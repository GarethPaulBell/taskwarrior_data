#!/bin/bash

# Define the source and destination directories
SOURCE_DIR=~/.task
DEST_DIR=~/taskwarrior_data

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy the Taskwarrior data
cp -r "$SOURCE_DIR"/* "$DEST_DIR"/

# Optionally, sync the data if you have a remote repository
git -C "$DEST_DIR" add .
if ! git -C "$DEST_DIR" diff --staged --quiet; then
    git -C "$DEST_DIR" commit -m "Automated backup $(date)"
    git -C "$DEST_DIR" push origin master
else
    echo "No changes to commit"
fi

