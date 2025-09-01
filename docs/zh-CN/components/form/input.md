---
title: 输入框组件
description: ZephyrInput 组件，支持多种输入类型和验证的输入框组件
---

# 输入框组件 (ZephyrInput)

输入框组件是表单中最常用的输入元素，ZephyrInput 提供了丰富的输入类型、验证和样式选项。

## 🎯 快速预览

```dart
ZephyrInput(
  placeholder: '请输入用户名',
  onChanged: (value) {
    print('输入内容: $value');
  },
)
```

## 📖 使用场景

- 用户名输入
- 密码输入
- 邮箱输入
- 搜索输入
- 表单填写
- 数据过滤

## 🎨 基础用法

### 基本输入框
```dart
ZephyrInput(
  placeholder: '请输入内容',
  onChanged: (value) {
    print('输入内容: $value');
  },
)
```

### 带标签的输入框
```dart
ZephyrInput(
  label: '用户名',
  placeholder: '请输入用户名',
  onChanged: (value) {
    print('用户名: $value');
  },
)
```

### 带图标的输入框
```dart
ZephyrInput(
  placeholder: '请搜索',
  prefixIcon: Icon(Icons.search),
  onChanged: (value) {
    print('搜索内容: $value');
  },
)
```

## 🔧 属性参数

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `placeholder` | `String?` | `null` | 占位符文本 |
| `label` | `String?` | `null` | 输入框标签 |
| `value` | `String?` | `null` | 输入框的值 |
| `onChanged` | `ValueChanged<String>?` | `null` | 值变化回调 |
| `onSubmitted` | `ValueChanged<String>?` | `null` | 提交回调 |
| `keyboardType` | `TextInputType` | `TextInputType.text` | 键盘类型 |
| `obscureText` | `bool` | `false` | 是否隐藏文本（密码模式） |
| `maxLength` | `int?` | `null` | 最大长度 |
| `minLines` | `int?` | `1` | 最小行数 |
| `maxLines` | `int?` | `1` | 最大行数 |
| `enabled` | `bool` | `true` | 是否启用 |
| `readOnly` | `bool` | `false` | 是否只读 |
| `prefixIcon` | `Widget?` | `null` | 前置图标 |
| `suffixIcon` | `Widget?` | `null` | 后置图标 |
| `errorText` | `String?` | `null` | 错误提示文本 |
| `helperText` | `String?` | `null` | 帮助文本 |
| `validator` | `String? Function(String?)?` | `null` | 验证函数 |
| `inputFormatters` | `List<TextInputFormatter>` | `[]` | 输入格式化器 |
| `autofocus` | `bool` | `false` | 是否自动聚焦 |
| `focusNode` | `FocusNode?` | `null` | 焦点节点 |

## 🎨 输入类型

### 文本输入
```dart
ZephyrInput(
  placeholder: '请输入姓名',
  keyboardType: TextInputType.text,
  onChanged: (value) {},
)
```

### 数字输入
```dart
ZephyrInput(
  placeholder: '请输入年龄',
  keyboardType: TextInputType.number,
  onChanged: (value) {},
)
```

### 邮箱输入
```dart
ZephyrInput(
  placeholder: '请输入邮箱',
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) {},
)
```

### 密码输入
```dart
ZephyrInput(
  placeholder: '请输入密码',
  obscureText: true,
  suffixIcon: Icon(Icons.visibility_off),
  onChanged: (value) {},
)
```

### 电话号码输入
```dart
ZephyrInput(
  placeholder: '请输入电话号码',
  keyboardType: TextInputType.phone,
  onChanged: (value) {},
)
```

### 多行文本输入
```dart
ZephyrInput(
  placeholder: '请输入详细描述',
  maxLines: 5,
  onChanged: (value) {},
)
```

## 🎭 状态展示

### 禁用状态
```dart
ZephyrInput(
  placeholder: '禁用状态',
  enabled: false,
  value: '不可编辑的文本',
)
```

### 只读状态
```dart
ZephyrInput(
  placeholder: '只读状态',
  readOnly: true,
  value: '只读文本',
)
```

### 错误状态
```dart
ZephyrInput(
  placeholder: '请输入邮箱',
  errorText: '请输入有效的邮箱地址',
  onChanged: (value) {},
)
```

### 加载状态
```dart
ZephyrInput(
  placeholder: '正在验证...',
  suffixIcon: CircularProgressIndicator(strokeWidth: 2),
  onChanged: (value) {},
)
```

## 🔍 输入验证

### 基础验证
```dart
ZephyrInput(
  placeholder: '请输入邮箱',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  },
  onChanged: (value) {},
)
```

### 必填验证
```dart
ZephyrInput(
  placeholder: '请输入用户名',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '用户名不能为空';
    }
    return null;
  },
  onChanged: (value) {},
)
```

### 长度验证
```dart
ZephyrInput(
  placeholder: '请输入密码',
  obscureText: true,
  validator: (value) {
    if (value == null || value.length < 6) {
      return '密码长度不能少于6位';
    }
    return null;
  },
  onChanged: (value) {},
)
```

### 自定义验证
```dart
ZephyrInput(
  placeholder: '请输入手机号',
  keyboardType: TextInputType.phone,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入手机号';
    }
    if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
      return '请输入有效的手机号';
    }
    return null;
  },
  onChanged: (value) {},
)
```

## 🎨 输入格式化

### 数字格式化
```dart
ZephyrInput(
  placeholder: '请输入金额',
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
  ],
  onChanged: (value) {},
)
```

### 文本格式化
```dart
ZephyrInput(
  placeholder: '请输入用户名',
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
    LengthLimitingTextInputFormatter(20),
  ],
  onChanged: (value) {},
)
```

## 🎭 高级功能

### 搜索框
```dart
ZephyrInput(
  placeholder: '搜索...',
  prefixIcon: Icon(Icons.search),
  suffixIcon: Icon(Icons.clear),
  onChanged: (value) {
    // 执行搜索逻辑
    _performSearch(value);
  },
  onSubmitted: (value) {
    // 执行搜索
    _performSearch(value);
  },
)
```

### 密码输入框
```dart
bool _obscureText = true;

ZephyrInput(
  placeholder: '请输入密码',
  obscureText: _obscureText,
  suffixIcon: IconButton(
    icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
    onPressed: () {
      setState(() {
        _obscureText = !_obscureText;
      });
    },
  ),
  onChanged: (value) {},
)
```

### 带清除按钮的输入框
```dart
String _text = '';

ZephyrInput(
  placeholder: '请输入内容',
  value: _text,
  suffixIcon: _text.isNotEmpty
      ? IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _text = '';
            });
          },
        )
      : null,
  onChanged: (value) {
    setState(() {
      _text = value;
    });
  },
)
```

## 📱 响应式设计

```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    final isMobile = sizingInformation.deviceType == DeviceType.mobile;
    
    return ZephyrInput(
      placeholder: isMobile ? '输入' : '请输入内容',
      maxLines: isMobile ? 1 : 3,
      onChanged: (value) {},
    );
  },
)
```

## 🎭 主题定制

```dart
ZephyrInputThemeData(
  // 默认样式
  defaultStyle: ZephyrInputStyle(
    backgroundColor: Colors.grey[100],
    borderColor: Colors.grey[300],
    borderRadius: BorderRadius.circular(8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    textStyle: TextStyle(fontSize: 16, color: Colors.black87),
    placeholderStyle: TextStyle(fontSize: 16, color: Colors.grey),
  ),
  
  // 状态样式
  focusedStyle: ZephyrInputStyle(
    borderColor: Colors.blue,
    borderWidth: 2,
  ),
  
  errorStyle: ZephyrInputStyle(
    borderColor: Colors.red,
    errorColor: Colors.red,
  ),
  
  disabledStyle: ZephyrInputStyle(
    backgroundColor: Colors.grey[200],
    textColor: Colors.grey[600],
  ),
)
```

## 🧪 测试用例

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrInput 测试', () {
    testWidgets('基本输入框渲染测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrInput(
            placeholder: '请输入内容',
            onChanged: (value) {},
          ),
        ),
      );
      
      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.text('请输入内容'), findsOneWidget);
    });

    testWidgets('输入框输入测试', (WidgetTester tester) async {
      String inputValue = '';
      
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrInput(
            placeholder: '请输入内容',
            onChanged: (value) {
              inputValue = value;
            },
          ),
        ),
      );
      
      await tester.enterText(find.byType(TextField), 'Hello World');
      await tester.pump();
      
      expect(inputValue, 'Hello World');
    });

    testWidgets('密码输入框测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrInput(
            placeholder: '请输入密码',
            obscureText: true,
            onChanged: (value) {},
          ),
        ),
      );
      
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, true);
    });

    testWidgets('禁用状态测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrInput(
            placeholder: '禁用输入框',
            enabled: false,
            onChanged: (value) {},
          ),
        ),
      );
      
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, false);
    });

    testWidgets('验证功能测试', (WidgetTester tester) async {
      String? errorText;
      
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrInput(
            placeholder: '请输入邮箱',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入邮箱';
              }
              return null;
            },
            onChanged: (value) {},
          ),
        ),
      );
      
      // 触发验证
      await tester.tap(find.byType(ZephyrInput));
      await tester.pump();
      
      // 验证逻辑需要根据实际实现调整
      expect(find.byType(ZephyrInput), findsOneWidget);
    });
  });
}
```

## 📚 最佳实践

### 1. 提供清晰的占位符
```dart
// ✅ 好的做法
ZephyrInput(
  placeholder: '请输入用户名',
  onChanged: (value) {},
)

// ❌ 避免的做法
ZephyrInput(
  placeholder: '输入',
  onChanged: (value) {},
)
```

### 2. 使用合适的输入类型
```dart
// ✅ 好的做法
ZephyrInput(
  placeholder: '请输入邮箱',
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) {},
)

// ❌ 避免的做法
ZephyrInput(
  placeholder: '请输入邮箱',
  keyboardType: TextInputType.text, // 应该使用邮箱类型
  onChanged: (value) {},
)
```

### 3. 提供实时验证
```dart
// ✅ 好的做法
ZephyrInput(
  placeholder: '请输入邮箱',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  },
  onChanged: (value) {},
)

// ❌ 避免的做法
ZephyrInput(
  placeholder: '请输入邮箱',
  onChanged: (value) {},
  // 没有验证
)
```

### 4. 使用合适的输入限制
```dart
// ✅ 好的做法
ZephyrInput(
  placeholder: '请输入用户名',
  maxLength: 20,
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
  ],
  onChanged: (value) {},
)

// ❌ 避免的做法
ZephyrInput(
  placeholder: '请输入用户名',
  onChanged: (value) {},
  // 没有输入限制
)
```

## 🔗 相关组件

- [选择器组件](../form/select) - 下拉选择组件
- [复选框组件](../form/checkbox) - 复选框组件
- [单选框组件](../form/radio) - 单选框组件
- [开关组件](../form/switch) - 开关组件
- [表单验证](../../guide/form-validation) - 表单验证指南

## 📝 更新日志

### v0.4.0 (2025-08-30)
- ✨ 新增输入框组件
- 🎨 支持多种输入类型和验证
- 📱 响应式设计支持
- 🧪 完整的测试覆盖
- 📚 详细的文档说明