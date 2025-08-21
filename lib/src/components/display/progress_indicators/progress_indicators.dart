import 'package:flutter/material.dart';
import 'progress_indicators_theme.dart';

/// 进度条类型
enum ZephyrProgressType {
  /// 线性进度条
  linear,
  
  /// 圆形进度条
  circular,
  
  /// 环形进度条
  ring,
  
  /// 半环形进度条
  semiRing,
  
  /// 波浪进度条
  wave,
}

/// 进度条样式
enum ZephyrProgressStyle {
  /// 默认样式
  default_,
  
  /// 成功样式
  success,
  
  /// 警告样式
  warning,
  
  /// 错误样式
  error,
  
  /// 信息样式
  info,
}

/// 进度条动画类型
enum ZephyrProgressAnimationType {
  /// 无动画
  none,
  
  /// 平滑动画
  smooth,
  
  /// 弹性动画
  elastic,
  
  /// 弹跳动画
  bounce,
}

/// ZephyrUI 进度指示器组件
///
/// 一个功能丰富的进度指示器组件，支持多种样式和动画效果。
///
/// 特性：
/// - 多种进度条类型（线性/圆形/环形/半环形/波浪）
/// - 丰富的样式选项
/// - 自定义颜色和大小
/// - 动画效果
/// - 进度文本显示
/// - 缓冲进度显示
/// - 响应式设计
/// - 无障碍支持
///
/// 示例用法：
/// ```dart
/// ZephyrProgressIndicator(
///   type: ZephyrProgressType.circular,
///   value: 0.75,
///   style: ZephyrProgressStyle.success,
///   showValue: true,
/// )
/// ```
class ZephyrProgressIndicator extends StatefulWidget {
  /// 进度值 (0.0 - 1.0)
  final double value;
  
  /// 缓冲值 (0.0 - 1.0)
  final double? bufferValue;
  
  /// 进度条类型
  final ZephyrProgressType type;
  
  /// 进度条样式
  final ZephyrProgressStyle style;
  
  /// 动画类型
  final ZephyrProgressAnimationType animationType;
  
  /// 动画持续时间
  final Duration animationDuration;
  
  /// 是否显示进度值
  final bool showValue;
  
  /// 是否显示百分比
  final bool showPercentage;
  
  /// 是否显示标签
  final bool showLabel;
  
  /// 标签文本
  final String? label;
  
  /// 进度条大小
  final double? size;
  
  /// 进度条粗细
  final double? strokeWidth;
  
  /// 背景颜色
  final Color? backgroundColor;
  
  /// 进度颜色
  final Color? progressColor;
  
  /// 缓冲颜色
  final Color? bufferColor;
  
  /// 文本颜色
  final Color? textColor;
  
  /// 是否圆角
  final bool rounded;
  
  /// 是否反向
  final bool reverse;
  
  /// 是否动画
  final bool animated;
  
  /// 自定义进度条构建器
  final Widget Function(BuildContext context, double value)? customProgressBuilder;
  
  /// 自定义文本构建器
  final Widget Function(BuildContext context, double value)? customTextBuilder;
  
  /// 主题数据
  final ZephyrProgressIndicatorsTheme? theme;
  
  /// 进度变化回调
  final Function(double value)? onValueChanged;
  
  /// 创建进度指示器组件
  const ZephyrProgressIndicator({
    Key? key,
    required this.value,
    this.bufferValue,
    this.type = ZephyrProgressType.linear,
    this.style = ZephyrProgressStyle.default_,
    this.animationType = ZephyrProgressAnimationType.smooth,
    this.animationDuration = const Duration(milliseconds: 300),
    this.showValue = true,
    this.showPercentage = true,
    this.showLabel = false,
    this.label,
    this.size,
    this.strokeWidth,
    this.backgroundColor,
    this.progressColor,
    this.bufferColor,
    this.textColor,
    this.rounded = true,
    this.reverse = false,
    this.animated = true,
    this.customProgressBuilder,
    this.customTextBuilder,
    this.theme,
    this.onValueChanged,
  }) : super(key: key);

  @override
  State<ZephyrProgressIndicator> createState() => _ZephyrProgressIndicatorState();
}

class _ZephyrProgressIndicatorState extends State<ZephyrProgressIndicator> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late ZephyrProgressIndicatorsTheme _theme;
  double _currentValue = 0.0;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrProgressIndicatorsTheme.light();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    
    _setupAnimation();
    _animationController.forward();
  }

  void _setupAnimation() {
    switch (widget.animationType) {
      case ZephyrProgressAnimationType.smooth:
        _progressAnimation = Tween<double>(
          begin: _currentValue,
          end: widget.value.clamp(0.0, 1.0),
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        break;
      case ZephyrProgressAnimationType.elastic:
        _progressAnimation = Tween<double>(
          begin: _currentValue,
          end: widget.value.clamp(0.0, 1.0),
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.elasticOut,
        ));
        break;
      case ZephyrProgressAnimationType.bounce:
        _progressAnimation = Tween<double>(
          begin: _currentValue,
          end: widget.value.clamp(0.0, 1.0),
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.bounceOut,
        ));
        break;
      default:
        _progressAnimation = Tween<double>(
          begin: widget.value.clamp(0.0, 1.0),
          end: widget.value.clamp(0.0, 1.0),
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.linear,
        ));
        break;
    }
  }

  @override
  void didUpdateWidget(ZephyrProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrProgressIndicatorsTheme.light();
    }
    if (widget.value != oldWidget.value) {
      _currentValue = _progressAnimation.value;
      _setupAnimation();
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getProgressColor() {
    if (widget.progressColor != null) return widget.progressColor!;
    
    switch (widget.style) {
      case ZephyrProgressStyle.success:
        return _theme.successColor;
      case ZephyrProgressStyle.warning:
        return _theme.warningColor;
      case ZephyrProgressStyle.error:
        return _theme.errorColor;
      case ZephyrProgressStyle.info:
        return _theme.infoColor;
      default:
        return _theme.primaryColor;
    }
  }

  Widget _buildLinearProgress() {
    final size = widget.size ?? 200.0;
    final strokeWidth = widget.strokeWidth ?? 8.0;
    
    return Container(
      width: size,
      height: strokeWidth,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? _theme.backgroundColor,
        borderRadius: widget.rounded ? BorderRadius.circular(strokeWidth / 2) : null,
      ),
      child: Stack(
        children: [
          // 缓冲进度
          if (widget.bufferValue != null && widget.bufferValue! > 0)
            FractionallySizedBox(
              alignment: widget.reverse ? Alignment.centerRight : Alignment.centerLeft,
              widthFactor: widget.bufferValue!.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.bufferColor ?? _theme.bufferColor,
                  borderRadius: widget.rounded ? BorderRadius.circular(strokeWidth / 2) : null,
                ),
              ),
            ),
          
          // 主进度
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return FractionallySizedBox(
                alignment: widget.reverse ? Alignment.centerRight : Alignment.centerLeft,
                widthFactor: _progressAnimation.value.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _getProgressColor(),
                    borderRadius: widget.rounded ? BorderRadius.circular(strokeWidth / 2) : null,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress() {
    final size = widget.size ?? 60.0;
    final strokeWidth = widget.strokeWidth ?? 6.0;
    
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // 背景圆
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.backgroundColor ?? _theme.backgroundColor,
                ),
              ),
              
              // 进度圆
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: _progressAnimation.value.clamp(0.0, 1.0),
                  strokeWidth: strokeWidth,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(_getProgressColor()),
                ),
              ),
              
              // 文本
              if (widget.showValue || widget.showLabel)
                _buildProgressText(_progressAnimation.value),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRingProgress() {
    final size = widget.size ?? 80.0;
    final strokeWidth = widget.strokeWidth ?? 8.0;
    
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // 背景环
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.backgroundColor ?? _theme.backgroundColor,
                ),
              ),
              
              // 进度环
              CustomPaint(
                size: Size(size, size),
                painter: _RingPainter(
                  progress: _progressAnimation.value.clamp(0.0, 1.0),
                  strokeWidth: strokeWidth,
                  progressColor: _getProgressColor(),
                  backgroundColor: Colors.transparent,
                ),
              ),
              
              // 文本
              if (widget.showValue || widget.showLabel)
                _buildProgressText(_progressAnimation.value),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSemiRingProgress() {
    final size = widget.size ?? 100.0;
    final strokeWidth = widget.strokeWidth ?? 10.0;
    
    return SizedBox(
      width: size,
      height: size / 2,
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // 背景半环
              CustomPaint(
                size: Size(size, size / 2),
                painter: _SemiRingPainter(
                  progress: 1.0,
                  strokeWidth: strokeWidth,
                  progressColor: widget.backgroundColor ?? _theme.backgroundColor,
                ),
              ),
              
              // 进度半环
              CustomPaint(
                size: Size(size, size / 2),
                painter: _SemiRingPainter(
                  progress: _progressAnimation.value.clamp(0.0, 1.0),
                  strokeWidth: strokeWidth,
                  progressColor: _getProgressColor(),
                ),
              ),
              
              // 文本
              if (widget.showValue || widget.showLabel)
                Positioned(
                  bottom: 10,
                  child: _buildProgressText(_progressAnimation.value),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWaveProgress() {
    final size = widget.size ?? 80.0;
    
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // 背景圆
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.backgroundColor ?? _theme.backgroundColor,
                ),
              ),
              
              // 波浪效果
              ClipOval(
                child: SizedBox(
                  width: size,
                  height: size,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        bottom: -size + (size * _progressAnimation.value.clamp(0.0, 1.0)),
                        child: Container(
                          color: _getProgressColor().withValues(alpha: 0.3),
                        ),
                      ),
                      Positioned.fill(
                        bottom: -size + (size * _progressAnimation.value.clamp(0.0, 1.0)) + 10,
                        child: Container(
                          color: _getProgressColor().withValues(alpha: 0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // 文本
              if (widget.showValue || widget.showLabel)
                _buildProgressText(_progressAnimation.value),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProgressText(double value) {
    if (widget.customTextBuilder != null) {
      return widget.customTextBuilder!(context, value);
    }
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showValue)
          Text(
            widget.showPercentage 
                ? '${(value * 100).toStringAsFixed(0)}%'
                : value.toStringAsFixed(2),
            style: _theme.textStyle.copyWith(
              color: widget.textColor ?? _theme.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (widget.showLabel && widget.label != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.label!,
            style: _theme.labelStyle.copyWith(
              color: widget.textColor ?? _theme.textColor,
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.customProgressBuilder != null) {
      return AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return widget.customProgressBuilder!(context, _progressAnimation.value);
        },
      );
    }

    switch (widget.type) {
      case ZephyrProgressType.linear:
        return _buildLinearProgress();
      case ZephyrProgressType.circular:
        return _buildCircularProgress();
      case ZephyrProgressType.ring:
        return _buildRingProgress();
      case ZephyrProgressType.semiRing:
        return _buildSemiRingProgress();
      case ZephyrProgressType.wave:
        return _buildWaveProgress();
    }
  }
}

/// 环形进度条绘制器
class _RingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 背景环
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    // 进度环
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// 半环形进度条绘制器
class _SemiRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;

  _SemiRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = (size.width - strokeWidth) / 2;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}