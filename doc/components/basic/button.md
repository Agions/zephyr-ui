---
title: Button 按钮
description: VelocityUI 按钮组件，支持多种类型、尺寸和状态，用于触发操作或事件
---

# Button 按钮

## 简介

Button 是一个功能丰富的按钮组件，用于触发各种操作或事件，如提交表单、打开对话框、取消操作或执行删除操作。

### 核心特性

- 支持多种按钮类型（主要、次要、轮廓、文本、成功、警告、危险）
- 支持三种按钮尺寸（小、中、大）
- 支持图标按钮（左侧图标、右侧图标、纯图标）
- 支持加载状态和禁用状态
- 支持全宽按钮
- 支持自定义样式
- 支持主题定制

### 使用场景

- 表单提交和重置操作
- 对话框的确认和取消按钮
- 导航和跳转操作
- 数据删除和确认操作
- 加载更多和刷新操作
- 收藏和点赞等交互操作

## 基本用法

```dart
VelocityButton.text(
  text: '按钮',
  onPressed: () {
    // 处理点击事件
  },
)
```

## 属性配置

### 按钮类型

VelocityUI 提供了多种按钮类型以满足不同场景：

```dart
// 主要按钮 - 用于重要操作，突出显示
VelocityButton.text(text: '主要按钮', type: VelocityButtonType.primary, onPressed: () {})

// 次要按钮 - 用于次要操作，视觉层级低于主要按钮
VelocityButton.text(text: '次要按钮', type: VelocityButtonType.secondary, onPressed: () {})

// 轮廓按钮 - 用于非主要操作，视觉干扰小
VelocityButton.text(text: '轮廓按钮', type: VelocityButtonType.outline, onPressed: () {})

// 文本按钮 - 用于辅助操作，无背景和边框
VelocityButton.text(text: '文本按钮', type: VelocityButtonType.text, onPressed: () {})

// 成功按钮 - 用于成功状态的操作
VelocityButton.text(text: '成功按钮', type: VelocityButtonType.success, onPressed: () {})

// 警告按钮 - 用于警告状态的操作
VelocityButton.text(text: '警告按钮', type: VelocityButtonType.warning, onPressed: () {})

// 危险按钮 - 用于危险状态的操作，如删除
VelocityButton.text(text: '危险按钮', type: VelocityButtonType.danger, onPressed: () {})
```

### 按钮尺寸

按钮支持三种尺寸，可根据不同的布局需求选择：

```dart
// 小按钮 - 用于空间受限的场景
VelocityButton.text(text: '小按钮', size: VelocityButtonSize.small, onPressed: () {})

// 中按钮 - 默认尺寸，适用于大多数场景
VelocityButton.text(text: '中按钮', size: VelocityButtonSize.medium, onPressed: () {})

// 大按钮 - 用于强调重要操作
VelocityButton.text(text: '大按钮', size: VelocityButtonSize.large, onPressed: () {})
```

### 按钮状态

按钮支持多种状态，可根据业务逻辑动态切换：

```dart
// 加载状态 - 用于异步操作过程中
VelocityButton.text(text: '加载中', loading: true, onPressed: () {})

// 禁用状态 - 用于不可交互的按钮
VelocityButton.text(text: '禁用', disabled: true, onPressed: () {})

// 全宽按钮 - 用于需要占满容器宽度的场景
VelocityButton.text(text: '全宽按钮', fullWidth: true, onPressed: () {})
```

## 高级用法

### 图标按钮

按钮可以包含图标，增强视觉表达：

```dart
// 左侧图标 - 图标在文本左侧
VelocityButton.icon(
  text: '添加',
  icon: Icons.add,
  onPressed: () {},
)

// 右侧图标 - 图标在文本右侧
VelocityButton.icon(
  text: '下一步',
  icon: Icons.arrow_forward,
  iconPosition: VelocityIconPosition.right,
  onPressed: () {},
)
```

### 纯图标按钮

用于仅需要图标的场景：

```dart
VelocityIconButton(
  icon: Icons.favorite,
  onPressed: () {},
  tooltip: '收藏', // 悬停提示
  size: 40, // 按钮大小
  iconSize: 20, // 图标大小
)
```

### 自定义子组件

对于更复杂的按钮内容，可以使用自定义子组件：

```dart
VelocityButton(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.shopping_cart, size: 16),
      SizedBox(width: 8),
      Text('添加到购物车'),
    ],
  ),
  onPressed: () {},
)
```

## 样式定制

### 自定义样式

按钮支持通过 `style` 属性进行样式定制：

```dart
VelocityButton.text(
  text: '自定义样式',
  onPressed: () {},
  style: VelocityButtonStyle(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    borderRadius: BorderRadius.circular(20),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    border: Border.all(color: Colors.purple, width: 2),
    // 更多样式属性...
  ),
)
```

### 主题支持

按钮组件支持通过主题进行全局样式定制，可以在应用的主题中配置按钮的默认样式。

## 状态管理

按钮的状态管理主要通过属性传递和回调函数实现：

- `onPressed`：点击事件回调
- `onLongPress`：长按事件回调
- `loading`：控制加载状态
- `disabled`：控制禁用状态

## 可访问性

### 无障碍支持

- 支持语义化标签
- 支持屏幕阅读器
- 支持键盘导航
- 支持悬停和焦点状态

### 使用建议

- 为按钮添加有意义的文本或 tooltip
- 确保按钮有足够的点击区域（建议至少 48x48 像素）
- 为不同状态的按钮提供清晰的视觉反馈
- 确保按钮在不同主题下都有良好的对比度

## 最佳实践

1. **选择合适的按钮类型**：

   - 主要操作使用主要按钮
   - 次要操作使用次要按钮或轮廓按钮
   - 危险操作使用危险按钮
   - 辅助操作使用文本按钮

2. **按钮尺寸选择**：

   - 在移动设备上，建议使用中等或大尺寸按钮
   - 在桌面设备上，可以根据布局需求选择合适的尺寸
   - 图标按钮的尺寸建议保持一致

3. **按钮文本简洁明了**：

   - 使用动词开头，如"提交"、"保存"、"删除"
   - 保持文本简短，通常不超过 2-3 个词
   - 避免使用模糊或歧义的文本

4. **合理使用加载状态**：

   - 对于异步操作，建议显示加载状态
   - 加载状态下应禁用按钮，防止重复点击
   - 提供清晰的加载指示器

5. **按钮组的使用**：
   - 将相关按钮组合在一起
   - 保持按钮组内的视觉一致性
   - 主要按钮通常放在右侧

## 常见问题

### 问题：按钮在某些设备上点击区域过小

**症状**：在移动设备上，按钮很难被点击到

**原因**：按钮的实际点击区域小于推荐的 48x48 像素

**解决方案**：

- 调整按钮的 `size` 属性为较大尺寸
- 使用 `padding` 属性增加按钮的点击区域
- 避免使用过小的自定义图标按钮

### 问题：按钮样式与设计稿不符

**症状**：按钮的颜色、圆角、阴影等与设计稿不一致

**解决方案**：

- 使用 `style` 属性自定义按钮样式
- 调整 `backgroundColor`、`borderRadius`、`boxShadow` 等属性
- 考虑在主题中配置全局按钮样式

### 问题：按钮在加载状态下仍可点击

**症状**：按钮显示加载状态，但仍能被点击

**解决方案**：

- 确保在设置 `loading: true` 时，按钮的 `disabled` 属性也被正确设置
- 或者在 `onPressed` 回调中检查加载状态

## API 参考

### VelocityButton

| 属性        | 类型                 | 默认值  | 说明           |
| ----------- | -------------------- | ------- | -------------- |
| child       | Widget?              | -       | 自定义按钮内容 |
| onPressed   | VoidCallback?        | -       | 点击事件回调   |
| onLongPress | VoidCallback?        | -       | 长按事件回调   |
| type        | VelocityButtonType   | primary | 按钮类型       |
| size        | VelocityButtonSize   | medium  | 按钮尺寸       |
| loading     | bool                 | false   | 加载状态       |
| disabled    | bool                 | false   | 禁用状态       |
| fullWidth   | bool                 | false   | 是否全宽显示   |
| style       | VelocityButtonStyle? | -       | 自定义样式     |

### VelocityButton.text

| 属性        | 类型                 | 默认值  | 说明         |
| ----------- | -------------------- | ------- | ------------ |
| text        | String               | -       | 按钮文本     |
| onPressed   | VoidCallback?        | -       | 点击事件回调 |
| onLongPress | VoidCallback?        | -       | 长按事件回调 |
| type        | VelocityButtonType   | primary | 按钮类型     |
| size        | VelocityButtonSize   | medium  | 按钮尺寸     |
| loading     | bool                 | false   | 加载状态     |
| disabled    | bool                 | false   | 禁用状态     |
| fullWidth   | bool                 | false   | 是否全宽显示 |
| style       | VelocityButtonStyle? | -       | 自定义样式   |

### VelocityButton.icon

| 属性         | 类型                 | 默认值  | 说明         |
| ------------ | -------------------- | ------- | ------------ |
| text         | String               | -       | 按钮文本     |
| icon         | IconData             | -       | 按钮图标     |
| iconPosition | VelocityIconPosition | left    | 图标位置     |
| onPressed    | VoidCallback?        | -       | 点击事件回调 |
| onLongPress  | VoidCallback?        | -       | 长按事件回调 |
| type         | VelocityButtonType   | primary | 按钮类型     |
| size         | VelocityButtonSize   | medium  | 按钮尺寸     |
| loading      | bool                 | false   | 加载状态     |
| disabled     | bool                 | false   | 禁用状态     |
| fullWidth    | bool                 | false   | 是否全宽显示 |
| style        | VelocityButtonStyle? | -       | 自定义样式   |

### VelocityIconButton

| 属性      | 类型                     | 默认值 | 说明         |
| --------- | ------------------------ | ------ | ------------ |
| icon      | IconData                 | -      | 按钮图标     |
| onPressed | VoidCallback?            | -      | 点击事件回调 |
| size      | double                   | 40     | 按钮大小     |
| iconSize  | double                   | 20     | 图标大小     |
| style     | VelocityIconButtonStyle? | -      | 自定义样式   |
| disabled  | bool                     | false  | 禁用状态     |
| loading   | bool                     | false  | 加载状态     |
| tooltip   | String?                  | -      | 悬停提示     |

### VelocityButtonType

| 类型      | 说明                             |
| --------- | -------------------------------- |
| primary   | 主要按钮，突出显示               |
| secondary | 次要按钮，视觉层级低于主要按钮   |
| outline   | 轮廓按钮，只有边框，无背景色     |
| text      | 文本按钮，只有文本，无背景和边框 |
| success   | 成功按钮，使用成功主题色         |
| warning   | 警告按钮，使用警告主题色         |
| danger    | 危险按钮，使用危险主题色         |

### VelocityButtonSize

| 尺寸   | 说明                 |
| ------ | -------------------- |
| small  | 小尺寸按钮           |
| medium | 中等尺寸按钮（默认） |
| large  | 大尺寸按钮           |

### VelocityIconPosition

| 位置  | 说明           |
| ----- | -------------- |
| left  | 图标在文本左侧 |
| right | 图标在文本右侧 |

## 相关组件

- [VelocityText 文本](/components/basic/text)
- [VelocityIcon 图标](/components/basic/icon)
- [VelocityChip 芯片](/components/basic/chip)

## 更新日志

### v1.0.0

- 初始版本发布
- 支持多种按钮类型和尺寸
- 支持图标按钮和纯图标按钮
- 支持加载状态和禁用状态

### v1.0.1

- 修复了某些情况下按钮样式不生效的问题
- 优化了按钮的触摸反馈
- 增加了对自定义子组件的支持

---

::: tip 提示

- 按钮的 `loading` 和 `disabled` 属性是独立的，需要分别设置
- 纯图标按钮建议添加 `tooltip` 属性，提高可访问性
- 对于重要操作，建议使用较大尺寸的主要按钮

:::

::: warning 警告

- 避免在按钮文本中使用过长的文本，这会影响按钮的布局和可读性
- 不要在同一页面上使用过多不同类型的按钮，这会造成视觉混乱
- 禁用状态的按钮应有明显的视觉区分

:::
