---
title: 组件介绍
description: ZephyrUI 组件库概览，包含基础组件、表单组件、导航组件、展示组件和反馈组件
---

# 组件介绍

ZephyrUI 提供了丰富的企业级 Flutter UI 组件，帮助开发者快速构建高质量的移动应用。

## 📦 组件分类

### 🎨 基础组件
基础的 UI 构建块，用于构建用户界面的基本元素。

- [按钮](./basic/button) - 支持多种样式和状态的按钮组件
- [文本](./basic/text) - 支持多种字体样式的文本组件
- [图标](./basic/icon) - 支持多种图标库的图标组件
- [头像](./basic/avatar) - 支持图片和文字头像的头像组件
- [徽章](./basic/badge) - 支持多种样式的徽章组件
- [卡片](./basic/card) - 支持阴影和圆角的卡片组件
- [分割线](./basic/divider) - 用于分隔内容的分割线组件
- [标签](./basic/tag) - 用于标记和分类的标签组件
- [提示框](./basic/tooltip) - 鼠标悬停时显示的提示框组件

### 📝 表单组件
用于数据输入和表单构建的组件。

- [输入框](./form/input) - 支持多种输入类型的输入框组件
- [选择器](./form/select) - 支持下拉和搜索的选择器组件
- [复选框](./form/checkbox) - 支持多种状态的复选框组件
- [单选框](./form/radio) - 支持分组选择的单选框组件
- [开关](./form/switch) - 支持滑动切换的开关组件
- [滑块](./form/slider) - 支持数值选择的滑块组件
- [评分](./form/rating) - 支持星级评分的评分组件
- [日期选择器](./form/date_picker) - 支持日期和时间选择的日期选择器组件
- [文本域](./form/text_area) - 支持多行文本输入的文本域组件

### 🧭 导航组件
用于页面导航和路由的组件。

- [标签页](./navigation/tabs) - 支持滑动切换的标签页组件
- [底部导航栏](./navigation/bottom_navigation_bar) - 底部导航栏组件
- [侧边菜单](./navigation/side_menu) - 支持多级菜单的侧边菜单组件
- [步骤器](./navigation/stepper) - 支持线性流程的步骤器组件
- [分页器](./navigation/pagination) - 支持大数据量的分页器组件
- [导航栏](./navigation/navigation_rail) - 侧边导航栏组件
- [树形控件](./navigation/tree) - 支持层级数据的树形控件组件

### 📊 展示组件
用于数据展示和布局的组件。

- [列表](./display/list) - 支持多种样式的列表组件
- [表格](./display/table) - 支持排序和筛选的表格组件
- [日历](./display/calendar) - 支持事件管理的日历组件
- [时间线](./display/timeline) - 用于展示事件序列的时间线组件
- [统计卡片](./display/statistic) - 用于数据统计的统计卡片组件
- [头像组](./display/avatar_group) - 用于展示多个头像的头像组组件
- [轮播图](./display/carousel) - 支持自动播放的轮播图组件
- [图表](./display/charts) - 用于数据可视化的图表组件

### 💬 反馈组件
用于用户交互反馈的组件。

- [警告框](./feedback/alert) - 支持多种类型的警告框组件
- [模态框](./feedback/modal) - 支持自定义内容的模态框组件
- [提示框](./feedback/toast) - 支持多种位置的提示框组件
- [进度条](./feedback/progress) - 支持多种样式的进度条组件
- [骨架屏](./feedback/skeleton) - 支持加载状态的骨架屏组件
- [通知](./feedback/notification) - 用于系统通知的通知组件

## 🎯 使用指南

### 安装

```bash
# 添加到 pubspec.yaml
dependencies:
  zephyr_ui: ^0.4.0

# 安装依赖
flutter pub get
```

### 基本使用

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(ZephyrApp(
    theme: ZephyrThemeData.light(),
    darkTheme: ZephyrThemeData.dark(),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZephyrUI 示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZephyrButton(
              onPressed: () {
                // 处理按钮点击
              },
              child: Text('主要按钮'),
              variant: ZephyrVariant.primary,
            ),
            SizedBox(height: 16),
            ZephyrInput(
              placeholder: '请输入内容',
              onChanged: (value) {
                print('输入内容: $value');
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 主题定制

### 自定义主题

```dart
final customTheme = ZephyrThemeData(
  primaryColor: Color(0xFF6366F1),
  secondaryColor: Color(0xFF8B5CF6),
  backgroundColor: Color(0xFFF9FAFB),
  surfaceColor: Color(0xFFFFFFFF),
  errorColor: Color(0xFFEF4444),
  
  // 文字主题
  textTheme: ZephyrTextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16, color: Colors.black87),
  ),
  
  // 组件主题
  buttonTheme: ZephyrButtonThemeData(
    borderRadius: BorderRadius.circular(8),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
);

// 使用自定义主题
ZephyrApp(
  theme: customTheme,
  home: MyApp(),
)
```

## 📱 响应式设计

### 断点系统

```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    if (sizingInformation.deviceType == DeviceType.mobile) {
      return _buildMobileLayout();
    } else if (sizingInformation.deviceType == DeviceType.tablet) {
      return _buildTabletLayout();
    } else {
      return _buildDesktopLayout();
    }
  },
)
```

## 🌐 国际化

### 多语言支持

```dart
MaterialApp(
  localizationsDelegates: [
    ZephyrLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('zh', 'CN'),
    const Locale('en', 'US'),
  ],
  locale: Locale('zh', 'CN'),
)
```

## 🧪 测试

### 组件测试

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  testWidgets('ZephyrButton 点击测试', (WidgetTester tester) async {
    bool clicked = false;
    
    await tester.pumpWidget(
      MaterialApp(
        home: ZephyrButton(
          onPressed: () {
            clicked = true;
          },
          child: Text('测试按钮'),
        ),
      ),
    );
    
    await tester.tap(find.byType(ZephyrButton));
    await tester.pump();
    
    expect(clicked, true);
  });
}
```

## 📚 相关资源

- [API 参考](../api/introduction)
- [设计系统](../design-system/color)
- [最佳实践](../guide/best-practices)
- [更新日志](../changelog)
- [贡献指南](../guide/contributing)

## 🤝 贡献

我们欢迎所有形式的贡献！请阅读 [贡献指南](../guide/contributing) 了解如何参与项目开发。

## 📄 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](../../LICENSE) 文件。