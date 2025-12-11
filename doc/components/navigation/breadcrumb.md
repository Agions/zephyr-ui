---
title: VelocityBreadcrumb 面包屑导航
description: VelocityUI 面包屑导航组件，用于显示当前页面的层级位置
---

# VelocityBreadcrumb 面包屑导航

面包屑导航组件，用于显示当前页面的层级位置，支持自动换行和自定义样式。

## 基本用法

```dart
VelocityBreadcrumb(
  items: [
    VelocityBreadcrumbItem(label: '首页'),
    VelocityBreadcrumbItem(label: '组件库'),
    VelocityBreadcrumbItem(label: '面包屑'),
  ],
  onItemTap: (index) {
    print('点击了第 $index 个面包屑项');
  },
)
```

## 自动换行

```dart
VelocityBreadcrumb(
  items: [
    VelocityBreadcrumbItem(label: '首页'),
    VelocityBreadcrumbItem(label: '组件库'),
    VelocityBreadcrumbItem(label: '导航组件'),
    VelocityBreadcrumbItem(label: '面包屑导航'),
    VelocityBreadcrumbItem(label: '高级用法'),
    VelocityBreadcrumbItem(label: '自定义样式'),
  ],
  wrap: true,
  onItemTap: (index) {
    print('点击了第 $index 个面包屑项');
  },
)
```

## 自定义分隔符

```dart
VelocityBreadcrumb(
  items: [
    VelocityBreadcrumbItem(label: '首页'),
    VelocityBreadcrumbItem(label: '组件库'),
    VelocityBreadcrumbItem(label: '面包屑'),
  ],
  separator: ' > ',
  onItemTap: (index) {
    print('点击了第 $index 个面包屑项');
  },
)
```

## 自定义样式

```dart
VelocityBreadcrumb(
  items: [
    VelocityBreadcrumbItem(label: '首页'),
    VelocityBreadcrumbItem(label: '组件库'),
    VelocityBreadcrumbItem(label: '面包屑'),
  ],
  style: VelocityBreadcrumbStyle(
    textStyle: TextStyle(color: Colors.blue),
    activeTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    separatorStyle: TextStyle(color: Colors.green),
  ),
  onItemTap: (index) {
    print('点击了第 $index 个面包屑项');
  },
)
```

## API

### VelocityBreadcrumb

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| items | List<VelocityBreadcrumbItem> | - | 面包屑项列表 |
| style | VelocityBreadcrumbStyle? | - | 样式 |
| onItemTap | ValueChanged<int>? | - | 项点击事件 |
| separator | String? | / | 分隔符 |
| wrap | bool | false | 是否自动换行 |
| mainAxisAlignment | MainAxisAlignment | MainAxisAlignment.start | 主轴对齐方式 |
| crossAxisAlignment | CrossAxisAlignment | CrossAxisAlignment.center | 交叉轴对齐方式 |

### VelocityBreadcrumbItem

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| label | String | - | 标签文本 |
| icon | IconData? | - | 图标 |
| route | String? | - | 路由路径 |

### VelocityBreadcrumbStyle

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| textStyle | TextStyle | TextStyle(fontSize: 14, color: Colors.black87) | 文本样式 |
| activeTextStyle | TextStyle | TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue) | 激活状态文本样式 |
| separatorStyle | TextStyle | TextStyle(fontSize: 14, color: Colors.grey) | 分隔符样式 |
| separator | String | / | 分隔符 |
| spacing | double | 8.0 | 间距 |
| itemPadding | EdgeInsets | EdgeInsets.symmetric(horizontal: 4.0) | 项内边距 |
| wrap | bool | false | 是否自动换行 |
