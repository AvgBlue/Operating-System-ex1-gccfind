#!/bin/bash

# Function to check line endings in a file
check_line_endings() {
    local file="$1"
    local line_ending_unix=$'\n'
    local line_ending_windows=$'\r\n'

    # Read the first line of the file
    local first_line
    read -r first_line < "$file"

    # Compare the line endings
    if [[ "$first_line" == *"$line_ending_windows"* ]]; then
        echo "File '$file' has DOS/Windows line endings."
    else
        echo "File '$file' has Unix line endings."
    fi
}

# Check if file path is provided as an argument
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <file>"
    exit 1
fi

file="$1"

# Check if file exists and is readable
if [[ ! -f "$file" || ! -r "$file" ]]; then
    echo "File '$file' does not exist or is not readable."
    exit 1
fi

# Call the function to check line endings
check_line_endings "$file"
