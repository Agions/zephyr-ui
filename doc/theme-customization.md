---
title: 主题定制
description: 深入了解 VelocityUI 的主题定制系统
---

# 主题定制

VelocityUI 提供了强大的主题定制系统，允许您根据应用的设计需求自定义组件的外观和行为。本指南将深入介绍主题定制的各种方式和最佳实践。

## 1. 主题系统概述

### 1.1 核心概念

VelocityUI 的主题系统基于以下核心概念：

- **VelocityThemeData**：全局主题配置类，包含所有组件的主题设置
- **组件主题类**：如 `VelocityButtonTheme`、`VelocityTextTheme` 等，用于配置特定组件的主题
- **样式类**：如 `VelocityButtonStyle`、`VelocityTextStyle` 等，用于在组件级别覆盖主题
- **EffectiveStyle**：用于合并主题样式和组件自定义样式的机制

### 1.2 主题优先级

VelocityUI 的主题优先级从高到低依次为：

1. 组件级样式覆盖
2. 全局主题配置
3. 组件默认样式

## 2. 全局主题配置

### 2.1 基本配置

在应用的根组件中，通过 `VelocityThemeData` 配置全局主题：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      VelocityThemeData(
        // 全局主题配置
        primaryColor: Colors.blue,
        secondaryColor: Colors.green,
        successColor: Colors.green,
        warningColor: Colors.yellow,
        errorColor: Colors.red,
        infoColor: Colors.blue,
      ),
    ],
  ),
  home: const MyHomePage(),
);
```

### 2.2 组件主题配置

您可以为特定组件配置详细的主题：

```dart
VelocityThemeData(
  // 按钮主题
  buttonTheme: VelocityButtonTheme(
    primaryColor: Colors.purple,
    borderRadius: BorderRadius.circular(8),
    height: 48,
    fontSize: 16,
    fontWeight: FontWeight.medium,
  ),
  
  // 文本主题
  textTheme: VelocityTextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.black54,
    ),
  ),
  
  // 卡片主题
  cardTheme: VelocityCardTheme(
    borderRadius: BorderRadius.circular(12),
    shadowColor: Colors.black.withOpacity(0.1),
    elevation: 2,
    padding: EdgeInsets.all(16),
  ),
);
```

### 2.3 深色模式支持

VelocityUI 支持深色模式，您可以分别配置浅色和深色主题：

```dart
MaterialApp(
  theme: ThemeData(
    brightness: Brightness.light,
    extensions: [
      VelocityThemeData(
        // 浅色主题配置
        primaryColor: Colors.blue,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      ),
    ],
  ),
  darkTheme: ThemeData(
    brightness: Brightness.dark,
    extensions: [
      VelocityThemeData(
        // 深色主题配置
        primaryColor: Colors.blueAccent,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      ),
    ],
  ),
  themeMode: ThemeMode.system, // 跟随系统主题
  home: const MyHomePage(),
);
```

## 3. 组件级样式覆盖

### 3.1 基本样式覆盖

在使用组件时，您可以通过 `style` 属性覆盖主题样式：

```dart
VelocityButton(
  text: '自定义按钮',
  onPressed: () {},
  style: VelocityButtonStyle(
    backgroundColor: Colors.orange,
    textColor: Colors.white,
    borderRadius: BorderRadius.circular(10),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    fontSize: 16,
  ),
);
```

### 3.2 链式样式设置

VelocityUI 支持链式调用的样式设置：

```dart
VelocityText(
  '链式样式设置',
).textSize(VelocityTextSize.xl)
 .textColor(Colors.blue)
 .fontWeight(VelocityFontWeight.bold)
 .textAlign(TextAlign.center);
```

### 3.3 主题继承

组件样式可以继承主题样式，只修改部分属性：

```dart
VelocityButton(
  text: '继承主题样式',
  onPressed: () {},
  style: VelocityButtonStyle(
    // 只修改背景色，其他属性继承主题
    backgroundColor: Colors.pink,
  ),
);
```

## 4. 样式系统详解

### 4.1 EffectiveStyle 机制

VelocityUI 使用 `EffectiveStyle` 机制来合并主题样式和组件自定义样式：

```dart
class EffectiveStyle<T extends StyleBase> {
  // 合并主题样式和自定义样式
  T merge(T themeStyle, T? customStyle) {
    // 合并逻辑
  }
}
```

### 4.2 样式属性类型

VelocityUI 的样式属性支持多种类型：

- **基本类型**：如 `double`、`int`、`bool` 等
- **颜色类型**：`Color`
- **字体类型**：`TextStyle`
- **边框类型**：`BorderRadius`、`BorderSide`
- **布局类型**：`EdgeInsets`、`Alignment`
- **枚举类型**：如 `VelocityButtonType`、`VelocityTextSize` 等

### 4.3 响应式样式

VelocityUI 支持响应式样式，可以根据屏幕尺寸调整组件样式：

```dart
VelocityButton(
  text: '响应式按钮',
  onPressed: () {},
  style: VelocityButtonStyle(
    padding: VelocityResponsiveEdgeInsets(
      xs: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      sm: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      md: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      lg: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      xl: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    ),
    fontSize: VelocityResponsiveDouble(
      xs: 14,
      sm: 15,
      md: 16,
      lg: 17,
      xl: 18,
    ),
  ),
);
```

## 5. 自定义组件主题

### 5.1 创建自定义主题类

如果您创建了自定义组件，可以为其创建主题类：

```dart
class VelocityCustomComponentTheme {
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  
  const VelocityCustomComponentTheme({
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8,
  });
}
```

### 5.2 集成到全局主题

将自定义主题类集成到 `VelocityThemeData` 中：

```dart
extension VelocityThemeDataExtension on VelocityThemeData {
  VelocityCustomComponentTheme get customComponentTheme => 
      this.customComponentTheme ?? const VelocityCustomComponentTheme();
}
```

### 5.3 在组件中使用

在自定义组件中使用主题：

```dart
class VelocityCustomComponent extends StatelessWidget {
  const VelocityCustomComponent({
    Key? key,
    required this.text,
    this.onPressed,
    this.style,
  }) : super(key: key);
  
  final String text;
  final VoidCallback? onPressed;
  final VelocityCustomComponentStyle? style;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<VelocityThemeData>();
    final effectiveStyle = EffectiveStyle<VelocityCustomComponentStyle>()
        .merge(theme!.customComponentTheme, style);
    
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: effectiveStyle.backgroundColor,
          borderRadius: BorderRadius.circular(effectiveStyle.borderRadius),
        ),
        child: Text(
          text,
          style: TextStyle(color: effectiveStyle.textColor),
        ),
      ),
    );
  }
}
```

## 6. 主题定制最佳实践

### 6.1 设计系统整合

将 VelocityUI 主题与您的设计系统整合：

```dart
// 从设计系统定义颜色
const designColors = {
  'primary': Colors.blue,
  'secondary': Colors.green,
  'success': Colors.green,
  'warning': Colors.yellow,
  'error': Colors.red,
  'info': Colors.blue,
};

// 创建基于设计系统的主题
final appTheme = VelocityThemeData(
  primaryColor: designColors['primary'],
  secondaryColor: designColors['secondary'],
  // 其他主题配置
);
```

### 6.2 主题分离

将主题配置与业务逻辑分离，便于维护和切换：

```dart
// theme/app_theme.dart
class AppTheme {
  static final light = VelocityThemeData(/* 浅色主题配置 */);
  static final dark = VelocityThemeData(/* 深色主题配置 */);
}

// 在应用中使用
MaterialApp(
  theme: ThemeData(extensions: [AppTheme.light]),
  darkTheme: ThemeData(extensions: [AppTheme.dark]),
  // ...
);
```

### 6.3 组件主题一致性

保持组件主题的一致性：

- 使用相同的圆角半径
- 保持一致的颜色系统
- 统一的间距和内边距
- 协调的字体大小和粗细

### 6.4 性能考虑

- 避免在每次构建时创建新的主题实例
- 使用 `const` 构造函数定义主题
- 合理使用主题继承，避免重复配置

## 7. 主题切换

### 7.1 运行时主题切换

支持在运行时切换主题：

```dart
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

// 在应用中使用
class MyApp extends StatelessWidget {
  final ThemeProvider themeProvider = ThemeProvider();
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            theme: ThemeData(extensions: [AppTheme.light]),
            darkTheme: ThemeData(extensions: [AppTheme.dark]),
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}
```

## 8. 主题调试

### 8.1 使用主题检查器

您可以创建一个主题检查器工具，用于调试和查看当前主题配置：

```dart
class ThemeInspector extends StatelessWidget {
  const ThemeInspector({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<VelocityThemeData>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('主题检查器')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('主色调: ${theme!.primaryColor}'),
              Text('次色调: ${theme.secondaryColor}'),
              Text('成功色: ${theme.successColor}'),
              // 其他主题属性
            ],
          ),
        ),
      ),
    );
  }
}
```

### 8.2 常见主题问题

- **主题不生效**：检查主题是否正确配置在 `MaterialApp` 的 `extensions` 中
- **样式覆盖不生效**：检查样式属性名称是否正确，以及主题优先级
- **深色模式切换问题**：确保同时配置了 `theme` 和 `darkTheme`

## 9. 主题配置参考

### 9.1 全局主题属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| primaryColor | Color | Colors.blue | 主色调 |
| secondaryColor | Color | Colors.green | 次色调 |
| successColor | Color | Colors.green | 成功色 |
| warningColor | Color | Colors.yellow | 警告色 |
| errorColor | Color | Colors.red | 错误色 |
| infoColor | Color | Colors.blue | 信息色 |
| backgroundColor | Color | Colors.white | 背景色 |
| textColor | Color | Colors.black | 文本色 |
| disabledColor | Color | Colors.grey | 禁用色 |

### 9.2 组件主题类

每个组件都有对应的主题类，例如：

- `VelocityButtonTheme` - 按钮主题
- `VelocityTextTheme` - 文本主题
- `VelocityCardTheme` - 卡片主题
- `VelocityInputTheme` - 输入框主题
- `VelocityBadgeTheme` - 徽章主题
- `VelocityDialogTheme` - 对话框主题

## 10. 总结

VelocityUI 的主题定制系统提供了强大的灵活性和可扩展性，允许您根据应用的设计需求自定义组件的外观和行为。通过合理使用全局主题配置和组件级样式覆盖，您可以创建出既符合设计规范又具有个性化特色的应用界面。

建议在项目初期就建立完善的主题系统，这将有助于保持应用的设计一致性，提高开发效率，并便于后续的维护和扩展。

---

通过本指南，您已经深入了解了 VelocityUI 的主题定制系统。现在，您可以开始为您的应用创建独特的主题设计了！