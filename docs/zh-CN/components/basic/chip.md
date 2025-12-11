---
title: Chip 芯片
description: VelocityUI Chip 组件，用于展示标签、联系人或操作
---

# Chip 芯片

Chip 组件用于展示标签、联系人或操作，支持多种样式和交互。

## 基本用法

```dart
VelocityChip(label: '标签')
```

## Chip 类型

VelocityUI 提供了三种 Chip 类型：

```dart
// 填充样式 (默认)
VelocityChip(label: '填充样式', type: VelocityChipType.filled)

// 轮廓样式
VelocityChip(label: '轮廓样式', type: VelocityChipType.outlined)

// 柔和样式
VelocityChip(label: '柔和样式', type: VelocityChipType.tonal)
```

## 带图标的 Chip

```dart
// 带图标
VelocityChip(label: '设置', icon: Icons.settings)

// 带头像
VelocityChip(
  label: '头像',
  avatar: CircleAvatar(
    radius: 10,
    backgroundImage: NetworkImage('...'),
  ),
)
```

## 可删除的 Chip

```dart
VelocityChip(
  label: '可删除',
  onDelete: () {
    // 处理删除操作
  },
)
```

## 选择 Chip (ChoiceChip)

```dart
VelocityChoiceChip(
  label: '选择项',
  selected: _isSelected,
  onSelected: (selected) {
    setState(() {
      _isSelected = selected;
    });
  },
)
```

## API

### VelocityChip

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| label | String | - | 标签文本 (必填) |
| avatar | Widget? | - | 头像组件 |
| icon | IconData? | - | 图标 |
| deleteIcon | IconData? | Icons.close | 删除图标 |
| onTap | VoidCallback? | - | 点击回调 |
| onDelete | VoidCallback? | - | 删除回调 |
| selected | bool | false | 是否选中 |
| disabled | bool | false | 是否禁用 |
| type | VelocityChipType | filled | Chip 类型 |
| style | VelocityChipStyle? | - | 自定义样式 |

### VelocityChoiceChip

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| label | String | - | 标签文本 (必填) |
| selected | bool | - | 是否选中 (必填) |
| onSelected | `ValueChanged<bool>` | - | 选中状态改变回调 (必填) |
| avatar | Widget? | - | 头像组件 |
| disabled | bool | false | 是否禁用 |
| style | VelocityChipStyle? | - | 自定义样式 |

### VelocityChipType

| 类型 | 说明 |
|------|------|
| filled | 填充样式 |
| outlined | 轮廓样式 |
| tonal | 柔和样式 |
