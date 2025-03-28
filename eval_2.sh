conda activate eval

# Qwen2.5-Math-Instruct Series
PROMPT_TYPE="qwen-boxed"

export HF_TOKEN=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

# 设置要评估的模型
MODEL_NAME_OR_PATH="Yuanxin-Liu/Qwen2.5-7B_Mix-Math-yt-rbt-grpo_0_exp0_gen_8_test_8_clip_ratio_0_outer_kl-320"
OUTPUT_DIR="results-baseline-320-sampling"

export CUDA_VISIBLE_DEVICES=4,5,6,7

echo "========================================================"
echo "开始评估基础模型: $MODEL_NAME_OR_PATH"
echo "输出目录: $OUTPUT_DIR"
echo "========================================================"

# 执行评估
bash sh/eval.sh $PROMPT_TYPE $MODEL_NAME_OR_PATH $OUTPUT_DIR

echo "基础模型评估完成！"