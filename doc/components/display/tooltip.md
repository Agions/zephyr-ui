---
title: Tooltip 文字提示
description: VelocityUI Tooltip 组件，简单的文字提示气泡
---

# Tooltip 文字提示

简单的文字提示气泡。

## 基本用法

```dart
VelocityTooltip(
  message: '提示信息',
  child: Text('长按我'),
)
```

## 气泡弹窗 (Popover)

点击或长按触发的更复杂的气泡。

```dart
VelocityPopover(
  content: Column(
    children: [
      ZephyrText('选项 1'),
      ZephyrText('选项 2'),
    ],
  ),
  child: ZephyrButton('点击弹出'),
)
```

## API

### VelocityTooltip

| 属性        | 类型                    | 默认值 | 说明            |
| ----------- | ----------------------- | ------ | --------------- |
| message     | String                  | -      | 提示文字 (必填) |
| child       | Widget                  | -      | 子组件 (必填)   |
| position    | VelocityTooltipPosition | top    | 位置            |
| richMessage | InlineSpan?             | -      | 富文本提示      |
| style       | VelocityTooltipStyle?   | -      | 自定义样式      |

### VelocityPopover

| 属性     | 类型                    | 默认值 | 说明                      |
| -------- | ----------------------- | ------ | ------------------------- |
| content  | Widget                  | -      | 弹出内容 (必填)           |
| child    | Widget                  | -      | 触发组件 (必填)           |
| position | VelocityTooltipPosition | bottom | 位置                      |
| trigger  | VelocityPopoverTrigger  | tap    | 触发方式 (tap, longPress) |
| style    | VelocityTooltipStyle?   | -      | 自定义样式                |
