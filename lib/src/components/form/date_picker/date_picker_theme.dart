import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 日期选择器主题
class ZephyrDatePickerTheme {
  /// 主色调，用于选中日期和当前日期
  final Color primaryColor;

  /// 选中日期背景色
  final Color selectedDateBackgroundColor;

  /// 选中日期文字颜色
  final Color selectedDateTextColor;

  /// 当前日期背景色
  final Color currentDateBackgroundColor;

  /// 当前日期文字颜色
  final Color currentDateTextColor;

  /// 日期文字颜色
  final Color dateTextColor;

  /// 禁用日期文字颜色
  final Color disabledDateTextColor;

  /// 周末日期文字颜色
  final Color weekendDateTextColor;

  /// 范围内日期背景色
  final Color rangeDateBackgroundColor;

  /// 头部背景色
  final Color headerBackgroundColor;

  /// 头部文字颜色
  final Color headerTextColor;

  /// 头部年份文字样式
  final TextStyle headerYearStyle;

  /// 头部月份文字样式
  final TextStyle headerMonthStyle;

  /// 星期标题文字样式
  final TextStyle weekdayStyle;

  /// 日期文字样式
  final TextStyle dateStyle;

  /// 选中日期文字样式
  final TextStyle selectedDateStyle;

  /// 当月日期单元格大小
  final double dateCellSize;

  /// 日期单元格间距
  final double dateCellSpacing;

  /// 日期单元格边框圆角
  final double dateCellBorderRadius;

  /// 确认按钮文字
  final String confirmButtonText;

  /// 取消按钮文字
  final String cancelButtonText;

  /// 重置按钮文字
  final String resetButtonText;

  /// 按钮文字样式
  final TextStyle buttonTextStyle;

  /// 按钮禁用文字样式
  final TextStyle disabledButtonTextStyle;

  /// 构造函数
  const ZephyrDatePickerTheme({
    required this.primaryColor,
    required this.selectedDateBackgroundColor,
    required this.selectedDateTextColor,
    required this.currentDateBackgroundColor,
    required this.currentDateTextColor,
    required this.dateTextColor,
    required this.disabledDateTextColor,
    required this.weekendDateTextColor,
    required this.rangeDateBackgroundColor,
    required this.headerBackgroundColor,
    required this.headerTextColor,
    required this.headerYearStyle,
    required this.headerMonthStyle,
    required this.weekdayStyle,
    required this.dateStyle,
    required this.selectedDateStyle,
    this.dateCellSize = 36.0,
    this.dateCellSpacing = 2.0,
    this.dateCellBorderRadius = 4.0,
    this.confirmButtonText = '确定',
    this.cancelButtonText = '取消',
    this.resetButtonText = '重置',
    required this.buttonTextStyle,
    required this.disabledButtonTextStyle,
  });

  /// 从上下文中获取主题
  static ZephyrDatePickerTheme of(BuildContext context) {
    final ZephyrTheme? theme =
        context.dependOnInheritedWidgetOfExactType<ZephyrTheme>();
    return theme?.data.datePickerTheme ??
        ZephyrDatePickerTheme(
          primaryColor: Colors.blue,
          selectedDateBackgroundColor: Colors.blue,
          selectedDateTextColor: Colors.white,
          currentDateBackgroundColor: Colors.blue.withValues(alpha: 0.1),
          currentDateTextColor: Colors.blue,
          dateTextColor: Colors.black87,
          disabledDateTextColor: Colors.black38,
          weekendDateTextColor: Colors.red.shade300,
          rangeDateBackgroundColor: Colors.blue.withValues(alpha: 0.2),
          headerBackgroundColor: Colors.blue.shade50,
          headerTextColor: Colors.black87,
          headerYearStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black54,
          ),
          headerMonthStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          weekdayStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
          dateStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          selectedDateStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          buttonTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
          disabledButtonTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        );
  }

  /// 创建主题的副本并更新指定的属性
  ZephyrDatePickerTheme copyWith({
    Color? primaryColor,
    Color? selectedDateBackgroundColor,
    Color? selectedDateTextColor,
    Color? currentDateBackgroundColor,
    Color? currentDateTextColor,
    Color? dateTextColor,
    Color? disabledDateTextColor,
    Color? weekendDateTextColor,
    Color? rangeDateBackgroundColor,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    TextStyle? headerYearStyle,
    TextStyle? headerMonthStyle,
    TextStyle? weekdayStyle,
    TextStyle? dateStyle,
    TextStyle? selectedDateStyle,
    double? dateCellSize,
    double? dateCellSpacing,
    double? dateCellBorderRadius,
    String? confirmButtonText,
    String? cancelButtonText,
    String? resetButtonText,
    TextStyle? buttonTextStyle,
    TextStyle? disabledButtonTextStyle,
  }) {
    return ZephyrDatePickerTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      selectedDateBackgroundColor:
          selectedDateBackgroundColor ?? this.selectedDateBackgroundColor,
      selectedDateTextColor:
          selectedDateTextColor ?? this.selectedDateTextColor,
      currentDateBackgroundColor:
          currentDateBackgroundColor ?? this.currentDateBackgroundColor,
      currentDateTextColor: currentDateTextColor ?? this.currentDateTextColor,
      dateTextColor: dateTextColor ?? this.dateTextColor,
      disabledDateTextColor:
          disabledDateTextColor ?? this.disabledDateTextColor,
      weekendDateTextColor: weekendDateTextColor ?? this.weekendDateTextColor,
      rangeDateBackgroundColor:
          rangeDateBackgroundColor ?? this.rangeDateBackgroundColor,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      headerYearStyle: headerYearStyle ?? this.headerYearStyle,
      headerMonthStyle: headerMonthStyle ?? this.headerMonthStyle,
      weekdayStyle: weekdayStyle ?? this.weekdayStyle,
      dateStyle: dateStyle ?? this.dateStyle,
      selectedDateStyle: selectedDateStyle ?? this.selectedDateStyle,
      dateCellSize: dateCellSize ?? this.dateCellSize,
      dateCellSpacing: dateCellSpacing ?? this.dateCellSpacing,
      dateCellBorderRadius: dateCellBorderRadius ?? this.dateCellBorderRadius,
      confirmButtonText: confirmButtonText ?? this.confirmButtonText,
      cancelButtonText: cancelButtonText ?? this.cancelButtonText,
      resetButtonText: resetButtonText ?? this.resetButtonText,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      disabledButtonTextStyle:
          disabledButtonTextStyle ?? this.disabledButtonTextStyle,
    );
  }
}
