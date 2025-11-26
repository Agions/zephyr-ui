/// ZephyrUI Typography 排版组件
///
/// 提供标准化的文本排版样式

library typography;

import 'package:flutter/material.dart';

/// 文本类型枚举
enum ZephyrTextType {
  h1, // 主标题
  h2, // 副标题
  h3, // 三级标题
  h4, // 四级标题
  h5, // 五级标题
  h6, // 六级标题
  body1, // 正文1
  body2, // 正文2
  caption, // 说明文字
  label, // 标签文字
  link, // 链接文字
}

/// 文本权重枚举
enum ZephyrTextWeight {
  regular, // 400
  medium, // 500
  bold, // 700
}

/// Typography 组件
class ZephyrTypography extends StatelessWidget {
  const ZephyrTypography({
    required this.text,
    super.key,
    this.type = ZephyrTextType.body1,
    this.weight = ZephyrTextWeight.regular,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.lineHeight,
    this.letterSpacing,
    this.italic = false,
    this.underline = false,
    this.decoration,
    this.decorationColor,
    this.onTap,
  });

  final String text;
  final ZephyrTextType type;
  final ZephyrTextWeight weight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? lineHeight;
  final double? letterSpacing;
  final bool italic;
  final bool underline;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 获取默认样式
    var defaultStyle = _getDefaultTextStyle(theme);

    // 应用权重
    var fontWeight = _getFontWeight(weight);

    // 应用颜色
    var textColor = color ?? _getDefaultColor(theme);

    // 应用装饰
    var textDecoration = decoration ??
        (underline ? TextDecoration.underline : TextDecoration.none);

    // 构建文本样式
    var textStyle = defaultStyle.copyWith(
      color: textColor,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      decoration: textDecoration,
      decorationColor: decorationColor ?? textColor,
      height: lineHeight,
      letterSpacing: letterSpacing,
    );

    Widget textWidget = Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );

    if (onTap != null) {
      textWidget = GestureDetector(
        onTap: onTap,
        child: textWidget,
      );
    }

    return textWidget;
  }

  TextStyle _getDefaultTextStyle(ThemeData theme) {
    switch (type) {
      case ZephyrTextType.h1:
        return theme.textTheme.headlineLarge!;
      case ZephyrTextType.h2:
        return theme.textTheme.headlineMedium!;
      case ZephyrTextType.h3:
        return theme.textTheme.headlineSmall!;
      case ZephyrTextType.h4:
        return theme.textTheme.titleLarge!;
      case ZephyrTextType.h5:
        return theme.textTheme.titleMedium!;
      case ZephyrTextType.h6:
        return theme.textTheme.titleSmall!;
      case ZephyrTextType.body1:
        return theme.textTheme.bodyLarge!;
      case ZephyrTextType.body2:
        return theme.textTheme.bodyMedium!;
      case ZephyrTextType.caption:
        return theme.textTheme.bodySmall!;
      case ZephyrTextType.label:
        return theme.textTheme.labelLarge!;
      case ZephyrTextType.link:
        return theme.textTheme.bodyMedium!.copyWith(
          color: theme.primaryColor,
          decoration: TextDecoration.underline,
        );
    }
  }

  FontWeight _getFontWeight(ZephyrTextWeight weight) {
    switch (weight) {
      case ZephyrTextWeight.regular:
        return FontWeight.w400;
      case ZephyrTextWeight.medium:
        return FontWeight.w500;
      case ZephyrTextWeight.bold:
        return FontWeight.w700;
    }
  }

  Color _getDefaultColor(ThemeData theme) {
    switch (type) {
      case ZephyrTextType.h1:
      case ZephyrTextType.h2:
      case ZephyrTextType.h3:
      case ZephyrTextType.h4:
      case ZephyrTextType.h5:
      case ZephyrTextType.h6:
        return theme.colorScheme.onSurface;
      case ZephyrTextType.body1:
      case ZephyrTextType.body2:
        return theme.colorScheme.onSurface.withValues(alpha:0.87);
      case ZephyrTextType.caption:
        return theme.colorScheme.onSurface.withValues(alpha:0.6);
      case ZephyrTextType.label:
        return theme.colorScheme.onSurface.withValues(alpha:0.87);
      case ZephyrTextType.link:
        return theme.primaryColor;
    }
  }
}

/// 标题组件
class ZephyrTitle extends ZephyrTypography {
  const ZephyrTitle({
    required super.text,
    super.key,
    super.type = ZephyrTextType.h3,
    super.weight = ZephyrTextWeight.bold,
    super.color,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.lineHeight,
    super.letterSpacing,
  });
}

/// 副标题组件
class ZephyrSubtitle extends ZephyrTypography {
  const ZephyrSubtitle({
    required super.text,
    super.key,
    super.type = ZephyrTextType.h5,
    super.weight = ZephyrTextWeight.medium,
    super.color,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.lineHeight,
    super.letterSpacing,
  });
}

/// 正文组件
class ZephyrParagraph extends ZephyrTypography {
  const ZephyrParagraph({
    required super.text,
    super.key,
    super.type = ZephyrTextType.body1,
    super.weight = ZephyrTextWeight.regular,
    super.color,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.lineHeight = 1.5,
    super.letterSpacing,
  });
}

/// 说明文字组件
class ZephyrCaption extends ZephyrTypography {
  const ZephyrCaption({
    required super.text,
    super.key,
    super.type = ZephyrTextType.caption,
    super.weight = ZephyrTextWeight.regular,
    super.color,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.lineHeight,
    super.letterSpacing,
  });
}

/// 链接组件
class ZephyrLink extends ZephyrTypography {
  const ZephyrLink({
    required super.text,
    super.key,
    super.type = ZephyrTextType.link,
    super.weight = ZephyrTextWeight.regular,
    super.color,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.lineHeight,
    super.letterSpacing,
    super.onTap,
    super.underline = true,
  });
}

/// 排版系统组件
class ZephyrTypographySystem extends StatelessWidget {
  const ZephyrTypographySystem({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!,
      child: child,
    );
  }
}

/// 文本段落组件
class ZephyrTextBlock extends StatelessWidget {
  const ZephyrTextBlock({
    required this.text,
    super.key,
    this.type = ZephyrTextType.body1,
    this.weight = ZephyrTextWeight.regular,
    this.color,
    this.textAlign,
    this.lineHeight,
    this.letterSpacing,
    this.paragraphSpacing,
  });
  final String text;
  final ZephyrTextType type;
  final ZephyrTextWeight weight;
  final Color? color;
  final TextAlign? textAlign;
  final double? lineHeight;
  final double? letterSpacing;
  final double? paragraphSpacing;

  @override
  Widget build(BuildContext context) {
    final paragraphs = text.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((paragraph) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: paragraphSpacing ?? (paragraphs.length > 1 ? 16.0 : 0),
          ),
          child: ZephyrTypography(
            text: paragraph,
            type: type,
            weight: weight,
            color: color,
            textAlign: textAlign,
            lineHeight: lineHeight,
            letterSpacing: letterSpacing,
          ),
        );
      }).toList(),
    );
  }
}
