# ZephyrUI 导航组件使用手册

## 概述

ZephyrUI 导航组件提供了完整的导航解决方案，包括侧边菜单、标签页、步进器等，帮助开发者构建直观、易用的应用导航结构。

## 组件列表

### 1. ZSideMenu 组件

#### 简介
ZSideMenu 是一个侧边菜单组件，支持多级菜单、图标显示和响应式设计。

#### 基本用法
```dart
import 'package:zephyr_ui/zephyr_ui.dart';

// 基本侧边菜单
ZSideMenu(
  items: [
    ZSideMenuItem(
      title: '首页',
      icon: Icons.home,
      onTap: () {},
    ),
    ZSideMenuItem(
      title: '用户管理',
      icon: Icons.people,
      onTap: () {},
    ),
    ZSideMenuItem(
      title: '设置',
      icon: Icons.settings,
      onTap: () {},
    ),
  ],
),

// 带子菜单的侧边菜单
ZSideMenu(
  items: [
    ZSideMenuItem(
      title: '产品管理',
      icon: Icons.inventory,
      children: [
        ZSideMenuItem(
          title: '产品列表',
          onTap: () {},
        ),
        ZSideMenuItem(
          title: '添加产品',
          onTap: () {},
        ),
      ],
    ),
    ZSideMenuItem(
      title: '订单管理',
      icon: Icons.shopping_cart,
      children: [
        ZSideMenuItem(
          title: '订单列表',
          onTap: () {},
        ),
        ZSideMenuItem(
          title: '订单统计',
          onTap: () {},
        ),
      ],
    ),
  ],
),
```

#### 属性说明
- `items`: 菜单项列表
- `selectedItem`: 当前选中项
- `onItemSelected`: 选中回调
- `expanded`: 是否展开
- `width`: 菜单宽度
- `collapsedWidth`: 折叠时宽度
- `showHeader`: 是否显示头部
- `header`: 自定义头部
- `footer`: 自定义底部

### 2. ZTabs 组件

#### 简介
ZTabs 是一个标签页组件，支持多种标签样式和内容切换。

#### 基本用法
```dart
// 基本标签页
ZTabs(
  tabs: [
    ZTab(
      title: '基本信息',
      content: Container(
        padding: EdgeInsets.all(16),
        child: Text('基本信息内容'),
      ),
    ),
    ZTab(
      title: '详细资料',
      content: Container(
        padding: EdgeInsets.all(16),
        child: Text('详细资料内容'),
      ),
    ),
    ZTab(
      title: '设置',
      content: Container(
        padding: EdgeInsets.all(16),
        child: Text('设置内容'),
      ),
    ),
  ],
),

// 带图标的标签页
ZTabs(
  tabs: [
    ZTab(
      icon: Icons.home,
      title: '首页',
      content: Text('首页内容'),
    ),
    ZTab(
      icon: Icons.settings,
      title: '设置',
      content: Text('设置内容'),
    ),
  ],
),

// 垂直标签页
ZTabs(
  direction: Axis.vertical,
  tabs: [
    ZTab(
      title: '标签1',
      content: Text('内容1'),
    ),
    ZTab(
      title: '标签2',
      content: Text('内容2'),
    ),
  ],
),
```

#### 属性说明
- `tabs`: 标签页列表
- `selectedTab`: 当前选中标签
- `onTabChanged`: 标签切换回调
- `direction`: 标签方向 (horizontal, vertical)
- `type`: 标签类型 (line, card, segment)
- `scrollable`: 是否可滚动
- `indicatorColor`: 指示器颜色
- `labelColor`: 标签颜色

### 3. ZStepper 组件

#### 简介
ZStepper 是一个步进器组件，用于展示多步骤流程。

#### 基本用法
```dart
// 基本步进器
ZStepper(
  steps: [
    ZStep(
      title: '第一步',
      content: Container(
        padding: EdgeInsets.all(16),
        child: Text('第一步内容'),
      ),
    ),
    ZStep(
      title: '第二步',
      content: Container(
        padding: EdgeInsets.all(16),
        child: Text('第二步内容'),
      ),
    ),
    ZStep(
      title: '第三步',
      content: Container(
        padding: EdgeInsets.all(16),
        child: Text('第三步内容'),
      ),
    ),
  ],
  currentStep: 1,
  onStepChanged: (index) {},
),

// 带子标题的步进器
ZStepper(
  steps: [
    ZStep(
      title: '基本信息',
      subtitle: '填写用户基本信息',
      content: Text('基本信息内容'),
    ),
    ZStep(
      title: '联系方式',
      subtitle: '填写联系方式',
      content: Text('联系方式内容'),
    ),
    ZStep(
      title: '完成',
      subtitle: '完成注册',
      content: Text('完成内容'),
    ),
  ],
  currentStep: 0,
  onStepChanged: (index) {},
),

// 垂直步进器
ZStepper(
  direction: Axis.vertical,
  steps: [
    ZStep(
      title: '步骤1',
      content: Text('内容1'),
    ),
    ZStep(
      title: '步骤2',
      content: Text('内容2'),
    ),
  ],
),
```

#### 属性说明
- `steps`: 步骤列表
- `currentStep`: 当前步骤索引
- `onStepChanged`: 步骤切换回调
- `direction`: 步进器方向 (horizontal, vertical)
- `type`: 步进器类型 (number, dot, icon)
- `controlsBuilder`: 自定义控制按钮
- `physics`: 滚动物理效果

### 4. ZPagination 组件

#### 简介
ZPagination 是一个分页组件，用于数据分页显示。

#### 基本用法
```dart
// 基本分页
ZPagination(
  currentPage: 1,
  totalPages: 10,
  onPageChanged: (page) {},
),

// 带每页显示数量的分页
ZPagination(
  currentPage: 1,
  totalPages: 10,
  pageSize: 20,
  totalItems: 200,
  onPageChanged: (page) {},
  onPageSizeChanged: (size) {},
),

// 简洁分页
ZPagination(
  currentPage: 1,
  totalPages: 10,
  type: ZPaginationType.simple,
  onPageChanged: (page) {},
),
```

#### 属性说明
- `currentPage`: 当前页码
- `totalPages`: 总页数
- `totalItems`: 总项目数
- `pageSize`: 每页显示数量
- `onPageChanged`: 页码变化回调
- `onPageSizeChanged`: 每页数量变化回调
- `type`: 分页类型 (default, simple, mini)
- `showSizeChanger`: 是否显示每页数量选择器
- `showQuickJumper`: 是否显示快速跳转

### 5. ZTree 组件

#### 简介
ZTree 是一个树形控件组件，用于展示层级数据。

#### 基本用法
```dart
// 基本树形控件
ZTree(
  nodes: [
    ZTreeNode(
      title: '根节点1',
      children: [
        ZTreeNode(
          title: '子节点1-1',
        ),
        ZTreeNode(
          title: '子节点1-2',
          children: [
            ZTreeNode(
              title: '叶子节点1-2-1',
            ),
          ],
        ),
      ],
    ),
    ZTreeNode(
      title: '根节点2',
      children: [
        ZTreeNode(
          title: '子节点2-1',
        ),
      ],
    ),
  ],
),

// 带图标的树形控件
ZTree(
  nodes: [
    ZTreeNode(
      title: '文件夹',
      icon: Icons.folder,
      expandedIcon: Icons.folder_open,
      children: [
        ZTreeNode(
          title: '文件1',
          icon: Icons.file_present,
        ),
        ZTreeNode(
          title: '文件2',
          icon: Icons.file_present,
        ),
      ],
    ),
  ],
  onNodeSelected: (node) {},
  onNodeExpanded: (node, expanded) {},
),
```

#### 属性说明
- `nodes`: 树节点列表
- `selectedNode`: 选中节点
- `expandedNodes`: 展开节点列表
- `onNodeSelected`: 节点选中回调
- `onNodeExpanded`: 节点展开回调
- `showIcon`: 是否显示图标
- `showLine`: 是否显示连接线
- `draggable`: 是否可拖拽

### 6. ZBottomNavigationBar 组件

#### 简介
ZBottomNavigationBar 是一个底部导航栏组件，适用于移动应用。

#### 基本用法
```dart
// 基本底部导航栏
ZBottomNavigationBar(
  items: [
    ZBottomNavigationBarItem(
      icon: Icons.home,
      label: '首页',
    ),
    ZBottomNavigationBarItem(
      icon: Icons.search,
      label: '搜索',
    ),
    ZBottomNavigationBarItem(
      icon: Icons.person,
      label: '我的',
    ),
  ],
  currentIndex: 0,
  onTap: (index) {},
),

// 带徽章的底部导航栏
ZBottomNavigationBar(
  items: [
    ZBottomNavigationBarItem(
      icon: Icons.home,
      label: '首页',
    ),
    ZBottomNavigationBarItem(
      icon: Icons.notifications,
      label: '通知',
      badge: '3',
    ),
    ZBottomNavigationBarItem(
      icon: Icons.person,
      label: '我的',
    ),
  ],
  currentIndex: 0,
  onTap: (index) {},
),
```

#### 属性说明
- `items`: 导航项列表
- `currentIndex`: 当前选中索引
- `onTap`: 点击回调
- `type`: 导航栏类型 (fixed, shifting)
- `backgroundColor`: 背景颜色
- `selectedColor`: 选中颜色
- `unselectedColor`: 未选中颜色

### 7. ZBreadcrumb 组件

#### 简介
ZBreadcrumb 是一个面包屑导航组件，用于显示页面层级关系。

#### 基本用法
```dart
// 基本面包屑
ZBreadcrumb(
  items: [
    ZBreadcrumbItem(
      title: '首页',
      onTap: () {},
    ),
    ZBreadcrumbItem(
      title: '产品管理',
      onTap: () {},
    ),
    ZBreadcrumbItem(
      title: '产品详情',
    ),
  ],
),

// 带图标的面包屑
ZBreadcrumb(
  items: [
    ZBreadcrumbItem(
      icon: Icons.home,
      title: '首页',
      onTap: () {},
    ),
    ZBreadcrumbItem(
      icon: Icons.inventory,
      title: '产品',
      onTap: () {},
    ),
    ZBreadcrumbItem(
      title: '详情',
    ),
  ],
),

// 可折叠的面包屑
ZBreadcrumb(
  items: [
    ZBreadcrumbItem(
      title: '首页',
      onTap: () {},
    ),
    ZBreadcrumbItem(
      title: '部门管理',
      onTap: () {},
    ),
    ZBreadcrumbItem(
      title: '技术部',
      onTap: () {},
    ),
    ZBreadcrumbItem(
      title: '前端组',
      onTap: () {},
    ),
    ZBreadcrumbItem(
      title: '当前页面',
    ),
  ],
  maxItems: 3,
),
```

#### 属性说明
- `items`: 面包屑项列表
- `separator`: 分隔符
- `maxItems`: 最大显示数量
- `onItemTap`: 项目点击回调
- `itemBuilder`: 自定义项目构建器

### 8. ZNavigationRail 组件

#### 简介
ZNavigationRail 是一个导航栏组件，适用于平板和桌面应用。

#### 基本用法
```dart
// 基本导航栏
ZNavigationRail(
  items: [
    ZNavigationRailItem(
      icon: Icons.home,
      label: '首页',
    ),
    ZNavigationRailItem(
      icon: Icons.search,
      label: '搜索',
    ),
    ZNavigationRailItem(
      icon: Icons.settings,
      label: '设置',
    ),
  ],
  selectedIndex: 0,
  onItemSelected: (index) {},
),

// 可展开的导航栏
ZNavigationRail(
  expanded: true,
  items: [
    ZNavigationRailItem(
      icon: Icons.dashboard,
      label: '仪表板',
    ),
    ZNavigationRailItem(
      icon: Icons.analytics,
      label: '分析',
    ),
  ],
  selectedIndex: 0,
  onItemSelected: (index) {},
),

// 带头部和尾部的导航栏
ZNavigationRail(
  header: Container(
    padding: EdgeInsets.all(16),
    child: Text('应用名称'),
  ),
  footer: Container(
    padding: EdgeInsets.all(16),
    child: Icon(Icons.logout),
  ),
  items: [
    ZNavigationRailItem(
      icon: Icons.home,
      label: '首页',
    ),
  ],
  selectedIndex: 0,
  onItemSelected: (index) {},
),
```

#### 属性说明
- `items`: 导航项列表
- `selectedIndex`: 选中索引
- `onItemSelected`: 选中回调
- `expanded`: 是否展开
- `header`: 头部组件
- `footer`: 尾部组件
- `backgroundColor`: 背景颜色
- `elevation`: 阴影深度

## 最佳实践

### 1. 导航结构设计
- 保持导航结构简单明了
- 使用合适的导航层次
- 考虑用户的使用习惯

### 2. 响应式设计
- 在不同设备上使用合适的导航方式
- 移动端使用底部导航或抽屉菜单
- 平板和桌面使用侧边导航栏

### 3. 用户体验
- 提供清晰的当前位置指示
- 支持深度链接和书签
- 保持导航状态的一致性

### 4. 性能优化
- 使用懒加载处理大量数据
- 优化树形控件的渲染性能
- 合理使用动画效果

## 常见问题

### Q: 如何处理深层导航？
A: 使用面包屑导航或层级菜单来处理深层导航结构。

### Q: 如何优化大量数据的树形控件？
A: 使用懒加载和虚拟滚动来优化性能。

### Q: 如何实现导航状态管理？
A: 使用状态管理库或路由系统来管理导航状态。

## 相关资源

- [API 参考文档](../api/navigation-components.md)
- [响应式设计指南](../guides/responsive-design.md)
- [最佳实践](../guides/best-practices.md)
- [示例代码](../../example/lib/components/navigation_components_demo.dart)