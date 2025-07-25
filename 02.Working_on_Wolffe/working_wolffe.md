## Working on Wolffe

Wolffe is the name of the HPC cluster at WSU. The wiki page for Wolffe is available at [Wolffe Wiki](https://wiki.cdms.westernsydney.edu.au/index.php?title=HPC_documentation#Conda_environment).

## Logging in

To log onto Wolffe, you will need to use the SSH protocol. Open a terminal and type the following command:

```bash
ssh <username>@wolffe.cdms.westernsydney.edu.au
```

Replace `<username>` with your WSU username. You will be prompted to enter your password. Once logged in, you will be in your home directory on the Wolffe cluster.

You'll also need to be on the CDMS network to access Wolffe. To access the VPN, use the OpenVPN client and the profile you have received. Note the profile is only valid until the end of the year, so staff should request a new profile each year, and students should request a new profile from their supervisors.

Once logged in, you can see the message: 

```
For help with HPC matters, see:

https://wiki.cdms.westernsydney.edu.au/index.php?title=HPC_documentation

Last login: xxxxx from xxx.xxx.xxx.xxx
```

and any message of the day that may be displayed.


## How to use any apps on Wolffe

Unlike a standard computer, HPC systems do not have all the application available for use by default. Instead, applications are made available through modules. Modules allow you to load and unload software packages as needed.

To see the available modules, you can use the command:

```bash
module avail
```
This will list all the available modules on Wolffe:

```Output
---------------------------------- /usr/share/Modules/modulefiles ----------------------------------
dot  module-git  module-info  modules  null  use.own  

-------------------------------------- /usr/share/modulefiles --------------------------------------
mp-x86_64  mpi/openmpi-x86_64  

-------------------------------------- /software/modulefiles ---------------------------------------
10x/cellranger-3.0.2   funtools/funtools              mpi/openmpi-4.0.2           R/4.4.2  
anaconda/conda3        gnu/gcc-7.4.0                  mpi/openmpi-4.1.5           T-RECS   
caffe/caffe-cuda-10.0  gnu/gcc-10                     nccl/nccl-2.26.2-1          
caffe/caffe-fedora     gnu/gcc-10.5.0                 nextflow/nextflow-25.04.6   
casa/casa-5.4.1        gnu/gcc-11.1.0                 PyCharm-community-2023.2.3  
casa/casa-5.6.0        Java/java-24                   Python/Python3.6            
casa/casa-5.7.0.pre    Julialang/Julia-1.6.2          Python/Python3.7.0          
cmake/cmake-3.24.4     karma/karma-1.7.25             Python/Python3.9            
cmake/cmake-3.25.3     lammps/lammps-stable-20230801  Python/Python3.10           
colmap/colmap-3.11     lammps/lammps-stable-20230822  Python/Python3.11           
cuda/cuda-10.0         matlab/matlab2016a             Python/Python3.12.3         
cuda/cuda-10.2         matlab/matlab2018a             PyTorch/Python3.7.0         
cuda/cuda-11.0         matlab/matlab2019a             PyTorch/Python3.9           
cuda/cuda-11.2         miriad/miriad                  PyTorch/Python3.10          
cuda/cuda-11.6         Montage/Montage-6.0            PyTorch/Python3.11          
cuda/cuda-12.6         mpi/openmpi-1.8.8              PyTorch/Python3.12.3        
```

You can load a module using the command:

```bash
module load <module_name>
```

For example, to load the Python 3.10 module, you would use:

```bash
module load Python/Python3.10
``` 

You can check which modules are currently loaded with:

```bash
module list
```
```Output
Currently Loaded Modulefiles:
 1) Python/Python3.10 
```

Unlike most HPC systems, Wolffe does have `git` installed by default, so you can use it without loading a module. So you can clone this repository directly into your home directory:

```bash
git clone https://github.com/CRMDS/Intro-HPC-workshop.git
```


### Querying the queue system

Wolffe uses the Slurm workload manager to manage jobs. To find out what resources are available, you can use the command:

```bash
sinfo
```
This will show you the status of the nodes in the cluster: 
```Output
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
cpu*         up 21-00:00:0      2    mix compute-[002-003]
cpu*         up 21-00:00:0      1  alloc compute-001
ampere24     up 7-00:00:00      4  alloc a30-[002-005]
ampere80     up 7-00:00:00      1  alloc a100-100
ampere80     up 7-00:00:00      1   idle a100-101
ampere40     up 7-00:00:00      1  alloc a100-000
ampere40     up 7-00:00:00      2   idle a100-[001-002]
```

The columns indicate:
- **PARTITION**: The name of the partition (or queue) the nodes belong to
- **AVAIL**: Whether the partition is available for use
- **TIMELIMIT**: The maximum time a job can run in this partition
- **NODES**: The number of nodes in this partition
- **STATE**: The current state of the nodes (e.g., `alloc` for allocated, `idle` for available)
- **NODELIST**: The names of the nodes in this partition

To see the jobs currently running and submitted on the cluster, you can use:

```bash
squeue
```
This will show you a list of jobs in the queue: 
```Output
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             18226  ampere24   RLGOAL 30069287  R 2-10:31:01      1 a30-005
             18287  ampere24     mat1 18870679  R   21:04:11      1 a30-002
             18288  ampere24     mat2 18870679  R   21:03:45      1 a30-003
             18289  ampere24     mat3 18870679  R   21:03:13      1 a30-004
             18100  ampere40 EA_V4_Mi 30069287  R 4-15:02:23      1 a100-000
             18304  ampere80 vec2word 30069287  R    8:52:30      1 a100-100
             17962       cpu X12.2_15 30031031  R 5-20:01:58      1 compute-001
             17963       cpu X12.2_14 30031031  R 5-20:01:55      1 compute-001
             17964       cpu X12.2_14 30031031  R 5-19:57:36      1 compute-001
             17965       cpu X12.2_13 30031031  R 5-19:52:40      1 compute-001
             17966       cpu X12.2_13 30031031  R 5-19:52:11      1 compute-001
             17967       cpu X12.2_12 30031031  R 5-19:35:30      1 compute-001
             17968       cpu X12.2_12 30031031  R 5-19:34:30      1 compute-001
             17969       cpu X12.2_11 30031031  R 5-19:29:03      1 compute-001
             17970       cpu X12.2_11 30031031  R 5-19:25:31      1 compute-001
             17971       cpu X12.2_10 30031031  R 5-18:49:38      1 compute-001
             17972       cpu X12.2_10 30031031  R 5-18:28:52      1 compute-001
             17973       cpu X12.2_09 30031031  R 5-18:24:49      1 compute-001
             ......
```

The columns indicate:
- **JOBID**: The unique identifier for the job
- **PARTITION**: The partition (or queue) the job is running in
- **NAME**: The name of the job
- **USER**: The user who submitted the job
- **ST**: The current state of the job (e.g., `R` for running, `PD` for pending)
- **TIME**: The total time the job has been running
- **NODES**: The number of nodes allocated to the job
- **NODELIST(REASON)**: The list of nodes the job is running on, or the reason why it is pending if it is not running

`squeue` can also be queried to show more information about jobs, check the `man squeue` page for more details.

To see your own jobs, you can use:

```bash
squeue -u <username>
```


## Running jobs

There are two main ways to run jobs on Wolffe: interactively and in batch mode. Note that you should **never** run jobs directly on the login node, as this can disrupt other users. 

### Interactive jobs

To ask for interactive resources, you can use the `sinteractive` command:

```bash
sinteractive -p cpu --time=0:30:00
```
This command requests an interactive session on the `cpu` partition for 30 minutes. You can adjust the partition and time limit as needed. Once the resources are allocated, you will be dropped into a shell on one of the compute nodes, where you can run commands interactively.

We'll run a simple [neural network example](NN1_digits.py). First, load the Python module:

```bash
module load PyTorch/Python3.10
```

Then, run the script:

```bash
python NN1_digits.py
```







## Parallel jobs







## Tips and tricks

To make the most of the HPC resources: 

- resource requests: Always ask for just enough resources for your job. Over-requesting can lead to longer wait times in the queue.
- job dependencies: Use job dependencies to chain jobs together, ensuring that one job starts only after another has completed. This can be done using the `--dependency` option in the `sbatch` command.
- job arrays: If you have many similar jobs to run, consider using job arrays. This allows you to submit multiple jobs with a single command, which can save time and reduce the load on the scheduler.
- monitoring: Use commands like `squeue`, `sinfo`, and `sacct` to monitor your jobs and the state of the cluster. This can help you identify issues and optimize your job submissions.
- error handling: Always check the output and error files generated by your jobs. These files can provide valuable information about the success or failure of your job and help you debug any issues that arise.
- documentation: Familiarize yourself with the documentation for Wolffe and Slurm. The [Wolffe Wiki](https://wiki.cdms.westernsydney.edu.au/index.php?title=HPC_documentation) is a great resource for understanding how to use the cluster effectively.
- **Always check the message of the day**: When you log in, read the message of the day for important announcements or changes to the system.
- **Use the `module` command**: Always check which modules are loaded and available. This can help you avoid conflicts and ensure you have the right software for your job.
- **Keep your home directory organized**: HPC systems often have limited storage, so keep your home directory tidy and remove unnecessary files regularly.
- **Use version control**: If you're working on code, consider using version control systems like Git to keep track of changes and collaborate with others.
- **Backup important data**: Regularly back up important data to avoid loss in case of hardware failure or other issues.
- **Be mindful of resource usage**: Avoid running resource-intensive jobs on the login node, as this can disrupt other users. Always use `sinteractive` or `sbatch` to run jobs on compute nodes.
- **Use the `scontrol` command**: This command can be used to view and modify job properties, such as changing the priority of a job or canceling a job.
- **Learn about job scheduling**: Understanding how the scheduler works can help you optimize your job submissions and reduce wait times in the queue.
- **Use `sacct` for job accounting**: This command can be used to view the status and resource usage of completed jobs, which can help you analyze performance and optimize future jobs.
- **Check the cluster status**: Use `sinfo` to check the status of the cluster and see which nodes are available. This can help you choose the best time to submit your jobs.

