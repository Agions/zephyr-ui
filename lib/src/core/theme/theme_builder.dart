/// ZephyrUI 统一主题构建器
///
/// 提供统一的主题构建和管理功能，整合所有设计令牌和主题配置
library theme_builder;

import 'package:flutter/material.dart';
import 'design_tokens.dart';
import 'theme_extensions.dart';

/// ZephyrUI 主题构建器
class ZephyrThemeBuilder {
  /// 构建亮色主题
  static ThemeData buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _buildLightColorScheme(),
      textTheme: _buildLightTextTheme(),
      appBarTheme: _buildLightAppBarTheme(),
      elevatedButtonTheme: _buildLightElevatedButtonTheme(),
      outlinedButtonTheme: _buildLightOutlinedButtonTheme(),
      textButtonTheme: _buildLightTextButtonTheme(),
      inputDecorationTheme: _buildLightInputDecorationTheme(),
      cardTheme: _buildLightCardTheme(),
      dividerTheme: _buildLightDividerTheme(),
      extensions: <ThemeExtension<dynamic>>[
        ZephyrColorsExtension.light,
        ZephyrSpacingExtension.light,
        ZephyrTypographyExtension.light,
        ZephyrBorderRadiusExtension.light,
        ZephyrShadowExtension.light,
        ZephyrAnimationExtension.light,
      ],
    );
  }

  /// 构建暗色主题
  static ThemeData buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _buildDarkColorScheme(),
      textTheme: _buildDarkTextTheme(),
      appBarTheme: _buildDarkAppBarTheme(),
      elevatedButtonTheme: _buildDarkElevatedButtonTheme(),
      outlinedButtonTheme: _buildDarkOutlinedButtonTheme(),
      textButtonTheme: _buildDarkTextButtonTheme(),
      inputDecorationTheme: _buildDarkInputDecorationTheme(),
      cardTheme: _buildDarkCardTheme(),
      dividerTheme: _buildDarkDividerTheme(),
      extensions: <ThemeExtension<dynamic>>[
        ZephyrColorsExtension.dark,
        ZephyrSpacingExtension.dark,
        ZephyrTypographyExtension.dark,
        ZephyrBorderRadiusExtension.dark,
        ZephyrShadowExtension.dark,
        ZephyrAnimationExtension.dark,
      ],
    );
  }

  /// 构建亮色配色方案
  static ColorScheme _buildLightColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: ZephyrColorTokens.primary50,
      onPrimary: ZephyrColorTokens.primary100,
      primaryContainer: ZephyrColorTokens.primary90,
      onPrimaryContainer: ZephyrColorTokens.primary10,
      secondary: ZephyrColorTokens.secondary50,
      onSecondary: ZephyrColorTokens.neutral0,
      secondaryContainer: ZephyrColorTokens.secondary90,
      onSecondaryContainer: ZephyrColorTokens.neutral90,
      tertiary: ZephyrColorTokens.success50,
      onTertiary: ZephyrColorTokens.neutral0,
      tertiaryContainer: ZephyrColorTokens.success90,
      onTertiaryContainer: ZephyrColorTokens.neutral90,
      error: ZephyrColorTokens.error50,
      onError: ZephyrColorTokens.neutral0,
      errorContainer: ZephyrColorTokens.error90,
      onErrorContainer: ZephyrColorTokens.neutral90,
      background: ZephyrColorTokens.neutral0,
      onBackground: ZephyrColorTokens.neutral90,
      surface: ZephyrColorTokens.neutral0,
      onSurface: ZephyrColorTokens.neutral90,
      surfaceVariant: ZephyrColorTokens.neutral30,
      onSurfaceVariant: ZephyrColorTokens.neutral80,
      outline: ZephyrColorTokens.neutral60,
      outlineVariant: ZephyrColorTokens.neutral40,
      shadow: ZephyrColorTokens.neutral0,
      scrim: ZephyrColorTokens.neutral0,
      inverseSurface: ZephyrColorTokens.neutral90,
      onInverseSurface: ZephyrColorTokens.neutral0,
      inversePrimary: ZephyrColorTokens.primary80,
    );
  }

  /// 构建暗色配色方案
  static ColorScheme _buildDarkColorScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: ZephyrColorTokens.primary80,
      onPrimary: ZephyrColorTokens.neutral0,
      primaryContainer: ZephyrColorTokens.primary30,
      onPrimaryContainer: ZephyrColorTokens.neutral30,
      secondary: ZephyrColorTokens.secondary90,
      onSecondary: ZephyrColorTokens.neutral0,
      secondaryContainer: ZephyrColorTokens.secondary30,
      onSecondaryContainer: ZephyrColorTokens.neutral30,
      tertiary: ZephyrColorTokens.success90,
      onTertiary: ZephyrColorTokens.neutral0,
      tertiaryContainer: ZephyrColorTokens.success30,
      onTertiaryContainer: ZephyrColorTokens.neutral30,
      error: ZephyrColorTokens.error90,
      onError: ZephyrColorTokens.neutral0,
      errorContainer: ZephyrColorTokens.error30,
      onErrorContainer: ZephyrColorTokens.neutral30,
      background: ZephyrColorTokens.neutral0,
      onBackground: ZephyrColorTokens.neutral30,
      surface: ZephyrColorTokens.neutral90,
      onSurface: ZephyrColorTokens.neutral30,
      surfaceVariant: ZephyrColorTokens.neutral80,
      onSurfaceVariant: ZephyrColorTokens.neutral30,
      outline: ZephyrColorTokens.neutral50,
      outlineVariant: ZephyrColorTokens.neutral30,
      shadow: ZephyrColorTokens.neutral0,
      scrim: ZephyrColorTokens.neutral0,
      inverseSurface: ZephyrColorTokens.neutral30,
      onInverseSurface: ZephyrColorTokens.neutral90,
      inversePrimary: ZephyrColorTokens.primary30,
    );
  }

  /// 构建亮色文本主题
  static TextTheme _buildLightTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: ZephyrTypographyTokens.displayLarge,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      displayMedium: TextStyle(
        fontSize: ZephyrTypographyTokens.displayMedium,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      displaySmall: TextStyle(
        fontSize: ZephyrTypographyTokens.displayMedium,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      headlineLarge: TextStyle(
        fontSize: ZephyrTypographyTokens.displaySmall,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      headlineMedium: TextStyle(
        fontSize: ZephyrTypographyTokens.headlineLarge,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      headlineSmall: TextStyle(
        fontSize: ZephyrTypographyTokens.headlineMedium,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      titleLarge: TextStyle(
        fontSize: ZephyrTypographyTokens.titleLarge,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      titleMedium: TextStyle(
        fontSize: ZephyrTypographyTokens.bodyLarge,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      titleSmall: TextStyle(
        fontSize: ZephyrTypographyTokens.bodyMedium,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      bodyLarge: TextStyle(
        fontSize: ZephyrTypographyTokens.titleLarge,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      bodyMedium: TextStyle(
        fontSize: ZephyrTypographyTokens.bodyLarge,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      bodySmall: TextStyle(
        fontSize: ZephyrTypographyTokens.bodyMedium,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      labelLarge: TextStyle(
        fontSize: ZephyrTypographyTokens.bodyMedium,
        fontWeight: ZephyrTypographyTokens.weightMedium,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      labelMedium: TextStyle(
        fontSize: ZephyrTypographyTokens.bodySmall,
        fontWeight: ZephyrTypographyTokens.weightMedium,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
      labelSmall: TextStyle(
        fontSize: ZephyrTypographyTokens.bodySmall,
        fontWeight: ZephyrTypographyTokens.weightMedium,
        height: ZephyrTypographyTokens.lineHeightNormal,
        color: ZephyrColorTokens.neutral90,
      ),
    );
  }

  /// 构建暗色文本主题
  static TextTheme _buildDarkTextTheme() {
    return _buildLightTextTheme().copyWith(
      displayLarge: TextStyle(color: ZephyrColorTokens.neutral30),
      displayMedium: TextStyle(color: ZephyrColorTokens.neutral30),
      displaySmall: TextStyle(color: ZephyrColorTokens.neutral30),
      headlineLarge: TextStyle(color: ZephyrColorTokens.neutral30),
      headlineMedium: TextStyle(color: ZephyrColorTokens.neutral30),
      headlineSmall: TextStyle(color: ZephyrColorTokens.neutral30),
      titleLarge: TextStyle(color: ZephyrColorTokens.neutral30),
      titleMedium: TextStyle(color: ZephyrColorTokens.neutral30),
      titleSmall: TextStyle(color: ZephyrColorTokens.neutral30),
      bodyLarge: TextStyle(color: ZephyrColorTokens.neutral30),
      bodyMedium: TextStyle(color: ZephyrColorTokens.neutral30),
      bodySmall: TextStyle(color: ZephyrColorTokens.neutral30),
      labelLarge: TextStyle(color: ZephyrColorTokens.neutral30),
      labelMedium: TextStyle(color: ZephyrColorTokens.neutral30),
      labelSmall: TextStyle(color: ZephyrColorTokens.neutral30),
    );
  }

  /// 构建亮色应用栏主题
  static AppBarTheme _buildLightAppBarTheme() {
    return AppBarTheme(
      backgroundColor: ZephyrColorTokens.neutral0,
      foregroundColor: ZephyrColorTokens.neutral90,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: ZephyrTypographyTokens.titleLarge,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        color: ZephyrColorTokens.neutral90,
      ),
      iconTheme: IconThemeData(
        color: ZephyrColorTokens.neutral90,
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: ZephyrColorTokens.neutral90,
        size: 24,
      ),
    );
  }

  /// 构建暗色应用栏主题
  static AppBarTheme _buildDarkAppBarTheme() {
    return AppBarTheme(
      backgroundColor: ZephyrColorTokens.neutral90,
      foregroundColor: ZephyrColorTokens.neutral30,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: ZephyrTypographyTokens.titleLarge,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        color: ZephyrColorTokens.neutral30,
      ),
      iconTheme: IconThemeData(
        color: ZephyrColorTokens.neutral30,
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: ZephyrColorTokens.neutral30,
        size: 24,
      ),
    );
  }

  /// 构建亮色凸起按钮主题
  static ElevatedButtonThemeData _buildLightElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ZephyrColorTokens.primary50,
        foregroundColor: ZephyrColorTokens.neutral0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ZephyrSpacingTokens.large,
          vertical: ZephyrSpacingTokens.medium,
        ),
        textStyle: TextStyle(
          fontSize: ZephyrTypographyTokens.bodyLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
        ),
      ),
    );
  }

  /// 构建暗色凸起按钮主题
  static ElevatedButtonThemeData _buildDarkElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ZephyrColorTokens.primary80,
        foregroundColor: ZephyrColorTokens.neutral0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ZephyrSpacingTokens.large,
          vertical: ZephyrSpacingTokens.medium,
        ),
        textStyle: TextStyle(
          fontSize: ZephyrTypographyTokens.bodyLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
        ),
      ),
    );
  }

  /// 构建亮色轮廓按钮主题
  static OutlinedButtonThemeData _buildLightOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ZephyrColorTokens.primary50,
        side: BorderSide(
          color: ZephyrColorTokens.primary50,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ZephyrSpacingTokens.large,
          vertical: ZephyrSpacingTokens.medium,
        ),
        textStyle: TextStyle(
          fontSize: ZephyrTypographyTokens.bodyLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
        ),
      ),
    );
  }

  /// 构建暗色轮廓按钮主题
  static OutlinedButtonThemeData _buildDarkOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ZephyrColorTokens.primary80,
        side: BorderSide(
          color: ZephyrColorTokens.primary80,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ZephyrSpacingTokens.large,
          vertical: ZephyrSpacingTokens.medium,
        ),
        textStyle: TextStyle(
          fontSize: ZephyrTypographyTokens.bodyLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
        ),
      ),
    );
  }

  /// 构建亮色文本按钮主题
  static TextButtonThemeData _buildLightTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ZephyrColorTokens.primary50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ZephyrSpacingTokens.large,
          vertical: ZephyrSpacingTokens.medium,
        ),
        textStyle: TextStyle(
          fontSize: ZephyrTypographyTokens.bodyLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
        ),
      ),
    );
  }

  /// 构建暗色文本按钮主题
  static TextButtonThemeData _buildDarkTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ZephyrColorTokens.primary80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ZephyrSpacingTokens.large,
          vertical: ZephyrSpacingTokens.medium,
        ),
        textStyle: TextStyle(
          fontSize: ZephyrTypographyTokens.bodyLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
        ),
      ),
    );
  }

  /// 构建亮色输入装饰主题
  static InputDecorationTheme _buildLightInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: ZephyrColorTokens.neutral30,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.neutral40,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.neutral40,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.primary50,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.error50,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.error50,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.neutral60,
          width: 1,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacingTokens.medium,
        vertical: ZephyrSpacingTokens.medium,
      ),
      hintStyle: TextStyle(
        color: ZephyrColorTokens.neutral60,
        fontSize: ZephyrTypographyTokens.bodyLarge,
      ),
      labelStyle: TextStyle(
        color: ZephyrColorTokens.neutral80,
        fontSize: ZephyrTypographyTokens.bodyMedium,
        fontWeight: ZephyrTypographyTokens.weightMedium,
      ),
      errorStyle: TextStyle(
        color: ZephyrColorTokens.error50,
        fontSize: ZephyrTypographyTokens.bodySmall,
      ),
    );
  }

  /// 构建暗色输入装饰主题
  static InputDecorationTheme _buildDarkInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: ZephyrColorTokens.neutral80,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.neutral60,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.neutral60,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.primary80,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.error90,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.error90,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
        borderSide: BorderSide(
          color: ZephyrColorTokens.neutral20,
          width: 1,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacingTokens.medium,
        vertical: ZephyrSpacingTokens.medium,
      ),
      hintStyle: TextStyle(
        color: ZephyrColorTokens.neutral50,
        fontSize: ZephyrTypographyTokens.bodyLarge,
      ),
      labelStyle: TextStyle(
        color: ZephyrColorTokens.neutral30,
        fontSize: ZephyrTypographyTokens.bodyMedium,
        fontWeight: ZephyrTypographyTokens.weightMedium,
      ),
      errorStyle: TextStyle(
        color: ZephyrColorTokens.error90,
        fontSize: ZephyrTypographyTokens.bodySmall,
      ),
    );
  }

  /// 构建亮色卡片主题
  static CardTheme _buildLightCardTheme() {
    return CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.large),
      ),
      color: ZephyrColorTokens.neutral0,
      shadowColor: ZephyrColorTokens.neutral0,
      margin: EdgeInsets.zero,
    );
  }

  /// 构建暗色卡片主题
  static CardTheme _buildDarkCardTheme() {
    return CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.large),
      ),
      color: ZephyrColorTokens.neutral80,
      shadowColor: ZephyrColorTokens.neutral0,
      margin: EdgeInsets.zero,
    );
  }

  /// 构建亮色分割线主题
  static DividerThemeData _buildLightDividerTheme() {
    return DividerThemeData(
      color: ZephyrColorTokens.neutral40,
      thickness: 1,
      space: 1,
      indent: 0,
      endIndent: 0,
    );
  }

  /// 构建暗色分割线主题
  static DividerThemeData _buildDarkDividerTheme() {
    return DividerThemeData(
      color: ZephyrColorTokens.neutral60,
      thickness: 1,
      space: 1,
      indent: 0,
      endIndent: 0,
    );
  }
}