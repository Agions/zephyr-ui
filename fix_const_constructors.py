#!/usr/bin/env python3
"""
Script to fix const constructor issues in the ZephyrUI Flutter component library.
This script systematically adds 'const' keyword to constructor invocations.
"""

import os
import re
import sys
from pathlib import Path

def fix_const_constructor_issue(file_path):
    """Fix const constructor issues in a single file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        original_content = content

        # Pattern 1: Add const to TextStyle constructors
        content = re.sub(
            r'textStyle:\s*TextStyle\(',
            'textStyle: const TextStyle(',
            content
        )

        # Pattern 2: Add const to EdgeInsets constructors
        content = re.sub(
            r'padding:\s*EdgeInsets\.\w+\(',
            lambda m: m.group(0).replace('padding: EdgeInsets.', 'padding: const EdgeInsets.'),
            content
        )

        # Pattern 3: Add const to BorderRadius constructors
        content = re.sub(
            r'borderRadius:\s*BorderRadius\.\w+\(',
            lambda m: m.group(0).replace('borderRadius: BorderRadius.', 'borderRadius: const BorderRadius.'),
            content
        )

        # Pattern 4: Add const to BorderSide constructors
        content = re.sub(
            r'BorderSide\(',
            'const BorderSide(',
            content
        )

        # Pattern 5: Add const to BoxShadow constructors
        content = re.sub(
            r'BoxShadow\(',
            'const BoxShadow(',
            content
        )

        # Pattern 6: Add const to Color constructors
        content = re.sub(
            r'Colors\.\w+\(\)',
            lambda m: m.group(0) if 'const' in m.group(0) else f'const {m.group(0)}',
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
    """Main function to process all theme files"""
    base_path = Path('/Users/zfkc/Desktop/03-移动端项目/flutter-ui/lib/src/components')

    if not base_path.exists():
        print(f"Base path does not exist: {base_path}")
        return

    fixed_files = []

    # Process all theme files first (highest impact)
    for theme_file in base_path.rglob('*_theme.dart'):
        if fix_const_constructor_issue(theme_file):
            fixed_files.append(theme_file)

    # Process form component files
    form_path = base_path / 'form'
    if form_path.exists():
        for dart_file in form_path.rglob('*.dart'):
            if 'example' not in dart_file.name and fix_const_constructor_issue(dart_file):
                fixed_files.append(dart_file)

    print(f"Fixed const constructor issues in {len(fixed_files)} files:")
    for file in sorted(fixed_files):
        print(f"  - {file.relative_to(base_path.parent.parent)}")

if __name__ == '__main__':
    main()