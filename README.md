# ZephyrUI

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%5E3.0-blue?logo=flutter" alt="Flutter Version">
  <img src="https://img.shields.io/badge/Dart-%5E3.0-blue?logo=dart" alt="Dart Version">
  <img src="https://img.shields.io/badge/Version-0.1.0-brightgreen" alt="Version">
  <img src="https://img.shields.io/badge/License-MIT-blue" alt="License">
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen" alt="PRs Welcome">
  <img src="https://img.shields.io/badge/Status-Stable-success" alt="Status">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Components-10%2B-orange" alt="Components">
  <img src="https://img.shields.io/badge/Demos-Complete-blue" alt="Demos">
  <img src="https://img.shields.io/badge/Documentation-100%25-green" alt="Documentation">
</p>

<p align="center">
  <strong>一个现代化、高性能、可定制的 Flutter 组件库，专为构建美观、一致的用户界面而设计。</strong>
</p>

<p align="center">
  <a href="#-快速开始">快速开始</a> •
  <a href="#-特性">特性</a> •
  <a href="#-组件">组件</a> •
  <a href="#-文档">文档</a> •
  <a href="#-示例">示例</a> •
  <a href="#-贡献">贡献</a>
</p>

## ✨ 简介

ZephyrUI 是一个企业级 Flutter 组件库，提供 **10+** 精心设计的组件，涵盖基础 UI、导航、反馈等核心功能。它基于最新的 Flutter 和 Dart 版本构建，遵循 Material Design 设计规范，同时提供高度可定制的主题系统。

### 🎯 项目状态

- **✅ 已完成组件**: 头像、徽章、按钮、卡片、标签、分割线、评分、树形控件、引导游览等
- **✅ 完整文档**: 所有已实现组件都有详细的文档和使用示例
- **✅ 演示应用**: 包含完整的示例应用，展示所有组件的使用方法
- **✅ 主题系统**: 支持深色/浅色主题切换

### 🎯 设计理念

- **一致性**: 统一的设计语言和交互模式
- **可访问性**: 遵循 WCAG 2.1 标准，支持屏幕阅读器
- **性能**: 优化的渲染和内存使用
- **可定制**: 强大的主题系统和组件配置
- **易用性**: 简洁直观的 API 设计

## 🚀 特性

### 🎨 核心特性
- **10+ 高质量组件**: 涵盖基础 UI、导航、反馈等核心功能
- **设计系统**: 基于 Material Design 3 设计规范
- **主题系统**: 支持亮色/暗色主题，可完全自定义
- **响应式设计**: 自动适配手机、平板、桌面等设备
- **完整示例**: 提供详细的演示应用

### ♿ 可访问性
- **WCAG 2.1 合规**: 遵循 Web 内容可访问性指南
- **屏幕阅读器支持**: 完整的语义化标签
- **键盘导航**: 完整的键盘操作支持
- **高对比度模式**: 支持系统高对比度设置
- **动态字体**: 支持系统字体大小缩放

### ⚡ 性能优化
- **内存优化**: 智能缓存和垃圾回收策略
- **渲染优化**: 使用 `const` 构造函数
- **动画优化**: 使用 `AnimatedWidget` 和 `ValueNotifier`
- **热重载**: 完全支持 Flutter 热重载

### 🛠️ 开发体验
- **TypeScript 风格 API**: 完整的类型提示和智能感知
- **热重载**: 完全支持 Flutter 热重载
- **调试工具**: 内置调试面板
- **示例完整**: 完整的使用示例和演示应用
- **文档完整**: 详细的 API 文档和使用示例

## 📦 组件分类

### 🎯 基础组件 (Basic) - ✅ 已完成
- **ZephyrAvatar** - ✅ 头像组件，支持图片和文字
- **ZephyrBadge** - ✅ 徽章和状态指示器
- **ZephyrButton** - ✅ 多种样式的按钮组件
- **ZephyrCard** - ✅ 卡片组件
- **ZephyrChip** - ✅ 标签选择器组件
- **ZephyrDivider** - ✅ 分割线和间距组件
- **ZephyrIcon** - ✅ 图标组件
- **ZephyrText** - ✅ 文本组件

### 🧭 导航组件 (Navigation) - ✅ 已完成
- **ZephyrTree** - ✅ 🌳 树形控件
- **ZephyrTour** - ✅ 🎯 引导游览

### 📝 表单组件 (Form) - ✅ 已完成
- **ZephyrRating** - ✅ ⭐ 评分组件

## 📦 安装

### 系统要求

- **Flutter**: ^3.0.0
- **Dart**: ^3.0.0
- **Android**: API 21+ (Android 5.0+)
- **iOS**: 12.0+
- **Web**: 现代浏览器 (Chrome, Safari, Firefox, Edge)

### 添加依赖

在 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  zephyr_ui: ^0.1.0
```

然后运行：

```bash
flutter pub get
```

## 🚀 快速开始

### 1. 基础设置

```dart
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrUI Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}
```

### 2. 使用组件

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头像组件
            ZephyrAvatar.text(
              text: 'ZU',
              size: ZephyrAvatarSize.medium,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),

            const SizedBox(height: 16),

            // 徽章组件
            ZephyrBadge(
              content: '新',
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),

            const SizedBox(height: 16),

            // 评分组件
            ZephyrRating(
              value: 4.5,
              allowHalfRating: true,
              onValueChanged: (value) {
                print('评分: $value');
              },
            ),

            const SizedBox(height: 16),

            // 标签组件
            ZephyrChip(
              label: 'Flutter',
              onPressed: () {
                print('标签被点击');
              },
            ),

            const SizedBox(height: 16),

            // 卡片组件
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '卡片标题',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('这是一个卡片组件的示例内容。'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3. 主题定制

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6366F1),
      brightness: Brightness.light,
    ),
    // 自定义字体
    fontFamily: 'Roboto',
    // 自定义圆角
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  darkTheme: ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
  ),
  themeMode: ThemeMode.system,
  home: MyHomePage(),
);
```

## 🎨 主题定制

### 主题系统概述

ZephyrUI 支持深色/浅色主题切换：

```dart
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}

// 在应用中使用
ChangeNotifierProvider(
  create: (context) => ThemeProvider(),
  child: Consumer<ThemeProvider>(
    builder: (context, themeProvider, child) {
      return MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeProvider.themeMode,
        home: MyHomePage(),
      );
    },
  ),
);
```

## 📱 响应式设计

### 断点系统

ZephyrUI 内置响应式支持：

```dart
// 扩展方法
extension ResponsiveExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 768;
  bool get isTablet => MediaQuery.of(this).size.width >= 768 &&
                      MediaQuery.of(this).size.width < 1024;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1024;
}

// 响应式布局
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 768) {
      return const MobileLayout();
    } else if (constraints.maxWidth < 1024) {
      return const TabletLayout();
    } else {
      return const DesktopLayout();
    }
  },
),
```

## 📚 文档

### 完整文档

- [📖 用户指南](docs/README.md) - 完整的用户文档
- [🚀 快速开始](docs/getting-started.md) - 快速上手指南
- [🔧 API 参考](docs/api/README.md) - 详细的 API 文档
- [🎨 主题定制](docs/theming.md) - 主题定制指南
- [♿ 可访问性](docs/accessibility.md) - 可访问性指南

### 组件文档

- [基础组件](docs/components/basic/README.md)
- [导航组件](docs/components/navigation/README.md)
- [表单组件](docs/components/form/README.md)

### 示例和演示

- [📱 示例应用](example/) - 完整的示例应用
- [🎯 组件示例](docs/examples/) - 各组件的使用示例

### 运行示例应用

克隆项目并运行示例应用：

```bash
# 克隆项目
git clone https://github.com/agions/zephyr-ui.git
cd zephyr_ui

# 运行示例应用
cd example
flutter pub get
flutter run
```

或者运行完整演示：

```bash
flutter run -t lib/main.dart
```

或者运行简化版本：

```bash
flutter run -t lib/main_simple.dart
```

## 🛠️ 开发规范

### 代码质量

ZephyrUI 遵循严格的开发规范，确保代码质量和一致性：

- **代码风格**: 遵循 Dart 官方代码风格指南
- **命名规范**: 使用描述性的名称，遵循驼峰命名法
- **注释规范**: 所有公共 API 都有完整的文档注释
- **测试覆盖**: 保持高测试覆盖率
- **性能优化**: 避免不必要的重建和内存泄漏

### 开发流程

1. **Fork 项目** - 从主仓库创建分支
2. **创建功能分支** - 使用 `feature/` 或 `fix/` 前缀
3. **编写代码** - 遵循代码规范和最佳实践
4. **添加测试** - 为新功能编写单元测试和集成测试
5. **更新文档** - 更新相关文档和示例
6. **提交 PR** - 提供详细的变更描述
7. **代码审查** - 响应审查意见并进行修改

## 🤝 贡献

我们欢迎任何形式的贡献！ZephyrUI 持续改进中，您的参与将帮助我们构建更好的组件库。

### 如何贡献

1. **Fork 项目** - 从主仓库创建分支
2. **选择任务** - 查看 Issues 或选择要开发的组件
3. **创建分支** - 使用 `feature/` 或 `fix/` 前缀
4. **开发组件** - 遵循现有的代码结构和命名规范
5. **添加示例** - 在 `example/` 目录中添加使用示例
6. **更新文档** - 在 `docs/` 目录中更新组件文档
7. **提交 PR** - 提供详细的变更描述

### 开发指南

- 遵循 Dart 官方代码风格指南
- 所有公共 API 都需要完整的文档注释
- 组件需要支持主题定制
- 确保组件的可访问性
- 添加必要的测试用例

### 贡献类型

- 🐛 **Bug 修复** - 修复现有问题
- ✨ **新组件** - 开发新的组件
- 📚 **文档** - 改进文档和示例
- 🎨 **UI/UX** - 改进用户界面和体验
- ⚡ **性能** - 性能优化和改进
- 🧪 **测试** - 增加测试覆盖率
- 🔧 **构建** - 改进构建和 CI/CD 流程

## 📄 许可证

ZephyrUI 采用 [MIT 许可证](LICENSE) - 查看文件获取详细信息。

### 许可证摘要

✅ **允许**:
- 商业使用
- 修改
- 分发
- 私人使用

❌ **禁止**:
- 声明责任
- 诉诸法律

📋 **要求**:
- 包含许可证和版权声明
- 声明重大更改

## 📞 支持

### 获取帮助

- 💬 **讨论**: [GitHub Discussions](https://github.com/agions/zephyr-ui/discussions)
- 🐛 **问题报告**: [GitHub Issues](https://github.com/agions/zephyr-ui/issues)
- 📖 **文档**: [GitHub 仓库文档](https://github.com/agions/zephyr-ui/tree/main/docs)

### 社区

- 🌟 **Star 项目** - 如果你喜欢 ZephyrUI，请给我们一个 ⭐️
- 🔄 **分享** - 分享给你的朋友和同事
- 🎯 **贡献** - 参与开发和改进
- 📢 **反馈** - 提供宝贵的反馈和建议

### 更新日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本更新和变更记录。

---

<p align="center">
  <strong>用 💛 制作 by Agions</strong>
</p>

<p align="center">
  <a href="#-快速开始">快速开始</a> •
  <a href="#-特性">特性</a> •
  <a href="#-组件">组件</a> •
  <a href="#-文档">文档</a> •
  <a href="#-示例">示例</a> •
  <a href="#-贡献">贡献</a>
</p>
