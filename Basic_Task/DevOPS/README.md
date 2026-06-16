# SPIDER DevOPS Basic Task

## Overview
> The script vault_sweep.sh is a bash script that scans repositories for dangerous scripts, insecure permissions, suspicious files, exposed credentials, and invalid environment configurations. It also sanitizes the .env files.

> The script watchdog.sh is a bash script which scans for the warning in the vault_sweep.log file, and it alerts the user by sending an email.

---

## Task Covers 

- Recursive shell script scanning
- Detects Dangerous command detection
- Detects Reverse shell detection
- Detects suspicious download detection
- Fixes world write permission
- Sanitizes Environment file
- Detects Hardcoded secret/token
- Detects High entropy / Base64 
- Detects Executables outside bin
- Finds the Author who committed dangerous lines
- Logging
- Email alerting

## Setup Instructions

### Install Mail Utils 

```
sudo apt update
sudo apt install mailutils
```
### Edit the Cron Job
Run:

`crontab -e`

Add:

`*/30 * * * * path/to/watchdog.sh`

### Edit the E-mail ID 

Please edit the email ID in the script `watchdog.sh`

---

## Patterns defined as dangerous

`rm[[:space:]]+-rf[[:space:]]+/`

This command might recursively and forcefully delete a root file/directory

`mkfs`

Formatting a filesystem can permanently erase stored data

`shutdown|reboot|poweroff`

Shutdown / reboot / power off commands might switch off the services 

`/dev/tcp|nc .* -e|bash -i >&|0>&1`

These patterns are commonly used to create reverse shells that provide attackers remote access to a system.

`curl.*\|.*(sh|bash)`

This pattern might install malware in the machine

## Rejection of Specific env lines

`^PATH=`

This might introduce security risks

`="[^ ]+"`

This greps the unnessary quotes. But doesn't affect where quotes are neccessary (i.e. "app key")

`^export`

Prevents exporting PATH

# Thank You
