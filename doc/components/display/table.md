---
title: Table 表格
description: VelocityUI Table 组件，用于展示行列数据
---

# Table 表格

用于展示行列数据。

## 基本用法

```dart
VelocityTable(
  columns: [
    VelocityTableColumn(title: '姓名', flex: 1),
    VelocityTableColumn(title: '年龄', flex: 1),
    VelocityTableColumn(title: '地址', flex: 2),
  ],
  rows: [
    VelocityTableRow(cells: ['张三', 18, '北京市']),
    VelocityTableRow(cells: ['李四', 25, '上海市']),
  ],
)
```

## 斑马纹与边框

```dart
VelocityTable(
  striped: true, // 斑马纹
  bordered: true, // 边框
  columns: [/*...*/],
  rows: [/*...*/],
)
```

## API

### VelocityTable

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| columns | ZephyrList<VelocityTableColumn> | - | 列定义 (必填) |
| rows | ZephyrList<VelocityTableRow> | - | 行数据 (必填) |
| showHeader | bool | true | 是否显示表头 |
| striped | bool | false | 是否显示斑马纹 |
| bordered | bool | false | 是否显示边框 |
| style | VelocityTableStyle? | - | 自定义样式 |
