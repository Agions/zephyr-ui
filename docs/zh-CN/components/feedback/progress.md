---
title: Progress 进度条
description: VelocityUI Progress 组件，用于展示操作进度
---

# Progress 进度条

用于展示操作的当前进度。

## 基本用法

```dart
VelocityProgress(value: 0.5)
```

## 进度条类型

```dart
// 线性进度条 (默认)
VelocityProgress(type: VelocityProgressType.linear, value: 0.5)

// 圆形进度条
VelocityProgress(type: VelocityProgressType.circular, value: 0.5)
```

## 显示标签

```dart
VelocityProgress(
  value: 0.7,
  showLabel: true,
  label: '上传中',
)
```

## 步骤进度条

用于展示分步流程的进度。

```dart
VelocityStepProgress(
  currentStep: 1,
  totalSteps: 4,
  labels: ['步骤1', '步骤2', '步骤3', '步骤4'],
)
```

## API

### VelocityProgress

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | double | - | 进度值 (0.0 - 1.0) (必填) |
| type | VelocityProgressType | linear | 进度条类型 |
| showLabel | bool | false | 是否显示标签 |
| label | String? | - | 自定义标签文本 |
| style | VelocityProgressStyle? | - | 自定义样式 |

### VelocityStepProgress

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| currentStep | int | - | 当前步骤 (0开始) (必填) |
| totalSteps | int | - | 总步骤数 (必填) |
| labels | ZephyrList<String>? | - | 步骤标签 |
| style | VelocityStepProgressStyle? | - | 自定义样式 |

### VelocityProgressType

| 类型 | 说明 |
|------|------|
| linear | 线性进度条 |
| circular | 圆形进度条 |
