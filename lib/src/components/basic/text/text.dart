import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 遵循Zephyr设计规范的文本组件
///
/// 提供了一系列预设的文本样式，便于创建一致的排版效果。
///
/// 示例用法:
/// ```dart
/// ZephyrText.headline('标题文本')
///
/// ZephyrText.body('正文内容')
/// ```
class ZephyrText extends StatelessWidget {
  /// 创建一个标准文本组件
  ///
  /// [text] 是要显示的文本内容
  const ZephyrText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaleFactor,
    this.theme,
    this.decoration,
    this.onPressed,
  }) : _variant = ZephyrTextVariant.custom;

  /// 创建一个大号标题文本
  factory ZephyrText.headlineLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.headlineLarge,
    );
  }

  /// 创建一个中号标题文本
  factory ZephyrText.headlineMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.headlineMedium,
    );
  }

  /// 创建一个小号标题文本
  factory ZephyrText.headlineSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.headlineSmall,
    );
  }

  /// 创建一个大号标题文本
  factory ZephyrText.titleLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.titleLarge,
    );
  }

  /// 创建一个中号标题文本
  factory ZephyrText.titleMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.titleMedium,
    );
  }

  /// 创建一个小号标题文本
  factory ZephyrText.titleSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.titleSmall,
    );
  }

  /// 创建一个大号正文文本
  factory ZephyrText.bodyLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.bodyLarge,
    );
  }

  /// 创建一个中号正文文本
  factory ZephyrText.bodyMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.bodyMedium,
    );
  }

  /// 创建一个小号正文文本
  factory ZephyrText.bodySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.bodySmall,
    );
  }

  /// 创建一个大号标签文本
  factory ZephyrText.labelLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.labelLarge,
    );
  }

  /// 创建一个中号标签文本
  factory ZephyrText.labelMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.labelMedium,
    );
  }

  /// 创建一个小号标签文本
  factory ZephyrText.labelSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    ZephyrTextTheme? theme,
  }) {
    return ZephyrText._(
      key: key,
      text: text,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      theme: theme,
      style: null,
      variant: ZephyrTextVariant.labelSmall,
    );
  }

  /// 私有构造函数，用于创建带变体的文本
  const ZephyrText._({
    required this.text,
    required ZephyrTextVariant variant,
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaleFactor,
    this.theme,
    this.decoration,
    this.onPressed,
  }) : _variant = variant;

  /// 显示的文本内容
  final String text;

  /// 自定义文本样式
  final TextStyle? style;

  /// 文本颜色
  final Color? color;

  /// 文本对齐方式
  final TextAlign? textAlign;

  /// 最大行数
  final int? maxLines;

  /// 文本溢出处理
  final TextOverflow? overflow;

  /// 是否允许文本换行
  final bool? softWrap;

  /// 文本缩放因子
  final double? textScaleFactor;

  /// 文本主题
  final ZephyrTextTheme? theme;

  /// 文本装饰
  final BoxDecoration? decoration;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 文本变体
  final ZephyrTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    final globalTextTheme = ZephyrTheme.of(context).zephyrTextTheme;
    final effectiveTheme = ZephyrTextTheme.resolve(
      context,
      theme?.merge(globalTextTheme),
    );

    // 根据变体选择相应的样式
    TextStyle? baseStyle;
    final defaultColor = effectiveTheme.primaryColor;

    switch (_variant) {
      case ZephyrTextVariant.headlineLarge:
        baseStyle = effectiveTheme.headlineLarge;
        break;
      case ZephyrTextVariant.headlineMedium:
        baseStyle = effectiveTheme.headlineMedium;
        break;
      case ZephyrTextVariant.headlineSmall:
        baseStyle = effectiveTheme.headlineSmall;
        break;
      case ZephyrTextVariant.titleLarge:
        baseStyle = effectiveTheme.titleLarge;
        break;
      case ZephyrTextVariant.titleMedium:
        baseStyle = effectiveTheme.titleMedium;
        break;
      case ZephyrTextVariant.titleSmall:
        baseStyle = effectiveTheme.titleSmall;
        break;
      case ZephyrTextVariant.bodyLarge:
        baseStyle = effectiveTheme.bodyLarge;
        break;
      case ZephyrTextVariant.bodyMedium:
        baseStyle = effectiveTheme.bodyMedium;
        break;
      case ZephyrTextVariant.bodySmall:
        baseStyle = effectiveTheme.bodySmall;
        break;
      case ZephyrTextVariant.labelLarge:
        baseStyle = effectiveTheme.labelLarge;
        break;
      case ZephyrTextVariant.labelMedium:
        baseStyle = effectiveTheme.labelMedium;
        break;
      case ZephyrTextVariant.labelSmall:
        baseStyle = effectiveTheme.labelSmall;
        break;
      case ZephyrTextVariant.custom:
        // 使用提供的样式或默认的文本样式
        baseStyle = style ?? effectiveTheme.bodyMedium;
        break;
    }

    // 合并样式，应用颜色覆盖
    final effectiveStyle = baseStyle.copyWith(
      color: color ?? baseStyle.color ?? defaultColor,
    );

    final textWidget = Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaler:
          textScaleFactor != null ? TextScaler.linear(textScaleFactor!) : null,
    );

    // 如果有装饰，包装在Container中
    if (decoration != null) {
      return Container(
        decoration: decoration,
        child: textWidget,
      );
    }

    // 如果有点击回调，包装在InkWell中
    if (onPressed != null) {
      return InkWell(
        onTap: onPressed,
        child: textWidget,
      );
    }

    return textWidget;
  }
}

/// 文本变体枚举
enum ZephyrTextVariant {
  /// 大号标题
  headlineLarge,

  /// 中号标题
  headlineMedium,

  /// 小号标题
  headlineSmall,

  /// 大号标题
  titleLarge,

  /// 中号标题
  titleMedium,

  /// 小号标题
  titleSmall,

  /// 大号正文
  bodyLarge,

  /// 中号正文
  bodyMedium,

  /// 小号正文
  bodySmall,

  /// 大号标签
  labelLarge,

  /// 中号标签
  labelMedium,

  /// 小号标签
  labelSmall,

  /// 自定义
  custom,
}
