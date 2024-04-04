#!/bin/bash

output_file="total_output.txt"

if [ -f "$output_file" ]; then
    rm "$output_file"
fi

for i in {1..20}; do
    echo "-- Output $i " >> "$output_file"    
    if [ -f "output${i}.txt" ]; then
        cat "output${i}.txt" >> "$output_file"
        echo \ >> "$output_file"
    else
        echo "Warning: File output${i}.txt not found."
    fi
done

echo "Concatenation complete. Results saved to $output_file"
