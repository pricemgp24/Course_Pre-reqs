#!/bin/bash

# Set the directory and file names

read -p "Enter Directory: " dir_name
read -p "Enter File: " file_name

# Check if the directory exists
if [ -d "$dir_name" ]; then
  echo "Directory '$dir_name' exists."

# Check if the file exists in the directory
  if [ -f "$dir_name/$file_name" ]; then
    echo "File '$file_name' already exists in '$dir_name'."
    echo ""
  else
    # File does not exist, create it
    echo "File '$file_name' not found in '$dir_name'. Creating file..."
    touch "$dir_name/$file_name"
    echo "File '$file_name' created inside '$dir_name'."
    echo ""
  fi

# Directory does not exist, create it and the file
else
  echo "Directory '$dir_name' does not exist. Creating it now."
  mkdir "$dir_name"
  touch "$dir_name/$file_name"
  echo "Directory '$dir_name' and file '$file_name' created."
fi

