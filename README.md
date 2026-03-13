# Linux Server Administration & Role-Based Access Control (RBAC)

## Project Overview
This project is a capstone for the Cloud Engineering program at AltSchool Africa. It simulates a real-world scenario of configuring a newly deployed Linux server for a tech startup, CloudNova Technologies.

## The Objective
To automate the provisioning of user accounts, organize teams into specific Linux groups, enforce strict file permissions, and secure the server for remote access using SSH keys.

## Technologies Used
* **OS:** Ubuntu 24.04 (managed via Vagrant/UTM)
* **Scripting:** Bash (Infrastructure as Code)
* **Core Concepts:** User/Group Management, Directory Permissions (`chmod`/`chown`), SSH Security.

## Architecture Setup
The `setup.sh` script automates the following:
1. Creates three departments (Developers, DevOps, Auditors).
2. Provisions 5 user accounts with temporary passwords and forced password resets.
3. Creates isolated project directories with strict `770` permissions.
4. Creates a shared company folder with `664` permissions.
5. Generates RSA SSH keys for remote access and disables root password authentication.

## Deliverables & Proof of Execution

### 1. User & Group Creation
**Users Provisioned:**
![Users](Images/cat_etc_passwd.png)

**Groups Created:**
![Groups](Images/cat_etc_group.png)

### 2. Folder Permissions
![Permissions](Images/Folder_Permission.png)

### 3. Passwordless SSH Authentication
![SSH Key Login](Images/Deliverable_4_SSH_Key_Login.png)

### 4. Restricted Access Verification
![Restricted Access](Images/Deliverable_5_Restricted_Access.png)

### Bonus: DevOps Deployment Folder
![DevOps Folder](Images/Permission_stuck.png)