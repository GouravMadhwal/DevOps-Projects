#!/bin/bash

# --------------------------------------------------
# Log Archiving Tool
# --------------------------------------------------
# This script compresses a given log directory into
# a timestamped .tar.gz archive and stores it in a
# dedicated archive directory.
#
# Usage:
#   ./log-archive.sh <log-directory>
# --------------------------------------------------

# -------- Step 1: Read the log directory argument --------

LOG_DIR="$1"

# Check if the user provided a directory argument
if [ -z "$LOG_DIR" ]; then  # -z means if $1 (first argument) is empty?
    echo "Usage: $0 <log-directory>"
    exit 1
fi

# Check if the provided directory exists
if [ ! -d "$LOG_DIR" ]; then # -d means if "$1" is a directory.
    echo "Error: Directory '$LOG_DIR' does not exist"
    exit 1
fi

# -------- Step 2: Create archive directory --------

# Directory where compressed logs will be stored
ARCHIVE_DIR="./logs_archive"

# Create the directory if it does not already exist
mkdir -p "$ARCHIVE_DIR" # -p make sures to not throw any error if the directory already exists

# -------- Step 3: Generate archive name --------

# Generate timestamp in YYYYMMDD_HHMMSS format
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create the archive filename
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

# -------- Step 4: Compress the logs --------

# -c : create a new archive
# -z : compress using gzip
# -f : specify the archive filename
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" "$LOG_DIR"

# -------- Step 5: Verify archive creation --------

# $? contains the exit status of the previous command
# 0 means success, any other value means failure
if [ $? -eq 0 ]; then # -eq means equal to and -ne means not equals
    # Log the successful archive operation
    echo "$(date): Archived $LOG_DIR into $ARCHIVE_NAME" >> archive.log

    echo "Logs archived successfully:"
    echo "$ARCHIVE_DIR/$ARCHIVE_NAME"
else
    echo "Error: Failed to create log archive"
    exit 1
fi
