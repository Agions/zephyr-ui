---
title: Search 搜索框
description: VelocityUI Search 组件，搜索输入
---

# Search 搜索框

搜索输入框。

## 基本用法

```dart
VelocitySearch(
  placeholder: '请输入搜索关键词',
  onChanged: (val) {},
  onSubmitted: (val) {},
)
```

## 带取消按钮

```dart
VelocitySearch(
  showCancelButton: true,
  onCancel: () {
    // 处理取消逻辑
  },
)
```

## API

### VelocitySearch

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| controller | TextEditingController? | - | 控制器 |
| placeholder | String | '搜索' | 占位文字 |
| onChanged | ValueChanged<String>? | - | 输入改变回调 |
| onSubmitted | ValueChanged<String>? | - | 提交回调 |
| onClear | VoidCallback? | - | 清除回调 |
| autofocus | bool | false | 自动获取焦点 |
| showCancelButton | bool | false | 是否显示取消按钮 |
| cancelText | String | '取消' | 取消按钮文本 |
| onCancel | VoidCallback? | - | 取消回调 |
| style | VelocitySearchStyle? | - | 自定义样式 |
