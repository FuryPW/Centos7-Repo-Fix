# Update CentOS Repository Configuration Script

This script updates the CentOS repository configuration to use the CentOS Vault repositories. This change is necessary because CentOS 7 has reached its End of Life (EOL), and the standard repositories are no longer maintained.

## Purpose

The primary purpose of this script is to:
1. Backup the existing repository configuration.
2. Update the repository URLs to point to the CentOS Vault, ensuring continued access to packages for CentOS 7.

## Prerequisites

- Ensure you have root privileges or use `sudo` to execute the script.
- The system should be running CentOS 7.

## Script Details

```bash
#!/bin/bash

# Backup the existing repository configuration
echo "Backing up existing repository configuration..."
sudo cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# Create the new CentOS-Base.repo file with the Vault repository URLs
echo "Updating the repository configuration to use CentOS Vault repositories..."
sudo tee /etc/yum.repos.d/CentOS-Base.repo > /dev/null <<EOL

[base]
name=CentOS-7 - Base
baseurl=http://vault.centos.org/7.9.2009/os/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-7 - Updates
baseurl=http://vault.centos.org/7.9.2009/updates/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[extras]
name=CentOS-7 - Extras
baseurl=http://vault.centos.org/7.9.2009/extras/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[centosplus]
name=CentOS-7 - Plus
baseurl=http://vault.centos.org/7.9.2009/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOL

# Clean YUM cache and update the system
echo "Cleaning YUM cache and updating the system..."
sudo yum clean all
sudo yum makecache
sudo yum update

echo "Repository configuration updated successfully."
echo "Created by Shiank98 for suportegm <3"

```

## Steps Performed by the Script

1. **Backup Existing Repository Configuration**
   - The script begins by backing up the current repository configuration file located at `/etc/yum.repos.d/CentOS-Base.repo` to `/etc/yum.repos.d/CentOS-Base.repo.bak`.

2. **Update Repository Configuration**
   - The script then updates the repository configuration file to use the CentOS Vault repositories. This ensures that the system can still access necessary packages despite the EOL status of CentOS 7.

3. **Clean YUM Cache and Update System**
   - Finally, the script cleans the YUM cache and rebuilds it, followed by updating the system to apply the new repository configurations.

## Usage

To use this script, save it to a file (e.g., `update_repos.sh`), make it executable, and run it:

```bash
chmod +x update_repos.sh
sudo ./update_repos.sh
```
### Notes

 - This script is specifically designed for CentOS 7 systems that need to switch to the CentOS Vault repositories due to the EOL status.
 - Ensure you review the script and understand its actions before executing it in a production environment.
