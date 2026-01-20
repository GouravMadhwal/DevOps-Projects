#!/bin/bash
# ^ Tells the system to run this script using the Bash shell

# ==================================================
# Server Performance Monitoring Script
# ==================================================
# This script collects and displays basic server stats:
# 1. CPU usage
# 2. Memory usage
# 3. Disk usage (root filesystem)
# 4. Top processes by CPU and memory
# 5. OS details
# 6. System uptime and logged-in users
# ==================================================

# Print a visual header
echo "============================================"
echo "        SERVER PERFORMANCE STATS"
echo "============================================"

# Print current date and time
# $(date) executes the `date` command and substitutes its output
echo "Generated on: $(date)"
echo

# ---------------- CPU USAGE -----------------
# `top` shows real-time system statistics
# -b  : batch mode (non-interactive, script-friendly)
# -n1 : run only one iteration
#
# We grep the line containing "Cpu(s)"
# awk '{print $8}' extracts the 8th column which is idle CPU percentage

CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')

# CPU used = 100 - idle
# awk is used here for floating-point math
# printf formats output to 2 decimal places

CPU_USED=$(awk "BEGIN {printf \"%.2f\", 100 - $CPU_IDLE}")

echo "CPU Usage:"
echo "Used: $CPU_USED%"
echo

# --------------- MEMORY USAGE ---------------
# `free -m` shows memory usage in megabytes
#
# Output format:
# Mem: total used free shared buff/cache available

# Extract total memory (2nd column)
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')

# Extract used memory (3rd column)
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')

# Extract free memory (4th column)
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')

# Calculate memory usage percentage
# (used / total) * 100
MEM_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED/$MEM_TOTAL)*100}")

echo "Memory Usage:"
echo "Used: ${MEM_USED}MB / ${MEM_TOTAL}MB (${MEM_PERCENT}%)"
echo "Free: ${MEM_FREE}MB"
echo

# ---------------- DISK USAGE ----------------
# `df -h` shows disk usage in human-readable format
# We only care about the root filesystem (/)
#
# NR==2 ensures we read the second line (actual data, not header)

DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')

echo "Disk Usage (Root /):"
echo "Used: $DISK_USED / $DISK_TOTAL ($DISK_PERCENT)"
echo "Free: $DISK_FREE"
echo

# -------- TOP PROCESSES BY CPU --------------
# `ps` lists running processes
# -e  : show all processes
# -o  : define output format
# pid : process ID
# comm: command name
# %cpu: CPU usage
#
# --sort=-%cpu sorts by CPU usage in descending order
# head -n 6 shows header + top 5 processes

echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# -------- TOP PROCESSES BY MEMORY -----------
# Same logic as CPU section
# %mem shows memory usage percentage

echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

# --------------- OS DETAILS ----------------
# /etc/os-release contains OS metadata
# PRETTY_NAME gives a readable OS name
# cut splits by '=' and prints the second field

echo "Operating System:"
grep PRETTY_NAME /etc/os-release | cut -d= -f2
echo

# ----------- UPTIME & LOAD -----------------
# `uptime` shows:
# - how long the system has been running
# - number of logged-in users
# - load average (1, 5, 15 minutes)

echo "Uptime and Load Average:"
uptime
echo

# ------------- LOGGED IN USERS -------------
# `who` lists currently logged-in users

echo "Logged-in Users:"
who
echo
