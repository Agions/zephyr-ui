# ZephyrText 文本组件

ZephyrText 是一个遵循设计规范的文本组件，提供了预设的文本样式系统，支持标题、正文、标签等多种文本类型，便于创建一致的排版效果。

## 🎯 组件概述

### 特性
- **预设样式系统**: 支持标题、正文、标签三大类12种预设样式
- **Material Design 3**: 遵循最新的 Material Design 3 文字层级规范
- **灵活定制**: 支持自定义颜色、对齐、行数限制等
- **主题适配**: 完整的主题系统支持
- **无障碍支持**: 内置语义化标签和文本缩放

### 适用场景
- 页面标题和副标题
- 正文内容显示
- 表单标签和说明
- 按钮和链接文本
- 状态提示信息
- 数据展示文本

## 🚀 基础用法

### 标题文本

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText.headlineLarge('大号标题'),
    SizedBox(height: 8),
    ZephyrText.headlineMedium('中号标题'),
    SizedBox(height: 8),
    ZephyrText.headlineSmall('小号标题'),
  ],
)
```

### 副标题文本

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText.titleLarge('大号副标题'),
    SizedBox(height: 8),
    ZephyrText.titleMedium('中号副标题'),
    SizedBox(height: 8),
    ZephyrText.titleSmall('小号副标题'),
  ],
)
```

### 正文文本

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText.bodyLarge('大号正文文本，适合重要内容'),
    SizedBox(height: 8),
    ZephyrText.bodyMedium('中号正文文本，适合一般内容'),
    SizedBox(height: 8),
    ZephyrText.bodySmall('小号正文文本，适合次要内容'),
  ],
)
```

### 标签文本

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText.labelLarge('大号标签文本'),
    SizedBox(height: 8),
    ZephyrText.labelMedium('中号标签文本'),
    SizedBox(height: 8),
    ZephyrText.labelSmall('小号标签文本'),
  ],
)
```

## 🎨 文本样式

### 1. 标题样式

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText(
      '主标题',
      style: ZephyrTextStyle.headline1,
    ),
    ZephyrText(
      '副标题',
      style: ZephyrTextStyle.headline2,
    ),
    ZephyrText(
      '小标题',
      style: ZephyrTextStyle.headline3,
    ),
    ZephyrText(
      '段落标题',
      style: ZephyrTextStyle.headline4,
    ),
    ZephyrText(
      '小标题',
      style: ZephyrTextStyle.headline5,
    ),
    ZephyrText(
      '子标题',
      style: ZephyrTextStyle.headline6,
    ),
  ],
)
```

### 2. 正文样式

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText(
      '主要正文',
      style: ZephyrTextStyle.body1,
    ),
    ZephyrText(
      '次要正文',
      style: ZephyrTextStyle.body2,
    ),
  ],
)
```

### 3. 特殊样式

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText(
      '按钮文本',
      style: ZephyrTextStyle.button,
    ),
    ZephyrText(
      '链接文本',
      style: ZephyrTextStyle.link,
      onPressed: () => _handleLink(),
    ),
    ZephyrText(
      '小字说明',
      style: ZephyrTextStyle.caption,
    ),
    ZephyrText(
      '覆盖文本',
      style: ZephyrTextStyle.overline,
    ),
  ],
)
```

## 🔧 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `text` | `String` | - | 文本内容 |
| `style` | `ZephyrTextStyle` | `body1` | 文本样式 |
| `color` | `Color` | - | 文本颜色 |
| `textAlign` | `TextAlign` | `start` | 文本对齐 |
| `maxLines` | `int` | - | 最大行数 |
| `overflow` | `TextOverflow` | - | 溢出处理 |
| `onPressed` | `VoidCallback` | - | 点击回调 |
| `semanticsLabel` | `String` | - | 语义标签 |

## 🎨 颜色系统

```dart
Column(
  children: [
    ZephyrText(
      '主要文本',
      color: ZephyrColors.primary,
    ),
    ZephyrText(
      '次要文本',
      color: ZephyrColors.secondary,
    ),
    ZephyrText(
      '成功文本',
      color: ZephyrColors.success,
    ),
    ZephyrText(
      '警告文本',
      color: ZephyrColors.warning,
    ),
    ZephyrText(
      '错误文本',
      color: ZephyrColors.error,
    ),
    ZephyrText(
      '禁用文本',
      color: ZephyrColors.disabled,
    ),
  ],
)
```

## 🔄 文本处理

### 文本截断

```dart
ZephyrText(
  '这是一段很长的文本，当超出指定行数时会被截断并显示省略号...',
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

### 文本对齐

```dart
Column(
  children: [
    ZephyrText(
      '左对齐文本',
      textAlign: TextAlign.left,
    ),
    ZephyrText(
      '居中对齐文本',
      textAlign: TextAlign.center,
    ),
    ZephyrText(
      '右对齐文本',
      textAlign: TextAlign.right,
    ),
  ],
)
```

### 文本装饰

```dart
Column(
  children: [
    ZephyrText(
      '下划线文本',
      decoration: TextDecoration.underline,
    ),
    ZephyrText(
      '删除线文本',
      decoration: TextDecoration.lineThrough,
    ),
    ZephyrText(
      '上划线文本',
      decoration: TextDecoration.overline,
    ),
  ],
)
```

## 🎭 富文本

### 文本组合

```dart
RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: '欢迎来到 ',
        style: ZephyrTextStyle.body1,
      ),
      TextSpan(
        text: 'ZephyrUI',
        style: ZephyrTextStyle.body1.copyWith(
          color: ZephyrColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      TextSpan(
        text: ' - 优雅的Flutter UI组件库',
        style: ZephyrTextStyle.body1,
      ),
    ],
  ),
)
```

### 链接文本

```dart
ZephyrText(
  '点击这里查看更多',
  style: ZephyrTextStyle.link,
  onPressed: () => _launchURL('https://example.com'),
)
```

## 📱 响应式设计

```dart
// 响应式文本大小
ZephyrText(
  '响应式标题',
  style: _getResponsiveTextStyle(context),
)

ZephyrTextStyle _getResponsiveTextStyle(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) return ZephyrTextStyle.headline6;
  if (width < 900) return ZephyrTextStyle.headline5;
  return ZephyrTextStyle.headline4;
}
```

## 🎭 最佳实践

### 1. 层级结构

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText(
      '页面标题',
      style: ZephyrTextStyle.headline4,
    ),
    SizedBox(height: 8),
    ZephyrText(
      '页面描述文本，提供更多的上下文信息...',
      style: ZephyrTextStyle.body1,
      color: ZephyrColors.secondary,
    ),
    SizedBox(height: 16),
    ZephyrText(
      '章节标题',
      style: ZephyrTextStyle.headline6,
    ),
    SizedBox(height: 4),
    ZephyrText(
      '章节内容...',
      style: ZephyrTextStyle.body2,
    ),
  ],
)
```

### 2. 状态显示

```dart
Widget _buildStatusText(bool isSuccess) {
  return ZephyrText(
    isSuccess ? '操作成功' : '操作失败',
    style: ZephyrTextStyle.body1.copyWith(
      color: isSuccess ? ZephyrColors.success : ZephyrColors.error,
    ),
  );
}
```

### 3. 数据格式化

```dart
ZephyrText(
  '价格: ${_formatPrice(price)}',
  style: ZephyrTextStyle.body1,
)

String _formatPrice(double price) {
  return '¥${price.toStringAsFixed(2)}';
}
```

### 4. 本地化支持

```dart
ZephyrText(
  AppLocalizations.of(context)!.welcomeMessage,
  style: ZephyrTextStyle.body1,
)
```

## 🎨 主题集成

```dart
// 在主题中配置文本样式
ZephyrThemeData(
  textTheme: ZephyrTextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headline4: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    headline5: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    body1: TextStyle(fontSize: 16),
    body2: TextStyle(fontSize: 14),
    button: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    caption: TextStyle(fontSize: 12),
    overline: TextStyle(fontSize: 10),
  ),
)
```

## 🔍 文本工具

### 文本截断工具

```dart
String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) return text;
  return '${text.substring(0, maxLength)}...';
}

// 使用
ZephyrText(
  truncateText(longText, 50),
  style: ZephyrTextStyle.body2,
)
```

### 文本高亮

```dart
Widget _buildHighlightedText(String text, String highlight) {
  if (highlight.isEmpty) {
    return ZephyrText(text);
  }
  
  final spans = <TextSpan>[];
  final parts = text.split(highlight);
  
  for (int i = 0; i < parts.length; i++) {
    spans.add(TextSpan(text: parts[i]));
    if (i < parts.length - 1) {
      spans.add(TextSpan(
        text: highlight,
        style: TextStyle(
          backgroundColor: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
      ));
    }
  }
  
  return RichText(text: TextSpan(children: spans));
}
```

## 📝 注意事项

1. **可读性**: 确保文本大小和颜色对比度符合可访问性标准
2. **一致性**: 在整个应用中使用一致的文本样式
3. **性能**: 避免在列表中使用过多的文本样式变化
4. **国际化**: 考虑文本长度在不同语言中的变化
5. **语义**: 使用适当的文本语义标签

---

**API 版本**: 1.0.0  
**最后更新**: 2024年8月18日