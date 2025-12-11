/// VelocityUI 文本组件
library velocity_text;

import 'package:flutter/material.dart';
import 'text_style.dart';

export 'text_style.dart';

/// 文本变体
enum VelocityTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

/// VelocityUI 文本组件
class VelocityText extends StatelessWidget {
  /// 创建文本组件
  const VelocityText(
    this.text, {
    super.key,
    this.variant,
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  /// 创建大号展示文本
  const VelocityText.displayLarge(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.displayLarge,
        style = null;

  /// 创建中号展示文本
  const VelocityText.displayMedium(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.displayMedium,
        style = null;

  /// 创建小号展示文本
  const VelocityText.displaySmall(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.displaySmall,
        style = null;

  /// 创建大号标题文本
  const VelocityText.headlineLarge(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.headlineLarge,
        style = null;

  /// 创建中号标题文本
  const VelocityText.headlineMedium(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.headlineMedium,
        style = null;

  /// 创建小号标题文本
  const VelocityText.headlineSmall(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.headlineSmall,
        style = null;

  /// 创建大号标题文本
  const VelocityText.titleLarge(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.titleLarge,
        style = null;

  /// 创建中号标题文本
  const VelocityText.titleMedium(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.titleMedium,
        style = null;

  /// 创建小号标题文本
  const VelocityText.titleSmall(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.titleSmall,
        style = null;

  /// 创建大号正文文本
  const VelocityText.bodyLarge(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.bodyLarge,
        style = null;

  /// 创建中号正文文本
  const VelocityText.bodyMedium(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.bodyMedium,
        style = null;

  /// 创建小号正文文本
  const VelocityText.bodySmall(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.bodySmall,
        style = null;

  /// 创建大号标签文本
  const VelocityText.labelLarge(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.labelLarge,
        style = null;

  /// 创建中号标签文本
  const VelocityText.labelMedium(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.labelMedium,
        style = null;

  /// 创建小号标签文本
  const VelocityText.labelSmall(this.text,
      {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
      : variant = VelocityTextVariant.labelSmall,
        style = null;

  /// 文本内容
  final String text;

  /// 文本变体
  final VelocityTextVariant? variant;

  /// 自定义样式
  final VelocityTextStyle? style;

  /// 文本颜色
  final Color? color;

  /// 文本对齐
  final TextAlign? textAlign;

  /// 最大行数
  final int? maxLines;

  /// 溢出处理
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle =
        VelocityTextStyle.resolve(variant: variant, customStyle: style);

    var textStyle = effectiveStyle.toTextStyle();
    if (color != null) {
      textStyle = textStyle.copyWith(color: color);
    }

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
