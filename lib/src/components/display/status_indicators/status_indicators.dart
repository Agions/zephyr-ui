import 'package:flutter/material.dart';

/// 状态类型
enum ZephyrStatusType {
  /// 默认状态
  default_,
  
  /// 成功状态
  success,
  
  /// 警告状态
  warning,
  
  /// 错误状态
  error,
  
  /// 信息状态
  info,
  
  /// 处理中状态
  processing,
  
  /// 等待状态
  pending,
  
  /// 自定义状态
  custom,
}

/// 状态形状
enum ZephyrStatusShape {
  /// 圆形
  circle,
  
  /// 方形
  square,
  
  /// 圆角方形
  rounded,
  
  /// 菱形
  diamond,
  
  /// 三角形
  triangle,
}

/// 状态大小
enum ZephyrStatusSize {
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

/// ZephyrUI 状态指示器组件
///
/// 一个简洁的状态指示器组件，用于显示各种状态信息。
///
/// 特性：
/// - 多种状态类型
/// - 自定义形状和大小
/// - 动画效果
/// - 自定义颜色
/// - 文本标签
/// - 响应式设计
///
/// 示例用法：
/// ```dart
/// ZephyrStatusIndicator(
///   type: ZephyrStatusType.success,
///   shape: ZephyrStatusShape.circle,
///   size: ZephyrStatusSize.medium,
///   label: '已完成',
/// )
/// ```
class ZephyrStatusIndicator extends StatelessWidget {
  /// 状态类型
  final ZephyrStatusType type;
  
  /// 状态形状
  final ZephyrStatusShape shape;
  
  /// 状态大小
  final ZephyrStatusSize size;
  
  /// 标签文本
  final String? label;
  
  /// 自定义颜色
  final Color? color;
  
  /// 是否显示动画
  final bool animated;
  
  /// 是否显示边框
  final bool bordered;
  
  /// 是否显示阴影
  final bool showShadow;
  
  /// 自定义图标
  final Widget? icon;
  
  /// 点击回调
  final VoidCallback? onTap;
  
  /// 创建状态指示器组件
  const ZephyrStatusIndicator({
    Key? key,
    required this.type,
    this.shape = ZephyrStatusShape.circle,
    this.size = ZephyrStatusSize.medium,
    this.label,
    this.color,
    this.animated = true,
    this.bordered = false,
    this.showShadow = false,
    this.icon,
    this.onTap,
  }) : super(key: key);

  Color _getStatusColor() {
    if (color != null) return color!;
    
    switch (type) {
      case ZephyrStatusType.success:
        return const Color(0xFF10B981);
      case ZephyrStatusType.warning:
        return const Color(0xFFF59E0B);
      case ZephyrStatusType.error:
        return const Color(0xFFEF4444);
      case ZephyrStatusType.info:
        return const Color(0xFF6366F1);
      case ZephyrStatusType.processing:
        return const Color(0xFF3B82F6);
      case ZephyrStatusType.pending:
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getStatusIcon() {
    if (icon != null) return Icons.circle; // 占位，实际使用自定义图标
    
    switch (type) {
      case ZephyrStatusType.success:
        return Icons.check_circle;
      case ZephyrStatusType.warning:
        return Icons.warning;
      case ZephyrStatusType.error:
        return Icons.error;
      case ZephyrStatusType.info:
        return Icons.info;
      case ZephyrStatusType.processing:
        return Icons.autorenew;
      case ZephyrStatusType.pending:
        return Icons.schedule;
      default:
        return Icons.circle;
    }
  }

  double _getSize() {
    switch (size) {
      case ZephyrStatusSize.xs:
        return 12.0;
      case ZephyrStatusSize.small:
        return 16.0;
      case ZephyrStatusSize.medium:
        return 20.0;
      case ZephyrStatusSize.large:
        return 24.0;
      case ZephyrStatusSize.xl:
        return 32.0;
    }
  }

  Widget _buildStatusIndicator() {
    final size = _getSize();
    final color = _getStatusColor();
    
    Widget indicator;
    
    switch (shape) {
      case ZephyrStatusShape.circle:
        indicator = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: bordered ? Border.all(color: color, width: 2) : null,
            boxShadow: showShadow ? [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: icon != null 
              ? IconTheme(
                  data: IconThemeData(
                    color: color,
                    size: size * 0.6,
                  ),
                  child: icon!,
                )
              : Icon(
                  _getStatusIcon(),
                  color: color,
                  size: size * 0.6,
                ),
        );
        break;
        
      case ZephyrStatusShape.square:
        indicator = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            border: bordered ? Border.all(color: color, width: 2) : null,
            boxShadow: showShadow ? [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: icon != null 
              ? IconTheme(
                  data: IconThemeData(
                    color: color,
                    size: size * 0.6,
                  ),
                  child: icon!,
                )
              : Icon(
                  _getStatusIcon(),
                  color: color,
                  size: size * 0.6,
                ),
        );
        break;
        
      case ZephyrStatusShape.rounded:
        indicator = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
            border: bordered ? Border.all(color: color, width: 2) : null,
            boxShadow: showShadow ? [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: icon != null 
              ? IconTheme(
                  data: IconThemeData(
                    color: color,
                    size: size * 0.6,
                  ),
                  child: icon!,
                )
              : Icon(
                  _getStatusIcon(),
                  color: color,
                  size: size * 0.6,
                ),
        );
        break;
        
      case ZephyrStatusShape.diamond:
        indicator = Transform.rotate(
          angle: 3.14159 / 4,
          child: Container(
            width: size * 0.7,
            height: size * 0.7,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              border: bordered ? Border.all(color: color, width: 2) : null,
              boxShadow: showShadow ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
          ),
        );
        break;
        
      case ZephyrStatusShape.triangle:
        indicator = CustomPaint(
          size: Size(size, size),
          painter: _TrianglePainter(color: color.withValues(alpha: 0.2)),
        );
        break;
    }
    
    if (animated && type == ZephyrStatusType.processing) {
      indicator = AnimatedRotation(
        turns: 1.0,
        duration: const Duration(seconds: 1),
        child: indicator,
      );
    }
    
    return indicator;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatusIndicator(),
        if (label != null) ...[
          const SizedBox(width: 8),
          Text(
            label!,
            style: TextStyle(
              fontSize: _getSize() * 0.7,
              fontWeight: FontWeight.w500,
              color: _getStatusColor(),
            ),
          ),
        ],
      ],
    );
    
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

/// 三角形绘制器
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}