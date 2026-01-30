🛠️ Bash Admin Toolkit: Enterprise Infrastructure & Security
Automated Linux System Administration, Security Hardening, and Disaster Recovery Suite.

📌 Project Overview
In a modern enterprise environment, manual server management is a bottleneck and a security risk. This toolkit is a collection of production-ready Bash scripts designed to automate the 7-step troubleshooting methodology and ensure the high availability and security of Linux-based infrastructure.

This project demonstrates proficiency in:

Security & Compliance: Hardening systems and vulnerability patching.

Operations & Automation: Scheduling maintenance and monitoring resources.

Identity & Access Management (IAM): Standardizing user onboarding.

Disaster Recovery: Implementing automated data redundancy.

| Script Name | Functional Domain | Technical Key Features |
| :--- | :--- | :--- |
| `harden.sh` | **Security** | Firewall (UFW) config, service reduction, UID 0 auditing. |
| `user_manager.sh` | **IAM** | Automated user creation, group logic, and forced password reset. |
| `health_check.sh` | **Monitoring** | CPU/RAM threshold alerts and `systemd` service verification. |
| `backup_manager.sh`| **Data Integrity** | Incremental `rsync` backups with a 30-day retention policy. |
| `patch_monitor.sh` | **Compliance** | Automated `apt` lifecycle management and reboot detection. |

🛠️ Detailed Script Functionality
1. System Hardening (harden.sh)
Following the Principle of Least Privilege, this script locks down the server by:

Configuring a "Deny-by-Default" firewall policy.

Scanning for unauthorized root-level accounts.

Disabling common attack vectors like cups and avahi-daemon.

2. Identity & Access Automator (user_manager.sh)
Streamlines IT Support desk operations by:

Standardizing account creation and home directory permissions (chmod 700).

Implementing Security+ standards by forcing users to change temporary passwords upon first login.

3. Infrastructure Health Monitor (health_check.sh)
Ensures SLA (Service Level Agreement) compliance by:

Logging system vitals (CPU, Memory, Disk).

Proactively checking if critical services (SSH, Web Servers) are active.

4. Sentinel Backup Manager (backup_manager.sh)
Ensures Business Continuity through:

Incremental backups using rsync to save bandwidth and storage.

Automated cleanup of archives older than 30 days to prevent disk exhaustion.

5. PatchGuardian Monitor (patch_monitor.sh)
Handles Vulnerability Management by:

Automating security updates.

Checking the /var/run/reboot-required flag to alert admins of necessary maintenance windows.

⚙️ Usage & Deployment GuideManual SetupBash# 

# 1. Clone the repository
git clone https://github.com/yourusername/bash-admin-toolkit.git

# 2. Enter the directory and set permissions
cd bash-admin-toolkit/scripts
chmod +x *.sh

# 3. Execute with administrative privileges
sudo ./harden.sh

Automated Scheduling (SOP)To ensure 24/7 reliability, these scripts should be scheduled using Crontab (crontab -e).

| Task | Frequency | Cron Expression |
| :--- | :--- | :--- |
| Health Checks | Every Hour | `0 * * * * /path/to/health_check.sh` |
| System Backups | Daily @ Midnight | `0 0 * * * /path/to/backup_manager.sh` |
| Security Patching| Weekly @ 3 AM | `0 3 * * 0 /path/to/patch_monitor.sh` |

