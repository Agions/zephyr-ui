/// ZephyrUI 性能优化主题数据
///
/// 优化后的主题数据结构，使用懒加载、缓存和内存优化技术。
library optimized_theme_data;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 主题缓存管理器
class _ThemeCache {
  static final Map<String, ZephyrThemeData> _cache = {};
  static const int _maxCacheSize = 10;

  /// 获取缓存的主题
  static ZephyrThemeData? get(String key) {
    return _cache[key];
  }

  /// 缓存主题
  static void put(String key, ZephyrThemeData theme) {
    if (_cache.length >= _maxCacheSize) {
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = theme;
  }

  /// 清除缓存
  static void clear() {
    _cache.clear();
  }
}

/// 主题数据构建器 - 使用建造者模式优化大对象创建
class ZephyrThemeDataBuilder {
  Brightness? _brightness;
  Color? _primaryColor;
  Color? _secondaryColor;
  Color? _backgroundColor;
  Color? _errorColor;
  TextTheme? _textTheme;
  ZephyrButtonTheme? _buttonTheme;
  ZephyrTextTheme? _zephyrTextTheme;
  ZephyrDividerTheme? _dividerTheme;
  ZephyrIconTheme? _iconTheme;
  ZephyrBadgeTheme? _badgeTheme;
  ZephyrSideMenuTheme? _sideMenuTheme;
  ZephyrStepperTheme? _stepperTheme;
  ZephyrCheckboxGroupTheme? _checkboxGroupTheme;
  ZephyrRadioGroupTheme? _radioGroupTheme;
  ZephyrSliderTheme? _sliderTheme;
  ZephyrDatePickerTheme? _datePickerTheme;
  ZephyrAccordionTheme? _accordionTheme;
  ZephyrSkeletonTheme? _skeletonTheme;
  ZephyrPaginationTheme? _paginationTheme;
  ZephyrRatingTheme? _ratingTheme;
  ZephyrTreeTheme? _treeTheme;
  ZephyrTourTheme? _tourTheme;
  double? _spacing;
  BuildContext? _context;

  ZephyrThemeDataBuilder brightness(Brightness value) {
    _brightness = value;
    return this;
  }

  ZephyrThemeDataBuilder primaryColor(Color value) {
    _primaryColor = value;
    return this;
  }

  ZephyrThemeDataBuilder secondaryColor(Color value) {
    _secondaryColor = value;
    return this;
  }

  ZephyrThemeDataBuilder backgroundColor(Color value) {
    _backgroundColor = value;
    return this;
  }

  ZephyrThemeDataBuilder errorColor(Color value) {
    _errorColor = value;
    return this;
  }

  ZephyrThemeDataBuilder spacing(double value) {
    _spacing = value;
    return this;
  }

  ZephyrThemeDataBuilder context(BuildContext? value) {
    _context = value;
    return this;
  }

  ZephyrThemeData build() {
    return ZephyrThemeData(
      brightness: _brightness ?? Brightness.light,
      primaryColor: _primaryColor ?? const Color(0xFF1976D2),
      secondaryColor: _secondaryColor ?? const Color(0xFF26A69A),
      backgroundColor: _backgroundColor ?? Colors.white,
      errorColor: _errorColor ?? const Color(0xFFD32F2F),
      textTheme: _textTheme ?? Typography.material2018().black,
      buttonTheme: _buttonTheme ?? const ZephyrButtonTheme(),
      zephyrTextTheme:
          _zephyrTextTheme ?? _createDefaultTextTheme(Brightness.light),
      dividerTheme: _dividerTheme ?? const ZephyrDividerTheme(),
      iconTheme: _iconTheme ?? _createDefaultIconTheme(Brightness.light),
      badgeTheme: _badgeTheme ?? _createDefaultBadgeTheme(),
      sideMenuTheme:
          _sideMenuTheme ?? _createDefaultSideMenuTheme(Brightness.light),
      stepperTheme:
          _stepperTheme ?? _createDefaultStepperTheme(Brightness.light),
      checkboxGroupTheme: _checkboxGroupTheme ??
          _createDefaultCheckboxGroupTheme(Brightness.light),
      radioGroupTheme:
          _radioGroupTheme ?? _createDefaultRadioGroupTheme(Brightness.light),
      sliderTheme: _sliderTheme ?? _createDefaultSliderTheme(Brightness.light),
      datePickerTheme:
          _datePickerTheme ?? _createDefaultDatePickerTheme(Brightness.light),
      accordionTheme: _accordionTheme ?? ZephyrAccordionTheme.light(),
      skeletonTheme: _skeletonTheme ?? ZephyrSkeletonTheme.light(),
      paginationTheme: _paginationTheme ?? ZephyrPaginationTheme.light(),
      ratingTheme: _ratingTheme ?? ZephyrRatingTheme.light(),
      treeTheme: _treeTheme ?? ZephyrTreeTheme.light(),
      tourTheme: _tourTheme ?? ZephyrTourTheme.light(),
      checkboxTheme: const ZephyrCheckboxTheme(),
      radioTheme: const ZephyrRadioTheme(),
      textAreaTheme: ZephyrTextAreaTheme.light(),
      timePickerTheme: ZephyrTimePickerTheme.light(),
      spacing: _spacing ?? 16.0,
      context: _context,
    );
  }

  static ZephyrTextTheme _createDefaultTextTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ZephyrTextTheme(
      headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF212121)),
      primaryColor: isDark ? Colors.white : const Color(0xFF212121),
      secondaryColor:
          isDark ? const Color(0xB3FFFFFF) : const Color(0xFF757575),
      errorColor: const Color(0xFFD32F2F),
      disabledColor: isDark ? const Color(0x80FFFFFF) : const Color(0xFFBDBDBD),
    );
  }

  static ZephyrIconTheme _createDefaultIconTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ZephyrIconTheme(
      defaultColor: isDark ? const Color(0xDEFFFFFF) : const Color(0xFF212121),
      primaryColor: isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      secondaryColor:
          isDark ? const Color(0xFF80CBC4) : const Color(0xFF26A69A),
      errorColor: const Color(0xFFD32F2F),
      warningColor: const Color(0xFFFF9800),
      successColor: const Color(0xFF4CAF50),
      infoColor: const Color(0xFF03A9F4),
      disabledColor: isDark ? const Color(0x80FFFFFF) : const Color(0xFFBDBDBD),
      defaultSize: 24.0,
      smallSize: 16.0,
      mediumSize: 24.0,
      largeSize: 32.0,
    );
  }

  static ZephyrBadgeTheme _createDefaultBadgeTheme() {
    return ZephyrBadgeTheme(
      backgroundColor: const Color(0xFFE53935),
      textColor: Colors.white,
      borderRadius: BorderRadius.circular(100),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      borderWidth: 0.0,
      borderColor: Colors.transparent,
    );
  }

  static ZephyrSideMenuTheme _createDefaultSideMenuTheme(
      Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ZephyrSideMenuTheme(
      backgroundColor: isDark ? const Color(0xFF212121) : Colors.white,
      width: 240.0,
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
      itemHeight: 48.0,
      itemSpacing: 4.0,
      itemTextStyle: TextStyle(
        fontSize: 14.0,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
      activeItemTextStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      ),
      activeItemBackgroundColor:
          (isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2))
              .withValues(alpha: 0.12),
      iconColor: isDark ? Colors.white70 : Colors.black54,
      activeIconColor:
          isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      dividerColor: isDark ? Colors.white24 : Colors.black12,
      dividerThickness: 1.0,
      headerBackgroundColor:
          isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
      headerTextStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.black87,
      ),
      footerBackgroundColor:
          isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
      selectedItemColor:
          isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      unselectedItemColor: isDark ? Colors.white70 : Colors.black87,
    );
  }

  static ZephyrStepperTheme _createDefaultStepperTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final primaryColor =
        isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2);
    final inactiveColor = isDark ? Colors.white60 : Colors.black45;

    return ZephyrStepperTheme(
      activeColor: primaryColor,
      completedColor: isDark ? Colors.green[300]! : Colors.green[600]!,
      inactiveColor: inactiveColor,
      errorColor: const Color(0xFFD32F2F),
      borderColor: isDark ? Colors.white24 : Colors.black12,
      borderWidth: 2.0,
      textColor: isDark ? Colors.white70 : Colors.black87,
      activeTextColor: primaryColor,
      subtitleColor: isDark ? Colors.white60 : Colors.black54,
      stepSize: 32.0,
      borderRadius: 8.0,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  static ZephyrCheckboxGroupTheme _createDefaultCheckboxGroupTheme(
      Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ZephyrCheckboxGroupTheme(
      activeColor: isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      checkColor: isDark ? Colors.black : Colors.white,
      borderColor: isDark ? const Color(0xB3FFFFFF) : const Color(0xFF757575),
      disabledBorderColor:
          isDark ? const Color(0x80FFFFFF) : const Color(0xFFBDBDBD),
      textStyle: TextStyle(
        fontSize: 14,
        color: isDark ? const Color(0xDEFFFFFF) : const Color(0xFF212121),
      ),
      disabledTextStyle: TextStyle(
        fontSize: 14,
        color: isDark ? const Color(0x99FFFFFF) : const Color(0xFF9E9E9E),
      ),
      borderWidth: 1.5,
      borderRadius: 4.0,
    );
  }

  static ZephyrRadioGroupTheme _createDefaultRadioGroupTheme(
      Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ZephyrRadioGroupTheme(
      activeColor: isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      borderColor: isDark ? const Color(0xB3FFFFFF) : const Color(0xFF757575),
      disabledBorderColor:
          isDark ? const Color(0x80FFFFFF) : const Color(0xFFBDBDBD),
      textStyle: TextStyle(
        fontSize: 14,
        color: isDark ? const Color(0xDEFFFFFF) : const Color(0xFF212121),
      ),
      selectedTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? const Color(0xFF212121) : const Color(0xFF212121),
      ),
      disabledTextStyle: TextStyle(
        fontSize: 14,
        color: isDark ? const Color(0x99FFFFFF) : const Color(0xFF9E9E9E),
      ),
      borderWidth: 1.5,
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
    );
  }

  static ZephyrSliderTheme _createDefaultSliderTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ZephyrSliderTheme(
      activeTrackColor:
          isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      inactiveTrackColor:
          isDark ? const Color(0x52FFFFFF) : const Color(0x52000000),
      hoverActiveTrackColor:
          isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      hoverInactiveTrackColor:
          isDark ? const Color(0xB3FFFFFF) : const Color(0xFF757575),
      disabledActiveTrackColor:
          isDark ? const Color(0x80FFFFFF) : const Color(0xFFBDBDBD),
      disabledInactiveTrackColor:
          isDark ? const Color(0x1FFFFFFF) : const Color(0x1F000000),
      thumbColor: isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      hoverThumbColor:
          isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      disabledThumbColor:
          isDark ? const Color(0x80FFFFFF) : const Color(0xFFBDBDBD),
      thumbShadowColor: isDark ? Colors.black54 : Colors.black26,
      valueIndicatorColor:
          isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      valueIndicatorTextStyle: TextStyle(
        color: isDark ? Colors.black : Colors.white,
        fontSize: 12.0,
      ),
      thumbBorderColor: isDark ? Colors.black12 : Colors.white,
      hoverThumbBorderColor:
          isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2),
      disabledThumbBorderColor:
          isDark ? const Color(0x80FFFFFF) : const Color(0xFFBDBDBD),
    );
  }

  static ZephyrDatePickerTheme _createDefaultDatePickerTheme(
      Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final primaryColor =
        isDark ? const Color(0xFF90CAF9) : const Color(0xFF1976D2);

    return ZephyrDatePickerTheme(
      primaryColor: primaryColor,
      selectedDateBackgroundColor: primaryColor,
      selectedDateTextColor: isDark ? Colors.black87 : Colors.white,
      currentDateBackgroundColor:
          primaryColor.withValues(alpha: isDark ? 0.3 : 0.1),
      currentDateTextColor: primaryColor,
      dateTextColor: isDark ? Colors.white : Colors.black87,
      disabledDateTextColor: isDark ? Colors.white38 : Colors.black38,
      weekendDateTextColor: isDark ? Colors.red.shade200 : Colors.red.shade300,
      rangeDateBackgroundColor: primaryColor.withValues(alpha: 0.2),
      headerBackgroundColor:
          isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE3F2FD),
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
      dateStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: isDark ? Colors.white : Colors.black87,
      ),
      selectedDateStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.black87 : Colors.white,
      ),
      buttonTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      disabledButtonTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white38 : Colors.grey,
      ),
    );
  }
}

/// 优化后的主题数据类
class ZephyrOptimizedThemeData extends ZephyrThemeData {
  ZephyrOptimizedThemeData({
    required super.brightness,
    required super.primaryColor,
    required super.secondaryColor,
    required super.backgroundColor,
    required super.errorColor,
    required super.textTheme,
    required super.buttonTheme,
    required super.zephyrTextTheme,
    required super.dividerTheme,
    required super.iconTheme,
    required super.badgeTheme,
    required super.sideMenuTheme,
    required super.stepperTheme,
    required super.checkboxGroupTheme,
    required super.radioGroupTheme,
    required super.sliderTheme,
    required super.datePickerTheme,
    required super.ratingTheme,
    required super.treeTheme,
    required super.tourTheme,
    required super.checkboxTheme,
    required super.radioTheme,
    required super.textAreaTheme,
    required super.timePickerTheme,
    required super.spacing,
    super.accordionTheme,
    super.skeletonTheme,
    super.paginationTheme,
    super.context,
  }) : _createdAt = DateTime.now();

  /// 工厂方法：创建优化的亮色主题
  factory ZephyrOptimizedThemeData.light() {
    const cacheKey = 'optimized_light';
    final cached = _ThemeCache.get(cacheKey);

    if (cached != null) {
      final optimized = cached as ZephyrOptimizedThemeData;
      optimized.recordUsage();
      return optimized;
    }

    final theme = createLightBasic();
    _ThemeCache.put(cacheKey, theme);
    return theme;
  }

  /// 工厂方法：创建优化的暗色主题
  factory ZephyrOptimizedThemeData.dark() {
    const cacheKey = 'optimized_dark';
    final cached = _ThemeCache.get(cacheKey);

    if (cached != null) {
      final optimized = cached as ZephyrOptimizedThemeData;
      optimized.recordUsage();
      return optimized;
    }

    final theme = createDarkBasic();
    _ThemeCache.put(cacheKey, theme);
    return theme;
  }

  /// 主题创建时间戳
  final DateTime _createdAt;

  /// 主题使用计数
  int _usageCount = 0;

  /// 最后使用时间
  DateTime _lastUsed = DateTime.now();

  /// 记录主题使用
  void recordUsage() {
    _usageCount++;
    _lastUsed = DateTime.now();
  }

  /// 获取使用统计
  Map<String, dynamic> getUsageStats() {
    return {
      'createdAt': _createdAt.toIso8601String(),
      'usageCount': _usageCount,
      'lastUsed': _lastUsed.toIso8601String(),
      'ageInMinutes': DateTime.now().difference(_createdAt).inMinutes,
    };
  }

  /// 检查是否应该被回收
  bool shouldEvict(Duration maxAge) {
    return DateTime.now().difference(_lastUsed) > maxAge;
  }

  /// 创建轻量级主题 - 仅包含基本属性
  static ZephyrOptimizedThemeData createLightBasic() {
    return ZephyrOptimizedThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF1976D2),
      secondaryColor: const Color(0xFF26A69A),
      backgroundColor: Colors.white,
      errorColor: const Color(0xFFD32F2F),
      textTheme: Typography.material2018().black,
      buttonTheme: const ZephyrButtonTheme(),
      zephyrTextTheme:
          ZephyrThemeDataBuilder._createDefaultTextTheme(Brightness.light),
      dividerTheme: const ZephyrDividerTheme(),
      iconTheme:
          ZephyrThemeDataBuilder._createDefaultIconTheme(Brightness.light),
      badgeTheme: ZephyrThemeDataBuilder._createDefaultBadgeTheme(),
      sideMenuTheme:
          ZephyrThemeDataBuilder._createDefaultSideMenuTheme(Brightness.light),
      stepperTheme:
          ZephyrThemeDataBuilder._createDefaultStepperTheme(Brightness.light),
      checkboxGroupTheme:
          ZephyrThemeDataBuilder._createDefaultCheckboxGroupTheme(
              Brightness.light),
      radioGroupTheme: ZephyrThemeDataBuilder._createDefaultRadioGroupTheme(
          Brightness.light),
      sliderTheme:
          ZephyrThemeDataBuilder._createDefaultSliderTheme(Brightness.light),
      datePickerTheme: ZephyrThemeDataBuilder._createDefaultDatePickerTheme(
          Brightness.light),
      ratingTheme: ZephyrRatingTheme.light(),
      treeTheme: ZephyrTreeTheme.light(),
      tourTheme: ZephyrTourTheme.light(),
      checkboxTheme: const ZephyrCheckboxTheme(),
      radioTheme: const ZephyrRadioTheme(),
      textAreaTheme: ZephyrTextAreaTheme.light(),
      timePickerTheme: ZephyrTimePickerTheme.light(),
      spacing: 16.0,
    );
  }

  /// 创建轻量级暗色主题
  static ZephyrOptimizedThemeData createDarkBasic() {
    return ZephyrOptimizedThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF90CAF9),
      secondaryColor: const Color(0xFF80CBC4),
      backgroundColor: const Color(0xFF121212),
      errorColor: const Color(0xFFEF5350),
      textTheme: Typography.material2018().white,
      buttonTheme: const ZephyrButtonTheme(
        primaryBackgroundColor: Color(0xFF90CAF9),
        primaryTextColor: Color(0xFF000000),
        secondaryBackgroundColor: Color(0xFF80CBC4),
        secondaryTextColor: Color(0xFF000000),
        disabledBackgroundColor: Color(0xFF424242),
        disabledTextColor: Color(0xFF757575),
      ),
      zephyrTextTheme:
          ZephyrThemeDataBuilder._createDefaultTextTheme(Brightness.dark),
      dividerTheme: const ZephyrDividerTheme(
        color: Color(0x33FFFFFF),
      ),
      iconTheme:
          ZephyrThemeDataBuilder._createDefaultIconTheme(Brightness.dark),
      badgeTheme: ZephyrThemeDataBuilder._createDefaultBadgeTheme(),
      sideMenuTheme:
          ZephyrThemeDataBuilder._createDefaultSideMenuTheme(Brightness.dark),
      stepperTheme:
          ZephyrThemeDataBuilder._createDefaultStepperTheme(Brightness.dark),
      checkboxGroupTheme:
          ZephyrThemeDataBuilder._createDefaultCheckboxGroupTheme(
              Brightness.dark),
      radioGroupTheme:
          ZephyrThemeDataBuilder._createDefaultRadioGroupTheme(Brightness.dark),
      sliderTheme:
          ZephyrThemeDataBuilder._createDefaultSliderTheme(Brightness.dark),
      datePickerTheme:
          ZephyrThemeDataBuilder._createDefaultDatePickerTheme(Brightness.dark),
      ratingTheme: ZephyrRatingTheme.dark(),
      treeTheme: ZephyrTreeTheme.dark(),
      tourTheme: ZephyrTourTheme.dark(),
      checkboxTheme: const ZephyrCheckboxTheme(),
      radioTheme: const ZephyrRadioTheme(),
      textAreaTheme: ZephyrTextAreaTheme.dark(),
      timePickerTheme: ZephyrTimePickerTheme.dark(),
      spacing: 16.0,
    );
  }

  /// 清除主题缓存
  static void clearCache() {
    _ThemeCache.clear();
  }

  /// 获取缓存统计
  static Map<String, dynamic> getCacheStats() {
    return {
      'cacheSize': _ThemeCache._cache.length,
      'maxCacheSize': _ThemeCache._maxCacheSize,
      'cachedThemes': _ThemeCache._cache.keys.toList(),
    };
  }
}
