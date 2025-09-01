#!/usr/bin/env python3
"""
ZephyrUI 文档格式统一化工具
用于统一所有Markdown文档的格式
"""

import os
import re
from pathlib import Path
from typing import List, Dict
import json

class DocsFormatter:
    def __init__(self, docs_dir: str = "doc"):
        self.docs_dir = Path(docs_dir)
        self.formatted_files = []
        self.formatting_stats = {
            'total_files': 0,
            'formatted_files': 0,
            'fixed_headings': 0,
            'fixed_code_blocks': 0,
            'fixed_tables': 0,
            'fixed_links': 0
        }
    
    def find_markdown_files(self) -> List[Path]:
        """查找所有Markdown文件"""
        return list(self.docs_dir.rglob("*.md"))
    
    def format_headings(self, content: str) -> str:
        """统一标题格式"""
        lines = content.split('\n')
        formatted_lines = []
        
        for i, line in enumerate(lines):
            # 处理标题格式
            if line.startswith('#'):
                # 确保标题前后有空行
                if i > 0 and lines[i-1].strip() != '':
                    formatted_lines.append('')
                formatted_lines.append(line)
                if i < len(lines) - 1 and lines[i+1].strip() != '':
                    formatted_lines.append('')
            else:
                formatted_lines.append(line)
        
        return '\n'.join(formatted_lines)
    
    def format_code_blocks(self, content: str) -> str:
        """统一代码块格式"""
        # 确保代码块前后有空行
        formatted_content = re.sub(r'(\n```\w*\n)', r'\n\1', content)
        formatted_content = re.sub(r'(\n```\n)', r'\1\n', formatted_content)
        
        # 添加语言标识
        formatted_content = re.sub(r'(\n)```([^`\n]*)\n', r'\1```dart\n', formatted_content)
        
        return formatted_content
    
    def format_tables(self, content: str) -> str:
        """统一表格格式"""
        lines = content.split('\n')
        formatted_lines = []
        
        for line in lines:
            if '|' in line and line.strip().startswith('|'):
                # 格式化表格行
                cells = [cell.strip() for cell in line.split('|')]
                if len(cells) > 2:  # 确保是表格行
                    formatted_line = '| ' + ' | '.join(cells[1:-1]) + ' |'
                    formatted_lines.append(formatted_line)
                else:
                    formatted_lines.append(line)
            else:
                formatted_lines.append(line)
        
        return '\n'.join(formatted_lines)
    
    def format_links(self, content: str) -> str:
        """统一链接格式"""
        # 确保链接格式正确
        formatted_content = re.sub(r'\[([^\]]+)\]\s*\(([^)]+)\)', r'[\1](\2)', content)
        
        # 统一内部链接格式
        formatted_content = re.sub(r'\[([^\]]+)\]\(\.\./([^)]+)\)', r'[\1](../\2)', formatted_content)
        formatted_content = re.sub(r'\[([^\]]+)\]\(\./([^)]+)\)', r'[\1](\2)', formatted_content)
        
        return formatted_content
    
    def add_frontmatter(self, content: str, file_path: Path) -> str:
        """添加统一的frontmatter"""
        # 获取文件标题
        title = file_path.stem.replace('-', ' ').replace('_', ' ').title()
        
        frontmatter = f"""---
title: {title}
description: ZephyrUI {title} 组件文档
version: 1.0.0
last_updated: 2024-08-25
---

"""
        
        # 如果文件已经有frontmatter，不重复添加
        if content.startswith('---'):
            return content
        
        return frontmatter + content
    
    def standardize_structure(self, content: str) -> str:
        """标准化文档结构"""
        lines = content.split('\n')
        
        # 确保有标题
        if not lines[0].startswith('# '):
            lines.insert(0, f"# {Path(self.current_file).stem.replace('-', ' ').title()}")
        
        # 添加标准章节
        standard_sections = [
            "## 🎯 组件概述",
            "## 🚀 基础用法",
            "## 🎨 样式定制",
            "## 🎛️ API 参考",
            "## 🏆 最佳实践",
            "## 🔄 相关组件",
            "## 📝 更新日志"
        ]
        
        # 检查是否需要添加标准章节
        for section in standard_sections:
            if section not in content:
                # 在适当位置添加章节
                if "## 🚀 基础用法" in content and section == "## 🎨 样式定制":
                    lines.append(f"\n{section}\n")
        
        return '\n'.join(lines)
    
    def format_file(self, file_path: Path) -> str:
        """格式化单个文件"""
        self.current_file = file_path
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # 应用各种格式化规则
            content = self.format_headings(content)
            content = self.format_code_blocks(content)
            content = self.format_tables(content)
            content = self.format_links(content)
            content = self.add_frontmatter(content, file_path)
            content = self.standardize_structure(content)
            
            # 如果内容有变化，保存文件
            if content != original_content:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                self.formatted_files.append(str(file_path))
                self.formatting_stats['formatted_files'] += 1
                
                # 更新统计信息
                if self.format_headings.__name__ in str(self.format_headings):
                    self.formatting_stats['fixed_headings'] += 1
                if self.format_code_blocks.__name__ in str(self.format_code_blocks):
                    self.formatting_stats['fixed_code_blocks'] += 1
                if self.format_tables.__name__ in str(self.format_tables):
                    self.formatting_stats['fixed_tables'] += 1
                if self.format_links.__name__ in str(self.format_links):
                    self.formatting_stats['fixed_links'] += 1
            
            return content
            
        except Exception as e:
            print(f"格式化文件 {file_path} 时出错: {e}")
            return ""
    
    def format_all_files(self):
        """格式化所有文档文件"""
        markdown_files = self.find_markdown_files()
        self.formatting_stats['total_files'] = len(markdown_files)
        
        for file_path in markdown_files:
            print(f"格式化文件: {file_path}")
            self.format_file(file_path)
    
    def generate_formatting_report(self):
        """生成格式化报告"""
        report = {
            'formatting_stats': self.formatting_stats,
            'formatted_files': self.formatted_files
        }
        
        with open('formatting-report.json', 'w', encoding='utf-8') as f:
            json.dump(report, f, ensure_ascii=False, indent=2)
        
        print(f"格式化完成!")
        print(f"总文件数: {self.formatting_stats['total_files']}")
        print(f"已格式化文件数: {self.formatting_stats['formatted_files']}")
        print(f"修复标题数: {self.formatting_stats['fixed_headings']}")
        print(f"修复代码块数: {self.formatting_stats['fixed_code_blocks']}")
        print(f"修复表格数: {self.formatting_stats['fixed_tables']}")
        print(f"修复链接数: {self.formatting_stats['fixed_links']}")

def main():
    """主函数"""
    print("开始格式化 ZephyrUI 文档...")
    
    formatter = DocsFormatter()
    
    # 格式化所有文件
    formatter.format_all_files()
    
    # 生成报告
    formatter.generate_formatting_report()
    
    print("文档格式化完成!")

if __name__ == "__main__":
    main()