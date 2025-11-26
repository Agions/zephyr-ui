#!/usr/bin/env python3
"""
Script to fix const constructor errors that are causing compilation failures.
This script removes incorrect const usage where constructors aren't actually const.
"""

import os
import re
import sys
from pathlib import Path

def fix_const_errors(file_path):
    """Fix const constructor errors in a single file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        original_content = content

        # Pattern 1: Remove const from BorderRadius.circular when variable is used
        content = re.sub(
            r'BorderRadius\.circular\(theme\.\w+\)',
            lambda m: m.group(0).replace('BorderRadius.circular(', 'BorderRadius.circular(').replace('const BorderRadius.circular(', 'BorderRadius.circular('),
            content
        )

        # Pattern 2: Remove const from BorderSide when nullable values are used
        content = re.sub(
            r'const BorderSide\((color:\s*theme\.\w+,|width:\s*theme\.\w+)',
            'BorderSide(',
            content
        )

        # Pattern 3: Remove const from EdgeInsets when theme values are used
        content = re.sub(
            r'const EdgeInsets\.only\(top:\s*theme\.\w+\)',
            'EdgeInsets.only(top: theme.',
            content
        )

        # Pattern 4: Remove const from BorderRadius.circular with variables
        content = re.sub(
            r'const BorderRadius\.circular\(([^)]+)\)',
            lambda m: f'BorderRadius.circular({m.group(1)})',
            content
        )

        # Pattern 5: Fix BoxShadow with widget.theme values (can't be const)
        content = re.sub(
            r'const BoxShadow\(\s*color:\s*widget\.theme\.',
            'BoxShadow(color: widget.theme.',
            content
        )

        # Pattern 6: Fix const in BorderSide with theme values
        content = re.sub(
            r'const BorderSide\(([^)]*widget\.theme\.[^)]*)\)',
            lambda m: f'BorderSide({m.group(1)})',
            content
        )

        # Write back if changed
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False

    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return False

def main():
    """Main function to fix const errors in problematic files"""
    base_path = Path('/Users/zfkc/Desktop/03-移动端项目/flutter-ui/lib/src/components/form')

    problematic_files = [
        'checkbox/checkbox.dart',
        'checkbox_group/checkbox_group.dart',
        'color_picker/color_picker.dart',
        'date_picker/date_picker.dart',
        'input/input.dart'
    ]

    fixed_files = []

    for file_name in problematic_files:
        file_path = base_path / file_name
        if file_path.exists() and fix_const_errors(file_path):
            fixed_files.append(file_path)

    print(f"Fixed const errors in {len(fixed_files)} files:")
    for file in sorted(fixed_files):
        print(f"  - {file.relative_to(base_path.parent.parent)}")

if __name__ == '__main__':
    main()