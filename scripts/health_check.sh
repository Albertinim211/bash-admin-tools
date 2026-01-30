#!/bin/bash

# --- Project: System Vitals - Infrastructure Health Monitor ---
# Purpose: Proactive monitoring of CPU, Memory, and Disk health.
# Skills: Process Management, Troubleshooting, Resource Allocation.

echo "--- Generating System Health Report ---"
DATE=$(date +'%Y-%m-%d %H:%M:%S')
echo "Report Time: $DATE"

# 1. Check CPU Usage
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $CPU_LOAD%"

# 2. Check Memory Usage
MEM_FREE=$(free -m | awk '/Mem:/ { print $4 }')
echo "Available Memory: ${MEM_FREE}MB"

# 3. Check Disk Usage (Root Partition)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
echo "Disk Usage (Root): $DISK_USAGE"

# 4. Check if a Critical Service is Running (e.g., SSH)
SERVICE="ssh"
if systemctl is-active --quiet $SERVICE; then
    echo "Service Status ($SERVICE): ACTIVE"
else
    echo "Service Status ($SERVICE): DOWN - Attention Required!"
    # Optional: sudo systemctl start $SERVICE
fi

# 5. Alerting Logic
if (( $(echo "$CPU_LOAD > 90.0" | bc -l) )); then
    echo "WARNING: High CPU usage detected!"
fi

echo "--- Health Check Complete ---"
