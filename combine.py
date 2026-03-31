# -*- coding: utf-8 -*-
# 配置区：只需要改这里的3个参数
MACHINE_CODE_FILE = "machine_code.txt"   # 你的机器码txt文件名
ASM_CODE_FILE = "asm.txt"          # 你的汇编指令txt文件名
START_ADDR = 0x80000000            # 起始地址（可自由修改）

# 读取文件并清理空行/空白字符
def read_file_lines(filename):
    with open(filename, "r", encoding="utf-8") as f:
        lines = [line.strip() for line in f if line.strip()]
    return lines

# 主逻辑
try:
    # 读取两个文件内容
    machine_lines = read_file_lines(MACHINE_CODE_FILE)
    asm_lines = read_file_lines(ASM_CODE_FILE)
    
    # 检查行数是否一致
    if len(machine_lines) != len(asm_lines):
        print(f"错误：两个文件行数不一致！机器码{len(machine_lines)}行，汇编{len(asm_lines)}行")
        exit(1)
    
    # 写入合并结果
    with open("merged_output.txt", "w", encoding="utf-8") as out_f:
        current_addr = START_ADDR
        
        for machine, asm in zip(machine_lines, asm_lines):
            # 格式：地址(16进制)    机器码    汇编指令
            out_f.write(f"{current_addr:08X}    {machine:10}    {asm}\n")
            current_addr += 4  # RISC-V 每条指令占4字节
    
    print(f"✅ 合并完成！生成文件：merged_output.txt")
    print(f"📌 总行数：{len(machine_lines)} 行")
    print(f"📍 起始地址：{hex(START_ADDR)}")

except FileNotFoundError as e:
    print(f"❌ 错误：找不到文件 {e.filename}")