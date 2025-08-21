/// ZephyrUI 手风琴主题
/// 
/// 定义手风琴组件的主题样式。
library accordion_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 手风琴主题
class ZephyrAccordionTheme {
  /// 创建手风琴主题
  const ZephyrAccordionTheme({
    this.backgroundColor = Colors.white,
    this.expandedBackgroundColor = const Color(0xFFF8F9FA),
    this.borderColor = const Color(0xFFE9ECEF),
    this.titlePadding = const EdgeInsets.all(16),
    this.contentPadding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.titleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF212529),
    ),
    this.contentStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF6C757D),
    ),
  });

  /// 背景色
  final Color backgroundColor;

  /// 展开时的背景色
  final Color expandedBackgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 标题内边距
  final EdgeInsets titlePadding;

  /// 内容内边距
  final EdgeInsets contentPadding;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 标题样式
  final TextStyle titleStyle;

  /// 内容样式
  final TextStyle contentStyle;

  /// 禁用状态主题
  ZephyrAccordionTheme get disabled {
    return ZephyrAccordionTheme(
      backgroundColor: backgroundColor.withValues(alpha: 0.6),
      expandedBackgroundColor: expandedBackgroundColor.withValues(alpha: 0.6),
      borderColor: borderColor.withValues(alpha: 0.4),
      titlePadding: titlePadding,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      titleStyle: titleStyle.copyWith(
        color: titleStyle.color?.withValues(alpha: 0.6),
      ),
      contentStyle: contentStyle.copyWith(
        color: contentStyle.color?.withValues(alpha: 0.6),
      ),
    );
  }

  /// 从上下文获取主题
  static ZephyrAccordionTheme of(BuildContext context) {
    return ZephyrTheme.of(context).accordionTheme ?? const ZephyrAccordionTheme();
  }

  /// 创建亮色主题
  static ZephyrAccordionTheme light() {
    return const ZephyrAccordionTheme(
      backgroundColor: Colors.white,
      expandedBackgroundColor: Color(0xFFF8F9FA),
      borderColor: Color(0xFFE9ECEF),
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF212529),
      ),
      contentStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF6C757D),
      ),
    );
  }

  /// 创建暗色主题
  static ZephyrAccordionTheme dark() {
    return const ZephyrAccordionTheme(
      backgroundColor: Color(0xFF2D3748),
      expandedBackgroundColor: Color(0xFF1A202C),
      borderColor: Color(0xFF4A5568),
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFFF7FAFC),
      ),
      contentStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFFCBD5E0),
      ),
    );
  }

  /// 复制主题并修改属性
  ZephyrAccordionTheme copyWith({
    Color? backgroundColor,
    Color? expandedBackgroundColor,
    Color? borderColor,
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
  }) {
    return ZephyrAccordionTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      expandedBackgroundColor: expandedBackgroundColor ?? this.expandedBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      titlePadding: titlePadding ?? this.titlePadding,
      contentPadding: contentPadding ?? this.contentPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      titleStyle: titleStyle ?? this.titleStyle,
      contentStyle: contentStyle ?? this.contentStyle,
    );
  }
}