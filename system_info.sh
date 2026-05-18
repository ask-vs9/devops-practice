#!/bin/bash

set -euo pipefail

print_header() {
    echo "=============================="
    echo " $1"
    echo "=============================="
}

host_info() {
    print_header "Hostname & OS Info"
    echo "Hostname : $(hostname)"
    echo "OS       : $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
    echo "Kernel   : $(uname -r)"
    echo ""
}

uptime_info() {
    print_header "Uptime"
    uptime -p
    echo ""
}

disk_info() {
    print_header "Top 5 Disk Usage"
    du -sh /* 2>/dev/null | sort -rh | head -5
    echo ""
}

memory_info() {
    print_header "Memory Usage"
    free -h
    echo ""
}

cpu_info() {
    print_header "Top 5 CPU Processes"
    ps aux --sort=-%cpu | awk 'NR==1 || NR<=6' | awk '{printf "%-10s %-6s %-6s %s\n", $1, $2, $3, $11}'
    echo ""
}

main() {
    echo ""
    echo "  System Info Report"
    echo "  Generated: $(date)"
    echo ""
    host_info
    uptime_info
    disk_info
    memory_info
    cpu_info
}

main
