---
title: Divider 分隔线
description: VelocityUI Divider 组件，用于分隔区隔内容
---

# Divider 分隔线

用于将内容分隔为多个区域。

## 基本用法

```dart
// 水平分隔线
VelocityDivider()

// 垂直分隔线
VelocityDivider(vertical: true)
```

## 自定义样式

```dart
VelocityDivider(
  style: VelocityDividerStyle(
    color: Colors.red,
    thickness: 2,
    margin: EdgeInsets.symmetric(vertical: 20),
  ),
)
```

## API

### VelocityDivider

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| vertical | bool | false | 是否垂直 |
| style | VelocityDividerStyle? | - | 自定义样式 |
