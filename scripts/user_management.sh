#!/bin/bash

# --- Project: Project Gatekeeper - Identity & Access Automator ---
# Purpose: Streamlines user onboarding/offboarding with a security-first approach.
# Skills: User Management, Access Control, Linux Admin, IT Support.

# Ensure the script runs with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root."
   exit 1
fi

echo "--- User Management System Initialized ---"

# 1. Define User Details
USERNAME="new_employee"
USER_GROUP="it_staff"
COMMENT="Remote Support Team"

# 2. Create Group if it doesn't exist (Infrastructure Readiness)
if ! getent group $USER_GROUP > /dev/null; then
    echo "Creating group: $USER_GROUP..."
    groupadd $USER_GROUP
fi

# 3. Create User with Home Directory and Shell (Standardization)
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists. Skipping creation."
else
    echo "Creating user: $USERNAME..."
    useradd -m -c "$COMMENT" -g $USER_GROUP -s /bin/bash $USERNAME
    
    # Set an initial expired password (Force user to change it at first login)
    echo "$USERNAME:TemporaryPassword123!" | chpasswd
    chage -d 0 $USERNAME
    echo "User created. Password change forced on first login."
fi

# 4. Enforce Directory Permissions (Least Privilege)
# Setting up a secure workspace for the user
mkdir -p /home/$USERNAME/secure_vault
chown $USERNAME:$USER_GROUP /home/$USERNAME/secure_vault
chmod 700 /home/$USERNAME/secure_vault

echo "Access Control: Secure directory created with restricted permissions (700)."
echo "--- Process Complete: User $USERNAME is ready for onboarding ---"
