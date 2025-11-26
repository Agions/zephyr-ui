import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 遵循Zephyr设计规范的分割线组件
///
/// 用于分隔内容区块，支持水平和垂直两种方向。
///
/// 示例用法:
/// ```dart
/// // 水平分割线
/// ZephyrDivider.horizontal()
///
/// // 垂直分割线
/// ZephyrDivider.vertical()
/// ```
class ZephyrDivider extends StatelessWidget {
  /// 创建一个水平分割线
  const ZephyrDivider.horizontal({
    super.key,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
    this.theme,
    this.height,
  })  : _axis = Axis.horizontal,
        width = null;

  /// 创建一个垂直分割线
  const ZephyrDivider.vertical({
    super.key,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
    this.theme,
    this.width,
  })  : _axis = Axis.vertical,
        height = null;

  /// 分割线颜色
  final Color? color;

  /// 分割线厚度
  final double? thickness;

  /// 起点缩进
  final double? indent;

  /// 终点缩进
  final double? endIndent;

  /// 分割线主题
  final ZephyrDividerTheme? theme;

  /// 水平分割线高度
  final double? height;

  /// 垂直分割线宽度
  final double? width;

  /// 分割线方向
  final Axis _axis;

  @override
  Widget build(BuildContext context) {
    // 获取主题
    final effectiveTheme = theme ??
        Theme.of(context).extension<ZephyrDividerTheme>() ??
        ZephyrDividerTheme.fallback(context);

    // 设置方向特定参数
    final isHorizontal = _axis == Axis.horizontal;
    final effectiveThickness = thickness ?? effectiveTheme.thickness!;
    final effectiveIndent = indent ?? effectiveTheme.indent!;
    final effectiveEndIndent = endIndent ?? effectiveTheme.endIndent!;

    // 计算内部尺寸
    final effectiveSpace = isHorizontal
        ? (height ?? (effectiveTheme.verticalSpacing! * 2 + effectiveThickness))
        : (width ??
            (effectiveTheme.horizontalSpacing! * 2 + effectiveThickness));

    if (isHorizontal) {
      return SizedBox(
        height: effectiveSpace,
        child: Center(
          child: Container(
            height: effectiveThickness,
            margin: EdgeInsetsDirectional.only(
              start: effectiveIndent,
              end: effectiveEndIndent,
            ),
            decoration: BoxDecoration(
              color: color ?? effectiveTheme.color,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: effectiveSpace,
        child: Center(
          child: Container(
            width: effectiveThickness,
            margin: EdgeInsetsDirectional.only(
              top: effectiveIndent,
              bottom: effectiveEndIndent,
            ),
            decoration: BoxDecoration(
              color: color ?? effectiveTheme.color,
            ),
          ),
        ),
      );
    }
  }
}
