#!/usr/bin/env python3
"""
Flutter UI 组件库重组脚本
重新组织文件夹结构，合并分类，删除不需要的组件
"""

import os
import shutil
import sys
from pathlib import Path

# 基础路径
BASE_DIR = Path("/Users/zfkc/Desktop/03-移动端项目/flutter-ui/lib/src/components")
COMPONENTS_DIR = BASE_DIR

# 新的文件夹结构
NEW_STRUCTURE = {
    "basic": {
        "description": "基础组件",
        "components": [
            "button", "text", "icon", "badge", "avatar", "divider", "card", "chip"
        ],
        "source_dirs": ["basic"]
    },
    "display": {
        "description": "展示组件",
        "components": [
            "timeline", "calendar", "list", "table", "statistic", "grid", "charts", 
            "carousel", "data_table", "tree_view"
        ],
        "source_dirs": ["data_display"]
    },
    "form": {
        "description": "表单组件",
        "components": [
            "input", "select", "checkbox", "radio", "switch", "slider", 
            "date_picker", "time_picker", "text_area", "rating", "auto_complete", 
            "color_picker", "file_upload", "signature", "checkbox_group", "radio_group"
        ],
        "source_dirs": ["forms", "input_advanced"]
    },
    "navigation": {
        "description": "导航组件",
        "components": [
            "tabs", "stepper", "pagination", "side_menu", "navigation_rail", 
            "bottom_navigation_bar", "tree"
        ],
        "source_dirs": ["navigation"],
        "exclude": ["breadcrumb"]  # 删除breadcrumb组件
    },
    "feedback": {
        "description": "反馈组件",
        "components": [
            "alert", "toast", "modal", "progress", "skeleton", "tour"
        ],
        "source_dirs": ["feedback"]
    },
    "layout": {
        "description": "布局组件",
        "components": [
            "grid", "container", "accordion"
        ],
        "source_dirs": ["layout"]
    }
}

# 需要删除的目录
DELETE_DIRS = ["media", "utilities", "error_handling"]

def log(message):
    """打印日志"""
    print(f"[重组脚本] {message}")

def backup_directory():
    """备份当前组件目录"""
    backup_dir = BASE_DIR.parent / "components_backup"
    if backup_dir.exists():
        shutil.rmtree(backup_dir)
    shutil.copytree(COMPONENTS_DIR, backup_dir)
    log(f"已备份到: {backup_dir}")
    return backup_dir

def clean_target_directories():
    """清理目标目录"""
    for category in NEW_STRUCTURE.keys():
        target_dir = COMPONENTS_DIR / category
        if target_dir.exists():
            shutil.rmtree(target_dir)
            log(f"清理目录: {target_dir}")

def move_components():
    """移动组件到新的目录结构"""
    for category, config in NEW_STRUCTURE.items():
        target_dir = COMPONENTS_DIR / category
        target_dir.mkdir(exist_ok=True)
        
        log(f"处理分类: {category} ({config['description']})")
        
        # 从源目录移动组件
        for source_dir in config["source_dirs"]:
            source_path = COMPONENTS_DIR / source_dir
            if not source_path.exists():
                log(f"源目录不存在: {source_path}")
                continue
                
            # 移动组件
            for component_dir in source_path.iterdir():
                if component_dir.is_dir():
                    component_name = component_dir.name
                    
                    # 检查是否在排除列表中
                    if "exclude" in config and component_name in config["exclude"]:
                        log(f"跳过排除的组件: {component_name}")
                        continue
                        
                    # 检查是否在组件列表中
                    if component_name in config["components"] or len(config["components"]) == 0:
                        target_component_dir = target_dir / component_name
                        shutil.copytree(component_dir, target_component_dir)
                        log(f"移动组件: {component_name} -> {target_component_dir}")

def delete_unnecessary_directories():
    """删除不需要的目录"""
    for dir_name in DELETE_DIRS:
        dir_path = COMPONENTS_DIR / dir_name
        if dir_path.exists():
            shutil.rmtree(dir_path)
            log(f"删除目录: {dir_path}")
    
    # 删除breadcrumb组件
    breadcrumb_path = COMPONENTS_DIR / "navigation" / "breadcrumb"
    if breadcrumb_path.exists():
        shutil.rmtree(breadcrumb_path)
        log(f"删除breadcrumb组件: {breadcrumb_path}")

def create_index_files():
    """创建index.dart文件"""
    for category, config in NEW_STRUCTURE.items():
        target_dir = COMPONENTS_DIR / category
        index_file = target_dir / "index.dart"
        
        # 收集所有组件的导出
        exports = []
        for component_dir in target_dir.iterdir():
            if component_dir.is_dir():
                component_index = component_dir / "index.dart"
                if component_index.exists():
                    relative_path = f"{component_dir.name}/index.dart"
                    exports.append(f"export '{relative_path}';")
        
        # 写入index.dart文件
        if exports:
            exports.sort()
            header = f"// {category} 组件库"
            description = f"// {config['description']}"
            content = f"""{header}
{description}

{chr(10).join(exports)}
"""
            index_file.write_text(content, encoding='utf-8')
            log(f"创建index文件: {index_file}")

def update_main_exports():
    """更新主要的exports.dart文件"""
    exports_file = COMPONENTS_DIR / "exports.dart"
    
    exports = []
    for category in NEW_STRUCTURE.keys():
        category_index = f"{category}/index.dart"
        exports.append(f"export '{category_index}';")
    
    content = f"""// ZephyrUI 组件库导出
// 统一导出所有组件

{chr(10).join(exports)}
"""
    exports_file.write_text(content, encoding='utf-8')
    log(f"更新主导出文件: {exports_file}")

def update_pubspec_version():
    """更新pubspec.yaml版本"""
    pubspec_file = BASE_DIR.parent.parent / "pubspec.yaml"
    if pubspec_file.exists():
        content = pubspec_file.read_text(encoding='utf-8')
        # 将版本从0.4.0改为0.3.0
        content = content.replace('version: 0.4.0', 'version: 0.3.0')
        pubspec_file.write_text(content, encoding='utf-8')
        log(f"更新pubspec.yaml版本为0.3.0")

def update_changelog():
    """更新CHANGELOG.md"""
    changelog_file = BASE_DIR.parent.parent / "CHANGELOG.md"
    if changelog_file.exists():
        content = changelog_file.read_text(encoding='utf-8')
        
        # 合并0.3.0和0.4.0的变更记录
        old_030 = """## [0.3.0] - 2025-08-25

### 重大变更

- 重构依赖结构，移除43个依赖中的冲突包
- 优化包大小，减少70-80%的依赖负担
- 简化核心组件，提供最小化可用版本
- 改善 pub.dev 发布兼容性

### 新增功能

- 添加 ZephyrButton、ZephyrText、ZephyrInput、ZephyrContainer 基础组件
- 完善包元数据和主题分类
- 添加发布者验证准备

### 修复

- 解决依赖冲突问题
- 修复代码分析错误
- 统一项目结构"""

        old_040 = """## [0.4.0] - 2025-08-25

### 重大变更

- 统一组件命名规范，所有组件使用 `Zephyr` 前缀
- 重构项目结构，移除冗余的 `src` 目录层级
- 更新所有文档和示例代码，使用新的命名规范
- 完善主题系统，支持更灵活的主题配置

### 新增功能

- 添加 ZephyrButton、ZephyrText、ZephyrInput、ZephyrContainer 基础组件
- 完善包元数据和主题分类
- 添加发布者验证准备
- 新增命名规范文档和迁移指南

### 修复

- 解决依赖冲突问题
- 修复代码分析错误
- 统一项目结构
- 更新所有组件引用和导入路径"""

        new_030 = """## [0.3.0] - 2025-08-25

### 重大变更

- 重构依赖结构，移除43个依赖中的冲突包
- 优化包大小，减少70-80%的依赖负担
- 简化核心组件，提供最小化可用版本
- 改善 pub.dev 发布兼容性
- 统一组件命名规范，所有组件使用 `Zephyr` 前缀
- 重构项目结构，移除冗余的 `src` 目录层级
- 重新组织文件夹结构，合并为6个主要分类
- 删除不必要的组件分类（media、utilities、error_handling等）
- 删除breadcrumb组件

### 新增功能

- 添加 ZephyrButton、ZephyrText、ZephyrInput、ZephyrContainer 基础组件
- 完善包元数据和主题分类
- 添加发布者验证准备
- 新增命名规范文档和迁移指南
- 重新组织组件分类结构：
  - basic: 基础组件（button、text、icon、badge等）
  - display: 展示组件（timeline、calendar、table、charts等）
  - form: 表单组件（input、select、checkbox、date_picker等）
  - navigation: 导航组件（tabs、stepper、pagination、tree等）
  - feedback: 反馈组件（alert、toast、modal、progress等）
  - layout: 布局组件（grid、container、accordion等）

### 修复

- 解决依赖冲突问题
- 修复代码分析错误
- 统一项目结构
- 更新所有组件引用和导入路径
- 优化组件组织结构，提高可维护性"""

        # 替换内容
        content = content.replace(old_030, new_030)
        content = content.replace(old_040, "")
        
        changelog_file.write_text(content, encoding='utf-8')
        log(f"更新CHANGELOG.md文件")

def check_missing_components():
    """检查缺失的组件"""
    log("检查缺失的组件...")
    
    for category, config in NEW_STRUCTURE.items():
        target_dir = COMPONENTS_DIR / category
        existing_components = [d.name for d in target_dir.iterdir() if d.is_dir()]
        
        for component in config["components"]:
            if component not in existing_components:
                log(f"缺失组件: {category}/{component}")
                
                # 创建基础组件目录结构
                component_dir = target_dir / component
                component_dir.mkdir(exist_ok=True)
                
                # 创建基础的组件文件
                component_file = component_dir / f"{component}.dart"
                theme_file = component_dir / f"{component}_theme.dart"
                index_file = component_dir / "index.dart"
                
                # 创建基础的组件模板
                if component == "avatar":
                    create_avatar_component(component_dir)
                elif component == "calendar":
                    create_calendar_component(component_dir)
                elif component == "timeline":
                    create_timeline_component(component_dir)
                elif component == "statistic":
                    create_statistic_component(component_dir)
                elif component == "stepper":
                    create_stepper_component(component_dir)
                elif component == "list":
                    create_list_component(component_dir)
                
                log(f"创建基础组件: {component}")

def create_avatar_component(component_dir):
    """创建avatar组件"""
    component_file = component_dir / "avatar.dart"
    theme_file = component_dir / "avatar_theme.dart"
    index_file = component_dir / "index.dart"
    
    component_content = """import 'package:flutter/material.dart';
import 'avatar_theme.dart';

class ZephyrAvatar extends StatelessWidget {
  const ZephyrAvatar({
    super.key,
    required this.child,
    this.size = 40,
    this.backgroundColor,
    this.onTap,
  });

  final Widget child;
  final double size;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? 
        theme.colorScheme.primary.withOpacity(0.1);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
"""
    
    theme_content = """import 'package:flutter/material.dart';

class ZephyrAvatarTheme {
  const ZephyrAvatarTheme({
    this.defaultSize = 40,
    this.smallSize = 32,
    this.largeSize = 56,
  });

  final double defaultSize;
  final double smallSize;
  final double largeSize;
}
"""
    
    index_content = """export 'avatar.dart';
export 'avatar_theme.dart';
"""
    
    component_file.write_text(component_content, encoding='utf-8')
    theme_file.write_text(theme_content, encoding='utf-8')
    index_file.write_text(index_content, encoding='utf-8')

def create_calendar_component(component_dir):
    """创建calendar组件"""
    component_file = component_dir / "calendar.dart"
    theme_file = component_dir / "calendar_theme.dart"
    index_file = component_dir / "index.dart"
    
    component_content = """import 'package:flutter/material.dart';
import 'calendar_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class ZephyrCalendar extends StatefulWidget {
  const ZephyrCalendar({
    super.key,
    this.selectedDay,
    this.onDaySelected,
    this.firstDay,
    this.lastDay,
    this.focusedDay,
  });

  final DateTime? selectedDay;
  final Function(DateTime, DateTime)? onDaySelected;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final DateTime? focusedDay;

  @override
  State<ZephyrCalendar> createState() => _ZephyrCalendarState();
}

class _ZephyrCalendarState extends State<ZephyrCalendar> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay ?? DateTime.now();
    _selectedDay = widget.selectedDay ?? DateTime.now();
    _firstDay = widget.firstDay ?? DateTime(DateTime.now().year - 1);
    _lastDay = widget.lastDay ?? DateTime(DateTime.now().year + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TableCalendar(
        firstDay: _firstDay,
        lastDay: _lastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: widget.onDaySelected ?? (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
"""
    
    theme_content = """import 'package:flutter/material.dart';

class ZephyrCalendarTheme {
  const ZephyrCalendarTheme({
    this.headerStyle,
    this.daysOfWeekStyle,
    this.calendarStyle,
  });

  final HeaderStyle? headerStyle;
  final DaysOfWeekStyle? daysOfWeekStyle;
  final CalendarStyle? calendarStyle;
}
"""
    
    index_content = """export 'calendar.dart';
export 'calendar_theme.dart';
"""
    
    component_file.write_text(component_content, encoding='utf-8')
    theme_file.write_text(theme_content, encoding='utf-8')
    index_file.write_text(index_content, encoding='utf-8')

def create_timeline_component(component_dir):
    """创建timeline组件"""
    component_file = component_dir / "timeline.dart"
    theme_file = component_dir / "timeline_theme.dart"
    index_file = component_dir / "index.dart"
    
    component_content = """import 'package:flutter/material.dart';
import 'timeline_theme.dart';

class ZephyrTimelineItem {
  const ZephyrTimelineItem({
    required this.title,
    required this.subtitle,
    this.icon,
    this.color,
  });

  final String title;
  final String subtitle;
  final IconData? icon;
  final Color? color;
}

class ZephyrTimeline extends StatelessWidget {
  const ZephyrTimeline({
    super.key,
    required this.items,
    this.isReversed = false,
  });

  final List<ZephyrTimelineItem> items;
  final bool isReversed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveItems = isReversed ? items.reversed.toList() : items;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: effectiveItems.length,
      itemBuilder: (context, index) {
        final item = effectiveItems[index];
        final isLast = index == effectiveItems.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: item.color ?? theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: item.icon != null
                      ? Icon(
                          item.icon,
                          size: 10,
                          color: Colors.white,
                        )
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: theme.textTheme.bodySmall,
                  ),
                  if (!isLast) const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
"""
    
    theme_content = """import 'package:flutter/material.dart';

class ZephyrTimelineTheme {
  const ZephyrTimelineTheme({
    this.dotSize = 16,
    this.lineColor,
    this.spacing = 24,
  });

  final double dotSize;
  final Color? lineColor;
  final double spacing;
}
"""
    
    index_content = """export 'timeline.dart';
export 'timeline_theme.dart';
"""
    
    component_file.write_text(component_content, encoding='utf-8')
    theme_file.write_text(theme_content, encoding='utf-8')
    index_file.write_text(index_content, encoding='utf-8')

def create_statistic_component(component_dir):
    """创建statistic组件"""
    component_file = component_dir / "statistic.dart"
    theme_file = component_dir / "statistic_theme.dart"
    index_file = component_dir / "index.dart"
    
    component_content = """import 'package:flutter/material.dart';
import 'statistic_theme.dart';

class ZephyrStatistic extends StatelessWidget {
  const ZephyrStatistic({
    super.key,
    required this.title,
    required this.value,
    this.suffix,
    this.prefix,
    this.description,
    this.trend,
    this.color,
  });

  final String title;
  final String value;
  final String? suffix;
  final String? prefix;
  final String? description;
  final String? trend;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                if (prefix != null)
                  Text(
                    prefix!,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: effectiveColor,
                    ),
                  ),
                Text(
                  value,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: effectiveColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (suffix != null)
                  Text(
                    suffix!,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: effectiveColor,
                    ),
                  ),
              ],
            ),
            if (trend != null || description != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  if (trend != null)
                    Text(
                      trend!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: trend!.startsWith('+') 
                            ? Colors.green 
                            : Colors.red,
                      ),
                    ),
                  if (description != null) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
"""
    
    theme_content = """import 'package:flutter/material.dart';

class ZephyrStatisticTheme {
  const ZephyrStatisticTheme({
    this.titleStyle,
    this.valueStyle,
    this.descriptionStyle,
    this.cardPadding = const EdgeInsets.all(16),
  });

  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsetsGeometry cardPadding;
}
"""
    
    index_content = """export 'statistic.dart';
export 'statistic_theme.dart';
"""
    
    component_file.write_text(component_content, encoding='utf-8')
    theme_file.write_text(theme_content, encoding='utf-8')
    index_file.write_text(index_content, encoding='utf-8')

def create_stepper_component(component_dir):
    """创建stepper组件"""
    component_file = component_dir / "stepper.dart"
    theme_file = component_dir / "stepper_theme.dart"
    index_file = component_dir / "index.dart"
    
    component_content = """import 'package:flutter/material.dart';
import 'stepper_theme.dart';

class ZephyrStep {
  const ZephyrStep({
    required this.title,
    required this.content,
    this.subtitle,
    this.isActive = false,
    this.isCompleted = false,
  });

  final String title;
  final String? subtitle;
  final Widget content;
  final bool isActive;
  final bool isCompleted;
}

class ZephyrStepper extends StatelessWidget {
  const ZephyrStepper({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.onStepTapped,
  });

  final List<ZephyrStep> steps;
  final int currentStep;
  final Function(int)? onStepTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 步骤指示器
        Row(
          children: List.generate(steps.length, (index) {
            final step = steps[index];
            final isCompleted = index < currentStep;
            final isActive = index == currentStep;

            return Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onStepTapped != null ? () => onStepTapped!(index) : null,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isCompleted || isActive
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  if (index < steps.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isCompleted
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        // 当前步骤内容
        if (currentStep < steps.length)
          steps[currentStep].content,
      ],
    );
  }
}
"""
    
    theme_content = """import 'package:flutter/material.dart';

class ZephyrStepperTheme {
  const ZephyrStepperTheme({
    this.stepSize = 32,
    this.lineHeight = 2,
    this.spacing = 24,
  });

  final double stepSize;
  final double lineHeight;
  final double spacing;
}
"""
    
    index_content = """export 'stepper.dart';
export 'stepper_theme.dart';
"""
    
    component_file.write_text(component_content, encoding='utf-8')
    theme_file.write_text(theme_content, encoding='utf-8')
    index_file.write_text(index_content, encoding='utf-8')

def create_list_component(component_dir):
    """创建list组件"""
    component_file = component_dir / "list.dart"
    theme_file = component_dir / "list_theme.dart"
    index_file = component_dir / "index.dart"
    
    component_content = """import 'package:flutter/material.dart';
import 'list_theme.dart';

class ZephyrListItem {
  const ZephyrListItem({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
}

class ZephyrList extends StatelessWidget {
  const ZephyrList({
    super.key,
    required this.items,
    this.padding,
    this.shrinkWrap = true,
    this.physics,
  });

  final List<ZephyrListItem> items;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: item.leading,
          title: Text(item.title),
          subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
          trailing: item.trailing,
          onTap: item.onTap,
          onLongPress: item.onLongPress,
        );
      },
    );
  }
}

class ZephyrListView extends StatelessWidget {
  const ZephyrListView({
    super.key,
    required this.children,
    this.padding,
    this.shrinkWrap = true,
    this.physics,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: children,
    );
  }
}
"""
    
    theme_content = """import 'package:flutter/material.dart';

class ZephyrListTheme {
  const ZephyrListTheme({
    this.tilePadding,
    this.contentPadding,
    this.horizontalTitleGap = 16,
    this.minVerticalPadding = 8,
  });

  final EdgeInsetsGeometry? tilePadding;
  final EdgeInsetsGeometry? contentPadding;
  final double horizontalTitleGap;
  final double minVerticalPadding;
}
"""
    
    index_content = """export 'list.dart';
export 'list_theme.dart';
"""
    
    component_file.write_text(component_content, encoding='utf-8')
    theme_file.write_text(theme_content, encoding='utf-8')
    index_file.write_text(index_content, encoding='utf-8')

def main():
    """主函数"""
    log("开始重组Flutter UI组件库...")
    
    try:
        # 备份当前目录
        backup_dir = backup_directory()
        
        # 清理目标目录
        clean_target_directories()
        
        # 移动组件
        move_components()
        
        # 删除不需要的目录
        delete_unnecessary_directories()
        
        # 创建index文件
        create_index_files()
        
        # 更新主导出文件
        update_main_exports()
        
        # 更新版本号
        update_pubspec_version()
        
        # 更新变更日志
        update_changelog()
        
        # 检查缺失组件
        check_missing_components()
        
        log("组件库重组完成!")
        log(f"备份目录: {backup_dir}")
        
    except Exception as e:
        log(f"重组过程中发生错误: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()