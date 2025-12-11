---
title: Empty 空状态
description: VelocityUI Empty 组件，用于空数据或异常展示
---

# Empty 空状态

用于空数据或异常展示。

## 基本用法

```dart
// 默认显示"暂无数据"
VelocityEmpty()
```

## 不同类型

```dart
VelocityEmpty(type: VelocityEmptyType.noNetwork)
VelocityEmpty(type: VelocityEmptyType.noSearch)
VelocityEmpty(type: VelocityEmptyType.error)
```

## 带操作按钮

```dart
VelocityEmpty(
  type: VelocityEmptyType.error,
  actionText: '重试',
  onAction: () {
    // 重试逻辑
  },
)
```

## 自定义

```dart
VelocityEmpty(
  type: VelocityEmptyType.custom,
  icon: Icons.shopping_cart,
  title: '购物车空空的',
  description: '去逛逛吧',
)
```

## API

### VelocityEmpty

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| type | VelocityEmptyType | noData | 类型 |
| icon | IconData? | - | 自定义图标 |
| title | String? | - | 自定义标题 |
| description | String? | - | 自定义描述 |
| action | Widget? | - | 自定义操作组件 |
| actionText | String? | - | 操作按钮文本 |
| onAction | VoidCallback? | - | 操作点击回调 |
| style | VelocityEmptyStyle? | - | 自定义样式 |

### VelocityEmptyType

| 类型 | 说明 |
|------|------|
| noData | 暂无数据 |
| noNetwork | 网络错误 |
| noSearch | 无搜索结果 |
| error | 通用错误 |
| custom | 自定义 |
