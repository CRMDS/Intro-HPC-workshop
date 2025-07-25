#! /usr/bin/env bash
#
#SBATCH --job-name=MLP
#SBATCH --output=res.txt
#
#SBATCH --ntasks=1
#SBATCH --time=05:00
#SBATCH --partition=cpu

# load the module
module load Python/Python3.10

# do the submission
python3 -u MLP.py
sleep 180

