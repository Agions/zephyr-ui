import 'package:flutter/material.dart';

/// ZephyrUI 数据网格主题配置
///
/// 定义数据网格组件的视觉样式，包括颜色、字体、边框等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrDataGridTheme {
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
  
  /// 选中单元格背景颜色
  final Color selectedCellColor;
  
  /// 斑马纹行颜色
  final Color stripedRowColor;
  
  /// 悬停单元格背景颜色
  final Color hoverCellColor;
  
  /// 编辑单元格背景颜色
  final Color editingCellColor;
  
  /// 错误单元格背景颜色
  final Color errorCellColor;
  
  /// 行号背景颜色
  final Color rowNumberBackgroundColor;
  
  /// 行号文本样式
  final TextStyle rowNumberTextStyle;
  
  /// 空数据文本样式
  final TextStyle emptyTextStyle;
  
  /// 调整器颜色
  final Color resizerColor;
  
  /// 主色调
  final Color primaryColor;
  
  /// 创建数据网格主题
  const ZephyrDataGridTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.headerBackgroundColor,
    required this.headerTextStyle,
    required this.headerIconColor,
    required this.cellTextStyle,
    required this.selectedCellColor,
    required this.stripedRowColor,
    required this.hoverCellColor,
    required this.editingCellColor,
    required this.errorCellColor,
    required this.rowNumberBackgroundColor,
    required this.rowNumberTextStyle,
    required this.emptyTextStyle,
    required this.resizerColor,
    required this.primaryColor,
  });

  /// 创建明亮的数据网格主题
  factory ZephyrDataGridTheme.light() {
    return ZephyrDataGridTheme(
      backgroundColor: Colors.white,
      borderColor: const Color(0xFFE5E7EB),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(8.0),
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
        color: Color(0xFF111827),
      ),
      selectedCellColor: const Color(0xFFEFF6FF),
      stripedRowColor: const Color(0xFFF9FAFB),
      hoverCellColor: const Color(0xFFF3F4F6),
      editingCellColor: const Color(0xFFFEF3C7),
      errorCellColor: const Color(0xFFFEE2E2),
      rowNumberBackgroundColor: const Color(0xFFF9FAFB),
      rowNumberTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF6B7280),
      ),
      emptyTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      resizerColor: const Color(0xFFD1D5DB),
      primaryColor: const Color(0xFF3B82F6),
    );
  }

  /// 创建暗色的数据网格主题
  factory ZephyrDataGridTheme.dark() {
    return ZephyrDataGridTheme(
      backgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(8.0),
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
      selectedCellColor: const Color(0xFF1E3A8A),
      stripedRowColor: const Color(0xFF374151),
      hoverCellColor: const Color(0xFF4B5563),
      editingCellColor: const Color(0xFF78350F),
      errorCellColor: const Color(0xFF991B1B),
      rowNumberBackgroundColor: const Color(0xFF374151),
      rowNumberTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF9CA3AF),
      ),
      emptyTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      resizerColor: const Color(0xFF6B7280),
      primaryColor: const Color(0xFF60A5FA),
    );
  }

  /// 创建自定义数据网格主题
  factory ZephyrDataGridTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? headerBackgroundColor,
    TextStyle? headerTextStyle,
    Color? headerIconColor,
    TextStyle? cellTextStyle,
    Color? selectedCellColor,
    Color? stripedRowColor,
    Color? hoverCellColor,
    Color? editingCellColor,
    Color? errorCellColor,
    Color? rowNumberBackgroundColor,
    TextStyle? rowNumberTextStyle,
    TextStyle? emptyTextStyle,
    Color? resizerColor,
    Color? primaryColor,
  }) {
    final baseTheme = ZephyrDataGridTheme.light();
    
    return ZephyrDataGridTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      headerBackgroundColor: headerBackgroundColor ?? baseTheme.headerBackgroundColor,
      headerTextStyle: headerTextStyle ?? baseTheme.headerTextStyle,
      headerIconColor: headerIconColor ?? baseTheme.headerIconColor,
      cellTextStyle: cellTextStyle ?? baseTheme.cellTextStyle,
      selectedCellColor: selectedCellColor ?? baseTheme.selectedCellColor,
      stripedRowColor: stripedRowColor ?? baseTheme.stripedRowColor,
      hoverCellColor: hoverCellColor ?? baseTheme.hoverCellColor,
      editingCellColor: editingCellColor ?? baseTheme.editingCellColor,
      errorCellColor: errorCellColor ?? baseTheme.errorCellColor,
      rowNumberBackgroundColor: rowNumberBackgroundColor ?? baseTheme.rowNumberBackgroundColor,
      rowNumberTextStyle: rowNumberTextStyle ?? baseTheme.rowNumberTextStyle,
      emptyTextStyle: emptyTextStyle ?? baseTheme.emptyTextStyle,
      resizerColor: resizerColor ?? baseTheme.resizerColor,
      primaryColor: primaryColor ?? baseTheme.primaryColor,
    );
  }

  /// 复制主题并修改部分属性
  ZephyrDataGridTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? headerBackgroundColor,
    TextStyle? headerTextStyle,
    Color? headerIconColor,
    TextStyle? cellTextStyle,
    Color? selectedCellColor,
    Color? stripedRowColor,
    Color? hoverCellColor,
    Color? editingCellColor,
    Color? errorCellColor,
    Color? rowNumberBackgroundColor,
    TextStyle? rowNumberTextStyle,
    TextStyle? emptyTextStyle,
    Color? resizerColor,
    Color? primaryColor,
  }) {
    return ZephyrDataGridTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      headerBackgroundColor: headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      headerIconColor: headerIconColor ?? this.headerIconColor,
      cellTextStyle: cellTextStyle ?? this.cellTextStyle,
      selectedCellColor: selectedCellColor ?? this.selectedCellColor,
      stripedRowColor: stripedRowColor ?? this.stripedRowColor,
      hoverCellColor: hoverCellColor ?? this.hoverCellColor,
      editingCellColor: editingCellColor ?? this.editingCellColor,
      errorCellColor: errorCellColor ?? this.errorCellColor,
      rowNumberBackgroundColor: rowNumberBackgroundColor ?? this.rowNumberBackgroundColor,
      rowNumberTextStyle: rowNumberTextStyle ?? this.rowNumberTextStyle,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      resizerColor: resizerColor ?? this.resizerColor,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }

  /// 主题合并
  ZephyrDataGridTheme merge(ZephyrDataGridTheme? other) {
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
      selectedCellColor: other.selectedCellColor,
      stripedRowColor: other.stripedRowColor,
      hoverCellColor: other.hoverCellColor,
      editingCellColor: other.editingCellColor,
      errorCellColor: other.errorCellColor,
      rowNumberBackgroundColor: other.rowNumberBackgroundColor,
      rowNumberTextStyle: other.rowNumberTextStyle,
      emptyTextStyle: other.emptyTextStyle,
      resizerColor: other.resizerColor,
      primaryColor: other.primaryColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrDataGridTheme &&
      other.backgroundColor == backgroundColor &&
      other.borderColor == borderColor &&
      other.borderWidth == borderWidth &&
      other.borderRadius == borderRadius &&
      other.headerBackgroundColor == headerBackgroundColor &&
      other.headerTextStyle == headerTextStyle &&
      other.headerIconColor == headerIconColor &&
      other.cellTextStyle == cellTextStyle &&
      other.selectedCellColor == selectedCellColor &&
      other.stripedRowColor == stripedRowColor &&
      other.hoverCellColor == hoverCellColor &&
      other.editingCellColor == editingCellColor &&
      other.errorCellColor == errorCellColor &&
      other.rowNumberBackgroundColor == rowNumberBackgroundColor &&
      other.rowNumberTextStyle == rowNumberTextStyle &&
      other.emptyTextStyle == emptyTextStyle &&
      other.resizerColor == resizerColor &&
      other.primaryColor == primaryColor;
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
      selectedCellColor,
      stripedRowColor,
      hoverCellColor,
      editingCellColor,
      errorCellColor,
      rowNumberBackgroundColor,
      rowNumberTextStyle,
      emptyTextStyle,
      resizerColor,
      primaryColor,
    ]);
  }
}