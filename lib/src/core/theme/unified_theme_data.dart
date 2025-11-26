/// ZephyrUI 统一主题数据结构
///
/// 基于 Material Design 3 的统一主题系统
library unified_theme_data;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import 'design_tokens.dart';
import 'theme_extension.dart';

/// 统一主题数据结构
class ZephyrUnifiedThemeData {
  const ZephyrUnifiedThemeData({
    required this.brightness,
    required this.colorScheme,
    required this.textTheme,
    required this.appBarTheme,
    required this.cardTheme,
    required this.chipTheme,
    required this.elevatedButtonTheme,
    required this.filledButtonTheme,
    required this.outlinedButtonTheme,
    required this.textButtonTheme,
    required this.inputDecorationTheme,
    required this.dividerTheme,
    required this.iconTheme,
    required this.badgeTheme,
    required this.extensions,
    required this.spacing,
    required this.animation,
  });

  /// 创建浅色主题
  factory ZephyrUnifiedThemeData.light({
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? errorColor,
    String? fontFamily,
    Map<Type, ThemeExtension<dynamic>>? extensions,
  }) {
    final primary = primaryColor ?? ZephyrColorTokens.primary60;
    final secondary = secondaryColor ?? ZephyrColorTokens.secondary60;
    final tertiary = tertiaryColor ?? ZephyrColorTokens.primary40;
    final error = errorColor ?? ZephyrColorTokens.error50;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      error: error,
      surface: ZephyrColorTokens.neutral98,
      onSurface: ZephyrColorTokens.neutral10,
      surfaceVariant: ZephyrColorTokens.neutral90,
      onSurfaceVariant: ZephyrColorTokens.neutral30,
      outline: ZephyrColorTokens.neutral40,
      outlineVariant: ZephyrColorTokens.neutral80,
      shadow: ZephyrColorTokens.neutral0,
      scrim: ZephyrColorTokens.neutral0,
      inverseSurface: ZephyrColorTokens.neutral20,
      onInverseSurface: ZephyrColorTokens.neutral95,
      inversePrimary: ZephyrColorTokens.primary80,
    );

    return ZephyrUnifiedThemeData(
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: _createTextTheme(Brightness.light, fontFamily),
      appBarTheme: _createAppBarTheme(Brightness.light, colorScheme),
      cardTheme: _createCardTheme(Brightness.light, colorScheme),
      chipTheme: _createChipTheme(Brightness.light, colorScheme),
      elevatedButtonTheme:
          _createElevatedButtonTheme(Brightness.light, colorScheme),
      filledButtonTheme:
          _createFilledButtonTheme(Brightness.light, colorScheme),
      outlinedButtonTheme:
          _createOutlinedButtonTheme(Brightness.light, colorScheme),
      textButtonTheme: _createTextButtonTheme(Brightness.light, colorScheme),
      inputDecorationTheme:
          _createInputDecorationTheme(Brightness.light, colorScheme),
      dividerTheme: _createDividerTheme(Brightness.light),
      iconTheme: _createIconTheme(Brightness.light, colorScheme),
      badgeTheme: _createBadgeTheme(Brightness.light, error),
      extensions: extensions ?? _createDefaultExtensions(Brightness.light),
      spacing: ZephyrSpacingTokens(),
      animation: ZephyrAnimationTokens(),
    );
  }

  /// 创建深色主题
  factory ZephyrUnifiedThemeData.dark({
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? errorColor,
    String? fontFamily,
    Map<Type, ThemeExtension<dynamic>>? extensions,
  }) {
    final primary = primaryColor ?? ZephyrColorTokens.primary80;
    final secondary = secondaryColor ?? ZephyrColorTokens.secondary80;
    final tertiary = tertiaryColor ?? ZephyrColorTokens.primary60;
    final error = errorColor ?? ZephyrColorTokens.error60;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      error: error,
      surface: ZephyrColorTokens.neutral6,
      onSurface: ZephyrColorTokens.neutral90,
      surfaceVariant: ZephyrColorTokens.neutral30,
      onSurfaceVariant: ZephyrColorTokens.neutral80,
      outline: ZephyrColorTokens.neutral60,
      outlineVariant: ZephyrColorTokens.neutral30,
      shadow: ZephyrColorTokens.neutral0,
      scrim: ZephyrColorTokens.neutral0,
      inverseSurface: ZephyrColorTokens.neutral90,
      onInverseSurface: ZephyrColorTokens.neutral10,
      inversePrimary: ZephyrColorTokens.primary40,
    );

    return ZephyrUnifiedThemeData(
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: _createTextTheme(Brightness.dark, fontFamily),
      appBarTheme: _createAppBarTheme(Brightness.dark, colorScheme),
      cardTheme: _createCardTheme(Brightness.dark, colorScheme),
      chipTheme: _createChipTheme(Brightness.dark, colorScheme),
      elevatedButtonTheme:
          _createElevatedButtonTheme(Brightness.dark, colorScheme),
      filledButtonTheme: _createFilledButtonTheme(Brightness.dark, colorScheme),
      outlinedButtonTheme:
          _createOutlinedButtonTheme(Brightness.dark, colorScheme),
      textButtonTheme: _createTextButtonTheme(Brightness.dark, colorScheme),
      inputDecorationTheme:
          _createInputDecorationTheme(Brightness.dark, colorScheme),
      dividerTheme: _createDividerTheme(Brightness.dark),
      iconTheme: _createIconTheme(Brightness.dark, colorScheme),
      badgeTheme: _createBadgeTheme(Brightness.dark, error),
      extensions: extensions ?? _createDefaultExtensions(Brightness.dark),
      spacing: ZephyrSpacingTokens(),
      animation: ZephyrAnimationTokens(),
    );
  }

  /// 亮度模式
  final Brightness brightness;

  /// 颜色方案
  final ColorScheme colorScheme;

  /// 文本主题
  final TextTheme textTheme;

  /// 应用栏主题
  final AppBarTheme appBarTheme;

  /// 卡片主题
  final CardTheme cardTheme;

  /// 芯片主题
  final ChipThemeData chipTheme;

  /// 按钮主题
  final ElevatedButtonThemeData elevatedButtonTheme;
  final FilledButtonThemeData filledButtonTheme;
  final OutlinedButtonThemeData outlinedButtonTheme;
  final TextButtonThemeData textButtonTheme;

  /// 输入装饰主题
  final InputDecorationTheme inputDecorationTheme;

  /// 分割线主题
  final DividerThemeData dividerTheme;

  /// 图标主题
  final IconThemeData iconTheme;

  /// 徽章主题
  final ZephyrBadgeTheme badgeTheme;

  /// 主题扩展
  final Map<Type, ThemeExtension<dynamic>> extensions;

  /// 间距配置
  final ZephyrSpacingTokens spacing;

  /// 动画配置
  final ZephyrAnimationTokens animation;

  /// 创建副本
  ZephyrUnifiedThemeData copyWith({
    Brightness? brightness,
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    AppBarTheme? appBarTheme,
    CardTheme? cardTheme,
    ChipThemeData? chipTheme,
    ElevatedButtonThemeData? elevatedButtonTheme,
    FilledButtonThemeData? filledButtonTheme,
    OutlinedButtonThemeData? outlinedButtonTheme,
    TextButtonThemeData? textButtonTheme,
    InputDecorationTheme? inputDecorationTheme,
    DividerThemeData? dividerTheme,
    IconThemeData? iconTheme,
    ZephyrBadgeTheme? badgeTheme,
    Map<Type, ThemeExtension<dynamic>>? extensions,
    ZephyrSpacingTokens? spacing,
    ZephyrAnimationTokens? animation,
  }) {
    return ZephyrUnifiedThemeData(
      brightness: brightness ?? this.brightness,
      colorScheme: colorScheme ?? this.colorScheme,
      textTheme: textTheme ?? this.textTheme,
      appBarTheme: appBarTheme ?? this.appBarTheme,
      cardTheme: cardTheme ?? this.cardTheme,
      chipTheme: chipTheme ?? this.chipTheme,
      elevatedButtonTheme: elevatedButtonTheme ?? this.elevatedButtonTheme,
      filledButtonTheme: filledButtonTheme ?? this.filledButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme ?? this.outlinedButtonTheme,
      textButtonTheme: textButtonTheme ?? this.textButtonTheme,
      inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
      dividerTheme: dividerTheme ?? this.dividerTheme,
      iconTheme: iconTheme ?? this.iconTheme,
      badgeTheme: badgeTheme ?? this.badgeTheme,
      extensions: extensions ?? this.extensions,
      spacing: spacing ?? this.spacing,
      animation: animation ?? this.animation,
    );
  }

  /// 转换为 Material 主题数据
  ThemeData toMaterialTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: appBarTheme,
      cardTheme: cardTheme,
      chipTheme: chipTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      filledButtonTheme: filledButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      inputDecorationTheme: inputDecorationTheme,
      dividerTheme: dividerTheme,
      iconTheme: iconTheme,
      extensions: extensions,
    );
  }

  /// 获取主题扩展
  T? getExtension<T>() {
    return extensions[T] as T?;
  }

  /// 创建文本主题
  static TextTheme _createTextTheme(Brightness brightness, String? fontFamily) {
    final baseTheme = brightness == Brightness.light
        ? Typography.material2018().black
        : Typography.material2018().white;

    final theme = baseTheme.copyWith(
      displayLarge: const TextStyle(
        fontSize: ZephyrTypographyTokens.displayLarge,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        letterSpacing: ZephyrTypographyTokens.letterSpacingTight,
        height: ZephyrTypographyTokens.lineHeightTight,
      ),
      displayMedium: const TextStyle(
        fontSize: ZephyrTypographyTokens.displayMedium,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        letterSpacing: ZephyrTypographyTokens.letterSpacingTight,
        height: ZephyrTypographyTokens.lineHeightTight,
      ),
      displaySmall: const TextStyle(
        fontSize: ZephyrTypographyTokens.displaySmall,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightTight,
      ),
      headlineLarge: const TextStyle(
        fontSize: ZephyrTypographyTokens.headlineLarge,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightNormal,
      ),
      headlineMedium: const TextStyle(
        fontSize: ZephyrTypographyTokens.headlineMedium,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightNormal,
      ),
      headlineSmall: const TextStyle(
        fontSize: ZephyrTypographyTokens.headlineSmall,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightNormal,
      ),
      titleLarge: const TextStyle(
        fontSize: ZephyrTypographyTokens.titleLarge,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightNormal,
      ),
      titleMedium: const TextStyle(
        fontSize: ZephyrTypographyTokens.titleMedium,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightNormal,
      ),
      titleSmall: const TextStyle(
        fontSize: ZephyrTypographyTokens.titleSmall,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightNormal,
      ),
      bodyLarge: const TextStyle(
        fontSize: ZephyrTypographyTokens.bodyLarge,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightRelaxed,
      ),
      bodyMedium: const TextStyle(
        fontSize: ZephyrTypographyTokens.bodyMedium,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightRelaxed,
      ),
      bodySmall: const TextStyle(
        fontSize: ZephyrTypographyTokens.bodySmall,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightRelaxed,
      ),
      labelLarge: const TextStyle(
        fontSize: ZephyrTypographyTokens.labelLarge,
        fontWeight: ZephyrTypographyTokens.weightMedium,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightNormal,
      ),
      labelMedium: const TextStyle(
        fontSize: ZephyrTypographyTokens.labelMedium,
        fontWeight: ZephyrTypographyTokens.weightMedium,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightNormal,
      ),
      labelSmall: const TextStyle(
        fontSize: ZephyrTypographyTokens.labelSmall,
        fontWeight: ZephyrTypographyTokens.weightMedium,
        letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        height: ZephyrTypographyTokens.lineHeightNormal,
      ),
    );

    return fontFamily != null ? theme.apply(fontFamily: fontFamily) : theme;
  }

  /// 创建应用栏主题
  static AppBarTheme _createAppBarTheme(
      Brightness brightness, ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: ZephyrElevationTokens.level3,
      surfaceTintColor: colorScheme.surfaceTint,
      shadowColor: colorScheme.shadow,
      titleTextStyle: TextStyle(
        fontSize: ZephyrTypographyTokens.titleLarge,
        fontWeight: ZephyrTypographyTokens.weightSemiBold,
        color: colorScheme.onSurface,
      ),
      toolbarTextStyle: TextStyle(
        fontSize: ZephyrTypographyTokens.bodyMedium,
        fontWeight: ZephyrTypographyTokens.weightRegular,
        color: colorScheme.onSurface,
      ),
    );
  }

  /// 创建卡片主题
  static CardTheme _createCardTheme(
      Brightness brightness, ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.surface,
      elevation: ZephyrElevationTokens.level1,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.medium),
      ),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    );
  }

  /// 创建芯片主题
  static ChipThemeData _createChipTheme(
      Brightness brightness, ColorScheme colorScheme) {
    return ChipThemeData(
      backgroundColor: colorScheme.surfaceContainerHighest,
      deleteIconColor: colorScheme.onSurfaceVariant,
      disabledColor: colorScheme.onSurface.withValues(alpha:0.12),
      selectedColor: colorScheme.primaryContainer,
      secondarySelectedColor: colorScheme.primaryContainer,
      shadowColor: Colors.transparent,
      selectedShadowColor: Colors.transparent,
      checkmarkColor: colorScheme.onPrimaryContainer,
      labelStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontSize: ZephyrTypographyTokens.bodySmall,
        fontWeight: ZephyrTypographyTokens.weightMedium,
      ),
      secondaryLabelStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontSize: ZephyrTypographyTokens.bodySmall,
        fontWeight: ZephyrTypographyTokens.weightMedium,
      ),
      brightness: brightness,
      elevation: 0,
      pressElevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
      ),
      side: BorderSide(
        color: colorScheme.outline,
        width: ZephyrBorderTokens.hairline,
      ),
    );
  }

  /// 创建按钮主题
  static ElevatedButtonThemeData _createElevatedButtonTheme(
      Brightness brightness, ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.onSurface.withValues(alpha:0.12),
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha:0.38),
        elevation: ZephyrElevationTokens.level1,
        shadowColor: colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: ZephyrTypographyTokens.labelLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
          letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        ),
      ),
    );
  }

  static FilledButtonThemeData _createFilledButtonTheme(
      Brightness brightness, ColorScheme colorScheme) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        disabledBackgroundColor: colorScheme.onSurface.withValues(alpha:0.12),
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha:0.38),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: ZephyrTypographyTokens.labelLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
          letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _createOutlinedButtonTheme(
      Brightness brightness, ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha:0.38),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        ),
        side: BorderSide(
          color: colorScheme.outline,
          width: ZephyrBorderTokens.hairline,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: ZephyrTypographyTokens.labelLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
          letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        ),
      ),
    );
  }

  static TextButtonThemeData _createTextButtonTheme(
      Brightness brightness, ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha:0.38),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: ZephyrTypographyTokens.labelLarge,
          fontWeight: ZephyrTypographyTokens.weightMedium,
          letterSpacing: ZephyrTypographyTokens.letterSpacingNormal,
        ),
      ),
    );
  }

  /// 创建输入装饰主题
  static InputDecorationTheme _createInputDecorationTheme(
      Brightness brightness, ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withValues(alpha:0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        borderSide: BorderSide(
          color: colorScheme.outline,
          width: ZephyrBorderTokens.hairline,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        borderSide: BorderSide(
          color: colorScheme.outline,
          width: ZephyrBorderTokens.hairline,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: ZephyrBorderTokens.thin,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: ZephyrBorderTokens.thin,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: ZephyrBorderTokens.thin,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadiusTokens.small),
        borderSide: BorderSide(
          color: colorScheme.onSurface.withValues(alpha:0.12),
          width: ZephyrBorderTokens.hairline,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontSize: ZephyrTypographyTokens.bodySmall,
        fontWeight: ZephyrTypographyTokens.weightMedium,
      ),
      hintStyle: TextStyle(
        color: colorScheme.onSurfaceVariant.withValues(alpha:0.7),
        fontSize: ZephyrTypographyTokens.bodyMedium,
        fontWeight: ZephyrTypographyTokens.weightRegular,
      ),
      errorStyle: TextStyle(
        color: colorScheme.error,
        fontSize: ZephyrTypographyTokens.bodySmall,
        fontWeight: ZephyrTypographyTokens.weightRegular,
      ),
      helperStyle: TextStyle(
        color: colorScheme.onSurfaceVariant.withValues(alpha:0.7),
        fontSize: ZephyrTypographyTokens.bodySmall,
        fontWeight: ZephyrTypographyTokens.weightRegular,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      alignLabelWithHint: true,
    );
  }

  /// 创建分割线主题
  static DividerThemeData _createDividerTheme(Brightness brightness) {
    return DividerThemeData(
      color: brightness == Brightness.light
          ? ZephyrColorTokens.neutral80
          : ZephyrColorTokens.neutral30,
      thickness: ZephyrBorderTokens.hairline,
      space: ZephyrSpacingTokens.small,
      indent: 0,
      endIndent: 0,
    );
  }

  /// 创建图标主题
  static IconThemeData _createIconTheme(
      Brightness brightness, ColorScheme colorScheme) {
    return IconThemeData(
      color: colorScheme.onSurfaceVariant,
      size: 24,
      opacity: 1,
    );
  }

  /// 创建徽章主题
  static ZephyrBadgeTheme _createBadgeTheme(
      Brightness brightness, Color errorColor) {
    return ZephyrBadgeTheme(
      backgroundColor: errorColor,
      textColor: brightness == Brightness.light ? Colors.white : Colors.black,
      borderRadius: BorderRadius.circular(ZephyrRadiusTokens.circular),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      borderWidth: 0,
      borderColor: Colors.transparent,
    );
  }

  /// 创建默认主题扩展
  static Map<Type, ThemeExtension<dynamic>> _createDefaultExtensions(
      Brightness brightness) {
    return {
      ZephyrColorSchemeExtension: const ZephyrColorSchemeExtension(),
      ZephyrShapeThemeExtension: const ZephyrShapeThemeExtension(),
      ZephyrSpacingThemeExtension: const ZephyrSpacingThemeExtension(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrUnifiedThemeData &&
        other.brightness == brightness &&
        other.colorScheme == colorScheme &&
        other.textTheme == textTheme &&
        other.appBarTheme == appBarTheme &&
        other.cardTheme == cardTheme &&
        other.chipTheme == chipTheme &&
        other.elevatedButtonTheme == elevatedButtonTheme &&
        other.filledButtonTheme == filledButtonTheme &&
        other.outlinedButtonTheme == outlinedButtonTheme &&
        other.textButtonTheme == textButtonTheme &&
        other.inputDecorationTheme == inputDecorationTheme &&
        other.dividerTheme == dividerTheme &&
        other.iconTheme == iconTheme &&
        other.badgeTheme == badgeTheme &&
        other.spacing == spacing &&
        other.animation == animation;
  }

  @override
  int get hashCode => Object.hashAll([
        brightness,
        colorScheme,
        textTheme,
        appBarTheme,
        cardTheme,
        chipTheme,
        elevatedButtonTheme,
        filledButtonTheme,
        outlinedButtonTheme,
        textButtonTheme,
        inputDecorationTheme,
        dividerTheme,
        iconTheme,
        badgeTheme,
        spacing,
        animation,
      ]);
}
