---
title: FormField 表单字段
description: VelocityUI FormField 组件，统一的表单项布局
---

# FormField 表单字段

统一的表单项布局，包含标签、内容、辅助文字和错误信息。

## 基本用法

```dart
VelocityFormField(
  label: '用户名',
  child: VelocityInput(/*...*/),
)
```

## 必填与错误信息

```dart
VelocityFormField(
  label: '邮箱',
  required: true,
  error: '邮箱格式不正确',
  child: VelocityInput(/*...*/),
)
```

## 水平布局

```dart
VelocityFormField(
  label: '开关',
  direction: Axis.horizontal,
  child: VelocitySwitch(/*...*/),
)
```

## 表单容器

使用 `VelocityForm` 可以统一管理一组表单项的间距。

```dart
VelocityForm(
  spacing: 16,
  children: [
    VelocityFormField(/*...*/),
    VelocityFormField(/*...*/),
  ],
)
```

## API

### VelocityFormField

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| label | String | - | 标签文字 (必填) |
| child | Widget | - | 表单控件 (必填) |
| required | bool | false | 是否必填 |
| helper | String? | - | 辅助文字 |
| error | String? | - | 错误信息 |
| direction | Axis | vertical | 布局方向 |
| style | VelocityFormFieldStyle? | - | 自定义样式 |

### VelocityForm

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| children | ZephyrList<Widget> | - | 子组件列表 (必填) |
| spacing | double | 16 | 垂直间距 |
| padding | EdgeInsets? | - | 内边距 |
