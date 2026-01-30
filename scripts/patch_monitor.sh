#!/bin/bash

# --- Project: PatchGuardian - Automated Vulnerability Mitigation ---
# Purpose: Automates system updates and monitors for required reboots.
# Skills: Package Management (APT), Security Compliance.

REPORT="/var/log/patch_report.log"
DATE=$(date +'%Y-%m-%d')

echo "--- Patching Session Started: $DATE ---" >> $REPORT

# Update package lists
sudo apt-get update -y >> $REPORT

# Upgrade only security patches (common in enterprise to avoid breaking apps)
# This example performs a general upgrade for portfolio purposes
sudo apt-get upgrade -y >> $REPORT

# Check if a reboot is required (Standard Linux flag)
if [ -f /var/run/reboot-required ]; then
    echo "ALERT: Security patches applied. System reboot required." >> $REPORT
    # In a real environment, you might schedule a reboot for 3 AM
    # echo "shutdown -r 03:00" | at now
else
    echo "System is up to date. No reboot needed." >> $REPORT
fi

echo "--- Patching Session Complete ---" >> $REPORT
