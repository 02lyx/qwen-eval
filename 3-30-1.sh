# Qwen2.5-Math-Instruct Series
PROMPT_TYPE="qwen-brite-template"

export HF_TOKEN=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

# 设置要评估的模型
MODELS=(
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"
)

# 设置对应的输出目录名称
OUTPUT_DIRS=(
    "[emodel]-epoch-1-sampling"
    "[emodel]-epoch-2-sampling"
    "[emodel]-epoch-3-sampling"
    "[emodel]-epoch-4-sampling"
)

# 设置对应的LoRA路径
LORA_PATHS=(
    "Yuanxin-Liu/estep-rs-epoch4-step-global_step_3025"
    "Yuanxin-Liu/estep-rs-epoch4-step-global_step_6050"
    "Yuanxin-Liu/estep-rs-epoch4-step-global_step_9075"
    "Yuanxin-Liu/estep-rs-epoch4-step-global_step_12100"
)

# 设置对应的GPU设备
export CUDA_VISIBLE_DEVICES=0,1,2,3

export WANDB_API_KEY=6f9e1eaf73cd08b4f0cd4674c7856201f2453428
wandb login --relogin $WANDB_API_KEY

PROJECT_NAME="qwen-eval"

# 遍历所有模型进行评估
for i in "${!MODELS[@]}"; do
    MODEL_NAME_OR_PATH="${MODELS[$i]}"
    OUTPUT_DIR="${OUTPUT_DIRS[$i]}"
    LORA_PATH="${LORA_PATHS[$i]}"
    
    echo "========================================================"
    echo "开始评估模型 $((i+1)): $MODEL_NAME_OR_PATH"
    echo "输出目录: $OUTPUT_DIR"
    echo "LoRA路径: $LORA_PATH"
    echo "========================================================"

    # 执行评估
    bash sh/eval.sh $PROMPT_TYPE $MODEL_NAME_OR_PATH $OUTPUT_DIR $LORA_PATH $PROJECT_NAME $OUTPUT_DIR

    echo "模型 $((i+1)) 评估完成！"
    echo "========================================================"
done

echo "所有模型评估完成！"