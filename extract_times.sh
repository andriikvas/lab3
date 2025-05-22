#!/bin/bash

echo "Variant,Run,Real(s)" > results/results.csv

for file in results/*.txt; do
    variant=$(basename "$file" .txt)
    run=1
    grep "real" "$file" | while read -r line; do
        time_str=$(echo "$line" | awk '{print $2}')
        min=$(echo "$time_str" | cut -d'm' -f1)
        sec=$(echo "$time_str" | cut -d'm' -f2 | tr -d 's')
        total=$(echo "$min * 60 + $sec" | bc -l)
        printf "%s,%d,%.3f\n" "$variant" "$run" "$total" >> results/results.csv
        ((run++))
    done
done