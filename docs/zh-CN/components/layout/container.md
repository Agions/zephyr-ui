---
title: Container 容器
description: VelocityUI Container 组件，用于包含内容的容器
---

# Container 容器

用于包含内容的容器，支持统一的样式配置。

## 基本用法

```dart
VelocityContainer(
  child: ZephyrText('内容'),
)
```

## 自定义样式

支持配置背景色、圆角、边框、阴影、内边距等。

```dart
VelocityContainer(
  style: VelocityContainerStyle(
    backgroundColor: Colors.white,
    padding: EdgeInsets.all(16),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 4),
    ],
  ),
  child: ZephyrText('自定义样式容器'),
)
```

## API

### VelocityContainer

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| child | Widget? | - | 子组件 |
| width | double? | - | 宽度 |
| height | double? | - | 高度 |
| constraints | BoxConstraints? | - | 尺寸限制 |
| alignment | AlignmentGeometry? | - | 对齐方式 |
| style | VelocityContainerStyle? | - | 自定义样式 |
