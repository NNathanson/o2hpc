# O2 on the HPC
##### _Required files and instructions for installing the ALICE experimental framework, O2, on UCT's high performance computing cluster._

### Setup
To log on to the HPC:
 - You must have an HPC account: [https://ucthpc.uct.ac.za/index.php/account/](https://ucthpc.uct.ac.za/index.php/account/)
 - You need to be connected to UCT via VPN: [www.icts.uct.ac.za/AnyConnect](http://www.icts.uct.ac.za/AnyConnect)

In order to build O2 successfully, this repository must be cloned into your `/scratch` folder on the HPC. The various functions are controlled by a Makefile - to execute it, navigate to the cloned directory (should be `/scratch/[stdno]/o2hpc`)and run the `make` command along with the target you want to run and your student number as per the following example: `make overlay stdno="nthnin001"`


### Installing O2
The technicalities of installing O2 on the HPC are all contained within the Makefile. The targets should be run in the folling order: **overlay -> init -> build**. Below is a brief description of what each target does.

#### Makefile Targets
- **overlay**: creates an ext3 file system overlay image. This image (called overlayO2.img) will appear in your scratch folder and essentially exists to store what would normally be found in the "sw" folder of an O2 build. On the HPC those contents will only be accessible from within your singularity container, in the location "**/home/overlay_sw**" which will be created throughout the installation process. 
- **init**: this runs the aliBuild init commands you would normally run before your first build. It also runs aliDoctor, so be sure to check the slurm output file when the job finishes to make sure you're good to go!
- **build**: the big one - this builds O2. Likely to take an entire day to run.
- **pull**: experimental, as I haven't actually tried this, but in theory it'll do all the git pulls you need if you want to update your build.


### Slurm Admin
Some of the targets (`init`, `build`, and `pull`) will submit jobs to slurm while running. Slurm (docs: https://slurm.schedmd.com/) is a workflow manager that the HPC uses to regulate what jobs are running at a given time - this means that sometimes you will run the makefile and it will take a while before the build actually begins, there is a queuing period. In order to keep track of if your job is running, you can check its status:

`squeue -j [jobnumber]`

You can also get slurm to email you with notifications when a job starts, fails or completes. If you would like to do this, add the following lines of code to the headers of the files `o2sing_init.sh`, `o2sing_build.sh` and `o2sing_pull.sh` in slurmcodes:

`#SBATCH --mail-user=[email]`

`#SBATCH --mail-type=ALL`


### Running O2 with srun
Even after O2 is installed, it will not be directly accessible on login to your HPC account. The actual build is contained in the file system overlay that we created, stored in your scratch directory. In order to run or develop O2, you will need to be woring in the singularity container where the overlay is accessible. It is important to note that you are not permitted to run singularity on the head node of the HPC - this means you shouldn't just run the "singularity" command whenever (it will work but you may get a warning email from the HPC administrators, don't do it). 

Instead, you can submit a job to slurm that will start an interactive bash terminal by running `srun --ntasks=20 --pty bash`. You can technically add a whole lot of customization other than the number of cores (like how long you expect to be running it), but I don't know if that's a requirement or not so I haven't been doing it. However one time I didn't specify the number of cores I wanted and I got another one of those warning emails from the administrators when O2 started using more cores than the default because I hadn't restricted it manually.  Yikes, that one's on me, don't make my mistakes. 

Once the job has been allocated resources, you'll see your name and location be replaced by "bash" in the terminal. From here, in your `/scratch/studentnumber/o2hpc` folder (or whatever location you've decided to keep overlayO2.img and o2build.sif) run `singularity shell --overlay overlayO2.img o2build.sif` to enter your singularity container, and then `alienv enter O2Physics/latest-o2 -w /home/overlay_sw` to enter O2.
