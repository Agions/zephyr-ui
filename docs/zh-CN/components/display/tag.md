---
title: Tag 标签
description: VelocityUI Tag 组件，用于标记状态或属性
---

# Tag 标签

进行标记和分类的小标签。

## 基本用法

```dart
VelocityTag(text: '标签')
```

## 标签类型

```dart
VelocityTag(text: 'Default', type: VelocityTagType.default_)
VelocityTag(text: 'Primary', type: VelocityTagType.primary)
VelocityTag(text: 'Success', type: VelocityTagType.success)
VelocityTag(text: 'Warning', type: VelocityTagType.warning)
VelocityTag(text: 'Error', type: VelocityTagType.error)
VelocityTag(text: 'Info', type: VelocityTagType.info)
```

## 轮廓标签

```dart
VelocityTag(
  text: '轮廓标签',
  type: VelocityTagType.primary,
  outlined: true,
)
```

## 可关闭标签

```dart
VelocityTag(
  text: '可关闭',
  closable: true,
  onClose: () {
    // 处理关闭逻辑
  },
)
```

## 带图标标签

```dart
VelocityTag(
  text: '通过',
  type: VelocityTagType.success,
  icon: Icons.check_circle,
)
```

## API

### VelocityTag

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| text | String | - | 标签文本 (必填) |
| type | VelocityTagType | default_ | 标签类型 |
| closable | bool | false | 是否可关闭 |
| onClose | VoidCallback? | - | 关闭回调 |
| icon | IconData? | - | 图标 |
| outlined | bool | false | 是否轮廓样式 |
| style | VelocityTagStyle? | - | 自定义样式 |
