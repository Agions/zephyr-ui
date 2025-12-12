---
title: Badge 徽章
description: VelocityUI Badge 组件，出现在按钮、图标旁的数字或状态标记
---

# Badge 徽章

## 简介

Badge 徽章组件用于显示数字或状态标记，通常出现在按钮、图标旁，用于提示新消息、未读通知、数量统计等场景。

### 核心特性

- 支持数字显示和红点模式
- 提供5种预定义颜色类型
- 支持设置最大值，自动显示为 "max+"
- 支持位置偏移调整
- 完善的样式定制能力

### 使用场景

- 消息通知数量提示
- 未读消息标记
- 商品数量统计
- 状态指示（如在线状态）
- 操作结果提示

## 基本用法

```dart
// 带数字的徽章
VelocityBadge(
  count: 5,
  child: VelocityIcon(Icons.notifications),
)
```

## 属性配置

### 徽章类型

支持5种预定义颜色类型，用于表示不同的状态。

```dart
VelocityBadge(count: 5, type: VelocityBadgeType.primary)
VelocityBadge(count: 5, type: VelocityBadgeType.success)
VelocityBadge(count: 5, type: VelocityBadgeType.warning)
VelocityBadge(count: 5, type: VelocityBadgeType.error) // 默认
VelocityBadge(count: 5, type: VelocityBadgeType.info)
```

### 红点模式

不显示具体数字，只显示一个红点，用于简单的状态提示。

```dart
VelocityBadge(
  dot: true,
  child: VelocityIcon(Icons.notifications),
)
```

### 最大值限制

当数字超过最大值时，会显示为 "max+" 格式。

```dart
VelocityBadge(
  count: 100,
  max: 99, // 显示为 99+
  child: VelocityIcon(Icons.notifications),
)
```

### 显示零值

默认情况下，当 count 为 0 时不显示徽章，可以通过 `showZero` 属性控制显示。

```dart
// 显示 0
VelocityBadge(
  count: 0,
  showZero: true,
  child: VelocityIcon(Icons.notifications),
)
```

### 位置偏移

通过 `offset` 属性调整徽章的位置。

```dart
VelocityBadge(
  count: 5,
  offset: Offset(10, -10), // 向右上偏移
  child: VelocityIcon(Icons.notifications),
)
```

## 高级用法

### 独立徽章

徽章可以不依赖子组件，独立显示。

```dart
// 独立显示的徽章
VelocityBadge(
  count: 5,
  type: VelocityBadgeType.success,
)
```

### 徽章组合使用

徽章可以与各种组件组合使用，如按钮、卡片、列表项等。

```dart
// 与按钮组合
VelocityButton(
  child: Text('按钮'),
  suffix: VelocityBadge(count: 5, dot: true),
)

// 与列表项组合
VelocityList(
  children: [
    VelocityListItem(
      title: Text('消息'),
      trailing: VelocityBadge(count: 12),
    ),
  ],
)
```

### 自定义样式

通过 `style` 属性可以完全自定义徽章的样式。

```dart
VelocityBadge(
  count: 5,
  style: VelocityBadgeStyle(
    backgroundColor: Colors.purple,
    textColor: Colors.white,
    fontSize: 10,
    padding: EdgeInsets.symmetric(horizontal: 6),
    borderRadius: BorderRadius.circular(10),
  ),
  child: VelocityIcon(Icons.notifications),
)
```

## 样式定制

### 自定义颜色

```dart
VelocityBadge(
  count: 5,
  style: VelocityBadgeStyle(
    backgroundColor: Colors.orange,
    textColor: Colors.white,
  ),
  child: VelocityIcon(Icons.notifications),
)
```

### 自定义大小

```dart
VelocityBadge(
  count: 5,
  style: VelocityBadgeStyle(
    fontSize: 12,
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  ),
  child: VelocityIcon(Icons.notifications),
)
```

## 可访问性

- 为徽章添加 `semanticLabel` 属性，提高屏幕阅读器的可访问性
- 确保徽章内容与上下文相关，避免混淆
- 对于红点模式，应提供额外的文本说明

## 最佳实践

- **数量显示**：对于大量未读消息，建议设置合理的最大值（如99），避免数字过长影响美观
- **颜色选择**：根据消息类型选择合适的徽章颜色，如错误信息使用红色，成功信息使用绿色
- **位置摆放**：徽章应放置在相关组件的右上角，符合用户的视觉习惯
- **视觉层次**：徽章的视觉重量应适中，既能够引起注意，又不喧宾夺主
- **交互反馈**：点击徽章后应及时更新或清除徽章内容

## 常见问题

### 问题：徽章不显示？

**症状**：设置了 count 但徽章不显示

**原因**：可能是 count 为 0 且 showZero 为 false

**解决方案**：
1. 检查 count 值是否大于 0
2. 如果需要显示 0，设置 showZero: true
3. 确保 child 组件正确渲染

### 问题：徽章位置不正确？

**症状**：徽章显示位置偏离预期

**原因**：默认位置可能不适合所有场景

**解决方案**：
1. 通过 offset 属性调整徽章位置
2. 确保父组件的定位方式正确
3. 对于复杂布局，考虑使用自定义样式

## API 参考

### VelocityBadge

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| key | Key? | - | 组件的唯一标识符 |
| count | int? | - | 显示数字 |
| dot | bool | false | 是否显示红点 |
| showZero | bool | false | 当数值为 0 时是否显示 |
| max | int | 99 | 最大值 |
| type | VelocityBadgeType | error | 徽章类型 |
| offset | Offset? | - | 位置偏移 |
| child | Widget? | - | 子组件 |
| semanticLabel | String? | - | 无障碍标签 |
| style | VelocityBadgeStyle? | - | 自定义样式 |

### VelocityBadgeStyle

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| backgroundColor | Color? | - | 背景颜色 |
| textColor | Color? | Colors.white | 文字颜色 |
| fontSize | double | 12 | 文字大小 |
| padding | EdgeInsets | EdgeInsets.symmetric(horizontal: 6) | 内边距 |
| borderRadius | BorderRadius | BorderRadius.circular(10) | 边框圆角 |
| minWidth | double | 20 | 最小宽度 |
| height | double | 20 | 高度 |

### 枚举类型

```dart
enum VelocityBadgeType {
  primary, // 主要颜色
  success, // 成功颜色
  warning, // 警告颜色
  error,   // 错误颜色
  info,    // 信息颜色
}
```

## 相关组件

- [Button 按钮](/components/basic/button)
- [Icon 图标](/components/basic/icon)
- [List 列表](/components/display/list)

## 更新日志

### v1.0.0

- 初始版本发布
- 支持数字显示和红点模式
- 提供5种预定义颜色类型
- 支持最大值设置和位置偏移

---

::: tip 提示

徽章的视觉效果会受到父组件布局的影响，对于复杂布局，建议使用 offset 属性调整位置。

:::
