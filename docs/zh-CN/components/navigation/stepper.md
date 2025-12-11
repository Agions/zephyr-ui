---
title: Stepper 步骤条
description: VelocityUI Stepper 组件，引导用户按照流程完成任务
---

# Stepper 步骤条

引导用户按照流程完成任务的导航条。

## 基本用法

```dart
VelocityStepper(
  currentStep: 1,
  steps: [
    VelocityStep(title: '步骤一', subtitle: '基本信息'),
    VelocityStep(title: '步骤二', subtitle: '详细信息'),
    VelocityStep(title: '步骤三', subtitle: '确认提交'),
  ],
  onStepTap: (index) {
    setState(() => _currentStep = index);
  },
)
```

## 垂直方向

```dart
VelocityStepper(
  direction: VelocityStepperDirection.vertical,
  currentStep: _currentStep,
  steps: [
    VelocityStep(title: '下单', content: ZephyrText('订单已提交')),
    VelocityStep(title: '配送', content: ZephyrText('正在配送中')),
    VelocityStep(title: '签收', content: ZephyrText('已签收')),
  ],
)
```

## 步骤状态

系统会自动根据 `currentStep` 判断状态，也可以手动指定：

```dart
VelocityStep(
  title: '错误步骤',
  status: VelocityStepStatus.error,
)
```

## API

### VelocityStepper

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| steps | ZephyrList<VelocityStep> | - | 步骤列表 (必填) |
| currentStep | int | - | 当前步骤索引 (必填) |
| direction | VelocityStepperDirection | horizontal | 方向 |
| onStepTap | ValueChanged<int>? | - | 点击步骤回调 |
| style | VelocityStepperStyle? | - | 自定义样式 |

### VelocityStep

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| title | String | - | 标题 (必填) |
| subtitle | String? | - | 副标题 |
| content | Widget? | - | 内容 (仅垂直模式显示) |
| status | VelocityStepStatus? | - | 状态 |

### VelocityStepStatus

| 类型 | 说明 |
|------|------|
| wait | 等待中 |
| process | 进行中 |
| finish | 已完成 |
| error | 错误 |
