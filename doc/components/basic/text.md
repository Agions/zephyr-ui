---
title: Text 文本
description: VelocityUI 文本组件，提供统一的排版样式和丰富的文本变体
---

# Text 文本

## 简介

Text 是一个功能强大的文本组件，提供统一的排版样式和丰富的文本变体，帮助您快速构建美观、一致的文本界面。

### 核心特性

- 支持 Material Design 3 排版系统
- 提供 15 种预设文本变体
- 支持自定义文本样式
- 支持文本溢出处理
- 支持文本对齐和行高调整
- 支持主题定制
- 支持无障碍访问

### 使用场景

- 应用标题和副标题
- 正文内容展示
- 标签和说明文字
- 表单提示文本
- 按钮和菜单文本
- 数据展示文本

## 基本用法

```dart
VelocityText('这是一段普通文本')
```

## 属性配置

### 文本内容

```dart
VelocityText('这是文本内容')
```

### 文本变体

VelocityUI 提供了多种文本变体，对应 Material Design 3 的排版系统：

#### Display 大标题

用于页面的主标题，视觉层级最高。

```dart
VelocityText.displayLarge('Display Large')
VelocityText.displayMedium('Display Medium')
VelocityText.displaySmall('Display Small')
```

#### Headline 标题

用于内容区块的标题，视觉层级仅次于 Display。

```dart
VelocityText.headlineLarge('Headline Large')
VelocityText.headlineMedium('Headline Medium')
VelocityText.headlineSmall('Headline Small')
```

#### Title 副标题

用于卡片、列表项等组件的标题。

```dart
VelocityText.titleLarge('Title Large')
VelocityText.titleMedium('Title Medium')
VelocityText.titleSmall('Title Small')
```

#### Body 正文

用于主要内容的展示。

```dart
VelocityText.bodyLarge('Body Large')
VelocityText.bodyMedium('Body Medium')
VelocityText.bodySmall('Body Small')
```

#### Label 标签

用于辅助文本和标签。

```dart
VelocityText.labelLarge('Label Large')
VelocityText.labelMedium('Label Medium')
VelocityText.labelSmall('Label Small')
```

### 文本颜色

```dart
// 使用预设颜色
VelocityText(
  '自定义颜色',
  color: VelocityColors.primary,
)

// 使用自定义颜色
VelocityText(
  '自定义颜色',
  color: Colors.purple,
)
```

### 文本对齐

```dart
VelocityText(
  '居中对齐',
  textAlign: TextAlign.center,
)

VelocityText(
  '右对齐',
  textAlign: TextAlign.right,
)
```

## 高级用法

### 文本溢出处理

用于处理长文本溢出的情况：

```dart
VelocityText(
  '这是一段非常长的文本，可能会超出容器宽度，需要进行溢出处理。',
  maxLines: 1, // 最大显示行数
  overflow: TextOverflow.ellipsis, // 溢出显示省略号
)
```

### 自定义样式

您可以通过 `style` 属性完全自定义文本样式：

```dart
VelocityText(
  '自定义样式文本',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.red,
    decoration: TextDecoration.underline,
    decorationColor: Colors.blue,
    decorationStyle: TextDecorationStyle.dashed,
  ),
)
```

### 结合变体使用自定义样式

```dart
VelocityText.titleLarge(
  '带自定义颜色的标题',
  color: VelocityColors.success,
  fontWeight: FontWeight.bold,
)
```

## 样式定制

### 主题支持

VelocityText 支持通过主题进行全局样式定制：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      VelocityThemeData(
        textTheme: VelocityTextTheme(
          displayLarge: TextStyle(
            fontSize: 57,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            lineHeight: 1.5,
            color: Colors.black87,
          ),
        ),
      ),
    ],
  ),
  home: MyHomePage(),
);
```

### 文本变体映射

每个文本变体都映射到 Material Design 3 的排版样式：

| 变体           | 字体大小 | 字重 | 行高 |
| -------------- | -------- | ---- | ---- |
| displayLarge   | 57       | 300  | 64   |
| displayMedium  | 45       | 300  | 52   |
| displaySmall   | 36       | 300  | 44   |
| headlineLarge  | 32       | 400  | 40   |
| headlineMedium | 28       | 400  | 36   |
| headlineSmall  | 24       | 400  | 32   |
| titleLarge     | 22       | 500  | 28   |
| titleMedium    | 16       | 500  | 24   |
| titleSmall     | 14       | 500  | 20   |
| bodyLarge      | 16       | 400  | 24   |
| bodyMedium     | 14       | 400  | 20   |
| bodySmall      | 12       | 400  | 16   |
| labelLarge     | 14       | 500  | 20   |
| labelMedium    | 12       | 500  | 16   |
| labelSmall     | 11       | 500  | 16   |

## 可访问性

### 无障碍支持

- 支持屏幕阅读器
- 支持文本缩放
- 支持高对比度模式
- 支持语义化标签

### 使用建议

- 为重要文本提供清晰的视觉层级
- 确保文本与背景有足够的对比度
- 避免使用过小的字体大小
- 为长文本提供适当的行高和字间距
- 使用语义化的文本变体

## 最佳实践

1. **保持一致性**：在整个应用中使用一致的文本变体和样式
2. **合理使用层级**：根据内容重要性选择合适的文本变体
3. **注意可读性**：
   - 正文文本建议使用 bodyMedium 或 bodyLarge
   - 确保文本与背景对比度至少为 4.5:1
   - 行高建议设置为字体大小的 1.5-1.6 倍
4. **避免过度定制**：优先使用预设变体，仅在必要时进行自定义
5. **考虑响应式设计**：在不同屏幕尺寸上调整文本大小和布局
6. **测试无障碍访问**：确保所有用户都能轻松阅读您的文本

## 常见问题

### 问题：文本在某些设备上显示异常

**症状**：文本在某些设备上显示过大或过小

**原因**：设备的文本缩放设置与应用的文本样式冲突

**解决方案**：

- 优先使用预设文本变体，它们已经过优化
- 避免硬编码字体大小
- 考虑使用相对字体大小
- 测试不同文本缩放设置下的显示效果

### 问题：文本对比度不够

**症状**：文本难以阅读，尤其是在强光下

**解决方案**：

- 使用 `VelocityColors` 中提供的预设颜色组合
- 确保文本与背景的对比度至少为 4.5:1
- 考虑为不同主题（亮色/暗色）提供不同的文本颜色

### 问题：长文本溢出容器

**症状**：长文本超出容器边界，导致布局错乱

**解决方案**：

- 设置 `maxLines` 和 `overflow` 属性
- 使用 `softWrap: true` 允许文本换行
- 考虑使用 `Expanded` 或 `Flexible` 包裹文本组件

## API 参考

### VelocityText

| 属性               | 类型                 | 默认值 | 说明                  |
| ------------------ | -------------------- | ------ | --------------------- |
| text               | String               | -      | 文本内容 (必填)       |
| variant            | VelocityTextVariant? | -      | 文本变体              |
| color              | Color?               | -      | 文本颜色              |
| fontSize           | double?              | -      | 字体大小              |
| fontWeight         | FontWeight?          | -      | 字重                  |
| fontStyle          | FontStyle?           | -      | 字体样式（正常/斜体） |
| letterSpacing      | double?              | -      | 字间距                |
| wordSpacing        | double?              | -      | 词间距                |
| textHeightBehavior | TextHeightBehavior?  | -      | 文本高度行为          |
| textAlign          | TextAlign?           | -      | 文本对齐方式          |
| textDirection      | TextDirection?       | -      | 文本方向              |
| locale             | Locale?              | -      | 文本区域设置          |
| softWrap           | bool?                | -      | 是否允许换行          |
| overflow           | TextOverflow?        | -      | 溢出处理方式          |
| textScaleFactor    | double?              | -      | 文本缩放因子          |
| maxLines           | int?                 | -      | 最大显示行数          |
| semanticsLabel     | String?              | -      | 无障碍标签            |
| style              | TextStyle?           | -      | 自定义样式            |

### VelocityTextVariant

```dart
enum VelocityTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}
```

### 便捷构造函数

VelocityText 提供了便捷构造函数，用于快速创建不同变体的文本：

| 构造函数       | 变体           |
| -------------- | -------------- |
| displayLarge   | displayLarge   |
| displayMedium  | displayMedium  |
| displaySmall   | displaySmall   |
| headlineLarge  | headlineLarge  |
| headlineMedium | headlineMedium |
| headlineSmall  | headlineSmall  |
| titleLarge     | titleLarge     |
| titleMedium    | titleMedium    |
| titleSmall     | titleSmall     |
| bodyLarge      | bodyLarge      |
| bodyMedium     | bodyMedium     |
| bodySmall      | bodySmall      |
| labelLarge     | labelLarge     |
| labelMedium    | labelMedium    |
| labelSmall     | labelSmall     |

## 相关组件

- [VelocityButton 按钮](/components/basic/button)
- [VelocityIcon 图标](/components/basic/icon)
- [VelocityLink 链接](/components/basic/link)
- [VelocityChip 芯片](/components/basic/chip)

## 更新日志

### v1.0.0

- 初始版本发布
- 支持 15 种文本变体
- 支持自定义样式
- 支持主题定制

### v1.0.1

- 优化了文本变体的字体大小和行高
- 改进了主题支持
- 增加了无障碍支持

---

::: tip 提示

- 优先使用预设的文本变体，它们已经过设计优化
- 为不同类型的内容选择合适的文本变体
- 考虑在主题中配置全局文本样式，以确保应用的一致性

:::

::: warning 警告

- 避免硬编码字体大小，这会导致在不同设备上显示异常
- 确保文本与背景有足够的对比度
- 不要在一个页面上使用过多不同的文本变体，这会造成视觉混乱

:::
