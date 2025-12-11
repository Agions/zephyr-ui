---
title: Pagination 分页
description: VelocityUI Pagination 组件，分页控制器
---

# Pagination 分页

分页控制器。

## 基本用法

```dart
VelocityPagination(
  current: 1,
  total: 50,
  pageSize: 10,
  onPageChanged: (page) {},
)
```

## 简单模式

只展示 "上一页 X/Y 下一页"。

```dart
VelocityPagination(
  current: 1,
  total: 50,
  simple: true,
  onPageChanged: (page) {},
)
```

## API

### VelocityPagination

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| current | int | - | 当前页码 (必填) |
| total | int | - | 数据总数 (必填) |
| pageSize | int | 10 | 每页数量 |
| onPageChanged | ValueChanged<int> | - | 页码改变回调 (必填) |
| simple | bool | false | 是否简单模式 |
| style | VelocityPaginationStyle? | - | 自定义样式 |
