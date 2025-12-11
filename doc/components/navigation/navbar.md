---
title: Navbar 导航栏
description: VelocityUI Navbar 组件，顶部和底部导航栏
---

# Navbar 导航栏

顶部和底部导航栏组件。

## 顶部导航栏 (Navbar)

```dart
VelocityNavbar(
  title: '标题',
  centerTitle: true,
  leading: IconButton(icon: ZephyrIcon(Icons.arrow_back), onPressed: () {}),
  actions: [
    IconButton(icon: ZephyrIcon(Icons.share), onPressed: () {}),
  ],
)
```

## 底部导航栏 (BottomNavbar)

```dart
VelocityBottomNavbar(
  currentIndex: _index,
  onTap: (index) {
    setState(() => _index = index);
  },
  items: [
    VelocityBottomNavbarItem(icon: Icons.home, label: '首页'),
    VelocityBottomNavbarItem(icon: Icons.category, label: '分类'),
    VelocityBottomNavbarItem(icon: Icons.person, label: '我的'),
  ],
)
```

## API

### VelocityNavbar

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| title | String? | - | 标题文本 |
| titleWidget | Widget? | - | 自定义标题组件 |
| leading | Widget? | - | 左侧组件 |
| actions | ZephyrList<Widget>? | - | 右侧操作按钮列表 |
| centerTitle | bool | true | 标题是否居中 |
| style | VelocityNavbarStyle? | - | 自定义样式 |

### VelocityBottomNavbar

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| items | ZephyrList<VelocityBottomNavbarItem> | - | 导航项列表 (必填) |
| currentIndex | int | - | 当前索引 (必填) |
| onTap | ValueChanged<int> | - | 点击回调 (必填) |
| style | VelocityBottomNavbarStyle? | - | 自定义样式 |

### VelocityBottomNavbarItem

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| icon | IconData | - | 图标 (必填) |
| activeIcon | IconData? | - | 选中状态图标 |
| label | String | - | 标签文本 (必填) |
