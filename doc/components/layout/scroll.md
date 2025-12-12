---
title: Scroll 滚动
description: VelocityUI Scroll 组件，统一的滚动视图
---

# Scroll 滚动

统一的滚动视图，集成下拉刷新和回到顶部功能。

## 基本用法

```dart
VelocityScrollView(
  children: [
    Text('Item 1'),
    Text('Item 2'),
    // ...
  ],
)
```

## 下拉刷新

```dart
VelocityRefresh(
  onRefresh: () async {
    // 刷新逻辑
  },
  child: VelocityScrollView(children: [...]),
)
```

## 回到顶部

```dart
VelocityScrollToTop(
  controller: scrollController,
  child: VelocityScrollView(
    controller: scrollController,
    children: [...],
  ),
)
```

## API

### VelocityScrollView

| 属性       | 类型               | 默认值   | 说明              |
| ---------- | ------------------ | -------- | ----------------- |
| children   | ZephyrList<Widget> | -        | 子组件列表 (必填) |
| direction  | Axis               | vertical | 滚动方向          |
| padding    | EdgeInsets?        | -        | 内边距            |
| controller | ScrollController?  | -        | 滚动控制器        |

### VelocityRefresh

| 属性      | 类型                    | 默认值 | 说明            |
| --------- | ----------------------- | ------ | --------------- |
| child     | Widget                  | -      | 子组件 (必填)   |
| onRefresh | Future<void> Function() | -      | 刷新回调 (必填) |
| color     | Color?                  | -      | 指示器颜色      |

### VelocityScrollToTop

| 属性       | 类型                      | 默认值 | 说明              |
| ---------- | ------------------------- | ------ | ----------------- |
| child      | Widget                    | -      | 子组件 (必填)     |
| controller | ScrollController          | -      | 滚动控制器 (必填) |
| showAfter  | double                    | 200    | 滚动多少距离显示  |
| style      | VelocityScrollToTopStyle? | -      | 自定义样式        |
