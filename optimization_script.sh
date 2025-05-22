#!/bin/bash

SOURCE="geometric_mean.c"
OPT_LEVELS=("-O0" "-O1" "-O2" "-O3")
mkdir -p results

echo "Компіляція з різними рівнями оптимізації..."

for opt in "${OPT_LEVELS[@]}"; do
    exe="geo_${opt//-}"  # Наприклад: -O1 → geo_O1

    echo ""
    echo "Компіляція $opt..."
    icc -std=c99 $opt $SOURCE -o $exe

    echo "Запуск Оптимізація $opt..." | tee results/${exe}.txt

    for i in 1 2 3; do
        echo "Запуск $i з 3" | tee -a results/${exe}.txt
        { time ./$exe > /dev/null; } 2>> results/${exe}.txt
    done
done