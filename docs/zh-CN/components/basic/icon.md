---
title: ZephyrIcon 图标
description: VelocityUI ZephyrIcon 组件，提供统一的图标展示风格
---

# ZephyrIcon 图标

用于展示图标的组件，提供统一的尺寸和样式管理。

## 基本用法

```dart
VelocityIcon(Icons.home)
```

## 图标尺寸

VelocityUI 提供了五种预置尺寸：

```dart
VelocityIcon(Icons.home, size: VelocityIconSize.xs) // 14px
VelocityIcon(Icons.home, size: VelocityIconSize.sm) // 18px
VelocityIcon(Icons.home, size: VelocityIconSize.md) // 24px (默认)
VelocityIcon(Icons.home, size: VelocityIconSize.lg) // 32px
VelocityIcon(Icons.home, size: VelocityIconSize.xl) // 48px
```

也可以使用 `customSize` 自定义尺寸：

```dart
VelocityIcon(Icons.home, customSize: 64)
```

## 图标颜色

```dart
VelocityIcon(Icons.favorite, color: VelocityColors.error)
```

## API

### VelocityIcon

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| icon | IconData | - | 图标数据 (必填) |
| size | VelocityIconSize | md | 图标尺寸 |
| customSize | double? | - | 自定义尺寸 |
| color | Color? | - | 图标颜色 |
| style | VelocityIconStyle? | - | 自定义样式 |
| semanticLabel | String? | - | 语义标签 |

### VelocityIconSize

| 尺寸 | 大小 |
|------|------|
| xs | 14px |
| sm | 18px |
| md | 24px |
| lg | 32px |
| xl | 48px |
