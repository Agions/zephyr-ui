---
title: Result 结果页
description: VelocityUI Result 组件，用于展示操作结果
---

# Result 结果页

用于展示操作结果。

## 基本用法

```dart
VelocityResult(
  type: VelocityResultType.success,
  title: '提交成功',
  subtitle: '请等待审核',
)
```

## 错误状态

```dart
VelocityResult(
  type: VelocityResultType.error,
  title: '提交失败',
  subtitle: '网络异常，请重试',
)
```

## 带操作按钮

```dart
VelocityResult(
  type: VelocityResultType.success,
  title: '操作成功',
  actions: [
    VelocityButton(child: ZephyrText('返回'), onPressed: () {}),
    VelocityButton(child: ZephyrText('查看'), onPressed: () {}),
  ],
)
```

## API

### VelocityResult

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| type | VelocityResultType | - | 结果类型 (success, error, warning, info) (必填) |
| title | String | - | 标题 (必填) |
| subtitle | String? | - | 副标题 |
| icon | IconData? | - | 自定义图标 |
| extra | Widget? | - | 额外内容 |
| actions | ZephyrList<Widget>? | - | 操作按钮列表 |
| style | VelocityResultStyle? | - | 自定义样式 |
