import 'package:flutter/material.dart';

/// 日历头部样式
class HeaderStyle {
  const HeaderStyle({
    this.textStyle,
    this.padding,
    this.backgroundColor,
  });

  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
}

/// 星期样式
class DaysOfWeekStyle {
  const DaysOfWeekStyle({
    this.textStyle,
    this.padding,
    this.weekendTextStyle,
  });

  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final TextStyle? weekendTextStyle;
}

/// 日历样式
class CalendarStyle {
  const CalendarStyle({
    this.textStyle,
    this.padding,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.todayBackgroundColor,
  });

  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? todayBackgroundColor;
}

/// ZephyrUI 日历主题
class ZephyrCalendarTheme {
  const ZephyrCalendarTheme({
    this.headerStyle,
    this.daysOfWeekStyle,
    this.calendarStyle,
  });

  final HeaderStyle? headerStyle;
  final DaysOfWeekStyle? daysOfWeekStyle;
  final CalendarStyle? calendarStyle;
}
