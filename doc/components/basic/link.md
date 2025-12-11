---
title: Link 链接
description: VelocityUI Link 组件，文字链接
---

# Link 链接

文字链接。

## 基本用法

```dart
VelocityLink(
  text: '链接文字',
  onTap: () {},
)
```

## 带图标和下划线

```dart
VelocityLink(
  text: '查看详情',
  icon: Icons.arrow_forward,
  underline: true,
  onTap: () {},
)
```

## 不同状态

```dart
VelocityLink(
  text: 'Primary Link',
  style: VelocityLinkStyle(color: VelocityColors.primary),
  onTap: () {},
)

VelocityLink(
  text: 'Disabled Link',
  disabled: true,
)
```

## API

### VelocityLink

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| text | String | - | 链接文字 (必填) |
| onTap | VoidCallback? | - | 点击回调 |
| icon | IconData? | - | 图标 |
| underline | bool | false | 是否显示下划线 |
| disabled | bool | false | 是否禁用 |
| style | VelocityLinkStyle? | - | 自定义样式 |
