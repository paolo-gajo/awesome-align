#!/bin/bash
#SBATCH -J food
#SBATCH -p local
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=72:00:00
#SBATCH --output=./.slurm/%j_output.log
#SBATCH --error=./.slurm/%j_error.log

DATA_FILE=/path/to/data/file
MODEL_NAME_OR_PATH=bert-base-multilingual-cased
OUTPUT_FILE=/path/to/output/file

CUDA_VISIBLE_DEVICES=0 awesome-align \
    --output_file=$OUTPUT_FILE \
    --model_name_or_path=$MODEL_NAME_OR_PATH \
    --data_file=$DATA_FILE \
    --extraction 'softmax' \
    --batch_size 32