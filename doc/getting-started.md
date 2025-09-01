# ZephyrUI 快速开始指南

## 目录
- [介绍](#介绍)
- [安装](#安装)
- [基础设置](#基础设置)
- [第一个组件](#第一个组件)
- [主题配置](#主题配置)
- [常用组件](#常用组件)
- [响应式设计](#响应式设计)
- [无障碍](#无障碍)
- [测试](#测试)
- [下一步](#下一步)

## 介绍

欢迎使用 ZephyrUI！本指南将帮助您开始使用我们全面的 Flutter 组件库。ZephyrUI 提供了 60+ 个高质量组件，具有一致的设计系统、内置的无障碍功能和出色的性能。

### 您将学到

- 如何安装和设置 ZephyrUI
- 基础组件使用
- 主题自定义
- 响应式设计模式
- 无障碍最佳实践
- 测试策略

## 安装

### 前置要求

在开始之前，请确保您具备以下条件：

- **Flutter**: ^3.0.0
- **Dart**: ^3.0.0
- 已设置的 Flutter 项目

### 第 1 步：将 ZephyrUI 添加到您的项目

将 ZephyrUI 添加到您的 `pubspec.yaml` 文件：

```yaml
dependencies:
  flutter:
    sdk: flutter
  zephyr_ui: ^0.1.0
```

### 第 2 步：安装依赖

在终端中运行以下命令：

```bash
flutter pub get
```

### 第 3 步：导入 ZephyrUI

在您的 Dart 文件中导入 ZephyrUI：

```dart
import 'package:zephyr_ui/zephyr_ui.dart';
```

## 基础设置

### 第 1 步：用 ZephyrApp 包装您的应用

将您的 `MaterialApp` 替换为 `ZephyrApp`：

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
    return ZephyrApp(
      title: '我的应用',
      theme: ZephyrTheme.light(),
      darkTheme: ZephyrTheme.dark(),
      home: const HomeScreen(),
    );
  }
}
```

### 第 2 步：创建基础主页

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 演示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '欢迎使用 ZephyrUI！',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '这是 ZephyrUI 组件的演示。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            // 组件将在这里添加
          ],
        ),
      ),
    );
  }
}
```

## 第一个组件

让我们添加您的第一个 ZephyrUI 组件 - 一个按钮：

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 演示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '欢迎使用 ZephyrUI！',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '这是 ZephyrUI 组件的演示。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // 您的第一个 ZephyrUI 组件
            ZephyrButton(
              text: '点击我！',
              onPressed: () {
                ZephyrToast.show(
                  context,
                  message: '来自 ZephyrUI 的问候！',
                  type: ZephyrToastType.success,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## 主题配置

ZephyrUI 提供了强大的主题功能。让我们自定义主题：

### 创建自定义主题

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrApp(
      title: '我的应用',
      theme: _createCustomTheme(),
      darkTheme: ZephyrTheme.dark(),
      home: const HomeScreen(),
    );
  }

  ZephyrThemeData _createCustomTheme() {
    return ZephyrThemeData(
      primaryColor: const Color(0xFF6366F1),
      secondaryColor: const Color(0xFF8B5CF6),
      backgroundColor: const Color(0xFFF9FAFB),
      surfaceColor: Colors.white,
      errorColor: const Color(0xFFEF4444),
      warningColor: const Color(0xFFF59E0B),
      successColor: const Color(0xFF10B981),
      infoColor: const Color(0xFF3B82F6),

      // 排版
      typography: ZephyrTypography(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        h1: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        h2: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        body: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        caption: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      ),

      // 圆角
      borderRadius: ZephyrBorderRadius(
        small: 4,
        medium: 8,
        large: 12,
        xlarge: 16,
        full: 9999,
      ),

      // 间距
      spacing: ZephyrSpacing(
        xs: 4,
        sm: 8,
        md: 16,
        lg: 24,
        xl: 32,
        xxl: 48,
      ),
    );
  }
}
```

### 动态主题切换

```dart
class ThemeProvider with ChangeNotifier {
  ZephyrThemeData _theme = ZephyrTheme.light();
  bool _isDarkMode = false;

  ZephyrThemeData get theme => _theme;
  bool get isDarkMode => _isDarkMode;

  void setTheme(ZephyrThemeData theme) {
    _theme = theme;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _theme = _isDarkMode ? ZephyrTheme.dark() : ZephyrTheme.light();
    notifyListeners();
  }
}

// 更新您的应用以使用主题提供者
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ZephyrApp(
            title: '我的应用',
            theme: themeProvider.theme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
```

## 常用组件

让我们在您的主页上添加一些常用组件：

### 表单组件

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 演示'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: themeProvider.toggleTheme,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 页眉
            const Text(
              '欢迎使用 ZephyrUI！',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '这是 ZephyrUI 组件的演示。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // 按钮
            const Text(
              '按钮',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ZephyrButton(
                  text: '主要',
                  type: ZephyrButtonType.primary,
                  onPressed: () {},
                ),
                ZephyrButton(
                  text: '次要',
                  type: ZephyrButtonType.secondary,
                  onPressed: () {},
                ),
                ZephyrButton(
                  text: '文本',
                  type: ZephyrButtonType.text,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 输入字段
            const Text(
              '输入字段',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ZephyrInput(
              placeholder: '输入您的姓名',
              prefix: const Icon(Icons.person),
              onChanged: (value) {
                print('姓名: $value');
              },
            ),
            const SizedBox(height: 16),
            ZephyrInput(
              placeholder: '输入您的邮箱',
              prefix: const Icon(Icons.email),
              onChanged: (value) {
                print('邮箱: $value');
              },
            ),
            const SizedBox(height: 32),

            // 评分组件
            const Text(
              '评分',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ZephyrRating(
              value: 4.5,
              allowHalfRating: true,
              onChanged: (value) {
                print('评分: $value');
              },
            ),
            const SizedBox(height: 32),

            // 卡片
            const Text(
              '卡片',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ZephyrCard(
              title: '功能卡片',
              subtitle: '这是一个功能卡片',
              content: const Text(
                '这是带有自定义内容的 ZephyrCard 组件示例。',
              ),
              actions: [
                ZephyrButton(
                  text: '了解更多',
                  type: ZephyrButtonType.text,
                  onPressed: () {},
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

## 响应式设计

ZephyrUI 包含内置的响应式设计工具：

### 响应式布局

```dart
class ResponsiveHomeScreen extends StatelessWidget {
  const ResponsiveHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('响应式演示'),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          // 移动端布局
          if (sizingInformation.isMobile) {
            return _buildMobileLayout();
          }
          // 平板布局
          else if (sizingInformation.isTablet) {
            return _buildTabletLayout();
          }
          // 桌面布局
          else {
            return _buildDesktopLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildContent(),
          const SizedBox(height: 24),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildContent(),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: _buildActions(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildContent(),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 1,
            child: _buildActions(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '响应式设计',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '此布局适应不同的屏幕尺寸。',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return ZephyrCard(
      title: '主要内容',
      content: const Text(
        '这是主要内容区域。它根据屏幕大小调整其大小和布局。',
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        ZephyrButton(
          text: '主要操作',
          type: ZephyrButtonType.primary,
          onPressed: () {},
          isFullWidth: true,
        ),
        const SizedBox(height: 16),
        ZephyrButton(
          text: '次要操作',
          type: ZephyrButtonType.secondary,
          onPressed: () {},
          isFullWidth: true,
        ),
      ],
    );
  }
}
```

## 无障碍

ZephyrUI 组件在设计时就考虑了无障碍性：

### 无障碍最佳实践

```dart
class AccessibleForm extends StatelessWidget {
  const AccessibleForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('无障碍表单'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '联系表单',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '所有字段都是必需的',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // 带有语义标签的无障碍输入
            ZephyrInput(
              placeholder: '全名',
              prefix: const Icon(Icons.person),
              semanticLabel: '输入您的全名',
              onChanged: (value) {
                print('姓名: $value');
              },
            ),
            const SizedBox(height: 16),

            // 无障碍邮箱输入
            ZephyrInput(
              placeholder: '邮箱地址',
              prefix: const Icon(Icons.email),
              semanticLabel: '输入您的邮箱地址',
              onChanged: (value) {
                print('邮箱: $value');
              },
            ),
            const SizedBox(height: 16),

            // 无障碍评分组件
            ZephyrRating(
              value: 0,
              semanticLabel: '为您的体验评分',
              onChanged: (value) {
                print('评分: $value');
              },
            ),
            const SizedBox(height: 32),

            // 无障碍按钮
            ZephyrButton(
              text: '提交表单',
              type: ZephyrButtonType.primary,
              onPressed: () {
                ZephyrToast.show(
                  context,
                  message: '表单提交成功！',
                  type: ZephyrToastType.success,
                );
              },
              semanticLabel: '提交联系表单',
            ),
          ],
        ),
      ),
    );
  }
}
```

## 测试

ZephyrUI 组件设计为可测试的：

### 组件测试示例

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrUI 组件测试', () {
    testWidgets('按钮正确显示并响应点击', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrButton(
              text: '测试按钮',
              onPressed: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      // 验证按钮显示
      expect(find.text('测试按钮'), findsOneWidget);

      // 点击按钮
      await tester.tap(find.text('测试按钮'));
      await tester.pump();

      // 验证回调被调用
      expect(wasTapped, isTrue);
    });

    testWidgets('输入字段接受文本输入', (WidgetTester tester) async {
      String inputValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              placeholder: '测试输入',
              onChanged: (value) {
                inputValue = value;
              },
            ),
          ),
        ),
      );

      // 输入文本
      await tester.enterText(find.byType(TextField), '你好世界');
      await tester.pump();

      // 验证输入被捕获
      expect(inputValue, equals('你好世界'));
    });

    testWidgets('评分组件处理用户交互', (WidgetTester tester) async {
      double ratingValue = 0.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrRating(
              value: ratingValue,
              onChanged: (value) {
                ratingValue = value;
              },
            ),
          ),
        ),
      );

      // 点击第三颗星
      await tester.tap(find.byType(Icon).at(2));
      await tester.pump();

      // 验证评分已更新
      expect(ratingValue, equals(3.0));
    });
  });
}
```

## 下一步

恭喜！您已成功设置 ZephyrUI 并创建了您的第一个组件。以下是一些建议的下一步：

### 探索更多组件

- **导航**: 尝试 `ZephyrTabs`、`ZephyrSideMenu`、`ZephyrStepper`
- **数据展示**: 探索 `ZephyrTable`、`ZephyrList`、`ZephyrTimeline`
- **高级**: 查看 `ZephyrTour`、`ZephyrTree`、`ZephyrAutoComplete`

### 学习高级功能

- [主题自定义](../theming.md)
- [响应式设计](../responsive-design.md)
- [无障碍指南](../accessibility.md)
- [性能优化](../performance.md)

### 构建实际应用

1. **待办事项应用**: 使用 `ZephyrInput`、`ZephyrButton`、`ZephyrList`
2. **电子商务**: 使用 `ZephyrCard`、`ZephyrRating`、`ZephyrTable`
3. **仪表板**: 使用 `ZephyrGrid`、`ZephyrStatistic`、`ZephyrChart`

## 需要帮助？

如果您遇到任何问题或有疑问：

1. 查看[文档](../README.md)
2. 搜索现有的[问题](https://github.com/agions/zephyr_ui/issues)
3. 加入我们的[讨论](https://github.com/agions/zephyr_ui/discussions)

祝您使用 ZephyrUI 编码愉快！🚀
