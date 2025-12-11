---
title: Radio 单选框
description: VelocityUI Radio 组件，用于单选操作
---

# Radio 单选框

用于在多个选项中进行单项选择。

## 基本用法

```dart
VelocityRadio<String>(
  value: 'A',
  groupValue: _selectedValue,
  label: '选项 A',
  onChanged: (value) {
    setState(() => _selectedValue = value);
  },
)
```

## 选项组

```dart
Column(
  children: [
    VelocityRadio(
      value: 'male',
      groupValue: _gender,
      label: '男',
      onChanged: (v) => setState(() => _gender = v),
    ),
    VelocityRadio(
      value: 'female',
      groupValue: _gender,
      label: '女',
      onChanged: (v) => setState(() => _gender = v),
    ),
  ],
)
```

## API

### VelocityRadio<T>

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | T | - | 选项值 (必填) |
| groupValue | T? | - | 当前选中值 (必填) |
| onChanged | ValueChanged<T?>? | - | 状态改变回调 (必填) |
| label | String? | - | 标签文本 |
| disabled | bool | false | 是否禁用 |
| style | VelocityRadioStyle? | - | 自定义样式 |
