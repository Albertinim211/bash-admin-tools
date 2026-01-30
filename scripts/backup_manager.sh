#!/bin/bash

# --- Project: Sentinel Backup - Automated Data Integrity ---
# Purpose: Incremental backups of critical system configurations.
# Skills: Rsync, Storage Management, Disaster Recovery.

SOURCE="/etc /home/admin/important_docs"
DESTINATION="/var/backups/inventory_backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
LOG_FILE="/var/log/backup_history.log"

# Create destination if it doesn't exist
mkdir -p $DESTINATION

echo "[$DATE] Starting backup of: $SOURCE" >> $LOG_FILE

# Perform incremental backup using rsync
# -a: archive mode, -v: verbose, -z: compress
rsync -avz --delete $SOURCE $DESTINATION/backup_$DATE >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "[$DATE] Backup Successful." >> $LOG_FILE
else
    echo "[$DATE] Backup FAILED. Check network/disk space." >> $LOG_FILE
fi

# Cleanup: Remove backups older than 30 days to save disk space
find $DESTINATION -type d -mtime +30 -exec rm -rf {} +
echo "[$DATE] Maintenance: Old backups purged." >> $LOG_FILE
