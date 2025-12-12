---
title: Avatar 头像
description: VelocityUI Avatar 组件，用于展示用户或事物头像
---

# Avatar 头像

## 简介

Avatar 头像组件用于展示用户、品牌或事物的形象，支持多种类型和样式定制，适用于个人资料、团队成员展示、评论区等场景。

### 核心特性

- 支持图片、文字和图标三种头像类型
- 提供 5 种预置尺寸和自定义尺寸选项
- 支持圆形、方形和圆角方形三种形状
- 支持头像组展示，自动处理重叠效果
- 完善的样式定制能力

### 使用场景

- 个人中心页面的用户头像
- 评论区的用户头像
- 团队成员展示列表
- 社交媒体分享的用户头像
- 品牌标识展示

## 基本用法

```dart
// 图片头像
VelocityAvatar(
  imageUrl: 'https://example.com/avatar.png',
  onTap: () {
    // 点击事件处理
  },
)
```

## 属性配置

### 头像类型

支持图片、文字和图标三种类型，系统会根据提供的属性自动判断类型优先级：图片 > 文字 > 图标。

```dart
// 图片头像 (优先级最高)
VelocityAvatar(imageUrl: 'https://example.com/avatar.png')

// 文字头像 (自动提取首字母)
VelocityAvatar(name: 'Velocity UI')

// 图标头像
VelocityAvatar(icon: Icons.person)
```

### 头像尺寸

提供 5 种预置尺寸，同时支持自定义尺寸。

```dart
// 预置尺寸
VelocityAvatar(size: VelocityAvatarSize.xs) // 24px
VelocityAvatar(size: VelocityAvatarSize.sm) // 32px
VelocityAvatar(size: VelocityAvatarSize.md) // 40px (默认)
VelocityAvatar(size: VelocityAvatarSize.lg) // 48px
VelocityAvatar(size: VelocityAvatarSize.xl) // 64px

// 自定义尺寸
VelocityAvatar(customSize: 100)
```

### 头像形状

支持圆形、方形和圆角方形三种形状。

```dart
VelocityAvatar(shape: VelocityAvatarShape.circle) // 圆形 (默认)
VelocityAvatar(shape: VelocityAvatarShape.square) // 方形
VelocityAvatar(shape: VelocityAvatarShape.rounded) // 圆角方形
```

## 高级用法

### 头像组展示

多个头像叠在一起显示，适用于团队成员、参与者列表等场景。

```dart
VelocityAvatarGroup(
  avatars: [
    VelocityAvatar(name: 'A'),
    VelocityAvatar(name: 'B'),
    VelocityAvatar(name: 'C'),
    VelocityAvatar(name: 'D'),
  ],
  max: 3, // 最多显示3个，超出部分显示数量
  onTap: (index) {
    print('点击了第 $index 个头像');
  },
)
```

### 点击交互

头像支持点击事件，可用于打开用户资料、放大查看等场景。

```dart
VelocityAvatar(
  imageUrl: 'https://example.com/avatar.png',
  onTap: () {
    // 打开用户资料
  },
)
```

## 样式定制

### 自定义样式

通过 `style` 属性可以自定义头像的各种样式。

```dart
VelocityAvatar(
  name: 'Velocity',
  style: VelocityAvatarStyle(
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    borderColor: Colors.white,
    borderWidth: 2,
  ),
)
```

### 头像组样式

```dart
VelocityAvatarGroup(
  avatars: [/* 头像列表 */],
  style: VelocityAvatarGroupStyle(
    spacing: -12, // 调整重叠距离
  ),
)
```

## 可访问性

- 为头像添加 `semanticLabel` 属性，提高屏幕阅读器的可访问性
- 对于图片头像，确保提供有意义的 `alt` 文本（通过 `semanticLabel` 实现）
- 头像组应提供清晰的无障碍标签，说明包含的头像数量

## 最佳实践

- **图片选择**：使用高分辨率、清晰的图片，建议尺寸为预期显示尺寸的 2 倍
- **文字头像**：名称应简短明了，避免过长文本导致显示异常
- **性能优化**：对于大量头像展示，建议使用图片懒加载
- **一致性**：在同一页面中保持头像尺寸和形状的一致性
- **反馈机制**：为可点击的头像添加视觉反馈，如悬停效果

## 常见问题

### 问题：图片加载失败怎么办？

**症状**：头像显示为默认图标或文字

**原因**：图片 URL 无效或网络问题导致加载失败

**解决方案**：

1. 确保图片 URL 正确且可访问
2. 提供 `name` 或 `icon` 属性作为备选
3. 考虑添加图片加载失败的处理逻辑

### 问题：头像组显示异常？

**症状**：头像重叠不正确或显示数量不符合预期

**原因**：头像组配置不当

**解决方案**：

1. 确保 `avatars` 列表不为空
2. 调整 `max` 属性控制显示数量
3. 通过 `spacing` 属性调整头像重叠距离

## API 参考

### VelocityAvatar

| 属性          | 类型                 | 默认值       | 说明                    |
| ------------- | -------------------- | ------------ | ----------------------- |
| key           | Key?                 | -            | 组件的唯一标识符        |
| imageUrl      | String?              | -            | 图片地址                |
| name          | String?              | -            | 名称 (用于生成文字头像) |
| icon          | IconData?            | Icons.person | 图标                    |
| size          | VelocityAvatarSize   | md           | 尺寸                    |
| shape         | VelocityAvatarShape  | circle       | 形状                    |
| customSize    | double?              | -            | 自定义尺寸              |
| onTap         | VoidCallback?        | -            | 点击回调                |
| semanticLabel | String?              | -            | 无障碍标签              |
| style         | VelocityAvatarStyle? | -            | 自定义样式              |

### VelocityAvatarStyle

| 属性            | 类型          | 默认值 | 说明     |
| --------------- | ------------- | ------ | -------- |
| backgroundColor | Color?        | -      | 背景颜色 |
| textColor       | Color?        | -      | 文字颜色 |
| iconColor       | Color?        | -      | 图标颜色 |
| borderColor     | Color?        | -      | 边框颜色 |
| borderWidth     | double        | 0      | 边框宽度 |
| borderRadius    | BorderRadius? | -      | 边框圆角 |

### VelocityAvatarGroup

| 属性    | 类型                      | 默认值 | 说明                         |
| ------- | ------------------------- | ------ | ---------------------------- |
| key     | Key?                      | -      | 组件的唯一标识符             |
| avatars | List<VelocityAvatar>      | -      | 头像列表 (必填)              |
| max     | int                       | 5      | 最大显示数量                 |
| size    | VelocityAvatarSize        | md     | 尺寸                         |
| spacing | double                    | -8     | 重叠距离                     |
| onTap   | ValueChanged<int>?        | -      | 点击回调，返回点击的头像索引 |
| style   | VelocityAvatarGroupStyle? | -      | 自定义样式                   |

### VelocityAvatarGroupStyle

| 属性                | 类型   | 默认值 | 说明               |
| ------------------- | ------ | ------ | ------------------ |
| moreBackgroundColor | Color? | -      | 更多头像的背景颜色 |
| moreTextColor       | Color? | -      | 更多头像的文字颜色 |

### 枚举类型

```dart
enum VelocityAvatarSize {
  xs, // 24px
  sm, // 32px
  md, // 40px (默认)
  lg, // 48px
  xl, // 64px
}

enum VelocityAvatarShape {
  circle, // 圆形
  square, // 方形
  rounded, // 圆角方形
}
```

## 相关组件

- [Badge 徽标](/components/display/badge)
- [Card 卡片](/components/display/card)
- [List 列表](/components/display/list)

## 更新日志

### v1.0.0

- 初始版本发布，支持图片、文字和图标三种头像类型
- 提供 5 种预置尺寸和自定义尺寸选项
- 支持圆形、方形和圆角方形三种形状
- 支持头像组展示功能

---

::: tip 提示

为了获得最佳显示效果，建议使用正方形图片作为头像源。

:::
