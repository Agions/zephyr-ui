---
title: Badge 徽章
description: VelocityUI Badge 组件，出现在按钮、图标旁的数字或状态标记
---

# Badge 徽章

出现在按钮、图标旁的数字或状态标记。

## 基本用法

```dart
VelocityBadge(
  count: 5,
  child: ZephyrIcon(Icons.notifications),
)
```

## 红点徽章

不显示具体数字，只显示一个小红点。

```dart
VelocityBadge(
  dot: true,
  child: ZephyrIcon(Icons.notifications),
)
```

## 最大值

超过最大值时显示为 `max+`。

```dart
VelocityBadge(
  count: 100,
  max: 99, // 显示为 99+
  child: ZephyrIcon(Icons.notifications),
)
```

## 徽章类型

```dart
VelocityBadge(count: 5, type: VelocityBadgeType.primary)
VelocityBadge(count: 5, type: VelocityBadgeType.success)
VelocityBadge(count: 5, type: VelocityBadgeType.warning)
VelocityBadge(count: 5, type: VelocityBadgeType.error) // 默认
VelocityBadge(count: 5, type: VelocityBadgeType.info)
```

## API

### VelocityBadge

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| count | int? | - | 显示数字 |
| dot | bool | false | 是否显示红点 |
| showZero | bool | false | 当数值为 0 时是否显示 |
| max | int | 99 | 最大值 |
| type | VelocityBadgeType | error | 徽章类型 |
| offset | Offset? | - | 位置偏移 |
| child | Widget? | - | 子组件 |
| style | VelocityBadgeStyle? | - | 自定义样式 |
