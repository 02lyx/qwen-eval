# Qwen2.5-Math-Instruct Series
PROMPT_TYPE="qwen-brite-template"

export HF_TOKEN=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

# 设置要评估的模型
MODELS=(
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0_exp0_gen_8_test_8_clip_ratio_0_outer_kl-80"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0_exp0_gen_8_test_8_clip_ratio_0_outer_kl-160"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0_exp0_gen_8_test_8_clip_ratio_0_outer_kl-240"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0_exp0_gen_8_test_8_clip_ratio_0_outer_kl-320"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0.5_exp12_gen_8_test_8_clip_ratio_-1_outer_kl-80"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0.5_exp12_gen_8_test_8_clip_ratio_-1_outer_kl-160"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0.5_exp12_gen_8_test_8_clip_ratio_-1_outer_kl-240"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0.5_exp12_gen_8_test_8_clip_ratio_-1_outer_kl-320"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0.5_exp12_no_ref_gen_8_test_8_clip_ratio_-1_outer_kl-80"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0.5_exp12_no_ref_gen_8_test_8_clip_ratio_-1_outer_kl-160"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0.5_exp12_no_ref_gen_8_test_8_clip_ratio_-1_outer_kl-240"
    "Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0.5_exp12_no_ref_gen_8_test_8_clip_ratio_-1_outer_kl-320"
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"
    "Qwen/Qwen2.5-7B"    
)

# 设置对应的输出目录名称
OUTPUT_DIRS=(
    "[base]-epoch-1-greedy"
    "[rs]-epoch-1-greedy"
    "[rs]-epoch-2-greedy"
    "[rs]-epoch-3-greedy"
    "[rs]-epoch-4-greedy"
    "[baseline]-epoch-1-greedy"
    "[baseline]-epoch-2-greedy"
    "[baseline]-epoch-3-greedy"
    "[baseline]-epoch-4-greedy"
    "[without-clip]-epoch-1-greedy"
    "[without-clip]-epoch-2-greedy"
    "[without-clip]-epoch-3-greedy"
    "[without-clip]-epoch-4-greedy"
    "[no-ref]-epoch-1-greedy"
    "[no-ref]-epoch-2-greedy"
    "[no-ref]-epoch-3-greedy"
    "[no-ref]-epoch-4-greedy"
    "[em]-epoch-1-greedy"
    "[em]-epoch-2-greedy"
    "[em]-epoch-3-greedy"
    "[em]-epoch-4-greedy"
)

# 设置对应的LoRA路径
LORA_PATHS=(
    "-1"
    "Yuanxin-Liu/mix-math-7b-Qwen-rs-baseline-global_step_1097"
    "Yuanxin-Liu/mix-math-7b-Qwen-rs-baseline-global_step_2194"
    "Yuanxin-Liu/mix-math-7b-Qwen-rs-baseline-global_step_3291"
    "Yuanxin-Liu/mix-math-7b-Qwen-rs-baseline-global_step_4388"
    "-1"
    "-1"
    "-1"
    "-1"
    "-1"
    "-1"
    "-1"
    "-1"
    "-1"
    "-1"
    "-1"
    "-1"
    "Yuanxin-Liu/estep-rs-epoch4-step-global_step_3025"
    "Yuanxin-Liu/estep-rs-epoch4-step-global_step_6050"
    "Yuanxin-Liu/estep-rs-epoch4-step-global_step_9075"
    "Yuanxin-Liu/estep-rs-epoch4-step-global_step_12100"    
)

# 设置对应的GPU设备
export CUDA_VISIBLE_DEVICES=4,5,6,7

export WANDB_API_KEY=6f9e1eaf73cd08b4f0cd4674c7856201f2453428
wandb login --relogin $WANDB_API_KEY

PROJECT_NAME="qwen-eval-greedy"

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
    bash sh/eval_greedy.sh $PROMPT_TYPE $MODEL_NAME_OR_PATH $OUTPUT_DIR $LORA_PATH $PROJECT_NAME $OUTPUT_DIR

    echo "模型 $((i+1)) 评估完成！"
    echo "========================================================"
done

echo "所有模型评估完成！"