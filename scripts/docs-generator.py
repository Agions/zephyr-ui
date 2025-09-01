#!/usr/bin/env python3
"""
ZephyrUI 文档自动生成工具
根据代码自动生成组件文档
"""

import os
import re
import json
from pathlib import Path
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass
from datetime import datetime

@dataclass
class ComponentInfo:
    """组件信息"""
    name: str
    type: str
    description: str
    properties: List[Dict]
    methods: List[Dict]
    examples: List[str]
    category: str
    file_path: str

class DocsGenerator:
    def __init__(self, lib_dir: str = "lib/src/components", docs_dir: str = "doc/components"):
        self.lib_dir = Path(lib_dir)
        self.docs_dir = Path(docs_dir)
        self.components = []
        self.templates = self.load_templates()

    def load_templates(self) -> Dict[str, str]:
        """加载文档模板"""
        templates = {
            'component': """---
title: {name} {type}
description: {description}
version: 1.0.0
last_updated: {date}
---

# {name} {type}

{description}

## 🎯 组件概述

### 特性
{features}

### 适用场景
{scenarios}

## 🚀 基础用法

### 基本使用

```dart
{basic_example}
```

## 🎨 样式定制

### 自定义样式

```dart
{style_example}
```

## 🎛️ API 参考

### 构造函数

```dart
{constructor}
```

**参数说明：**
{properties_docs}

### 主要属性

| 属性 | 类型 | 描述 | 默认值 |
|------|------|------|--------|
{properties_table}

## 🏆 最佳实践

### 推荐用法

```dart
{best_practice_example}
```

### 避免用法

```dart
{avoid_example}
```

## 🔄 相关组件

{related_components}

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基础功能
- ✅ 完整的主题支持

---

**组件路径**: `{file_path}`
**示例路径**: `example/lib/components/{name}_demo.dart`
**文档版本**: 1.0.0
**最后更新**: {date}
""",
            'readme': """---
title: {category_name} 组件
description: ZephyrUI {category_name} 组件总览
version: 1.0.0
last_updated: {date}
---

# {category_name} 组件

{category_description}

## 📋 组件列表

{components_list}

## 🎯 选择指南

{selection_guide}

## 📚 相关文档

- [组件总览](../README.md)
- [API 参考](../api/components.md)
- [最佳实践](../guides/best-practices.md)

---

**文档版本**: 1.0.0
**最后更新**: {date}
"""
        }
        return templates

    def find_component_files(self) -> List[Path]:
        """查找组件文件"""
        component_files = []

        # 查找所有Dart文件
        for dart_file in self.lib_dir.rglob("*.dart"):
            if dart_file.name.endswith(".dart") and not dart_file.name.startswith("_"):
                component_files.append(dart_file)

        return component_files

    def parse_component_file(self, file_path: Path) -> Optional[ComponentInfo]:
        """解析组件文件"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # 提取组件类名
            class_match = re.search(r'class\s+(\w+).*extends.*StatelessWidget|StatefulWidget', content)
            if not class_match:
                return None

            class_name = class_match.group(1)

            # 提取组件描述
            description_match = re.search(r'///\s*(.+)', content)
            description = description_match.group(1) if description_match else f"{class_name} 组件"

            # 确定组件类型
            component_type = self.get_component_type(class_name)

            # 确定组件类别
            category = self.get_component_category(file_path)

            # 提取属性
            properties = self.extract_properties(content)

            # 提取方法
            methods = self.extract_methods(content)

            # 生成示例
            examples = self.generate_examples(class_name, properties)

            return ComponentInfo(
                name=class_name,
                type=component_type,
                description=description,
                properties=properties,
                methods=methods,
                examples=examples,
                category=category,
                file_path=str(file_path)
            )

        except Exception as e:
            print(f"解析文件 {file_path} 时出错: {e}")
            return None

    def get_component_type(self, class_name: str) -> str:
        """确定组件类型"""
        if 'Button' in class_name:
            return '按钮'
        elif 'Input' in class_name or 'Field' in class_name:
            return '输入框'
        elif 'Card' in class_name:
            return '卡片'
        elif 'Text' in class_name:
            return '文本'
        elif 'Icon' in class_name:
            return '图标'
        elif 'List' in class_name:
            return '列表'
        elif 'Grid' in class_name:
            return '网格'
        elif 'Tab' in class_name:
            return '标签页'
        elif 'Form' in class_name:
            return '表单'
        else:
            return '组件'

    def get_component_category(self, file_path: Path) -> str:
        """确定组件类别"""
        path_parts = file_path.parts

        if 'basic' in path_parts:
            return 'basic'
        elif 'form' in path_parts:
            return 'form'
        elif 'navigation' in path_parts:
            return 'navigation'
        elif 'display' in path_parts:
            return 'display'
        elif 'feedback' in path_parts:
            return 'feedback'
        elif 'layout' in path_parts:
            return 'layout'
        elif 'advanced' in path_parts:
            return 'advanced'
        else:
            return 'basic'

    def extract_properties(self, content: str) -> List[Dict]:
        """提取组件属性"""
        properties = []

        # 查找构造函数中的参数
        constructor_match = re.search(r'\w+\(.*?\{(.+?)\}', content, re.DOTALL)
        if constructor_match:
            params = constructor_match.group(1)

            # 解析参数
            param_lines = [line.strip() for line in params.split('\n') if line.strip()]

            for line in param_lines:
                # 匹配参数定义
                param_match = re.match(r'(\w+)\s+(.+?),?', line)
                if param_match:
                    param_name = param_match.group(1)
                    param_type = param_match.group(2)

                    # 提取参数描述
                    description_match = re.search(r'///\s*[^\n]*\n.*?\b' + param_name + r'\b[^\n]*\n\s*///\s*(.+)', content, re.DOTALL)
                    description = description_match.group(1) if description_match else ""

                    properties.append({
                        'name': param_name,
                        'type': param_type,
                        'description': description,
                        'required': '?' not in param_type and '=' not in param_type,
                        'default_value': self.extract_default_value(param_type)
                    })

        return properties

    def extract_methods(self, content: str) -> List[Dict]:
        """提取组件方法"""
        methods = []

        # 查找方法定义
        method_matches = re.findall(r'\s+(\w+)\(([^)]*)\)\s*{', content)

        for method_name, params in method_matches:
            if not method_name.startswith('_') and method_name != 'build':
                methods.append({
                    'name': method_name,
                    'parameters': params,
                    'description': f"{method_name} 方法"
                })

        return methods

    def extract_default_value(self, param_type: str) -> str:
        """提取默认值"""
        if '=' in param_type:
            return param_type.split('=')[1].strip()
        return ""

    def generate_examples(self, class_name: str, properties: List[Dict]) -> List[str]:
        """生成示例代码"""
        examples = []

        # 基础示例
        basic_example = f"{class_name}(\n"

        # 添加常用属性
        for prop in properties[:3]:  # 只取前3个属性
            if prop['name'] in ['text', 'label', 'title', 'child']:
                basic_example += f"  {prop['name']}: '示例',\n"
            elif prop['name'] in ['onPressed', 'onTap', 'onClick']:
                basic_example += f"  {prop['name']}: () => print('点击'),\n"

        basic_example += ")"
        examples.append(basic_example)

        return examples

    def generate_component_doc(self, component: ComponentInfo) -> str:
        """生成组件文档"""
        # 生成特性列表
        features = "- **丰富功能**: 提供多种配置选项\n"
        features += "- **主题支持**: 完整的主题系统集成\n"
        features += "- **无障碍**: 支持屏幕阅读器\n"
        features += "- **响应式**: 适配不同屏幕尺寸"

        # 生成适用场景
        scenarios = "- 用户界面构建\n"
        scenarios += "- 数据输入和展示\n"
        scenarios += "- 用户交互处理"

        # 生成属性文档
        properties_docs = ""
        for prop in component.properties:
            properties_docs += f"- `{prop['name']}`: {prop['description']}\n"

        # 生成属性表格
        properties_table = ""
        for prop in component.properties:
            required = "是" if prop['required'] else "否"
            default = prop['default_value'] if prop['default_value'] else "无"
            properties_table += f"| `{prop['name']}` | `{prop['type']}` | {prop['description']} | {default} |\n"

        # 生成基础示例
        basic_example = component.examples[0] if component.examples else f"{component.name}()"

        # 生成样式示例
        style_example = f"{component.name}(\n"
        style_example += "  // 自定义样式\n"
        style_example += "  backgroundColor: Colors.blue,\n"
        style_example += "  textColor: Colors.white,\n"
        style_example += ")"

        # 生成最佳实践示例
        best_practice_example = f"// ✅ 推荐用法\n{basic_example}"

        avoid_example = f"// ❌ 避免用法\n// 不要在没有必要的情况下创建过多组件"

        # 生成相关组件
        related_components = "- [组件总览](../README.md)\n"
        related_components += f"- [{component.category} 组件](../{component.category}/README.md)"

        # 生成构造函数
        constructor = f"const {component.name}({{\n"
        for prop in component.properties[:5]:  # 只显示前5个属性
            required = "required" if prop['required'] else ""
            constructor += f"  {required} this.{prop['name']},\n"
        constructor += "});"

        return self.templates['component'].format(
            name=component.name,
            type=component.type,
            description=component.description,
            features=features,
            scenarios=scenarios,
            basic_example=basic_example,
            style_example=style_example,
            constructor=constructor,
            properties_docs=properties_docs,
            properties_table=properties_table,
            best_practice_example=best_practice_example,
            avoid_example=avoid_example,
            related_components=related_components,
            file_path=component.file_path,
            date=datetime.now().strftime("%Y-%m-%d")
        )

    def generate_category_readme(self, category: str, components: List[ComponentInfo]) -> str:
        """生成类别README"""
        category_names = {
            'basic': '基础',
            'form': '表单',
            'navigation': '导航',
            'display': '显示',
            'feedback': '反馈',
            'layout': '布局',
            'advanced': '高级'
        }

        category_name = category_names.get(category, category)

        # 生成类别描述
        category_descriptions = {
            'basic': '基础组件是构建用户界面的核心元素，包括按钮、文本、图标等。',
            'form': '表单组件用于数据输入和验证，包括输入框、选择器、日期选择器等。',
            'navigation': '导航组件帮助用户在应用中导航，包括标签页、步骤器、面包屑等。',
            'display': '显示组件用于数据展示，包括表格、列表、日历、时间线等。',
            'feedback': '反馈组件为用户提供操作反馈，包括警告框、消息提示、进度指示器等。',
            'layout': '布局组件用于页面布局和结构，包括网格、容器、手风琴等。',
            'advanced': '高级组件提供复杂功能，包括图表、文件上传、颜色选择器等。'
        }

        category_description = category_descriptions.get(category, f'{category_name}组件集合')

        # 生成组件列表
        components_list = ""
        for component in components:
            components_list += f"- [{component.name} {component.type}]({component.name.lower()}.md) - {component.description}\n"

        # 生成选择指南
        selection_guide = f"""
### 何时使用{category_name}组件

{category_name}组件适用于以下场景：

- **基础交互**: 需要{category_name.lower()}交互时
- **数据展示**: 需要展示{category_name.lower()}数据时
- **用户体验**: 需要{category_name.lower()}提升用户体验时

### 组件选择流程

1. **确定需求**: 明确需要什么类型的{category_name.lower()}功能
2. **选择组件**: 根据需求选择合适的{category_name.lower()}组件
3. **定制样式**: 根据设计规范定制组件样式
4. **测试验证**: 确保组件在不同场景下正常工作
"""

        return self.templates['readme'].format(
            category_name=category_name,
            category_description=category_description,
            components_list=components_list,
            selection_guide=selection_guide,
            date=datetime.now().strftime("%Y-%m-%d")
        )

    def create_category_directory(self, category: str) -> Path:
        """创建类别目录"""
        category_dir = self.docs_dir / category
        category_dir.mkdir(parents=True, exist_ok=True)
        return category_dir

    def generate_docs(self):
        """生成所有文档"""
        print("开始生成ZephyrUI文档...")

        # 查找所有组件文件
        component_files = self.find_component_files()
        print(f"找到 {len(component_files)} 个组件文件")

        # 解析组件信息
        for file_path in component_files:
            component = self.parse_component_file(file_path)
            if component:
                self.components.append(component)

        print(f"解析了 {len(self.components)} 个组件")

        # 按类别分组
        categories = {}
        for component in self.components:
            if component.category not in categories:
                categories[component.category] = []
            categories[component.category].append(component)

        # 生成每个类别的文档
        for category, components in categories.items():
            print(f"生成 {category} 类别文档...")

            # 创建类别目录
            category_dir = self.create_category_directory(category)

            # 生成类别README
            readme_content = self.generate_category_readme(category, components)
            readme_path = category_dir / "README.md"
            with open(readme_path, 'w', encoding='utf-8') as f:
                f.write(readme_content)

            # 生成每个组件的文档
            for component in components:
                print(f"  生成 {component.name} 文档...")

                doc_content = self.generate_component_doc(component)
                doc_path = category_dir / f"{component.name.lower()}.md"

                with open(doc_path, 'w', encoding='utf-8') as f:
                    f.write(doc_content)

        # 生成总览文档
        self.generate_overview_doc(categories)

        print("文档生成完成!")

    def generate_overview_doc(self, categories: Dict[str, List[ComponentInfo]]):
        """生成总览文档"""
        overview_content = """---
title: 组件总览
description: ZephyrUI 所有组件的总览和快速导航
version: 1.0.0
last_updated: {date}
---

# ZephyrUI 组件总览

ZephyrUI 提供了丰富的高质量Flutter组件，帮助您快速构建现代化的用户界面。

## 📊 组件统计

- **总组件数**: {total_components}
- **基础组件**: {basic_count}
- **表单组件**: {form_count}
- **导航组件**: {navigation_count}
- **显示组件**: {display_count}
- **反馈组件**: {feedback_count}
- **布局组件**: {layout_count}
- **高级组件**: {advanced_count}

## 🎯 组件分类

""".format(
            date=datetime.now().strftime("%Y-%m-%d"),
            total_components=sum(len(components) for components in categories.values()),
            basic_count=len(categories.get('basic', [])),
            form_count=len(categories.get('form', [])),
            navigation_count=len(categories.get('navigation', [])),
            display_count=len(categories.get('display', [])),
            feedback_count=len(categories.get('feedback', [])),
            layout_count=len(categories.get('layout', [])),
            advanced_count=len(categories.get('advanced', []))
        )

        # 添加各类别组件
        category_names = {
            'basic': '基础组件',
            'form': '表单组件',
            'navigation': '导航组件',
            'display': '显示组件',
            'feedback': '反馈组件',
            'layout': '布局组件',
            'advanced': '高级组件'
        }

        for category, components in categories.items():
            category_name = category_names.get(category, category)
            overview_content += f"""
### {category_name}

{category_name}提供了丰富的功能组件：

"""

            for component in components:
                overview_content += f"- [{component.name} {component.type}]({category}/{component.name.lower()}.md) - {component.description}\n"

            overview_content += "\n"

        # 添加使用指南
        overview_content += """
## 🚀 快速开始

1. **安装依赖**
   ```yaml
   dependencies:
     zephyr_ui: ^0.3.0
   ```

2. **导入组件**
   ```dart
   import 'package:zephyr_ui/zephyr_ui.dart';
   ```

3. **使用组件**
   ```dart
   ZephyrButton.primary(
     text: '点击我',
     onPressed: () {},
   )
   ```

## 📚 相关文档

- [快速开始](../getting-started/quick-start.md)
- [API 参考](../api/components.md)
- [最佳实践](../guides/best-practices.md)
- [故障排除](../guides/troubleshooting.md)

---

**文档版本**: 1.0.0
**最后更新**: {date}
""".format(date=datetime.now().strftime("%Y-%m-%d"))

        # 保存总览文档
        overview_path = self.docs_dir / "README.md"
        with open(overview_path, 'w', encoding='utf-8') as f:
            f.write(overview_content)

def main():
    """主函数"""
    generator = DocsGenerator()
    generator.generate_docs()

if __name__ == "__main__":
    main()
