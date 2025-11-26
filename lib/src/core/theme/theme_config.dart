/// ZephyrUI 主题配置
///
/// 提供主题配置的工厂方法和预设主题，简化主题的创建和定制。
library theme_config;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 主题配置类
class ZephyrThemeConfig {
  ZephyrThemeConfig._();

  /// 创建默认浅色主题
  static ZephyrThemeData createLightTheme({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? errorColor,
    String? fontFamily,
  }) {
    final primary = primaryColor ?? ZephyrColors.primary500;
    final secondary = secondaryColor ?? ZephyrColors.secondary500;
    final background = backgroundColor ?? ZephyrColors.neutral50;
    final error = errorColor ?? ZephyrColors.error500;

    return ZephyrThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      secondaryColor: secondary,
      backgroundColor: background,
      errorColor: error,
      spacing: ZephyrSpacing.md,
      textTheme: _createTextTheme(Brightness.light, fontFamily),
      buttonTheme: _createButtonTheme(Brightness.light, primary, secondary),
      zephyrTextTheme: _createZephyrTextTheme(Brightness.light),
      dividerTheme: _createDividerTheme(Brightness.light),
      iconTheme: _createIconTheme(Brightness.light),
      badgeTheme: _createBadgeTheme(Brightness.light, error),
      sideMenuTheme: _createSideMenuTheme(Brightness.light, primary),
      stepperTheme: _createStepperTheme(Brightness.light, primary),
      checkboxGroupTheme: _createCheckboxGroupTheme(Brightness.light, primary),
      radioGroupTheme: _createRadioGroupTheme(Brightness.light, primary),
      sliderTheme: _createSliderTheme(Brightness.light, primary),
      datePickerTheme: _createDatePickerTheme(Brightness.light, primary),
      accordionTheme: ZephyrAccordionTheme.light(),
      skeletonTheme: ZephyrSkeletonTheme.light(),
      paginationTheme: ZephyrPaginationTheme.light(),
      ratingTheme: ZephyrRatingTheme.light(),
      treeTheme: ZephyrTreeTheme.light(),
      tourTheme: ZephyrTourTheme.light(),
      checkboxTheme: ZephyrCheckboxTheme.light(),
      radioTheme: ZephyrRadioTheme.light(),
      textAreaTheme: ZephyrTextAreaTheme.light(),
      timePickerTheme: ZephyrTimePickerTheme.light(),
    );
  }

  /// 创建默认深色主题
  static ZephyrThemeData createDarkTheme({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? errorColor,
    String? fontFamily,
  }) {
    final primary = primaryColor ?? ZephyrColors.primary200;
    final secondary = secondaryColor ?? ZephyrColors.secondary200;
    final background = backgroundColor ?? ZephyrColors.neutral900;
    final error = errorColor ?? ZephyrColors.error500;

    return ZephyrThemeData(
      brightness: Brightness.dark,
      primaryColor: primary,
      secondaryColor: secondary,
      backgroundColor: background,
      errorColor: error,
      spacing: ZephyrSpacing.md,
      textTheme: _createTextTheme(Brightness.dark, fontFamily),
      buttonTheme: _createButtonTheme(Brightness.dark, primary, secondary),
      zephyrTextTheme: _createZephyrTextTheme(Brightness.dark),
      dividerTheme: _createDividerTheme(Brightness.dark),
      iconTheme: _createIconTheme(Brightness.dark),
      badgeTheme: _createBadgeTheme(Brightness.dark, error),
      sideMenuTheme: _createSideMenuTheme(Brightness.dark, primary),
      stepperTheme: _createStepperTheme(Brightness.dark, primary),
      checkboxGroupTheme: _createCheckboxGroupTheme(Brightness.dark, primary),
      radioGroupTheme: _createRadioGroupTheme(Brightness.dark, primary),
      sliderTheme: _createSliderTheme(Brightness.dark, primary),
      datePickerTheme: _createDatePickerTheme(Brightness.dark, primary),
      accordionTheme: ZephyrAccordionTheme.dark(),
      skeletonTheme: ZephyrSkeletonTheme.dark(),
      paginationTheme: ZephyrPaginationTheme.dark(),
      ratingTheme: ZephyrRatingTheme.dark(),
      treeTheme: ZephyrTreeTheme.dark(),
      tourTheme: ZephyrTourTheme.dark(),
      checkboxTheme: ZephyrCheckboxTheme.dark(),
      radioTheme: ZephyrRadioTheme.dark(),
      textAreaTheme: ZephyrTextAreaTheme.dark(),
      timePickerTheme: ZephyrTimePickerTheme.dark(),
    );
  }

  /// 创建企业级主题
  static ZephyrThemeData createEnterpriseTheme({
    Brightness brightness = Brightness.light,
    String? fontFamily,
  }) {
    final isDark = brightness == Brightness.dark;

    return isDark
        ? createDarkTheme(
            primaryColor: const Color(0xFF1565C0),
            secondaryColor: const Color(0xFF37474F),
            fontFamily: fontFamily,
          )
        : createLightTheme(
            primaryColor: const Color(0xFF1565C0),
            secondaryColor: const Color(0xFF37474F),
            fontFamily: fontFamily,
          );
  }

  /// 创建现代主题
  static ZephyrThemeData createModernTheme({
    Brightness brightness = Brightness.light,
    String? fontFamily,
  }) {
    final isDark = brightness == Brightness.dark;

    return isDark
        ? createDarkTheme(
            primaryColor: const Color(0xFF6366F1),
            secondaryColor: const Color(0xFF8B5CF6),
            fontFamily: fontFamily,
          )
        : createLightTheme(
            primaryColor: const Color(0xFF6366F1),
            secondaryColor: const Color(0xFF8B5CF6),
            fontFamily: fontFamily,
          );
  }

  /// 创建自然主题
  static ZephyrThemeData createNatureTheme({
    Brightness brightness = Brightness.light,
    String? fontFamily,
  }) {
    final isDark = brightness == Brightness.dark;

    return isDark
        ? createDarkTheme(
            primaryColor: const Color(0xFF4CAF50),
            secondaryColor: const Color(0xFF8BC34A),
            fontFamily: fontFamily,
          )
        : createLightTheme(
            primaryColor: const Color(0xFF4CAF50),
            secondaryColor: const Color(0xFF8BC34A),
            fontFamily: fontFamily,
          );
  }

  /// 创建文本主题
  static TextTheme _createTextTheme(Brightness brightness, String? fontFamily) {
    final baseTheme = brightness == Brightness.light
        ? Typography.material2018().black
        : Typography.material2018().white;

    if (fontFamily != null) {
      return baseTheme.apply(fontFamily: fontFamily);
    }

    return baseTheme;
  }

  /// 创建按钮主题
  static ZephyrButtonTheme _createButtonTheme(
    Brightness brightness,
    Color primary,
    Color secondary,
  ) {
    final isDark = brightness == Brightness.dark;

    return ZephyrButtonTheme(
      primaryBackgroundColor: primary,
      primaryTextColor: isDark ? ZephyrColors.neutral900 : Colors.white,
      secondaryBackgroundColor: secondary,
      secondaryTextColor: isDark ? ZephyrColors.neutral900 : Colors.white,
      disabledBackgroundColor:
          isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral300,
      disabledTextColor:
          isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral600,
    );
  }

  /// 创建 Zephyr 文本主题
  static ZephyrTextTheme _createZephyrTextTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ZephyrTextTheme(
      headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : ZephyrColors.neutral900),
      primaryColor: isDark ? Colors.white : ZephyrColors.neutral900,
      secondaryColor:
          isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral600,
      errorColor: ZephyrColors.error500,
      disabledColor: isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
    );
  }

  /// 创建分割线主题
  static ZephyrDividerTheme _createDividerTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ZephyrDividerTheme(
      color: isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral200,
    );
  }

  /// 创建图标主题
  static ZephyrIconTheme _createIconTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ZephyrIconTheme(
      defaultColor: isDark ? Colors.white : ZephyrColors.neutral900,
      primaryColor: isDark ? Colors.white : ZephyrColors.neutral900,
      secondaryColor:
          isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral600,
      errorColor: ZephyrColors.error500,
      warningColor: ZephyrColors.warning500,
      successColor: ZephyrColors.success500,
      infoColor: ZephyrColors.info500,
      disabledColor: isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
      defaultSize: 24.0,
      smallSize: 16.0,
      mediumSize: 24.0,
      largeSize: 32.0,
    );
  }

  /// 创建徽章主题
  static ZephyrBadgeTheme _createBadgeTheme(
      Brightness brightness, Color error) {
    return ZephyrBadgeTheme(
      backgroundColor: error,
      textColor: Colors.white,
      borderRadius: BorderRadius.circular(ZephyrRadius.full),
      padding: const EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.sm,
        vertical: ZephyrSpacing.xs,
      ),
      borderWidth: 0.0,
      borderColor: Colors.transparent,
    );
  }

  /// 创建侧边菜单主题
  static ZephyrSideMenuTheme _createSideMenuTheme(
    Brightness brightness,
    Color primary,
  ) {
    final isDark = brightness == Brightness.dark;

    return ZephyrSideMenuTheme(
      backgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      selectedItemColor: primary,
      unselectedItemColor:
          isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral600,
    );
  }

  /// 创建步进器主题
  static ZephyrStepperTheme _createStepperTheme(
    Brightness brightness,
    Color primary,
  ) {
    final isDark = brightness == Brightness.dark;

    return ZephyrStepperTheme(
      completedColor: ZephyrColors.success500,
      activeColor: primary,
      inactiveColor: isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral400,
      errorColor: ZephyrColors.error500,
      borderColor: isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300,
      borderWidth: 2.0,
      textColor: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
      activeTextColor: primary,
      subtitleColor: isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral600,
      stepSize: 32.0,
      borderRadius: 8.0,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  /// 创建复选框组主题
  static ZephyrCheckboxGroupTheme _createCheckboxGroupTheme(
    Brightness brightness,
    Color primary,
  ) {
    final isDark = brightness == Brightness.dark;

    return ZephyrCheckboxGroupTheme(
      activeColor: primary,
      checkColor: Colors.white,
      borderColor: isDark ? Colors.white70 : Colors.black54,
      disabledBorderColor: isDark ? Colors.white38 : Colors.black38,
      textStyle: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
      disabledTextStyle: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white38 : Colors.black38,
      ),
      borderWidth: 1.5,
      borderRadius: 4.0,
    );
  }

  /// 创建单选框组主题
  static ZephyrRadioGroupTheme _createRadioGroupTheme(
    Brightness brightness,
    Color primary,
  ) {
    final isDark = brightness == Brightness.dark;

    return ZephyrRadioGroupTheme(
      activeColor: primary,
      borderColor: isDark ? Colors.white70 : Colors.black54,
      disabledBorderColor: isDark ? Colors.white38 : Colors.black38,
      textStyle: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
      selectedTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
      disabledTextStyle: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white38 : Colors.black38,
      ),
    );
  }

  /// 创建滑块主题
  static ZephyrSliderTheme _createSliderTheme(
    Brightness brightness,
    Color primary,
  ) {
    final isDark = brightness == Brightness.dark;

    return ZephyrSliderTheme(
      activeTrackColor: primary,
      inactiveTrackColor: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
      hoverActiveTrackColor: primary.withValues(alpha: 0.8),
      hoverInactiveTrackColor:
          isDark ? Colors.grey.shade600 : Colors.grey.shade400,
      disabledActiveTrackColor:
          isDark ? Colors.grey.shade700 : Colors.grey.shade300,
      disabledInactiveTrackColor:
          isDark ? Colors.grey.shade800 : Colors.grey.shade400,
      thumbColor: primary,
      hoverThumbColor: primary.withValues(alpha: 0.8),
      disabledThumbColor: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
      thumbShadowColor: Colors.black.withValues(alpha: 0.2),
      valueIndicatorColor: primary,
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
      thumbBorderColor: Colors.transparent,
      hoverThumbBorderColor: primary.withValues(alpha: 0.6),
      disabledThumbBorderColor:
          isDark ? Colors.grey.shade500 : Colors.grey.shade400,
    );
  }

  /// 创建日期选择器主题
  static ZephyrDatePickerTheme _createDatePickerTheme(
    Brightness brightness,
    Color primary,
  ) {
    final isDark = brightness == Brightness.dark;
    final primaryLight = primary.withValues(alpha: 0.1);
    final primaryMedium = primary.withValues(alpha: 0.2);

    return ZephyrDatePickerTheme(
      primaryColor: primary,
      selectedDateBackgroundColor: primary,
      selectedDateTextColor: Colors.white,
      currentDateBackgroundColor: primaryLight,
      currentDateTextColor: primary,
      dateTextColor: isDark ? Colors.white70 : Colors.black87,
      disabledDateTextColor: isDark ? Colors.white38 : Colors.black38,
      weekendDateTextColor: isDark ? Colors.red.shade300 : Colors.red.shade400,
      rangeDateBackgroundColor: primaryMedium,
      headerBackgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      headerTextColor: isDark ? Colors.white : Colors.black87,
      headerYearStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: isDark ? Colors.white70 : Colors.black54,
      ),
      headerMonthStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
      ),
      weekdayStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white70 : Colors.black54,
      ),
      dateStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      selectedDateStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      buttonTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      disabledButtonTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white38 : Colors.black38,
      ),
    );
  }
}
