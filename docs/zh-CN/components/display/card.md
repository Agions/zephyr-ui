---
title: ZephyrCard 卡片
description: VelocityUI ZephyrCard 组件，通用卡片容器
---

# ZephyrCard 卡片

通用卡片容器，用于承载内容。

## 基本用法

```dart
VelocityCard(
  child: ZephyrText('卡片内容'),
)
```

## 卡片样式

VelocityUI 提供了三种卡片样式：

```dart
// 默认样式 (带阴影)
VelocityCard(child: ZephyrText('默认卡片'))

// 轮廓样式 (带边框，无阴影)
VelocityOutlinedCard(child: ZephyrText('轮廓卡片'))

// 填充样式 (带背景色，无阴影)
VelocityFilledCard(child: ZephyrText('填充卡片'))
```

## 可交互卡片

```dart
VelocityCard(
  onTap: () {
    print('点击了卡片');
  },
  child: ZephyrText('可点击卡片'),
)
```

## API

### VelocityCard

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| child | Widget? | - | 子组件 |
| onTap | VoidCallback? | - | 点击回调 |
| onLongPress | VoidCallback? | - | 长按回调 |
| style | VelocityCardStyle? | - | 自定义样式 |

### VelocityOutlinedCard / VelocityFilledCard

参数同 `VelocityCard`。
