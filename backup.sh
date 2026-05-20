#!/bin/bash
# Day 19 – Task 2: Server Backup Script

set -euo pipefail

SOURCE="${1:-}"
DEST="${2:-}"
DATE=$(date +%Y-%m-%d)
ARCHIVE="backup-$DATE.tar.gz"

# check arguments
if [ -z "$SOURCE" ] || [ -z "$DEST" ]; then
    echo "Usage: ./backup.sh <source-directory> <backup-destination>"
    exit 1
fi

# check source exists
if [ ! -d "$SOURCE" ]; then
    echo "Error: Source directory '$SOURCE' does not exist."
    exit 1
fi

# create destination if it doesn't exist
mkdir -p "$DEST"

echo "$(date): Starting backup of $SOURCE"

# create timestamped archive
tar -czf "$DEST/$ARCHIVE" "$SOURCE" 2>/dev/null

# verify archive was created
if [ -f "$DEST/$ARCHIVE" ]; then
    SIZE=$(du -sh "$DEST/$ARCHIVE" | cut -f1)
    echo "$(date): Backup created — $ARCHIVE ($SIZE)"
else
    echo "$(date): Error — backup failed."
    exit 1
fi

# delete backups older than 14 days
DELETED=$(find "$DEST" -name "backup-*.tar.gz" -mtime +14 | wc -l)
find "$DEST" -name "backup-*.tar.gz" -mtime +14 -delete
echo "$(date): Removed $DELETED old backup(s)"

echo "$(date): Backup complete."
