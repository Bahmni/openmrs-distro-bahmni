#!/bin/bash

dir_path="/openmrs/data/fhirExports"
log_file="/openmrs/data/purge.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_file"
    echo "$1"
}

if [ ! -d "$dir_path" ]; then
    log_message "Error: Directory $dir_path not found."
    exit 1
fi

find "$dir_path" -type f -mmin +1 -delete
