#!/bin/bash
# Day 17 – Task 3a: Command-line arguments

if [ $# -eq 0 ]; then
    echo "Usage: ./greet.sh <name>"
        exit 1
    fi

        echo "Hello, $1!"
