---
title: 快速开始
description: ZephyrUI 快速开始指南，帮助您在2分钟内上手使用
version: 1.0.0
last_updated: 2024-08-25
---

# ZephyrUI 快速开始

欢迎来到 ZephyrUI！本指南将帮助您在2分钟内快速上手使用我们的企业级Flutter UI组件库。

## 🎯 什么是ZephyrUI？

ZephyrUI 是一个现代化的Flutter UI组件库，提供：

- 🚀 **60+ 专业组件**: 涵盖表单、导航、显示、反馈等各类组件
- 🎨 **设计系统**: 统一的设计语言和主题系统
- 📱 **响应式设计**: 支持移动端、平板和桌面
- ♿ **无障碍支持**: 完整的无障碍设计
- ⚡ **高性能**: 优化的渲染和内存管理

## 📦 安装

### 1. 添加依赖

在您的 `pubspec.yaml` 文件中添加 ZephyrUI：

```yaml
dependencies:
  flutter:
    sdk: flutter
  zephyr_ui: ^0.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  zephyr_ui_dev_tools: ^0.3.0  # 开发工具
```

### 2. 安装依赖

在项目根目录运行：

```bash
flutter pub get
```

## 🚀 第一个应用

### 1. 基础设置

创建一个简单的Flutter应用：

```dart
// main.dart
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

### 2. 创建主界面

```dart
// home_screen.dart
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
            // 标题
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

            // 按钮组
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

## 🎨 常用组件示例

### 按钮组件

```dart
// 按钮类型
Column(
  children: [
    // 主要按钮
    ZephyrButton.primary(
      text: '主要操作',
      onPressed: () {},
    ),

    const SizedBox(height: 8),

    // 次要按钮
    ZephyrButton.secondary(
      text: '次要操作',
      onPressed: () {},
    ),

    const SizedBox(height: 8),

    // 轮廓按钮
    ZephyrButton.outlined(
      text: '轮廓按钮',
      onPressed: () {},
    ),

    const SizedBox(height: 8),

    // 文本按钮
    ZephyrButton.text(
      text: '文本按钮',
      onPressed: () {},
    ),
  ],
)
```

### 表单组件

```dart
// 表单示例
Column(
  children: [
    ZephyrInputField(
      label: '用户名',
      placeholder: '请输入用户名',
      prefixIcon: const Icon(Icons.person),
    ),

    const SizedBox(height: 16),

    ZephyrInputField(
      label: '密码',
      placeholder: '请输入密码',
      obscureText: true,
      prefixIcon: const Icon(Icons.lock),
    ),

    const SizedBox(height: 16),

    ZephyrSelect(
      label: '选择城市',
      placeholder: '请选择城市',
      options: [
        ZephyrSelectOption(value: 'beijing', label: '北京'),
        ZephyrSelectOption(value: 'shanghai', label: '上海'),
        ZephyrSelectOption(value: 'guangzhou', label: '广州'),
      ],
      onChanged: (value) => print('选择: $value'),
    ),
  ],
)
```

### 卡片组件

```dart
// 卡片示例
ZephyrCard(
  title: '项目信息',
  subtitle: 'Flutter UI组件库',
  content: const Text(
    'ZephyrUI是一个现代化的Flutter UI组件库，'
    '提供丰富的组件和工具，帮助开发者快速构建美观的应用。',
  ),
  actions: [
    ZephyrButton.text(
      text: '取消',
      onPressed: () {},
    ),
    ZephyrButton.primary(
      text: '确认',
      onPressed: () {},
    ),
  ],
)
```

## 🎭 主题定制

### 基础主题

```dart
MaterialApp(
  theme: ZephyrTheme.light(),
  darkTheme: ZephyrTheme.dark(),
  themeMode: ThemeMode.system,
  home: const MyApp(),
)
```

### 自定义主题

```dart
final customTheme = ZephyrThemeData(
  primaryColor: Colors.blue,
  secondaryColor: Colors.green,
  backgroundColor: Colors.grey[50],
  surfaceColor: Colors.white,
  errorColor: Colors.red,
);

MaterialApp(
  theme: customTheme.toThemeData(),
  home: const MyApp(),
)
```

## 📱 响应式设计

```dart
// 响应式组件
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceType = ZephyrBreakpoints.getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return const MobileLayout();
      case DeviceType.tablet:
        return const TabletLayout();
      case DeviceType.desktop:
        return const DesktopLayout();
    }
  }
}
```

## 🔧 开发工具

### 1. 热重载

ZephyrUI完全支持Flutter的热重载功能，修改代码后立即看到效果。

### 2. 开发者工具

```bash
# 安装开发工具
flutter pub add zephyr_ui_dev_tools

# 使用调试工具
import 'package:zephyr_ui_dev_tools/zephyr_ui_dev_tools.dart';

// 在开发模式下启用调试工具
if (kDebugMode) {
  ZephyrDevTools.initialize();
}
```

## 🧪 测试

```dart
// 组件测试示例
void main() {
  testWidgets('ZephyrButton 点击测试', (WidgetTester tester) async {
    bool clicked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ZephyrButton(
          text: '测试按钮',
          onPressed: () => clicked = true,
        ),
      ),
    );

    // 查找按钮并点击
    await tester.tap(find.text('测试按钮'));
    await tester.pump();

    // 验证点击事件
    expect(clicked, true);
  });
}
```

## 📚 下一步

### 1. 查看完整文档

- [组件文档](../components/README.md)
- [API参考](../api/components.md)
- [最佳实践](../guides/best-practices.md)

### 2. 运行示例应用

```bash
# 克隆仓库
git clone https://github.com/zephyrui/zephyr_ui.git
cd zephyr_ui

# 运行示例
flutter run -t example/lib/main.dart
```

### 3. 加入社区

- [GitHub Issues](https://github.com/zephyrui/zephyr_ui/issues)
- [GitHub Discussions](https://github.com/zephyrui/zephyr_ui/discussions)
- [社区论坛](https://community.zephyrui.dev)

## 🆘 遇到问题？

### 常见问题

1. **依赖冲突**: 确保Flutter版本兼容
2. **主题问题**: 检查MaterialApp配置
3. **组件不显示**: 确认正确导入包

### 获取帮助

1. **查看文档**: [完整文档](../README.md)
2. **搜索问题**: [GitHub Issues](https://github.com/zephyrui/zephyr_ui/issues)
3. **提交问题**: 创建新的Issue
4. **联系支持**: [support@zephyrui.com](mailto:support@zephyrui.com)

---

🎉 **恭喜！** 您已经成功上手ZephyrUI！继续探索我们的组件库，构建精美的Flutter应用吧！

**文档版本**: 1.0.0
**最后更新**: 2024年8月25日
