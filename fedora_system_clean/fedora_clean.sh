#!/bin/bash

# Script to clean up Fedora system and autoremove packages

# Function to run commands with sudo

    echo "Please enter your sudo password if prompted."
    sudo -k # Invalidate any existing sudo timestamp
    sudo true


echo "Starting system cleanup..."

# Update package information
echo "Updating package information..."
dnf makecache

# Clean up the package cache
echo "Cleaning up package cache..."
 dnf clean all

# Remove unused dependencies
echo "Removing unused dependencies..."
sudo dnf autoremove -y

# Optionally, remove old kernels (keep the latest 2)
echo "Removing old kernels..."
sudo dnf remove $(dnf repoquery --installonly --latest-limit=-2 -q)

# Optional: Remove orphaned packages (requires installation of 'dnf-plugins-core')
echo "Removing orphaned packages..."
if command -v package-cleanup &> /dev/null; then
 sudo   dnf remove $(package-cleanup --quiet --orphans)
else
    echo "'package-cleanup' is not installed. Skipping orphaned packages removal."
fi

echo "System cleanup completed."

