/// ZephyrUI 主题配置
///
/// 提供预定义主题配置和主题工厂方法
library theme_configurations;

import 'package:flutter/material.dart';
import 'unified_theme_data.dart';
import 'design_tokens.dart';

/// 主题配置类
class ZephyrThemeConfigurations {
  ZephyrThemeConfigurations._();

  /// 预定义主题配置
  static const Map<String, ZephyrThemePreset> presets = {
    'default': ZephyrThemePreset(
      name: '默认',
      description: '默认的 ZephyrUI 主题',
      primaryColor: ZephyrColorTokens.primary60,
      secondaryColor: ZephyrColorTokens.secondary60,
      brightness: Brightness.light,
    ),
    'dark': ZephyrThemePreset(
      name: '深色',
      description: '深色主题，适合夜间使用',
      primaryColor: ZephyrColorTokens.primary80,
      secondaryColor: ZephyrColorTokens.secondary80,
      brightness: Brightness.dark,
    ),
    'blue': ZephyrThemePreset(
      name: '蓝色',
      description: '以蓝色为主调的专业主题',
      primaryColor: ZephyrColorTokens.primary60,
      secondaryColor: ZephyrColorTokens.primary40,
      brightness: Brightness.light,
    ),
    'green': ZephyrThemePreset(
      name: '绿色',
      description: '自然清新的绿色主题',
      primaryColor: ZephyrColorTokens.success50,
      secondaryColor: ZephyrColorTokens.success30,
      brightness: Brightness.light,
    ),
    'purple': ZephyrThemePreset(
      name: '紫色',
      description: '优雅的紫色主题',
      primaryColor: Color(0xFF9C27B0),
      secondaryColor: Color(0xFFBA68C8),
      brightness: Brightness.light,
    ),
    'orange': ZephyrThemePreset(
      name: '橙色',
      description: '活力四射的橙色主题',
      primaryColor: ZephyrColorTokens.warning50,
      secondaryColor: ZephyrColorTokens.warning30,
      brightness: Brightness.light,
    ),
    'teal': ZephyrThemePreset(
      name: '青色',
      description: '现代感的青色主题',
      primaryColor: ZephyrColorTokens.info50,
      secondaryColor: ZephyrColorTokens.info30,
      brightness: Brightness.light,
    ),
    'corporate': ZephyrThemePreset(
      name: '企业',
      description: '专业的企业级主题',
      primaryColor: Color(0xFF1565C0),
      secondaryColor: Color(0xFF37474F),
      brightness: Brightness.light,
    ),
    'modern': ZephyrThemePreset(
      name: '现代',
      description: '现代简约的设计主题',
      primaryColor: Color(0xFF6366F1),
      secondaryColor: Color(0xFF8B5CF6),
      brightness: Brightness.light,
    ),
    'nature': ZephyrThemePreset(
      name: '自然',
      description: '自然环保的主题',
      primaryColor: ZephyrColorTokens.success50,
      secondaryColor: ZephyrColorTokens.success30,
      brightness: Brightness.light,
    ),
  };

  /// 企业主题配置
  static const Map<String, ZephyrEnterpriseTheme> enterpriseThemes = {
    'technology': ZephyrEnterpriseTheme(
      name: '科技',
      description: '科技公司的专业主题',
      primaryColor: Color(0xFF1565C0),
      secondaryColor: Color(0xFF37474F),
      accentColor: Color(0xFF00BCD4),
      fontFamily: 'Roboto',
    ),
    'finance': ZephyrEnterpriseTheme(
      name: '金融',
      description: '金融机构的稳重主题',
      primaryColor: Color(0xFF2E7D32),
      secondaryColor: Color(0xFF1976D2),
      accentColor: Color(0xFFD32F2F),
      fontFamily: 'Roboto',
    ),
    'healthcare': ZephyrEnterpriseTheme(
      name: '医疗',
      description: '医疗健康的专业主题',
      primaryColor: Color(0xFF1976D2),
      secondaryColor: Color(0xFF388E3C),
      accentColor: Color(0xFFD32F2F),
      fontFamily: 'Roboto',
    ),
    'education': ZephyrEnterpriseTheme(
      name: '教育',
      description: '教育机构的清新主题',
      primaryColor: Color(0xFF1976D2),
      secondaryColor: Color(0xFF7B1FA2),
      accentColor: Color(0xFF388E3C),
      fontFamily: 'Roboto',
    ),
    'retail': ZephyrEnterpriseTheme(
      name: '零售',
      description: '零售行业的活泼主题',
      primaryColor: Color(0xFFFF5722),
      secondaryColor: Color(0xFF4CAF50),
      accentColor: Color(0xFF2196F3),
      fontFamily: 'Roboto',
    ),
  };

  /// 特殊用途主题配置
  static const Map<String, ZephyrSpecialTheme> specialThemes = {
    'accessibility': ZephyrSpecialTheme(
      name: '无障碍',
      description: '高对比度的无障碍主题',
      highContrast: true,
      largeText: true,
      reducedMotion: true,
    ),
    'minimal': ZephyrSpecialTheme(
      name: '极简',
      description: '极简主义设计主题',
      minimalColors: true,
      reducedMotion: true,
    ),
    'vibrant': ZephyrSpecialTheme(
      name: '鲜艳',
      description: '色彩鲜艳的活泼主题',
      vibrantColors: true,
      enhancedAnimations: true,
    ),
  };

  /// 创建预设主题
  static ZephyrUnifiedThemeData createPresetTheme(String presetName) {
    final preset = presets[presetName];
    if (preset == null) {
      throw ArgumentError('Unknown preset: $presetName');
    }

    if (preset.brightness == Brightness.light) {
      return ZephyrUnifiedThemeData.light(
        primaryColor: preset.primaryColor,
        secondaryColor: preset.secondaryColor,
      );
    } else {
      return ZephyrUnifiedThemeData.dark(
        primaryColor: preset.primaryColor,
        secondaryColor: preset.secondaryColor,
      );
    }
  }

  /// 创建企业主题
  static ZephyrUnifiedThemeData createEnterpriseTheme(String themeName) {
    final theme = enterpriseThemes[themeName];
    if (theme == null) {
      throw ArgumentError('Unknown enterprise theme: $themeName');
    }

    return ZephyrUnifiedThemeData.light(
      primaryColor: theme.primaryColor,
      secondaryColor: theme.secondaryColor,
      fontFamily: theme.fontFamily,
    );
  }

  /// 创建特殊主题
  static ZephyrUnifiedThemeData createSpecialTheme(String themeName) {
    final theme = specialThemes[themeName];
    if (theme == null) {
      throw ArgumentError('Unknown special theme: $themeName');
    }

    ZephyrUnifiedThemeData baseTheme;

    switch (themeName) {
      case 'accessibility':
        baseTheme = ZephyrUnifiedThemeData.light(
          primaryColor: Colors.black,
          secondaryColor: Colors.white,
        );
        break;
      case 'minimal':
        baseTheme = ZephyrUnifiedThemeData.light(
          primaryColor: Colors.grey[800]!,
          secondaryColor: Colors.grey[600]!,
        );
        break;
      case 'vibrant':
        baseTheme = ZephyrUnifiedThemeData.light(
          primaryColor: Colors.pink[500]!,
          secondaryColor: Colors.orange[500]!,
        );
        break;
      default:
        baseTheme = ZephyrUnifiedThemeData.light();
    }

    return baseTheme;
  }

  /// 从配置创建主题
  static ZephyrUnifiedThemeData createThemeFromConfig(
      ZephyrThemeConfig config) {
    if (config.brightness == Brightness.light) {
      return ZephyrUnifiedThemeData.light(
        primaryColor: config.primaryColor,
        secondaryColor: config.secondaryColor,
        fontFamily: config.fontFamily,
      );
    } else {
      return ZephyrUnifiedThemeData.dark(
        primaryColor: config.primaryColor,
        secondaryColor: config.secondaryColor,
        fontFamily: config.fontFamily,
      );
    }
  }

  /// 创建自适应主题
  static ZephyrUnifiedThemeData createAdaptiveTheme({
    required Brightness brightness,
    Color? primaryColor,
    Color? secondaryColor,
    String? fontFamily,
    bool? highContrast,
    bool? largeText,
    bool? reducedMotion,
  }) {
    // 基础主题创建
    ZephyrUnifiedThemeData theme;

    if (brightness == Brightness.light) {
      theme = ZephyrUnifiedThemeData.light(
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        fontFamily: fontFamily,
      );
    } else {
      theme = ZephyrUnifiedThemeData.dark(
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        fontFamily: fontFamily,
      );
    }

    // 应用自适应设置
    if (highContrast == true) {
      theme = _applyHighContrast(theme);
    }

    if (largeText == true) {
      theme = _applyLargeText(theme);
    }

    if (reducedMotion == true) {
      theme = _applyReducedMotion(theme);
    }

    return theme;
  }

  /// 应用高对比度
  static ZephyrUnifiedThemeData _applyHighContrast(
      ZephyrUnifiedThemeData theme) {
    final colorScheme = theme.colorScheme.copyWith(
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.black,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    );

    return theme.copyWith(colorScheme: colorScheme);
  }

  /// 应用大字体
  static ZephyrUnifiedThemeData _applyLargeText(ZephyrUnifiedThemeData theme) {
    final textTheme = theme.textTheme.copyWith(
      displayLarge: theme.textTheme.displayLarge?.copyWith(fontSize: 64),
      displayMedium: theme.textTheme.displayMedium?.copyWith(fontSize: 48),
      displaySmall: theme.textTheme.displaySmall?.copyWith(fontSize: 40),
      headlineLarge: theme.textTheme.headlineLarge?.copyWith(fontSize: 32),
      headlineMedium: theme.textTheme.headlineMedium?.copyWith(fontSize: 28),
      headlineSmall: theme.textTheme.headlineSmall?.copyWith(fontSize: 24),
      titleLarge: theme.textTheme.titleLarge?.copyWith(fontSize: 22),
      titleMedium: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
      titleSmall: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
      bodyLarge: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
      bodyMedium: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
      bodySmall: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
      labelLarge: theme.textTheme.labelLarge?.copyWith(fontSize: 16),
      labelMedium: theme.textTheme.labelMedium?.copyWith(fontSize: 14),
      labelSmall: theme.textTheme.labelSmall?.copyWith(fontSize: 12),
    );

    return theme.copyWith(textTheme: textTheme);
  }

  /// 应用减少动画
  static ZephyrUnifiedThemeData _applyReducedMotion(
      ZephyrUnifiedThemeData theme) {
    final animation = ZephyrAnimationTokens();

    // 这里可以添加减少动画的逻辑
    // 实际实现可能需要修改动画配置

    return theme.copyWith(animation: animation);
  }

  /// 获取所有预设主题名称
  static List<String> getPresetNames() {
    return presets.keys.toList();
  }

  /// 获取所有企业主题名称
  static List<String> getEnterpriseThemeNames() {
    return enterpriseThemes.keys.toList();
  }

  /// 获取所有特殊主题名称
  static List<String> getSpecialThemeNames() {
    return specialThemes.keys.toList();
  }

  /// 验证主题配置
  static bool validateThemeConfig(ZephyrThemeConfig config) {
    try {
      // 验证颜色
      if (config.primaryColor.toARGB32() == 0) return false;
      if (config.secondaryColor.toARGB32() == 0) return false;

      // 验证字体
      if (config.fontFamily?.isEmpty == true) return false;

      return true;
    } catch (e) {
      return false;
    }
  }

  /// 导出主题配置
  static Map<String, dynamic> exportThemeConfig(ZephyrUnifiedThemeData theme) {
    return {
      'brightness': theme.brightness.name,
      'primaryColor': theme.colorScheme.primary.value,
      'secondaryColor': theme.colorScheme.secondary.value,
      'tertiaryColor': theme.colorScheme.tertiary.value,
      'errorColor': theme.colorScheme.error.value,
      'fontFamily': theme.textTheme.bodyLarge?.fontFamily,
    };
  }

  /// 导入主题配置
  static ZephyrThemeConfig importThemeConfig(Map<String, dynamic> config) {
    return ZephyrThemeConfig(
      brightness: Brightness.values.firstWhere(
        (b) => b.name == config['brightness'],
        orElse: () => Brightness.light,
      ),
      primaryColor:
          Color(config['primaryColor'] ?? ZephyrColorTokens.primary60.value),
      secondaryColor: Color(
          config['secondaryColor'] ?? ZephyrColorTokens.secondary60.value),
      fontFamily: config['fontFamily'],
    );
  }
}

/// 主题预设配置
class ZephyrThemePreset {
  const ZephyrThemePreset({
    required this.name,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
    required this.brightness,
  });

  final String name;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;
  final Brightness brightness;
}

/// 企业主题配置
class ZephyrEnterpriseTheme {
  const ZephyrEnterpriseTheme({
    required this.name,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.fontFamily,
  });

  final String name;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final String fontFamily;
}

/// 特殊主题配置
class ZephyrSpecialTheme {
  const ZephyrSpecialTheme({
    required this.name,
    required this.description,
    this.highContrast = false,
    this.largeText = false,
    this.rucedMotion = false,
    this.minimalColors = false,
    this.vibrantColors = false,
    this.enhancedAnimations = false,
  });

  final String name;
  final String description;
  final bool highContrast;
  final bool largeText;
  final bool reducedMotion;
  final bool minimalColors;
  final bool vibrantColors;
  final bool enhancedAnimations;
}

/// 主题配置类
class ZephyrThemeConfig {
  const ZephyrThemeConfig({
    required this.brightness,
    required this.primaryColor,
    required this.secondaryColor,
    this.fontFamily,
    this.customExtensions,
  });

  final Brightness brightness;
  final Color primaryColor;
  final Color secondaryColor;
  final String? fontFamily;
  final Map<Type, ThemeExtension<dynamic>>? customExtensions;

  ZephyrThemeConfig copyWith({
    Brightness? brightness,
    Color? primaryColor,
    Color? secondaryColor,
    String? fontFamily,
    Map<Type, ThemeExtension<dynamic>>? customExtensions,
  }) {
    return ZephyrThemeConfig(
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      fontFamily: fontFamily ?? this.fontFamily,
      customExtensions: customExtensions ?? this.customExtensions,
    );
  }
}
