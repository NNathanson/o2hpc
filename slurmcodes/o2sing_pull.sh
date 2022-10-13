#!/bin/sh
#SBATCH --account=physics
#SBATCH --partition=ada
#BATCH --time=1:00:00
#SBATCH --nodes=1 --ntasks=20
#SBATCH --job-name="o2Pull"

singularity exec --overlay overlayO2.img o2build.sif bash slurmcodes/o2pull.sh  
