---
title: Toast 轻提示
description: VelocityUI Toast 组件，用于轻量级的操作反馈
---

# Toast 轻提示

轻量级的信息反馈组件，用于在页面中显示简短的信息提示。

## 基本用法

```dart
VelocityToast.show(
  context,
  message: '操作成功',
);
```

## Toast 类型

```dart
// 信息提示
VelocityToast.show(context, message: '这是一条普通提示', type: VelocityToastType.info);

// 成功提示
VelocityToast.show(context, message: '操作成功！', type: VelocityToastType.success);

// 警告提示
VelocityToast.show(context, message: '请注意！', type: VelocityToastType.warning);

// 错误提示
VelocityToast.show(context, message: '操作失败', type: VelocityToastType.error);
```

## 显示位置

```dart
// 顶部显示
VelocityToast.show(context, message: '顶部提示', position: VelocityToastPosition.top);

// 中间显示
VelocityToast.show(context, message: '中间提示', position: VelocityToastPosition.center);

// 底部显示
VelocityToast.show(context, message: '底部提示', position: VelocityToastPosition.bottom);
```

## 自定义持续时间

```dart
VelocityToast.show(
  context,
  message: '这条提示将在5秒后消失',
  duration: const Duration(seconds: 5),
);
```

## 手动关闭

```dart
VelocityToast.dismiss();
```

## API

### VelocityToast.show

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| context | BuildContext | - | 上下文 (必填) |
| message | String | - | 提示信息 (必填) |
| type | VelocityToastType | info | 提示类型 |
| position | VelocityToastPosition | bottom | 显示位置 |
| duration | Duration | 2秒 | 显示持续时间 |
| style | VelocityToastStyle? | - | 自定义样式 |

### VelocityToastType

| 类型 | 说明 |
|------|------|
| info | 信息提示 |
| success | 成功提示 |
| warning | 警告提示 |
| error | 错误提示 |

### VelocityToastPosition

| 位置 | 说明 |
|------|------|
| top | 顶部 |
| center | 中间 |
| bottom | 底部 |
