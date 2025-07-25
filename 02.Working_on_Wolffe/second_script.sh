#! /usr/bin/env bash
#
#SBATCH --job-name=MLP
#SBATCH --output=S-%A-res.txt
#SBATCH --error=S-%A-err.txt
#
#SBATCH --ntasks=1
#SBATCH --time=05:00
#SBATCH --partition=cpu
#SBATCH --array=1-10   # Array job with 10 tasks

# load the module
module load Python/Python3.10

# move to work directory
cd ~/Intro-HPC-workshop/02.Working_on_Wolffe/

data_file='random_state.txt'
# read the i-th line from the file and store it as "n"
n=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $data_file)

echo "Running task ${SLURM_ARRAY_TASK_ID} with random state ${n}"

# do the submission
python3 -u MLP_pararg.py --random_state $n
sleep 60
