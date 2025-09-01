# ZephyrUI 组件选择指南

## 概述

ZephyrUI 提供了丰富的组件库，选择合适的组件对于构建优秀的用户界面至关重要。本指南将帮助您根据不同的使用场景选择合适的组件。

## 组件分类矩阵

### 基础组件

| 组件 | 主要用途 | 适用场景 | 特点 |
|------|----------|----------|------|
| **ZAvatar** | 头像显示 | 用户头像、品牌标识 | 支持文字、图标、图片 |
| **ZBadge** | 徽章标记 | 通知数量、状态标记 | 支持数字、点状、自定义 |
| **ZButton** | 按钮操作 | 表单提交、页面跳转 | 多种样式、加载状态 |
| **ZCard** | 内容容器 | 信息展示、内容分组 | 阴影效果、圆角边框 |
| **ZChip** | 标签显示 | 分类标签、过滤选项 | 可选中、可删除 |
| **ZDivider** | 内容分隔 | 区域分隔、视觉分组 | 水平、垂直、带文本 |
| **ZIcon** | 图标显示 | 操作图标、状态图标 | 丰富图标库、可点击 |
| **ZText** | 文本显示 | 标题、正文、说明 | 多种文本样式 |

### 表单组件

| 组件 | 主要用途 | 适用场景 | 特点 |
|------|----------|----------|------|
| **ZInputField** | 文本输入 | 用户名、邮箱、搜索 | 多种输入类型、验证 |
| **ZTextArea** | 多行文本 | 描述、评论、备注 | 字符计数、自动扩展 |
| **ZSelect** | 选项选择 | 分类选择、状态选择 | 单选、多选、可搜索 |
| **ZCheckbox** | 多选操作 | 兴趣选择、权限设置 | 支持组合选择 |
| **ZRadio** | 单选操作 | 性别选择、类型选择 | 互斥选择 |
| **ZSwitch** | 开关操作 | 功能开关、状态切换 | 二选一状态 |
| **ZSlider** | 数值选择 | 音量、亮度、价格 | 范围选择、步进控制 |
| **ZDatePicker** | 日期选择 | 生日、预约、日期范围 | 多种日期模式 |
| **ZTimePicker** | 时间选择 | 时间设置、预约时间 | 12/24小时制 |
| **ZRating** | 评分操作 | 产品评价、服务评分 | 星级评分、自定义 |
| **ZFormBuilder** | 表单构建 | 复杂表单、动态表单 | 声明式构建、统一验证 |

### 导航组件

| 组件 | 主要用途 | 适用场景 | 特点 |
|------|----------|----------|------|
| **ZSideMenu** | 侧边导航 | 管理后台、复杂应用 | 多级菜单、响应式 |
| **ZTabs** | 标签导航 | 内容切换、分类浏览 | 多种样式、可滚动 |
| **ZStepper** | 步骤导航 | 流程引导、分步表单 | 垂直/水平、进度指示 |
| **ZPagination** | 分页导航 | 数据列表、分页浏览 | 多种分页样式 |
| **ZTree** | 树形导航 | 层级数据、目录结构 | 多级展开、拖拽支持 |
| **ZBottomNavigationBar** | 底部导航 | 移动应用、主要功能 | 图标+文字、徽章支持 |
| **ZBreadcrumb** | 面包屑导航 | 页面层级、当前位置 | 层级显示、可折叠 |
| **ZNavigationRail** | 侧边导航栏 | 平板应用、桌面应用 | 可展开、头部尾部 |

## 场景化选择指南

### 1. 用户注册表单

**推荐组件组合：**
```dart
Column(
  children: [
    ZInputField(label: '用户名'),
    ZInputField(label: '邮箱'),
    ZInputField(label: '密码', obscureText: true),
    ZDatePicker(label: '出生日期'),
    ZRadio(label: '性别'),
    ZCheckbox(label: '同意条款'),
    ZButton(text: '注册'),
  ],
)
```

**选择理由：**
- 使用 `ZInputField` 处理文本输入
- 使用 `ZDatePicker` 处理日期选择
- 使用 `ZRadio` 处理性别选择
- 使用 `ZCheckbox` 处理协议同意
- 使用 `ZButton` 处理表单提交

### 2. 产品管理后台

**推荐组件组合：**
```dart
Row(
  children: [
    ZSideMenu(
      items: [/* 菜单项 */],
    ),
    Expanded(
      child: ZTabs(
        tabs: [
          ZTab(title: '产品列表'),
          ZTab(title: '添加产品'),
        ],
      ),
    ),
  ],
)
```

**选择理由：**
- 使用 `ZSideMenu` 处理主导航
- 使用 `ZTabs` 处理内容切换
- 在产品列表中使用 `ZTable` 和 `ZPagination`
- 在添加产品中使用 `ZFormBuilder`

### 3. 电商应用

**推荐组件组合：**
```dart
Column(
  children: [
    // 搜索栏
    ZInputField(
      placeholder: '搜索商品',
      prefixIcon: Icon(Icons.search),
    ),
    
    // 商品列表
    Expanded(
      child: ZGrid(
        children: [
          ZCard(
            child: Column(
              children: [
                ZImage(imageUrl: product.image),
                ZText.heading3(product.name),
                ZText('¥${product.price}'),
                ZButton(text: '加入购物车'),
              ],
            ),
          ),
        ],
      ),
    ),
    
    // 底部导航
    ZBottomNavigationBar(
      items: [
        ZBottomNavigationBarItem(icon: Icons.home, label: '首页'),
        ZBottomNavigationBarItem(icon: Icons.shopping_cart, label: '购物车'),
        ZBottomNavigationBarItem(icon: Icons.person, label: '我的'),
      ],
    ),
  ],
)
```

**选择理由：**
- 使用 `ZInputField` 处理搜索功能
- 使用 `ZGrid` 和 `ZCard` 展示商品
- 使用 `ZBottomNavigationBar` 处理主要导航

### 4. 数据分析仪表板

**推荐组件组合：**
```dart
Row(
  children: [
    ZNavigationRail(
      items: [/* 导航项 */],
    ),
    Expanded(
      child: Column(
        children: [
          // 统计卡片
          ZGrid(
            children: [
              ZStatistic(
                title: '总用户数',
                value: '10,234',
                icon: Icons.people,
              ),
              ZStatistic(
                title: '总收入',
                value: '¥234,567',
                icon: Icons.attach_money,
              ),
            ],
          ),
          
          // 图表
          ZCard(
            title: '用户增长趋势',
            child: ZChart(
              type: ZChartType.line,
              data: userData,
            ),
          ),
          
          // 数据表格
          ZCard(
            title: '最新订单',
            child: ZTable(
              columns: [/* 列定义 */],
              data: orderData,
            ),
          ),
        ],
      ),
    ),
  ],
)
```

**选择理由：**
- 使用 `ZNavigationRail` 处理桌面端导航
- 使用 `ZStatistic` 展示关键指标
- 使用 `ZChart` 展示趋势数据
- 使用 `ZTable` 展示详细数据

### 5. 内容发布系统

**推荐组件组合：**
```dart
ZStepper(
  steps: [
    ZStep(
      title: '基本信息',
      content: Column(
        children: [
          ZInputField(label: '标题'),
          ZTextArea(label: '摘要'),
        ],
      ),
    ),
    ZStep(
      title: '内容编辑',
      content: ZEditor(
        initialContent: content,
        onChanged: (value) {},
      ),
    ),
    ZStep(
      title: '发布设置',
      content: Column(
        children: [
          ZDatePicker(label: '发布时间'),
          ZSelect(label: '分类'),
          ZSwitch(label: '立即发布'),
        ],
      ),
    ),
  ],
)
```

**选择理由：**
- 使用 `ZStepper` 处理多步骤发布流程
- 使用 `ZEditor` 处理富文本编辑
- 使用 `ZDatePicker` 处理定时发布
- 使用 `ZSelect` 处理分类选择

## 性能优化建议

### 1. 列表性能
- **大数据列表**: 使用 `ZList` + 虚拟滚动
- **网格布局**: 使用 `ZGrid` + 延迟加载
- **分页数据**: 使用 `ZPagination` 分页加载

### 2. 表单性能
- **复杂表单**: 使用 `ZFormBuilder` 统一管理
- **动态表单**: 使用动态生成字段
- **表单验证**: 使用内置验证规则

### 3. 导航性能
- **深层导航**: 使用 `ZBreadcrumb` 管理层级
- **大量菜单**: 使用 `ZSideMenu` + 懒加载
- **标签切换**: 使用 `ZTabs` + 内容缓存

## 可访问性建议

### 1. 语义化选择
- 使用合适的组件表达语义
- 为所有交互组件提供标签
- 支持键盘导航

### 2. 视觉辅助
- 确保颜色对比度符合标准
- 提供足够的点击区域
- 使用图标时配合文字说明

### 3. 屏幕阅读器
- 为所有组件提供语义化标签
- 确保状态变化能被正确识别
- 支持屏幕阅读器导航

## 最佳实践总结

### 1. 统一性
- 在整个应用中保持组件样式一致
- 使用主题系统统一管理样式
- 遵循设计规范

### 2. 可用性
- 提供清晰的操作反馈
- 支持撤销和重做
- 处理错误状态

### 3. 性能
- 使用合适的组件处理大数据
- 优化渲染性能
- 合理使用动画

### 4. 维护性
- 使用组合而非继承
- 保持组件的单一职责
- 提供良好的文档

## 常见问题

### Q: 如何选择合适的表单组件？
A: 根据数据类型选择：文本用 `ZInputField`，长文本用 `ZTextArea`，选项用 `ZSelect` 或 `ZRadio`，开关用 `ZSwitch`。

### Q: 如何处理复杂的导航结构？
A: 使用组合导航：主导航用 `ZSideMenu` 或 `ZBottomNavigationBar`，次级导航用 `ZTabs`，层级导航用 `ZBreadcrumb`。

### Q: 如何优化大量数据的展示？
A: 使用虚拟滚动、分页加载、懒加载等技术，选择合适的列表组件。

## 相关资源

- [基础组件文档](./basic/basic-components.md)
- [表单组件文档](./form/form-components.md)
- [导航组件文档](./navigation/navigation-components.md)
- [最佳实践指南](../guides/best-practices.md)
- [性能优化指南](../guides/performance.md)