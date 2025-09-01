/// ZephyrUI 分页主题
/// 
/// 定义分页组件的主题样式。
library pagination_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 分页主题
class ZephyrPaginationTheme {
  /// 创建分页主题
  const ZephyrPaginationTheme({
    this.pageInfoStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF6C757D),
    ),
    this.ellipsisStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF6C757D),
    ),
    this.borderColor = const Color(0xFFDEE2E6),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  /// 页码信息样式
  final TextStyle pageInfoStyle;

  /// 省略号样式
  final TextStyle ellipsisStyle;

  /// 边框颜色
  final Color borderColor;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 从上下文获取主题
  static ZephyrPaginationTheme of(BuildContext context) {
    return ZephyrTheme.of(context).paginationTheme ?? const ZephyrPaginationTheme();
  }

  /// 创建亮色主题
  static ZephyrPaginationTheme light() {
    return const ZephyrPaginationTheme(
      pageInfoStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF6C757D),
      ),
      ellipsisStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF6C757D),
      ),
      borderColor: Color(0xFFDEE2E6),
    );
  }

  /// 创建暗色主题
  static ZephyrPaginationTheme dark() {
    return const ZephyrPaginationTheme(
      pageInfoStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFFADB5BD),
      ),
      ellipsisStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFFADB5BD),
      ),
      borderColor: Color(0xFF495057),
    );
  }

  /// 复制主题并修改属性
  ZephyrPaginationTheme copyWith({
    TextStyle? pageInfoStyle,
    TextStyle? ellipsisStyle,
    Color? borderColor,
    BorderRadius? borderRadius,
  }) {
    return ZephyrPaginationTheme(
      pageInfoStyle: pageInfoStyle ?? this.pageInfoStyle,
      ellipsisStyle: ellipsisStyle ?? this.ellipsisStyle,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}