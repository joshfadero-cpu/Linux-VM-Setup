#!/bin/bash

#STEP 1: Create Company Departments (Groups)
echo "Creating groups..."
groupadd developers
groupadd devops
groupadd auditors

#STEP 2: Create Users and Assign to Groups
echo "Creating users and assigning to groups..."

# Developers
useradd -m -g developers -s /bin/bash daniel
useradd -m -g developers -s /bin/bash aisha

# DevOps
useradd -m -g devops -s /bin/bash michael
useradd -m -g devops -s /bin/bash grace

#Auditors
useradd -m -g auditors -s /bin/bash victor

echo "Users and groups created successfully."

# STEP 3 & 4: Create Project Directories and Set Permissions
echo "Creating project directories and setting permissions..."
mkdir -p /projects/development
mkdir -p /projects/devops
mkdir -p /projects/audit

# Change Group Ownership (root is the owner, the department is the group)
chown root:developers /projects/development
chown root:devops /projects/devops
chown root:auditors /projects/audit

# Change Permissions (770 = Owner gets full access, Group gets full access, Others get ZERO access)
chmod 770 /projects/development
chmod 770 /projects/devops
chmod 770 /projects/audit

# STEP 5: Create Shared Company File
echo "Creating shared company file..."
mkdir -p /company_shared
touch /company_shared/announcements.txt

# Give DevOps ownership of the file
chown root:devops /company_shared/announcements.txt

# Change Permissions (664 = Owner reads/writes, Group reads/writes, Others ONLY read)
chmod 664 /company_shared/announcements.txt

echo "Folders and permissions configured successfully!"

# STEP 6: Configure SSH Access
echo "Configuring SSH access for daniel and michael..."

# 1. Generate keys for Daniel
# We create his .ssh folder, generate the key, and add it to authorized_keys
mkdir -p /home/daniel/.ssh
ssh-keygen -t rsa -b 4096 -f /home/daniel/.ssh/id_rsa -N ""
cat /home/daniel/.ssh/id_rsa.pub >> /home/daniel/.ssh/authorized_keys

# We must fix the ownership and permissions so Daniel actually owns his keys
chown -R daniel:developers /home/daniel/.ssh
chmod 700 /home/daniel/.ssh
chmod 600 /home/daniel/.ssh/authorized_keys

# 2. Generate keys for Michael
mkdir -p /home/michael/.ssh
ssh-keygen -t rsa -b 4096 -f /home/michael/.ssh/id_rsa -N ""
cat /home/michael/.ssh/id_rsa.pub >> /home/michael/.ssh/authorized_keys

chown -R michael:devops /home/michael/.ssh
chmod 700 /home/michael/.ssh
chmod 600 /home/michael/.ssh/authorized_keys

# 3. Secure the SSH Server (Disable Root Login & Password Authentication)
# The 'sed' command automatically searches for text in a file and replaces it
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# 4. Restart the SSH service to apply the new security rules
systemctl restart ssh

echo "SSH configuration complete!"

# BONUS: DevOps Deployment Folder
echo "Configuring DevOps deployment folder..."
mkdir -p /deployments

# Assign ownership to the devops group
chown root:devops /deployments

# Set permissions: root (7), devops (7), others (0)
chmod 770 /deployments

echo "Bonus step completed successfully! System is fully secured."