#!/usr/bin/env python3
"""
更新导入路径脚本
用于批量更新移动文件后的导入路径
"""

import os
import re
from pathlib import Path

def update_imports_in_file(file_path):
    """更新单个文件中的导入路径"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # 导入路径映射
        import_mappings = [
            # advanced -> media
            (r'package:zephyr_ui\/src\/components\/advanced\/imagecropper', 'package:zephyr_ui/src/components/media/image_cropper'),
            (r'package:zephyr_ui\/src\/components\/advanced\/pdfviewer', 'package:zephyr_ui/src/components/media/pdf_viewer'),
            (r'package:zephyr_ui\/src\/components\/advanced\/mediaplayer', 'package:zephyr_ui/src/components/media/media_player'),
            
            # advanced -> input_advanced
            (r'package:zephyr_ui\/src\/components\/advanced\/autocomplete', 'package:zephyr_ui/src/components/input_advanced/auto_complete'),
            (r'package:zephyr_ui\/src\/components\/advanced\/colorpicker', 'package:zephyr_ui/src/components/input_advanced/color_picker'),
            (r'package:zephyr_ui\/src\/components\/advanced\/editor', 'package:zephyr_ui/src/components/input_advanced/rich_editor'),
            (r'package:zephyr_ui\/src\/components\/advanced\/upload', 'package:zephyr_ui/src/components/input_advanced/file_upload'),
            
            # advanced -> utilities
            (r'package:zephyr_ui\/src\/components\/advanced\/qrcode', 'package:zephyr_ui/src/components/utilities/qr_code'),
            (r'package:zephyr_ui\/src\/components\/advanced\/drag_drop', 'package:zephyr_ui/src/components/utilities/drag_drop'),
            
            # advanced -> data_display
            (r'package:zephyr_ui\/src\/components\/advanced\/chart', 'package:zephyr_ui/src/components/data_display/charts'),
            
            # form -> forms
            (r'package:zephyr_ui\/src\/components\/form', 'package:zephyr_ui/src/components/forms'),
            
            # display -> data_display
            (r'package:zephyr_ui\/src\/components\/display', 'package:zephyr_ui/src/components/data_display'),
        ]
        
        # 应用所有导入路径映射
        for old_pattern, new_pattern in import_mappings:
            content = re.sub(old_pattern, new_pattern, content)
        
        # 如果内容有变化，则写回文件
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        
        return False
    
    except Exception as e:
        print(f"处理文件 {file_path} 时出错: {e}")
        return False

def main():
    """主函数"""
    base_path = Path("/Users/zfkc/Desktop/03-移动端项目/flutter-ui")
    
    # 需要处理的文件类型
    file_extensions = ['.dart', '.md', '.txt']
    
    # 统计信息
    total_files = 0
    updated_files = 0
    
    print("=== 更新导入路径 ===")
    
    # 遍历所有相关文件
    for ext in file_extensions:
        for file_path in base_path.rglob(f"*{ext}"):
            # 跳过脚本文件和临时文件
            if 'scripts' in str(file_path) or 'build' in str(file_path) or '.dart_tool' in str(file_path):
                continue
            
            total_files += 1
            if update_imports_in_file(file_path):
                updated_files += 1
                print(f"更新: {file_path}")
    
    print(f"\n=== 完成 ===")
    print(f"总共处理 {total_files} 个文件")
    print(f"更新了 {updated_files} 个文件")

if __name__ == "__main__":
    main()