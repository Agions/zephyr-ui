#!/usr/bin/env python3
"""
目录结构重组脚本
用于将 Flutter UI 组件库的目录结构进行专业化重组
"""

import os
import shutil
import sys
from pathlib import Path

def main():
    # 基础路径
    base_path = Path("/Users/zfkc/Desktop/03-移动端项目/flutter-ui/lib/src/components")
    
    # 1. 创建新的目录结构
    print("=== 创建新的目录结构 ===")
    
    # 创建新目录
    new_dirs = [
        "media",
        "input_advanced", 
        "utilities",
        "data_display"
    ]
    
    for dir_name in new_dirs:
        new_dir = base_path / dir_name
        if not new_dir.exists():
            print(f"创建目录: {new_dir}")
            new_dir.mkdir(parents=True, exist_ok=True)
    
    # 2. 移动文件到新位置
    print("\n=== 移动文件到新位置 ===")
    
    # 移动映射：源目录 -> 目标目录
    move_mappings = [
        ("advanced/imagecropper", "media/image_cropper"),
        ("advanced/pdfviewer", "media/pdf_viewer"),
        ("advanced/mediaplayer", "media/media_player"),
        ("advanced/autocomplete", "input_advanced/auto_complete"),
        ("advanced/colorpicker", "input_advanced/color_picker"),
        ("advanced/editor", "input_advanced/rich_editor"),
        ("advanced/upload", "input_advanced/file_upload"),
        ("advanced/qrcode", "utilities/qr_code"),
        ("advanced/chart", "data_display/charts"),
    ]
    
    for src_dir, dst_dir in move_mappings:
        src_path = base_path / src_dir
        dst_path = base_path / dst_dir
        
        if src_path.exists():
            print(f"移动: {src_path} -> {dst_path}")
            # 确保目标目录存在
            dst_path.parent.mkdir(parents=True, exist_ok=True)
            # 移动目录
            shutil.move(str(src_path), str(dst_path))
        else:
            print(f"警告: 源目录不存在: {src_path}")
    
    # 3. 重命名目录
    print("\n=== 重命名目录 ===")
    
    # 重命名 form 为 forms
    form_path = base_path / "form"
    forms_path = base_path / "forms"
    if form_path.exists():
        print(f"重命名: {form_path} -> {forms_path}")
        shutil.move(str(form_path), str(forms_path))
    
    # 重命名 display 为 data_display
    display_path = base_path / "display"
    data_display_path = base_path / "data_display"
    if display_path.exists():
        print(f"重命名: {display_path} -> {data_display_path}")
        shutil.move(str(display_path), str(data_display_path))
    
    # 4. 检查并移动 drag_drop.dart
    print("\n=== 处理 drag_drop.dart ===")
    drag_drop_src = base_path / "advanced" / "drag_drop.dart"
    drag_drop_dst = base_path / "utilities" / "drag_drop.dart"
    
    if drag_drop_src.exists():
        print(f"移动: {drag_drop_src} -> {drag_drop_dst}")
        drag_drop_dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(drag_drop_src), str(drag_drop_dst))
    
    # 5. 创建空的 index.dart 文件（如果需要）
    print("\n=== 创建 index.dart 文件 ===")
    
    index_dirs = [
        "media",
        "input_advanced", 
        "utilities",
        "data_display"
    ]
    
    for dir_name in index_dirs:
        index_file = base_path / dir_name / "index.dart"
        if not index_file.exists():
            print(f"创建: {index_file}")
            with open(index_file, 'w') as f:
                f.write("// Export statements will be added here\n")
    
    print("\n=== 目录重组完成 ===")

if __name__ == "__main__":
    main()