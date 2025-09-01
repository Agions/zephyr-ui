# ZephyrUI 基础组件使用手册

## 概述

ZephyrUI 基础组件是构建用户界面的核心元素，提供了丰富的基础UI组件，帮助开发者快速构建美观、一致的用户界面。

## 组件列表

### 1. ZAvatar 组件

#### 简介
ZAvatar 是一个头像显示组件，支持文字、图标和图片三种显示方式。

#### 基本用法
```dart
import 'package:zephyr_ui/zephyr_ui.dart';

// 文字头像
ZAvatar.text(
  '张三',
  size: ZephyrAvatarSize.medium,
  backgroundColor: Colors.blue,
)

// 图标头像
ZAvatar.icon(
  Icons.person,
  size: ZephyrAvatarSize.medium,
  backgroundColor: Colors.green,
)

// 图片头像
ZAvatar.image(
  'https://example.com/avatar.jpg',
  size: ZephyrAvatarSize.medium,
)
```

#### 属性说明
- `size`: 头像大小 (extraSmall, small, medium, large, extraLarge)
- `backgroundColor`: 背景颜色
- `foregroundColor`: 前景颜色
- `shape`: 头像形状 (circle, square)
- `border`: 边框设置
- `showShadow`: 是否显示阴影

#### 最佳实践
- 使用文字头像时，建议显示用户姓名的首字母
- 图片头像应该提供加载失败的占位符
- 在不同的屏幕尺寸下选择合适的大小

### 2. ZBadge 组件

#### 简介
ZBadge 是一个徽章组件，通常用于显示通知数量或状态标记。

#### 基本用法
```dart
// 数字徽章
ZBadge(
  count: 5,
  child: Icon(Icons.notifications),
)

// 点状徽章
ZBadge.dot(
  child: Icon(Icons.mail),
)

// 自定义徽章
ZBadge(
  child: Icon(Icons.shopping_cart),
  badge: Container(
    padding: EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
    child: Text('新'),
  ),
)
```

#### 属性说明
- `count`: 显示的数字
- `showZero`: 是否显示0
- `maxCount`: 最大显示数字
- `position`: 徽章位置 (topRight, topLeft, bottomRight, bottomLeft)
- `color`: 徽章颜色
- `offset`: 徽章偏移量

### 3. ZButton 组件

#### 简介
ZButton 是一个功能丰富的按钮组件，支持多种样式和状态。

#### 基本用法
```dart
// 主要按钮
ZButton(
  text: '提交',
  onPressed: () {},
  type: ZButtonType.primary,
)

// 次要按钮
ZButton(
  text: '取消',
  onPressed: () {},
  type: ZButtonType.secondary,
)

// 文本按钮
ZButton(
  text: '了解更多',
  onPressed: () {},
  type: ZButtonType.text,
)

// 图标按钮
ZButton.icon(
  icon: Icons.add,
  onPressed: () {},
  tooltip: '添加',
)

// 加载状态
ZButton(
  text: '保存中...',
  onPressed: () {},
  loading: true,
)
```

#### 属性说明
- `type`: 按钮类型 (primary, secondary, text, outline)
- `size`: 按钮大小 (small, medium, large)
- `disabled`: 是否禁用
- `loading`: 是否显示加载状态
- `fullWidth`: 是否占满宽度
- `icon`: 按钮图标
- `onPressed`: 点击回调

### 4. ZCard 组件

#### 简介
ZCard 是一个卡片容器组件，提供统一的内容展示样式。

#### 基本用法
```dart
ZCard(
  title: '用户信息',
  subtitle: '个人资料',
  child: Column(
    children: [
      ListTile(
        leading: Icon(Icons.person),
        title: Text('姓名'),
        trailing: Text('张三'),
      ),
      ListTile(
        leading: Icon(Icons.email),
        title: Text('邮箱'),
        trailing: Text('zhangsan@example.com'),
      ),
    ],
  ),
)

// 带操作的卡片
ZCard(
  title: '设置',
  actions: [
    ZButton(
      text: '编辑',
      onPressed: () {},
      type: ZButtonType.text,
    ),
  ],
  child: Text('这里是设置内容'),
)
```

#### 属性说明
- `title`: 卡片标题
- `subtitle`: 卡片副标题
- `child`: 卡片内容
- `actions`: 卡片操作按钮
- `elevation`: 阴影深度
- `borderRadius`: 边框圆角
- `padding`: 内边距

### 5. ZChip 组件

#### 简介
ZChip 是一个芯片组件，用于显示标签、分类或选择项。

#### 基本用法
```dart
// 基本芯片
ZChip(
  label: '标签1',
  onPressed: () {},
)

// 可删除芯片
ZChip(
  label: '可删除标签',
  onDeleted: () {},
)

// 选择芯片
ZChip(
  label: '选择项',
  selected: true,
  onSelected: (value) {},
)

// 带图标的芯片
ZChip(
  label: '带图标',
  avatar: Icon(Icons.star),
  onPressed: () {},
)
```

#### 属性说明
- `label`: 芯片标签
- `selected`: 是否选中
- `onSelected`: 选择回调
- `onDeleted`: 删除回调
- `avatar`: 芯片头像
- `color`: 芯片颜色
- `disabled`: 是否禁用

### 6. ZDivider 组件

#### 简介
ZDivider 是一个分隔线组件，用于分隔内容区域。

#### 基本用法
```dart
// 水平分隔线
ZDivider(),

// 带文本的分隔线
ZDivider.withText('或'),

// 垂直分隔线
ZDivider.vertical(),

// 自定义样式
ZDivider(
  color: Colors.grey,
  thickness: 2,
  indent: 16,
  endIndent: 16,
)
```

#### 属性说明
- `color`: 分隔线颜色
- `thickness`: 分隔线厚度
- `indent`: 起始缩进
- `endIndent`: 结束缩进
- `height`: 分隔线高度

### 7. ZIcon 组件

#### 简介
ZIcon 是一个图标组件，提供了丰富的图标选择和自定义选项。

#### 基本用法
```dart
// 基本图标
ZIcon(Icons.home),

// 带颜色的图标
ZIcon(
  Icons.favorite,
  color: Colors.red,
  size: 24,
),

// 可点击的图标
ZIcon(
  Icons.settings,
  onPressed: () {},
  tooltip: '设置',
)
```

#### 属性说明
- `icon`: 图标数据
- `size`: 图标大小
- `color`: 图标颜色
- `onPressed`: 点击回调
- `tooltip`: 工具提示

### 8. ZText 组件

#### 简介
ZText 是一个文本组件，提供了统一的文本样式和排版。

#### 基本用法
```dart
// 标题文本
ZText.heading1('大标题'),
ZText.heading2('中标题'),
ZText.heading3('小标题'),

// 正文文本
ZText.body('这是正文内容'),
ZText.caption('这是说明文字'),

// 自定义样式
ZText(
  '自定义文本',
  style: TextStyle(
    color: Colors.blue,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
)
```

#### 属性说明
- `data`: 文本内容
- `style`: 文本样式
- `textAlign`: 文本对齐
- `maxLines`: 最大行数
- `overflow`: 溢出处理
- `color`: 文本颜色

## 最佳实践

### 1. 统一性
- 在整个应用中保持组件样式的一致性
- 使用主题系统统一管理颜色和字体

### 2. 可访问性
- 为所有交互组件提供适当的语义
- 确保文本颜色对比度符合WCAG标准
- 为图标和按钮提供工具提示

### 3. 性能优化
- 在列表中使用 `const` 构造函数
- 避免在构建方法中创建复杂的对象
- 使用 `Key` 来优化Widget重建

### 4. 响应式设计
- 根据屏幕尺寸调整组件大小
- 使用媒体查询适配不同设备
- 考虑横屏和竖屏的布局差异

## 常见问题

### Q: 如何自定义组件主题？
A: 使用 `ZephyrTheme` 和 `ThemeExtension` 来自定义组件主题。

### Q: 组件加载很慢怎么办？
A: 检查是否在构建方法中创建了复杂对象，使用 `const` 构造函数优化性能。

### Q: 如何处理组件的错误状态？
A: 使用 `ErrorWidget` 或自定义错误处理逻辑来优雅地处理错误。

## 相关资源

- [API 参考文档](./api/basic-components.md)
- [主题定制指南](../guides/theme-customization.md)
- [响应式设计指南](../guides/responsive-design.md)
- [示例代码](../../example/lib/components/)