/// ZephyrUI 容器主题
///
/// 定义容器组件的主题样式。
library container_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 容器主题
class ZephyrContainerTheme {
  /// 创建容器主题
  const ZephyrContainerTheme({
    this.backgroundColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.constraints,
    this.alignment,
    this.maxWidth,
  });

  /// 背景色
  final Color? backgroundColor;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 边框
  final Border? border;

  /// 阴影
  final List<BoxShadow>? boxShadow;

  /// 约束
  final BoxConstraints? constraints;

  /// 对齐方式
  final AlignmentGeometry? alignment;

  /// 最大宽度
  final double? maxWidth;

  /// 从上下文获取主题
  static ZephyrContainerTheme of(BuildContext context) {
    final zephyrTheme = ZephyrTheme.of(context);
    return _defaultTheme(zephyrTheme);
  }

  /// 默认主题
  static ZephyrContainerTheme _defaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    return ZephyrContainerTheme(
      backgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      padding: const EdgeInsets.all(ZephyrSpacing.md),
      margin: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(ZephyrRadius.md),
      border: Border.all(
        color: isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral200,
        width: 1,
      ),
      boxShadow: ZephyrShadows.sm,
      constraints: null,
      alignment: null,
      maxWidth: null,
    );
  }

  /// 创建主题副本
  ZephyrContainerTheme copyWith({
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
    BoxConstraints? constraints,
    AlignmentGeometry? alignment,
    double? maxWidth,
  }) {
    return ZephyrContainerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      constraints: constraints ?? this.constraints,
      alignment: alignment ?? this.alignment,
      maxWidth: maxWidth ?? this.maxWidth,
    );
  }

  /// 线性插值
  static ZephyrContainerTheme lerp(
    ZephyrContainerTheme? a,
    ZephyrContainerTheme? b,
    double t,
  ) {
    if (a == null && b == null) return const ZephyrContainerTheme();
    if (a == null) return b!;
    if (b == null) return a;

    return ZephyrContainerTheme(
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t),
      margin: EdgeInsetsGeometry.lerp(a.margin, b.margin, t),
      borderRadius: BorderRadius.lerp(a.borderRadius, b.borderRadius, t),
      border: Border.lerp(a.border, b.border, t),
      boxShadow: BoxShadow.lerpList(a.boxShadow, b.boxShadow, t),
      constraints: BoxConstraints.lerp(a.constraints, b.constraints, t),
      alignment: AlignmentGeometry.lerp(a.alignment, b.alignment, t),
      maxWidth: a.maxWidth != null && b.maxWidth != null
          ? a.maxWidth! + (b.maxWidth! - a.maxWidth!) * t
          : t < 0.5
              ? a.maxWidth
              : b.maxWidth,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrContainerTheme &&
        other.backgroundColor == backgroundColor &&
        other.padding == padding &&
        other.margin == margin &&
        other.borderRadius == borderRadius &&
        other.border == border &&
        other.boxShadow == boxShadow &&
        other.constraints == constraints &&
        other.alignment == alignment &&
        other.maxWidth == maxWidth;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      padding,
      margin,
      borderRadius,
      border,
      boxShadow,
      constraints,
      alignment,
      maxWidth,
    );
  }
}
