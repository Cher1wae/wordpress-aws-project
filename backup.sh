#!/bin/bash

# Load environment variables
source .env

# Timestamp for unique backup filename
TIMESTAMP=$(date +"%Y-%m-%d-%H%M")

# Backup file name
BACKUP_FILE="backup-$TIMESTAMP.sql"

echo "Creating MySQL backup..."

# Run mysqldump inside the MySQL container
docker exec mysql mysqldump -u root -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE > $BACKUP_FILE

echo "Uploading backup to S3..."

# Upload to S3
aws s3 cp $BACKUP_FILE s3://wordpress-backup-cherish-2026/

echo "Backup completed successfully!"
echo "File uploaded to: s3://wordpress-backup-cherish-2026/$BACKUP_FILE"
