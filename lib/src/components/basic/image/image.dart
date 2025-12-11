/// VelocityUI 图片组件
library velocity_image;

import 'package:flutter/material.dart';
import 'image_style.dart';

export 'image_style.dart';

/// VelocityUI 图片组件
class VelocityImage extends StatelessWidget {
  /// 创建图片组件
  const VelocityImage({
    super.key,
    this.src,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.style,
    this.placeholder,
    this.errorWidget,
  });

  /// 图片地址
  final String? src;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 填充方式
  final BoxFit fit;

  /// 自定义样式
  final VelocityImageStyle? style;

  /// 占位组件
  final Widget? placeholder;

  /// 错误组件
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityImageStyle.defaults();

    Widget image;
    if (src == null || src!.isEmpty) {
      image = _buildPlaceholder(effectiveStyle);
    } else if (src!.startsWith('http')) {
      image = Image.network(
        src!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ?? _buildPlaceholder(effectiveStyle);
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildError(effectiveStyle);
        },
      );
    } else {
      image = Image.asset(
        src!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildError(effectiveStyle);
        },
      );
    }

    if (effectiveStyle.borderRadius != null) {
      image =
          ClipRRect(borderRadius: effectiveStyle.borderRadius!, child: image);
    }

    return image;
  }

  Widget _buildPlaceholder(VelocityImageStyle style) {
    return Container(
      width: width,
      height: height,
      color: style.placeholderColor,
      child: Center(
        child: Icon(Icons.image, color: style.placeholderIconColor, size: 32),
      ),
    );
  }

  Widget _buildError(VelocityImageStyle style) {
    return Container(
      width: width,
      height: height,
      color: style.errorColor,
      child: Center(
        child: Icon(Icons.broken_image, color: style.errorIconColor, size: 32),
      ),
    );
  }
}
