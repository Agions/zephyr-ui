library chroma_theme_data;

import 'package:flutter/material.dart';
import 'package:flutter_ui/src/core/theme/chroma_tokens.dart';

/// chromaUI 主题数据
class chromaThemeData {
  /// 创建主题数据
  const chromaThemeData({
    required this.brightness,
    required this.tokens,
  });

  /// 亮度模式
  final Brightness brightness;

  /// 设计令牌实例
  final chromaTokens tokens;

  /// 创建一个包含基础（默认）Token值的实例
  static final chromaTokens baseTokens = chromaTokens(
    colors: const chromaColors(
      primary: Color(0xFF007AFF),
      secondary: Color(0xFF6C757D),
      success: Color(0xFF28A745),
      warning: Color(0xFFFFC107),
      error: Color(0xFFDC3545),
      background: Color(0xFFFFFFFF),
      surface: Color(0xFFF8F9FA),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
    typography: const chromaTypography(
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16),
      caption: TextStyle(fontSize: 12),
    ),
    spacing: const chromaSpacing(
      xxs: 2.0,
      xs: 4.0,
      s: 8.0,
      m: 16.0,
      l: 24.0,
      xl: 32.0,
      xxl: 48.0,
    ),
    radii: const chromaRadii(
      s: Radius.circular(4.0),
      m: Radius.circular(8.0),
      l: Radius.circular(16.0),
      full: Radius.circular(9999.0),
    ),
    shadows: const chromaShadows(
      s: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      m: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      l: [BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, 8))],
    ),
    animations: const chromaAnimations(
      defaultCurve: Curves.easeInOut,
      defaultDuration: Duration(milliseconds: 250),
    ),
  );

  /// 创建浅色主题
  factory chromaThemeData.light() {
    return chromaThemeData(
      brightness: Brightness.light,
      tokens: baseTokens,
    );
  }

  /// 创建深色主题
  /// TODO: 为深色模式定义一套不同的Token值
  factory chromaThemeData.dark() {
    return chromaThemeData(
      brightness: Brightness.dark,
      // 暂时复用基础Token，后续需要为深色模式单独创建一套颜色Token
      tokens: baseTokens.copyWith(
        colors: baseTokens.colors.copyWith(
          background: const Color(0xFF121212),
          surface: const Color(0xFF1E1E1E),
          onPrimary: Colors.black,
          onSecondary: Colors.black,
        ),
      ),
    );
  }

  /// 创建副本并替换指定属性
  chromaThemeData copyWith({
    Brightness? brightness,
    chromaTokens? tokens,
  }) {
    return chromaThemeData(
      brightness: brightness ?? this.brightness,
      tokens: tokens ?? this.tokens,
    );
  }
}

// 为chromaTokens中的每个子类添加copyWith方法，以便于主题扩展
extension chromaTokensCopyWith on chromaTokens {
  chromaTokens copyWith({
    chromaColors? colors,
    chromaTypography? typography,
    chromaSpacing? spacing,
    chromaRadii? radii,
    chromaShadows? shadows,
    chromaAnimations? animations,
  }) {
    return chromaTokens(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radii: radii ?? this.radii,
      shadows: shadows ?? this.shadows,
      animations: animations ?? this.animations,
    );
  }
}

extension chromaColorsCopyWith on chromaColors {
  chromaColors copyWith({
    Color? primary,
    Color? secondary,
    Color? success,
    Color? warning,
    Color? error,
    Color? background,
    Color? surface,
    Color? onPrimary,
    Color? onSecondary,
  }) {
    return chromaColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecondary: onSecondary ?? this.onSecondary,
    );
  }
}
// 其他Token类的copyWith方法可以按需添加...
