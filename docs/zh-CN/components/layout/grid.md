---
title: ZephyrGrid 网格
description: VelocityUI ZephyrGrid 组件，网格布局系统
---

# ZephyrGrid 网格

网格布局系统。

## 基本用法

```dart
VelocityGrid(
  columns: 2, // 列数
  mainAxisSpacing: 10, // 主轴间距
  crossAxisSpacing: 10, // 交叉轴间距
  children: [
    // ... 子组件列表
  ],
)
```

## 响应式网格 (ResponsiveGrid)

根据容器宽度自动计算列数。

```dart
VelocityResponsiveGrid(
  minItemWidth: 150, // 最小子项宽度
  children: [
    // ... 子组件列表
  ],
)
```

## 流式布局 (Wrap)

```dart
VelocityWrap(
  spacing: 8,
  runSpacing: 8,
  children: [
    Chip(label: ZephyrText('Tag 1')),
    Chip(label: ZephyrText('Tag 2')),
  ],
)
```

## API

### VelocityGrid

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| children | ZephyrList<Widget> | - | 子组件列表 (必填) |
| columns | int | 2 | 列数 |
| mainAxisSpacing | double | 16 | 主轴间距 |
| crossAxisSpacing | double | 16 | 交叉轴间距 |
| childAspectRatio | double | 1 | 子项宽高比 |
| padding | EdgeInsets? | - | 内边距 |
| shrinkWrap | bool | false | 是否自适应高度 |
| physics | ScrollPhysics? | - | 滚动物理效果 |

### VelocityResponsiveGrid

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| minItemWidth | double | 150 | 最小子项宽度 |
| ... | ... | ... | 其他属性类似 VelocityGrid |
