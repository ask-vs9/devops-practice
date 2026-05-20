#!/bin/bash
set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: ./log_analyzer.sh <path-to-log-file>"
    exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi

DATE=$(date +%Y-%m-%d)
REPORT="log_report_$DATE.txt"
TOTAL_LINES=$(wc -l < "$LOG_FILE")

echo "Analyzing: $LOG_FILE"
echo ""

# error count
ERROR_COUNT=$(grep -cE "ERROR|Failed" "$LOG_FILE" || true)
echo "Total errors found: $ERROR_COUNT"

# critical events
echo ""
echo "--- Critical Events ---"
grep -n "CRITICAL" "$LOG_FILE" | while read -r line; do
    LINENUM=$(echo "$line" | cut -d: -f1)
    CONTENT=$(echo "$line" | cut -d: -f2-)
    echo "Line $LINENUM:$CONTENT"
done

# top 5 error messages
echo ""
echo "--- Top 5 Error Messages ---"
grep "ERROR" "$LOG_FILE" \
    | awk '{for(i=4;i<=NF;i++) printf $i" "; print ""}' \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -5

# generate report
{
    echo "====================================="
    echo "       Daily Log Analysis Report"
    echo "====================================="
    echo "Date of Analysis : $DATE"
    echo "Log File         : $LOG_FILE"
    echo "Total Lines      : $TOTAL_LINES"
    echo "Total Errors     : $ERROR_COUNT"
    echo ""
    echo "--- Top 5 Error Messages ---"
    grep "ERROR" "$LOG_FILE" \
        | awk '{for(i=4;i<=NF;i++) printf $i" "; print ""}' \
        | sort \
        | uniq -c \
        | sort -rn \
        | head -5
    echo ""
    echo "--- Critical Events ---"
    grep -n "CRITICAL" "$LOG_FILE" | while read -r line; do
        LINENUM=$(echo "$line" | cut -d: -f1)
        CONTENT=$(echo "$line" | cut -d: -f2-)
        echo "Line $LINENUM:$CONTENT"
    done
    echo ""
    echo "====================================="
    echo "Report generated on: $(date)"
    echo "====================================="
} > "$REPORT"

echo ""
echo "Report saved: $REPORT"

# archive
mkdir -p archive
mv "$LOG_FILE" archive/
echo "Log archived to: archive/$(basename "$LOG_FILE")"
