---
title: Drawer 抽屉
description: VelocityUI Drawer 组件，屏幕边缘滑出的浮层面板
---

# Drawer 抽屉

屏幕边缘滑出的浮层面板。

## 基本用法

```dart
VelocityDrawer(
  items: [
    VelocityDrawerItem(icon: Icons.home, label: '首页', onTap: () {}),
    VelocityDrawerItem(icon: Icons.settings, label: '设置', onTap: () {}),
  ],
  selectedIndex: _index,
  onItemTap: (index) {
    setState(() => _index = index);
  },
)
```

## 带头部和底部

```dart
VelocityDrawer(
  header: UserAccountsDrawerHeader(
    accountName: Text('User'),
    accountEmail: Text('user@example.com'),
  ),
  items: [/*...*/],
  footer: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Version 1.0.0'),
  ),
)
```

## 分隔线

```dart
VelocityDrawer(
  items: [
    VelocityDrawerItem(icon: Icons.home, label: '首页'),
    VelocityDrawerItem.divider(), // 分隔线
    VelocityDrawerItem(icon: Icons.logout, label: '退出'),
  ],
)
```

## API

### VelocityDrawer

| 属性          | 类型                           | 默认值 | 说明              |
| ------------- | ------------------------------ | ------ | ----------------- |
| items         | ZephyrList<VelocityDrawerItem> | -      | 菜单项列表 (必填) |
| selectedIndex | int?                           | -      | 当前选中项索引    |
| onItemTap     | ValueChanged<int>?             | -      | 点击回调          |
| header        | Widget?                        | -      | 头部组件          |
| footer        | Widget?                        | -      | 底部组件          |
| style         | VelocityDrawerStyle?           | -      | 自定义样式        |

### VelocityDrawerItem

| 属性      | 类型          | 默认值 | 说明         |
| --------- | ------------- | ------ | ------------ |
| icon      | IconData?     | -      | 图标         |
| label     | String?       | -      | 标签文本     |
| trailing  | Widget?       | -      | 右侧组件     |
| onTap     | VoidCallback? | -      | 点击回调     |
| isDivider | bool          | false  | 是否为分隔线 |
