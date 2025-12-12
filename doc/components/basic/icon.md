---
title: Icon 图标
description: VelocityUI Icon 组件，提供统一的图标展示风格和尺寸管理
---

# Icon 图标

## 简介

Icon 是一个用于展示图标的组件，提供统一的尺寸和样式管理，支持多种图标库和自定义图标。

### 核心特性

- 支持 Material Icons 图标库
- 提供 5 种预置尺寸
- 支持自定义尺寸
- 支持自定义颜色
- 支持主题定制
- 支持无障碍访问
- 支持语义标签

### 使用场景

- 导航菜单和底部导航栏
- 按钮和操作控件
- 状态指示器
- 表单字段和输入控件
- 卡片和列表项
- 数据可视化

## 基本用法

```dart
VelocityIcon(Icons.home)
```

## 属性配置

### 图标数据

```dart
// 使用 Material Icons
VelocityIcon(Icons.home)

// 使用自定义图标库
VelocityIcon(MyCustomIcons.customIcon)
```

### 图标尺寸

VelocityUI 提供了五种预置尺寸，以适应不同的使用场景：

```dart
// 超小尺寸 (14px) - 用于紧凑布局
VelocityIcon(Icons.home, size: VelocityIconSize.xs)

// 小尺寸 (18px) - 用于辅助文本和标签
VelocityIcon(Icons.home, size: VelocityIconSize.sm)

// 中等尺寸 (24px) - 默认尺寸，用于大多数场景
VelocityIcon(Icons.home, size: VelocityIconSize.md)

// 大尺寸 (32px) - 用于强调和突出显示
VelocityIcon(Icons.home, size: VelocityIconSize.lg)

// 超大尺寸 (48px) - 用于关键操作和重点展示
VelocityIcon(Icons.home, size: VelocityIconSize.xl)
```

### 自定义尺寸

对于预置尺寸无法满足的场景，可以使用 `customSize` 属性自定义图标尺寸：

```dart
// 自定义尺寸 (64px)
VelocityIcon(Icons.home, customSize: 64)

// 结合其他组件使用自定义尺寸
VelocityIcon(Icons.home, customSize: 100)
```

### 图标颜色

```dart
// 使用预设颜色
VelocityIcon(Icons.favorite, color: VelocityColors.error)
VelocityIcon(Icons.check, color: VelocityColors.success)

// 使用自定义颜色
VelocityIcon(Icons.star, color: Colors.purple)

// 使用主题颜色
VelocityIcon(Icons.settings, color: Theme.of(context).primaryColor)
```

### 语义标签

为了提高可访问性，可以添加语义标签：

```dart
VelocityIcon(
  Icons.delete,
  semanticLabel: '删除',
)

VelocityIcon(
  Icons.save,
  semanticLabel: '保存',
)
```

## 高级用法

### 与其他组件结合使用

#### 图标按钮

```dart
VelocityButton.icon(
  text: '添加',
  icon: Icons.add,
  onPressed: () {
    // 处理点击事件
  },
)
```

#### 带图标的列表项

```dart
VelocityListTile(
  leading: VelocityIcon(Icons.folder),
  title: VelocityText('文档'),
  trailing: VelocityIcon(Icons.chevron_right),
  onTap: () {
    // 处理点击事件
  },
)
```

#### 状态指示器

```dart
Row(
  children: [
    VelocityIcon(Icons.check_circle, color: VelocityColors.success),
    SizedBox(width: 8),
    VelocityText('操作成功'),
  ],
)
```

### 动画图标

可以结合 Flutter 的动画系统创建动态图标：

```dart
// 简单的旋转动画
AnimatedRotation(
  turns: _isRotated ? 1.0 : 0.0,
  duration: const Duration(seconds: 1),
  child: VelocityIcon(Icons.refresh),
)

// 缩放动画
AnimatedScale(
  scale: _isScaled ? 1.2 : 1.0,
  duration: const Duration(milliseconds: 300),
  child: VelocityIcon(Icons.star, color: VelocityColors.warning),
)
```

## 样式定制

### 主题支持

VelocityIcon 支持通过主题进行全局样式定制：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      VelocityThemeData(
        iconTheme: VelocityIconTheme(
          size: VelocityIconSize.md,
          color: Colors.blue,
        ),
      ),
    ],
  ),
  home: MyHomePage(),
);
```

### 自定义样式

通过 `style` 属性可以完全自定义图标的样式：

```dart
VelocityIcon(
  Icons.home,
  style: VelocityIconStyle(
    color: Colors.purple,
    size: 32,
  ),
)
```

## 可访问性

### 无障碍支持

- 支持语义标签，提高屏幕阅读器的可访问性
- 支持高对比度模式
- 支持键盘导航
- 支持缩放功能

### 使用建议

- 为所有图标添加 `semanticLabel`，尤其是功能图标
- 确保图标颜色与背景有足够的对比度
- 避免使用过于复杂的图标，保持简洁明了
- 为交互式图标提供清晰的视觉反馈
- 考虑在不同主题下的显示效果

## 最佳实践

1. **一致性**：在整个应用中使用一致的图标风格和尺寸
2. **清晰度**：选择清晰、易于识别的图标
3. **尺寸适配**：根据上下文选择合适的图标尺寸
4. **颜色使用**：
   - 使用 `VelocityColors` 中的预设颜色组合
   - 确保图标颜色与背景有足够的对比度
   - 为不同状态使用不同颜色（正常、悬停、禁用）
5. **图标与文本结合**：
   - 对于重要操作，同时使用图标和文本
   - 保持图标与文本的视觉对齐
6. **避免过度使用**：
   - 不要在一个界面中使用过多不同类型的图标
   - 保持简洁，避免视觉混乱
7. **考虑不同平台**：
   - 某些图标在不同平台上的含义可能不同
   - 测试图标在不同设备上的显示效果

## 常见问题

### 问题：图标显示为方框

**症状**：图标显示为方框，而不是预期的图形

**原因**：

- 图标库没有正确导入
- 图标名称拼写错误
- 图标库版本不兼容

**解决方案**：

- 确保已正确导入图标库
- 检查图标名称的拼写
- 确保图标库版本与 Flutter 版本兼容
- 尝试使用不同的图标

### 问题：图标尺寸不符合预期

**症状**：图标显示过大或过小

**解决方案**：

- 检查 `size` 属性是否设置正确
- 如果使用了 `customSize`，确保值合适
- 检查主题中是否设置了全局图标尺寸
- 考虑图标所在容器的约束

### 问题：图标颜色不显示

**症状**：图标始终显示为默认颜色

**解决方案**：

- 确保 `color` 属性值正确
- 检查是否有样式覆盖了颜色设置
- 检查主题中的全局图标颜色设置
- 确保图标支持颜色修改

### 问题：图标在某些设备上显示异常

**症状**：图标在某些设备上显示模糊或变形

**解决方案**：

- 优先使用矢量图标，避免使用位图
- 确保图标尺寸是偶数
- 避免过度缩放图标
- 考虑使用不同分辨率的图标

## API 参考

### VelocityIcon

| 属性          | 类型               | 默认值 | 说明                          |
| ------------- | ------------------ | ------ | ----------------------------- |
| icon          | IconData           | -      | 图标数据 (必填)               |
| size          | VelocityIconSize   | md     | 图标尺寸                      |
| customSize    | double?            | -      | 自定义尺寸，优先级高于 `size` |
| color         | Color?             | -      | 图标颜色                      |
| style         | VelocityIconStyle? | -      | 自定义样式                    |
| semanticLabel | String?            | -      | 语义标签，用于无障碍访问      |
| key           | Key?               | -      | 组件 key                      |

### VelocityIconSize

```dart
enum VelocityIconSize {
  xs, // 14px
  sm, // 18px
  md, // 24px (默认)
  lg, // 32px
  xl, // 48px
}
```

### VelocityIconStyle

| 属性  | 类型    | 默认值 | 说明     |
| ----- | ------- | ------ | -------- |
| color | Color?  | -      | 图标颜色 |
| size  | double? | -      | 图标尺寸 |

## 相关组件

- [VelocityButton 按钮](/components/basic/button) - 带图标的按钮组件
- [VelocityListTile 列表项](/components/display/list) - 带图标的列表项组件
- [VelocityChip 芯片](/components/basic/chip) - 带图标的芯片组件
- [VelocityBadge 徽章](/components/display/badge) - 带图标的徽章组件

## 更新日志

### v1.0.0

- 初始版本发布
- 支持 Material Icons
- 提供 5 种预置尺寸
- 支持自定义尺寸和颜色

### v1.0.1

- 优化了图标渲染性能
- 增加了对语义标签的支持
- 改进了无障碍访问

---

::: tip 提示

- 优先使用 Material Icons，它们经过了优化和广泛测试
- 为所有功能图标添加语义标签，提高可访问性
- 在不同主题下测试图标显示效果
- 考虑图标与周围元素的视觉平衡

:::

::: warning 警告

- 避免使用过多不同风格的图标库
- 不要在一个界面中使用过多图标
- 确保图标颜色与背景有足够的对比度
- 不要使用过小的图标，影响可点击区域

:::
