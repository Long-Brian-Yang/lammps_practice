#!/bin/bash
# run_simulations.sh
# Script to prepare and submit multiple LAMMPS simulations at different temperatures

# Ensure the script runs in the submission directory
cd "$PWD"

# Loop over temperatures from 1200K to 1400K in steps of 20K
for ((t=1200; t<=1400; t+=20))
do
    echo "Preparing simulation for ${t}K..."

    # Define unique input, log, and output filenames for each temperature
    input_file="Cu_${t}.in"

    # Copy the base input file to a new file for the current temperature
    cp Cu.in "${input_file}"

    # Replace the temperature variable in the input file
    sed -i "s/variable\s\+t\s\+equal\s\+[0-9]\+/variable        t equal ${t}/" "${input_file}"

    # Update the log file name in the input file
    sed -i "s/log\s\+.*/log log${t}.lammps/" "${input_file}"

    # Submit the job using the submission script
    bash submit_lammps.sh "${input_file}" "${t}"
done

echo "All simulations have been submitted."