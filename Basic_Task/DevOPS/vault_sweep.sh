#!/bin/bash

TARGET_DIR="$1"
LOG_DIR="./vault_logs"
LOG_FILE="$LOG_DIR/vault_sweep.log"

mkdir -p "$LOG_DIR"
chmod 700 "$LOG_DIR"

touch "$LOG_FILE"

timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

log_msg() {
    local type="$1"
    local msg="$2"

    echo "[$(timestamp)] [$type] $msg" >> "$LOG_FILE"
}

warn() {
    local file="$1"
    local reason="$2"

    echo "[WARN] $file _ Reason: $reason"
    log_msg "WARN" "$file $reason"
}

get_git_author() {

    local file="$1"

    if git -C "$TARGET_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then

        ath=$(git -C "$TARGET_DIR" blame -p "$file" 2>/dev/null | grep "^author " | head -1 | cut -d' ' -f2-)

        if [ -n "$ath" ]; then
            log_msg "INFO" "$file Author: $ath"
        fi
    fi
}


scan_shell_scripts() {

    find "$TARGET_DIR" -type f -name "*.sh" | while read -r file
    do

        if grep -Eq 'rm[[:space:]]+-rf[[:space:]]+/' "$file"; then
            warn "$file" "Contains rm -rf /"
            get_git_author "$file"
        fi

        if grep -Eq 'mkfs' "$file"; then
            warn "$file" "Contains mkfs"
            get_git_author "$file"
        fi

        if grep -Eq 'shutdown|reboot|poweroff' "$file"; then
            warn "$file" "Unauthorized shutdown/reboot"
            get_git_author "$file"
        fi

        if grep -Eq '/dev/tcp|nc .* -e|bash -i >&|0>&1' "$file"; then
            warn "$file" "Reverse shell pattern"
            get_git_author "$file"
        fi


        if grep -Eq 'curl.*\|.*(sh|bash)' "$file"; then
            warn "$file" "curl piped to shell"
            get_git_author "$file"
        fi

        if grep -Eq 'wget.*\|.*(sh|bash)' "$file"; then
            warn "$file" "wget piped to shell"
            get_git_author "$file"
        fi

        per=$(stat -c "%a" "$file")

        if [ "$per" = "777" ]; then 

            warn "$file" "World writable permission"

            read -p "Fix permission for $file ? [Y/n]: " action

            if [[ "$action" =~ ^[Yy]$ ]]; then

                chmod o-w "$file"

                log_msg "FIX" "$file removed world write permission"
            fi
        fi
    done
}

scan_hidden() {

    find "$TARGET_DIR" -name ".*" | while read -r file
    do

        if [ -f "$file" ]; then

            if grep -Eq '/dev/tcp|curl.*\|.*sh|wget.*\|.*bash' "$file" 2>/dev/null
            then
                warn "$file" "Suspicious hidden file"
            fi
        fi
    done
}


sanitize_env_files() {

find "$TARGET_DIR" -type f \( -name ".env*" \) | while read -r file
do

    ofile="${file}.sanitized"

    > "$ofile"

    valid=0
    invalid=0

    rej=""

    while IFS= read -r line || [ -n "$line" ]
    do

        [[ -z "$line" ]] && continue


        if echo "$line" | grep -qE '="[^ ]+"'; then
            invalid=$((invalid+1))
            rej="$rej [$line]"
            continue
        fi


        if echo "$line" | grep -q '^export '; then
            invalid=$((invalid+1))
            rej="$rej [$line]"
            continue
        fi



        if echo "$line" | grep -q '^PATH='; then
            invalid=$((invalid+1))
            rej="$rej [$line]"
            continue
        fi

        if echo "$line" | grep -Eq '^(PASSWORD|SECRET|TOKEN)='; then
            invalid=$((invalid+1))
            rej="$rej [$line]"
            continue
        fi

        if echo "$line" | grep -Eq '^[A-Z0-9_]+=[^ ]+$'
        then
            echo "$line" >> "$ofile"
            valid=$((valid+1))
        else
            invalid=$((invalid+1))
            rej="$rej [$line]"
        fi

    done < "$file"

    log_msg "INFO" "$file Valid: $valid, Invalid: $invalid"
    log_msg "SKIP" "$file Rejected:$rej"

done
}

scan_source_files() {

find "$TARGET_DIR" -type f \( -name "*.js" -o -name "*.py" \) | while read -r file
do

    grep -nE '["'\''][A-Za-z0-9_\-]{10,}["'\'']' "$file" |
    while read -r found
    do
        warn "$file:$found" "Hardcoded credential"
    done

done
}

scan_entropy_strings() {

find "$TARGET_DIR" -type f \( -name "*.js" -o -name "*.py" -o -name "*.sh" \) |
while read -r file
do

    grep -nE '[A-Za-z0-9+/]{40,}={0,2}' "$file" |
    while read -r found
    do
        warn "$file:$found" "Base64 or high entropy payload"
    done

done
}


scan_binaries() {

find "$TARGET_DIR" -type f -executable |
while read -r file
do

    if [[ "$file" != */bin/* ]]; then

        type=$(file "$file")

        if echo "$type" | grep -Eq 'ELF|executable'; then

            warn "$file" "Executable outside bin directory"

        fi
    fi
done
}


scan_shell_scripts
scan_hidden
sanitize_env_files
scan_source_files
scan_entropy_strings
scan_binaries
