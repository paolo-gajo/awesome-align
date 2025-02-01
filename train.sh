#!/bin/bash
#SBATCH -J food
#SBATCH -p local
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=72:00:00
#SBATCH --output=./.slurm/%j_output.log
#SBATCH --error=./.slurm/%j_error.log

TRAIN_SRC_TGT=./data/XL-WA/txt/it/train.src-tgt
TRAIN_GOLD=./data/XL-WA/txt/it/train.gold
EVAL_SRC_TGT=./data/XL-WA/txt/it/test.src-tgt
EVAL_GOLD=./data/XL-WA/txt/it/test.gold
OUTPUT_DIR=./output

python run_train.py \
    --output_dir=$OUTPUT_DIR \
    --model_name_or_path=bert-base-multilingual-cased \
    --extraction 'softmax' \
    --do_train \
    --train_tlm \
    --train_so \
    --train_data_file=$TRAIN_SRC_TGT \
    --train_gold_file=$TRAIN_GOLD \
    --per_gpu_train_batch_size 32 \
    --gradient_accumulation_steps 1 \
    --num_train_epochs 1 \
    --learning_rate 2e-5 \
    --save_steps 4000 \
    --max_steps 20000 \
    --do_eval \
    --eval_data_file=$EVAL_SRC_TGT \
    --eval_gold_file=$EVAL_GOLD