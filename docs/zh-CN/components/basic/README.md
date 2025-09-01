---
title: 基础组件
description: ZephyrUI 基础组件，包括按钮、文本、图标、头像等基础 UI 元素
---

# 基础组件

基础组件是构建用户界面的基本元素，提供了丰富的样式和交互选项。

## 📦 组件列表

| 组件 | 描述 | 链接 |
|------|------|------|
| [按钮](./button) | 支持多种样式和状态的按钮组件 | [查看文档](./button) |
| [文本](./text) | 支持多种字体样式的文本组件 | [查看文档](./text) |
| [图标](./icon) | 支持多种图标库的图标组件 | [查看文档](./icon) |
| [头像](./avatar) | 支持图片和文字头像的头像组件 | [查看文档](./avatar) |
| [徽章](./badge) | 支持多种样式的徽章组件 | [查看文档](./badge) |
| [卡片](./card) | 支持阴影和圆角的卡片组件 | [查看文档](./card) |
| [分割线](./divider) | 用于分隔内容的分割线组件 | [查看文档](./divider) |
| [标签](./tag) | 用于标记和分类的标签组件 | [查看文档](./tag) |
| [提示框](./tooltip) | 鼠标悬停时显示的提示框组件 | [查看文档](./tooltip) |

## 🎯 使用示例

### 基本布局
```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class BasicComponentsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基础组件示例'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 按钮示例
            Text('按钮组件', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ZephyrButton(
                  onPressed: () {},
                  child: Text('主要按钮'),
                  variant: ZephyrVariant.primary,
                ),
                ZephyrButton(
                  onPressed: () {},
                  child: Text('次要按钮'),
                  variant: ZephyrVariant.secondary,
                ),
                ZephyrButton(
                  onPressed: () {},
                  child: Text('危险按钮'),
                  variant: ZephyrVariant.danger,
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // 文本示例
            Text('文本组件', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZephyrText(
                  '标题文本',
                  variant: ZephyrTextVariant.headline1,
                ),
                ZephyrText(
                  '正文文本',
                  variant: ZephyrTextVariant.body1,
                ),
                ZephyrText(
                  '小字文本',
                  variant: ZephyrTextVariant.caption,
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // 图标示例
            Text('图标组件', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 8),
            Wrap(
              spacing: 16,
              children: [
                ZephyrIcon(
                  Icons.home,
                  size: 24,
                  color: Colors.blue,
                ),
                ZephyrIcon(
                  Icons.star,
                  size: 32,
                  color: Colors.orange,
                ),
                ZephyrIcon(
                  Icons.heart,
                  size: 40,
                  color: Colors.red,
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // 头像示例
            Text('头像组件', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 8),
            Wrap(
              spacing: 16,
              children: [
                ZephyrAvatar(
                  imageUrl: 'https://example.com/avatar1.jpg',
                  size: 40,
                ),
                ZephyrAvatar(
                  initials: 'JD',
                  size: 40,
                  backgroundColor: Colors.blue,
                ),
                ZephyrAvatar(
                  imageUrl: 'https://example.com/avatar2.jpg',
                  size: 60,
                  shape: BoxShape.circle,
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // 徽章示例
            Text('徽章组件', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 8),
            Wrap(
              spacing: 16,
              children: [
                ZephyrBadge(
                  count: 5,
                  child: ZephyrIcon(Icons.notifications),
                ),
                ZephyrBadge(
                  count: 99,
                  maxCount: 99,
                  child: ZephyrIcon(Icons.mail),
                ),
                ZephyrBadge(
                  text: 'NEW',
                  child: ZephyrButton(
                    onPressed: () {},
                    child: Text('新品'),
                  ),
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

## 🎨 主题定制

基础组件支持完整的主题定制，可以通过 `ZephyrThemeData` 统一配置：

```dart
final theme = ZephyrThemeData(
  // 文本主题
  textTheme: ZephyrTextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16, color: Colors.black87),
    caption: TextStyle(fontSize: 12, color: Colors.grey),
  ),
  
  // 按钮主题
  buttonTheme: ZephyrButtonThemeData(
    borderRadius: BorderRadius.circular(8),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
  
  // 图标主题
  iconTheme: ZephyrIconThemeData(
    size: 24,
    color: Colors.blue,
  ),
  
  // 头像主题
  avatarTheme: ZephyrAvatarThemeData(
    size: 40,
    backgroundColor: Colors.grey[300],
  ),
  
  // 徽章主题
  badgeTheme: ZephyrBadgeThemeData(
    backgroundColor: Colors.red,
    textColor: Colors.white,
  ),
);

// 使用主题
ZephyrApp(
  theme: theme,
  home: MyApp(),
)
```

## 📱 响应式设计

基础组件支持响应式设计，可以根据不同的设备尺寸自动调整样式：

```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    final deviceType = sizingInformation.deviceType;
    
    return Column(
      children: [
        ZephyrButton(
          onPressed: () {},
          child: Text(deviceType == DeviceType.mobile ? '移动端' : '桌面端'),
          size: deviceType == DeviceType.mobile 
              ? ZephyrSize.small 
              : ZephyrSize.medium,
        ),
        
        ZephyrText(
          '响应式文本',
          variant: deviceType == DeviceType.mobile
              ? ZephyrTextVariant.body2
              : ZephyrTextVariant.body1,
        ),
      ],
    );
  },
)
```

## 🌐 国际化

基础组件支持国际化，可以根据不同的语言环境显示不同的文本：

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
  home: BasicComponentsDemo(),
)
```

## 🧪 测试

基础组件提供了完整的测试覆盖：

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('基础组件测试', () {
    testWidgets('按钮组件测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrButton(
            onPressed: () {},
            child: Text('测试按钮'),
          ),
        ),
      );
      
      expect(find.text('测试按钮'), findsOneWidget);
      expect(find.byType(ZephyrButton), findsOneWidget);
    });

    testWidgets('文本组件测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrText(
            '测试文本',
            variant: ZephyrTextVariant.body1,
          ),
        ),
      );
      
      expect(find.text('测试文本'), findsOneWidget);
      expect(find.byType(ZephyrText), findsOneWidget);
    });

    testWidgets('图标组件测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrIcon(
            Icons.home,
            size: 24,
            color: Colors.blue,
          ),
        ),
      );
      
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byType(ZephyrIcon), findsOneWidget);
    });
  });
}
```

## 📚 相关资源

- [组件总览](../introduction) - 所有组件的概览
- [表单组件](../form) - 表单相关的组件
- [导航组件](../navigation) - 导航相关的组件
- [展示组件](../display) - 数据展示相关的组件
- [反馈组件](../feedback) - 用户反馈相关的组件
- [设计系统](../../design-system/color) - 颜色和设计规范
- [主题定制](../../guide/theme-system) - 主题定制指南

## 🤝 贡献

我们欢迎所有形式的贡献！请阅读 [贡献指南](../../guide/contributing) 了解如何参与项目开发。

## 📄 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](../../../LICENSE) 文件。