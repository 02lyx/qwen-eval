conda activate eval

# Qwen2.5-Math-Instruct Series
PROMPT_TYPE="qwen-brite-template"

export HF_TOKEN=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

# 设置要评估的模型
MODEL_NAME_OR_PATH="Qwen/Qwen2.5-7B"
OUTPUT_DIR="[rs]-160-sampling"
LORA_PATH="Yuanxin-Liu/mix-math-7b-Qwen-rs-baseline-global_step_2194"
export CUDA_VISIBLE_DEVICES=4,5,6,7

echo "========================================================"
echo "开始评估基础模型: $MODEL_NAME_OR_PATH"
echo "输出目录: $OUTPUT_DIR"
echo "========================================================"

# 执行评估
bash sh/eval.sh $PROMPT_TYPE $MODEL_NAME_OR_PATH $OUTPUT_DIR $LORA_PATH

echo "基础模型评估完成！"