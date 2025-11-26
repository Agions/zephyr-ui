#!/bin/bash

# 批量修复 super parameter 警告的脚本
# 只修复主构造函数，不修复工厂构造函数

echo "开始修复 super parameter 警告..."

# 获取所有包含 Key? key, 的文件
files=($(find lib -name "*.dart" -exec grep -l "Key? key," {} \;))

total_files=${#files[@]}
fixed_files=0

echo "找到 $total_files 个需要修复的文件"

for file in "${files[@]}"; do
    echo "处理文件: $file"
    
    # 创建临时文件
    temp_file=$(mktemp)
    
    # 使用 sed 来修复构造函数
    # 匹配模式：const ClassName({ Key? key, ... }) : super(key: key);
    # 替换为：const ClassName({ super.key, ... });
    sed -E '
    # 处理主构造函数 - 只处理非工厂构造函数
    /^  const [A-Z][a-zA-Z0-9]*\(\{$/,/^\) : super\(key: key\);$/ {
        # 替换 Key? key, 为 super.key,
        s/Key\? key,/super.key,/
        # 删除 super(key: key) 行
        /^\) : super\(key: key\);$/d
        # 在构造函数结束位置添加 );
        /^    [a-zA-Z_][a-zA-Z0-9_]*,?$/!{
            /^  })$/a\
  )
        }
    }
    ' "$file" > "$temp_file"
    
    # 检查文件是否有变化
    if ! cmp -s "$file" "$temp_file"; then
        # 备份原文件
        cp "$file" "$file.bak"
        # 替换原文件
        mv "$temp_file" "$file"
        ((fixed_files++))
        echo "  ✓ 已修复"
    else
        rm "$temp_file"
        echo "  - 无需修复"
    fi
done

echo "修复完成！"
echo "总共处理了 $total_files 个文件"
echo "成功修复了 $fixed_files 个文件"
