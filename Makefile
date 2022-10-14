work := /scratch/$(stdno)/o2hpc
slurm := $(work)/slurmcodes

blank:
	echo "No function specified"

overlay:
	cd $(work) && \
	dd if=/dev/zero of=overlayO2.img bs=1G count=70 && \
	mkfs.ext3 -f overlayO2.img && \
	chmod 777 overlayO2.img

init: $(work)/overlayO2.img $(work)/o2build.sif $(work)/slurmcodes/o2init.sh $(work)/slurmcodes/o2sing_init.sh
	cd $(work) && \
	mkdir alice && \
	sbatch $(slurm)/o2sing_init.sh

build: $(work)/overlayO2.img $(work)/o2build.sif $(work)/alice $(work)/slurmcodes/o2build.sh $(work)/slurmcodes/o2sing_build.sh
	cd $(work) && \
	sbatch $(slurm)/o2sing_build.sh 

pull: $(work)/overlayO2.img $(work)/o2build.sif $(work)/alice $(work)/slurmcodes/o2pull.sh $(work)/slurmcodes/o2sing_pull.sh
	cd $(work) && \
        sbatch $(slurm)/o2sing_pull.sh
