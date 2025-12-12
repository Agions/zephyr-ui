/// VelocityUI 日历组件样式
library velocity_calendar_style;

import 'package:flutter/material.dart';

/// VelocityUI 日历组件样式
class VelocityCalendarStyle {
  /// 创建日历样式
  VelocityCalendarStyle({
    this.backgroundColor = Colors.white,
    this.headerBackgroundColor = Colors.white,
    this.headerTextColor = Colors.black87,
    this.headerTitleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.headerSubtitleStyle = const TextStyle(
      fontSize: 14,
      color: Colors.grey,
    ),
    this.weekdayTextColor = const Color(0xFF4B5563),
    this.weekdayTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    this.dayTextColor = Colors.black87,
    this.dayTextStyle = const TextStyle(
      fontSize: 14,
    ),
    this.todayTextColor = Colors.blue,
    this.todayTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    this.todayBackgroundColor = const Color(0xFFEBF5FF),
    this.selectedTextColor = Colors.white,
    this.selectedTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    this.selectedBackgroundColor = Colors.blue,
    this.disabledTextColor = const Color(0xFFD1D5DB),
    this.disabledTextStyle = const TextStyle(
      fontSize: 14,
    ),
    this.outsideTextColor = const Color(0xFF9CA3AF),
    this.outsideTextStyle = const TextStyle(
      fontSize: 14,
    ),
    this.rangeTextColor = Colors.white,
    this.rangeTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    this.rangeBackgroundColor = const Color(0xFFEBF5FF),
    this.rangeStartEndBackgroundColor = Colors.blue,
    this.arrowColor = Colors.black87,
    this.borderColor = const Color(0xFFE5E7EB),
    this.borderWidth = 1.0,
    this.cellSize = 48.0,
    this.cellPadding = EdgeInsets.zero,
    this.headerPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.weekdayPadding = const EdgeInsets.symmetric(vertical: 8),
    this.dayPadding = EdgeInsets.zero,
    this.radius = 4.0,
    this.headerHeight = 56.0,
    this.weekdayHeight = 40.0,
    this.monthHeight = 320.0,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.showHeader = true,
    this.showWeekdays = true,
    this.showBorders = false,
    this.showToday = true,
    this.showMonthNavigator = true,
  });

  /// 默认样式
  static VelocityCalendarStyle defaults() => VelocityCalendarStyle();

  /// 背景颜色
  final Color backgroundColor;

  /// 头部背景颜色
  final Color headerBackgroundColor;

  /// 头部文本颜色
  final Color headerTextColor;

  /// 头部标题样式
  final TextStyle headerTitleStyle;

  /// 头部副标题样式
  final TextStyle headerSubtitleStyle;

  /// 星期文本颜色
  final Color weekdayTextColor;

  /// 星期文本样式
  final TextStyle weekdayTextStyle;

  /// 日期文本颜色
  final Color dayTextColor;

  /// 日期文本样式
  final TextStyle dayTextStyle;

  /// 今天文本颜色
  final Color todayTextColor;

  /// 今天文本样式
  final TextStyle todayTextStyle;

  /// 今天背景颜色
  final Color todayBackgroundColor;

  /// 选中日期文本颜色
  final Color selectedTextColor;

  /// 选中日期文本样式
  final TextStyle selectedTextStyle;

  /// 选中日期背景颜色
  final Color selectedBackgroundColor;

  /// 禁用日期文本颜色
  final Color disabledTextColor;

  /// 禁用日期文本样式
  final TextStyle disabledTextStyle;

  /// 月份外日期文本颜色
  final Color outsideTextColor;

  /// 月份外日期文本样式
  final TextStyle outsideTextStyle;

  /// 范围日期文本颜色
  final Color rangeTextColor;

  /// 范围日期文本样式
  final TextStyle rangeTextStyle;

  /// 范围日期背景颜色
  final Color rangeBackgroundColor;

  /// 范围开始和结束背景颜色
  final Color rangeStartEndBackgroundColor;

  /// 箭头颜色
  final Color arrowColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 单元格大小
  final double cellSize;

  /// 单元格内边距
  final EdgeInsets cellPadding;

  /// 头部内边距
  final EdgeInsets headerPadding;

  /// 星期内边距
  final EdgeInsets weekdayPadding;

  /// 日期内边距
  final EdgeInsets dayPadding;

  /// 圆角
  final double radius;

  /// 头部高度
  final double headerHeight;

  /// 星期行高度
  final double weekdayHeight;

  /// 月份高度
  final double monthHeight;

  /// 外边距
  final EdgeInsets margin;

  /// 内边距
  final EdgeInsets padding;

  /// 是否显示头部
  final bool showHeader;

  /// 是否显示星期
  final bool showWeekdays;

  /// 是否显示边框
  final bool showBorders;

  /// 是否显示今天
  final bool showToday;

  /// 是否显示月份导航
  final bool showMonthNavigator;

  /// 复制样式并替换指定属性
  VelocityCalendarStyle copyWith({
    Color? backgroundColor,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    TextStyle? headerTitleStyle,
    TextStyle? headerSubtitleStyle,
    Color? weekdayTextColor,
    TextStyle? weekdayTextStyle,
    Color? dayTextColor,
    TextStyle? dayTextStyle,
    Color? todayTextColor,
    TextStyle? todayTextStyle,
    Color? todayBackgroundColor,
    Color? selectedTextColor,
    TextStyle? selectedTextStyle,
    Color? selectedBackgroundColor,
    Color? disabledTextColor,
    TextStyle? disabledTextStyle,
    Color? outsideTextColor,
    TextStyle? outsideTextStyle,
    Color? rangeTextColor,
    TextStyle? rangeTextStyle,
    Color? rangeBackgroundColor,
    Color? rangeStartEndBackgroundColor,
    Color? arrowColor,
    Color? borderColor,
    double? borderWidth,
    double? cellSize,
    EdgeInsets? cellPadding,
    EdgeInsets? headerPadding,
    EdgeInsets? weekdayPadding,
    EdgeInsets? dayPadding,
    double? radius,
    double? headerHeight,
    double? weekdayHeight,
    double? monthHeight,
    EdgeInsets? margin,
    EdgeInsets? padding,
    bool? showHeader,
    bool? showWeekdays,
    bool? showBorders,
    bool? showToday,
    bool? showMonthNavigator,
  }) {
    return VelocityCalendarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      headerTitleStyle: headerTitleStyle ?? this.headerTitleStyle,
      headerSubtitleStyle: headerSubtitleStyle ?? this.headerSubtitleStyle,
      weekdayTextColor: weekdayTextColor ?? this.weekdayTextColor,
      weekdayTextStyle: weekdayTextStyle ?? this.weekdayTextStyle,
      dayTextColor: dayTextColor ?? this.dayTextColor,
      dayTextStyle: dayTextStyle ?? this.dayTextStyle,
      todayTextColor: todayTextColor ?? this.todayTextColor,
      todayTextStyle: todayTextStyle ?? this.todayTextStyle,
      todayBackgroundColor: todayBackgroundColor ?? this.todayBackgroundColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      outsideTextColor: outsideTextColor ?? this.outsideTextColor,
      outsideTextStyle: outsideTextStyle ?? this.outsideTextStyle,
      rangeTextColor: rangeTextColor ?? this.rangeTextColor,
      rangeTextStyle: rangeTextStyle ?? this.rangeTextStyle,
      rangeBackgroundColor: rangeBackgroundColor ?? this.rangeBackgroundColor,
      rangeStartEndBackgroundColor:
          rangeStartEndBackgroundColor ?? this.rangeStartEndBackgroundColor,
      arrowColor: arrowColor ?? this.arrowColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      cellSize: cellSize ?? this.cellSize,
      cellPadding: cellPadding ?? this.cellPadding,
      headerPadding: headerPadding ?? this.headerPadding,
      weekdayPadding: weekdayPadding ?? this.weekdayPadding,
      dayPadding: dayPadding ?? this.dayPadding,
      radius: radius ?? this.radius,
      headerHeight: headerHeight ?? this.headerHeight,
      weekdayHeight: weekdayHeight ?? this.weekdayHeight,
      monthHeight: monthHeight ?? this.monthHeight,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      showHeader: showHeader ?? this.showHeader,
      showWeekdays: showWeekdays ?? this.showWeekdays,
      showBorders: showBorders ?? this.showBorders,
      showToday: showToday ?? this.showToday,
      showMonthNavigator: showMonthNavigator ?? this.showMonthNavigator,
    );
  }
}

/// 日历选择模式
enum VelocityCalendarSelectionMode {
  /// 单选
  single,

  /// 范围选择
  range,

  /// 多选
  multiple,

  /// 无选择
  none,
}

/// 日历视图模式
enum VelocityCalendarViewMode {
  /// 月视图
  month,

  /// 年视图
  year,

  /// 十年视图
  decade,
}
