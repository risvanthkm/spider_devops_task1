#!/bin/bash

TARGET_DIR="./repo"
mailid="risvanth129@gmail.com"

output=$(sudo bash ./vault_sweep.sh "$TARGET_DIR")

if echo "$output" | grep -q "\[WARN\]"; then

    msg="Security alert: dangerous files detected in $TARGET_DIR"
    echo "$msg"
    echo "$msg" | mail -s "Vault Sweep Alert" $mailid

fi
