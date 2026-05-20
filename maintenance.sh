#!/bin/bash
# Day 19 – Task 4: Scheduled Maintenance Script

set -euo pipefail

LOGFILE="/var/log/maintenance.log"
LOG_DIR="/var/log/myapp"
BACKUP_SRC="/opt/myapp"
BACKUP_DEST="/backups"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" | tee -a "$LOGFILE"
}

run_log_rotation() {
    log "Starting log rotation..."
    bash /opt/scripts/log_rotate.sh "$LOG_DIR" >> "$LOGFILE" 2>&1
    log "Log rotation done."
}

run_backup() {
    log "Starting backup..."
    bash /opt/scripts/backup.sh "$BACKUP_SRC" "$BACKUP_DEST" >> "$LOGFILE" 2>&1
    log "Backup done."
}

main() {
    log "====== Maintenance started ======"
    run_log_rotation
    run_backup
    log "====== Maintenance complete ======"
}

main
