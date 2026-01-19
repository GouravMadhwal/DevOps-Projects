# Log Archive Tool (Bash)

A simple command-line tool written in Bash to compress and archive system logs on a scheduled or on-demand basis.
This script helps keep systems clean by archiving log directories into timestamped `.tar.gz` files while maintaining a record of all archive operations.

---

## Why This Project Exists

Log files grow.
Left unattended, they consume disk space, slow systems down, and eventually cause outages.

This project demonstrates how to:

* Work with files and directories in Linux
* Accept command-line arguments
* Compress data using standard Unix tools
* Build a simple but practical CLI utility
* Handle errors and log operational events

---

## Features

* Accepts a log directory as a command-line argument
* Compresses logs into a `.tar.gz` archive
* Uses timestamped filenames to avoid overwriting archives
* Stores archives in a dedicated directory
* Logs archive activity with date and time
* Performs basic validation and error handling

---

## Requirements

* Linux-based operating system
* Bash shell
* Standard Unix utilities:

  * `tar`
  * `date`
  * `mkdir`

No external dependencies are required.

---

## Usage

Make the script executable:

```bash
chmod +x log-archive.sh
```

Run the script by providing the log directory:

```bash
./log-archive.sh <log-directory>
```

### Example

```bash
./log-archive.sh /var/log
```

If permission is required (common for system logs):

```bash
sudo ./log-archive.sh /var/log
```

---

## Output

* Archived logs are stored in the `logs_archive/` directory
* Archive filenames follow this format:

```text
logs_archive_YYYYMMDD_HHMMSS.tar.gz
```

Example:

```text
logs_archive_20240816_100648.tar.gz
```

* Archive activity is logged in `archive.log`:

```text
Sun Jan 19 21:30:05 IST 2026: Archived /var/log into logs_archive_20260119_213005.tar.gz
```
---

## Notes

* The script validates input and directory existence before execution
* Archive creation is verified using exit status checks
* Absolute paths in archives are safely handled by `tar`
* Intended for learning and lightweight automation use cases

---

## License

MIT License

---
