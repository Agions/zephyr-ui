---
title: Timeline 时间线
description: VelocityUI Timeline 组件，可视化地呈现时间流信息
---

# Timeline 时间线

可视化地呈现时间流信息。

## 基本用法

```dart
VelocityTimeline(
  items: [
    VelocityTimelineItem(
      label: '2023-01-01',
      content: ZephyrText('创建项目'),
    ),
    VelocityTimelineItem(
      label: '2023-02-01',
      content: ZephyrText('发布 v1.0'),
    ),
  ],
)
```

## 自定义颜色与图标

```dart
VelocityTimelineItem(
  icon: Icons.check,
  color: Colors.green,
  content: ZephyrText('完成'),
)
```

## 幽灵节点

```dart
VelocityTimelineItem(
  hollow: true,
  content: ZephyrText('待办事项'),
)
```

## API

### VelocityTimeline

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| items | ZephyrList<VelocityTimelineItem> | - | 时间轴项列表 (必填) |
| reverse | bool | false | 是否倒序 |
| style | VelocityTimelineStyle? | - | 自定义样式 |

### VelocityTimelineItem

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| label | String? | - | 标签 |
| time | String? | - | 时间 |
| content | Widget? | - | 内容 |
| icon | IconData? | - | 图标 |
| color | Color? | - | 颜色 |
| hollow | bool | false | 是否空心 (幽灵节点) |
