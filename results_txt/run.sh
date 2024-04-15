#!/bin/bash

# Get the directory of the current script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
output_file="${script_dir}/total_output.txt"

# Remove the output file if it already exists
if [ -f "$output_file" ]; then
    rm "$output_file"
fi

# Loop to process files
for i in {1..20}; do
    echo "-- Output $i " >> "$output_file"    
    if [ -f "${script_dir}/output${i}.txt" ]; then
        cat "${script_dir}/output${i}.txt" >> "$output_file"
        echo "" >> "$output_file"
    else
        echo "Warning: File output${i}.txt not found." >> "$output_file"
    fi
done

echo "Concatenation complete. Results saved to $output_file"
