# O2 on the HPC
### Required files and instructions for installing the ALICE experimental framework, O2, on UCT's high performance computing cluster.

In order to log on to the HPC at all, you need to be connected to UCT via VPN. The instructions to do this can be found here: [www.icts.uct.ac.za/AnyConnect](http://www.icts.uct.ac.za/AnyConnect)

Once you're in, create and enter a folder called `alice`, and then another called `setup`:
```
mkdir alice
cd alice
mkdir setup
cd setup
```

This is the folder where you will install O2. Pull, clone or otherwise, you need the following files:
- **alidock.sif**: the singularity container image that we will use to build O2
- **o2install.sh**: the set of "aliBuild init" commands that are used to initialize the installation
- **o2sing_init.sh**: the file that we will submit to slurm in order to execute **o2install.sh**
- **o2build.sh**: the main "aliBuild build" command 
- **o2sing.sh**: the file that we will submit to slurm in order to execute **o2build.sh**

The only change that is needed is in the files **o2sing_init.sh** and **o2sing.sh** - currently the "mail user" is set to me (nthnin001@myuct.ac.za). I recommend you change this so that you get email notifications about the status of your job, and so that I don't get flooded with them. 

First you need to submit **o2sing_init.sh** to slurm - to do this, run `sbatch o2sing_init.sh` from the `setup` folder. To check the status of your job, run `squeue` - this will show the list  of all jobs running on the HPC, their JOBIDs and the time they have been running for, etc. A log file will also be generated, named `slurm-JOBID.out` where `JOBID` is a unique code that will be provided to you when you submit to slurm. Once this is successfully completed (hopefully), make sure that the folders `alidist`, `sw`, `O2` and `O2Physics` have been created in your `alice` folder.

The same procedure should then be applied to **o2sing.sh**. 
