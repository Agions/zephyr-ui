---
title: Tabs 标签页
description: VelocityUI Tabs 组件，用于内容切换
---

# Tabs 标签页

选项卡切换组件。

## 基本用法

```dart
VelocityTabs(
  tabs: ['标签1', '标签2', '标签3'],
  children: [
    Text('内容1'),
    Text('内容2'),
    Text('内容3'),
  ],
)
```

## 监听切换

```dart
VelocityTabs(
  tabs: ['首页', '我的'],
  children: [
    HomeParams(),
    ProfilePage(),
  ],
  onChanged: (index) {
    print('切换到索引: $index');
  },
)
```

## API

### VelocityTabs

| 属性         | 类型               | 默认值 | 说明            |
| ------------ | ------------------ | ------ | --------------- |
| tabs         | ZephyrList<String> | -      | 标签列表 (必填) |
| children     | ZephyrList<Widget> | -      | 内容列表 (必填) |
| initialIndex | int                | 0      | 初始索引        |
| onChanged    | ValueChanged<int>? | -      | 切换回调        |
| style        | VelocityTabsStyle? | -      | 自定义样式      |
