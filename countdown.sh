#!/bin/bash
# Day 17 – Task 2: While Loop countdown

read -p "Enter a number to count down from: " NUM

while [ $NUM -ge 0 ]; do
    echo "$NUM"
        NUM=$((NUM - 1))
        done

        echo "Done!"
