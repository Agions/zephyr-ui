---
title: VelocityDatePicker 日期选择器
description: VelocityUI 日期选择器组件，支持日期、时间和日期时间选择
---

# VelocityDatePicker 日期选择器

日期选择器组件，支持单独选择日期、时间或日期时间。

## 基本用法

```dart
VelocityDatePicker(
  label: '选择日期',
  onDateSelected: (date) {
    print('选中日期: $date');
  },
)
```

## 日期时间选择

```dart
VelocityDatePicker(
  label: '选择日期时间',
  type: VelocityDatePickerType.datetime,
  onDateSelected: (date) {
    print('选中日期时间: $date');
  },
)
```

## 时间选择

```dart
VelocityDatePicker(
  label: '选择时间',
  type: VelocityDatePickerType.time,
  onDateSelected: (date) {
    print('选中时间: $date');
  },
)
```

## 自定义格式

```dart
VelocityDatePicker(
  label: '选择日期',
  format: 'yyyy/MM/dd',
  onChanged: (value) {
    print('格式化日期: $value');
  },
)
```

## 初始值设置

```dart
VelocityDatePicker(
  label: '选择日期',
  initialDate: DateTime.now(),
  onDateSelected: (date) {
    print('选中日期: $date');
  },
)
```

## 日期范围限制

```dart
VelocityDatePicker(
  label: '选择日期',
  initialDate: DateTime.now(),
  firstDate: DateTime(2023),
  lastDate: DateTime(2025),
  onDateSelected: (date) {
    print('选中日期: $date');
  },
)
```

## API

### VelocityDatePicker

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| controller | TextEditingController? | - | 控制器 |
| label | String? | - | 标签文本 |
| hint | String? | - | 提示文本 |
| helper | String? | - | 帮助文本 |
| error | String? | - | 错误文本 |
| prefixIcon | IconData? | Icons.calendar_today | 前缀图标 |
| suffixIcon | IconData? | - | 后缀图标 |
| enabled | bool | true | 是否启用 |
| readOnly | bool | false | 是否只读 |
| format | String? | - | 自定义格式 |
| type | VelocityDatePickerType | VelocityDatePickerType.date | 选择类型 |
| initialDate | DateTime? | - | 初始日期 |
| firstDate | DateTime? | - | 最小日期 |
| lastDate | DateTime? | - | 最大日期 |
| onChanged | ValueChanged<String>? | - | 文本改变回调 |
| onDateSelected | ValueChanged<DateTime>? | - | 日期选择回调 |
| style | VelocityDatePickerStyle? | - | 自定义样式 |

### VelocityTimePicker

```dart
VelocityTimePicker(
  label: '选择时间',
  onTimeSelected: (time) {
    print('选中时间: $time');
  },
)
```

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| controller | TextEditingController? | - | 控制器 |
| label | String? | - | 标签文本 |
| hint | String? | - | 提示文本 |
| helper | String? | - | 帮助文本 |
| error | String? | - | 错误文本 |
| prefixIcon | IconData? | Icons.access_time | 前缀图标 |
| suffixIcon | IconData? | - | 后缀图标 |
| enabled | bool | true | 是否启用 |
| readOnly | bool | false | 是否只读 |
| format | String? | - | 自定义格式 |
| initialTime | TimeOfDay? | - | 初始时间 |
| onChanged | ValueChanged<String>? | - | 文本改变回调 |
| onTimeSelected | ValueChanged<TimeOfDay>? | - | 时间选择回调 |
| style | VelocityDatePickerStyle? | - | 自定义样式 |

### VelocityDatePickerType

| 枚举值 | 说明 |
|--------|------|
| date | 仅日期选择 |
| time | 仅时间选择 |
| datetime | 日期时间选择 |
