import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 轻量级徽章组件，用于显示计数或状态指示
///
/// ZephyrBadge 支持三种主要变体：
/// 1. 标准徽章 - 显示文本内容
/// 2. 数字徽章 - 显示数字计数，可选最大显示值
/// 3. 圆点徽章 - 仅显示一个色彩圆点，无文本
class ZephyrBadge extends StatelessWidget {
  /// 创建标准徽章
  ///
  /// [content] 为必填参数，指定徽章显示的文本内容
  const ZephyrBadge({
    Key? key,
    required this.content,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.borderWidth,
    this.borderColor,
  })  : isNumeric = false,
        count = null,
        maxCount = null,
        isDot = false,
        super(key: key);

  /// 创建数字徽章
  ///
  /// [count] 指定徽章内显示的数字
  /// [maxCount] 可选参数，当 [count] 超过此值时，显示为 "[maxCount]+"
  const ZephyrBadge.count({
    Key? key,
    required this.count,
    this.maxCount,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.borderWidth,
    this.borderColor,
  })  : content = null,
        isNumeric = true,
        isDot = false,
        super(key: key);

  /// 创建圆点徽章
  ///
  /// 一个无文本的小圆点，通常用作状态指示器
  const ZephyrBadge.dot({
    Key? key,
    this.backgroundColor,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
  })  : content = null,
        textColor = null,
        padding = const EdgeInsets.all(4.0),
        isNumeric = false,
        count = null,
        maxCount = null,
        isDot = true,
        super(key: key);

  /// 徽章显示的文本内容
  final String? content;

  /// 是否为数字徽章
  final bool isNumeric;

  /// 数字徽章中显示的计数
  final int? count;

  /// 数字徽章中的最大显示计数
  final int? maxCount;

  /// 是否为圆点徽章
  final bool isDot;

  /// 徽章背景色
  final Color? backgroundColor;

  /// 徽章文本颜色
  final Color? textColor;

  /// 徽章边框圆角
  final BorderRadius? borderRadius;

  /// 徽章内边距
  final EdgeInsetsGeometry? padding;

  /// 徽章边框宽度
  final double? borderWidth;

  /// 徽章边框颜色
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    // 获取主题数据
    final theme = Theme.of(context).extension<ZephyrBadgeTheme>() ??
        ZephyrBadgeTheme.fallback(context);

    // 确定显示的内容
    String? displayContent;
    if (isDot) {
      displayContent = '';
    } else if (isNumeric && count != null) {
      if (maxCount != null && count! > maxCount!) {
        displayContent = '$maxCount+';
      } else {
        displayContent = count.toString();
      }
    } else {
      displayContent = content;
    }

    return Container(
      padding: padding ?? theme.padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.backgroundColor,
        borderRadius: borderRadius ?? theme.borderRadius,
        border: Border.all(
          width: borderWidth ?? theme.borderWidth,
          color: borderColor ?? theme.borderColor,
        ),
      ),
      child: isDot
          ? const SizedBox(width: 4, height: 4) // 圆点徽章只显示一个小点
          : Text(
              displayContent ?? '',
              style: TextStyle(
                color: textColor ?? theme.textColor,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}

/// 徽章位置枚举
enum ZephyrBadgePosition {
  /// 右上角
  topRight,

  /// 左上角
  topLeft,

  /// 右下角
  bottomRight,

  /// 左下角
  bottomLeft,
}
