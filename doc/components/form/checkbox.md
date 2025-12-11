---
title: Checkbox 复选框
description: VelocityUI Checkbox 组件，用于多选操作
---

# Checkbox 复选框

用于在多个选项中进行多项选择。

## 基本用法

```dart
VelocityCheckbox(
  value: _isChecked,
  onChanged: (value) {
    setState(() => _isChecked = value);
  },
)
```

## 带标签

```dart
VelocityCheckbox(
  value: _agreed,
  label: '我已阅读并同意协议',
  onChanged: (value) {
    setState(() => _agreed = value);
  },
)
```

## 禁用状态

```dart
VelocityCheckbox(
  value: true,
  label: '禁用状态',
  disabled: true,
  onChanged: null,
)
```

## API

### VelocityCheckbox

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | bool | - | 是否选中 (必填) |
| onChanged | ValueChanged<bool>? | - | 状态改变回调 (必填) |
| label | String? | - | 标签文本 |
| disabled | bool | false | 是否禁用 |
| style | VelocityCheckboxStyle? | - | 自定义样式 |
