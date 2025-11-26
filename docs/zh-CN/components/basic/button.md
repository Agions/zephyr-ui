---
title: 按钮组件
description: ZephyrButton 组件，支持多种样式和状态的按钮组件
---

# 按钮组件 (ZephyrButton)

按钮组件是用户界面中最常用的交互元素之一，ZephyrButton 提供了丰富的样式和状态选项。

## 🎯 快速预览

```dart
ZephyrButton.primary(
  text: '主要按钮',
  onPressed: () {
    // 处理按钮点击
  },
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
ZephyrButton.primary(
  text: '主要按钮',
  onPressed: () {
    // 处理按钮点击
  },
)
```

### 次要按钮 (Secondary)
```dart
ZephyrButton.secondary(
  text: '次要按钮',
  onPressed: () {
    // 处理按钮点击
  },
)
```

### 轮廓按钮 (Outline)
```dart
ZephyrButton.outline(
  text: '轮廓按钮',
  onPressed: () {
    // 处理按钮点击
  },
)
```

### 文本按钮 (Text)
```dart
ZephyrButton.text(
  text: '文本按钮',
  onPressed: () {
    // 处理按钮点击
  },
)
```

### 图标按钮
```dart
ZephyrButton.icon(
  icon: Icons.favorite,
  onPressed: () {
    // 处理按钮点击
  },
)
```

## 🔧 属性参数

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `text` | `String` | 必填 | 按钮显示的文本 |
| `onPressed` | `VoidCallback?` | `null` | 点击按钮时的回调 |
| `icon` | `IconData?` | `null` | 可选的图标 |
| `size` | `ZephyrButtonSize` | `ZephyrButtonSize.medium` | 按钮尺寸 |
| `isFullWidth` | `bool` | `false` | 是否占据全宽 |
| `isLoading` | `bool` | `false` | 是否处于加载状态 |
| `isDisabled` | `bool` | `false` | 是否禁用 |
| `theme` | `ZephyrButtonTheme?` | `null` | 按钮主题 |

## 📏 尺寸选项

### 小尺寸 (Small)
```dart
ZephyrButton.primary(
  text: '小按钮',
  size: ZephyrButtonSize.small,
  onPressed: () {
    // 处理按钮点击
  },
)
```

### 中尺寸 (Medium)
```dart
ZephyrButton.primary(
  text: '中按钮',
  size: ZephyrButtonSize.medium,
  onPressed: () {
    // 处理按钮点击
  },
)
```

### 大尺寸 (Large)
```dart
ZephyrButton.primary(
  text: '大按钮',
  size: ZephyrButtonSize.large,
  onPressed: () {
    // 处理按钮点击
  },
)
```

## 🎭 状态展示

### 禁用状态
```dart
ZephyrButton.primary(
  text: '禁用按钮',
  isDisabled: true,
  onPressed: () {
    // 处理按钮点击
  },
)
```

### 加载状态
```dart
ZephyrButton.primary(
  text: '加载中',
  isLoading: true,
  onPressed: () {
    // 处理按钮点击
  },
)
```

## 🎨 自定义样式

### 带图标按钮
```dart
ZephyrButton.primary(
  text: '带图标按钮',
  icon: Icons.add,
  onPressed: () {
    // 处理按钮点击
  },
)
```

### 全宽按钮
```dart
ZephyrButton.primary(
  text: '全宽按钮',
  isFullWidth: true,
  onPressed: () {
    // 处理按钮点击
  },
)
```

## 📱 响应式设计

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final isMobile = constraints.maxWidth < 600;
    
    return ZephyrButton.primary(
      text: isMobile ? '移动端' : '桌面端',
      size: isMobile ? ZephyrButtonSize.small : ZephyrButtonSize.medium,
      onPressed: () {
        // 处理按钮点击
      },
    );
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
          home: ZephyrButton.primary(
            text: '测试按钮',
            onPressed: () {},
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
          home: ZephyrButton.primary(
            text: '点击按钮',
            onPressed: () {
              clicked = true;
            },
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
          home: ZephyrButton.primary(
            text: '禁用按钮',
            isDisabled: true,
            onPressed: () {
              // 不会被调用
            },
          ),
        ),
      );
      
      final button = tester.widget<ZephyrButton>(find.byType(ZephyrButton));
      expect(button.isDisabled, true);
    });

    testWidgets('加载状态测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrButton.primary(
            text: '加载按钮',
            isLoading: true,
            onPressed: () {
              // 不会被调用
            },
          ),
        ),
      );
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
```

## 📚 最佳实践

### 1. 使用语义化的构造函数
```dart
// ✅ 好的做法
ZephyrButton.primary(
  text: '提交',
  onPressed: _handleSubmit,
)

ZephyrButton.text(
  text: '取消',
  onPressed: _handleCancel,
)

// ❌ 避免的做法
ZephyrButton._internal(
  text: '提交',
  type: ZephyrButtonType.filled,
  onPressed: _handleSubmit,
)
```

### 2. 提供清晰的视觉反馈
```dart
// ✅ 好的做法
ZephyrButton.primary(
  text: _isLoading ? '提交中...' : '提交',
  isLoading: _isLoading,
  onPressed: _isLoading ? null : _handleSubmit,
)

// ❌ 避免的做法
ZephyrButton.primary(
  text: '提交',
  onPressed: _handleSubmit,
  // 没有提供加载状态反馈
)
```

### 3. 保持按钮文本简洁
```dart
// ✅ 好的做法
ZephyrButton.primary(
  text: '保存',
  onPressed: _handleSave,
)

// ❌ 避免的做法
ZephyrButton.primary(
  text: '点击这里保存表单数据', // 文本过长
  onPressed: _handleSave,
)
```

## 🔗 相关组件

- [文本组件](../basic/text) - 用于按钮文本样式
- [图标组件](../basic/icon) - 用于按钮图标
- [输入框组件](../form/input) - 表单输入组件
- [选择器组件](../form/select) - 下拉选择组件

## 📝 更新日志

### v0.3.0 (2025-11-26)
- ✨ 新增按钮组件
- 🎨 支持多种样式变体
- 📱 响应式设计支持
- 🧪 完整的测试覆盖
- 📚 详细的文档说明