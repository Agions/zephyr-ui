---
title: Image 图片
description: VelocityUI Image 组件，增强版图片展示
---

# Image 图片

增强版图片展示，支持圆角、占位图和错误状态。

## 基本用法

```dart
VelocityImage(
  src: 'https://picsum.photos/300/200',
  width: 300,
  height: 200,
)
```

## 圆角图片

```dart
VelocityImage(
  src: '...',
  style: VelocityImageStyle(
    borderRadius: BorderRadius.circular(8),
  ),
)
```

## 占位与错误

```dart
VelocityImage(
  src: '...',
  placeholder: CircularProgressIndicator(),
  errorWidget: ZephyrIcon(Icons.error),
)
```

## API

### VelocityImage

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| src | String? | - | 图片地址 (支持网络和本地) |
| width | double? | - | 宽度 |
| height | double? | - | 高度 |
| fit | BoxFit | cover | 填充方式 |
| placeholder | Widget? | - | 加载占位组件 |
| errorWidget | Widget? | - | 错误占位组件 |
| style | VelocityImageStyle? | - | 自定义样式 |
