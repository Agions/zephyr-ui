#!/bin/bash

# 批量修复 super parameter 警告的脚本
echo "开始批量修复 super parameter 警告..."

# 获取所有包含 Key? key, 的文件
files=($(find lib -name "*.dart" -exec grep -l "Key? key," {} \; | grep -v "\.bak"))

total_files=${#files[@]}
fixed_files=0

echo "找到 $total_files 个需要修复的文件"

for file in "${files[@]}"; do
    echo "处理文件: $file"
    
    # 使用 perl 进行更精确的替换
    if perl -i.bak -pe '
        # 匹配构造函数模式并替换
        if (/const\s+\w+\s*\(\{[^}]*Key\? key,/) {
            s/Key\? key,/super.key,/;
            s/\)\s*:\s*super\(key:\s*key\)/\)/;
        }
    ' "$file" 2>/dev/null; then
        # 检查文件是否真的被修改了
        if ! diff "$file" "$file.bak" >/dev/null 2>&1; then
            ((fixed_files++))
            echo "  ✓ 已修复"
            rm "$file.bak"
        else
            echo "  - 无需修复"
            rm "$file.bak"
        fi
    else
        echo "  ✗ 修复失败"
        if [ -f "$file.bak" ]; then
            rm "$file.bak"
        fi
    fi
done

echo "修复完成！"
echo "总共处理了 $total_files 个文件"
echo "成功修复了 $fixed_files 个文件"

# 验证修复结果
echo "验证修复结果..."
remaining_files=$(find lib -name "*.dart" -exec grep -l "Key? key," {} \; | grep -v "\.bak" | wc -l)
echo "剩余 $remaining_files 个文件仍需修复"
