---
title: Skeleton 骨架屏
description: VelocityUI Skeleton 组件，加载时的占位展示
---

# Skeleton 骨架屏

在需要等待加载内容的位置提供一个占位图形组合。

## 基本用法

```dart
VelocitySkeleton(
  width: 200,
  height: 20,
)
```

## 圆形骨架

```dart
VelocitySkeleton(
  width: 50,
  height: 50,
  circle: true,
)
```

## 骨架容器

方便地在加载中和加载完成状态间切换。

```dart
VelocitySkeletonContainer(
  loading: true, // 控制显示骨架屏还是子组件
  skeleton: Column(
    children: [
      VelocitySkeleton(width: 100, height: 20),
      VelocitySkeleton(width: 80, height: 20),
    ],
  ),
  child: ZephyrText('加载完成的内容'),
)
```

## 预置骨架

```dart
// 列表骨架
VelocityListSkeleton(itemCount: 5)

// 卡片骨架
VelocityCardSkeleton()
```

## API

### VelocitySkeleton

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| width | double? | - | 宽度 |
| height | double | 16 | 高度 |
| circle | bool | false | 是否圆形 |
| borderRadius | BorderRadius? | - | 圆角 |
| style | VelocitySkeletonStyle? | - | 自定义样式 |

### VelocitySkeletonContainer

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| loading | bool | - | 是否加载中 (必填) |
| skeleton | Widget | - | 骨架屏组件 (必填) |
| child | Widget | - | 实际内容组件 (必填) |
