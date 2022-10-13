#!/bin/sh
#SBATCH --account=physics
#SBATCH --partition=ada
#BATCH --time=24:00:00
#SBATCH --nodes=1 --ntasks=40
#SBATCH --job-name="o2Build"

singularity exec --overlay overlayO2.img o2build.sif bash slurmcodes/o2build.sh 
