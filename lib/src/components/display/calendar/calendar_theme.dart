import 'package:flutter/material.dart';

/// ZephyrUI 日历主题配置
///
/// 定义日历组件的视觉样式，包括颜色、字体、边框等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrCalendarTheme {
  /// 背景颜色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 主色调
  final Color primaryColor;

  /// 头部背景颜色
  final Color headerBackgroundColor;

  /// 头部文本颜色
  final Color headerTextColor;

  /// 头部图标颜色
  final Color headerIconColor;

  /// 头部标题样式
  final TextStyle headerTitleStyle;

  /// 星期标题样式
  final TextStyle weekdayHeaderStyle;

  /// 日期数字样式
  final TextStyle dayStyle;

  /// 周末文本颜色
  final Color weekendTextColor;

  /// 禁用文本颜色
  final Color disabledTextColor;

  /// 今日背景颜色
  final Color todayColor;

  /// 今日边框颜色
  final Color todayBorderColor;

  /// 选中日期背景颜色
  final Color selectedDayColor;

  /// 事件默认颜色
  final Color eventColor;

  /// 事件文本样式
  final TextStyle eventStyle;

  /// 事件边框颜色
  final Color eventBorderColor;

  /// 事件圆角
  final BorderRadius eventBorderRadius;

  /// 事件阴影
  final List<BoxShadow> eventShadow;

  /// 身体文本样式
  final TextStyle bodyTextStyle;

  /// 创建日历主题
  const ZephyrCalendarTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.primaryColor,
    required this.headerBackgroundColor,
    required this.headerTextColor,
    required this.headerIconColor,
    required this.headerTitleStyle,
    required this.weekdayHeaderStyle,
    required this.dayStyle,
    required this.weekendTextColor,
    required this.disabledTextColor,
    required this.todayColor,
    required this.todayBorderColor,
    required this.selectedDayColor,
    required this.eventColor,
    required this.eventStyle,
    required this.eventBorderColor,
    required this.eventBorderRadius,
    required this.eventShadow,
    required this.bodyTextStyle,
  });

  /// 创建明亮的日历主题
  factory ZephyrCalendarTheme.light() {
    return ZephyrCalendarTheme(
      backgroundColor: Colors.white,
      borderColor: const Color(0xFFE5E7EB),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(12.0),
      primaryColor: const Color(0xFF3B82F6),
      headerBackgroundColor: const Color(0xFFF9FAFB),
      headerTextColor: const Color(0xFF111827),
      headerIconColor: const Color(0xFF6B7280),
      headerTitleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF111827),
      ),
      weekdayHeaderStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF6B7280),
      ),
      dayStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF111827),
      ),
      weekendTextColor: const Color(0xFFEF4444),
      disabledTextColor: const Color(0xFFD1D5DB),
      todayColor: const Color(0xFFEFF6FF),
      todayBorderColor: const Color(0xFF3B82F6),
      selectedDayColor: const Color(0xFFDBEAFE),
      eventColor: const Color(0xFF3B82F6),
      eventStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      eventBorderColor: const Color(0xFF3B82F6),
      eventBorderRadius: BorderRadius.circular(4.0),
      eventShadow: const [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
      bodyTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF374151),
      ),
    );
  }

  /// 创建暗色的日历主题
  factory ZephyrCalendarTheme.dark() {
    return ZephyrCalendarTheme(
      backgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(12.0),
      primaryColor: const Color(0xFF60A5FA),
      headerBackgroundColor: const Color(0xFF374151),
      headerTextColor: const Color(0xFFF9FAFB),
      headerIconColor: const Color(0xFF9CA3AF),
      headerTitleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF9FAFB),
      ),
      weekdayHeaderStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF9CA3AF),
      ),
      dayStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFF9FAFB),
      ),
      weekendTextColor: const Color(0xFFF87171),
      disabledTextColor: const Color(0xFF4B5563),
      todayColor: const Color(0xFF1E3A8A),
      todayBorderColor: const Color(0xFF60A5FA),
      selectedDayColor: const Color(0xFF1E40AF),
      eventColor: const Color(0xFF60A5FA),
      eventStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      eventBorderColor: const Color(0xFF60A5FA),
      eventBorderRadius: BorderRadius.circular(4.0),
      eventShadow: const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
      bodyTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFD1D5DB),
      ),
    );
  }

  /// 创建自定义日历主题
  factory ZephyrCalendarTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? primaryColor,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    Color? headerIconColor,
    TextStyle? headerTitleStyle,
    TextStyle? weekdayHeaderStyle,
    TextStyle? dayStyle,
    Color? weekendTextColor,
    Color? disabledTextColor,
    Color? todayColor,
    Color? todayBorderColor,
    Color? selectedDayColor,
    Color? eventColor,
    TextStyle? eventStyle,
    Color? eventBorderColor,
    BorderRadius? eventBorderRadius,
    List<BoxShadow>? eventShadow,
    TextStyle? bodyTextStyle,
  }) {
    final baseTheme = ZephyrCalendarTheme.light();
    
    return ZephyrCalendarTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      primaryColor: primaryColor ?? baseTheme.primaryColor,
      headerBackgroundColor: headerBackgroundColor ?? baseTheme.headerBackgroundColor,
      headerTextColor: headerTextColor ?? baseTheme.headerTextColor,
      headerIconColor: headerIconColor ?? baseTheme.headerIconColor,
      headerTitleStyle: headerTitleStyle ?? baseTheme.headerTitleStyle,
      weekdayHeaderStyle: weekdayHeaderStyle ?? baseTheme.weekdayHeaderStyle,
      dayStyle: dayStyle ?? baseTheme.dayStyle,
      weekendTextColor: weekendTextColor ?? baseTheme.weekendTextColor,
      disabledTextColor: disabledTextColor ?? baseTheme.disabledTextColor,
      todayColor: todayColor ?? baseTheme.todayColor,
      todayBorderColor: todayBorderColor ?? baseTheme.todayBorderColor,
      selectedDayColor: selectedDayColor ?? baseTheme.selectedDayColor,
      eventColor: eventColor ?? baseTheme.eventColor,
      eventStyle: eventStyle ?? baseTheme.eventStyle,
      eventBorderColor: eventBorderColor ?? baseTheme.eventBorderColor,
      eventBorderRadius: eventBorderRadius ?? baseTheme.eventBorderRadius,
      eventShadow: eventShadow ?? baseTheme.eventShadow,
      bodyTextStyle: bodyTextStyle ?? baseTheme.bodyTextStyle,
    );
  }

  /// 复制主题并修改部分属性
  ZephyrCalendarTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? primaryColor,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    Color? headerIconColor,
    TextStyle? headerTitleStyle,
    TextStyle? weekdayHeaderStyle,
    TextStyle? dayStyle,
    Color? weekendTextColor,
    Color? disabledTextColor,
    Color? todayColor,
    Color? todayBorderColor,
    Color? selectedDayColor,
    Color? eventColor,
    TextStyle? eventStyle,
    Color? eventBorderColor,
    BorderRadius? eventBorderRadius,
    List<BoxShadow>? eventShadow,
    TextStyle? bodyTextStyle,
  }) {
    return ZephyrCalendarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      primaryColor: primaryColor ?? this.primaryColor,
      headerBackgroundColor: headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      headerIconColor: headerIconColor ?? this.headerIconColor,
      headerTitleStyle: headerTitleStyle ?? this.headerTitleStyle,
      weekdayHeaderStyle: weekdayHeaderStyle ?? this.weekdayHeaderStyle,
      dayStyle: dayStyle ?? this.dayStyle,
      weekendTextColor: weekendTextColor ?? this.weekendTextColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      todayColor: todayColor ?? this.todayColor,
      todayBorderColor: todayBorderColor ?? this.todayBorderColor,
      selectedDayColor: selectedDayColor ?? this.selectedDayColor,
      eventColor: eventColor ?? this.eventColor,
      eventStyle: eventStyle ?? this.eventStyle,
      eventBorderColor: eventBorderColor ?? this.eventBorderColor,
      eventBorderRadius: eventBorderRadius ?? this.eventBorderRadius,
      eventShadow: eventShadow ?? this.eventShadow,
      bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
    );
  }

  /// 主题合并
  ZephyrCalendarTheme merge(ZephyrCalendarTheme? other) {
    if (other == null) return this;
    
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      primaryColor: other.primaryColor,
      headerBackgroundColor: other.headerBackgroundColor,
      headerTextColor: other.headerTextColor,
      headerIconColor: other.headerIconColor,
      headerTitleStyle: other.headerTitleStyle,
      weekdayHeaderStyle: other.weekdayHeaderStyle,
      dayStyle: other.dayStyle,
      weekendTextColor: other.weekendTextColor,
      disabledTextColor: other.disabledTextColor,
      todayColor: other.todayColor,
      todayBorderColor: other.todayBorderColor,
      selectedDayColor: other.selectedDayColor,
      eventColor: other.eventColor,
      eventStyle: other.eventStyle,
      eventBorderColor: other.eventBorderColor,
      eventBorderRadius: other.eventBorderRadius,
      eventShadow: other.eventShadow,
      bodyTextStyle: other.bodyTextStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrCalendarTheme &&
      other.backgroundColor == backgroundColor &&
      other.borderColor == borderColor &&
      other.borderWidth == borderWidth &&
      other.borderRadius == borderRadius &&
      other.primaryColor == primaryColor &&
      other.headerBackgroundColor == headerBackgroundColor &&
      other.headerTextColor == headerTextColor &&
      other.headerIconColor == headerIconColor &&
      other.headerTitleStyle == headerTitleStyle &&
      other.weekdayHeaderStyle == weekdayHeaderStyle &&
      other.dayStyle == dayStyle &&
      other.weekendTextColor == weekendTextColor &&
      other.disabledTextColor == disabledTextColor &&
      other.todayColor == todayColor &&
      other.todayBorderColor == todayBorderColor &&
      other.selectedDayColor == selectedDayColor &&
      other.eventColor == eventColor &&
      other.eventStyle == eventStyle &&
      other.eventBorderColor == eventBorderColor &&
      other.eventBorderRadius == eventBorderRadius &&
      other.eventShadow == eventShadow &&
      other.bodyTextStyle == bodyTextStyle;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      primaryColor,
      headerBackgroundColor,
      headerTextColor,
      headerIconColor,
      headerTitleStyle,
      weekdayHeaderStyle,
      dayStyle,
      weekendTextColor,
      disabledTextColor,
      todayColor,
      todayBorderColor,
      selectedDayColor,
      eventColor,
      eventStyle,
      eventBorderColor,
      eventBorderRadius,
      eventShadow,
      bodyTextStyle,
    ]);
  }
}