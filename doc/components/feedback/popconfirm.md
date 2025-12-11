---
title: Popconfirm 确认气泡
description: VelocityUI Popconfirm 组件，点击元素时弹出气泡确认框
---

# Popconfirm 确认气泡

点击元素，弹出气泡确认框。常用于操作前需要用户二次确认的场景。

## 基本用法

```dart
VelocityPopconfirm(
  title: '确定要删除吗？',
  onConfirm: () {
    // 确认回调
  },
  child: VelocityButton.text(text: '删除'),
)
```

## 自定义按钮文字

```dart
VelocityPopconfirm(
  title: '确定要提交吗？',
  confirmText: '是的',
  cancelText: '再想想',
  onConfirm: () {},
  child: VelocityButton.text(text: '提交'),
)
```

## 带详细内容

```dart
VelocityPopconfirm(
  title: '确定要注销账户吗？',
  content: '注销后，您的所有数据将被永久删除，且无法恢复。',
  onConfirm: () {},
  child: VelocityButton.text(text: '注销账户'),
)
```

## API

### VelocityPopconfirm

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| child | Widget | - | 触发元素 (必填) |
| title | String | - | 确认标题 (必填) |
| content | String? | - | 详细内容 |
| confirmText | String | '确定' | 确认按钮文本 |
| cancelText | String | '取消' | 取消按钮文本 |
| onConfirm | VoidCallback? | - | 确认回调 |
| onCancel | VoidCallback? | - | 取消回调 |
| style | VelocityPopconfirmStyle? | - | 自定义样式 |
