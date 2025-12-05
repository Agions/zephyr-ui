---
title: Dialog 对话框
description: VelocityUI 对话框组件，用于重要信息的确认和提示
---

# Dialog 对话框

对话框用于重要信息的确认、警告或需要用户确认的操作。

## 基本用法

### 提示对话框

```dart
VelocityDialog.alert(
  context,
  title: '操作提示',
  content: '您的数据已成功保存！',
  confirmText: '知道了',
);
```

### 确认对话框

```dart
final result = await VelocityDialog.confirm(
  context,
  title: '确认删除',
  content: '删除后数据将无法恢复，您确定要继续吗？',
  confirmText: '删除',
  cancelText: '取消',
);

if (result == true) {
  // 用户点击了确认
}
```

## 使用场景

### 危险操作确认

```dart
final confirmed = await VelocityDialog.confirm(
  context,
  title: '确认注销账户？',
  content: '注销后，您的所有数据将被永久删除，且无法恢复。',
  confirmText: '确认注销',
  cancelText: '取消',
);

if (confirmed == true) {
  // 执行注销操作
}
```

### 自定义对话框

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('用户反馈'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('请为我们的服务评分'),
        // 自定义内容
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('取消'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('提交'),
      ),
    ],
  ),
);
```

## API

### VelocityDialog.alert

显示提示对话框，只有一个确认按钮。

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| context | BuildContext | - | 上下文 (必填) |
| title | String | - | 对话框标题 (必填) |
| content | String? | - | 对话框内容 |
| confirmText | String | '确定' | 确认按钮文本 |
| style | VelocityDialogStyle? | - | 自定义样式 |

### VelocityDialog.confirm

显示确认对话框，有确认和取消两个按钮。

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| context | BuildContext | - | 上下文 (必填) |
| title | String | - | 对话框标题 (必填) |
| content | String? | - | 对话框内容 |
| confirmText | String | '确定' | 确认按钮文本 |
| cancelText | String | '取消' | 取消按钮文本 |
| style | VelocityDialogStyle? | - | 自定义样式 |

**返回值**: `Future<bool?>` - 用户点击确认返回 `true`，点击取消返回 `false`
