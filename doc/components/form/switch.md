---
title: Switch 开关
description: VelocityUI Switch 组件，用于切换两种状态
---

# Switch 开关

用于切换两种状态，如开启/关闭。

## 基本用法

```dart
VelocitySwitch(
  value: _isOpen,
  onChanged: (value) {
    setState(() => _isOpen = value);
  },
)
```

## 带标签

```dart
VelocitySwitch(
  value: _darkMode,
  label: '深色模式',
  onChanged: (value) {
    setState(() => _darkMode = value);
  },
)
```

## 禁用状态

```dart
VelocitySwitch(
  value: true,
  label: '禁用状态',
  disabled: true,
  onChanged: null,
)
```

## API

### VelocitySwitch

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | bool | - | 开关状态 (必填) |
| onChanged | ValueChanged<bool>? | - | 状态改变回调 (必填) |
| label | String? | - | 标签文本 |
| disabled | bool | false | 是否禁用 |
| style | VelocitySwitchStyle? | - | 自定义样式 |
