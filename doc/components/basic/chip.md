---
title: VelocityChip 芯片
description: VelocityUI Chip 组件，用于展示标签、联系人或操作，支持多种样式和交互
---

# VelocityChip 芯片

## 简介

VelocityChip 是一个用于展示标签、联系人或操作的组件，支持多种样式、图标、头像和交互方式，提供了灵活的标签和选择功能。

### 核心特性

- 支持三种样式：填充样式、轮廓样式、柔和样式
- 支持图标和头像
- 支持可删除的芯片
- 支持选择芯片（单选和多选）
- 支持自定义样式
- 支持主题定制
- 支持无障碍访问
- 支持键盘导航

### 使用场景

- 标签云展示
- 联系人列表
- 筛选和分类
- 多选项选择
- 搜索结果标签
- 用户兴趣标签
- 操作快捷方式

## 基本用法

```dart
VelocityChip(label: '标签')
```

## 属性配置

### Chip 类型

VelocityUI 提供了三种 Chip 类型，适应不同的设计需求：

```dart
// 填充样式 (默认) - 适合突出显示重要标签
VelocityChip(label: '填充样式', type: VelocityChipType.filled)

// 轮廓样式 - 适合展示多个标签，视觉干扰较小
VelocityChip(label: '轮廓样式', type: VelocityChipType.outlined)

// 柔和样式 - 适合中性或次要标签
VelocityChip(label: '柔和样式', type: VelocityChipType.tonal)
```

### 带图标的 Chip

```dart
// 带图标 - 用于功能标签或操作
VelocityChip(label: '设置', icon: Icons.settings)

// 带头像 - 用于联系人或用户标签
VelocityChip(
  label: '头像',
  avatar: CircleAvatar(
    radius: 10,
    backgroundImage: NetworkImage('https://picsum.photos/20/20'),
  ),
)

// 带自定义头像 - 用于个性化标签
VelocityChip(
  label: '自定义头像',
  avatar: Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: VelocityColors.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: VelocityText(
        'A',
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
    ),
  ),
)
```

### 可删除的 Chip

```dart
// 基本可删除 Chip
VelocityChip(
  label: '可删除',
  onDelete: () {
    // 处理删除操作
    print('Chip 被删除');
  },
)

// 带图标和删除功能的 Chip
VelocityChip(
  label: '带图标可删除',
  icon: Icons.tag,
  onDelete: () {
    // 处理删除操作
  },
)
```

### 禁用状态

```dart
// 禁用的 Chip
VelocityChip(
  label: '禁用',
  disabled: true,
)

// 禁用的可删除 Chip
VelocityChip(
  label: '禁用可删除',
  onDelete: () {
    // 此回调不会被执行
  },
  disabled: true,
)
```

## 高级用法

### 选择 Chip (ChoiceChip)

用于单选场景：

```dart
class ChoiceChipExample extends StatefulWidget {
  const ChoiceChipExample({Key? key}) : super(key: key);

  @override
  State<ChoiceChipExample> createState() => _ChoiceChipExampleState();
}

class _ChoiceChipExampleState extends State<ChoiceChipExample> {
  int _selectedIndex = 0;
  final List<String> _choices = ['选项1', '选项2', '选项3'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _choices.asMap().entries.map((entry) {
        final int index = entry.key;
        final String label = entry.value;
        return VelocityChoiceChip(
          label: label,
          selected: _selectedIndex == index,
          onSelected: (selected) {
            setState(() {
              _selectedIndex = selected ? index : -1;
            });
          },
        );
      }).toList(),
    );
  }
}
```

### 多选 Chip

用于多选场景：

```dart
class MultiSelectChipExample extends StatefulWidget {
  const MultiSelectChipExample({Key? key}) : super(key: key);

  @override
  State<MultiSelectChipExample> createState() => _MultiSelectChipExampleState();
}

class _MultiSelectChipExampleState extends State<MultiSelectChipExample> {
  final List<String> _selectedChoices = [];
  final List<String> _choices = ['苹果', '香蕉', '橙子', '草莓', '葡萄'];

  void _toggleChoice(String choice) {
    setState(() {
      if (_selectedChoices.contains(choice)) {
        _selectedChoices.remove(choice);
      } else {
        _selectedChoices.add(choice);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: _choices.map((choice) {
            final isSelected = _selectedChoices.contains(choice);
            return VelocityChip(
              label: choice,
              selected: isSelected,
              onTap: () => _toggleChoice(choice),
              type: isSelected ? VelocityChipType.filled : VelocityChipType.outlined,
              color: isSelected ? VelocityColors.primary : null,
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        VelocityText('选中的选项: $_selectedChoices'),
      ],
    );
  }
}
```

### 动态生成 Chip 列表

```dart
class DynamicChipExample extends StatefulWidget {
  const DynamicChipExample({Key? key}) : super(key: key);

  @override
  State<DynamicChipExample> createState() => _DynamicChipExampleState();
}

class _DynamicChipExampleState extends State<DynamicChipExample> {
  final List<String> _tags = ['标签1', '标签2', '标签3'];
  final TextEditingController _controller = TextEditingController();

  void _addTag() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tags.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: _tags.map((tag) {
            return VelocityChip(
              label: tag,
              onDelete: () => _removeTag(tag),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: '输入新标签',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) => _addTag(),
              ),
            ),
            SizedBox(width: 8),
            VelocityButton.text(
              text: '添加',
              onPressed: _addTag,
            ),
          ],
        ),
      ],
    );
  }
}
```

### 自定义样式

```dart
// 自定义颜色和样式
VelocityChip(
  label: '自定义样式',
  icon: Icons.star,
  type: VelocityChipType.filled,
  style: VelocityChipStyle(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    borderRadius: BorderRadius.circular(20),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    border: Border.all(color: Colors.purple, width: 2),
  ),
)
```

## 样式定制

### 主题支持

VelocityChip 支持通过主题进行全局样式定制：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      VelocityThemeData(
        chipTheme: VelocityChipTheme(
          primaryColor: VelocityColors.primary,
          secondaryColor: VelocityColors.secondary,
          borderRadius: BorderRadius.circular(16),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          labelStyle: TextStyle(fontSize: 14),
        ),
      ),
    ],
  ),
  home: MyHomePage(),
);
```

### 样式属性

| 属性 | 说明 |
|------|------|
| backgroundColor | 背景颜色 |
| foregroundColor | 前景颜色（文本和图标） |
| borderColor | 边框颜色 |
| borderRadius | 圆角半径 |
| padding | 内边距 |
| labelStyle | 标签文本样式 |
| iconSize | 图标大小 |
| avatarSize | 头像大小 |
| deleteIconSize | 删除图标大小 |

## 可访问性

### 无障碍支持

- 支持键盘导航 (Tab 键聚焦，Enter 键激活)
- 支持屏幕阅读器
- 支持语义标签
- 支持高对比度模式

### 使用建议

- 为芯片添加有意义的文本，避免使用过于简短的标签
- 确保芯片在不同状态下有明显的视觉区分
- 为可点击的芯片提供清晰的点击反馈
- 考虑为重要芯片添加 `semanticLabel`
- 确保芯片有足够的点击区域

```dart
VelocityChip(
  label: '重要标签',
  semanticLabel: '这是一个重要标签，用于标记重要内容',
  onTap: () {},
)
```

## 最佳实践

1. **选择合适的 Chip 类型**：
   - 重要标签使用 `filled` 类型
   - 多个标签使用 `outlined` 或 `tonal` 类型
   - 保持视觉一致性

2. **合理使用图标和头像**：
   - 图标用于功能标签或操作
   - 头像用于联系人或用户标签
   - 避免过度使用装饰元素

3. **Chip 布局**：
   - 使用 `Wrap` 组件实现自动换行
   - 为 Chip 之间添加适当的间距
   - 考虑在不同屏幕尺寸下的显示效果

4. **交互设计**：
   - 为可点击的 Chip 提供清晰的视觉反馈
   - 为可删除的 Chip 提供确认机制
   - 考虑添加动画效果，提高用户体验

5. **性能考虑**：
   - 对于大量 Chip，考虑使用 `ListView.builder` 实现懒加载
   - 避免在 Chip 中使用复杂的自定义组件

## 常见问题

### 问题：Chip 点击区域过小

**症状**：Chip 很难被点击到

**解决方案**：
- 调整 `padding` 属性，增加内边距
- 使用 `SizedBox` 或 `Container` 包裹 Chip，增加点击区域
- 确保标签文本足够长

### 问题：Chip 样式与设计稿不符

**症状**：Chip 的颜色、圆角或字体与设计稿不一致

**解决方案**：
- 使用 `style` 属性自定义 Chip 样式
- 调整 `backgroundColor`、`borderRadius`、`labelStyle` 等属性
- 考虑在主题中配置全局 Chip 样式

### 问题：大量 Chip 导致布局性能问题

**症状**：页面包含大量 Chip 时，滚动或渲染变慢

**解决方案**：
- 使用 `Wrap` 组件实现自动换行
- 考虑使用 `ListView.builder` 实现懒加载
- 避免在 Chip 中使用复杂的自定义组件
- 考虑使用虚拟化列表

### 问题：Chip 在深色模式下显示异常

**症状**：Chip 在深色模式下对比度不够或显示不正常

**解决方案**：
- 使用主题中的 Chip 颜色，它会根据当前主题自动调整
- 为不同主题（亮色/暗色）提供不同的 Chip 样式
- 确保背景色和前景色的对比度足够

### 问题：可删除 Chip 的删除图标不显示

**症状**：设置了 `onDelete` 回调，但删除图标不显示

**解决方案**：
- 确保 Chip 没有被设置为 `disabled: true`
- 检查是否自定义了 `deleteIcon` 但设置为 `null`
- 确保主题中没有隐藏删除图标

## API 参考

### VelocityChip

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| label | String | - | 标签文本 (必填) |
| avatar | Widget? | - | 头像组件 |
| icon | IconData? | - | 图标 |
| deleteIcon | IconData? | Icons.close | 删除图标 |
| onTap | VoidCallback? | - | 点击回调 |
| onDelete | VoidCallback? | - | 删除回调 |
| selected | bool | false | 是否选中 |
| disabled | bool | false | 是否禁用 |
| type | VelocityChipType | filled | Chip 类型 |
| color | Color? | - | 主题色 |
| backgroundColor | Color? | - | 背景颜色 |
| foregroundColor | Color? | - | 前景颜色（文本和图标） |
| borderColor | Color? | - | 边框颜色 |
| style | VelocityChipStyle? | - | 自定义样式 |
| key | Key? | - | 组件 key |

### VelocityChoiceChip

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| label | String | - | 标签文本 (必填) |
| selected | bool | - | 是否选中 (必填) |
| onSelected | ValueChanged<bool> | - | 选中状态改变回调 (必填) |
| avatar | Widget? | - | 头像组件 |
| disabled | bool | false | 是否禁用 |
| style | VelocityChipStyle? | - | 自定义样式 |
| key | Key? | - | 组件 key |

### VelocityChipType

```dart
enum VelocityChipType {
  filled, // 填充样式
  outlined, // 轮廓样式
  tonal, // 柔和样式
}
```

### VelocityChipStyle

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| backgroundColor | Color? | - | 背景颜色 |
| foregroundColor | Color? | - | 前景颜色（文本和图标） |
| borderColor | Color? | - | 边框颜色 |
| borderRadius | BorderRadius? | - | 圆角半径 |
| padding | EdgeInsets? | - | 内边距 |
| labelStyle | TextStyle? | - | 标签文本样式 |
| iconSize | double? | - | 图标大小 |
| avatarSize | double? | - | 头像大小 |
| deleteIconSize | double? | - | 删除图标大小 |
| borderWidth | double? | - | 边框宽度 |

## 相关组件

- [VelocityButton 按钮](/components/basic/button) - 用于主要操作
- [VelocityIcon 图标](/components/basic/icon) - 用于图标展示
- [VelocityText 文本](/components/basic/text) - 用于文本展示
- [VelocityImage 图片](/components/basic/image) - 用于图片展示

## 更新日志

### v1.0.0

- 初始版本发布
- 支持三种 Chip 类型
- 支持图标和头像
- 支持可删除功能
- 支持选择芯片

### v1.0.1

- 优化了 Chip 的视觉样式
- 增加了对主题定制的支持
- 改进了无障碍访问
- 支持自定义样式

### v1.0.2

- 增加了 `semanticLabel` 支持
- 优化了点击反馈
- 修复了某些情况下的样式冲突
- 增加了更多的自定义样式属性

---

::: tip 提示

- 选择合适的 Chip 类型，保持视觉一致性
- 为可点击的 Chip 提供清晰的点击反馈
- 考虑在不同屏幕尺寸下的布局
- 为重要的 Chip 添加 `semanticLabel`，提高无障碍访问性

:::

::: warning 警告

- 避免在 Chip 中使用过长的文本
- 不要过度使用装饰元素，保持简洁
- 确保 Chip 在不同状态下有明显的视觉区分
- 考虑在移动端上的触摸体验

:::
