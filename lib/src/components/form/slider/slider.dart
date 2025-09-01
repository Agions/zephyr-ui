import 'package:flutter/material.dart';
import 'slider_theme.dart';

/// 滑块的类型
enum ZephyrSliderType {
  /// 标准滑块
  standard,

  /// 带有离散值的滑块
  discrete,

  /// 带有值指示器的滑块
  indicator,
}

/// 滑块组件
///
/// 允许用户通过拖动滑块在一个范围内选择值
class ZephyrSlider extends StatefulWidget {
  /// 当前值
  final double value;

  /// 最小值
  final double min;

  /// 最大值
  final double max;

  /// 滑块类型
  final ZephyrSliderType type;

  /// 是否禁用
  final bool disabled;

  /// 分割数量（用于离散滑块）
  final int? divisions;

  /// 标签（用于带指示器的滑块）
  final String? label;

  /// 值变化时的回调
  final ValueChanged<double>? onChanged;

  /// 拖动开始时的回调
  final ValueChanged<double>? onChangeStart;

  /// 拖动结束时的回调
  final ValueChanged<double>? onChangeEnd;

  /// 自定义主题
  final ZephyrSliderTheme? theme;

  /// 创建滑块组件
  const ZephyrSlider({
    Key? key,
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.type = ZephyrSliderType.standard,
    this.disabled = false,
    this.divisions,
    this.label,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.theme,
  }) : super(key: key);

  @override
  State<ZephyrSlider> createState() => _ZephyrSliderState();
}

class _ZephyrSliderState extends State<ZephyrSlider> {
  late double _value;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(ZephyrSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrSliderTheme.of(context);

    // 根据禁用状态选择颜色
    final activeTrackColor = widget.disabled
        ? theme.disabledActiveTrackColor
        : _isHovered
            ? theme.hoverActiveTrackColor
            : theme.activeTrackColor;

    final inactiveTrackColor = widget.disabled
        ? theme.disabledInactiveTrackColor
        : _isHovered
            ? theme.hoverInactiveTrackColor
            : theme.inactiveTrackColor;

    final thumbColor = widget.disabled
        ? theme.disabledThumbColor
        : _isHovered
            ? theme.hoverThumbColor
            : theme.thumbColor;

    final thumbBorderColor = widget.disabled
        ? theme.disabledThumbBorderColor
        : _isHovered
            ? theme.hoverThumbBorderColor
            : theme.thumbBorderColor;

    // 回调处理逻辑在_buildSlider方法中实现

    // 自定义滑块外观
    final SliderThemeData sliderThemeData = SliderThemeData(
      trackHeight: theme.trackHeight,
      activeTrackColor: activeTrackColor,
      inactiveTrackColor: inactiveTrackColor,
      thumbColor: thumbColor,
      thumbShape: _CustomThumbShape(
        radius: theme.thumbSize / 2,
        borderColor: thumbBorderColor,
        borderWidth: theme.thumbBorderWidth,
        isHovered: _isHovered,
      ),
      overlayColor: theme.thumbColor.withValues(alpha: 0.12),
      overlayShape:
          RoundSliderOverlayShape(overlayRadius: theme.thumbSize * 0.8),
      valueIndicatorColor: theme.valueIndicatorColor,
      valueIndicatorTextStyle: theme.valueIndicatorTextStyle,
      trackShape: _CustomTrackShape(borderRadius: theme.trackBorderRadius),
    );

    return Semantics(
      label: widget.label ?? '滑块',
      value: _value.toStringAsFixed(1),
      increasedValue:
          (_value + (widget.max - widget.min) / 100).toStringAsFixed(1),
      decreasedValue:
          (_value - (widget.max - widget.min) / 100).toStringAsFixed(1),
      child: MouseRegion(
        onEnter: (_) {
          if (!widget.disabled) {
            setState(() {
              _isHovered = true;
            });
          }
        },
        onExit: (_) {
          if (!widget.disabled) {
            setState(() {
              _isHovered = false;
            });
          }
        },
        child: SliderTheme(
          data: sliderThemeData,
          child: _buildSlider(),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    switch (widget.type) {
      case ZephyrSliderType.discrete:
        return Slider(
          value: _value,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions ?? ((widget.max - widget.min).toInt()),
          onChanged: widget.disabled
              ? null
              : (double value) {
                  setState(() {
                    _value = value;
                  });
                  widget.onChanged?.call(value);
                },
          onChangeStart: widget.disabled ? null : widget.onChangeStart,
          onChangeEnd: widget.disabled ? null : widget.onChangeEnd,
        );

      case ZephyrSliderType.indicator:
        return Slider(
          value: _value,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          label: widget.label ?? _value.toStringAsFixed(1),
          onChanged: widget.disabled
              ? null
              : (double value) {
                  setState(() {
                    _value = value;
                  });
                  widget.onChanged?.call(value);
                },
          onChangeStart: widget.disabled ? null : widget.onChangeStart,
          onChangeEnd: widget.disabled ? null : widget.onChangeEnd,
        );

      case ZephyrSliderType.standard:
      default:
        return Slider(
          value: _value,
          min: widget.min,
          max: widget.max,
          onChanged: widget.disabled
              ? null
              : (double value) {
                  setState(() {
                    _value = value;
                  });
                  widget.onChanged?.call(value);
                },
          onChangeStart: widget.disabled ? null : widget.onChangeStart,
          onChangeEnd: widget.disabled ? null : widget.onChangeEnd,
        );
    }
  }
}

/// 自定义滑块形状
class _CustomThumbShape extends SliderComponentShape {
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final bool isHovered;

  const _CustomThumbShape({
    required this.radius,
    required this.borderColor,
    required this.borderWidth,
    required this.isHovered,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(isHovered ? radius * 1.2 : radius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final double effectiveRadius = isHovered ? radius * 1.2 : radius;

    final Paint fillPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawCircle(center, effectiveRadius, fillPaint);
    canvas.drawCircle(center, effectiveRadius, borderPaint);

    // 添加hover效果的光晕
    if (isHovered) {
      final Paint glowPaint = Paint()
        ..color = sliderTheme.thumbColor!.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

      canvas.drawCircle(center, effectiveRadius * 1.5, glowPaint);
    }
  }
}

/// 自定义轨道形状
class _CustomTrackShape extends RoundedRectSliderTrackShape {
  final double borderRadius;

  const _CustomTrackShape({required this.borderRadius});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    // 获取轨道矩形
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // 活动轨道部分
    final activeRect = RRect.fromLTRBAndCorners(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
      topLeft: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
    );

    // 非活动轨道部分
    final inactiveRect = RRect.fromLTRBAndCorners(
      thumbCenter.dx,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
      topRight: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    final Paint activePaint = Paint()..color = sliderTheme.activeTrackColor!;
    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!;

    context.canvas.drawRRect(activeRect, activePaint);
    context.canvas.drawRRect(inactiveRect, inactivePaint);
  }
}
