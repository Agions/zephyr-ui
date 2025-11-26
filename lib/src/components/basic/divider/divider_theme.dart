import 'package:flutter/material.dart';

/// 定义ZephyrDivider的视觉属性
///
/// 此主题用于ZephyrDivider组件确定视觉样式，包括颜色、厚度和缩进。
class ZephyrDividerTheme extends ThemeExtension<ZephyrDividerTheme> {
  const ZephyrDividerTheme({
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
    this.verticalSpacing,
    this.horizontalSpacing,
  });

  /// 分割线颜色
  final Color? color;

  /// 分割线厚度
  final double? thickness;

  /// 左侧缩进
  final double? indent;

  /// 右侧缩进
  final double? endIndent;

  /// 垂直分割线上下间距
  final double? verticalSpacing;

  /// 水平分割线左右间距
  final double? horizontalSpacing;

  @override
  ZephyrDividerTheme copyWith({
    Color? color,
    double? thickness,
    double? indent,
    double? endIndent,
    double? verticalSpacing,
    double? horizontalSpacing,
  }) {
    return ZephyrDividerTheme(
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      indent: indent ?? this.indent,
      endIndent: endIndent ?? this.endIndent,
      verticalSpacing: verticalSpacing ?? this.verticalSpacing,
      horizontalSpacing: horizontalSpacing ?? this.horizontalSpacing,
    );
  }

  @override
  ZephyrDividerTheme lerp(ThemeExtension<ZephyrDividerTheme>? other, double t) {
    if (other is! ZephyrDividerTheme) {
      return this;
    }

    return ZephyrDividerTheme(
      color: Color.lerp(color, other.color, t),
      thickness: lerpDouble(thickness, other.thickness, t),
      indent: lerpDouble(indent, other.indent, t),
      endIndent: lerpDouble(endIndent, other.endIndent, t),
      verticalSpacing: lerpDouble(verticalSpacing, other.verticalSpacing, t),
      horizontalSpacing:
          lerpDouble(horizontalSpacing, other.horizontalSpacing, t),
    );
  }

  /// 创建默认主题
  static ZephyrDividerTheme fallback(BuildContext context) {
    final theme = Theme.of(context);
    final dividerTheme = theme.dividerTheme;
    final colorScheme = theme.colorScheme;

    return ZephyrDividerTheme(
      color: dividerTheme.color ?? colorScheme.outline.withValues(alpha: 0.2),
      thickness: dividerTheme.thickness ?? 1.0,
      indent: dividerTheme.indent ?? 0.0,
      endIndent: dividerTheme.endIndent ?? 0.0,
      verticalSpacing: 0.0,
      horizontalSpacing: 0.0,
    );
  }

  /// 辅助方法：对 double 类型值进行线性插值
  static double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b! * t;
    if (b == null) return a * (1.0 - t);
    return a + (b - a) * t;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrDividerTheme &&
        other.color == color &&
        other.thickness == thickness &&
        other.indent == indent &&
        other.endIndent == endIndent &&
        other.verticalSpacing == verticalSpacing &&
        other.horizontalSpacing == horizontalSpacing;
  }

  @override
  int get hashCode => Object.hash(
        color,
        thickness,
        indent,
        endIndent,
        verticalSpacing,
        horizontalSpacing,
      );
}
