# ZephyrUI 文档

<div align="center">

![ZephyrUI Logo](https://img.shields.io/badge/ZephyrUI-v1.0.0-blue?style=for-the-badge&logo=flutter&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**企业级 Flutter UI 组件库**

🚀 **60+ 专业组件** • 🎨 **设计系统** • 📱 **响应式** • ♿ **无障碍** • ⚡ **高性能**


</div>

---

## 📖 目录

- [🚀 快速开始](#-快速开始)
- [📦 安装](#-安装)
- [🎯 核心特性](#-核心特性)
- [🎨 组件](#-组件)
- [🏗️ 架构](️-架构)
- [📚 文档](#-文档)
- [🤝 贡献](#-贡献)
- [📞 支持](#-支持)

---

## 🚀 快速开始

在2分钟内快速上手 ZephyrUI：

### 1. 安装

```bash
# 添加到 pubspec.yaml
dependencies:
  zephyr_ui: ^1.0.0

# 安装依赖
flutter pub get
```

### 2. 基础设置

```dart
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ZephyrApp(
      title: '我的应用',
      theme: ZephyrTheme.light(),
      darkTheme: ZephyrTheme.dark(),
      home: const HomeScreen(),
    );
  }
}
```

### 3. 第一个组件

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 演示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '欢迎使用 ZephyrUI！',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '企业级 Flutter 组件，触手可及。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // 按钮变体
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ZephyrButton.primary(
                  text: '开始使用',
                  onPressed: () => print('主要操作'),
                ),
                ZephyrButton.secondary(
                  text: '了解更多',
                  onPressed: () => print('次要操作'),
                ),
                ZephyrButton.outlined(
                  text: '查看演示',
                  onPressed: () => print('边框操作'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 表单组件
            ZephyrInputField(
              label: '邮箱地址',
              placeholder: '请输入邮箱',
              prefixIcon: const Icon(Icons.email_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入邮箱地址';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return '请输入有效的邮箱地址';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // 卡片组件
            ZephyrCard(
              title: '专业 UI 组件',
              subtitle: '为企业应用而构建',
              content: const Text(
                'ZephyrUI 提供了一套全面的高质量、'
                '无障碍且可定制的 Flutter 组件。',
              ),
              actions: [
                ZephyrButton.text(
                  text: '文档',
                  onPressed: () => print('导航到文档'),
                ),
                ZephyrButton.primary(
                  text: '开始使用',
                  onPressed: () => print('开始使用'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 📦 安装

### 系统要求

- **Flutter**: ^3.0.0
- **Dart**: ^3.0.0
- **iOS**: 12.0+
- **Android**: API 21+

### 添加依赖

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  zephyr_ui: ^1.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  zephyr_ui_dev_tools: ^1.0.0  # 开发工具
```

### 安装和运行

```bash
# 安装依赖
flutter pub get

# 运行示例应用
flutter run -t lib/main.dart

# 运行测试
flutter test
```

---

## 🎯 核心特性

### 🎨 **设计系统**
- **一致的主题**: 所有组件统一的设计语言
- **可定制**: 广泛的主题定制能力
- **暗色模式**: 内置暗色主题支持
- **Material Design 3**: 最新的 Material Design 指南

### 📱 **响应式设计**
- **断点系统**: 移动端、平板和桌面布局
- **自适应组件**: 根据屏幕大小自适应的组件
- **灵活网格**: 强大的网格系统用于复杂布局

### ♿ **无障碍**
- **屏幕阅读器支持**: 完整的语义标记
- **键盘导航**: 完整的键盘无障碍
- **高对比度**: 符合 WCAG AA 标准的颜色对比度
- **焦点管理**: 适当的焦点处理

### ⚡ **性能**
- **优化渲染**: 高效的组件构建
- **懒加载**: 按需组件加载
- **内存管理**: 适当的资源清理
- **树摇**: 死代码消除

### 🔧 **开发者体验**
- **类型安全**: 完整的类型安全
- **热重载**: 即时开发反馈
- **开发工具**: 全面的开发工具
- **测试**: 内置测试工具

---

## 🎨 组件

### 📋 **表单组件**
| 组件 | 描述 | 状态 |
|-----------|-------------|---------|
| [输入框](components/form/input.md) | 带验证的文本输入 | ✅ |
| [选择器](components/form/select.md) | 下拉选择 | ✅ |
| [日期选择器](components/form/date_picker.md) | 日期选择 | ✅ |
| [复选框](components/form/checkbox.md) | 复选框输入 | ✅ |
| [单选框](components/form/radio.md) | 单选按钮选择 | ✅ |
| [开关](components/form/switch.md) | 切换开关 | ✅ |
| [滑块](components/form/slider.md) | 范围选择 | ✅ |
| [表单构建器](components/form/form_builder.md) | 表单组合 | ✅ |

### 🎯 **基础组件**
| 组件 | 描述 | 状态 |
|-----------|-------------|---------|
| [按钮](components/basic/button.md) | 各种按钮样式 | ✅ |
| [头像](components/basic/avatar.md) | 用户头像 | ✅ |
| [徽章](components/basic/badge.md) | 状态指示器 | ✅ |
| [卡片](components/basic/card.md) | 内容容器 | ✅ |
| [芯片](components/basic/chip.md) | 过滤器/标签 | ✅ |
| [图标](components/basic/icon.md) | 图标系统 | ✅ |
| [文本](components/basic/text.md) | 排版 | ✅ |

### 🧭 **导航组件**
| 组件 | 描述 | 状态 |
|-----------|-------------|---------|
| [标签页](components/navigation/tabs.md) | 标签导航 | ✅ |
| [底部导航](components/navigation/bottom_navigation_bar.md) | 底部导航栏 | ✅ |
| [步骤条](components/navigation/stepper.md) | 步骤指示器 | ✅ |
| [面包屑](components/navigation/breadcrumb.md) | 面包屑导航 | ✅ |
| [侧边菜单](components/navigation/side_menu.md) | 导航抽屉 | ✅ |

### 📊 **显示组件**
| 组件 | 描述 | 状态 |
|-----------|-------------|---------|
| [表格](components/display/table.md) | 数据表格 | ✅ |
| [列表](components/display/list.md) | 列表视图 | ✅ |
| [日历](components/display/calendar.md) | 日历视图 | ✅ |
| [时间线](components/display/timeline.md) | 时间线视图 | ✅ |
| [图表](components/display/chart.md) | 数据可视化 | ✅ |

### 💬 **反馈组件**
| 组件 | 描述 | 状态 |
|-----------|-------------|---------|
| [警告](components/feedback/alert.md) | 警告消息 | ✅ |
| [模态框](components/feedback/modal.md) | 模态对话框 | ✅ |
| [提示](components/feedback/toast.md) | 提示通知 | ✅ |
| [进度](components/feedback/progress.md) | 进度指示器 | ✅ |
| [骨架屏](components/feedback/skeleton.md) | 加载骨架 | ✅ |

### 🚀 **高级组件**
| 组件 | 描述 | 状态 |
|-----------|-------------|---------|
| [自动完成](components/advanced/auto_complete.md) | 自动建议 | ✅ |
| [轮播](components/advanced/carousel.md) | 图片轮播 | ✅ |
| [颜色选择器](components/advanced/color_picker.md) | 颜色选择 | ✅ |
| [富文本编辑器](components/advanced/rich_editor.md) | 富文本编辑器 | ✅ |
| [树形视图](components/advanced/tree.md) | 树形视图 | ✅ |

---

## 🏗️ 架构

### 核心原则

```
┌─────────────────────────────────────────────────────────────┐
│                    ZephyrUI 架构                            │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐  │
│  │   主题层       │  │   组件层        │  │  工具层     │  │
│  │                 │  │                 │  │             │  │
│  │ • 亮色主题     │  │ • 基础组件     │  │ • 助手函数  │  │
│  │ • 暗色主题     │  │ • 表单组件     │  │ • 工具类    │  │
│  │ • 自定义主题   │  │ • 布局组件     │  │ • 常量      │  │
│  └─────────────────┘  └─────────────────┘  └─────────────┘  │
│                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐  │
│  │   服务层       │  │   数据层        │  │  平台层     │  │
│  │                 │  │                 │  │             │  │
│  │ • 主题服务     │  │ • 模型         │  │ • iOS       │  │
│  │ • API 服务     │  │ • 仓储         │  │ • Android   │  │
│  │ • 认证服务     │  │ • 提供者       │  │ • Web        │  │
│  └─────────────────┘  └─────────────────┘  └─────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### 关键架构特性

- **分层架构**: 清晰的关注点分离
- **面向服务**: 模块化服务设计
- **状态管理**: 内置状态管理解决方案
- **插件系统**: 可扩展的插件架构
- **性能优化**: 高效的渲染和内存使用

---

## 📚 文档

### 入门指南
- [安装指南](getting-started.md)
- [快速开始教程](examples/quick-start.md)
- [项目结构](guides/project-structure.md)

### 组件指南
- [组件概览](components/component-selection-guide.md)
- [表单组件](components/form/form-components.md)
- [布局组件](components/layout/grid.md)
- [导航组件](components/navigation/navigation-components.md)

### 高级主题
- [主题系统](guides/theming.md)
- [性能优化](guides/performance.md)
- [无障碍指南](guides/accessibility.md)
- [测试策略](guides/testing.md)

### API 参考
- [组件 API](api/components.md)
- [主题 API](api/themes.md)
- [工具函数](api/utils.md)
- [类型定义](api/types.md)

### 示例
- [基础示例](examples/basic.md)
- [高级示例](examples/advanced.md)
- [完整应用](examples/complete-app.md)
- [在线演示](https://demo.zephyrui.dev)

---

## 🤝 贡献

我们欢迎社区的贡献！详情请查看[贡献指南](../CONTRIBUTING.md)。

### 开发设置

```bash
# 克隆仓库
git clone https://github.com/zephyrui/zephyr_ui.git
cd zephyr_ui

# 安装依赖
flutter pub get

# 运行开发服务器
flutter run -t lib/development/main.dart

# 运行测试
flutter test

# 运行静态分析
flutter analyze
```

### 贡献指南

- 📝 **代码风格**: 遵循[风格指南](guides/style-guide.md)
- 🧪 **测试**: 保持 90%+ 的测试覆盖率
- 📚 **文档**: 为所有公共 API 编写文档
- 🎨 **设计**: 遵循 Material Design 3 指南
- ♿ **无障碍**: 确保 WCAG AA 合规

---

## 📞 支持

### 获取帮助

1. **文档**: 从[完整文档](./index.md)开始
2. **常见问题**: 查看[常见问题解答](faq.md)

### 专业支持

为企业客户提供：

- 🎯 **优先支持**: 24/7 邮件和聊天支持
- 🚀 **定制开发**: 功能开发和定制
- 📚 **培训**: 现场和远程培训课程
- 🔧 **咨询**: 架构和性能咨询

联系[销售团队](mailto:sales@zephyrui.dev)获取定价和详情。

---

## 📄 许可证

ZephyrUI 使用 MIT 许可证。详情请查看[LICENSE](../LICENSE)文件。

---

## 🙏 致谢

- **Flutter 团队**: 感谢出色的 Flutter 框架
- **Material Design**: 感谢设计系统的灵感
- **社区**: 感谢所有反馈和贡献
- **贡献者**: 感谢所有让 ZephyrUI 变得更好的人们

---

<div align="center">

**由 Agions 用 ❤️ 制作**


</div>

## 组件

### 基础组件
- [Button](components/basic/button.md)
- [Badge](components/basic/badge.md)
- [Avatar](components/basic/avatar.md)
- [Card](components/basic/card.md)
- [Chip](components/basic/chip.md)
- [Divider](components/basic/divider.md)
- [Icon](components/basic/icon.md)
- [Text](components/basic/text.md)

### 表单组件
- [Input](components/form/input.md)
- [Select](components/form/select.md)
- [DatePicker](components/form/date_picker.md)
- [CheckBox](components/form/checkbox.md)
- [Radio](components/form/radio.md)
- [Switch](components/form/switch.md)
- [Slider](components/form/slider.md)
- [FormBuilder](components/form/form_builder.md)

### 布局组件 (布局组件)
- [Container](components/layout/container.md) - 容器组件，提供灵活的包装能力
- [Grid](components/layout/grid.md) - 网格布局组件，支持多种网格模式
- [Accordion](components/layout/accordion.md) - 手风琴组件，可折叠的内容展示

### 导航组件
- [Tabs](components/navigation/tabs.md)
- [Pagination](components/navigation/pagination.md)
- [SideMenu](components/navigation/side_menu.md)
- [Stepper](components/navigation/stepper.md)

### 显示组件
- [Table](components/display/table.md)
- [List](components/display/list.md)
- [Calendar](components/display/calendar.md)
- [Timeline](components/display/timeline.md)
- [Statistic](components/display/statistic.md)

### 反馈组件
- [Alert](components/feedback/alert.md)
- [Modal](components/feedback/modal.md)
- [Toast](components/feedback/toast.md)
- [Progress](components/feedback/progress.md)
- [Skeleton](components/feedback/skeleton.md)

### 高级组件
- [AutoComplete](components/advanced/autocomplete.md)
- [Chart](components/advanced/chart.md)
- [Carousel](components/advanced/carousel.md)
- [ColorPicker](components/advanced/color_picker.md)
- [Breadcrumb](components/advanced/breadcrumb.md)
- [RichEditor](components/advanced/rich_editor.md)
- [Upload](components/advanced/upload.md)

## 主题

ZephyrUI 提供了强大的主题系统，允许您自定义所有组件的外观。

### 亮色主题

```dart
MaterialApp(
  theme: ZephyrTheme.lightTheme,
  home: MyApp(),
);
```

### 暗色主题

```dart
MaterialApp(
  darkTheme: ZephyrTheme.darkTheme,
  themeMode: ThemeMode.dark,
  home: MyApp(),
);
```

### 自定义主题

```dart
final customTheme = ZephyrThemeData(
  primaryColor: Colors.blue,
  secondaryColor: Colors.green,
  // ... 其他自定义
);

MaterialApp(
  theme: customTheme.toThemeData(),
  home: MyApp(),
);
```

## 贡献

我们欢迎贡献！详情请查看 [CONTRIBUTING.md](../CONTRIBUTING.md)。