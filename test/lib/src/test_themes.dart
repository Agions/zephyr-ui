/// 主题测试工具
///
/// 提供主题相关的测试工具和方法
library test_themes;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/core/constants/design_tokens.dart';
import 'package:zephyr_ui/src/core/constants/enums.dart';

/// 主题测试工具类
class ThemeTestUtils {
  /// 测试亮色主题
  static ThemeData get lightTheme => ThemeData.light();
  
  /// 测试暗色主题
  static ThemeData get darkTheme => ThemeData.dark();
  
  /// 创建自定义主题
  static ThemeData createTheme({
    Color primaryColor = ZephyrColors.primary500,
    Color secondaryColor = ZephyrColors.secondary500,
    Color backgroundColor = ZephyrColors.neutral50,
    Color surfaceColor = Colors.white,
    Color errorColor = ZephyrColors.error500,
    Brightness brightness = Brightness.light,
  }) {
    return ThemeData(
      brightness: brightness,
      primarySwatch: Colors.blue,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        secondary: secondaryColor,
        background: backgroundColor,
        surface: surfaceColor,
        error: errorColor,
      ),
    );
  }
  
  /// 创建主题变体
  static List<ThemeData> createThemeVariants() {
    return [
      lightTheme,
      darkTheme,
      createTheme(primaryColor: Colors.red),
      createTheme(primaryColor: Colors.green),
      createTheme(primaryColor: Colors.purple),
      createTheme(brightness: Brightness.dark),
    ];
  }
  
  /// 验证主题一致性
  static void expectThemeConsistency(
    ThemeData theme1,
    ThemeData theme2, {
    String? reason,
  }) {
    expect(theme1.brightness, theme2.brightness, reason: reason);
    expect(theme1.primaryColor, theme2.primaryColor, reason: reason);
    expect(theme1.scaffoldBackgroundColor, theme2.scaffoldBackgroundColor, reason: reason);
    expect(theme1.cardColor, theme2.cardColor, reason: reason);
    expect(theme1.dividerColor, theme2.dividerColor, reason: reason);
  }
  
  /// 验证主题属性
  static void expectThemeProperty<T>(
    ThemeData theme,
    T expected,
    T Function(ThemeData) getter, {
    String? reason,
  }) {
    expect(getter(theme), expected, reason: reason);
  }
  
  /// 验证颜色方案
  static void expectColorScheme(
    ColorScheme scheme1,
    ColorScheme scheme2, {
    String? reason,
  }) {
    expect(scheme1.brightness, scheme2.brightness, reason: reason);
    expect(scheme1.primary, scheme2.primary, reason: reason);
    expect(scheme1.secondary, scheme2.secondary, reason: reason);
    expect(scheme1.background, scheme2.background, reason: reason);
    expect(scheme1.surface, scheme2.surface, reason: reason);
    expect(scheme1.error, scheme2.error, reason: reason);
  }
  
  /// 验证文本主题
  static void expectTextTheme(
    TextTheme theme1,
    TextTheme theme2, {
    String? reason,
  }) {
    expectTextStyle(theme1.displayLarge, theme2.displayLarge, reason: reason);
    expectTextStyle(theme1.displayMedium, theme2.displayMedium, reason: reason);
    expectTextStyle(theme1.displaySmall, theme2.displaySmall, reason: reason);
    expectTextStyle(theme1.headlineLarge, theme2.headlineLarge, reason: reason);
    expectTextStyle(theme1.headlineMedium, theme2.headlineMedium, reason: reason);
    expectTextStyle(theme1.headlineSmall, theme2.headlineSmall, reason: reason);
    expectTextStyle(theme1.titleLarge, theme2.titleLarge, reason: reason);
    expectTextStyle(theme1.titleMedium, theme2.titleMedium, reason: reason);
    expectTextStyle(theme1.titleSmall, theme2.titleSmall, reason: reason);
    expectTextStyle(theme1.bodyLarge, theme2.bodyLarge, reason: reason);
    expectTextStyle(theme1.bodyMedium, theme2.bodyMedium, reason: reason);
    expectTextStyle(theme1.bodySmall, theme2.bodySmall, reason: reason);
    expectTextStyle(theme1.labelLarge, theme2.labelLarge, reason: reason);
    expectTextStyle(theme1.labelMedium, theme2.labelMedium, reason: reason);
    expectTextStyle(theme1.labelSmall, theme2.labelSmall, reason: reason);
  }
  
  /// 验证文本样式
  static void expectTextStyle(
    TextStyle? style1,
    TextStyle? style2, {
    String? reason,
  }) {
    if (style1 == null && style2 == null) return;
    if (style1 == null || style2 == null) {
      expect(style1, style2, reason: reason);
      return;
    }
    
    expect(style1.fontSize, style2.fontSize, reason: reason);
    expect(style1.fontWeight, style2.fontWeight, reason: reason);
    expect(style1.fontStyle, style2.fontStyle, reason: reason);
    expect(style1.color, style2.color, reason: reason);
    expect(style1.backgroundColor, style2.backgroundColor, reason: reason);
  }
  
  /// 验证主题扩展
  static void expectThemeExtension<T extends ThemeExtension<T>>(
    ThemeData theme,
    T expected, {
    String? reason,
  }) {
    final actual = theme.extension<T>();
    expect(actual, expected, reason: reason);
  }
  
  /// 在不同主题下测试组件
  static Future<void> testWithThemes(
    WidgetTester tester,
    Widget Function() widgetBuilder, {
    List<ThemeData> themes = const [
      ThemeData.light(),
      ThemeData.dark(),
    ],
    required Future<void> Function(WidgetTester, ThemeData) testCallback,
  }) async {
    for (final theme in themes) {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Material(
            child: widgetBuilder(),
          ),
        ),
      );
      
      await testCallback(tester, theme);
    }
  }
  
  /// 在不同亮度下测试组件
  static Future<void> testWithBrightness(
    WidgetTester tester,
    Widget Function() widgetBuilder, {
    List<Brightness> brightnesses = const [
      Brightness.light,
      Brightness.dark,
    ],
    required Future<void> Function(WidgetTester, Brightness) testCallback,
  }) async {
    for (final brightness in brightnesses) {
      await tester.pumpWidget(
        MaterialApp(
          theme: brightness == Brightness.light
              ? ThemeData.light()
              : ThemeData.dark(),
          darkTheme: ThemeData.dark(),
          themeMode: brightness == Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
          home: Material(
            child: widgetBuilder(),
          ),
        ),
      );
      
      await testCallback(tester, brightness);
    }
  }
  
  /// 在不同颜色方案下测试组件
  static Future<void> testWithColorSchemes(
    WidgetTester tester,
    Widget Function() widgetBuilder, {
    List<ColorScheme> colorSchemes = const [
      ColorScheme.light(),
      ColorScheme.dark(),
      ColorScheme.highContrastLight(),
      ColorScheme.highContrastDark(),
    ],
    required Future<void> Function(WidgetTester, ColorScheme) testCallback,
  }) async {
    for (final colorScheme in colorSchemes) {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(colorScheme: colorScheme),
          home: Material(
            child: widgetBuilder(),
          ),
        ),
      );
      
      await testCallback(tester, colorScheme);
    }
  }
  
  /// 测试主题切换
  static Future<void> testThemeSwitching(
    WidgetTester tester,
    Widget Function() widgetBuilder, {
    required Future<void> Function(WidgetTester, ThemeMode) testCallback,
  }) async {
    final themeModes = [
      ThemeMode.light,
      ThemeMode.dark,
      ThemeMode.system,
    ];
    
    for (final themeMode in themeModes) {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: Material(
            child: widgetBuilder(),
          ),
        ),
      );
      
      await testCallback(tester, themeMode);
    }
  }
  
  /// 测试主题继承
  static Future<void> testThemeInheritance(
    WidgetTester tester,
    Widget Function() widgetBuilder, {
    required Future<void> Function(WidgetTester, ThemeData) testCallback,
  }) async {
    // 测试父主题
    final parentTheme = ThemeData(
      primaryColor: Colors.red,
      scaffoldBackgroundColor: Colors.grey[100],
    );
    
    // 测试子主题
    final childTheme = parentTheme.copyWith(
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[200],
    );
    
    // 测试混合主题
    final mixedTheme = ThemeData(
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.grey[300],
    );
    
    final themes = [parentTheme, childTheme, mixedTheme];
    
    for (final theme in themes) {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Material(
            child: widgetBuilder(),
          ),
        ),
      );
      
      await testCallback(tester, theme);
    }
  }
  
  /// 测试主题数据复制
  static void testThemeDataCopy(ThemeData theme) {
    // 测试复制功能
    final copied = theme.copyWith();
    expectThemeConsistency(theme, copied);
    
    // 测试部分属性修改
    final modified = theme.copyWith(
      primaryColor: Colors.red,
      scaffoldBackgroundColor: Colors.grey[200],
    );
    
    expect(modified.primaryColor, Colors.red);
    expect(modified.scaffoldBackgroundColor, Colors.grey[200]);
    expect(modified.brightness, theme.brightness);
  }
  
  /// 测试主题数据比较
  static void testThemeDataComparison(ThemeData theme1, ThemeData theme2) {
    // 测试相等性
    expect(theme1 == theme2, isTrue);
    
    // 测试哈希码
    expect(theme1.hashCode, theme2.hashCode);
  }
  
  /// 测试主题数据序列化
  static void testThemeDataSerialization(ThemeData theme) {
    // 测试转换为Map
    final map = theme.toJson();
    expect(map, isNotNull);
    expect(map, isA<Map<String, dynamic>>());
    
    // 测试从Map恢复
    final restored = ThemeData.fromJson(map);
    expectThemeConsistency(theme, restored);
  }
  
  /// 获取主题属性
  static T getThemeProperty<T>(ThemeData theme, String propertyName) {
    switch (propertyName) {
      case 'brightness':
        return theme.brightness as T;
      case 'primaryColor':
        return theme.primaryColor as T;
      case 'secondaryHeaderColor':
        return theme.secondaryHeaderColor as T;
      case 'backgroundColor':
        return theme.backgroundColor as T;
      case 'scaffoldBackgroundColor':
        return theme.scaffoldBackgroundColor as T;
      case 'cardColor':
        return theme.cardColor as T;
      case 'dividerColor':
        return theme.dividerColor as T;
      case 'focusColor':
        return theme.focusColor as T;
      case 'hoverColor':
        return theme.hoverColor as T;
      case 'splashColor':
        return theme.splashColor as T;
      case 'highlightColor':
        return theme.highlightColor as T;
      case 'disabledColor':
        return theme.disabledColor as T;
      case 'errorColor':
        return theme.errorColor as T;
      default:
        throw ArgumentError('Unknown theme property: $propertyName');
    }
  }
  
  /// 设置主题属性
  static ThemeData setThemeProperty<T>(
    ThemeData theme,
    String propertyName,
    T value,
  ) {
    switch (propertyName) {
      case 'brightness':
        return theme.copyWith(brightness: value as Brightness);
      case 'primaryColor':
        return theme.copyWith(primaryColor: value as Color);
      case 'secondaryHeaderColor':
        return theme.copyWith(secondaryHeaderColor: value as Color);
      case 'backgroundColor':
        return theme.copyWith(backgroundColor: value as Color);
      case 'scaffoldBackgroundColor':
        return theme.copyWith(scaffoldBackgroundColor: value as Color);
      case 'cardColor':
        return theme.copyWith(cardColor: value as Color);
      case 'dividerColor':
        return theme.copyWith(dividerColor: value as Color);
      case 'focusColor':
        return theme.copyWith(focusColor: value as Color);
      case 'hoverColor':
        return theme.copyWith(hoverColor: value as Color);
      case 'splashColor':
        return theme.copyWith(splashColor: value as Color);
      case 'highlightColor':
        return theme.copyWith(highlightColor: value as Color);
      case 'disabledColor':
        return theme.copyWith(disabledColor: value as Color);
      case 'errorColor':
        return theme.copyWith(errorColor: value as Color);
      default:
        throw ArgumentError('Unknown theme property: $propertyName');
    }
  }
  
  /// 测试主题属性访问器
  static void testThemePropertyAccessors(ThemeData theme) {
    // 测试所有属性访问器
    expect(theme.brightness, isNotNull);
    expect(theme.primaryColor, isNotNull);
    expect(theme.secondaryHeaderColor, isNotNull);
    expect(theme.backgroundColor, isNotNull);
    expect(theme.scaffoldBackgroundColor, isNotNull);
    expect(theme.cardColor, isNotNull);
    expect(theme.dividerColor, isNotNull);
    expect(theme.focusColor, isNotNull);
    expect(theme.hoverColor, isNotNull);
    expect(theme.splashColor, isNotNull);
    expect(theme.highlightColor, isNotNull);
    expect(theme.disabledColor, isNotNull);
    expect(theme.errorColor, isNotNull);
  }
  
  /// 测试主题数据默认值
  static void testThemeDataDefaults(ThemeData theme) {
    // 测试默认主题属性
    expect(theme.brightness, Brightness.light);
    expect(theme.primaryColor, isNotNull);
    expect(theme.scaffoldBackgroundColor, isNotNull);
    expect(theme.cardColor, isNotNull);
    expect(theme.dividerColor, isNotNull);
  }
  
  /// 测试主题数据边界情况
  static void testThemeDataEdgeCases() {
    // 测试空主题
    final emptyTheme = ThemeData();
    testThemeDataDefaults(emptyTheme);
    
    // 测试自定义主题
    final customTheme = ThemeData(
      primaryColor: Colors.red,
      scaffoldBackgroundColor: Colors.grey[200],
    );
    expect(customTheme.primaryColor, Colors.red);
    expect(customTheme.scaffoldBackgroundColor, Colors.grey[200]);
    
    // 测试极端颜色值
    final extremeTheme = ThemeData(
      primaryColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0x00000000),
    );
    expect(extremeTheme.primaryColor, const Color(0xFFFFFFFF));
    expect(extremeTheme.scaffoldBackgroundColor, const Color(0x00000000));
  }
  
  /// 测试主题数据错误处理
  static void testThemeDataErrorHandling() {
    // 测试无效属性
    expect(() => getThemeProperty(ThemeData(), 'invalidProperty'), throwsArgumentError);
    
    // 测试无效属性值
    expect(() => setThemeProperty(ThemeData(), 'brightness', 'invalid'), throwsA(isA<TypeError>()));
  }
  
  /// 测试主题数据性能
  static void testThemeDataPerformance() {
    final sw = Stopwatch()..start();
    
    // 测试主题创建性能
    for (int i = 0; i < 1000; i++) {
      ThemeData();
    }
    
    sw.stop();
    print('ThemeData creation time: ${sw.elapsedMilliseconds}ms');
    
    // 测试主题复制性能
    sw.reset();
    final theme = ThemeData();
    for (int i = 0; i < 1000; i++) {
      theme.copyWith();
    }
    sw.stop();
    print('ThemeData copy time: ${sw.elapsedMilliseconds}ms');
  }
  
  /// 测试主题数据内存使用
  static void testThemeDataMemoryUsage() {
    final theme = ThemeData();
    final copied = theme.copyWith();
    
    // 验证复制不会共享引用
    expect(identical(theme, copied), isFalse);
    expect(identical(theme.primaryColor, copied.primaryColor), isTrue); // 颜色是不可变的
    
    // 验证深拷贝
    expect(theme.primaryColor, copied.primaryColor);
  }
}

/// 主题测试数据
class ThemeTestData {
  /// 常用颜色方案
  static const List<ColorScheme> commonColorSchemes = [
    ColorScheme.light(),
    ColorScheme.dark(),
    ColorScheme.highContrastLight(),
    ColorScheme.highContrastDark(),
  ];
  
  /// 常用主题
  static const List<ThemeData> commonThemes = [
    ThemeData.light(),
    ThemeData.dark(),
    ThemeData(primarySwatch: Colors.blue),
    ThemeData(primarySwatch: Colors.green),
    ThemeData(primarySwatch: Colors.red),
  ];
  
  /// 常用亮度模式
  static const List<Brightness> commonBrightnesses = [
    Brightness.light,
    Brightness.dark,
  ];
  
  /// 常用主题模式
  static const List<ThemeMode> commonThemeModes = [
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system,
  ];
  
  /// 主题属性测试用例
  static const List<Map<String, dynamic>> themePropertyTests = [
    {'property': 'brightness', 'values': [Brightness.light, Brightness.dark]},
    {'property': 'primaryColor', 'values': [Colors.blue, Colors.red, Colors.green]},
    {'property': 'scaffoldBackgroundColor', 'values': [Colors.white, Colors.grey[200]]},
    {'property': 'cardColor', 'values': [Colors.white, Colors.grey[100]]},
    {'property': 'dividerColor', 'values': [Colors.grey[300], Colors.grey[400]]},
  ];
}

/// 主题测试断言
class ThemeTestAssertions {
  /// 验证主题颜色对比度
  static void expectColorContrast(
    Color foreground,
    Color background, {
    double minimumRatio = 4.5,
    String? reason,
  }) {
    final ratio = _calculateContrastRatio(foreground, background);
    expect(ratio, greaterThanOrEqualTo(minimumRatio), reason: reason);
  }
  
  /// 计算颜色对比度
  static double _calculateContrastRatio(Color color1, Color color2) {
    final l1 = _calculateLuminance(color1);
    final l2 = _calculateLuminance(color2);
    
    final lighter = math.max(l1, l2);
    final darker = math.min(l1, l2);
    
    return (lighter + 0.05) / (darker + 0.05);
  }
  
  /// 计算颜色亮度
  static double _calculateLuminance(Color color) {
    final r = color.red / 255.0;
    final g = color.green / 255.0;
    final b = color.blue / 255.0;
    
    final rLinear = r <= 0.03928 ? r / 12.92 : math.pow((r + 0.055) / 1.055, 2.4);
    final gLinear = g <= 0.03928 ? g / 12.92 : math.pow((g + 0.055) / 1.055, 2.4);
    final bLinear = b <= 0.03928 ? b / 12.92 : math.pow((b + 0.055) / 1.055, 2.4);
    
    return 0.2126 * rLinear + 0.7152 * gLinear + 0.0722 * bLinear;
  }
  
  /// 验证主题可访问性
  static void expectThemeAccessibility(
    ThemeData theme, {
    String? reason,
  }) {
    // 验证文本颜色对比度
    expectColorContrast(
      theme.primaryTextTheme.bodyLarge?.color ?? Colors.black,
      theme.scaffoldBackgroundColor,
      minimumRatio: 4.5,
      reason: reason,
    );
    
    // 验证主色调对比度
    expectColorContrast(
      theme.primaryColor,
      theme.scaffoldBackgroundColor,
      minimumRatio: 3.0,
      reason: reason,
    );
    
    // 验证错误颜色对比度
    expectColorContrast(
      theme.errorColor,
      theme.scaffoldBackgroundColor,
      minimumRatio: 3.0,
      reason: reason,
    );
  }
  
  /// 验证主题一致性
  static void expectThemeConsistencyAcrossVariants(
    List<ThemeData> themes, {
    String? reason,
  }) {
    if (themes.isEmpty) return;
    
    final baseTheme = themes.first;
    
    for (final theme in themes) {
      // 验证基本属性类型一致
      expect(theme.brightness.runtimeType, baseTheme.brightness.runtimeType, reason: reason);
      expect(theme.primaryColor.runtimeType, baseTheme.primaryColor.runtimeType, reason: reason);
      
      // 验证文本主题结构一致
      expectTextTheme(theme.primaryTextTheme, baseTheme.primaryTextTheme, reason: reason);
      expectTextTheme(theme.textTheme, baseTheme.textTheme, reason: reason);
    }
  }
}