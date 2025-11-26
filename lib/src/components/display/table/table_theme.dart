import 'package:flutter/material.dart';

/// ZephyrUI 表格主题配置
///
/// 定义表格组件的视觉样式，包括颜色、字体、边框等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrTableTheme {
  /// 创建表格主题
  const ZephyrTableTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.headerBackgroundColor,
    required this.headerTextStyle,
    required this.headerIconColor,
    required this.cellTextStyle,
    required this.selectedRowColor,
    required this.stripedRowColor,
    required this.footerBackgroundColor,
    required this.paginationTextStyle,
    required this.paginationTextColor,
    required this.paginationIconColor,
    required this.loadingTextStyle,
    required this.emptyTextStyle,
    required this.primaryColor,
    required this.hoverRowColor,
    required this.sortIconColor,
    required this.filterIconColor,
  });

  /// 创建明亮的表格主题
  factory ZephyrTableTheme.light() {
    return ZephyrTableTheme(
      backgroundColor: Colors.white,
      borderColor: const Color(0xFFE5E7EB),
      borderWidth: 1.0,
      borderRadius: const BorderRadius.circular(8.0),
      headerBackgroundColor: const Color(0xFFF9FAFB),
      headerTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF374151),
      ),
      headerIconColor: const Color(0xFF6B7280),
      cellTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF374151),
      ),
      selectedRowColor: const Color(0xFFEFF6FF),
      stripedRowColor: const Color(0xFFFAFAFA),
      footerBackgroundColor: const Color(0xFFF9FAFB),
      paginationTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      paginationTextColor: const Color(0xFF374151),
      paginationIconColor: const Color(0xFF6B7280),
      loadingTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      emptyTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      primaryColor: const Color(0xFF3B82F6),
      hoverRowColor: const Color(0xFFF3F4F6),
      sortIconColor: const Color(0xFF6B7280),
      filterIconColor: const Color(0xFF6B7280),
    );
  }

  /// 创建暗色的表格主题
  factory ZephyrTableTheme.dark() {
    return ZephyrTableTheme(
      backgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      borderWidth: 1.0,
      borderRadius: const BorderRadius.circular(8.0),
      headerBackgroundColor: const Color(0xFF374151),
      headerTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF9FAFB),
      ),
      headerIconColor: const Color(0xFF9CA3AF),
      cellTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFF9FAFB),
      ),
      selectedRowColor: const Color(0xFF1E3A8A),
      stripedRowColor: const Color(0xFF374151),
      footerBackgroundColor: const Color(0xFF374151),
      paginationTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      paginationTextColor: const Color(0xFFF9FAFB),
      paginationIconColor: const Color(0xFF9CA3AF),
      loadingTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      emptyTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      primaryColor: const Color(0xFF60A5FA),
      hoverRowColor: const Color(0xFF374151),
      sortIconColor: const Color(0xFF9CA3AF),
      filterIconColor: const Color(0xFF9CA3AF),
    );
  }

  /// 创建自定义表格主题
  factory ZephyrTableTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? headerBackgroundColor,
    TextStyle? headerTextStyle,
    Color? headerIconColor,
    TextStyle? cellTextStyle,
    Color? selectedRowColor,
    Color? stripedRowColor,
    Color? footerBackgroundColor,
    TextStyle? paginationTextStyle,
    Color? paginationTextColor,
    Color? paginationIconColor,
    TextStyle? loadingTextStyle,
    TextStyle? emptyTextStyle,
    Color? primaryColor,
    Color? hoverRowColor,
    Color? sortIconColor,
    Color? filterIconColor,
  }) {
    final baseTheme = ZephyrTableTheme.light();

    return ZephyrTableTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      headerBackgroundColor:
          headerBackgroundColor ?? baseTheme.headerBackgroundColor,
      headerTextStyle: headerTextStyle ?? baseTheme.headerTextStyle,
      headerIconColor: headerIconColor ?? baseTheme.headerIconColor,
      cellTextStyle: cellTextStyle ?? baseTheme.cellTextStyle,
      selectedRowColor: selectedRowColor ?? baseTheme.selectedRowColor,
      stripedRowColor: stripedRowColor ?? baseTheme.stripedRowColor,
      footerBackgroundColor:
          footerBackgroundColor ?? baseTheme.footerBackgroundColor,
      paginationTextStyle: paginationTextStyle ?? baseTheme.paginationTextStyle,
      paginationTextColor: paginationTextColor ?? baseTheme.paginationTextColor,
      paginationIconColor: paginationIconColor ?? baseTheme.paginationIconColor,
      loadingTextStyle: loadingTextStyle ?? baseTheme.loadingTextStyle,
      emptyTextStyle: emptyTextStyle ?? baseTheme.emptyTextStyle,
      primaryColor: primaryColor ?? baseTheme.primaryColor,
      hoverRowColor: hoverRowColor ?? baseTheme.hoverRowColor,
      sortIconColor: sortIconColor ?? baseTheme.sortIconColor,
      filterIconColor: filterIconColor ?? baseTheme.filterIconColor,
    );
  }

  /// 背景颜色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 表头背景颜色
  final Color headerBackgroundColor;

  /// 表头文本样式
  final TextStyle headerTextStyle;

  /// 表头图标颜色
  final Color headerIconColor;

  /// 单元格文本样式
  final TextStyle cellTextStyle;

  /// 选中行背景颜色
  final Color selectedRowColor;

  /// 斑马纹行背景颜色
  final Color stripedRowColor;

  /// 页脚背景颜色
  final Color footerBackgroundColor;

  /// 分页文本样式
  final TextStyle paginationTextStyle;

  /// 分页文本颜色
  final Color paginationTextColor;

  /// 分页图标颜色
  final Color paginationIconColor;

  /// 加载文本样式
  final TextStyle loadingTextStyle;

  /// 空数据文本样式
  final TextStyle emptyTextStyle;

  /// 主色调
  final Color primaryColor;

  /// 悬停行背景颜色
  final Color hoverRowColor;

  /// 排序图标颜色
  final Color sortIconColor;

  /// 筛选图标颜色
  final Color filterIconColor;

  /// 复制主题并修改部分属性
  ZephyrTableTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? headerBackgroundColor,
    TextStyle? headerTextStyle,
    Color? headerIconColor,
    TextStyle? cellTextStyle,
    Color? selectedRowColor,
    Color? stripedRowColor,
    Color? footerBackgroundColor,
    TextStyle? paginationTextStyle,
    Color? paginationTextColor,
    Color? paginationIconColor,
    TextStyle? loadingTextStyle,
    TextStyle? emptyTextStyle,
    Color? primaryColor,
    Color? hoverRowColor,
    Color? sortIconColor,
    Color? filterIconColor,
  }) {
    return ZephyrTableTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      headerIconColor: headerIconColor ?? this.headerIconColor,
      cellTextStyle: cellTextStyle ?? this.cellTextStyle,
      selectedRowColor: selectedRowColor ?? this.selectedRowColor,
      stripedRowColor: stripedRowColor ?? this.stripedRowColor,
      footerBackgroundColor:
          footerBackgroundColor ?? this.footerBackgroundColor,
      paginationTextStyle: paginationTextStyle ?? this.paginationTextStyle,
      paginationTextColor: paginationTextColor ?? this.paginationTextColor,
      paginationIconColor: paginationIconColor ?? this.paginationIconColor,
      loadingTextStyle: loadingTextStyle ?? this.loadingTextStyle,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      primaryColor: primaryColor ?? this.primaryColor,
      hoverRowColor: hoverRowColor ?? this.hoverRowColor,
      sortIconColor: sortIconColor ?? this.sortIconColor,
      filterIconColor: filterIconColor ?? this.filterIconColor,
    );
  }

  /// 主题合并
  ZephyrTableTheme merge(ZephyrTableTheme? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      headerBackgroundColor: other.headerBackgroundColor,
      headerTextStyle: other.headerTextStyle,
      headerIconColor: other.headerIconColor,
      cellTextStyle: other.cellTextStyle,
      selectedRowColor: other.selectedRowColor,
      stripedRowColor: other.stripedRowColor,
      footerBackgroundColor: other.footerBackgroundColor,
      paginationTextStyle: other.paginationTextStyle,
      paginationTextColor: other.paginationTextColor,
      paginationIconColor: other.paginationIconColor,
      loadingTextStyle: other.loadingTextStyle,
      emptyTextStyle: other.emptyTextStyle,
      primaryColor: other.primaryColor,
      hoverRowColor: other.hoverRowColor,
      sortIconColor: other.sortIconColor,
      filterIconColor: other.filterIconColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ZephyrTableTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.headerBackgroundColor == headerBackgroundColor &&
        other.headerTextStyle == headerTextStyle &&
        other.headerIconColor == headerIconColor &&
        other.cellTextStyle == cellTextStyle &&
        other.selectedRowColor == selectedRowColor &&
        other.stripedRowColor == stripedRowColor &&
        other.footerBackgroundColor == footerBackgroundColor &&
        other.paginationTextStyle == paginationTextStyle &&
        other.paginationTextColor == paginationTextColor &&
        other.paginationIconColor == paginationIconColor &&
        other.loadingTextStyle == loadingTextStyle &&
        other.emptyTextStyle == emptyTextStyle &&
        other.primaryColor == primaryColor &&
        other.hoverRowColor == hoverRowColor &&
        other.sortIconColor == sortIconColor &&
        other.filterIconColor == filterIconColor;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      headerBackgroundColor,
      headerTextStyle,
      headerIconColor,
      cellTextStyle,
      selectedRowColor,
      stripedRowColor,
      footerBackgroundColor,
      paginationTextStyle,
      paginationTextColor,
      paginationIconColor,
      loadingTextStyle,
      emptyTextStyle,
      primaryColor,
      hoverRowColor,
      sortIconColor,
      filterIconColor,
    ]);
  }
}
