#!/bin/bash
# Day 19 – Task 1: Log Rotation Script

set -euo pipefail

LOG_DIR="${1:-}"

# check if directory argument is provided
if [ -z "$LOG_DIR" ]; then
    echo "Usage: ./log_rotate.sh <log-directory>"
    exit 1
fi

# check if directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

echo "$(date): Starting log rotation for $LOG_DIR"

# compress .log files older than 7 days
COMPRESSED=$(find "$LOG_DIR" -name "*.log" -mtime +7 | wc -l)
find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \;
echo "$(date): Compressed $COMPRESSED file(s)"

# delete .gz files older than 30 days
DELETED=$(find "$LOG_DIR" -name "*.gz" -mtime +30 | wc -l)
find "$LOG_DIR" -name "*.gz" -mtime +30 -delete
echo "$(date): Deleted $DELETED old archive(s)"

echo "$(date): Log rotation complete."
