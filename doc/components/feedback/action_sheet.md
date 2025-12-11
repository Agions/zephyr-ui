---
title: ActionSheet 动作面板
description: VelocityUI ActionSheet 组件，从底部弹出的动作菜单
---

# ActionSheet 动作面板

从底部弹出的动作菜单，用于某些操作的选择。

## 基本用法

```dart
VelocityActionSheet.show(
  context: context,
  actions: [
    VelocityActionSheetItem(label: '选项 1', onTap: () {}),
    VelocityActionSheetItem(label: '选项 2', onTap: () {}),
  ],
  cancelAction: VelocityActionSheetItem(label: '取消'),
)
```

## 带标题和描述

```dart
VelocityActionSheet.show(
  context: context,
  title: '确认操作',
  message: '此操作无法撤销',
  actions: [/*...*/],
  cancelAction: VelocityActionSheetItem(label: '取消'),
)
```

## 警示选项

```dart
VelocityActionSheet.show(
  context: context,
  actions: [
    VelocityActionSheetItem(
      label: '删除',
      isDestructive: true,
      onTap: () {},
    ),
  ],
)
```

## API

### VelocityActionSheet.show

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| context | BuildContext | - | 上下文 (必填) |
| title | String? | - | 标题 |
| message | String? | - | 描述信息 |
| actions | ZephyrList<VelocityActionSheetItem> | - | 动作列表 (必填) |
| cancelAction | VelocityActionSheetItem? | - | 取消动作 |
| style | VelocityActionSheetStyle? | - | 自定义样式 |

### VelocityActionSheetItem

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| label | String | - | 标签文字 (必填) |
| value | T? | - | 返回值 |
| onTap | VoidCallback? | - | 点击回调 |
| isDestructive | bool | false | 是否为警示项 (红色文字) |
