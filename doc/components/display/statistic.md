---
title: Statistic 统计数值
description: VelocityUI Statistic 组件，用于展示统计数值
---

# Statistic 统计数值

用于展示统计数值。

## 基本用法

```dart
VelocityStatistic(
  title: 'Active Users',
  value: 112893,
)
```

## 带前缀和后缀

```dart
VelocityStatistic(
  title: 'Feedback',
  value: 1128,
  prefix: ZephyrIcon(Icons.thumb_up),
  suffix: '/ 100',
)
```

## 倒计时 (Countdown)

```dart
VelocityCountdown(
  endTime: DateTime.now().add(Duration(days: 2)),
  format: 'dd天 HH:mm:ss',
  onFinish: () {
    print('finished');
  },
)
```

## API

### VelocityStatistic

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| title | String? | - | 标题 |
| value | num | - | 数值 (必填) |
| precision | int | 0 | 精度 |
| prefix | Widget? | - | 前缀 |
| suffix | String? | - | 后缀 |
| trend | VelocityStatisticTrend? | - | 趋势 (up, down) |
| trendValue | String? | - | 趋势值 |
| style | VelocityStatisticStyle? | - | 自定义样式 |

### VelocityCountdown

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| endTime | DateTime | - | 结束时间 (必填) |
| format | String | HH:mm:ss | 格式 |
| onFinish | VoidCallback? | - | 结束回调 |
| style | VelocityCountdownStyle? | - | 自定义样式 |
