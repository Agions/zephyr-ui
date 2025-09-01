---
title: 反馈组件
description: ZephyrUI 反馈组件，包括警告框、模态框、提示框等用户反馈相关组件
---

# 反馈组件

反馈组件用于用户交互反馈，提供了丰富的提示和反馈选项。

## 📦 组件列表

| 组件 | 描述 | 链接 |
|------|------|------|
| [警告框](./alert) | 支持多种类型的警告框组件 | [查看文档](./alert) |
| [模态框](./modal) | 支持自定义内容的模态框组件 | [查看文档](./modal) |
| [提示框](./toast) | 支持多种位置的提示框组件 | [查看文档](./toast) |
| [进度条](./progress) | 支持多种样式的进度条组件 | [查看文档](./progress) |
| [骨架屏](./skeleton) | 支持加载状态的骨架屏组件 | [查看文档](./skeleton) |
| [通知](./notification) | 用于系统通知的通知组件 | [查看文档](./notification) |

## 🎯 使用示例

### 基本反馈组件
```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class FeedbackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('反馈组件示例'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 警告框
            Text('警告框', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            Column(
              children: [
                ZephyrAlert(
                  type: ZephyrAlertType.success,
                  title: '成功',
                  description: '操作成功完成',
                ),
                SizedBox(height: 8),
                ZephyrAlert(
                  type: ZephyrAlertType.warning,
                  title: '警告',
                  description: '这是一个警告信息',
                ),
                SizedBox(height: 8),
                ZephyrAlert(
                  type: ZephyrAlertType.error,
                  title: '错误',
                  description: '操作失败，请重试',
                ),
                SizedBox(height: 8),
                ZephyrAlert(
                  type: ZephyrAlertType.info,
                  title: '提示',
                  description: '这是一个提示信息',
                ),
              ],
            ),
            
            SizedBox(height: 32),
            
            // 进度条
            Text('进度条', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            Column(
              children: [
                ZephyrProgress(
                  value: 0.3,
                  type: ZephyrProgressType.linear,
                ),
                SizedBox(height: 8),
                ZephyrProgress(
                  value: 0.6,
                  type: ZephyrProgressType.linear,
                  color: Colors.green,
                ),
                SizedBox(height: 8),
                ZephyrProgress(
                  value: 0.9,
                  type: ZephyrProgressType.circular,
                ),
              ],
            ),
            
            SizedBox(height: 32),
            
            // 骨架屏
            Text('骨架屏', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            Column(
              children: [
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.text,
                  lines: 3,
                ),
                SizedBox(height: 16),
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.avatar,
                ),
                SizedBox(height: 16),
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.button,
                ),
              ],
            ),
            
            SizedBox(height: 32),
            
            // 交互按钮
            Text('交互示例', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ZephyrButton(
                  onPressed: () => _showAlert(context),
                  child: Text('显示警告框'),
                  variant: ZephyrVariant.primary,
                ),
                ZephyrButton(
                  onPressed: () => _showModal(context),
                  child: Text('显示模态框'),
                  variant: ZephyrVariant.secondary,
                ),
                ZephyrButton(
                  onPressed: () => _showToast(context),
                  child: Text('显示提示框'),
                  variant: ZephyrVariant.success,
                ),
                ZephyrButton(
                  onPressed: () => _showNotification(context),
                  child: Text('显示通知'),
                  variant: ZephyrVariant.warning,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ZephyrAlert(
        type: ZephyrAlertType.success,
        title: '操作成功',
        description: '您的操作已成功完成',
        actions: [
          ZephyrButton(
            onPressed: () => Navigator.pop(context),
            child: Text('确定'),
            variant: ZephyrVariant.primary,
          ),
        ],
      ),
    );
  }
  
  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ZephyrModal(
        title: '确认操作',
        content: Text('您确定要执行此操作吗？'),
        actions: [
          ZephyrButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'),
            variant: ZephyrVariant.secondary,
          ),
          ZephyrButton(
            onPressed: () => Navigator.pop(context),
            child: Text('确定'),
            variant: ZephyrVariant.primary,
          ),
        ],
      ),
    );
  }
  
  void _showToast(BuildContext context) {
    ZephyrToast.show(
      context: context,
      message: '操作成功完成',
      type: ZephyrToastType.success,
    );
  }
  
  void _showNotification(BuildContext context) {
    ZephyrNotification.show(
      context: context,
      title: '系统通知',
      message: '您有一条新的消息',
      type: ZephyrNotificationType.info,
    );
  }
}
```

## 🎨 主题定制

反馈组件支持完整的主题定制，可以通过 `ZephyrThemeData` 统一配置：

```dart
final theme = ZephyrThemeData(
  // 警告框主题
  alertTheme: ZephyrAlertThemeData(
    successColor: Colors.green,
    warningColor: Colors.orange,
    errorColor: Colors.red,
    infoColor: Colors.blue,
    borderRadius: BorderRadius.circular(8),
    padding: EdgeInsets.all(16),
  ),
  
  // 模态框主题
  modalTheme: ZephyrModalThemeData(
    backgroundColor: Colors.white,
    titleColor: Colors.black87,
    contentColor: Colors.black54,
    borderRadius: BorderRadius.circular(12),
    elevation: 24,
  ),
  
  // 提示框主题
  toastTheme: ZephyrToastThemeData(
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    borderRadius: BorderRadius.circular(8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
  
  // 进度条主题
  progressTheme: ZephyrProgressThemeData(
    backgroundColor: Colors.grey[300],
    activeColor: Colors.blue,
    borderRadius: BorderRadius.circular(4),
  ),
  
  // 骨架屏主题
  skeletonTheme: ZephyrSkeletonThemeData(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[100],
    borderRadius: BorderRadius.circular(4),
  ),
  
  // 通知主题
  notificationTheme: ZephyrNotificationThemeData(
    backgroundColor: Colors.white,
    titleColor: Colors.black87,
    messageColor: Colors.black54,
    borderRadius: BorderRadius.circular(8),
    elevation: 8,
  ),
);

// 使用主题
ZephyrApp(
  theme: theme,
  home: FeedbackDemo(),
)
```

## 📱 响应式设计

反馈组件支持响应式设计，可以根据不同的设备尺寸自动调整样式：

```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    final deviceType = sizingInformation.deviceType;
    
    return Column(
      children: [
        ZephyrAlert(
          type: ZephyrAlertType.info,
          title: deviceType == DeviceType.mobile ? '提示' : '系统提示',
          description: deviceType == DeviceType.mobile 
              ? '这是一个简短的提示信息' 
              : '这是一个较长的系统提示信息，包含更多的详细内容',
        ),
        
        SizedBox(height: 16),
        
        ZephyrModal(
          title: '确认操作',
          content: Text(
            deviceType == DeviceType.mobile
                ? '确定吗？'
                : '您确定要执行此操作吗？此操作不可撤销。',
          ),
          actions: [
            ZephyrButton(
              onPressed: () => Navigator.pop(context),
              child: Text('取消'),
              variant: ZephyrVariant.secondary,
            ),
            ZephyrButton(
              onPressed: () => Navigator.pop(context),
              child: Text('确定'),
              variant: ZephyrVariant.primary,
            ),
          ],
        ),
      ],
    );
  },
)
```

## 🌐 国际化

反馈组件支持国际化，可以根据不同的语言环境显示不同的文本：

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
  home: FeedbackDemo(),
)
```

## 🧪 测试

反馈组件提供了完整的测试覆盖：

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('反馈组件测试', () {
    testWidgets('警告框测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAlert(
            type: ZephyrAlertType.success,
            title: '成功',
            description: '操作成功完成',
          ),
        ),
      );
      
      expect(find.byType(ZephyrAlert), findsOneWidget);
      expect(find.text('成功'), findsOneWidget);
      expect(find.text('操作成功完成'), findsOneWidget);
    });

    testWidgets('进度条测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrProgress(
            value: 0.5,
            type: ZephyrProgressType.linear,
          ),
        ),
      );
      
      expect(find.byType(ZephyrProgress), findsOneWidget);
    });

    testWidgets('骨架屏测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrSkeleton(
            type: ZephyrSkeletonType.text,
            lines: 3,
          ),
        ),
      );
      
      expect(find.byType(ZephyrSkeleton), findsOneWidget);
    });
  });
}
```

## 📚 相关资源

- [组件总览](../introduction) - 所有组件的概览
- [基础组件](../basic) - 基础UI组件
- [表单组件](../form) - 表单相关的组件
- [导航组件](../navigation) - 导航相关的组件
- [展示组件](../display) - 数据展示相关的组件
- [用户反馈](../../guide/user-feedback) - 用户反馈指南
- [主题定制](../../guide/theme-system) - 主题定制指南

## 🤝 贡献

我们欢迎所有形式的贡献！请阅读 [贡献指南](../../guide/contributing) 了解如何参与项目开发。

## 📄 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](../../../LICENSE) 文件。