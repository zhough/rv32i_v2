# ====================== 配置项 ======================
COE_PATH    = "rv32i_v2.srcs/coe/irom.coe"   # 你的coe路径
OUTPUT_TXT  = "machine_code.txt"             # 输出txt
# ====================================================

with open(COE_PATH, "r", encoding="utf-8") as f:
    lines = f.readlines()

result = []

for line in lines:
    line = line.strip()
    
    # 跳过空行、开头的定义行
    if not line or line.startswith("memory_initialization"):
        continue
    
    # 去掉逗号、分号、空格
    clean = line.replace(",", "").replace(";", "").strip()
    
    # 只保留 8 位机器码
    if len(clean) == 8:
        result.append(clean)

# 写入txt，每行一条机器码
with open(OUTPUT_TXT, "w", encoding="utf-8") as f:
    f.write("\n".join(result))

print(f"✅ 处理完成！已保存到：{OUTPUT_TXT}")
print(f"📝 共提取指令：{len(result)} 条")