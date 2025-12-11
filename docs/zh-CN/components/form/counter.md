---
title: Counter 计数器
description: VelocityUI Counter 组件，数字输入/计数器
---

# Counter 计数器

数字输入/计数器。

## 基本用法

```dart
VelocityCounter(
  value: count,
  onChanged: (val) {
    setState(() => count = val);
  },
)
```

## 设置步长和范围

```dart
VelocityCounter(
  value: count,
  min: 0,
  max: 100,
  step: 5,
  onChanged: (val) {},
)
```

## API

### VelocityCounter

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | int | - | 当前值 (必填) |
| onChanged | ValueChanged<int> | - | 值改变回调 (必填) |
| min | int | 0 | 最小值 |
| max | int | 99999 | 最大值 |
| step | int | 1 | 步长 |
| disabled | bool | false | 是否禁用 |
| showInput | bool | true | 是否显示输入框 |
| style | VelocityCounterStyle? | - | 自定义样式 |
