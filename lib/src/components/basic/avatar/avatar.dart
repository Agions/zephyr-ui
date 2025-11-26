import 'package:flutter/material.dart';
import 'avatar_theme.dart';

/// 头像组件，用于展示用户或实体的图像标识
///
/// 支持图片、文字和图标三种模式，以及圆形、方形两种形状
class ZephyrAvatar extends StatelessWidget {
  /// 创建一个标准头像
  const ZephyrAvatar({
    super.key,
    this.child,
    this.image,
    this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.size = ZephyrAvatarSize.medium,
    this.shape = ZephyrAvatarShape.circle,
    this.borderWidth,
    this.borderColor,
    this.elevation,
    this.shadowColor,
    this.onTap,
  }) : assert(
          (child != null && image == null && text == null) ||
              (child == null && image != null && text == null) ||
              (child == null && image == null && text != null) ||
              (child == null && image == null && text == null),
          '只能提供child、image或text中的一个',
        );

  /// 使用图片创建头像
  factory ZephyrAvatar.image({
    required ImageProvider image,
    Key? key,
    ZephyrAvatarSize size = ZephyrAvatarSize.medium,
    ZephyrAvatarShape shape = ZephyrAvatarShape.circle,
    double? borderWidth,
    Color? borderColor,
    double? elevation,
    Color? shadowColor,
    VoidCallback? onTap,
  }) {
    return ZephyrAvatar(
      key: key,
      image: image,
      size: size,
      shape: shape,
      borderWidth: borderWidth,
      borderColor: borderColor,
      elevation: elevation,
      shadowColor: shadowColor,
      onTap: onTap,
    );
  }

  /// 使用文字创建头像
  factory ZephyrAvatar.text({
    required String text,
    Key? key,
    Color? backgroundColor,
    Color? foregroundColor,
    ZephyrAvatarSize size = ZephyrAvatarSize.medium,
    ZephyrAvatarShape shape = ZephyrAvatarShape.circle,
    double? borderWidth,
    Color? borderColor,
    double? elevation,
    Color? shadowColor,
    VoidCallback? onTap,
  }) {
    return ZephyrAvatar(
      key: key,
      text: text,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      size: size,
      shape: shape,
      borderWidth: borderWidth,
      borderColor: borderColor,
      elevation: elevation,
      shadowColor: shadowColor,
      onTap: onTap,
    );
  }

  /// 使用图标创建头像
  factory ZephyrAvatar.icon({
    required IconData icon,
    Key? key,
    Color? backgroundColor,
    Color? foregroundColor,
    ZephyrAvatarSize size = ZephyrAvatarSize.medium,
    ZephyrAvatarShape shape = ZephyrAvatarShape.circle,
    double? borderWidth,
    Color? borderColor,
    double? elevation,
    Color? shadowColor,
    VoidCallback? onTap,
  }) {
    return ZephyrAvatar(
      key: key,
      backgroundColor: backgroundColor,
      size: size,
      shape: shape,
      borderWidth: borderWidth,
      borderColor: borderColor,
      elevation: elevation,
      shadowColor: shadowColor,
      onTap: onTap,
      child: Icon(
        icon,
        color: foregroundColor,
        size: _getIconSize(size),
      ),
    );
  }

  /// 头像内容
  final Widget? child;

  /// 头像图片
  final ImageProvider? image;

  /// 头像文本
  final String? text;

  /// 背景色
  final Color? backgroundColor;

  /// 前景色（文字或图标颜色）
  final Color? foregroundColor;

  /// 头像尺寸
  final ZephyrAvatarSize size;

  /// 头像形状
  final ZephyrAvatarShape shape;

  /// 边框宽度
  final double? borderWidth;

  /// 边框颜色
  final Color? borderColor;

  /// 阴影高度
  final double? elevation;

  /// 阴影颜色
  final Color? shadowColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 获取对应尺寸的图标大小
  static double _getIconSize(ZephyrAvatarSize size) {
    switch (size) {
      case ZephyrAvatarSize.extraSmall:
        return 12.0;
      case ZephyrAvatarSize.small:
        return 16.0;
      case ZephyrAvatarSize.medium:
        return 24.0;
      case ZephyrAvatarSize.large:
        return 32.0;
      case ZephyrAvatarSize.extraLarge:
        return 48.0;
    }
  }

  /// 获取对应尺寸的字体大小
  static double _getTextSize(ZephyrAvatarSize size) {
    switch (size) {
      case ZephyrAvatarSize.extraSmall:
        return 10.0;
      case ZephyrAvatarSize.small:
        return 12.0;
      case ZephyrAvatarSize.medium:
        return 16.0;
      case ZephyrAvatarSize.large:
        return 20.0;
      case ZephyrAvatarSize.extraLarge:
        return 28.0;
    }
  }

  /// 获取对应尺寸的容器大小
  static double _getContainerSize(ZephyrAvatarSize size) {
    switch (size) {
      case ZephyrAvatarSize.extraSmall:
        return 24.0;
      case ZephyrAvatarSize.small:
        return 32.0;
      case ZephyrAvatarSize.medium:
        return 48.0;
      case ZephyrAvatarSize.large:
        return 64.0;
      case ZephyrAvatarSize.extraLarge:
        return 96.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrAvatarTheme>() ??
        ZephyrAvatarTheme.fallback(context);

    final effectiveBackgroundColor = backgroundColor ?? theme.backgroundColor;
    final effectiveForegroundColor = foregroundColor ?? theme.foregroundColor;
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderColor = borderColor ?? theme.borderColor;
    final effectiveElevation = elevation ?? theme.elevation;
    final effectiveShadowColor = shadowColor ?? theme.shadowColor;

    final containerSize = _getContainerSize(size);
    final borderRadius = shape == ZephyrAvatarShape.circle
        ? BorderRadius.circular(containerSize / 2)
        : BorderRadius.circular(theme.squareBorderRadius);

    Widget content;

    if (image != null) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: Image(
          image: image!,
          width: containerSize,
          height: containerSize,
          fit: BoxFit.cover,
        ),
      );
    } else if (text != null) {
      var displayText = text!.length > 2 ? text!.substring(0, 2) : text!;
      content = Center(
        child: Text(
          displayText.toUpperCase(),
          style: TextStyle(
            color: effectiveForegroundColor,
            fontSize: _getTextSize(size),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      content = child ?? const SizedBox();
    }

    final avatar = Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: image != null ? null : effectiveBackgroundColor,
        borderRadius: borderRadius,
        border: effectiveBorderWidth > 0
            ? Border.all(
                width: effectiveBorderWidth,
                color: effectiveBorderColor,
              )
            : null,
        boxShadow: effectiveElevation > 0
            ? [
                BoxShadow(
                  color: effectiveShadowColor.withValues(alpha: 0.3),
                  blurRadius: effectiveElevation * 2,
                  spreadRadius: effectiveElevation / 2,
                ),
              ]
            : null,
      ),
      child: content,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: avatar,
      );
    }

    return avatar;
  }
}

/// 头像尺寸枚举
enum ZephyrAvatarSize {
  /// 超小尺寸 (24px)
  extraSmall,

  /// 小尺寸 (32px)
  small,

  /// 中等尺寸 (48px)
  medium,

  /// 大尺寸 (64px)
  large,

  /// 超大尺寸 (96px)
  extraLarge,
}

/// 头像形状枚举
enum ZephyrAvatarShape {
  /// 圆形
  circle,

  /// 方形（圆角）
  square,
}
