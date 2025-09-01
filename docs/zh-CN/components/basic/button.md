---
title: 按钮组件
description: ZephyrButton 组件，支持多种样式和状态的按钮组件
---

# 按钮组件 (ZephyrButton)

按钮组件是用户界面中最常用的交互元素之一，ZephyrButton 提供了丰富的样式和状态选项。

## 🎯 快速预览

```dart
ZephyrButton(
  onPressed: () {
    // 处理按钮点击
  },
  child: Text('主要按钮'),
  variant: ZephyrVariant.primary,
)
```

## 📖 使用场景

- 表单提交
- 页面导航
- 操作确认
- 功能触发
- 对话框操作

## 🎨 样式变体

### 主要按钮 (Primary)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('主要按钮'),
  variant: ZephyrVariant.primary,
)
```

### 次要按钮 (Secondary)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('次要按钮'),
  variant: ZephyrVariant.secondary,
)
```

### 警告按钮 (Warning)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('警告按钮'),
  variant: ZephyrVariant.warning,
)
```

### 危险按钮 (Danger)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('危险按钮'),
  variant: ZephyrVariant.danger,
)
```

### 成功按钮 (Success)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('成功按钮'),
  variant: ZephyrVariant.success,
)
```

### 幽灵按钮 (Ghost)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('幽灵按钮'),
  variant: ZephyrVariant.ghost,
)
```

### 文本按钮 (Text)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('文本按钮'),
  variant: ZephyrVariant.text,
)
```

## 🔧 属性参数

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `onPressed` | `VoidCallback?` | `null` | 按钮点击回调函数 |
| `child` | `Widget` | 必填 | 按钮内容 |
| `variant` | `ZephyrVariant` | `ZephyrVariant.primary` | 按钮样式变体 |
| `size` | `ZephyrSize` | `ZephyrSize.medium` | 按钮尺寸 |
| `disabled` | `bool` | `false` | 是否禁用 |
| `loading` | `bool` | `false` | 是否显示加载状态 |
| `fullWidth` | `bool` | `false` | 是否占满宽度 |
| `icon` | `Widget?` | `null` | 前置图标 |
| `suffixIcon` | `Widget?` | `null` | 后置图标 |
| `shape` | `BoxShape?` | `null` | 按钮形状 |
| `elevation` | `double?` | `null` | 阴影高度 |
| `color` | `Color?` | `null` | 自定义颜色 |
| `textColor` | `Color?` | `null` | 自定义文字颜色 |

## 📏 尺寸选项

### 小尺寸 (Small)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('小按钮'),
  size: ZephyrSize.small,
)
```

### 中尺寸 (Medium)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('中按钮'),
  size: ZephyrSize.medium,
)
```

### 大尺寸 (Large)
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('大按钮'),
  size: ZephyrSize.large,
)
```

## 🎭 状态展示

### 禁用状态
```dart
ZephyrButton(
  onPressed: null, // 或 disabled: true
  child: Text('禁用按钮'),
)
```

### 加载状态
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('加载中'),
  loading: true,
)
```

## 🎨 自定义样式

### 自定义颜色
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('自定义按钮'),
  color: Color(0xFF8B5CF6),
  textColor: Colors.white,
)
```

### 带图标按钮
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('发送'),
  icon: Icon(Icons.send),
)
```

### 全宽按钮
```dart
ZephyrButton(
  onPressed: () {},
  child: Text('全宽按钮'),
  fullWidth: true,
)
```

## 📱 响应式设计

```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    final isMobile = sizingInformation.deviceType == DeviceType.mobile;
    
    return ZephyrButton(
      onPressed: () {},
      child: Text(isMobile ? '移动端' : '桌面端'),
      size: isMobile ? ZephyrSize.small : ZephyrSize.medium,
    );
  },
)
```

## 🎭 主题定制

```dart
ZephyrButtonThemeData(
  // 默认样式
  defaultStyle: ZephyrButtonStyle(
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    borderRadius: BorderRadius.circular(8),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
  
  // 变体样式
  variants: {
    ZephyrVariant.primary: ZephyrButtonStyle(
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    ),
    ZephyrVariant.secondary: ZephyrButtonStyle(
      backgroundColor: Colors.transparent,
      textColor: Colors.blue,
      borderColor: Colors.blue,
    ),
  },
  
  // 尺寸样式
  sizes: {
    ZephyrSize.small: ZephyrButtonStyle(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      fontSize: 14,
    ),
    ZephyrSize.medium: ZephyrButtonStyle(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      fontSize: 16,
    ),
    ZephyrSize.large: ZephyrButtonStyle(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      fontSize: 18,
    ),
  },
)
```

## 🧪 测试用例

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrButton 测试', () {
    testWidgets('基本按钮渲染测试', (WidgetTester tester) async {
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

    testWidgets('按钮点击测试', (WidgetTester tester) async {
      bool clicked = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrButton(
            onPressed: () {
              clicked = true;
            },
            child: Text('点击按钮'),
          ),
        ),
      );
      
      await tester.tap(find.byType(ZephyrButton));
      await tester.pump();
      
      expect(clicked, true);
    });

    testWidgets('禁用按钮测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrButton(
            onPressed: null,
            child: Text('禁用按钮'),
          ),
        ),
      );
      
      final button = tester.widget<ZephyrButton>(find.byType(ZephyrButton));
      expect(button.disabled, true);
    });

    testWidgets('加载状态测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrButton(
            onPressed: () {},
            child: Text('加载按钮'),
            loading: true,
          ),
        ),
      );
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
```

## 📚 最佳实践

### 1. 使用语义化的变体
```dart
// ✅ 好的做法
ZephyrButton(
  onPressed: _handleSubmit,
  child: Text('提交'),
  variant: ZephyrVariant.primary,
)

ZephyrButton(
  onPressed: _handleDelete,
  child: Text('删除'),
  variant: ZephyrVariant.danger,
)

// ❌ 避免的做法
ZephyrButton(
  onPressed: _handleSubmit,
  child: Text('提交'),
  color: Colors.red, // 使用语义化的变体而不是硬编码颜色
)
```

### 2. 提供清晰的视觉反馈
```dart
// ✅ 好的做法
ZephyrButton(
  onPressed: _isLoading ? null : _handleSubmit,
  child: Text(_isLoading ? '提交中...' : '提交'),
  loading: _isLoading,
)

// ❌ 避免的做法
ZephyrButton(
  onPressed: _handleSubmit,
  child: Text('提交'),
  disabled: _isLoading, // 没有提供加载状态反馈
)
```

### 3. 保持按钮文本简洁
```dart
// ✅ 好的做法
ZephyrButton(
  onPressed: _handleSave,
  child: Text('保存'),
)

// ❌ 避免的做法
ZephyrButton(
  onPressed: _handleSave,
  child: Text('点击这里保存表单数据'), // 文本过长
)
```

## 🔗 相关组件

- [文本组件](../basic/text) - 用于按钮文本样式
- [图标组件](../basic/icon) - 用于按钮图标
- [输入框组件](../form/input) - 表单输入组件
- [选择器组件](../form/select) - 下拉选择组件

## 📝 更新日志

### v0.4.0 (2025-08-30)
- ✨ 新增按钮组件
- 🎨 支持多种样式变体
- 📱 响应式设计支持
- 🧪 完整的测试覆盖
- 📚 详细的文档说明