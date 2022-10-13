#!/bin/sh
#SBATCH --account=physics
#SBATCH --partition=ada
#BATCH --time=00:30:00
#SBATCH --nodes=1 --ntasks=20
#SBATCH --job-name="o2Init"

singularity exec --overlay overlayO2.img o2build.sif slurmcodes/o2init.sh
