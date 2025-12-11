---
title: Menu 菜单
description: VelocityUI Menu 组件，弹出式菜单
---

# Menu 菜单

弹出式菜单。

## 基本用法

```dart
VelocityMenu(
  items: [
    VelocityMenuItem(label: '添加', value: 'add', icon: Icons.add),
    VelocityMenuItem(label: '删除', value: 'delete', icon: Icons.delete),
  ],
  onSelected: (value) {
    print(value);
  },
  child: ZephyrText('点击弹出菜单'),
)
```

## API

### VelocityMenu

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| items | ZephyrList<VelocityMenuItem> | - | 菜单项列表 (必填) |
| child | Widget | - | 触发组件 (必填) |
| onSelected | ValueChanged<dynamic>? | - | 选中回调 |
| offset | Offset | Offset.zero | 偏移量 |
| style | VelocityMenuStyle? | - | 自定义样式 |

### VelocityMenuItem

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| label | String? | - | 标签 |
| value | dynamic | - | 值 |
| icon | IconData? | - | 图标 |
| disabled | bool | false | 是否禁用 |
