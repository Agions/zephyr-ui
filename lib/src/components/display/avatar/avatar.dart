/// VelocityUI 头像组件
library velocity_avatar;

import 'package:flutter/material.dart';
import 'avatar_style.dart';

export 'avatar_style.dart';

/// 头像尺寸
enum VelocityAvatarSize { xs, sm, md, lg, xl }

/// 头像形状
enum VelocityAvatarShape { circle, square, rounded }

/// VelocityUI 头像组件
class VelocityAvatar extends StatelessWidget {
  /// 创建头像组件
  const VelocityAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.icon,
    this.size = VelocityAvatarSize.md,
    this.shape = VelocityAvatarShape.circle,
    this.customSize,
    this.style,
    this.onTap,
  });

  /// 图片地址
  final String? imageUrl;

  /// 名称（生成首字母）
  final String? name;

  /// 自定义图标
  final IconData? icon;

  /// 尺寸
  final VelocityAvatarSize size;

  /// 形状
  final VelocityAvatarShape shape;

  /// 自定义尺寸
  final double? customSize;

  /// 自定义样式
  final VelocityAvatarStyle? style;

  /// 点击回调
  final VoidCallback? onTap;

  double get _size {
    if (customSize != null) return customSize!;
    switch (size) {
      case VelocityAvatarSize.xs:
        return 24;
      case VelocityAvatarSize.sm:
        return 32;
      case VelocityAvatarSize.md:
        return 40;
      case VelocityAvatarSize.lg:
        return 48;
      case VelocityAvatarSize.xl:
        return 64;
    }
  }

  double get _fontSize {
    switch (size) {
      case VelocityAvatarSize.xs:
        return 10;
      case VelocityAvatarSize.sm:
        return 12;
      case VelocityAvatarSize.md:
        return 14;
      case VelocityAvatarSize.lg:
        return 18;
      case VelocityAvatarSize.xl:
        return 24;
    }
  }

  double get _iconSize {
    switch (size) {
      case VelocityAvatarSize.xs:
        return 14;
      case VelocityAvatarSize.sm:
        return 16;
      case VelocityAvatarSize.md:
        return 20;
      case VelocityAvatarSize.lg:
        return 24;
      case VelocityAvatarSize.xl:
        return 32;
    }
  }

  BorderRadius get _borderRadius {
    switch (shape) {
      case VelocityAvatarShape.circle:
        return BorderRadius.circular(_size / 2);
      case VelocityAvatarShape.square:
        return BorderRadius.zero;
      case VelocityAvatarShape.rounded:
        return const BorderRadius.all(Radius.circular(8));
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityAvatarStyle.defaults();

    Widget content;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      content = ClipRRect(
        borderRadius: _borderRadius,
        child: Image.network(
          imageUrl!,
          width: _size,
          height: _size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildFallback(effectiveStyle),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildFallback(effectiveStyle);
          },
        ),
      );
    } else {
      content = _buildFallback(effectiveStyle);
    }

    Widget avatar = Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        border: effectiveStyle.border,
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }

  Widget _buildFallback(VelocityAvatarStyle style) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: _borderRadius,
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, size: _iconSize, color: style.foregroundColor)
            : name != null && name!.isNotEmpty
                ? Text(_getInitials(name!),
                    style: TextStyle(
                        color: style.foregroundColor,
                        fontSize: _fontSize,
                        fontWeight: FontWeight.w500))
                : Icon(Icons.person,
                    size: _iconSize, color: style.foregroundColor),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }
}

/// VelocityUI 头像组
class VelocityAvatarGroup extends StatelessWidget {
  /// 创建头像组
  const VelocityAvatarGroup({
    required this.avatars, super.key,
    this.max = 5,
    this.size = VelocityAvatarSize.md,
    this.overlap = 8,
    this.style,
  });

  /// 头像列表
  final List<VelocityAvatar> avatars;

  /// 最大显示数量
  final int max;

  /// 尺寸
  final VelocityAvatarSize size;

  /// 重叠距离
  final double overlap;

  /// 样式
  final VelocityAvatarGroupStyle? style;

  @override
  Widget build(BuildContext context) {
    final displayAvatars = avatars.take(max).toList();
    final remaining = avatars.length - max;
    final effectiveStyle = style ?? VelocityAvatarGroupStyle.defaults();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < displayAvatars.length; i++)
          Transform.translate(
            offset: Offset(-i * overlap, 0),
            child: VelocityAvatar(
              imageUrl: displayAvatars[i].imageUrl,
              name: displayAvatars[i].name,
              icon: displayAvatars[i].icon,
              size: size,
              style: VelocityAvatarStyle(
                backgroundColor: displayAvatars[i].style?.backgroundColor,
                foregroundColor: displayAvatars[i].style?.foregroundColor,
                border: Border.all(
                    color: effectiveStyle.borderColor,
                    width: effectiveStyle.borderWidth),
              ),
            ),
          ),
        if (remaining > 0)
          Transform.translate(
            offset: Offset(-displayAvatars.length * overlap, 0),
            child: VelocityAvatar(
              name: '+$remaining',
              size: size,
              style: VelocityAvatarStyle(
                backgroundColor: effectiveStyle.overflowBackgroundColor,
                foregroundColor: effectiveStyle.overflowForegroundColor,
                border: Border.all(
                    color: effectiveStyle.borderColor,
                    width: effectiveStyle.borderWidth),
              ),
            ),
          ),
      ],
    );
  }
}
