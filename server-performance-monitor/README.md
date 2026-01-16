# Server Performance Stats Script

A lightweight Bash script to analyze basic Linux server performance metrics.
Designed to run on any standard Linux distribution using built-in system utilities only.

---

## Features

The script reports the following system statistics:

* **Total CPU usage**
* **Memory usage**

  * Used vs Free
  * Usage percentage
* **Disk usage (root filesystem `/`)**

  * Used vs Free
  * Usage percentage
* **Top 5 processes by CPU usage**
* **Top 5 processes by memory usage**

### Additional System Information

* OS version
* System uptime and load average
* Currently logged-in users
* (Optional) Recent failed login attempts if logs are accessible

---

## Requirements

* Linux-based operating system
* Bash shell
* Standard Linux utilities:

  * `top`
  * `ps`
  * `free`
  * `df`
  * `awk`
  * `grep`
  * `uptime`
  * `who`

These tools are available by default on most Linux distributions.

---

## Installation

Clone the repository:

```bash
git clone https://github.com/your-username/server-stats.git
cd server-stats
```

Make the script executable:

```bash
chmod +x server-stats.sh
```

---

## Usage

Run the script directly:

```bash
./server-stats.sh
```

The script outputs a formatted summary of current server performance metrics to the terminal.

---

## Sample Output

```text
===== SERVER PERFORMANCE STATS =====
Generated on: Mon Jan 15 21:30:00 IST 2026

CPU Usage:
Used: 12.4%

Memory Usage:
Used: 2048MB / 8192MB (25.00%)
Free: 4096MB

Disk Usage (/):
Used: 15G / 40G (38%)
Free: 25G

Top 5 Processes by CPU:
PID   COMMAND     %CPU
...

Top 5 Processes by Memory:
PID   COMMAND     %MEM
...

OS Version:
"Ubuntu 22.04.3 LTS"

Uptime & Load:
21:30:00 up 10 days, load average: 0.23, 0.30, 0.28

Logged-in Users:
user pts/0
```

---

## Notes

* Disk usage is calculated for the root filesystem (`/`)
* Memory values are reported in megabytes
* Failed login attempts require access to authentication logs and may need elevated permissions
* CPU usage is calculated using idle time from `top`

---

## Use Cases

* Quick health check on a Linux server
* Learning Linux performance monitoring fundamentals
* Lightweight alternative to full monitoring stacks

---

https://roadmap.sh/projects/server-stats

## License

MIT License

---
