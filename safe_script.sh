#!/bin/bash
# Day 17 – Task 5a: Error handling with set -e and ||

set -e  # exit immediately if any command fails

echo "Creating directory /tmp/devops-test..."
mkdir /tmp/devops-test || echo "Directory already exists -- continuing."

echo "Navigating into /tmp/devops-test..."
cd /tmp/devops-test || { echo "Failed to enter directory."; exit 1; }

echo "Creating file inside directory..."
touch devops-file.txt || { echo "Failed to create file."; exit 1; }

echo "All steps completed successfully."
ls -l /tmp/devops-test/
