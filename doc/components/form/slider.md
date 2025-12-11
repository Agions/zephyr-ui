---
title: Slider 滑块
description: VelocityUI Slider 组件，用于在给定范围内选择值
---

# Slider 滑块

用于在给定范围内选择一个值或一个范围。

## 基本用法

```dart
VelocitySlider(
  value: _value,
  onChanged: (value) {
    setState(() => _value = value);
  },
)
```

## 带标签和步进

```dart
VelocitySlider(
  value: _value,
  min: 0,
  max: 100,
  divisions: 10,
  showLabel: true,
  label: '${_value.toInt()}%',
  onChanged: (value) {
    setState(() => _value = value);
  },
)
```

## 范围选择 (RangeSlider)

```dart
VelocityRangeSlider(
  values: _rangeValues,
  min: 0,
  max: 100,
  showLabels: true,
  onChanged: (values) {
    setState(() => _rangeValues = values);
  },
)
```

## API

### VelocitySlider

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | double | - | 当前值 (必填) |
| onChanged | ValueChanged<double>? | - | 值改变回调 (必填) |
| min | double | 0.0 | 最小值 |
| max | double | 100.0 | 最大值 |
| divisions | int? | - | 离散分段数 |
| label | String? | - | 标签文本 |
| showLabel | bool | false | 是否显示标签 |
| disabled | bool | false | 是否禁用 |
| style | VelocitySliderStyle? | - | 自定义样式 |

### VelocityRangeSlider

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| values | RangeValues | - | 当前范围值 (必填) |
| onChanged | ValueChanged<RangeValues>? | - | 值改变回调 (必填) |
| showLabels | bool | false | 是否显示标签 |
| ... | ... | ... | 其他属性同 VelocitySlider |
