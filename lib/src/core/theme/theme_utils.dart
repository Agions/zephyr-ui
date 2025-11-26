/// ZephyrUI 主题工具类
///
/// 提供主题相关的实用工具和辅助方法
library theme_utils;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'unified_theme_data.dart';
import 'design_tokens.dart';

/// 主题工具类
class ZephyrThemeUtils {
  ZephyrThemeUtils._();

  /// 从上下文获取主题数据
  static ZephyrUnifiedThemeData? of(BuildContext context) {
    return Theme.of(context).extension<ZephyrUnifiedThemeExtension>()?.data;
  }

  /// 获取颜色方案
  static ColorScheme getColorScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  /// 获取文本主题
  static TextTheme getTextTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  /// 获取主题扩展
  static T? getExtension<T extends ThemeExtension<T>>(BuildContext context) {
    return Theme.of(context).extension<T>();
  }

  /// 判断是否为暗色主题
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// 获取对比色
  static Color getContrastColor(Color color) {
    // 计算颜色的相对亮度
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// 获取颜色阴影
  static Color getColorShade(Color color, {double amount = 0.2}) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// 获取颜色色调
  static Color getColorTint(Color color, {double amount = 0.2}) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// 获取颜色透明度变化
  static Color getColorWithOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  /// 创建颜色渐变
  static LinearGradient createColorGradient({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
      stops: stops,
      tileMode: tileMode,
    );
  }

  /// 创建阴影效果
  static List<BoxShadow> createShadowEffect({
    Color color = Colors.black,
    double blurRadius = 10,
    double spreadRadius = 0,
    Offset offset = const Offset(0, 2),
    double opacity = 0.1,
  }) {
    return [
      BoxShadow(
        color: color.withValues(alpha: opacity),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        offset: offset,
      ),
    ];
  }

  /// 获取响应式尺寸
  static double getResponsiveSize(
    BuildContext context, {
    required double mobileSize,
    double? tabletSize,
    double? desktopSize,
  }) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= ZephyrBreakpointTokens.lg && desktopSize != null) {
      return desktopSize;
    }
    if (width >= ZephyrBreakpointTokens.md && tabletSize != null) {
      return tabletSize;
    }
    return mobileSize;
  }

  /// 获取响应式间距
  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    required EdgeInsets mobilePadding,
    EdgeInsets? tabletPadding,
    EdgeInsets? desktopPadding,
  }) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= ZephyrBreakpointTokens.lg && desktopPadding != null) {
      return desktopPadding;
    }
    if (width >= ZephyrBreakpointTokens.md && tabletPadding != null) {
      return tabletPadding;
    }
    return mobilePadding;
  }

  /// 创建自适应布局
  static Widget createResponsiveLayout({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= ZephyrBreakpointTokens.lg && desktop != null) {
      return desktop;
    }
    if (width >= ZephyrBreakpointTokens.md && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// 格式化颜色值
  static String formatColorValue(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  /// 解析颜色值
  static Color? parseColorValue(String value) {
    try {
      if (value.startsWith('#')) {
        return Color(int.parse(value.substring(1), radix: 16));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 创建主题预览
  static Widget createThemePreview({
    required ZephyrUnifiedThemeData theme,
    required VoidCallback onTap,
    String? label,
    double width = 120,
    double height = 80,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
          border: Border.all(
            color: theme.colorScheme.outline,
            width: ZephyrBorderTokens.hairline,
          ),
          boxShadow: ZephyrShadowTokens.small,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(ZephyrRadiusTokens.medium),
                  ),
                ),
              ),
            ),
            if (label != null)
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 创建颜色选择器
  static Future<Color?> showColorPicker({
    required BuildContext context,
    Color? initialColor,
    String? title,
  }) async {
    return showDialog<Color>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? '选择颜色'),
        content: SizedBox(
          width: 300,
          height: 400,
          child: _ColorPickerWidget(
            initialColor: initialColor ?? Colors.blue,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 创建主题配置对话框
  static Future<Map<String, dynamic>?> showThemeConfigDialog({
    required BuildContext context,
    Map<String, dynamic>? initialConfig,
  }) async {
    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _ThemeConfigDialog(
        initialConfig: initialConfig ?? {},
      ),
    );
  }

  /// 生成主题报告
  static String generateThemeReport(ZephyrUnifiedThemeData theme) {
    final buffer = StringBuffer();

    buffer.writeln('=== ZephyrUI 主题报告 ===');
    buffer.writeln('');
    buffer.writeln('亮度模式: ${theme.brightness.name}');
    buffer.writeln('');

    buffer.writeln('颜色方案:');
    buffer.writeln('  主色: ${formatColorValue(theme.colorScheme.primary)}');
    buffer.writeln('  次要色: ${formatColorValue(theme.colorScheme.secondary)}');
    buffer.writeln('  第三色: ${formatColorValue(theme.colorScheme.tertiary)}');
    buffer.writeln('  错误色: ${formatColorValue(theme.colorScheme.error)}');
    buffer.writeln('  表面色: ${formatColorValue(theme.colorScheme.surface)}');
    buffer.writeln(
        '  表面色变体: ${formatColorValue(theme.colorScheme.surfaceContainerHighest)}');
    buffer.writeln('');

    buffer.writeln('文本主题:');
    buffer.writeln('  显示大号: ${theme.textTheme.displayLarge?.fontSize}px');
    buffer.writeln('  标题大号: ${theme.textTheme.headlineLarge?.fontSize}px');
    buffer.writeln('  标题中号: ${theme.textTheme.headlineMedium?.fontSize}px');
    buffer.writeln('  正文大号: ${theme.textTheme.bodyLarge?.fontSize}px');
    buffer.writeln('  正文中号: ${theme.textTheme.bodyMedium?.fontSize}px');
    buffer.writeln('  标签大号: ${theme.textTheme.labelLarge?.fontSize}px');
    buffer.writeln('');

    buffer.writeln('间距配置:');
    buffer.writeln('  微小: ${theme.spacing.micro}px');
    buffer.writeln('  小号: ${theme.spacing.small}px');
    buffer.writeln('  中号: ${theme.spacing.medium}px');
    buffer.writeln('  大号: ${theme.spacing.large}px');
    buffer.writeln('  特大: ${theme.spacing.extraLarge}px');
    buffer.writeln('');

    buffer.writeln('动画配置:');
    buffer.writeln('  超快: ${theme.animation.ultraFast.inMilliseconds}ms');
    buffer.writeln('  快速: ${theme.animation.fast.inMilliseconds}ms');
    buffer.writeln('  正常: ${theme.animation.normal.inMilliseconds}ms');
    buffer.writeln('  慢速: ${theme.animation.slow.inMilliseconds}ms');
    buffer.writeln('  超慢: ${theme.animation.ultraSlow.inMilliseconds}ms');

    return buffer.toString();
  }

  /// 验证主题配置
  static bool validateThemeConfiguration(ZephyrUnifiedThemeData theme) {
    try {
      // 验证颜色方案
      final colors = [
        theme.colorScheme.primary,
        theme.colorScheme.secondary,
        theme.colorScheme.tertiary,
        theme.colorScheme.error,
        theme.colorScheme.surface,
        theme.colorScheme.onSurface,
      ];

      for (final color in colors) {
        if (color.value == 0) return false;
      }

      // 验证文本主题
      if (theme.textTheme.bodyLarge?.fontSize == null) return false;

      // 验证间距
      if (theme.spacing.small <= 0) return false;

      return true;
    } catch (e) {
      return false;
    }
  }

  /// 复制主题配置到剪贴板
  static Future<void> copyThemeConfig(ZephyrUnifiedThemeData theme) async {
    final config = {
      'brightness': theme.brightness.name,
      'colors': {
        'primary': theme.colorScheme.primary.value,
        'secondary': theme.colorScheme.secondary.value,
        'tertiary': theme.colorScheme.tertiary.value,
        'error': theme.colorScheme.error.value,
        'surface': theme.colorScheme.surface.value,
      },
      'spacing': {
        'small': theme.spacing.small,
        'medium': theme.spacing.medium,
        'large': theme.spacing.large,
      },
    };

    final configString = config.toString();
    await Clipboard.setData(ClipboardData(text: configString));
  }
}

/// 颜色选择器组件
class _ColorPickerWidget extends StatefulWidget {
  const _ColorPickerWidget({
    required this.initialColor,
  });

  final Color initialColor;

  @override
  State<_ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<_ColorPickerWidget> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: _predefinedColors.length,
            itemBuilder: (context, index) {
              final color = _predefinedColors[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _selectedColor == color
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: _selectedColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              ZephyrThemeUtils.formatColorValue(_selectedColor),
              style: TextStyle(
                color: ZephyrThemeUtils.getContrastColor(_selectedColor),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static const List<Color> _predefinedColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.bluerown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
    Colors.white,
  ];
}

/// 主题配置对话框
class _ThemeConfigDialog extends StatefulWidget {
  const _ThemeConfigDialog({
    required this.initialConfig,
  });

  final Map<String, dynamic> initialConfig;

  @override
  State<_ThemeConfigDialog> createState() => _ThemeConfigDialogState();
}

class _ThemeConfigDialogState extends State<_ThemeConfigDialog> {
  late Map<String, dynamic> _config;

  @override
  void initState() {
    super.initState();
    _config = Map<String, dynamic>.from(widget.initialConfig);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('主题配置'),
      content: SizedBox(
        width: 400,
        height: 300,
        child: Column(
          children: [
            // 这里可以添加更多配置选项
            const Text('主题配置选项'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildConfigItem('主色', 'primaryColor', Colors.blue),
                  _buildConfigItem('次要色', 'secondaryColor', Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _config),
          child: const Text('确定'),
        ),
      ],
    );
  }

  Widget _buildConfigItem(String label, String key, Color defaultColor) {
    final colorValue = _config[key] as int?;
    final color = colorValue != null ? Color(colorValue) : defaultColor;

    return ListTile(
      title: Text(label),
      trailing: GestureDetector(
        onTap: () async {
          final selectedColor = await ZephyrThemeUtils.showColorPicker(
            context: context,
            initialColor: color,
            title: '选择$label',
          );
          if (selectedColor != null) {
            setState(() {
              _config[key] = selectedColor.value;
            });
          }
        },
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
