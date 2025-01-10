#!/bin/sh
# TSUBAME4 job submission script for LAMMPS

#$ -cwd                             # Execute job in the current directory
#$ -l cpu_16=1                      # Request 1 node with 16 CPU cores
#$ -l h_rt=02:00:00                 # Maximum runtime of 2 hours
#$ -N lammps_job                    # Job name
#$ -o log.lammps                    # Standard output log
#$ -e log.lammps.err                # Error output log

# Load required modules
module purge
module load intel/2024.0.2
module load openmpi/4.1.1
module load lammps/2aug2023_u3

# Log job start
echo "Job started on $(hostname) at $(date)"

# Run LAMMPS with 8 MPI processes
mpirun -np 8 lmp_mpi -in Cu.in

# Log job completion
echo "Job finished on $(hostname) at $(date)"