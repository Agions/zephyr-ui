// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

/// ZephyrUI 主题生成器
/// 
/// 功能：
/// - 自动生成主题文件
/// - 主题颜色配置
/// - 主题样式定制
/// - 主题导出
class ThemeGenerator {
  
  ThemeGenerator({required String outputDir}) : _outputDir = outputDir;
  final String _outputDir;
  
  /// 生成主题文件
  Future<void> generateTheme({
    required String themeName,
    required ThemeData baseTheme,
    Map<String, dynamic>? customColors,
    Map<String, dynamic>? customStyles,
  }) async {
    final themeData = _buildThemeData(
      themeName,
      baseTheme,
      customColors ?? {},
      customStyles ?? {},
    );
    
    await _saveThemeFile(themeName, themeData);
  }
  
  /// 生成主题配置文件
  Future<void> generateThemeConfig({
    required String themeName,
    required Map<String, dynamic> config,
  }) async {
    final configFile = File(path.join(_outputDir, '${themeName}_config.json'));
    await configFile.writeAsString(json.encode(config));
  }
  
  /// 生成主题预览文件
  Future<void> generateThemePreview(String themeName) async {
    final previewContent = _generateThemePreviewContent(themeName);
    final previewFile = File(path.join(_outputDir, '${themeName}_preview.dart'));
    await previewFile.writeAsString(previewContent);
  }
  
  /// 批量生成主题
  Future<void> generateThemes(List<ThemeConfig> configs) async {
    for (final config in configs) {
      await generateTheme(
        themeName: config.name,
        baseTheme: config.baseTheme,
        customColors: config.customColors,
        customStyles: config.customStyles,
      );
      
      await generateThemeConfig(
        themeName: config.name,
        config: config.config,
      );
      
      await generateThemePreview(config.name);
    }
  }
  
  /// 生成主题导出文件
  Future<void> generateThemeExport(List<String> themeNames) async {
    final exportContent = _generateThemeExportContent(themeNames);
    final exportFile = File(path.join(_outputDir, 'theme_export.dart'));
    await exportFile.writeAsString(exportContent);
  }
  
  Map<String, dynamic> _buildThemeData(
    String themeName,
    ThemeData baseTheme,
    Map<String, dynamic> customColors,
    Map<String, dynamic> customStyles,
  ) {
    final themeData = {
      'name': themeName,
      'colors': {
        'primary': baseTheme.colorScheme.primary.value,
        'primaryContainer': baseTheme.colorScheme.primaryContainer.value,
        'secondary': baseTheme.colorScheme.secondary.value,
        'secondaryContainer': baseTheme.colorScheme.secondaryContainer.value,
        'surface': baseTheme.colorScheme.surface.value,
        'error': baseTheme.colorScheme.error.value,
        'onPrimary': baseTheme.colorScheme.onPrimary.value,
        'onSecondary': baseTheme.colorScheme.onSecondary.value,
        'onSurface': baseTheme.colorScheme.onSurface.value,
        'onError': baseTheme.colorScheme.onError.value,
        ...customColors,
      },
      'styles': {
        'textTheme': {
          'displayLarge': _textStyleToMap(baseTheme.textTheme.displayLarge),
          'displayMedium': _textStyleToMap(baseTheme.textTheme.displayMedium),
          'displaySmall': _textStyleToMap(baseTheme.textTheme.displaySmall),
          'headlineLarge': _textStyleToMap(baseTheme.textTheme.headlineLarge),
          'headlineMedium': _textStyleToMap(baseTheme.textTheme.headlineMedium),
          'headlineSmall': _textStyleToMap(baseTheme.textTheme.headlineSmall),
          'titleLarge': _textStyleToMap(baseTheme.textTheme.titleLarge),
          'titleMedium': _textStyleToMap(baseTheme.textTheme.titleMedium),
          'titleSmall': _textStyleToMap(baseTheme.textTheme.titleSmall),
          'bodyLarge': _textStyleToMap(baseTheme.textTheme.bodyLarge),
          'bodyMedium': _textStyleToMap(baseTheme.textTheme.bodyMedium),
          'bodySmall': _textStyleToMap(baseTheme.textTheme.bodySmall),
          'labelLarge': _textStyleToMap(baseTheme.textTheme.labelLarge),
          'labelMedium': _textStyleToMap(baseTheme.textTheme.labelMedium),
          'labelSmall': _textStyleToMap(baseTheme.textTheme.labelSmall),
        },
        'elevatedButtonTheme': {
          'style': _buttonStyleToMap(baseTheme.elevatedButtonTheme.style),
        },
        'textButtonTheme': {
          'style': _buttonStyleToMap(baseTheme.textButtonTheme.style),
        },
        'outlinedButtonTheme': {
          'style': _buttonStyleToMap(baseTheme.outlinedButtonTheme.style),
        },
        'inputDecorationTheme': {
          'border': _inputBorderToMap(baseTheme.inputDecorationTheme.border),
          'focusedBorder': _inputBorderToMap(baseTheme.inputDecorationTheme.focusedBorder),
          'enabledBorder': _inputBorderToMap(baseTheme.inputDecorationTheme.enabledBorder),
          'errorBorder': _inputBorderToMap(baseTheme.inputDecorationTheme.errorBorder),
          'focusedErrorBorder': _inputBorderToMap(baseTheme.inputDecorationTheme.focusedErrorBorder),
        },
        ...customStyles,
      },
    };
    
    return themeData;
  }
  
  Future<void> _saveThemeFile(String themeName, Map<String, dynamic> themeData) async {
    final themeFile = File(path.join(_outputDir, '${themeName}_theme.dart'));
    final themeContent = _generateThemeContent(themeName, themeData);
    await themeFile.writeAsString(themeContent);
  }
  
  String _generateThemeContent(String themeName, Map<String, dynamic> themeData) {
    final colors = themeData['colors'] as Map<String, dynamic>;
    // ignore: unused_local_variable
    final styles = themeData['styles'] as Map<String, dynamic>;
    
    return '''
import 'package:flutter/material.dart';

/// $themeName 主题
/// 
/// 自动生成的主题文件
class ${_toPascalCase(themeName)}Theme {
  static const String name = '$themeName';
  
  // 颜色定义
  static const Color primary = Color(${colors['primary']});
  static const Color primaryContainer = Color(${colors['primaryContainer']});
  static const Color secondary = Color(${colors['secondary']});
  static const Color secondaryContainer = Color(${colors['secondaryContainer']});
  static const Color surface = Color(${colors['surface']});
  static const Color error = Color(${colors['error']});
  static const Color onPrimary = Color(${colors['onPrimary']});
  static const Color onSecondary = Color(${colors['onSecondary']});
  static const Color onSurface = Color(${colors['onSurface']});
  static const Color onError = Color(${colors['onError']});
  
  // 自定义颜色
${_generateCustomColors(colors)}
  
  // 主题数据
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      primary: primary,
      primaryContainer: primaryContainer,
      secondary: secondary,
      secondaryContainer: secondaryContainer,
      surface: surface,
      error: error,
      onPrimary: onPrimary,
      onSecondary: onSecondary,
      onSurface: onSurface,
      onError: onError,
      brightness: Brightness.light,
    ),
    textTheme: _buildTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: onPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: BorderSide(color: primary),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: error),
      ),
    ),
  );
  
  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
    );
  }
}
''';
  }
  
  String _generateCustomColors(Map<String, dynamic> colors) {
    final buffer = StringBuffer();
    final standardColors = {
      'primary', 'primaryVariant', 'secondary', 'secondaryVariant',
      'background', 'surface', 'error', 'onPrimary', 'onSecondary',
      'onBackground', 'onSurface', 'onError'
    };
    
    for (final entry in colors.entries) {
      if (!standardColors.contains(entry.key)) {
        buffer.writeln('  static const Color ${entry.key} = Color(${entry.value});');
      }
    }
    
    return buffer.toString();
  }
  
  String _generateThemePreviewContent(String themeName) {
    return '''
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class ${_toPascalCase(themeName)}ThemePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ${_toPascalCase(themeName)}Theme.theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${_toPascalCase(themeName)} Theme Preview'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Color Palette',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16),
              _buildColorPalette(),
              SizedBox(height: 32),
              Text(
                'Typography',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16),
              _buildTypography(),
              SizedBox(height: 32),
              Text(
                'Components',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16),
              _buildComponents(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildColorPalette() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildColorCard('Primary', ${_toPascalCase(themeName)}Theme.primary),
        _buildColorCard('Secondary', ${_toPascalCase(themeName)}Theme.secondary),
        _buildColorCard('Background', ${_toPascalCase(themeName)}Theme.background),
        _buildColorCard('Surface', ${_toPascalCase(themeName)}Theme.surface),
        _buildColorCard('Error', ${_toPascalCase(themeName)}Theme.error),
      ],
    );
  }
  
  Widget _buildColorCard(String label, Color color) {
    return Card(
      child: Container(
        width: 100,
        height: 100,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: _getContrastColor(color),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  Widget _buildTypography() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Headline 1', style: Theme.of(context).textTheme.headline1),
        Text('Headline 2', style: Theme.of(context).textTheme.headline2),
        Text('Headline 3', style: Theme.of(context).textTheme.headline3),
        Text('Headline 4', style: Theme.of(context).textTheme.headline4),
        Text('Headline 5', style: Theme.of(context).textTheme.headline5),
        Text('Headline 6', style: Theme.of(context).textTheme.headline6),
        Text('Body Text 1', style: Theme.of(context).textTheme.bodyText1),
        Text('Body Text 2', style: Theme.of(context).textTheme.bodyText2),
        Text('Caption', style: Theme.of(context).textTheme.caption),
      ],
    );
  }
  
  Widget _buildComponents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('Elevated Button'),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: Text('Text Button'),
        ),
        SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {},
          child: Text('Outlined Button'),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            labelText: 'Text Field',
            hintText: 'Enter text',
          ),
        ),
      ],
    );
  }
  
  Color _getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
''';
  }
  
  String _generateThemeExportContent(List<String> themeNames) {
    final buffer = StringBuffer();
    
    buffer.writeln('import \'package:flutter/material.dart\';');
    buffer.writeln();
    
    for (final themeName in themeNames) {
      buffer.writeln('import \'${themeName}_theme.dart\';');
    }
    
    buffer.writeln();
    buffer.writeln('/// 主题导出文件');
    buffer.writeln('class ThemeExport {');
    buffer.writeln('  static const Map<String, ThemeData> themes = {');
    
    for (final themeName in themeNames) {
      buffer.writeln('    \'$themeName\': ${_toPascalCase(themeName)}Theme.theme,');
    }
    
    buffer.writeln('  };');
    buffer.writeln();
    buffer.writeln('  static ThemeData? getTheme(String name) {');
    buffer.writeln('    return themes[name];');
    buffer.writeln('  }');
    buffer.writeln('}');
    
    return buffer.toString();
  }
  
  Map<String, dynamic> _textStyleToMap(TextStyle? style) {
    if (style == null) return {};
    
    return {
      'fontSize': style.fontSize,
      'fontWeight': style.fontWeight?.index,
      'color': style.color?.value,
      'backgroundColor': style.backgroundColor?.value,
      'letterSpacing': style.letterSpacing,
      'wordSpacing': style.wordSpacing,
      'height': style.height,
    };
  }
  
  Map<String, dynamic> _buttonStyleToMap(ButtonStyle? style) {
    if (style == null) return {};
    
    return {
      'backgroundColor': style.backgroundColor?.resolve({})?.value,
      'foregroundColor': style.foregroundColor?.resolve({})?.value,
      'overlayColor': style.overlayColor?.resolve({})?.value,
      'shadowColor': style.shadowColor?.resolve({})?.value,
      'elevation': style.elevation?.resolve({}),
      'padding': style.padding?.resolve({})?.toString(),
    };
  }
  
  Map<String, dynamic> _inputBorderToMap(InputBorder? border) {
    if (border == null) return {};
    
    if (border is OutlineInputBorder) {
      return {
        'type': 'outline',
        'borderRadius': border.borderRadius.toString(),
        'borderSide': {
          'color': border.borderSide.color.value,
          'width': border.borderSide.width,
        },
      };
    }
    
    return {};
  }
  
  String _toPascalCase(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }
}

/// 主题配置
class ThemeConfig {
  
  ThemeConfig({
    required this.name,
    required this.baseTheme,
    this.customColors = const {},
    this.customStyles = const {},
    this.config = const {},
  });
  final String name;
  final ThemeData baseTheme;
  final Map<String, dynamic> customColors;
  final Map<String, dynamic> customStyles;
  final Map<String, dynamic> config;
}