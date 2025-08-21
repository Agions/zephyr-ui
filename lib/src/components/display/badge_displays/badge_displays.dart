import 'package:flutter/material.dart';

/// 徽章类型
enum ZephyrBadgeType {
  /// 默认徽章
  default_,
  
  /// 主要徽章
  primary,
  
  /// 成功徽章
  success,
  
  /// 警告徽章
  warning,
  
  /// 错误徽章
  error,
  
  /// 信息徽章
  info,
  
  /// 自定义徽章
  custom,
}

/// 徽章形状
enum ZephyrBadgeShape {
  /// 圆形
  circle,
  
  /// 圆角矩形
  rounded,
  
  /// 方形
  square,
  
  /// 药丸形状
  pill,
}

/// 徽章大小
enum ZephyrBadgeSize {
  /// 超小
  xs,
  
  /// 小
  small,
  
  /// 中等
  medium,
  
  /// 大
  large,
}

/// ZephyrUI 徽章显示组件
///
/// 一个灵活的徽章组件，用于显示状态、数量、标签等信息。
///
/// 特性：
/// - 多种徽章类型和形状
/// - 自定义颜色和大小
/// - 动画效果
/// - 图标支持
/// - 点击交互
/// - 响应式设计
///
/// 示例用法：
/// ```dart
/// ZephyrBadge(
///   text: 'New',
///   type: ZephyrBadgeType.primary,
///   shape: ZephyrBadgeShape.pill,
///   size: ZephyrBadgeSize.small,
/// )
/// ```
class ZephyrBadge extends StatelessWidget {
  /// 徽章文本
  final String text;
  
  /// 徽章类型
  final ZephyrBadgeType type;
  
  /// 徽章形状
  final ZephyrBadgeShape shape;
  
  /// 徽章大小
  final ZephyrBadgeSize size;
  
  /// 自定义颜色
  final Color? color;
  
  /// 文本颜色
  final Color? textColor;
  
  /// 图标
  final Widget? icon;
  
  /// 是否显示边框
  final bool bordered;
  
  /// 是否显示阴影
  final bool showShadow;
  
  /// 是否动画
  final bool animated;
  
  /// 点击回调
  final VoidCallback? onTap;
  
  /// 创建徽章组件
  const ZephyrBadge({
    Key? key,
    required this.text,
    this.type = ZephyrBadgeType.default_,
    this.shape = ZephyrBadgeShape.rounded,
    this.size = ZephyrBadgeSize.medium,
    this.color,
    this.textColor,
    this.icon,
    this.bordered = false,
    this.showShadow = false,
    this.animated = false,
    this.onTap,
  }) : super(key: key);

  Color _getBadgeColor() {
    if (color != null) return color!;
    
    switch (type) {
      case ZephyrBadgeType.primary:
        return const Color(0xFF3B82F6);
      case ZephyrBadgeType.success:
        return const Color(0xFF10B981);
      case ZephyrBadgeType.warning:
        return const Color(0xFFF59E0B);
      case ZephyrBadgeType.error:
        return const Color(0xFFEF4444);
      case ZephyrBadgeType.info:
        return const Color(0xFF6366F1);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Color _getTextColor() {
    if (textColor != null) return textColor!;
    return Colors.white;
  }

  double _getFontSize() {
    switch (size) {
      case ZephyrBadgeSize.xs:
        return 10.0;
      case ZephyrBadgeSize.small:
        return 11.0;
      case ZephyrBadgeSize.medium:
        return 12.0;
      case ZephyrBadgeSize.large:
        return 14.0;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ZephyrBadgeSize.xs:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
      case ZephyrBadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case ZephyrBadgeSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ZephyrBadgeSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (shape) {
      case ZephyrBadgeShape.circle:
        return BorderRadius.circular(100);
      case ZephyrBadgeShape.rounded:
        return BorderRadius.circular(4);
      case ZephyrBadgeShape.square:
        return BorderRadius.zero;
      case ZephyrBadgeShape.pill:
        return BorderRadius.circular(100);
    }
  }

  Widget _buildBadge() {
    final badgeColor = _getBadgeColor();
    final textColor = _getTextColor();
    final fontSize = _getFontSize();
    final padding = _getPadding();
    final borderRadius = _getBorderRadius();
    
    Widget badge = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: borderRadius,
        border: bordered 
            ? Border.all(color: badgeColor, width: 1)
            : null,
        boxShadow: showShadow ? [
          BoxShadow(
            color: badgeColor.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(
                color: textColor,
                size: fontSize * 1.2,
              ),
              child: icon!,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
    
    if (animated) {
      badge = AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 200),
        child: badge,
      );
    }
    
    return badge;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _buildBadge();
    
    if (onTap != null) {
      child = GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: child,
        ),
      );
    }
    
    return child;
  }
}

/// 徽章组组件
class ZephyrBadgeGroup extends StatelessWidget {
  /// 徽章列表
  final List<ZephyrBadge> badges;
  
  /// 徽章间距
  final double spacing;
  
  /// 换行间距
  final double runSpacing;
  
  /// 对齐方式
  final WrapAlignment alignment;
  
  /// 创建徽章组组件
  const ZephyrBadgeGroup({
    Key? key,
    required this.badges,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      children: badges,
    );
  }
}

/// 点状徽章组件
class ZephyrDotBadge extends StatelessWidget {
  /// 子组件
  final Widget child;
  
  /// 徽章数量
  final int? count;
  
  /// 是否显示为点
  final bool isDot;
  
  /// 徽章类型
  final ZephyrBadgeType type;
  
  /// 自定义颜色
  final Color? color;
  
  /// 徽章位置
  final AlignmentGeometry alignment;
  
  /// 偏移量
  final Offset offset;
  
  /// 是否隐藏为零
  final bool hideZero;
  
  /// 创建点状徽章组件
  const ZephyrDotBadge({
    Key? key,
    required this.child,
    this.count,
    this.isDot = false,
    this.type = ZephyrBadgeType.error,
    this.color,
    this.alignment = Alignment.topRight,
    this.offset = const Offset(-4, 4),
    this.hideZero = true,
  }) : super(key: key);

  Color _getBadgeColor() {
    if (color != null) return color!;
    
    switch (type) {
      case ZephyrBadgeType.primary:
        return const Color(0xFF3B82F6);
      case ZephyrBadgeType.success:
        return const Color(0xFF10B981);
      case ZephyrBadgeType.warning:
        return const Color(0xFFF59E0B);
      case ZephyrBadgeType.error:
        return const Color(0xFFEF4444);
      case ZephyrBadgeType.info:
        return const Color(0xFF6366F1);
      default:
        return const Color(0xFFEF4444);
    }
  }

  @override
  Widget build(BuildContext context) {
    final badgeColor = _getBadgeColor();
    final shouldShow = !hideZero || (count != null && count! > 0);
    
    return Stack(
      alignment: alignment,
      children: [
        child,
        if (shouldShow)
          Transform.translate(
            offset: offset,
            child: Container(
              padding: isDot 
                  ? const EdgeInsets.all(4) 
                  : const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badgeColor,
                shape: isDot ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: isDot ? null : BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
              ),
              constraints: BoxConstraints(
                minWidth: isDot ? 8 : 16,
                minHeight: isDot ? 8 : 16,
              ),
              child: isDot 
                  ? null 
                  : Text(
                      count?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
      ],
    );
  }
}