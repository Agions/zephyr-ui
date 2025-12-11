---
title: Rate 评分
description: VelocityUI Rate 组件，评分输入
---

# Rate 评分

评分输入。

## 基本用法

```dart
VelocityRate(
  value: 3,
  onChanged: (val) {
    print(val);
  },
)
```

## 半星选择

```dart
VelocityRate(
  value: 3.5,
  allowHalf: true,
  onChanged: (val) {},
)
```

## 自定义图标

```dart
VelocityRate(
  value: 4,
  character: Icons.favorite, // 爱心图标
  style: VelocityRateStyle(activeColor: Colors.red),
  onChanged: (val) {},
)
```

## API

### VelocityRate

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | double | - | 当前值 (必填) |
| onChanged | ValueChanged<double>? | - | 值改变回调 |
| count | int | 5 | 总数 |
| allowHalf | bool | false | 是否允许半选 |
| disabled | bool | false | 是否禁用 |
| character | IconData? | - | 自定义图标 |
| style | VelocityRateStyle? | - | 自定义样式 |
