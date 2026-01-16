#!/bin/bash

# ============================================
# Server Performance Monitoring Script
# ============================================
# This script displays basic system statistics:
# - CPU usage
# - Memory usage
# - Disk usage
# - Top processes
# - OS and uptime information
# ============================================

echo "============================================"
echo "        SERVER PERFORMANCE STATS"
echo "============================================"
echo "Generated on: $(date)"
echo

# ---------------- CPU USAGE -----------------
# 'top' gives CPU stats, we extract idle CPU
# Used CPU = 100 - idle

CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
CPU_USED=$(awk "BEGIN {printf \"%.2f\", 100 - $CPU_IDLE}")

echo "CPU Usage:"
echo "Used: $CPU_USED%"
echo

# --------------- MEMORY USAGE ---------------
# free -m shows memory in MB

MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED/$MEM_TOTAL)*100}")

echo "Memory Usage:"
echo "Used: ${MEM_USED}MB / ${MEM_TOTAL}MB (${MEM_PERCENT}%)"
echo "Free: ${MEM_FREE}MB"
echo

# ---------------- DISK USAGE ----------------
# df -h shows disk usage in human-readable form
# We check the root filesystem (/)

DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')

echo "Disk Usage (Root /):"
echo "Used: $DISK_USED / $DISK_TOTAL ($DISK_PERCENT)"
echo "Free: $DISK_FREE"
echo

# -------- TOP PROCESSES BY CPU --------------
# ps lists processes
# --sort=-%cpu sorts by CPU usage (descending)

echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# -------- TOP PROCESSES BY MEMORY -----------

echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

# --------------- OS DETAILS ----------------

echo "Operating System:"
grep PRETTY_NAME /etc/os-release | cut -d= -f2
echo

# ----------- UPTIME & LOAD -----------------

echo "Uptime and Load Average:"
uptime
echo

# ------------- LOGGED IN USERS -------------

echo "Logged-in Users:"
who
echo
