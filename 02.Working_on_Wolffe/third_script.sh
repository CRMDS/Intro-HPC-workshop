#! /usr/bin/env bash
#
#SBATCH --job-name=MLP
#SBATCH --output=output/S-gpu-out.txt
#SBATCH --error=output/S-gpu-err.txt
#
#SBATCH --time=00:05:00
#SBATCH --partition=ampere80
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=1

# load the module
module load Pytouch/Python3.10

# move to work directory
cd ~/Intro-HPC-workshop/02.Working_on_Wolffe/

# do the submission
python3 -u NN_gpu.py
sleep 60
