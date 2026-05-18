#!/bin/bash

with_local() {
    local NAME="Avinash"
    echo "Inside function: $NAME"
}

without_local() {
    CITY="Mumbai"
    echo "Inside function: $CITY"
}

with_local
echo "Outside function (local): ${NAME:-not set}"

without_local
echo "Outside function (no local): $CITY"
