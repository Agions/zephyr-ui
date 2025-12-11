---
title: Segmented 分段控制器
description: VelocityUI Segmented 组件，分段控制器
---

# Segmented 分段控制器

分段控制器。

## 基本用法

```dart
VelocitySegmented<int>(
  value: selectedValue,
  segments: [
    VelocitySegment(value: 0, label: '日报'),
    VelocitySegment(value: 1, label: '周报'),
    VelocitySegment(value: 2, label: '月报'),
  ],
  onChanged: (val) {
    setState(() => selectedValue = val);
  },
)
```

## API

### VelocitySegmented

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | T | - | 当前选中值 (必填) |
| segments | ZephyrList<VelocitySegment<T>> | - | 分段列表 (必填) |
| onChanged | ValueChanged<T> | - | 值改变回调 (必填) |
| disabled | bool | false | 是否禁用 |
| style | VelocitySegmentedStyle? | - | 自定义样式 |

### VelocitySegment

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | T | - | 值 (必填) |
| label | String | - | 标签 (必填) |
| icon | IconData? | - | 图标 |
| disabled | bool | false | 是否禁用该项 |
