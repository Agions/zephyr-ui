#!/usr/bin/env python3
"""
验证重组后的组件结构
"""

import os
from pathlib import Path

BASE_DIR = Path("/Users/zfkc/Desktop/03-移动端项目/flutter-ui/lib/src/components")

EXPECTED_STRUCTURE = {
    "basic": [
        "avatar", "badge", "button", "card", "chip", "divider", "icon", "text"
    ],
    "display": [
        "calendar", "carousel", "charts", "list", 
        "statistic", "table", "timeline"
    ],
    "form": [
        "auto_complete", "checkbox", "checkbox_group", "color_picker", 
        "date_picker", "file_upload", "input", "radio", "radio_group", 
        "rating", "select", "signature", "slider", "switch", "text_area", 
        "time_picker"
    ],
    "navigation": [
        "bottom_navigation_bar", "navigation_rail", "pagination", 
        "side_menu", "stepper", "tabs", "tree"
    ],
    "feedback": [
        "alert", "modal", "progress", "skeleton", "toast", "tour"
    ],
    "layout": [
        "accordion", "container", "grid"
    ]
}

def validate_structure():
    """验证组件结构"""
    print("验证重组后的组件结构...")
    
    all_valid = True
    
    for category, expected_components in EXPECTED_STRUCTURE.items():
        category_dir = BASE_DIR / category
        
        if not category_dir.exists():
            print(f"❌ 分类目录不存在: {category}")
            all_valid = False
            continue
        
        # 检查index.dart文件
        index_file = category_dir / "index.dart"
        if not index_file.exists():
            print(f"❌ 缺少index.dart文件: {category}/index.dart")
            all_valid = False
        else:
            print(f"✅ {category}/index.dart")
        
        # 检查组件
        existing_components = [d.name for d in category_dir.iterdir() if d.is_dir()]
        
        for component in expected_components:
            component_dir = category_dir / component
            if not component_dir.exists():
                print(f"❌ 缺少组件: {category}/{component}")
                all_valid = False
            else:
                # 检查组件文件
                component_files = list(component_dir.glob("*.dart"))
                if not component_files:
                    print(f"❌ 组件文件为空: {category}/{component}")
                    all_valid = False
                else:
                    print(f"✅ {category}/{component}")
        
        # 检查是否有额外的组件
        extra_components = set(existing_components) - set(expected_components) - {"__pycache__"}
        if extra_components:
            print(f"⚠️  额外的组件: {category}/{', '.join(extra_components)}")
    
    # 检查主要的exports.dart文件
    exports_file = BASE_DIR / "exports.dart"
    if not exports_file.exists():
        print("❌ 缺少主要的exports.dart文件")
        all_valid = False
    else:
        print("✅ exports.dart")
    
    # 检查是否删除了不需要的目录
    deleted_dirs = ["media", "utilities", "error_handling", "forms", "input_advanced", "data_display"]
    for dir_name in deleted_dirs:
        dir_path = BASE_DIR / dir_name
        if dir_path.exists():
            print(f"❌ 未删除的目录: {dir_name}")
            all_valid = False
        else:
            print(f"✅ 已删除目录: {dir_name}")
    
    # 检查breadcrumb是否删除
    breadcrumb_path = BASE_DIR / "navigation" / "breadcrumb"
    if breadcrumb_path.exists():
        print("❌ breadcrumb组件未删除")
        all_valid = False
    else:
        print("✅ breadcrumb组件已删除")
    
    print(f"\n验证结果: {'✅ 通过' if all_valid else '❌ 失败'}")
    return all_valid

def show_structure():
    """显示当前结构"""
    print("\n当前组件结构:")
    print("=" * 50)
    
    for category in sorted(EXPECTED_STRUCTURE.keys()):
        category_dir = BASE_DIR / category
        print(f"\n{category.upper()}:")
        
        if category_dir.exists():
            components = [d.name for d in category_dir.iterdir() if d.is_dir()]
            for component in sorted(components):
                print(f"  - {component}")
        else:
            print("  ❌ 目录不存在")

if __name__ == "__main__":
    show_structure()
    print("\n" + "=" * 50)
    validate_structure()