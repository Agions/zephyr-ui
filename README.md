# VelocityUI

<div align="center">

![VelocityUI Logo](https://raw.githubusercontent.com/Agions/velocity-ui/main/assets/images/logo_python.svg)

**高性能企业级 Flutter UI 组件库**

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-28A745?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-FF6B6B?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-4A90E2?style=for-the-badge)

[![Stars](https://img.shields.io/github/stars/Agions/velocity-ui?style=for-the-badge&logo=github)](https://github.com/Agions/velocity-ui)
[![Forks](https://img.shields.io/github/forks/Agions/velocity-ui?style=for-the-badge&logo=github)](https://github.com/Agions/velocity-ui)
[![Issues](https://img.shields.io/github/issues/Agions/velocity-ui?style=for-the-badge&logo=github)](https://github.com/Agions/velocity-ui/issues)
[![PRs](https://img.shields.io/github/issues-pr/Agions/velocity-ui?style=for-the-badge&logo=github)](https://github.com/Agions/velocity-ui/pulls)

**🚀 60+ 专业组件 • ⚡ 高性能 • 🎨 设计系统 • 📱 响应式 • ♿ 无障碍**

</div>

---

## 📋 目录

- [✨ 特性概览](#-特性概览)
- [🚀 快速开始](#-快速开始)
- [📦 安装指南](#-安装指南)
- [🎨 核心特性](#-核心特性)
- [🏗️ 架构设计](#-架构设计)
- [📊 组件库](#-组件库)
- [📚 文档资源](#-文档资源)
- [🤝 贡献指南](#-贡献指南)
- [📞 技术支持](#-技术支持)
- [📄 开源协议](#-开源协议)

---

## ✨ 特性概览

### 🎨 **设计系统**

- **统一主题**：Material Design 3 规范
- **高度可定制**：灵活的主题配置
- **暗色模式**：完整的深色主题支持
- **设计令牌**：一致的设计语言

### 📱 **响应式设计**

- **多端适配**：移动端、平板、桌面端
- **断点系统**：智能布局切换
- **自适应组件**：根据屏幕尺寸优化
- **弹性布局**：强大的网格系统

### ♿ **无障碍支持**

- **屏幕阅读器**：完整的语义化标记
- **键盘导航**：全键盘操作支持
- **高对比度**：WCAG AA 标准合规
- **焦点管理**：智能焦点处理

### ⚡ **性能优化**

- **高效渲染**：优化的组件构建策略
- **懒加载**：按需加载减少资源占用
- **内存管理**：智能资源回收机制
- **树摇优化**：移除未使用代码

---

## 🚀 快速开始

### 1. 添加依赖

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  velocity_ui: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  velocity_ui_dev_tools: ^0.4.0
```

### 2. 基础配置

```dart
import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VelocityApp(
      title: 'VelocityUI 应用',
      theme: VelocityTheme.light(),
      darkTheme: VelocityTheme.dark(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
```

### 3. 使用示例

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VelocityUI 演示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题区域
            const Text(
              '欢迎使用 VelocityUI',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '企业级 Flutter UI 组件库，为现代应用而生',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // 按钮组件演示
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                VelocityButton(
                  text: '主要操作',
                  onPressed: () => print('Primary action'),
                  type: VelocityButtonType.primary,
                ),
                VelocityButton(
                  text: '次要操作',
                  onPressed: () => print('Secondary action'),
                  type: VelocityButtonType.secondary,
                ),
                VelocityButton(
                  text: '边框操作',
                  onPressed: () => print('Outlined action'),
                  type: VelocityButtonType.outlined,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 表单组件演示
            VelocityInput(
              label: '邮箱地址',
              placeholder: '请输入您的邮箱',
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

            // 卡片组件演示
            VelocityCard(
              title: '专业 UI 组件',
              subtitle: '为企业级应用精心设计',
              content: const Text(
                'VelocityUI 提供了超过 60 个高质量、无障碍且完全可定制的 Flutter 组件，'
                '帮助开发者快速构建现代化的用户界面。',
              ),
              actions: [
                VelocityButton(
                  text: '查看文档',
                  onPressed: () => print('View documentation'),
                  type: VelocityButtonType.text,
                ),
                VelocityButton(
                  text: '立即开始',
                  onPressed: () => print('Get started'),
                  type: VelocityButtonType.primary,
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

## 📦 安装指南

### 系统要求

- **Flutter**: ^3.0.0
- **Dart**: ^3.0.0
- **iOS**: 12.0+
- **Android**: API 21+

### 安装步骤

```bash
# 1. 克隆仓库
git clone https://github.com/Agions/velocity-ui.git
cd velocity-ui

# 2. 安装依赖
flutter pub get

# 3. 运行示例应用
flutter run -t lib/main.dart

# 4. 运行测试
flutter test

# 5. 静态分析
flutter analyze
```

---

## 🎨 核心特性

### 🎯 **组件生态**

| 类别        | 组件数量 | 状态 | 描述                       |
| ----------- | -------- | ---- | -------------------------- |
| 📋 表单组件 | 13       | ✅   | 输入、选择、验证等表单元素 |
| 🎯 基础组件 | 8        | ✅   | 按钮、卡片、头像等基础元素 |
| 🧭 导航组件 | 8        | ✅   | 选项卡、步骤器、面包屑等   |
| 📊 数据展示 | 13       | ✅   | 表格、列表、图表等数据组件 |
| 💬 反馈组件 | 6        | ✅   | 提示、加载、对话框等       |
| 🏗️ 布局组件 | 4        | ✅   | 网格、容器、折叠面板等     |
| 🚀 高级组件 | 16       | ✅   | 图表、上传、编辑器等       |

### 🔧 **开发工具**

- **热重载**：实时预览代码更改
- **开发工具**：完整的开发辅助工具集
- **类型安全**：完整的 TypeScript 支持
- **测试工具**：内置测试框架和工具

### 📈 **性能监控**

```dart
class VelocityPerformanceMetrics {
  static const Duration targetFrameTime = Duration(milliseconds: 16);
  static const Duration maxBuildTime = Duration(milliseconds: 2);
  static const int maxMemoryUsage = 100; // MB
  static const double jankThreshold = 0.1;
}
```

---

## 🏗️ 架构设计

### 系统架构

```
┌─────────────────────────────────────────────────────────────┐
│                    VelocityUI 架构                            │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐  │
│  │   表现层        │  │   组件层        │  │  工具层     │  │
│  │                 │  │                 │  │             │  │
│  │ • 主题系统     │  │ • 基础组件     │  │ • 工具函数  │  │
│  │ • 样式管理     │  │ • 复合组件     │  │ • 常量定义  │  │
│  │ • 响应式布局   │  │ • 业务组件     │  │ • 辅助类    │  │
│  └─────────────────┘  └─────────────────┘  └─────────────┘  │
│                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐  │
│  │   服务层        │  │   数据层        │  │  平台层     │  │
│  │                 │  │                 │  │             │  │
│  │ • 主题服务     │  │ • 状态管理     │  │ • iOS       │  │
│  │ • 动画服务     │  │ • 数据模型     │  │ • Android   │  │
│  │ • 事件服务     │  │ • 业务逻辑     │  │ • Web       │  │
│  └─────────────────┘  └─────────────────┘  └─────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### 设计原则

1. **一致性**：统一的设计语言和交互模式
2. **可访问性**：遵循 WCAG 2.1 标准
3. **性能**：优化的渲染和内存使用
4. **可定制性**：灵活的主题系统
5. **易用性**：直观的 API 设计

---

## 📊 组件库

### 📋 表单组件

| 组件                    | 功能         | 状态 |
| ----------------------- | ------------ | ---- |
| `VelocityInput`         | 文本输入框   | ✅   |
| `VelocitySelect`        | 下拉选择器   | ✅   |
| `VelocityDatePicker`    | 日期选择器   | ✅   |
| `VelocityCheckbox`      | 复选框       | ✅   |
| `VelocityRadio`         | 单选按钮     | ✅   |
| `VelocitySwitch`        | 开关切换     | ✅   |
| `VelocitySlider`        | 滑块组件     | ✅   |
| `VelocityRating`        | 评分组件     | ✅   |
| `VelocityTimePicker`    | 时间选择器   | ✅   |
| `VelocityTextArea`      | 多行文本输入 | ✅   |
| `VelocityCheckboxGroup` | 复选框组     | ✅   |
| `VelocityRadioGroup`    | 单选框组     | ✅   |

### 🎯 基础组件

| 组件              | 功能       | 状态 |
| ----------------- | ---------- | ---- |
| `VelocityButton`  | 多样式按钮 | ✅   |
| `VelocityAvatar`  | 头像组件   | ✅   |
| `VelocityBadge`   | 徽章指示器 | ✅   |
| `VelocityCard`    | 卡片组件   | ✅   |
| `VelocityChip`    | 标签选择器 | ✅   |
| `VelocityIcon`    | 图标组件   | ✅   |
| `VelocityText`    | 文本组件   | ✅   |
| `VelocityDivider` | 分割线组件 | ✅   |

### 🧭 导航组件

| 组件                          | 功能       | 状态 |
| ----------------------------- | ---------- | ---- |
| `VelocityTabs`                | 选项卡导航 | ✅   |
| `VelocityStepper`             | 步骤器     | ✅   |
| `VelocityBreadcrumb`          | 面包屑导航 | ✅   |
| `VelocityPagination`          | 分页组件   | ✅   |
| `VelocityBottomNavigationBar` | 底部导航栏 | ✅   |
| `VelocitySideMenu`            | 侧边菜单   | ✅   |
| `VelocityNavigationRail`      | 导航栏     | ✅   |
| `VelocityTour`                | 引导游览   | ✅   |

---

## 📚 文档资源

### 📖 入门指南

- [快速开始](doc/getting-started.md)
- [项目结构](doc/guides/project-structure.md)
- [开发环境配置](doc/guides/setup.md)

### 🎨 设计指南

- [设计系统](doc/guides/design-system.md)
- [主题定制](doc/guides/theming.md)
- [响应式设计](doc/guides/responsive-design.md)
- [无障碍设计](doc/guides/accessibility.md)

### 🚀 最佳实践

- [性能优化](doc/guides/performance.md)
- [代码规范](doc/guides/coding-standards.md)
- [测试策略](doc/guides/testing.md)
- [部署指南](doc/guides/deployment.md)

### 🔧 API 参考

- [组件 API](doc/api/components.md)
- [主题 API](doc/api/themes.md)
- [工具函数](doc/api/utils.md)
- [类型定义](doc/api/types.md)

---

## 🤝 贡献指南

### 开发环境设置

```bash
# 1. Fork 仓库
# 2. 克隆到本地
git clone https://github.com/YOUR_USERNAME/velocity-ui.git
cd velocity-ui

# 3. 添加上游仓库
git remote add upstream https://github.com/Agions/velocity-ui.git

# 4. 创建功能分支
git checkout -b feature/your-feature-name

# 5. 安装依赖
flutter pub get

# 6. 开发和测试
flutter test
flutter analyze
```

### 贡献规范

- 📝 **代码风格**：遵循 [Dart 官方规范](https://dart.dev/guides/language/effective-dart)
- 🧪 **测试覆盖**：保持 90%+ 的测试覆盖率
- 📚 **文档**：为所有公共 API 编写文档注释
- 🎨 **设计**：遵循 Material Design 3 指南
- ♿ **无障碍**：确保 WCAG AA 合规

### 提交规范

```bash
# 提交格式
git commit -m "feat: 添加新组件 X"
git commit -m "fix: 修复组件 Y 的 bug"
git commit -m "docs: 更新 README 文档"
git commit -m "style: 代码格式化"
git commit -m "refactor: 重构组件结构"
git commit -m "test: 添加单元测试"
```

---

## 📞 技术支持

### 🆘 获取帮助

1. **文档**：从 [完整文档](doc/README.md) 开始
2. **示例**：查看 [示例应用](example/)
3. **问题报告**：[GitHub Issues](https://github.com/Agions/velocity-ui/issues)

### 💼 企业支持

为企业客户提供专业支持服务：

- 🎯 **优先支持**：24/7 技术支持
- 🚀 **定制开发**：功能定制和开发
- 🔧 **技术咨询**：架构设计和性能优化

---

## 📄 开源协议

本项目采用 **MIT 协议** 开源。

### 协议概要

✅ **允许**：

- 商业使用
- 修改和分发
- 私人使用
- 子协议使用

❌ **禁止**：

- 声明责任
- 诉诸法律

📋 **要求**：

- 包含许可证和版权声明
- 声明重大更改

详见 [LICENSE](./LICENSE) 文件。

---

<div align="center">

**由 Agions 团队用 ❤️ 精心打造**

[![GitHub](https://img.shields.io/github/stars/Agions/zephyr-ui?style=social)](https://github.com/Agions/zephyr-ui)

</div>
