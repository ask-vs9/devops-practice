#!/bin/bash

greet() {
    echo "Hello, $1!"
}

add() {
    SUM=$(( $1 + $2 ))
    echo "Sum of $1 + $2 = $SUM"
}

greet "Avinash"
add 10 20
