---
title: ZephyrButton 按钮
description: VelocityUI 按钮组件，支持多种类型、尺寸和状态
---

# ZephyrButton 按钮

按钮用于触发一个操作或事件，如提交表单、打开对话框、取消操作或执行删除操作。

## 基本用法

```dart
VelocityButton.text(
  text: '按钮',
  onPressed: () {
    // 处理点击
  },
)
```

## 按钮类型

VelocityUI 提供了多种按钮类型以满足不同场景：

```dart
// 主要按钮
VelocityButton.text(text: '主要按钮', type: VelocityButtonType.primary, onPressed: () {})

// 次要按钮
VelocityButton.text(text: '次要按钮', type: VelocityButtonType.secondary, onPressed: () {})

// 轮廓按钮
VelocityButton.text(text: '轮廓按钮', type: VelocityButtonType.outline, onPressed: () {})

// 文本按钮
VelocityButton.text(text: '文本按钮', type: VelocityButtonType.text, onPressed: () {})

// 成功按钮
VelocityButton.text(text: '成功按钮', type: VelocityButtonType.success, onPressed: () {})

// 警告按钮
VelocityButton.text(text: '警告按钮', type: VelocityButtonType.warning, onPressed: () {})

// 危险按钮
VelocityButton.text(text: '危险按钮', type: VelocityButtonType.danger, onPressed: () {})
```

## 按钮尺寸

```dart
VelocityButton.text(text: '小按钮', size: VelocityButtonSize.small, onPressed: () {})
VelocityButton.text(text: '中按钮', size: VelocityButtonSize.medium, onPressed: () {})
VelocityButton.text(text: '大按钮', size: VelocityButtonSize.large, onPressed: () {})
```

## 图标按钮

```dart
// 左侧图标
VelocityButton.icon(
  text: '添加',
  icon: Icons.add,
  onPressed: () {},
)

// 右侧图标
VelocityButton.icon(
  text: '下一步',
  icon: Icons.arrow_forward,
  iconPosition: VelocityIconPosition.right,
  onPressed: () {},
)

// 纯图标按钮
VelocityIconButton(
  icon: Icons.favorite,
  onPressed: () {},
  tooltip: '收藏',
)
```

## 按钮状态

```dart
// 加载状态
VelocityButton.text(text: '加载中', loading: true, onPressed: () {})

// 禁用状态
VelocityButton.text(text: '禁用', disabled: true, onPressed: () {})

// 全宽按钮
VelocityButton.text(text: '全宽按钮', fullWidth: true, onPressed: () {})
```

## API

### VelocityButton

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| child | Widget? | - | 按钮内容 |
| onPressed | VoidCallback? | - | 点击事件 |
| onLongPress | VoidCallback? | - | 长按事件 |
| type | VelocityButtonType | primary | 按钮类型 |
| size | VelocityButtonSize | medium | 按钮尺寸 |
| loading | bool | false | 加载状态 |
| disabled | bool | false | 禁用状态 |
| fullWidth | bool | false | 是否全宽 |
| style | VelocityButtonStyle? | - | 自定义样式 |

### VelocityButtonType

| 类型 | 说明 |
|------|------|
| primary | 主要按钮 |
| secondary | 次要按钮 |
| outline | 轮廓按钮 |
| text | 文本按钮 |
| success | 成功按钮 |
| warning | 警告按钮 |
| danger | 危险按钮 |

### VelocityButtonSize

| 尺寸 | 说明 |
|------|------|
| small | 小尺寸 |
| medium | 中等尺寸 |
| large | 大尺寸 |
