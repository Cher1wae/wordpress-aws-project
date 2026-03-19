#!/bin/bash

# Update system packages
echo "Updating system..."
sudo apt update -y

# Install Docker if not installed
if ! command -v docker &> /dev/null
then
    echo "Installing Docker..."
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker ubuntu
else
    echo "Docker already installed"
fi

# Install Docker Compose if not installed
if ! command -v docker-compose &> /dev/null
then
    echo "Installing Docker Compose..."
    sudo apt install -y docker-compose
else
    echo "Docker Compose already installed"
fi

# Create mount directory
echo "Creating mount point..."
sudo mkdir -p /mnt/mysql-data

# Mount EBS volume if not already mounted
if ! mount | grep "/mnt/mysql-data" > /dev/null
then
    echo "Mounting EBS volume..."
    sudo mount /dev/xvdf /mnt/mysql-data
else
    echo "EBS volume already mounted"
fi

# Set permissions
echo "Setting permissions..."
sudo chown -R ubuntu:ubuntu /mnt/mysql-data

echo "Provisioning complete!"
