/// ZephyrUI 骨架屏主题
/// 
/// 定义骨架屏组件的主题样式。
library skeleton_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 骨架屏主题
class ZephyrSkeletonTheme {
  /// 创建骨架屏主题
  const ZephyrSkeletonTheme({
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  /// 基础颜色
  final Color baseColor;

  /// 高亮颜色
  final Color highlightColor;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 从上下文获取主题
  static ZephyrSkeletonTheme of(BuildContext context) {
    return ZephyrTheme.of(context).skeletonTheme ?? const ZephyrSkeletonTheme();
  }

  /// 创建亮色主题
  static ZephyrSkeletonTheme light() {
    return const ZephyrSkeletonTheme(
      baseColor: Color(0xFFE0E0E0),
      highlightColor: Color(0xFFF5F5F5),
    );
  }

  /// 创建暗色主题
  static ZephyrSkeletonTheme dark() {
    return const ZephyrSkeletonTheme(
      baseColor: Color(0xFF424242),
      highlightColor: Color(0xFF616161),
    );
  }

  /// 复制主题并修改属性
  ZephyrSkeletonTheme copyWith({
    Color? baseColor,
    Color? highlightColor,
    BorderRadius? borderRadius,
  }) {
    return ZephyrSkeletonTheme(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}