#!/usr/bin/env python3
"""
ZephyrUI 文档质量检查工具
检查文档质量、格式规范和内容完整性
"""

import os
import re
import json
from pathlib import Path
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass
from datetime import datetime

@dataclass
class DocIssue:
    """文档问题"""
    file_path: str
    line_number: int
    issue_type: str
    severity: str
    message: str
    suggestion: str

@dataclass
class DocQualityScore:
    """文档质量评分"""
    file_path: str
    total_score: float
    content_score: float
    format_score: float
    structure_score: float
    issues: List[DocIssue]

class DocsQualityChecker:
    def __init__(self, docs_dir: str = "doc"):
        self.docs_dir = Path(docs_dir)
        self.issues: List[DocIssue] = []
        self.scores: List[DocQualityScore] = []
        self.quality_rules = self.load_quality_rules()
        
    def load_quality_rules(self) -> Dict:
        """加载质量检查规则"""
        return {
            'content': {
                'required_sections': [
                    '## 🎯 组件概述',
                    '## 🚀 基础用法',
                    '## 🎨 样式定制',
                    '## 🎛️ API 参考',
                    '## 🏆 最佳实践'
                ],
                'min_code_examples': 3,
                'min_description_length': 100,
                'max_description_length': 2000,
                'required_properties': ['title', 'description', 'version']
            },
            'format': {
                'max_line_length': 120,
                'required_frontmatter': True,
                'code_block_language': True,
                'heading_blank_lines': True,
                'table_format': True
            },
            'structure': {
                'max_file_size': 100 * 1024,  # 100KB
                'required_headings': 3,
                'min_sections': 5,
                'logical_order': True
            }
        }
    
    def find_markdown_files(self) -> List[Path]:
        """查找所有Markdown文件"""
        return list(self.docs_dir.rglob("*.md"))
    
    def check_file_quality(self, file_path: Path) -> DocQualityScore:
        """检查单个文件质量"""
        issues = []
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                lines = content.split('\n')
        except Exception as e:
            return DocQualityScore(
                file_path=str(file_path),
                total_score=0,
                content_score=0,
                format_score=0,
                structure_score=0,
                issues=[DocIssue(
                    file_path=str(file_path),
                    line_number=0,
                    issue_type='file_read_error',
                    severity='critical',
                    message=f'无法读取文件: {e}',
                    suggestion='检查文件权限和编码'
                )]
            )
        
        # 检查内容质量
        content_score, content_issues = self.check_content_quality(file_path, content, lines)
        issues.extend(content_issues)
        
        # 检查格式质量
        format_score, format_issues = self.check_format_quality(file_path, content, lines)
        issues.extend(format_issues)
        
        # 检查结构质量
        structure_score, structure_issues = self.check_structure_quality(file_path, content, lines)
        issues.extend(structure_issues)
        
        # 计算总分
        total_score = (content_score * 0.4 + format_score * 0.3 + structure_score * 0.3)
        
        return DocQualityScore(
            file_path=str(file_path),
            total_score=total_score,
            content_score=content_score,
            format_score=format_score,
            structure_score=structure_score,
            issues=issues
        )
    
    def check_content_quality(self, file_path: Path, content: str, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查内容质量"""
        issues = []
        score = 100.0
        
        # 检查frontmatter
        frontmatter_score, frontmatter_issues = self.check_frontmatter(file_path, content, lines)
        score += frontmatter_score * 0.2
        issues.extend(frontmatter_issues)
        
        # 检查必需章节
        sections_score, sections_issues = self.check_required_sections(file_path, content, lines)
        score += sections_score * 0.3
        issues.extend(sections_issues)
        
        # 检查代码示例
        code_score, code_issues = self.check_code_examples(file_path, content, lines)
        score += code_score * 0.3
        issues.extend(code_issues)
        
        # 检查描述质量
        desc_score, desc_issues = self.check_description_quality(file_path, content, lines)
        score += desc_score * 0.2
        issues.extend(desc_issues)
        
        return min(score, 100), issues
    
    def check_frontmatter(self, file_path: Path, content: str, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查frontmatter"""
        issues = []
        score = 100.0
        
        if not content.startswith('---'):
            issues.append(DocIssue(
                file_path=str(file_path),
                line_number=1,
                issue_type='missing_frontmatter',
                severity='major',
                message='文档缺少frontmatter',
                suggestion='在文件开头添加frontmatter，包含title、description、version等信息'
            ))
            score -= 50
        else:
            # 检查必需属性
            frontmatter_end = content.find('---', 3)
            if frontmatter_end == -1:
                issues.append(DocIssue(
                    file_path=str(file_path),
                    line_number=1,
                    issue_type='invalid_frontmatter',
                    severity='major',
                    message='Frontmatter格式错误',
                    suggestion='确保frontmatter以---开始和结束'
                ))
                score -= 30
            else:
                frontmatter_content = content[3:frontmatter_end]
                
                required_props = self.quality_rules['content']['required_properties']
                for prop in required_props:
                    if prop not in frontmatter_content:
                        issues.append(DocIssue(
                            file_path=str(file_path),
                            line_number=1,
                            issue_type=f'missing_frontmatter_{prop}',
                            severity='minor',
                            message=f'Frontmatter缺少{prop}属性',
                            suggestion=f'在frontmatter中添加{prop}: 值'
                        ))
                        score -= 10
        
        return score, issues
    
    def check_required_sections(self, file_path: Path, content: str, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查必需章节"""
        issues = []
        score = 100.0
        
        required_sections = self.quality_rules['content']['required_sections']
        missing_sections = []
        
        for section in required_sections:
            if section not in content:
                missing_sections.append(section)
        
        if missing_sections:
            issues.append(DocIssue(
                file_path=str(file_path),
                line_number=1,
                issue_type='missing_sections',
                severity='major',
                message=f'缺少必需章节: {", ".join(missing_sections)}',
                suggestion=f'添加缺失的章节: {", ".join(missing_sections)}'
            ))
            score -= len(missing_sections) * 15
        
        return score, issues
    
    def check_code_examples(self, file_path: Path, content: str, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查代码示例"""
        issues = []
        score = 100.0
        
        # 统计代码块数量
        code_blocks = re.findall(r'```dart\n.*?\n```', content, re.DOTALL)
        code_count = len(code_blocks)
        
        min_examples = self.quality_rules['content']['min_code_examples']
        if code_count < min_examples:
            issues.append(DocIssue(
                file_path=str(file_path),
                line_number=1,
                issue_type='insufficient_code_examples',
                severity='minor',
                message=f'代码示例数量不足: {code_count} < {min_examples}',
                suggestion=f'添加至少{min_examples}个代码示例'
            ))
            score -= (min_examples - code_count) * 10
        
        # 检查代码块语言标识
        untagged_blocks = re.findall(r'```\n(.*?)\n```', content, re.DOTALL)
        if untagged_blocks:
            issues.append(DocIssue(
                file_path=str(file_path),
                line_number=1,
                issue_type='untagged_code_blocks',
                severity='minor',
                message=f'发现{len(untagged_blocks)}个未标识语言的代码块',
                suggestion='为所有代码块添加语言标识，如```dart'
            ))
            score -= len(untagged_blocks) * 5
        
        return score, issues
    
    def check_description_quality(self, file_path: Path, content: str, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查描述质量"""
        issues = []
        score = 100.0
        
        # 提取主要描述（frontmatter后的第一段文字）
        description_match = re.search(r'---\n.*?\n---\n\n(.+?)(?=\n\n#|\n##)', content, re.DOTALL)
        if description_match:
            description = description_match.group(1)
            desc_length = len(description)
            
            min_length = self.quality_rules['content']['min_description_length']
            max_length = self.quality_rules['content']['max_description_length']
            
            if desc_length < min_length:
                issues.append(DocIssue(
                    file_path=str(file_path),
                    line_number=1,
                    issue_type='short_description',
                    severity='minor',
                    message=f'描述过短: {desc_length} < {min_length}',
                    suggestion=f'扩展描述至少到{min_length}字符'
                ))
                score -= 20
            
            if desc_length > max_length:
                issues.append(DocIssue(
                    file_path=str(file_path),
                    line_number=1,
                    issue_type='long_description',
                    severity='minor',
                    message=f'描述过长: {desc_length} > {max_length}',
                    suggestion=f'精简描述到{max_length}字符以内'
                ))
                score -= 10
        else:
            issues.append(DocIssue(
                file_path=str(file_path),
                line_number=1,
                issue_type='missing_description',
                severity='major',
                message='缺少文档描述',
                suggestion='在frontmatter后添加组件描述'
            ))
            score -= 50
        
        return score, issues
    
    def check_format_quality(self, file_path: Path, content: str, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查格式质量"""
        issues = []
        score = 100.0
        
        # 检查行长度
        line_length_score, line_length_issues = self.check_line_length(file_path, lines)
        score += line_length_score * 0.3
        issues.extend(line_length_issues)
        
        # 检查标题格式
        heading_score, heading_issues = self.check_heading_format(file_path, lines)
        score += heading_score * 0.3
        issues.extend(heading_issues)
        
        # 检查表格格式
        table_score, table_issues = self.check_table_format(file_path, lines)
        score += table_score * 0.2
        issues.extend(table_issues)
        
        # 检查链接格式
        link_score, link_issues = self.check_link_format(file_path, lines)
        score += link_score * 0.2
        issues.extend(link_issues)
        
        return min(score, 100), issues
    
    def check_line_length(self, file_path: Path, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查行长度"""
        issues = []
        score = 100.0
        
        max_length = self.quality_rules['format']['max_line_length']
        long_lines = []
        
        for i, line in enumerate(lines, 1):
            if len(line) > max_length and not line.startswith('http'):
                long_lines.append((i, len(line)))
        
        if long_lines:
            issues.append(DocIssue(
                file_path=str(file_path),
                line_number=long_lines[0][0],
                issue_type='long_lines',
                severity='minor',
                message=f'发现{len(long_lines)}行过长的文本',
                suggestion=f'将长行拆分为多行，每行不超过{max_length}字符'
            ))
            score -= len(long_lines) * 2
        
        return score, issues
    
    def check_heading_format(self, file_path: Path, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查标题格式"""
        issues = []
        score = 100.0
        
        for i, line in enumerate(lines, 1):
            if line.startswith('#'):
                # 检查标题前后是否有空行
                has_blank_before = i == 1 or lines[i-2].strip() == ''
                has_blank_after = i == len(lines) or lines[i].strip() == ''
                
                if self.quality_rules['format']['heading_blank_lines']:
                    if not has_blank_before:
                        issues.append(DocIssue(
                            file_path=str(file_path),
                            line_number=i,
                            issue_type='heading_format',
                            severity='minor',
                            message='标题前缺少空行',
                            suggestion='在标题前添加空行'
                        ))
                        score -= 5
                    
                    if not has_blank_after:
                        issues.append(DocIssue(
                            file_path=str(file_path),
                            line_number=i,
                            issue_type='heading_format',
                            severity='minor',
                            message='标题后缺少空行',
                            suggestion='在标题后添加空行'
                        ))
                        score -= 5
        
        return score, issues
    
    def check_table_format(self, file_path: Path, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查表格格式"""
        issues = []
        score = 100.0
        
        for i, line in enumerate(lines, 1):
            if '|' in line and line.strip().startswith('|'):
                # 检查表格格式
                cells = [cell.strip() for cell in line.split('|')]
                if len(cells) < 3:  # 至少需要 | 内容 | 
                    issues.append(DocIssue(
                        file_path=str(file_path),
                        line_number=i,
                        issue_type='table_format',
                        severity='minor',
                        message='表格格式不正确',
                        suggestion='确保表格行格式为 | 单元格1 | 单元格2 |'
                    ))
                    score -= 10
        
        return score, issues
    
    def check_link_format(self, file_path: Path, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查链接格式"""
        issues = []
        score = 100.0
        
        for i, line in enumerate(lines, 1):
            # 检查Markdown链接格式
            markdown_links = re.findall(r'\[([^\]]+)\]\(([^)]+)\)', line)
            for text, url in markdown_links:
                if not url.startswith('http') and not url.startswith('#'):
                    # 检查内部链接
                    if not url.endswith('.md'):
                        issues.append(DocIssue(
                            file_path=str(file_path),
                            line_number=i,
                            issue_type='link_format',
                            severity='minor',
                            message=f'内部链接格式不正确: {url}',
                            suggestion='确保内部链接指向.md文件'
                        ))
                        score -= 5
        
        return score, issues
    
    def check_structure_quality(self, file_path: Path, content: str, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查结构质量"""
        issues = []
        score = 100.0
        
        # 检查文件大小
        file_size = len(content.encode('utf-8'))
        max_size = self.quality_rules['structure']['max_file_size']
        
        if file_size > max_size:
            issues.append(DocIssue(
                file_path=str(file_path),
                line_number=1,
                issue_type='large_file',
                severity='minor',
                message=f'文件过大: {file_size} > {max_size}',
                suggestion='考虑拆分大文件或精简内容'
            ))
            score -= 20
        
        # 检查章节数量
        sections = re.findall(r'^## ', content, re.MULTILINE)
        min_sections = self.quality_rules['structure']['min_sections']
        
        if len(sections) < min_sections:
            issues.append(DocIssue(
                file_path=str(file_path),
                line_number=1,
                issue_type='few_sections',
                severity='minor',
                message=f'章节数量不足: {len(sections)} < {min_sections}',
                suggestion=f'添加更多章节，至少{min_sections}个'
            ))
            score -= 15
        
        # 检查逻辑顺序
        order_score, order_issues = self.check_logical_order(file_path, content, lines)
        score += order_score * 0.3
        issues.extend(order_issues)
        
        return min(score, 100), issues
    
    def check_logical_order(self, file_path: Path, content: str, lines: List[str]) -> Tuple[float, List[DocIssue]]:
        """检查逻辑顺序"""
        issues = []
        score = 100.0
        
        # 定义期望的章节顺序
        expected_order = [
            '## 🎯 组件概述',
            '## 🚀 基础用法',
            '## 🎨 样式定制',
            '## 🎛️ API 参考',
            '## 🏆 最佳实践',
            '## 🔄 相关组件',
            '## 📝 更新日志'
        ]
        
        # 查找实际章节
        actual_sections = []
        for line in lines:
            if line.startswith('## '):
                actual_sections.append(line)
        
        # 检查顺序
        for i, expected in enumerate(expected_order):
            if expected in actual_sections:
                expected_index = actual_sections.index(expected)
                
                # 检查是否有更重要的章节在后面
                for j in range(i + 1, len(expected_order)):
                    if expected_order[j] in actual_sections:
                        later_index = actual_sections.index(expected_order[j])
                        if later_index < expected_index:
                            issues.append(DocIssue(
                                file_path=str(file_path),
                                line_number=lines.index(expected) + 1,
                                issue_type='logical_order',
                                severity='minor',
                                message=f'章节顺序不合理: {expected} 应该在 {expected_order[j]} 之后',
                                suggestion='调整章节顺序，符合逻辑流程'
                            ))
                            score -= 10
                            break
        
        return score, issues
    
    def check_all_files(self):
        """检查所有文件质量"""
        markdown_files = self.find_markdown_files()
        
        for file_path in markdown_files:
            print(f"检查文件: {file_path}")
            score = self.check_file_quality(file_path)
            self.scores.append(score)
            self.issues.extend(score.issues)
    
    def generate_quality_report(self):
        """生成质量报告"""
        # 统计信息
        total_files = len(self.scores)
        files_with_issues = len([s for s in self.scores if s.issues])
        total_issues = len(self.issues)
        
        # 按严重程度统计
        severity_counts = {}
        for issue in self.issues:
            severity = issue.severity
            severity_counts[severity] = severity_counts.get(severity, 0) + 1
        
        # 按问题类型统计
        type_counts = {}
        for issue in self.issues:
            issue_type = issue.issue_type
            type_counts[issue_type] = type_counts.get(issue_type, 0) + 1
        
        # 计算平均分
        avg_score = sum(s.total_score for s in self.scores) / len(self.scores) if self.scores else 0
        
        # 生成报告
        report = {
            'summary': {
                'total_files': total_files,
                'files_with_issues': files_with_issues,
                'total_issues': total_issues,
                'average_score': avg_score,
                'quality_grade': self.get_quality_grade(avg_score)
            },
            'severity_breakdown': severity_counts,
            'issue_type_breakdown': type_counts,
            'file_scores': [
                {
                    'file_path': score.file_path,
                    'total_score': score.total_score,
                    'content_score': score.content_score,
                    'format_score': score.format_score,
                    'structure_score': score.structure_score,
                    'issue_count': len(score.issues)
                }
                for score in self.scores
            ],
            'issues': [
                {
                    'file_path': issue.file_path,
                    'line_number': issue.line_number,
                    'issue_type': issue.issue_type,
                    'severity': issue.severity,
                    'message': issue.message,
                    'suggestion': issue.suggestion
                }
                for issue in self.issues
            ],
            'recommendations': self.generate_recommendations()
        }
        
        # 保存报告
        with open('docs-quality-report.json', 'w', encoding='utf-8') as f:
            json.dump(report, f, ensure_ascii=False, indent=2)
        
        # 生成人类可读的报告
        self.generate_human_readable_report(report)
        
        print(f"质量检查完成!")
        print(f"总文件数: {total_files}")
        print(f"有问题的文件: {files_with_issues}")
        print(f"总问题数: {total_issues}")
        print(f"平均质量分: {avg_score:.1f}")
        print(f"质量等级: {self.get_quality_grade(avg_score)}")
        print("详细报告已保存到 docs-quality-report.json")
    
    def get_quality_grade(self, score: float) -> str:
        """获取质量等级"""
        if score >= 90:
            return "优秀"
        elif score >= 80:
            return "良好"
        elif score >= 70:
            return "中等"
        elif score >= 60:
            return "及格"
        else:
            return "不及格"
    
    def generate_recommendations(self) -> List[str]:
        """生成改进建议"""
        recommendations = []
        
        # 基于问题类型的建议
        type_counts = {}
        for issue in self.issues:
            issue_type = issue.issue_type
            type_counts[issue_type] = type_counts.get(issue_type, 0) + 1
        
        if 'missing_frontmatter' in type_counts:
            recommendations.append("为所有文档添加frontmatter，包含title、description、version等信息")
        
        if 'missing_sections' in type_counts:
            recommendations.append("确保所有组件文档都包含必需的章节：组件概述、基础用法、样式定制、API参考、最佳实践")
        
        if 'insufficient_code_examples' in type_counts:
            recommendations.append("为每个组件添加至少3个代码示例，涵盖不同使用场景")
        
        if 'long_lines' in type_counts:
            recommendations.append("将过长的行拆分为多行，每行不超过120个字符")
        
        if 'heading_format' in type_counts:
            recommendations.append("确保标题前后有空行，保持格式统一")
        
        if 'link_format' in type_counts:
            recommendations.append("统一链接格式，确保内部链接指向正确的.md文件")
        
        return recommendations
    
    def generate_human_readable_report(self, report: Dict):
        """生成人类可读的报告"""
        report_content = f"""# ZephyrUI 文档质量检查报告

**检查时间**: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}  
**检查文件数**: {report['summary']['total_files']}  
**有问题的文件**: {report['summary']['files_with_issues']}  
**总问题数**: {report['summary']['total_issues']}  
**平均质量分**: {report['summary']['average_score']:.1f}  
**质量等级**: {report['summary']['quality_grade']}

## 📊 质量统计

### 问题严重程度分布
"""
        
        for severity, count in report['severity_breakdown'].items():
            report_content += f"- **{severity}**: {count} 个问题\n"
        
        report_content += "\n### 问题类型分布\n"
        
        for issue_type, count in report['issue_type_breakdown'].items():
            report_content += f"- **{issue_type}**: {count} 个问题\n"
        
        report_content += "\n## 📈 文件质量评分\n\n"
        
        for file_score in report['file_scores']:
            grade = self.get_quality_grade(file_score['total_score'])
            report_content += f"### {file_score['file_path']}\n"
            report_content += f"- **总分**: {file_score['total_score']:.1f} ({grade})\n"
            report_content += f"- **内容分**: {file_score['content_score']:.1f}\n"
            report_content += f"- **格式分**: {file_score['format_score']:.1f}\n"
            report_content += f"- **结构分**: {file_score['structure_score']:.1f}\n"
            report_content += f"- **问题数**: {file_score['issue_count']}\n\n"
        
        report_content += "## 🔧 改进建议\n\n"
        
        for i, recommendation in enumerate(report['recommendations'], 1):
            report_content += f"{i}. {recommendation}\n"
        
        report_content += "\n## 📋 详细问题列表\n\n"
        
        for issue in report['issues']:
            report_content += f"### {issue['file_path']}:{issue['line_number']}\n"
            report_content += f"**类型**: {issue['issue_type']}  \n"
            report_content += f"**严重程度**: {issue['severity']}  \n"
            report_content += f"**问题**: {issue['message']}  \n"
            report_content += f"**建议**: {issue['suggestion']}\n\n"
        
        # 保存人类可读报告
        with open('docs-quality-report.md', 'w', encoding='utf-8') as f:
            f.write(report_content)
        
        print("人类可读报告已保存到 docs-quality-report.md")

def main():
    """主函数"""
    print("开始检查ZephyrUI文档质量...")
    
    checker = DocsQualityChecker()
    
    # 检查所有文件
    checker.check_all_files()
    
    # 生成质量报告
    checker.generate_quality_report()
    
    print("文档质量检查完成!")

if __name__ == "__main__":
    main()