import 'package:flutter/material.dart';

/// ZephyrUI 列表主题配置
///
/// 定义列表组件的视觉样式，包括颜色、字体、边框等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrListTheme {
  /// 背景颜色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 分割线颜色
  final Color dividerColor;

  /// 标题文本样式
  final TextStyle titleStyle;

  /// 副标题文本样式
  final TextStyle subtitleStyle;

  /// 描述文本样式
  final TextStyle descriptionStyle;

  /// 附加信息文本样式
  final TextStyle extraTextStyle;

  /// 选中项背景颜色
  final Color selectedItemColor;

  /// 悬停项背景颜色
  final Color hoverItemColor;

  /// 禁用文本颜色
  final Color disabledTextColor;

  /// 分组背景颜色
  final Color groupBackgroundColor;

  /// 分组标题样式
  final TextStyle groupTitleStyle;

  /// 分组描述样式
  final TextStyle groupDescriptionStyle;

  /// 加载文本样式
  final TextStyle loadingTextStyle;

  /// 空数据文本样式
  final TextStyle emptyTextStyle;

  /// 加载更多文本样式
  final TextStyle loadMoreTextStyle;

  /// 拖拽手柄颜色
  final Color dragHandleColor;

  /// 主色调
  final Color primaryColor;

  /// 创建列表主题
  const ZephyrListTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.dividerColor,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.descriptionStyle,
    required this.extraTextStyle,
    required this.selectedItemColor,
    required this.hoverItemColor,
    required this.disabledTextColor,
    required this.groupBackgroundColor,
    required this.groupTitleStyle,
    required this.groupDescriptionStyle,
    required this.loadingTextStyle,
    required this.emptyTextStyle,
    required this.loadMoreTextStyle,
    required this.dragHandleColor,
    required this.primaryColor,
  });

  /// 创建明亮的列表主题
  factory ZephyrListTheme.light() {
    return ZephyrListTheme(
      backgroundColor: Colors.white,
      borderColor: const Color(0xFFE5E7EB),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(8.0),
      dividerColor: const Color(0xFFF3F4F6),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF111827),
      ),
      subtitleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      extraTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      selectedItemColor: const Color(0xFFEFF6FF),
      hoverItemColor: const Color(0xFFF9FAFB),
      disabledTextColor: const Color(0xFFD1D5DB),
      groupBackgroundColor: const Color(0xFFF9FAFB),
      groupTitleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF374151),
      ),
      groupDescriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
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
      loadMoreTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      dragHandleColor: const Color(0xFF9CA3AF),
      primaryColor: const Color(0xFF3B82F6),
    );
  }

  /// 创建暗色的列表主题
  factory ZephyrListTheme.dark() {
    return ZephyrListTheme(
      backgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(8.0),
      dividerColor: const Color(0xFF374151),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFFF9FAFB),
      ),
      subtitleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      extraTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      selectedItemColor: const Color(0xFF1E3A8A),
      hoverItemColor: const Color(0xFF374151),
      disabledTextColor: const Color(0xFF4B5563),
      groupBackgroundColor: const Color(0xFF374151),
      groupTitleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF9FAFB),
      ),
      groupDescriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
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
      loadMoreTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      dragHandleColor: const Color(0xFF6B7280),
      primaryColor: const Color(0xFF60A5FA),
    );
  }

  /// 创建自定义列表主题
  factory ZephyrListTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? dividerColor,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? descriptionStyle,
    TextStyle? extraTextStyle,
    Color? selectedItemColor,
    Color? hoverItemColor,
    Color? disabledTextColor,
    Color? groupBackgroundColor,
    TextStyle? groupTitleStyle,
    TextStyle? groupDescriptionStyle,
    TextStyle? loadingTextStyle,
    TextStyle? emptyTextStyle,
    TextStyle? loadMoreTextStyle,
    Color? dragHandleColor,
    Color? primaryColor,
  }) {
    final baseTheme = ZephyrListTheme.light();
    
    return ZephyrListTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      dividerColor: dividerColor ?? baseTheme.dividerColor,
      titleStyle: titleStyle ?? baseTheme.titleStyle,
      subtitleStyle: subtitleStyle ?? baseTheme.subtitleStyle,
      descriptionStyle: descriptionStyle ?? baseTheme.descriptionStyle,
      extraTextStyle: extraTextStyle ?? baseTheme.extraTextStyle,
      selectedItemColor: selectedItemColor ?? baseTheme.selectedItemColor,
      hoverItemColor: hoverItemColor ?? baseTheme.hoverItemColor,
      disabledTextColor: disabledTextColor ?? baseTheme.disabledTextColor,
      groupBackgroundColor: groupBackgroundColor ?? baseTheme.groupBackgroundColor,
      groupTitleStyle: groupTitleStyle ?? baseTheme.groupTitleStyle,
      groupDescriptionStyle: groupDescriptionStyle ?? baseTheme.groupDescriptionStyle,
      loadingTextStyle: loadingTextStyle ?? baseTheme.loadingTextStyle,
      emptyTextStyle: emptyTextStyle ?? baseTheme.emptyTextStyle,
      loadMoreTextStyle: loadMoreTextStyle ?? baseTheme.loadMoreTextStyle,
      dragHandleColor: dragHandleColor ?? baseTheme.dragHandleColor,
      primaryColor: primaryColor ?? baseTheme.primaryColor,
    );
  }

  /// 复制主题并修改部分属性
  ZephyrListTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? dividerColor,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? descriptionStyle,
    TextStyle? extraTextStyle,
    Color? selectedItemColor,
    Color? hoverItemColor,
    Color? disabledTextColor,
    Color? groupBackgroundColor,
    TextStyle? groupTitleStyle,
    TextStyle? groupDescriptionStyle,
    TextStyle? loadingTextStyle,
    TextStyle? emptyTextStyle,
    TextStyle? loadMoreTextStyle,
    Color? dragHandleColor,
    Color? primaryColor,
  }) {
    return ZephyrListTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      dividerColor: dividerColor ?? this.dividerColor,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      extraTextStyle: extraTextStyle ?? this.extraTextStyle,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      hoverItemColor: hoverItemColor ?? this.hoverItemColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      groupBackgroundColor: groupBackgroundColor ?? this.groupBackgroundColor,
      groupTitleStyle: groupTitleStyle ?? this.groupTitleStyle,
      groupDescriptionStyle: groupDescriptionStyle ?? this.groupDescriptionStyle,
      loadingTextStyle: loadingTextStyle ?? this.loadingTextStyle,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      loadMoreTextStyle: loadMoreTextStyle ?? this.loadMoreTextStyle,
      dragHandleColor: dragHandleColor ?? this.dragHandleColor,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }

  /// 主题合并
  ZephyrListTheme merge(ZephyrListTheme? other) {
    if (other == null) return this;
    
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      dividerColor: other.dividerColor,
      titleStyle: other.titleStyle,
      subtitleStyle: other.subtitleStyle,
      descriptionStyle: other.descriptionStyle,
      extraTextStyle: other.extraTextStyle,
      selectedItemColor: other.selectedItemColor,
      hoverItemColor: other.hoverItemColor,
      disabledTextColor: other.disabledTextColor,
      groupBackgroundColor: other.groupBackgroundColor,
      groupTitleStyle: other.groupTitleStyle,
      groupDescriptionStyle: other.groupDescriptionStyle,
      loadingTextStyle: other.loadingTextStyle,
      emptyTextStyle: other.emptyTextStyle,
      loadMoreTextStyle: other.loadMoreTextStyle,
      dragHandleColor: other.dragHandleColor,
      primaryColor: other.primaryColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrListTheme &&
      other.backgroundColor == backgroundColor &&
      other.borderColor == borderColor &&
      other.borderWidth == borderWidth &&
      other.borderRadius == borderRadius &&
      other.dividerColor == dividerColor &&
      other.titleStyle == titleStyle &&
      other.subtitleStyle == subtitleStyle &&
      other.descriptionStyle == descriptionStyle &&
      other.extraTextStyle == extraTextStyle &&
      other.selectedItemColor == selectedItemColor &&
      other.hoverItemColor == hoverItemColor &&
      other.disabledTextColor == disabledTextColor &&
      other.groupBackgroundColor == groupBackgroundColor &&
      other.groupTitleStyle == groupTitleStyle &&
      other.groupDescriptionStyle == groupDescriptionStyle &&
      other.loadingTextStyle == loadingTextStyle &&
      other.emptyTextStyle == emptyTextStyle &&
      other.loadMoreTextStyle == loadMoreTextStyle &&
      other.dragHandleColor == dragHandleColor &&
      other.primaryColor == primaryColor;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      dividerColor,
      titleStyle,
      subtitleStyle,
      descriptionStyle,
      extraTextStyle,
      selectedItemColor,
      hoverItemColor,
      disabledTextColor,
      groupBackgroundColor,
      groupTitleStyle,
      groupDescriptionStyle,
      loadingTextStyle,
      emptyTextStyle,
      loadMoreTextStyle,
      dragHandleColor,
      primaryColor,
    ]);
  }
}