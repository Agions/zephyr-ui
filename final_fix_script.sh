#!/bin/bash

# 最终批量修复脚本
echo "开始最终批量修复..."

# 获取所有需要修复的文件
files=($(find lib -name "*.dart" -exec grep -l "Key? key," {} \;))

echo "找到 ${#files[@]} 个文件需要修复"

# 修复每个文件
for file in "${files[@]}"; do
    echo "处理: $file"
    
    # 使用 sed 进行修复
    sed -i.bak 's/Key? key,/super.key,/g' "$file"
    sed -i.bak 's/) : super(key: key)/)/g' "$file"
    
    # 检查是否修复成功
    if grep -q "super.key" "$file"; then
        echo "  ✓ 修复成功"
        rm "$file.bak"
    else
        echo "  ✗ 修复失败，恢复备份"
        mv "$file.bak" "$file"
    fi
done

echo "修复完成"
