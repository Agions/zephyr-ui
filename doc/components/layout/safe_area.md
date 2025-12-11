---
title: SafeArea 安全区域
description: VelocityUI SafeArea 组件，自动处理刘海屏和底部区域
---

# SafeArea 安全区域

自动处理刘海屏和底部区域，确保内容不被系统元素遮挡。

## 基本用法

```dart
VelocitySafeArea(
  child: ZephyrText('安全区域内容'),
)
```

## 指定方向

可以指定只需要哪些方向的安全区域。

```dart
// 仅处理顶部
VelocitySafeArea.top(
  child: ...
)

// 仅处理底部
VelocitySafeArea.bottom(
  child: ...
)

// 处理水平方向 (Web/Pad 常见)
VelocitySafeArea.horizontal(
  child: ...
)
```

## API

### VelocitySafeArea

| 构造函数 | 说明 |
|----------|------|
| VelocitySafeArea | 自定义所有方向 |
| VelocitySafeArea.top | 仅顶部 (bottom=false) |
| VelocitySafeArea.bottom | 仅底部 (top=false) |
| VelocitySafeArea.horizontal | 仅水平 (left=true, right=true) |

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| child | Widget | - | 子组件 (必填) |
| top | bool | true | 是否应用顶部安全区域 |
| bottom | bool | true | 是否应用底部安全区域 |
| left | bool | true | 是否应用左侧安全区域 |
| right | bool | true | 是否应用右侧安全区域 |
| minimum | EdgeInsets | - | 最小边距 |
