# O2 on the HPC
##### _Required files and instructions for installing the ALICE experimental framework, O2, on UCT's high performance computing cluster._

### Setup
To log on to the HPC:
 - You must have an HPC account: [https://ucthpc.uct.ac.za/index.php/account/](https://ucthpc.uct.ac.za/index.php/account/)
 - You need to be connected to UCT via VPN: [www.icts.uct.ac.za/AnyConnect](http://www.icts.uct.ac.za/AnyConnect)

In order to build O2 successfully, this repository must be cloned into your `/scratch` folder on the HPC. The various functions are controlled by a Makefile - to execute it, run the `make` command along with the target you want to run within the file and your student number as per the following example: `make overlay stdno="nthnin001"`


TODO: add info about make targets here


### Slurm Admin
Some of the targets (`init`, `build`, and `pull`) will submit jobs to slurm while running. Slurm (docs: https://slurm.schedmd.com/) is a workflow manager that the HPC uses to regulate what jobs are running at a time - this means that sometimes you will run the makefile and it will take some time before the build begins. In order to keep track of if your job is running, you can check the status of your job:

`squeue -o"%.7i %.9P %.8j %.8u %.2t %.10M %.6D %C" -j [jobnumber]`

You can also get slurm to email you with notifications when a job starts, fails or completes. If you would like to do this, add the following lines of code to the headers of the files `o2sing_init.sh`, `o2sing_build.sh` and `o2sing_pull.sh`:

`#SBATCH --mail-user=[email]`

`#SBATCH --mail-type=ALL`


### Running O2 with srun
Even after O2 is installed, it will not be directly accessible on login to your HPC account. The actual build is contained in a file system overlay that we created, stored in your scratch directory. In order to run/develop O2, you will need to be in a singularity environment where the overlay is accessible. It is important to note that you are not permitted to run singularity on the head node of the HPC - this means you should not just run the "singularity" command (it will work but you may get a warning email from the HPC administrators, just don't do it). 

Instead, you can submit a job to slurm that will start an interactive bash terminal by running `srun --ntasks=20 --pty bash`. You can technically add a whole lot of customization (like how long you expect to be running it), but if I'm honest I don't if that's a requirement or not. I just know that once I didn't specify the number of cores I wanted, it defaulted to 1, and I got another one of those warning emails from the administrators because I didn't manually tell O2 how many to use so it went over 1. Yikes, that one's on me, don't make my mistakes. 
