import json
import os

def process_gpqa():
    # 读取 gpqa.json 文件
    input_file = os.path.join(os.path.dirname(__file__), 'gpqa.json')
    output_file = os.path.join(os.path.dirname(__file__), 'test.jsonl')
    
    with open(input_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # 处理数据并写入 jsonl 文件
    with open(output_file, 'w', encoding='utf-8') as f:
        for idx, item in enumerate(data):
            # 获取问题文本
            question = item['prompt'][0]['value']
            
            # 获取选项
            choices = item['choices']
            options = ' '.join([f"{k}) {v}" for k, v in choices.items()])
            
            # 获取答案
            answer = item['final_answer']
            
            # 创建新的数据格式
            processed_item = {
                'id': str(idx),
                'question': question,
                'options': options,
                'Answer': answer
            }
            
            # 写入 jsonl 文件
            f.write(json.dumps(processed_item, ensure_ascii=False) + '\n')

if __name__ == '__main__':
    process_gpqa()
    print("处理完成！输出文件：gpqa.jsonl")
