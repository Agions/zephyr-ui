---
title: Space 间距
description: VelocityUI Space 组件，用于设置组件间距
---

# Space 间距

用于设置组件间距，提供简便的写法。

## 基本用法

```dart
// 垂直间距
VelocitySpace.vertical(16)

// 水平间距
VelocitySpace.horizontal(16)
```

## 预设尺寸

```dart
VelocitySpace.xs  // 4
VelocitySpace.sm  // 8
VelocitySpace.md  // 16
VelocitySpace.lg  // 24
VelocitySpace.xl  // 32
```

## 自动间距容器

`VelocityRow` 和 `VelocityColumn` 可以自动为子组件添加间距。

```dart
VelocityRow(
  spacing: 16,
  children: [
    Button1(),
    Button2(),
  ],
)
```

## API

### VelocitySpace

| 构造函数 | 说明 |
|----------|------|
| VelocitySpace({width, height}) | 自定义宽高 |
| VelocitySpace.horizontal(size) | 仅水平宽度 |
| VelocitySpace.vertical(size) | 仅垂直高度 |

### VelocityRow / VelocityColumn

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| children | ZephyrList<Widget> | - | 子组件列表 (必填) |
| spacing | double | 0 | 子组件间距 |
| mainAxisAlignment | MainAxisAlignment | - | 主轴对齐 |
| crossAxisAlignment | CrossAxisAlignment | - | 交叉轴对齐 |
