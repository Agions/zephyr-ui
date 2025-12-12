---
title: 快速开始
description: 快速上手 VelocityUI 组件库
---

# 快速开始

本指南将帮助您快速上手 VelocityUI 组件库，从安装到第一个组件的使用。

## 1. 安装

### 1.1 前置要求

- Flutter 3.0.0 或更高版本
- Dart 3.0.0 或更高版本

### 1.2 安装步骤

在您的 Flutter 项目中，通过以下命令安装 VelocityUI：

```bash
flutter pub add velocity_ui
```

或者手动在 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  flutter:
    sdk: flutter
  velocity_ui: ^1.0.0
```

然后运行：

```bash
flutter pub get
```

## 2. 基本使用

### 2.1 导入组件

在需要使用 VelocityUI 组件的文件中导入：

```dart
import 'package:velocity_ui/velocity_ui.dart';
```

### 2.2 第一个组件

让我们创建一个简单的页面，使用 VelocityUI 的 Button 组件：

```dart
import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VelocityUI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VelocityUI Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const VelocityText(
              'Welcome to VelocityUI!',
              size: VelocityTextSize.xl,
              weight: VelocityFontWeight.bold,
            ),
            const SizedBox(height: 24),
            VelocityButton.primary(
              text: '主要按钮',
              onPressed: () {
                print('主要按钮被点击');
              },
            ),
            const SizedBox(height: 12),
            VelocityButton.secondary(
              text: '次要按钮',
              onPressed: () {
                print('次要按钮被点击');
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2.3 运行应用

使用 Flutter 命令运行应用：

```bash
flutter run
```

您应该能看到一个包含 "Welcome to VelocityUI!" 文本和两个按钮的页面。

## 3. 主题定制

VelocityUI 支持强大的主题定制功能，您可以全局配置组件样式。

### 3.1 全局主题配置

在应用的根组件中配置全局主题：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      VelocityThemeData(
        // 自定义主题配置
        buttonTheme: VelocityButtonTheme(
          primaryColor: Colors.purple,
          borderRadius: BorderRadius.circular(20),
          height: 50,
        ),
        textTheme: VelocityTextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[800]),
        ),
        badgeTheme: VelocityBadgeTheme(
          primaryColor: Colors.green,
        ),
      ),
    ],
  ),
  home: const MyHomePage(),
);
```

### 3.2 组件级主题覆盖

您也可以在单个组件上覆盖全局主题：

```dart
VelocityButton(
  text: '自定义按钮',
  onPressed: () {},
  style: VelocityButtonStyle(
    backgroundColor: Colors.orange,
    textColor: Colors.white,
    borderRadius: BorderRadius.circular(10),
  ),
);
```

## 4. 核心概念

### 4.1 组件分类

VelocityUI 的组件按功能分为六大类：

- **基础组件**：构建用户界面的核心元素，如 Button、Text、Icon 等
- **展示组件**：用于展示信息和数据，如 Avatar、Card、List 等
- **布局组件**：用于构建页面布局，如 Grid、Space、Container 等
- **导航组件**：用于页面导航和路由，如 Tabs、Drawer、Menu 等
- **表单组件**：用于收集和验证用户输入，如 Input、Select、Checkbox 等
- **反馈组件**：用于向用户提供反馈，如 Dialog、Toast、Loading 等

### 4.2 样式系统

VelocityUI 采用了基于 `EffectiveStyle` 的样式系统，支持：

- 链式调用的样式设置
- 主题继承和覆盖
- 响应式设计
- 类型安全的样式属性

### 4.3 无障碍支持

VelocityUI 所有组件都提供了完善的无障碍支持：

- 支持语义化标签
- 键盘导航支持
- 屏幕阅读器优化
- 高对比度设计

## 5. 最佳实践

### 5.1 组件使用

- 遵循组件的设计意图使用
- 保持组件使用的一致性
- 合理设置组件的属性
- 避免过度定制组件样式

### 5.2 性能优化

- 对于大量数据展示，使用懒加载
- 合理使用 `const` 构造函数
- 避免不必要的重建
- 优化图片资源

### 5.3 代码组织

- 按功能模块组织组件
- 使用主题统一管理样式
- 提取可复用的组件
- 编写清晰的注释

## 6. 下一步

- 查看 [组件目录](/components/basic/) 了解所有可用组件
- 阅读 [主题定制](/theme-customization/) 深入了解主题系统
- 查看 [API 参考](/api-reference/) 获取详细的 API 文档
- 探索 [示例项目](https://github.com/agions/velocity_ui/tree/main/example) 了解实际应用

## 7. 常见问题

### 7.1 组件不显示

**问题**：添加了组件但在界面上不显示

**解决方案**：
1. 检查组件是否有足够的空间显示
2. 检查组件的可见性属性
3. 检查组件的父组件布局

### 7.2 样式不生效

**问题**：设置了组件样式但没有生效

**解决方案**：
1. 检查样式属性名称是否正确
2. 检查是否有更高优先级的样式覆盖
3. 检查主题配置是否正确

### 7.3 版本兼容性

**问题**：使用 VelocityUI 时出现版本冲突

**解决方案**：
1. 确保 Flutter 和 Dart 版本满足要求
2. 检查依赖版本冲突
3. 更新 VelocityUI 到最新版本

## 8. 资源与支持

- [GitHub 仓库](https://github.com/agions/velocity_ui)
- [问题反馈](https://github.com/agions/velocity_ui/issues)
- [贡献指南](https://github.com/agions/velocity_ui/blob/main/CONTRIBUTING.md)
- [许可证](https://github.com/agions/velocity_ui/blob/main/LICENSE)

---

现在您已经完成了 VelocityUI 的快速开始指南，开始构建您的应用吧！