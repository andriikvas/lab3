#!/bin/bash

SOURCE="geometric_mean.c"
OPT_LEVELS=("-O0" "-O1" "-O2" "-O3")

mkdir -p results

for opt in "${OPT_LEVELS[@]}"; do
    echo "Compiling with $opt..."
    exe="geo_${opt//-/}"

    icc -std=c99 $opt $SOURCE -o $exe

    echo "Running $exe..." | tee results/${exe}.txt

    { time for i in {1..5}; do ./$exe > /dev/null; done ; } 2>> results/${exe}.txt
done