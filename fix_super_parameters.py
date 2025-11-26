#!/usr/bin/env python3
"""
Script to fix super parameter issues in the ZephyrUI Flutter component library.
This script systematically replaces 'Key? key,' and '}) : super(key: key);' with modern 'super.key' syntax.
"""

import os
import re
import sys
from pathlib import Path

def fix_super_parameter_issue(file_path):
    """Fix super parameter issues in a single file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        original_content = content

        # Pattern 1: Replace 'Key? key,' with 'super.key,'
        content = re.sub(
            r'const\s+\w+\(\{\s*Key\?\s*key,',
            lambda m: m.group(0).replace('Key? key,', 'super.key,'),
            content
        )

        # Pattern 2: Replace '}) : super(key: key);' with '});'
        content = re.sub(
            r'\}\)\s*:\s*super\(key:\s*key\)\s*;',
            '});',
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
    """Main function to process all form component files"""
    base_path = Path('/Users/zfkc/Desktop/03-移动端项目/flutter-ui/lib/src/components/form')

    if not base_path.exists():
        print(f"Base path does not exist: {base_path}")
        return

    fixed_files = []

    # Process all dart files in the form directory
    for dart_file in base_path.rglob('*.dart'):
        # Skip example files for now (they have factory constructors)
        if 'example' in dart_file.name:
            continue

        if fix_super_parameter_issue(dart_file):
            fixed_files.append(dart_file)

    print(f"Fixed super parameter issues in {len(fixed_files)} files:")
    for file in sorted(fixed_files):
        print(f"  - {file.relative_to(base_path.parent.parent)}")

if __name__ == '__main__':
    main()