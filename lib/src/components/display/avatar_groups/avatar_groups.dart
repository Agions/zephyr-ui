import 'package:flutter/material.dart';

/// 头像形状
enum ZephyrAvatarShape {
  /// 圆形
  circle,
  
  /// 方形
  square,
  
  /// 圆角方形
  rounded,
}

/// 头像大小
enum ZephyrAvatarSize {
  /// 超小
  xs,
  
  /// 小
  small,
  
  /// 中等
  medium,
  
  /// 大
  large,
  
  /// 超大
  xl,
}

/// 头像组布局
enum ZephyrAvatarGroupLayout {
  /// 水平排列
  horizontal,
  
  /// 垂直排列
  vertical,
  
  /// 网格排列
  grid,
}

/// ZephyrUI 头像组件
///
/// 一个功能丰富的头像组件，支持图片、文字、图标等多种显示方式。
///
/// 特性：
/// - 多种形状和大小
/// - 图片、文字、图标支持
/// - 自定义颜色
/// - 点击交互
/// - 状态指示
/// - 响应式设计
///
/// 示例用法：
/// ```dart
/// ZephyrAvatar(
///   name: '张三',
///   imageUrl: 'https://example.com/avatar.jpg',
///   shape: ZephyrAvatarShape.circle,
///   size: ZephyrAvatarSize.medium,
/// )
/// ```
class ZephyrAvatar extends StatelessWidget {
  /// 显示名称
  final String? name;
  
  /// 图片URL
  final String? imageUrl;
  
  /// 图标
  final Widget? icon;
  
  /// 自定义背景颜色
  final Color? backgroundColor;
  
  /// 自定义文本颜色
  final Color? textColor;
  
  /// 头像形状
  final ZephyrAvatarShape shape;
  
  /// 头像大小
  final ZephyrAvatarSize size;
  
  /// 是否显示边框
  final bool bordered;
  
  /// 边框颜色
  final Color? borderColor;
  
  /// 是否显示阴影
  final bool showShadow;
  
  /// 是否在线状态
  final bool isOnline;
  
  /// 点击回调
  final VoidCallback? onTap;
  
  /// 创建头像组件
  const ZephyrAvatar({
    Key? key,
    this.name,
    this.imageUrl,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.shape = ZephyrAvatarShape.circle,
    this.size = ZephyrAvatarSize.medium,
    this.bordered = false,
    this.borderColor,
    this.showShadow = false,
    this.isOnline = false,
    this.onTap,
  }) : super(key: key);

  double _getSize() {
    switch (size) {
      case ZephyrAvatarSize.xs:
        return 24.0;
      case ZephyrAvatarSize.small:
        return 32.0;
      case ZephyrAvatarSize.medium:
        return 40.0;
      case ZephyrAvatarSize.large:
        return 48.0;
      case ZephyrAvatarSize.xl:
        return 64.0;
    }
  }

  double _getFontSize() {
    switch (size) {
      case ZephyrAvatarSize.xs:
        return 10.0;
      case ZephyrAvatarSize.small:
        return 12.0;
      case ZephyrAvatarSize.medium:
        return 14.0;
      case ZephyrAvatarSize.large:
        return 16.0;
      case ZephyrAvatarSize.xl:
        return 20.0;
    }
  }

  BorderRadius _getBorderRadius() {
    switch (shape) {
      case ZephyrAvatarShape.circle:
        return BorderRadius.circular(100);
      case ZephyrAvatarShape.square:
        return BorderRadius.zero;
      case ZephyrAvatarShape.rounded:
        return BorderRadius.circular(8);
    }
  }

  Color _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    if (name != null && name!.isNotEmpty) {
      final colors = [
        const Color(0xFF3B82F6),
        const Color(0xFF10B981),
        const Color(0xFFF59E0B),
        const Color(0xFFEF4444),
        const Color(0xFF6366F1),
        const Color(0xFF8B5CF6),
      ];
      final index = name!.hashCode % colors.length;
      return colors[index];
    }
    return const Color(0xFFE5E7EB);
  }

  Color _getTextColor() {
    if (textColor != null) return textColor!;
    return Colors.white;
  }

  String _getInitials() {
    if (name == null || name!.isEmpty) return '';
    final parts = name!.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else {
      return name![0].toUpperCase();
    }
  }

  Widget _buildAvatarContent() {
    final size = _getSize();
    final fontSize = _getFontSize();
    final backgroundColor = _getBackgroundColor();
    final textColor = _getTextColor();
    final borderRadius = _getBorderRadius();

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallback(size, backgroundColor, textColor, fontSize);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: size,
              height: size,
              color: backgroundColor,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              ),
            );
          },
        ),
      );
    } else if (icon != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: textColor,
            size: fontSize * 1.5,
          ),
          child: icon!,
        ),
      );
    } else {
      return _buildFallback(size, backgroundColor, textColor, fontSize);
    }
  }

  Widget _buildFallback(double size, Color backgroundColor, Color textColor, double fontSize) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: _getBorderRadius(),
      ),
      child: Center(
        child: Text(
          _getInitials(),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = _getSize();
    final borderRadius = _getBorderRadius();
    
    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: bordered
            ? Border.all(
                color: borderColor ?? Colors.white,
                width: 2,
              )
            : null,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: _buildAvatarContent(),
    );

    // 在线状态指示器
    if (isOnline) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: size * 0.3,
              height: size * 0.3,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      avatar = GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: avatar,
        ),
      );
    }

    return avatar;
  }
}

/// 头像组组件
class ZephyrAvatarGroup extends StatelessWidget {
  /// 头像列表
  final List<ZephyrAvatar> avatars;
  
  /// 组布局
  final ZephyrAvatarGroupLayout layout;
  
  /// 头像间距
  final double spacing;
  
  /// 最大显示数量
  final int? maxVisible;
  
  /// 剩余数量文本
  final String? overflowText;
  
  /// 是否堆叠显示
  final bool stacked;
  
  /// 堆叠偏移量
  final double stackOffset;
  
  /// 创建头像组组件
  const ZephyrAvatarGroup({
    Key? key,
    required this.avatars,
    this.layout = ZephyrAvatarGroupLayout.horizontal,
    this.spacing = 8.0,
    this.maxVisible,
    this.overflowText,
    this.stacked = false,
    this.stackOffset = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (avatars.isEmpty) {
      return const SizedBox();
    }

    final visibleAvatars = maxVisible != null 
        ? avatars.take(maxVisible!).toList()
        : avatars;
    final remainingCount = avatars.length - visibleAvatars.length;

    Widget buildOverflowBadge() {
      if (remainingCount <= 0) return const SizedBox();
      
      return Container(
        width: stacked ? stackOffset : null,
        height: stacked ? stackOffset : null,
        decoration: BoxDecoration(
          color: const Color(0xFF6B7280),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            overflowText ?? '+$remainingCount',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    List<Widget> children = [];

    if (stacked) {
      // 堆叠布局
      for (int i = 0; i < visibleAvatars.length; i++) {
        children.add(
          Positioned(
            left: i * stackOffset,
            child: visibleAvatars[i],
          ),
        );
      }
      if (remainingCount > 0) {
        children.add(
          Positioned(
            left: visibleAvatars.length * stackOffset,
            child: buildOverflowBadge(),
          ),
        );
      }
      
      return Container(
        width: (visibleAvatars.length + (remainingCount > 0 ? 1 : 0)) * stackOffset,
        height: stackOffset,
        child: Stack(
          children: children,
        ),
      );
    } else {
      // 普通布局
      children.addAll(visibleAvatars);
      if (remainingCount > 0) {
        children.add(buildOverflowBadge());
      }

      switch (layout) {
        case ZephyrAvatarGroupLayout.horizontal:
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: children
                .expand((avatar) => [avatar, SizedBox(width: spacing)])
                .take(children.length * 2 - 1)
                .toList(),
          );
        case ZephyrAvatarGroupLayout.vertical:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: children
                .expand((avatar) => [avatar, SizedBox(height: spacing)])
                .take(children.length * 2 - 1)
                .toList(),
          );
        case ZephyrAvatarGroupLayout.grid:
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: children,
          );
      }
    }
  }
}