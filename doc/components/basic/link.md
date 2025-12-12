---
title: Link 链接
description: VelocityUI Link 组件，支持图标、下划线和不同状态的文字链接
---

# Link 链接

## 简介

Link 是一个功能丰富的文字链接组件，支持图标、下划线、不同状态和自定义样式，用于实现页面内导航、外部链接和各种交互操作。

### 核心特性

- 支持文本链接
- 支持图标链接
- 支持下划线控制
- 支持禁用状态
- 支持自定义样式
- 支持主题定制
- 支持无障碍访问
- 支持键盘导航

### 使用场景

- 页面内导航链接
- 外部网站链接
- 表单提交链接
- 帮助文档链接
- 隐私政策和条款链接
- 社交媒体链接
- 操作提示链接

## 基本用法

```dart
VelocityLink(
  text: '链接文字',
  onTap: () {
    // 处理点击事件
  },
)
```

## 属性配置

### 链接文本

```dart
VelocityLink(
  text: '查看详情',
  onTap: () {},
)
```

### 点击回调

```dart
VelocityLink(
  text: '跳转页面',
  onTap: () {
    // 导航到新页面
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPage()),
    );
  },
)
```

### 图标支持

```dart
// 右侧图标
VelocityLink(
  text: '查看详情',
  icon: Icons.arrow_forward,
  onTap: () {},
)

// 左侧图标
VelocityLink(
  text: '返回',
  icon: Icons.arrow_back,
  iconPosition: VelocityIconPosition.left,
  onTap: () {},
)
```

### 下划线控制

```dart
// 显示下划线
VelocityLink(
  text: '带下划线的链接',
  underline: true,
  onTap: () {},
)

// 不显示下划线 (默认)
VelocityLink(
  text: '不带下划线的链接',
  underline: false,
  onTap: () {},
)
```

### 禁用状态

```dart
VelocityLink(
  text: '禁用链接',
  disabled: true,
  onTap: () {
    // 此回调不会被执行
  },
)
```

## 高级用法

### 外部链接

```dart
VelocityLink(
  text: '访问官方网站',
  onTap: () {
    // 打开外部链接
    launchUrl(Uri.parse('https://example.com'));
  },
  icon: Icons.open_in_new,
)
```

### 自定义样式

```dart
VelocityLink(
  text: '自定义样式链接',
  onTap: () {},
  style: VelocityLinkStyle(
    color: VelocityColors.success,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    decorationColor: VelocityColors.success,
    decorationStyle: TextDecorationStyle.dashed,
  ),
)
```

### 链接列表

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    VelocityLink(
      text: '链接项 1',
      onTap: () {},
      icon: Icons.arrow_forward,
      underline: true,
    ),
    SizedBox(height: 12),
    VelocityLink(
      text: '链接项 2',
      onTap: () {},
      icon: Icons.arrow_forward,
      underline: true,
    ),
    SizedBox(height: 12),
    VelocityLink(
      text: '链接项 3',
      onTap: () {},
      icon: Icons.arrow_forward,
      underline: true,
    ),
  ],
)
```

### 结合其他组件使用

```dart
// 链接在文本中
VelocityText.rich(
  TextSpan(
    text: '请 ',
    children: [
      TextSpan(
        text: '阅读并同意',
        style: TextStyle(color: VelocityColors.primary),
      ),
      TextSpan(text: ' '),
      WidgetSpan(
        child: VelocityLink(
          text: '服务条款',
          underline: true,
          onTap: () {},
        ),
      ),
      TextSpan(text: ' 和 '),
      WidgetSpan(
        child: VelocityLink(
          text: '隐私政策',
          underline: true,
          onTap: () {},
        ),
      ),
    ],
  ),
)
```

### 链接动画

```dart
AnimatedOpacity(
  opacity: _isHovered ? 0.7 : 1.0,
  duration: Duration(milliseconds: 200),
  child: MouseRegion(
    onEnter: (_) => setState(() => _isHovered = true),
    onExit: (_) => setState(() => _isHovered = false),
    child: VelocityLink(
      text: '带悬停效果的链接',
      onTap: () {},
    ),
  ),
)
```

## 样式定制

### 主题支持

VelocityLink 支持通过主题进行全局样式定制：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      VelocityThemeData(
        linkTheme: VelocityLinkTheme(
          color: VelocityColors.primary,
          disabledColor: VelocityColors.gray400,
          fontSize: 14,
          underline: false,
        ),
      ),
    ],
  ),
  home: MyHomePage(),
);
```

### 自定义样式属性

```dart
VelocityLink(
  text: '完全自定义链接',
  onTap: () {},
  style: VelocityLinkStyle(
    color: Colors.purple,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    letterSpacing: 1.0,
    underline: true,
    decorationColor: Colors.purple,
    decorationThickness: 2,
    decorationStyle: TextDecorationStyle.wavy,
  ),
)
```

## 可访问性

### 无障碍支持

- 支持键盘导航 (Tab 键聚焦，Enter 键激活)
- 支持屏幕阅读器
- 支持语义标签
- 支持高对比度模式

### 使用建议

- 为链接添加有意义的文本，避免使用 "点击这里" 等模糊描述
- 为外部链接添加图标指示
- 确保链接在不同状态下有明显的视觉区分
- 为重要链接添加 `semanticLabel`
- 确保链接有足够的点击区域

```dart
VelocityLink(
  text: '隐私政策',
  onTap: () {},
  semanticLabel: '查看隐私政策',
  ariaLabel: '点击查看网站隐私政策和数据使用条款',
)
```

## 最佳实践

1. **链接文本清晰**：使用明确、描述性的链接文本，避免使用 "点击这里" 或 "更多" 等模糊描述

2. **视觉区分**：确保链接在视觉上与普通文本区分开，使用不同的颜色或下划线

3. **状态反馈**：为链接的不同状态（正常、悬停、禁用）提供清晰的视觉反馈

4. **一致的样式**：在整个应用中保持链接样式的一致性

5. **外部链接处理**：为外部链接添加明确的指示（如图标），并考虑使用 `target="_blank"` 打开

6. **无障碍设计**：确保链接支持键盘导航和屏幕阅读器

7. **适当的点击区域**：确保链接有足够的点击区域，提高可访问性

8. **避免链接嵌套**：不要在链接内部嵌套其他链接

## 常见问题

### 问题：链接点击区域过小

**症状**：链接很难被点击到

**解决方案**：

- 增加链接文本的内边距
- 使用 `SizedBox` 或 `Container` 包裹链接，增加点击区域
- 确保链接文本足够长

### 问题：链接样式与设计稿不符

**症状**：链接的颜色、字体大小或下划线与设计稿不一致

**解决方案**：

- 使用 `style` 属性自定义链接样式
- 调整 `color`、`fontSize`、`underline` 等属性
- 考虑在主题中配置全局链接样式

### 问题：链接在禁用状态下仍可点击

**症状**：链接显示为禁用状态，但仍能被点击

**解决方案**：

- 确保在设置 `disabled: true` 时，链接的 `onTap` 回调为空或在回调中检查禁用状态
- 检查主题中的 `disabled` 样式是否正确应用

### 问题：链接在深色模式下不可见

**症状**：链接在深色模式下与背景颜色对比度不够

**解决方案**：

- 使用主题中的链接颜色，它会根据当前主题自动调整
- 为不同主题（亮色/暗色）提供不同的链接颜色
- 确保链接颜色与背景颜色的对比度至少为 4.5:1

### 问题：链接跳转后没有反馈

**症状**：用户点击链接后，没有任何视觉反馈

**解决方案**：

- 添加加载指示器
- 确保链接跳转逻辑正确执行
- 考虑添加过渡动画

## API 参考

### VelocityLink

| 属性          | 类型                 | 默认值 | 说明                              |
| ------------- | -------------------- | ------ | --------------------------------- |
| text          | String               | -      | 链接文字 (必填)                   |
| onTap         | VoidCallback?        | -      | 点击回调                          |
| icon          | IconData?            | -      | 图标                              |
| iconPosition  | VelocityIconPosition | right  | 图标位置                          |
| underline     | bool                 | false  | 是否显示下划线                    |
| disabled      | bool                 | false  | 是否禁用                          |
| style         | VelocityLinkStyle?   | -      | 自定义样式                        |
| semanticLabel | String?              | -      | 语义标签，用于无障碍访问          |
| ariaLabel     | String?              | -      | ARIA 标签，提供更详细的无障碍描述 |
| key           | Key?                 | -      | 组件 key                          |

### VelocityLinkStyle

| 属性                | 类型                 | 默认值 | 说明                  |
| ------------------- | -------------------- | ------ | --------------------- |
| color               | Color?               | -      | 链接颜色              |
| disabledColor       | Color?               | -      | 禁用状态颜色          |
| fontSize            | double?              | -      | 字体大小              |
| fontWeight          | FontWeight?          | -      | 字重                  |
| fontStyle           | FontStyle?           | -      | 字体样式（正常/斜体） |
| letterSpacing       | double?              | -      | 字间距                |
| decoration          | TextDecoration?      | -      | 文本装饰              |
| decorationColor     | Color?               | -      | 装饰颜色              |
| decorationStyle     | TextDecorationStyle? | -      | 装饰样式              |
| decorationThickness | double?              | -      | 装饰厚度              |

## 相关组件

- [VelocityButton 按钮](/components/basic/button) - 用于主要操作
- [VelocityText 文本](/components/basic/text) - 用于普通文本
- [VelocityIcon 图标](/components/basic/icon) - 用于图标
- [VelocityCard 卡片](/components/display/card) - 常用于包含链接的卡片

## 更新日志

### v1.0.0

- 初始版本发布
- 支持文本链接和图标链接
- 支持下划线控制
- 支持禁用状态

### v1.0.1

- 优化了链接的视觉样式
- 增加了对主题定制的支持
- 改进了无障碍访问
- 支持图标位置配置

### v1.0.2

- 增加了 `semanticLabel` 和 `ariaLabel` 支持
- 优化了点击反馈
- 修复了某些情况下的样式冲突

---

::: tip 提示

- 优先使用主题中的链接样式，保持应用的一致性
- 为重要链接添加 `semanticLabel`，提高无障碍访问性
- 为外部链接添加图标指示
- 确保链接在不同状态下有明显的视觉区分

:::

::: warning 警告

- 避免在链接内部嵌套其他可点击元素
- 不要过度使用链接，保持界面简洁
- 确保链接文本有明确的含义
- 考虑在移动端上的触摸体验

:::
