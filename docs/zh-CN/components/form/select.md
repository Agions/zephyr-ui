---
title: Select 选择器
description: VelocityUI Select 组件，用于下拉选择
---

# Select 选择器

弹出一个下拉菜单给用户选择操作。

## 基本用法

```dart
VelocitySelect<String>(
  value: _selectedValue,
  items: [
    VelocitySelectItem(value: '1', label: '选项1'),
    VelocitySelectItem(value: '2', label: '选项2'),
  ],
  label: '选择器',
  hint: '请选择',
  onChanged: (value) {
    setState(() => _selectedValue = value);
  },
)
```

## 带图标

```dart
VelocitySelect<String>(
  value: _selectedValue,
  items: [
    VelocitySelectItem(value: 'apple', label: '苹果', icon: Icons.apple),
    VelocitySelectItem(value: 'android', label: '安卓', icon: Icons.android),
  ],
  onChanged: (value) {},
)
```

## 禁用选项

```dart
VelocitySelectItem(
  value: 'disabled',
  label: '禁用选项',
  disabled: true,
)
```

## API

### VelocitySelect<T>

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | T? | - | 当前选中值 (必填) |
| items | ZephyrList<VelocitySelectItem<T>> | - | 选项列表 (必填) |
| onChanged | ValueChanged<T?>? | - | 选中回调 (必填) |
| label | String? | - | 标签文本 |
| hint | String? | - | 提示文本 |
| disabled | bool | false | 是否禁用 |
| style | VelocitySelectStyle? | - | 自定义样式 |

### VelocitySelectItem<T>

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | T | - | 选项值 (必填) |
| label | String | - | 选项标签 (必填) |
| icon | IconData? | - | 选项图标 |
| disabled | bool | false | 是否禁用该选项 |
