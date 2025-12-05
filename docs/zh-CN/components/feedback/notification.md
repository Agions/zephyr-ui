---
title: Notification 通知
description: VelocityUI 通知组件，用于全局展示通知提醒信息
---

# Notification 通知

全局展示通知提醒信息，常用于系统级通知、推送消息等场景。

## 基本用法

```dart
VelocityNotification.show(
  context: context,
  title: '通知标题',
  message: '这是一条通知消息',
);
```

## 通知类型

VelocityUI 提供了四种预置的通知类型：

```dart
// 信息通知
VelocityNotification.show(
  context: context,
  title: '提示信息',
  message: '这是一条普通的信息通知',
  type: VelocityNotificationType.info,
);

// 成功通知
VelocityNotification.show(
  context: context,
  title: '操作成功',
  message: '您的数据已成功保存',
  type: VelocityNotificationType.success,
);

// 警告通知
VelocityNotification.show(
  context: context,
  title: '警告',
  message: '您的账户即将到期，请及时续费',
  type: VelocityNotificationType.warning,
);

// 错误通知
VelocityNotification.show(
  context: context,
  title: '错误',
  message: '网络连接失败，请检查网络设置',
  type: VelocityNotificationType.error,
);
```

## 通知位置

```dart
// 顶部显示
VelocityNotification.show(
  context: context,
  title: '顶部通知',
  message: '这条通知显示在顶部',
  position: VelocityNotificationPosition.top,
);

// 底部显示
VelocityNotification.show(
  context: context,
  title: '底部通知',
  message: '这条通知显示在底部',
  position: VelocityNotificationPosition.bottom,
);
```

## 自定义持续时间

```dart
VelocityNotification.show(
  context: context,
  title: '短时通知',
  message: '这条通知将在2秒后自动消失',
  duration: const Duration(seconds: 2),
);
```

## 手动关闭

```dart
VelocityNotification.dismiss();
```

## API

### VelocityNotification.show

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| context | BuildContext | - | 上下文 (必填) |
| title | String | - | 通知标题 (必填) |
| message | String? | - | 通知内容 |
| type | VelocityNotificationType | info | 通知类型 |
| position | VelocityNotificationPosition | top | 通知位置 |
| duration | Duration | 4秒 | 显示持续时间 |
| onTap | VoidCallback? | - | 点击回调 |
| showClose | bool | true | 是否显示关闭按钮 |
| style | VelocityNotificationStyle? | - | 自定义样式 |

### VelocityNotificationType

| 类型 | 说明 |
|------|------|
| info | 信息提示 |
| success | 成功提示 |
| warning | 警告提示 |
| error | 错误提示 |

### VelocityNotificationPosition

| 位置 | 说明 |
|------|------|
| top | 顶部显示 |
| bottom | 底部显示 |
