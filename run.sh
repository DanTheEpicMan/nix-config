#!/bin/bash

# Directory to search for .sh files
RUN_DIR="/home/dan/nix-config/scripts/"

# Find all .sh files in the specified directory and store them in an array
files=()
for file in "$RUN_DIR"*.sh; do
  if [[ -f "$file" ]]; then
    files+=("$file")
  fi
done

# If no .sh files are found, exit with a message
if [[ ${#files[@]} -eq 0 ]]; then
  echo "No .sh files found in $RUN_DIR. Check if files exist and have the .sh extension."
  ls -l "$RUN_DIR"
  exit 1
fi

# Display the numbered list of .sh files
echo ""
for i in "${!files[@]}"; do
  filename=$(basename "${files[$i]}")
  echo "$((i + 1)). $filename"
done
echo ""

# Prompt the user for input
read -p "> " choice

# Validate the user input
if [[ ! "$choice" =~ ^[0-9]+$ ]]; then
  echo "Invalid choice: Not a number."
  exit 1
elif [[ "$choice" -gt ${#files[@]} ]]; then
  echo "Invalid choice: Number too large."
  exit 1
elif [[ "$choice" -lt 1 ]]; then
  echo "Invalid choice: Number too small."
  exit 1
fi

# Execute the selected .sh file using bash
chosen_file="${files[$((choice - 1))]}"

echo "Running $chosen_file..."
bash "$chosen_file" || { echo "Error running $chosen_file. Check file contents."; exit 1; }  # Run with bash

exit 0