---
title: Card 卡片
description: VelocityUI Card 组件，通用卡片容器
---

# Card 卡片

## 简介

Card 卡片组件是一种通用容器，用于承载和组织内容，通过视觉分隔提升页面层次感，适用于信息展示、列表项、详情页等多种场景。

### 核心特性

- 支持三种预定义样式：默认、轮廓、填充
- 支持点击和长按交互
- 完善的样式定制能力
- 响应式设计，适配不同屏幕尺寸
- 支持圆角、阴影、边框等视觉效果定制

### 使用场景

- 产品列表展示
- 新闻资讯卡片
- 用户资料展示
- 订单详情页
- 仪表盘统计卡片
- 分类内容展示

## 基本用法

```dart
// 最基本的卡片
VelocityCard(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('卡片内容'),
  ),
)
```

## 属性配置

### 卡片样式

提供三种预定义卡片样式，满足不同设计需求。

```dart
// 默认样式 (带阴影)
VelocityCard(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: VelocityText('默认卡片'),
  ),
)

// 轮廓样式 (带边框，无阴影)
VelocityOutlinedCard(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: VelocityText('轮廓卡片'),
  ),
)

// 填充样式 (带背景色，无阴影)
VelocityFilledCard(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: VelocityText('填充卡片'),
  ),
)
```

### 交互属性

卡片支持点击和长按交互，可用于导航、展开详情等场景。

```dart
VelocityCard(
  onTap: () {
    // 点击事件处理
    print('卡片被点击了');
  },
  onLongPress: () {
    // 长按事件处理
    print('卡片被长按了');
  },
  child: Padding(
    padding: EdgeInsets.all(16),
    child: VelocityText('可交互卡片'),
  ),
)
```

## 高级用法

### 带头部和尾部的卡片

卡片内容可以包含头部、主体和尾部，用于组织复杂信息。

```dart
VelocityCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 卡片头部
      Padding(
        padding: EdgeInsets.all(16),
        child: VelocityText('卡片标题', size: VelocityTextSize.lg, weight: VelocityFontWeight.bold),
      ),
      // 卡片主体
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: VelocityText('卡片内容描述，详细说明卡片的用途和信息。'),
      ),
      // 卡片尾部
      Padding(
        padding: EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerRight,
          child: VelocityButton(
            size: VelocityButtonSize.sm,
            child: Text('查看详情'),
            onPressed: () {},
          ),
        ),
      ),
    ],
  ),
)
```

### 图片卡片

卡片可以包含图片，用于产品展示、新闻资讯等场景。

```dart
VelocityCard(
  child: Column(
    children: [
      // 卡片图片
      Image.network(
        'https://example.com/image.jpg',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
      // 图片下方内容
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VelocityText('产品名称', weight: VelocityFontWeight.bold),
            SizedBox(height: 8),
            VelocityText('产品描述', size: VelocityTextSize.sm, color: Colors.grey),
            SizedBox(height: 12),
            VelocityText('¥99.00', color: Colors.red),
          ],
        ),
      ),
    ],
  ),
)
```

### 卡片网格布局

卡片常用于网格布局，展示多个项目。

```dart
VelocityGrid(
  columns: 2,
  spacing: 16,
  children: List.generate(6, (index) {
    return VelocityCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.image, size: 48, color: Colors.grey),
            SizedBox(height: 12),
            VelocityText('卡片 ${index + 1}'),
          ],
        ),
      ),
    );
  }),
)
```

## 样式定制

### 自定义卡片样式

通过 `style` 属性可以完全自定义卡片的外观。

```dart
VelocityCard(
  style: VelocityCardStyle(
    borderRadius: BorderRadius.circular(12),
    padding: EdgeInsets.all(20),
    shadowColor: Colors.blue.withOpacity(0.3),
    elevation: 8,
    backgroundColor: Colors.white,
  ),
  child: VelocityText('自定义样式卡片'),
)
```

### 轮廓卡片样式定制

```dart
VelocityOutlinedCard(
  style: VelocityCardStyle(
    borderRadius: BorderRadius.circular(8),
    borderColor: Colors.purple,
    borderWidth: 2,
    padding: EdgeInsets.all(16),
  ),
  child: VelocityText('自定义轮廓卡片'),
)
```

## 可访问性

- 为可交互卡片添加清晰的 `semanticLabel`
- 确保卡片内容的颜色对比度符合无障碍标准
- 对于图片卡片，提供有意义的替代文本
- 确保卡片内的交互元素具有足够的点击区域

## 最佳实践

- **内容组织**：保持卡片内容简洁明了，突出核心信息
- **视觉层次**：合理使用标题、正文、辅助文字等，建立清晰的视觉层次
- **交互反馈**：为可交互卡片添加明确的视觉反馈（如阴影变化、颜色变化）
- **性能优化**：对于大量卡片展示，考虑使用懒加载和缓存机制
- **响应式设计**：在不同屏幕尺寸下调整卡片布局和大小
- **一致性**：在同一页面中保持卡片样式的一致性

## 常见问题

### 问题：卡片内容溢出？

**症状**：卡片内容超出卡片边界

**原因**：内容尺寸过大或布局不当

**解决方案**：

1. 确保卡片内容使用适当的约束（如 `Expanded`、`Flexible`）
2. 对于长文本，使用 `maxLines` 和 `overflow` 属性处理
3. 调整卡片的 `padding` 和内容的内边距

### 问题：卡片点击无反应？

**症状**：点击卡片没有触发 `onTap` 回调

**原因**：可能存在以下问题

**解决方案**：

1. 确保 `onTap` 属性已正确设置
2. 检查卡片内容是否遮挡了点击区域（如使用了 `AbsorbPointer` 或 `IgnorePointer`）
3. 确保卡片是可见的且没有被其他组件覆盖

### 问题：卡片样式不生效？

**症状**：自定义样式没有应用到卡片上

**原因**：样式配置不当

**解决方案**：

1. 确保使用了正确的样式类 `VelocityCardStyle`
2. 检查样式属性名称是否正确
3. 对于不同类型的卡片，某些样式属性可能有不同的默认值

## API 参考

### VelocityCard

| 属性          | 类型               | 默认值 | 说明             |
| ------------- | ------------------ | ------ | ---------------- |
| key           | Key?               | -      | 组件的唯一标识符 |
| child         | Widget?            | -      | 子组件           |
| onTap         | VoidCallback?      | -      | 点击回调         |
| onLongPress   | VoidCallback?      | -      | 长按回调         |
| semanticLabel | String?            | -      | 无障碍标签       |
| style         | VelocityCardStyle? | -      | 自定义样式       |

### VelocityCardStyle

| 属性            | 类型         | 默认值                        | 说明           |
| --------------- | ------------ | ----------------------------- | -------------- |
| backgroundColor | Color?       | -                             | 背景颜色       |
| borderRadius    | BorderRadius | BorderRadius.circular(8)      | 边框圆角       |
| padding         | EdgeInsets   | EdgeInsets.all(16)            | 内边距         |
| shadowColor     | Color?       | Colors.black.withOpacity(0.1) | 阴影颜色       |
| elevation       | double       | 2                             | 阴影 elevation |
| borderColor     | Color?       | -                             | 边框颜色       |
| borderWidth     | double       | 1                             | 边框宽度       |

### VelocityOutlinedCard

同 `VelocityCard`，但默认样式为轮廓样式。

### VelocityFilledCard

同 `VelocityCard`，但默认样式为填充样式。

## 相关组件

- [Grid 网格](/components/layout/grid)
- [Button 按钮](/components/basic/button)
- [Text 文本](/components/basic/text)
- [Image 图片](/components/basic/image)

## 更新日志

### v1.0.0

- 初始版本发布
- 支持三种卡片样式：默认、轮廓、填充
- 支持点击和长按交互
- 完善的样式定制能力

---

::: tip 提示

为了获得最佳的视觉效果和性能，建议卡片高度不要超过屏幕高度的一半。

:::
