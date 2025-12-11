---
title: Avatar 头像
description: VelocityUI Avatar 组件，用于展示用户或事物头像
---

# Avatar 头像

用于展示用户、品牌或事物的头像。

## 基本用法

```dart
VelocityAvatar(
  imageUrl: 'https://example.com/avatar.png',
)
```

## 头像类型

支持图片、文字和图标三种类型。

```dart
// 图片头像
VelocityAvatar(imageUrl: '...')

// 文字头像 (自动提取首字母)
VelocityAvatar(name: 'Velocity UI')

// 图标头像
VelocityAvatar(icon: Icons.person)
```

## 头像尺寸

VelocityUI 提供了 5 种预置尺寸，同时也支持自定义尺寸。

```dart
VelocityAvatar(size: VelocityAvatarSize.xs) // 24px
VelocityAvatar(size: VelocityAvatarSize.sm) // 32px
VelocityAvatar(size: VelocityAvatarSize.md) // 40px (默认)
VelocityAvatar(size: VelocityAvatarSize.lg) // 48px
VelocityAvatar(size: VelocityAvatarSize.xl) // 64px

// 自定义尺寸
VelocityAvatar(customSize: 100)
```

## 头像形状

```dart
VelocityAvatar(shape: VelocityAvatarShape.circle) // 圆形 (默认)
VelocityAvatar(shape: VelocityAvatarShape.square) // 方形
VelocityAvatar(shape: VelocityAvatarShape.rounded) // 圆角方形
```

## 头像组 (AvatarGroup)

多个头像叠在一起显示。

```dart
VelocityAvatarGroup(
  avatars: [
    VelocityAvatar(name: 'A'),
    VelocityAvatar(name: 'B'),
    VelocityAvatar(name: 'C'),
  ],
  max: 3, // 最多显示数量
)
```

## API

### VelocityAvatar

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| imageUrl | String? | - | 图片地址 |
| name | String? | - | 名称 (用于生成文字头像) |
| icon | IconData? | - | 图标 |
| size | VelocityAvatarSize | md | 尺寸 |
| shape | VelocityAvatarShape | circle | 形状 |
| customSize | double? | - | 自定义尺寸 |
| onTap | VoidCallback? | - | 点击回调 |
| style | VelocityAvatarStyle? | - | 自定义样式 |

### VelocityAvatarGroup

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| avatars | ZephyrList<VelocityAvatar> | - | 头像列表 (必填) |
| max | int | 5 | 最大显示数量 |
| size | VelocityAvatarSize | md | 尺寸 |
| overlap | double | 8 | 重叠距离 |
| style | VelocityAvatarGroupStyle? | - | 自定义样式 |
