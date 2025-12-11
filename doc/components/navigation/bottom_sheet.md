---
title: BottomSheet 底部面板
description: VelocityUI BottomSheet 组件，从底部弹出的面板
---

# BottomSheet 底部面板

从底部弹出的面板，比 ActionSheet 更灵活，可承载复杂内容。

## 基本用法

```dart
VelocityBottomSheet.show(
  context: context,
  title: '标题',
  child: ZephyrText('内容区域...'),
)
```

## 操作列表模式

```dart
VelocityBottomSheet.showActions(
  context: context,
  actions: [
    VelocityBottomSheetAction(label: '分享', icon: Icons.share, onTap: () {}),
    VelocityBottomSheetAction(label: '复制', icon: Icons.copy, onTap: () {}),
  ],
  cancelText: '取消',
)
```

## API

### VelocityBottomSheet.show

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| context | BuildContext | - | 上下文 (必填) |
| child | Widget | - | 内容组件 (必填) |
| title | String? | - | 标题 |
| height | double? | - | 高度 |
| showHandle | bool | true | 是否显示拖拽手柄 |
| showCloseButton | bool | false | 是否显示关闭按钮 |
| style | VelocityBottomSheetStyle? | - | 自定义样式 |

### VelocityBottomSheet.showActions

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| actions | ZephyrList<VelocityBottomSheetAction> | - | 动作列表 (必填) |
| cancelText | String? | - | 取消按钮文本 |
