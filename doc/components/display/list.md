---
title: List 列表
description: VelocityUI List 组件，通用列表项及分组
---

# List 列表

通用列表项及分组。

## 基本用法

```dart
VelocityListTile(
  title: Text('标题'),
  onTap: () {},
)
```

## 完整配置

```dart
VelocityListTile(
  leading: ZephyrIcon(Icons.star),
  title: ZephyrText('标题'),
  subtitle: ZephyrText('副标题'),
  trailing: ZephyrIcon(Icons.chevron_right),
  onTap: () {},
)
```

## 列表分组 (ListGroup)

```dart
VelocityListGroup(
  header: ZephyrText('分组标题'),
  children: [
    VelocityListTile(title: ZephyrText('列表项 1')),
    VelocityListTile(title: ZephyrText('列表项 2')),
  ],
)
```

## API

### VelocityListTile

| 属性        | 类型                   | 默认值 | 说明       |
| ----------- | ---------------------- | ------ | ---------- |
| title       | Widget?                | -      | 标题       |
| subtitle    | Widget?                | -      | 副标题     |
| leading     | Widget?                | -      | 左侧组件   |
| trailing    | Widget?                | -      | 右侧组件   |
| onTap       | VoidCallback?          | -      | 点击回调   |
| onLongPress | VoidCallback?          | -      | 长按回调   |
| enabled     | bool                   | true   | 是否启用   |
| selected    | bool                   | false  | 是否选中   |
| style       | VelocityListTileStyle? | -      | 自定义样式 |

### VelocityListGroup

| 属性     | 类型                    | 默认值 | 说明              |
| -------- | ----------------------- | ------ | ----------------- |
| children | ZephyrList<Widget>      | -      | 子组件列表 (必填) |
| header   | Widget?                 | -      | 分组标题          |
| divider  | bool                    | true   | 是否显示分隔线    |
| style    | VelocityListGroupStyle? | -      | 自定义样式        |
