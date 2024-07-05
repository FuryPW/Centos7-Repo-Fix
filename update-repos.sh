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

