#!/usr/bin/env python3
"""
ZephyrUI 文档链接检查工具
用于检查和修复文档中的失效链接
"""

import os
import re
import requests
from pathlib import Path
from typing import List, Dict, Tuple
import json
import time

class LinkChecker:
    def __init__(self, docs_dir: str = "doc"):
        self.docs_dir = Path(docs_dir)
        self.broken_links = []
        self.fixed_links = []
        self.link_mapping = {}
        
    def find_markdown_files(self) -> List[Path]:
        """查找所有Markdown文件"""
        return list(self.docs_dir.rglob("*.md"))
    
    def extract_links(self, file_path: Path) -> List[Tuple[str, int]]:
        """提取文件中的所有链接"""
        links = []
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                lines = f.readlines()
                for line_num, line in enumerate(lines, 1):
                    # 匹配 Markdown 链接 [text](url)
                    markdown_links = re.findall(r'\[([^\]]+)\]\(([^)]+)\)', line)
                    for text, url in markdown_links:
                        links.append((url, line_num))
        except Exception as e:
            print(f"读取文件 {file_path} 时出错: {e}")
        return links
    
    def check_internal_link(self, url: str, current_file: Path) -> bool:
        """检查内部链接是否有效"""
        # 处理相对路径
        if url.startswith('./'):
            url = url[2:]
        elif url.startswith('../'):
            # 处理上级目录
            parts = url.split('../')
            base_path = current_file.parent
            for part in parts[1:]:
                if part == '':
                    continue
                if part.endswith('/'):
                    base_path = base_path.parent
                else:
                    base_path = base_path / part
            target_path = base_path
        else:
            target_path = current_file.parent / url
        
        # 移除锚点
        if '#' in str(target_path):
            target_path = str(target_path).split('#')[0]
        
        return target_path.exists()
    
    def check_external_link(self, url: str) -> bool:
        """检查外部链接是否有效"""
        try:
            response = requests.head(url, timeout=10, allow_redirects=True)
            return response.status_code < 400
        except:
            return False
    
    def check_all_links(self):
        """检查所有文档中的链接"""
        markdown_files = self.find_markdown_files()
        
        for file_path in markdown_files:
            print(f"检查文件: {file_path}")
            links = self.extract_links(file_path)
            
            for url, line_num in links:
                if url.startswith('http') or url.startswith('https'):
                    # 外部链接
                    if not self.check_external_link(url):
                        self.broken_links.append({
                            'file': str(file_path),
                            'line': line_num,
                            'url': url,
                            'type': 'external'
                        })
                else:
                    # 内部链接
                    if not self.check_internal_link(url, file_path):
                        self.broken_links.append({
                            'file': str(file_path),
                            'line': line_num,
                            'url': url,
                            'type': 'internal'
                        })
    
    def generate_link_mapping(self):
        """生成链接映射"""
        # 组件映射
        component_mapping = {
            'ZephyrInput': 'doc/components/form/input.md',
            'ZephyrButton': 'doc/components/basic/button.md',
            'ZephyrCard': 'doc/components/basic/card.md',
            'ZephyrText': 'doc/components/basic/text.md',
            'ZephyrIcon': 'doc/components/basic/icon.md',
            'ZephyrAvatar': 'doc/components/basic/avatar.md',
            'ZephyrBadge': 'doc/components/basic/badge.md',
            'ZephyrChip': 'doc/components/basic/chip.md',
            'ZephyrDivider': 'doc/components/basic/divider.md',
            'ZephyrSelect': 'doc/components/form/select.md',
            'ZephyrDatePicker': 'doc/components/form/date_picker.md',
            'ZephyrCheckbox': 'doc/components/form/checkbox.md',
            'ZephyrRadio': 'doc/components/form/radio.md',
            'ZephyrSwitch': 'doc/components/form/switch.md',
            'ZephyrSlider': 'doc/components/form/slider.md',
            'ZephyrRating': 'doc/components/form/rating.md',
            'ZephyrTimePicker': 'doc/components/form/time_picker.md',
            'ZephyrTextArea': 'doc/components/form/text_area.md',
            'ZephyrFormBuilder': 'doc/components/form/form_builder.md',
            'ZephyrTabs': 'doc/components/navigation/tabs.md',
            'ZephyrStepper': 'doc/components/navigation/stepper.md',
            'ZephyrBreadcrumb': 'doc/components/navigation/breadcrumb.md',
            'ZephyrPagination': 'doc/components/navigation/pagination.md',
            'ZephyrBottomNavigationBar': 'doc/components/navigation/bottom_navigation_bar.md',
            'ZephyrSideMenu': 'doc/components/navigation/side_menu.md',
            'ZephyrNavigationRail': 'doc/components/navigation/navigation_rail.md',
            'ZephyrTour': 'doc/components/navigation/tour.md',
            'ZephyrTree': 'doc/components/navigation/tree.md',
            'ZephyrTable': 'doc/components/display/table.md',
            'ZephyrList': 'doc/components/display/list.md',
            'ZephyrCalendar': 'doc/components/display/calendar.md',
            'ZephyrTimeline': 'doc/components/display/timeline.md',
            'ZephyrStatistic': 'doc/components/display/statistic.md',
            'ZephyrCardGrid': 'doc/components/display/card_grid.md',
            'ZephyrDataGrid': 'doc/components/display/data_grid.md',
            'ZephyrProgressIndicators': 'doc/components/display/progress_indicators.md',
            'ZephyrStatusIndicators': 'doc/components/display/status_indicators.md',
            'ZephyrAvatarGroups': 'doc/components/display/avatar_groups.md',
            'ZephyrBadgeDisplays': 'doc/components/display/badge_displays.md',
            'ZephyrTagClouds': 'doc/components/display/tag_clouds.md',
            'ZephyrAlert': 'doc/components/feedback/alert.md',
            'ZephyrToast': 'doc/components/feedback/toast.md',
            'ZephyrProgress': 'doc/components/feedback/progress.md',
            'ZephyrSkeleton': 'doc/components/feedback/skeleton.md',
            'ZephyrModal': 'doc/components/feedback/modal.md',
            'ZephyrGrid': 'doc/components/layout/grid.md',
            'ZephyrContainer': 'doc/components/layout/container.md',
            'ZephyrAccordion': 'doc/components/layout/accordion.md',
            'ZephyrChart': 'doc/components/advanced/chart.md',
            'ZephyrUpload': 'doc/components/advanced/upload.md',
            'ZephyrColorPicker': 'doc/components/advanced/color_picker.md',
            'ZephyrCarousel': 'doc/components/advanced/carousel.md',
            'ZephyrRichEditor': 'doc/components/advanced/rich_editor.md',
            'ZephyrAutocomplete': 'doc/components/advanced/autocomplete.md',
            'ZephyrImageCropper': 'doc/components/advanced/image_cropper.md',
            'ZephyrMediaPlayer': 'doc/components/advanced/media_player.md',
            'ZephyrPDFViewer': 'doc/components/advanced/pdf_viewer.md',
            'ZephyrQRCode': 'doc/components/advanced/qr_code.md',
            'ZephyrSignature': 'doc/components/advanced/signature.md',
            'ZephyrDragDrop': 'doc/components/advanced/drag_drop.md',
            'ZephyrDataVisualization': 'doc/components/advanced/data_visualization.md'
        }
        
        # 指南映射
        guide_mapping = {
            'getting-started': 'doc/guides/getting-started.md',
            'best-practices': 'doc/guides/best-practices.md',
            'performance-optimization': 'doc/guides/performance-optimization.md',
            'design-guidelines': 'doc/guides/design-guidelines.md',
            'accessibility': 'doc/guides/accessibility.md',
            'testing': 'doc/guides/testing.md',
            'theming': 'doc/guides/theming.md',
            'responsive-design': 'doc/guides/responsive-design.md'
        }
        
        self.link_mapping = {**component_mapping, **guide_mapping}
    
    def fix_broken_links(self):
        """修复失效的链接"""
        for broken_link in self.broken_links:
            file_path = broken_link['file']
            line_num = broken_link['line']
            url = broken_link['url']
            
            # 尝试从映射中找到正确的链接
            for key, correct_path in self.link_mapping.items():
                if key.lower() in url.lower():
                    # 修复链接
                    self.fix_link_in_file(file_path, line_num, url, correct_path)
                    self.fixed_links.append({
                        'file': file_path,
                        'line': line_num,
                        'old_url': url,
                        'new_url': correct_path
                    })
                    break
    
    def fix_link_in_file(self, file_path: str, line_num: int, old_url: str, new_url: str):
        """在文件中修复链接"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                lines = f.readlines()
            
            # 修复链接
            line = lines[line_num - 1]
            fixed_line = line.replace(f'({old_url})', f'({new_url})')
            lines[line_num - 1] = fixed_line
            
            with open(file_path, 'w', encoding='utf-8') as f:
                f.writelines(lines)
                
        except Exception as e:
            print(f"修复文件 {file_path} 中的链接时出错: {e}")
    
    def generate_report(self):
        """生成检查报告"""
        report = {
            'total_broken_links': len(self.broken_links),
            'total_fixed_links': len(self.fixed_links),
            'broken_links': self.broken_links,
            'fixed_links': self.fixed_links,
            'link_mapping': self.link_mapping
        }
        
        with open('link-check-report.json', 'w', encoding='utf-8') as f:
            json.dump(report, f, ensure_ascii=False, indent=2)
        
        print(f"发现 {len(self.broken_links)} 个失效链接")
        print(f"修复了 {len(self.fixed_links)} 个链接")
        print("详细报告已保存到 link-check-report.json")

def main():
    """主函数"""
    print("开始检查 ZephyrUI 文档链接...")
    
    checker = LinkChecker()
    
    # 生成链接映射
    checker.generate_link_mapping()
    
    # 检查所有链接
    checker.check_all_links()
    
    # 修复失效链接
    checker.fix_broken_links()
    
    # 生成报告
    checker.generate_report()
    
    print("链接检查完成!")

if __name__ == "__main__":
    main()