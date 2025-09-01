# ZephyrUI 主题系统

## 概述

ZephyrUI 主题系统是一个基于 Material Design 3 的现代化主题解决方案，提供了完整的主题管理、定制和扩展功能。

## 核心特性

### 🎨 统一的设计令牌
- 基于 Material Design 3 规范
- 完整的颜色、间距、字体、阴影系统
- 类型安全的设计令牌

### 🌓 主题切换支持
- 亮色/暗色主题
- 跟随系统设置
- 自定义主题创建

### 🔧 强大的扩展机制
- 主题扩展基类
- 组件级主题定制
- 灵活的属性覆盖

### 🛠️ 丰富的工具集
- 主题验证器
- 主题分析器
- 主题生成器
- 导出/导入功能

## 快速开始

### 1. 基础使用

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(
    ZephyrThemeExtensionBuilder(
      themeData: ZephyrUnifiedThemeData.light(),
      builder: (context, theme) {
        return MaterialApp(
          theme: theme.toMaterialTheme(),
          home: MyApp(),
        );
      },
    ),
  );
}
```

### 2. 主题切换

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主题演示'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              // 切换主题
              final newTheme = Theme.of(context).brightness == Brightness.light
                  ? ZephyrUnifiedThemeData.dark()
                  : ZephyrUnifiedThemeData.light();
              
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ZephyrThemeExtensionBuilder(
                    themeData: newTheme,
                    builder: (context, theme) => MyApp(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Hello, ZephyrUI!'),
      ),
    );
  }
}
```

### 3. 使用预设主题

```dart
// 使用预设主题
final theme = ZephyrThemeConfigurations.createPresetTheme('modern');
final enterpriseTheme = ZephyrThemeConfigurations.createEnterpriseTheme('technology');
final specialTheme = ZephyrThemeConfigurations.createSpecialTheme('accessibility');
```

### 4. 自定义主题

```dart
final customTheme = ZephyrUnifiedThemeData.light(
  primaryColor: Colors.purple,
  secondaryColor: Colors.pink,
  fontFamily: 'Roboto',
);
```

## 核心组件

### ZephyrUnifiedThemeData
统一主题数据结构，包含所有主题配置：

```dart
class ZephyrUnifiedThemeData {
  final Brightness brightness;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final Map<Type, ThemeExtension<dynamic>> extensions;
  final ZephyrSpacingTokens spacing;
  final ZephyrAnimationTokens animation;
  // ... 更多属性
}
```

### ZephyrThemeManager
主题管理器，提供主题切换和持久化功能：

```dart
// 初始化主题管理器
await ZephyrThemeManager.instance.initialize();

// 设置主题模式
await ZephyrThemeManager.instance.setThemeMode(ZephyrThemeMode.dark);

// 创建自定义主题
await ZephyrThemeManager.instance.createCustomTheme(
  primaryColor: Colors.purple,
  secondaryColor: Colors.pink,
);
```

### ZephyrThemeTools
主题工具集，提供各种实用功能：

```dart
// 验证主题
final result = ZephyrThemeTools.validator.validate(theme);

// 分析主题
final analysis = ZephyrThemeTools.analyzer.analyze(theme);

// 生成随机主题
final randomTheme = ZephyrThemeTools.generator.generateRandomTheme();

// 导出主题
final json = ZephyrThemeTools.exporter.toJson(theme);
```

## 设计令牌

### 颜色令牌

```dart
// 主色调
ZephyrColorTokens.primary50
ZephyrColorTokens.primary100
// ... 更多颜色

// 语义色调
ZephyrColorTokens.success50
ZephyrColorTokens.warning50
ZephyrColorTokens.error50
ZephyrColorTokens.info50
```

### 间距令牌

```dart
ZephyrSpacingTokens.micro    // 2.0
ZephyrSpacingTokens.small    // 8.0
ZephyrSpacingTokens.medium   // 16.0
ZephyrSpacingTokens.large    // 24.0
ZephyrSpacingTokens.extraLarge // 32.0
```

### 字体令牌

```dart
// 字体大小
ZephyrTypographyTokens.displayLarge  // 57.0
ZephyrTypographyTokens.headlineLarge // 32.0
ZephyrTypographyTokens.bodyLarge    // 16.0
ZephyrTypographyTokens.labelLarge   // 14.0

// 字重
ZephyrTypographyTokens.weightRegular
ZephyrTypographyTokens.weightMedium
ZephyrTypographyTokens.weightBold
```

### 动画令牌

```dart
ZephyrAnimationTokens.fast   // 150ms
ZephyrAnimationTokens.normal // 250ms
ZephyrAnimationTokens.slow   // 350ms
```

## 主题扩展

### 创建自定义扩展

```dart
class MyCustomThemeExtension extends ZephyrThemeExtension<MyCustomThemeExtension> {
  const MyCustomThemeExtension({
    this.customColor = Colors.blue,
    this.customSize = 16.0,
  });

  final Color customColor;
  final double customSize;

  @override
  MyCustomThemeExtension copyWith({
    Color? customColor,
    double? customSize,
  }) {
    return MyCustomThemeExtension(
      customColor: customColor ?? this.customColor,
      customSize: customSize ?? this.customSize,
    );
  }

  @override
  MyCustomThemeExtension merge(MyCustomThemeExtension? other) {
    if (other == null) return this;
    return copyWith(
      customColor: other.customColor,
      customSize: other.customSize,
    );
  }
}
```

### 使用扩展

```dart
final theme = ZephyrUnifiedThemeData.light().copyWith(
  extensions: {
    MyCustomThemeExtension: MyCustomThemeExtension(
      customColor: Colors.purple,
      customSize: 20.0,
    ),
  },
);

// 在组件中使用
final extension = ZephyrThemeUtils.getExtension<MyCustomThemeExtension>(context);
```

## 主题工具

### 验证工具

```dart
final result = ZephyrThemeTools.validator.validate(theme);
if (result.isValid) {
  print('主题配置正确');
} else {
  for (final issue in result.issues) {
    print('${issue.type}: ${issue.message}');
  }
}
```

### 分析工具

```dart
final analysis = ZephyrThemeTools.analyzer.analyze(theme);
print('颜色数量: ${analysis.colorCount}');
print('对比度: ${analysis.contrastRatio}');
print('可访问性评分: ${analysis.accessibilityScore}');
```

### 生成工具

```dart
// 随机生成
final randomTheme = ZephyrThemeTools.generator.generateRandomTheme();

// 从颜色生成
final colorTheme = ZephyrThemeTools.generator.generateFromColor(Colors.purple);
```

### 导出工具

```dart
// 导出为 JSON
final json = ZephyrThemeTools.exporter.toJson(theme);

// 导出为 Dart 代码
final dart = ZephyrThemeTools.exporter.toDartCode(theme);

// 导出为 CSS
final css = ZephyrThemeTools.exporter.toCss(theme);

// 保存到文件
await ZephyrThemeTools.exporter.saveToFile(
  theme, 
  'my_theme.json', 
  ZephyrThemeExportFormat.json,
);
```

## 最佳实践

### 1. 主题结构设计

```dart
// 推荐的主题结构
abstract class AppThemes {
  static final light = ZephyrUnifiedThemeData.light(
    primaryColor: AppColors.primary,
    secondaryColor: AppColors.secondary,
  );

  static final dark = ZephyrUnifiedThemeData.dark(
    primaryColor: AppColors.primaryDark,
    secondaryColor: AppColors.secondaryDark,
  );

  static final Map<String, ZephyrUnifiedThemeData> presets = {
    'default': light,
    'dark': dark,
    'corporate': ZephyrThemeConfigurations.createEnterpriseTheme('technology'),
  };
}
```

### 2. 主题管理

```dart
class ThemeService extends ChangeNotifier {
  ZephyrUnifiedThemeData _currentTheme = AppThemes.light;

  ZephyrUnifiedThemeData get currentTheme => _currentTheme;

  void setTheme(ZephyrUnifiedThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        setTheme(AppThemes.light);
        break;
      case ThemeMode.dark:
        setTheme(AppThemes.dark);
        break;
      case ThemeMode.system:
        // 根据系统设置选择主题
        break;
    }
  }
}
```

### 3. 组件主题使用

```dart
class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
      ),
      child: Text(
        'Hello World',
        style: textTheme.bodyLarge,
      ),
    );
  }
}
```

## 性能优化

### 1. 主题缓存

```dart
class ThemeCache {
  static final Map<String, ZephyrUnifiedThemeData> _cache = {};

  static ZephyrUnifiedThemeData getTheme(String key) {
    return _cache.putIfAbsent(key, () => _createTheme(key));
  }

  static ZephyrUnifiedThemeData _createTheme(String key) {
    // 根据键创建主题
    return ZephyrUnifiedThemeData.light();
  }
}
```

### 2. 懒加载主题

```dart
class LazyThemeProvider extends StatefulWidget {
  final Widget Function(BuildContext context, ZephyrUnifiedThemeData theme) builder;

  const LazyThemeProvider({required this.builder});

  @override
  State<LazyThemeProvider> createState() => _LazyThemeProviderState();
}

class _LazyThemeProviderState extends State<LazyThemeProvider> {
  ZephyrUnifiedThemeData? _theme;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final theme = await _loadThemeFromStorage();
    setState(() {
      _theme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_theme == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return widget.builder(context, _theme!);
  }
}
```

## 常见问题

### Q: 如何添加新的颜色到主题？

A: 使用主题扩展机制：

```dart
class ExtendedColorScheme extends ZephyrThemeExtension<ExtendedColorScheme> {
  const ExtendedColorScheme({
    this.brandColor = Colors.blue,
    this.accentColor = Colors.orange,
  });

  final Color brandColor;
  final Color accentColor;

  // 实现 copyWith 和 merge 方法
}
```

### Q: 如何实现主题切换动画？

A: 使用 `ZephyrAnimatedThemeSwitcher`：

```dart
ZephyrAnimatedThemeSwitcher(
  duration: Duration(milliseconds: 300),
  child: MyWidget(),
)
```

### Q: 如何验证主题的可访问性？

A: 使用主题分析工具：

```dart
final analysis = ZephyrThemeTools.analyzer.analyze(theme);
if (analysis.accessibilityScore < 0.7) {
  print('主题可访问性需要改进');
}
```

## 示例项目

查看 `example/theme_demo_app.dart` 获取完整的使用示例。

## API 参考

详细的 API 文档请参考各个类的文档注释。

## 更新日志

### v1.0.0
- 初始版本发布
- 基础主题系统
- 主题管理器
- 主题工具集
- 示例应用