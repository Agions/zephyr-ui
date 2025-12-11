---
title: Spinner 加载动画
description: VelocityUI Spinner 组件，提供多种样式的加载动画
---

# Spinner 加载动画

用于表示加载状态的动画组件，支持多种动画效果。

## 基本用法

```dart
VelocitySpinner()
```

## 动画类型

VelocityUI 提供了多种动画类型：

```dart
// 圆形 (默认)
VelocitySpinner(type: VelocitySpinnerType.circular)

// 点状
VelocitySpinner(type: VelocitySpinnerType.dots)

// 波浪
VelocitySpinner(type: VelocitySpinnerType.wave)

// 脉冲
VelocitySpinner(type: VelocitySpinnerType.pulse)

// 环形
VelocitySpinner(type: VelocitySpinnerType.ring)
```

## 自定义尺寸和颜色

```dart
VelocitySpinner(
  size: 48,
  color: VelocityColors.primary,
)
```

## API

### VelocitySpinner

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| type | VelocitySpinnerType | circular | 动画类型 |
| size | double | 32 | 尺寸 |
| color | Color? | - | 颜色 |
| style | VelocitySpinnerStyle? | - | 自定义样式 |

### VelocitySpinnerType

| 类型 | 说明 |
|------|------|
| circular | 圆形旋转 |
| dots | 三点跳动 |
| wave | 波浪效果 |
| pulse | 脉冲效果 |
| ring | 环形旋转 |
