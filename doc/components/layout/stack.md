---
title: Stack 层叠布局
description: VelocityUI Stack 组件，简化的层叠布局和绝对定位
---

# Stack 层叠布局

简化的层叠布局和绝对定位，提供语义化的 API。

## 基本用法

```dart
VelocityStack(
  children: [
    Container(color: Colors.blue),
    VelocityPositioned.center(child: ZephyrText('Center')),
  ],
)
```

## 绝对定位

使用 `VelocityPositioned` 及其构造函数进行快速定位。

```dart
VelocityStack(
  children: [
    // 充满全屏
    VelocityPositioned.fill(
      child: Image.asset('bg.png'),
    ),
    // 居中
    VelocityPositioned.center(
      child: ZephyrText('Hello'),
    ),
    // 自定义位置
    VelocityPositioned(
      bottom: 20,
      right: 20,
      child: ZephyrIcon(Icons.add),
    ),
  ],
)
```

## API

### VelocityStack

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| children | ZephyrList<Widget> | - | 子组件列表 (必填) |
| alignment | AlignmentGeometry | topStart | 对齐方式 |
| fit | StackFit | loose | 大小调整行为 |

### VelocityPositioned

| 构造函数 | 说明 |
|----------|------|
| VelocityPositioned | 默认构造，类似 Positioned |
| VelocityPositioned.fill | 填满父容器 |
| VelocityPositioned.center | 居中 (无约束) |
