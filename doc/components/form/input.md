---
title: Input 输入框
description: VelocityUI Input 组件，支持多种输入类型和验证
---

# Input 输入框

文本输入框，支持单行、多行、密码、图标等多种功能。

## 基本用法

```dart
VelocityInput(
  label: '用户名',
  hint: '请输入用户名',
  controller: _controller,
)
```

## 带图标

```dart
VelocityInput(
  label: '搜索',
  prefixIcon: Icons.search,
  suffixIcon: Icons.clear,
)
```

## 密码输入

```dart
VelocityInput(
  label: '密码',
  obscureText: true,
  prefixIcon: Icons.lock,
)
```

## 文本区域 (TextArea)

```dart
VelocityTextArea(
  label: '描述',
  hint: '请输入详细描述...',
  minLines: 3,
  maxLines: 6,
)
```

## 输入验证

```dart
VelocityInput(
  label: '邮箱',
  error: _errorMessage, // 传入错误信息显示错误状态
  onChanged: (value) {
    // 验证逻辑
  },
)
```

## API

### VelocityInput

| 属性         | 类型                   | 默认值 | 说明         |
| ------------ | ---------------------- | ------ | ------------ |
| controller   | TextEditingController? | -      | 控制器       |
| label        | String?                | -      | 标签文本     |
| hint         | String?                | -      | 提示文本     |
| helper       | String?                | -      | 帮助文本     |
| error        | String?                | -      | 错误文本     |
| prefixIcon   | IconData?              | -      | 前缀图标     |
| suffixIcon   | IconData?              | -      | 后缀图标     |
| obscureText  | bool                   | false  | 是否隐藏文本 |
| enabled      | bool                   | true   | 是否启用     |
| readOnly     | bool                   | false  | 是否只读     |
| maxLines     | int                    | 1      | 最大行数     |
| maxLength    | int?                   | -      | 最大长度     |
| keyboardType | TextInputType?         | -      | 键盘类型     |
| onChanged    | ValueChanged<String>?  | -      | 内容改变回调 |
| style        | VelocityInputStyle?    | -      | 自定义样式   |

### VelocityTextArea

| 属性     | 类型 | 默认值 | 说明                     |
| -------- | ---- | ------ | ------------------------ |
| minLines | int  | 3      | 最小行数                 |
| maxLines | int  | 5      | 最大行数                 |
| ...      | ...  | ...    | 其他属性同 VelocityInput |
