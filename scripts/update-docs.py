#!/usr/bin/env python3
"""
ZephyrUI 文档更新自动化脚本
自动更新文档版本、时间戳和交叉引用
"""

import os
import re
import json
from pathlib import Path
from typing import Dict, List, Optional, Tuple
from datetime import datetime
import argparse

class DocsUpdater:
    def __init__(self, docs_dir: str = "doc"):
        self.docs_dir = Path(docs_dir)
        self.updated_files = []
        self.update_stats = {
            'total_files': 0,
            'updated_files': 0,
            'fixed_links': 0,
            'updated_versions': 0,
            'updated_timestamps': 0
        }
        
    def find_markdown_files(self) -> List[Path]:
        """查找所有Markdown文件"""
        return list(self.docs_dir.rglob("*.md"))
    
    def update_frontmatter(self, file_path: Path, version: str = "1.0.0") -> bool:
        """更新frontmatter"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # 更新版本
            if version:
                content = re.sub(
                    r'version:.*',
                    f'version: {version}',
                    content
                )
            
            # 更新时间戳
            current_date = datetime.now().strftime("%Y-%m-%d")
            content = re.sub(
                r'last_updated:.*',
                f'last_updated: {current_date}',
                content
            )
            
            # 如果内容有变化，保存文件
            if content != original_content:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                self.update_stats['updated_files'] += 1
                if version:
                    self.update_stats['updated_versions'] += 1
                self.update_stats['updated_timestamps'] += 1
                
                return True
            
            return False
            
        except Exception as e:
            print(f"更新文件 {file_path} 时出错: {e}")
            return False
    
    def update_cross_references(self, file_path: Path) -> bool:
        """更新交叉引用"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # 更新组件引用
            component_mapping = {
                'Button': 'ZephyrButton',
                'Input': 'ZephyrInput',
                'Card': 'ZephyrCard',
                'Text': 'ZephyrText',
                'Icon': 'ZephyrIcon',
                'List': 'ZephyrList',
                'Grid': 'ZephyrGrid',
                'Tabs': 'ZephyrTabs',
                'Form': 'ZephyrForm'
            }
            
            # 更新组件名称引用
            for old_name, new_name in component_mapping.items():
                content = re.sub(
                    rf'\b{old_name}\b(?![a-zA-Z])',
                    new_name,
                    content
                )
            
            # 更新文档链接
            link_mapping = {
                '../components/': '../components/',
                '../guides/': '../guides/',
                '../api/': '../api/',
                '../examples/': '../examples/'
            }
            
            for old_link, new_link in link_mapping.items():
                content = re.sub(
                    rf'\]\({old_link}([^)]+)\)',
                    f']({new_link}\\1)',
                    content
                )
            
            # 如果内容有变化，保存文件
            if content != original_content:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                self.update_stats['updated_files'] += 1
                self.update_stats['fixed_links'] += 1
                
                return True
            
            return False
            
        except Exception as e:
            print(f"更新交叉引用 {file_path} 时出错: {e}")
            return False
    
    def update_api_references(self, file_path: Path) -> bool:
        """更新API引用"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # 更新API参考链接
            api_patterns = [
                (r'\[API Reference\]\(.*?\)', '[API 参考](../api/components.md)'),
                (r'\[API 文档\]\(.*?\)', '[API 参考](../api/components.md)'),
                (r'\[组件API\]\(.*?\)', '[组件 API](../api/components.md)'),
                (r'\[主题API\]\(.*?\)', '[主题 API](../api/themes.md)'),
                (r'\[工具API\]\(.*?\)', '[工具函数 API](../api/utils.md)')
            ]
            
            for pattern, replacement in api_patterns:
                content = re.sub(pattern, replacement, content)
            
            # 如果内容有变化，保存文件
            if content != original_content:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                self.update_stats['updated_files'] += 1
                self.update_stats['fixed_links'] += 1
                
                return True
            
            return False
            
        except Exception as e:
            print(f"更新API引用 {file_path} 时出错: {e}")
            return False
    
    def update_code_examples(self, file_path: Path) -> bool:
        """更新代码示例"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # 更新导入语句
            import_patterns = [
                (r"import 'package:flutter/material\.dart';", "import 'package:flutter/material.dart';\nimport 'package:zephyr_ui/zephyr_ui.dart';"),
                (r"import 'package:zephyr_ui/.*';", "import 'package:zephyr_ui/zephyr_ui.dart';")
            ]
            
            for pattern, replacement in import_patterns:
                content = re.sub(pattern, replacement, content)
            
            # 更新组件使用
            component_updates = {
                'ElevatedButton(': 'ZephyrButton.primary(',
                'OutlinedButton(': 'ZephyrButton.secondary(',
                'TextButton(': 'ZephyrButton.text(',
                'Text(': 'ZephyrText(',
                'Icon(': 'ZephyrIcon(',
                'Card(': 'ZephyrCard(',
                'ListTile(': 'ZephyrListTile('
            }
            
            for old_comp, new_comp in component_updates.items():
                content = re.sub(
                    rf'\b{old_comp}',
                    new_comp,
                    content
                )
            
            # 如果内容有变化，保存文件
            if content != original_content:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                self.update_stats['updated_files'] += 1
                
                return True
            
            return False
            
        except Exception as e:
            print(f"更新代码示例 {file_path} 时出错: {e}")
            return False
    
    def update_table_of_contents(self, file_path: Path) -> bool:
        """更新目录"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # 如果是README文件，更新目录
            if file_path.name == 'README.md':
                # 提取所有标题
                headers = re.findall(r'^(#+)\s+(.+)$', content, re.MULTILINE)
                
                # 生成新的目录
                toc = "## 📖 目录\n\n"
                for level, title in headers:
                    if level == '#':  # 跳过主标题
                        continue
                    
                    indent = '  ' * (len(level) - 2)
                    anchor = title.lower().replace(' ', '-').replace('/', '').replace('.', '')
                    toc += f"{indent}- [{title}](#{anchor})\n"
                
                # 替换现有目录
                toc_pattern = r'## 📖 目录\n\n(?:.*?\n\n)?(?=##)'
                new_content = re.sub(toc_pattern, toc + '\n\n', content, flags=re.DOTALL)
                
                if new_content != content:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    
                    self.update_stats['updated_files'] += 1
                    
                    return True
            
            return False
            
        except Exception as e:
            print(f"更新目录 {file_path} 时出错: {e}")
            return False
    
    def update_version_references(self, file_path: Path, version: str) -> bool:
        """更新版本引用"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # 更新版本引用
            version_patterns = [
                (r'zephyr_ui:\s*\^\d+\.\d+\.\d+', f'zephyr_ui: ^{version}'),
                (r'version\s*["\']\d+\.\d+\.\d+["\']', f'version "{version}"'),
                (r'版本\s*[:：]\s*\d+\.\d+\.\d+', f'版本: {version}'),
                (r'v\d+\.\d+\.\d+', f'v{version}')
            ]
            
            for pattern, replacement in version_patterns:
                content = re.sub(pattern, replacement, content)
            
            # 如果内容有变化，保存文件
            if content != original_content:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                self.update_stats['updated_files'] += 1
                self.update_stats['updated_versions'] += 1
                
                return True
            
            return False
            
        except Exception as e:
            print(f"更新版本引用 {file_path} 时出错: {e}")
            return False
    
    def update_single_file(self, file_path: Path, version: str = None) -> bool:
        """更新单个文件"""
        updated = False
        
        print(f"更新文件: {file_path}")
        
        # 更新frontmatter
        if self.update_frontmatter(file_path, version):
            updated = True
        
        # 更新交叉引用
        if self.update_cross_references(file_path):
            updated = True
        
        # 更新API引用
        if self.update_api_references(file_path):
            updated = True
        
        # 更新代码示例
        if self.update_code_examples(file_path):
            updated = True
        
        # 更新目录
        if self.update_table_of_contents(file_path):
            updated = True
        
        # 更新版本引用
        if version and self.update_version_references(file_path, version):
            updated = True
        
        if updated:
            self.updated_files.append(str(file_path))
        
        return updated
    
    def update_all_files(self, version: str = None, pattern: str = None) -> None:
        """更新所有文件"""
        markdown_files = self.find_markdown_files()
        self.update_stats['total_files'] = len(markdown_files)
        
        # 如果有模式匹配，只更新匹配的文件
        if pattern:
            markdown_files = [f for f in markdown_files if pattern in f.name or pattern in str(f)]
        
        for file_path in markdown_files:
            self.update_single_file(file_path, version)
    
    def generate_update_report(self) -> None:
        """生成更新报告"""
        report = {
            'update_stats': self.update_stats,
            'updated_files': self.updated_files,
            'timestamp': datetime.now().isoformat()
        }
        
        # 保存JSON报告
        with open('docs-update-report.json', 'w', encoding='utf-8') as f:
            json.dump(report, f, ensure_ascii=False, indent=2)
        
        # 生成人类可读报告
        report_content = f"""# ZephyrUI 文档更新报告

**更新时间**: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}  
**总文件数**: {self.update_stats['total_files']}  
**更新文件数**: {self.update_stats['updated_files']}  
**修复链接数**: {self.update_stats['fixed_links']}  
**更新版本数**: {self.update_stats['updated_versions']}  
**更新时间戳数**: {self.update_stats['updated_timestamps']}

## 📊 更新统计

### 更新的文件
"""
        
        for file_path in self.updated_files:
            report_content += f"- {file_path}\n"
        
        report_content += "\n## 📋 更新详情\n\n"
        report_content += f"- **总文件数**: {self.update_stats['total_files']}\n"
        report_content += f"- **更新文件数**: {self.update_stats['updated_files']}\n"
        report_content += f"- **修复链接数**: {self.update_stats['fixed_links']}\n"
        report_content += f"- **更新版本数**: {self.update_stats['updated_versions']}\n"
        report_content += f"- **更新时间戳数**: {self.update_stats['updated_timestamps']}\n"
        
        # 保存人类可读报告
        with open('docs-update-report.md', 'w', encoding='utf-8') as f:
            f.write(report_content)
        
        print("更新报告已保存到 docs-update-report.md")
    
    def run_checks(self) -> None:
        """运行检查"""
        print("开始检查文档更新...")
        
        # 检查链接
        print("检查链接...")
        os.system("python scripts/link-checker.py")
        
        # 检查质量
        print("检查质量...")
        os.system("python scripts/docs-quality-checker.py")
        
        # 生成文档
        print("生成文档...")
        os.system("python scripts/docs-generator.py")
        
        print("检查完成!")

def main():
    """主函数"""
    parser = argparse.ArgumentParser(description="ZephyrUI 文档更新工具")
    parser.add_argument('--version', '-v', help='更新版本号')
    parser.add_argument('--pattern', '-p', help='只更新匹配模式的文件')
    parser.add_argument('--check', '-c', action='store_true', help='运行检查')
    parser.add_argument('--docs-dir', '-d', default='doc', help='文档目录')
    
    args = parser.parse_args()
    
    updater = DocsUpdater(args.docs_dir)
    
    if args.check:
        updater.run_checks()
    else:
        print("开始更新ZephyrUI文档...")
        
        # 更新所有文件
        updater.update_all_files(args.version, args.pattern)
        
        # 生成更新报告
        updater.generate_update_report()
        
        print("文档更新完成!")
        print(f"更新了 {updater.update_stats['updated_files']} 个文件")
        print(f"修复了 {updater.update_stats['fixed_links']} 个链接")

if __name__ == "__main__":
    main()