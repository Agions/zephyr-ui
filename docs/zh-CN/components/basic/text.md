---
title: ZephyrText 文本
description: VelocityUI ZephyrText 组件，提供统一的排版样式
---

# ZephyrText 文本

统一的文本展示组件，内置多种排版样式。

## 基本用法

```dart
VelocityText('这是一段普通文本')
```

## 文本变体

VelocityUI 提供了多种文本变体，对应 Material Design 3 的排版系统：

### Display 大标题

```dart
VelocityText.displayLarge('Display Large')
VelocityText.displayMedium('Display Medium')
VelocityText.displaySmall('Display Small')
```

### Headline 标题

```dart
VelocityText.headlineLarge('Headline Large')
VelocityText.headlineMedium('Headline Medium')
VelocityText.headlineSmall('Headline Small')
```

### Title 副标题

```dart
VelocityText.titleLarge('Title Large')
VelocityText.titleMedium('Title Medium')
VelocityText.titleSmall('Title Small')
```

### Body 正文

```dart
VelocityText.bodyLarge('Body Large')
VelocityText.bodyMedium('Body Medium')
VelocityText.bodySmall('Body Small')
```

### Label 标签

```dart
VelocityText.labelLarge('Label Large')
VelocityText.labelMedium('Label Medium')
VelocityText.labelSmall('Label Small')
```

## 自定义样式

```dart
VelocityText(
  '自定义颜色和对齐',
  color: VelocityColors.primary,
  textAlign: TextAlign.center,
)
```

## 文本溢出

```dart
VelocityText(
  '这是一段非常长的文本，可能会超出容器宽度...',
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
)
```

## API

### VelocityText

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| text | String | - | 文本内容 (必填) |
| variant | VelocityTextVariant | - | 文本变体 |
| color | Color? | - | 文本颜色 |
| textAlign | TextAlign? | - | 对齐方式 |
| maxLines | int? | - | 最大行数 |
| overflow | TextOverflow? | - | 溢出处理 |
| style | VelocityTextStyle? | - | 自定义样式 |
