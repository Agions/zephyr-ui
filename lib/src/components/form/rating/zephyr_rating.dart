/// ZephyrUI 评分组件
/// 
/// 提供专业的评分展示和交互组件，支持多种样式和自定义

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 评分图标类型
enum ZephyrRatingIconType {
  star,
  heart,
  thumb,
  circle,
  custom,
}

/// 评分大小
enum ZephyrRatingSize {
  small,
  medium,
  large,
  extraLarge,
}

/// 评分组件
class ZephyrRating extends StatefulWidget {
  final double value;
  final int max;
  final ZephyrRatingIconType iconType;
  final ZephyrRatingSize size;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? hoverColor;
  final bool allowHalfRating;
  final bool readonly;
  final bool showValue;
  final Widget? customIcon;
  final ValueChanged<double>? onChanged;
  final String? semanticLabel;
  final ZephyrRatingTheme? theme;

  const ZephyrRating({
    super.key,
    required this.value,
    this.max = 5,
    this.iconType = ZephyrRatingIconType.star,
    this.size = ZephyrRatingSize.medium,
    this.activeColor,
    this.inactiveColor,
    this.hoverColor,
    this.allowHalfRating = false,
    this.readonly = false,
    this.showValue = false,
    this.customIcon,
    this.onChanged,
    this.semanticLabel,
    this.theme,
  });

  @override
  State<ZephyrRating> createState() => _ZephyrRatingState();
}

class _ZephyrRatingState extends State<ZephyrRating> {
  double _hoverValue = 0.0;
  bool _isHovering = false;

  double get _iconSize {
    switch (widget.size) {
      case ZephyrRatingSize.small:
        return 16.0;
      case ZephyrRatingSize.medium:
        return 24.0;
      case ZephyrRatingSize.large:
        return 32.0;
      case ZephyrRatingSize.extraLarge:
        return 48.0;
    }
  }

  double get _spacing {
    switch (widget.size) {
      case ZephyrRatingSize.small:
        return 2.0;
      case ZephyrRatingSize.medium:
        return 4.0;
      case ZephyrRatingSize.large:
        return 6.0;
      case ZephyrRatingSize.extraLarge:
        return 8.0;
    }
  }

  Color get _activeColor => widget.activeColor ?? Colors.amber;
  Color get _inactiveColor => widget.inactiveColor ?? Colors.grey.shade300;
  Color get _hoverColor => widget.hoverColor ?? Colors.amber.shade300;

  Widget _buildIcon(int index, {bool isActive = false, bool isHalf = false}) {
    final icon = switch (widget.iconType) {
      ZephyrRatingIconType.star => Icons.star,
      ZephyrRatingIconType.heart => Icons.favorite,
      ZephyrRatingIconType.thumb => Icons.thumb_up,
      ZephyrRatingIconType.circle => Icons.circle,
      ZephyrRatingIconType.custom => widget.customIcon ?? Icons.star,
    };

    final color = isActive ? _activeColor : _inactiveColor;

    return Icon(
      icon,
      size: _iconSize,
      color: color,
    );
  }

  Widget _buildRatingItem(int index) {
    final itemValue = index + 1;
    final isActive = widget.value >= itemValue;
    final isHalfActive = widget.allowHalfRating && 
        widget.value >= index + 0.5 && 
        widget.value < itemValue;
    final isHovered = _isHovering && _hoverValue >= itemValue;

    final child = Stack(
      children: [
        _buildIcon(index, isActive: isActive),
        if (isHalfActive)
          ClipRect(
            clipper: _HalfClipper(),
            child: _buildIcon(index, isActive: true),
          ),
      ],
    );

    if (widget.readonly) {
      return child;
    }

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
          _hoverValue = itemValue.toDouble();
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
          _hoverValue = 0.0;
        });
      },
      child: GestureDetector(
        onTapDown: (details) {
          if (widget.allowHalfRating) {
            final localPosition = details.localPosition;
            final halfWidth = _iconSize / 2;
            final value = localPosition.dx < halfWidth 
                ? index + 0.5 
                : itemValue.toDouble();
            widget.onChanged?.call(value);
          } else {
            widget.onChanged?.call(itemValue.toDouble());
          }
        },
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrRatingTheme.resolve(context, widget.theme);
    
    return ZephyrPerformanceWidget(
      widgetName: 'ZephyrRating',
      child: Semantics(
        label: widget.semanticLabel ?? '评分: ${widget.value}',
        value: widget.value.toString(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.max, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: index < widget.max - 1 ? _spacing : 0),
                  child: _buildRatingItem(index),
                );
              }),
            ),
            if (widget.showValue) ...[
              const SizedBox(width: 8),
              ZephyrText.body(
                text: widget.value.toStringAsFixed(1),
                color: effectiveTheme.textColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 半星裁剪器
class _HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

/// 评分显示组件（只读）
class ZephyrRatingDisplay extends StatelessWidget {
  final double value;
  final int max;
  final ZephyrRatingIconType iconType;
  final ZephyrRatingSize size;
  final Color? activeColor;
  final Color? inactiveColor;
  final Widget? customIcon;
  final bool showValue;
  final String? semanticLabel;
  final ZephyrRatingTheme? theme;

  const ZephyrRatingDisplay({
    super.key,
    required this.value,
    this.max = 5,
    this.iconType = ZephyrRatingIconType.star,
    this.size = ZephyrRatingSize.medium,
    this.activeColor,
    this.inactiveColor,
    this.customIcon,
    this.showValue = false,
    this.semanticLabel,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ZephyrRating(
      value: value,
      max: max,
      iconType: iconType,
      size: size,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      readonly: true,
      showValue: showValue,
      customIcon: customIcon,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }
}

/// 评分主题
class ZephyrRatingTheme extends ThemeExtension<ZephyrRatingTheme> {
  final Color activeColor;
  final Color inactiveColor;
  final Color hoverColor;
  final Color textColor;
  final double borderRadius;
  final Duration animationDuration;

  const ZephyrRatingTheme({
    required this.activeColor,
    required this.inactiveColor,
    required this.hoverColor,
    required this.textColor,
    required this.borderRadius,
    required this.animationDuration,
  });

  @override
  ZephyrRatingTheme copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? hoverColor,
    Color? textColor,
    double? borderRadius,
    Duration? animationDuration,
  }) {
    return ZephyrRatingTheme(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      hoverColor: hoverColor ?? this.hoverColor,
      textColor: textColor ?? this.textColor,
      borderRadius: borderRadius ?? this.borderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  ZephyrRatingTheme lerp(ThemeExtension<ZephyrRatingTheme>? other, double t) {
    if (other is! ZephyrRatingTheme) {
      return this;
    }
    return ZephyrRatingTheme(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      borderRadius: ui.lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      animationDuration: lerpDuration(animationDuration, other.animationDuration, t),
    );
  }

  static ZephyrRatingTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrRatingTheme>();
    return theme ?? _createDefaultTheme(ZephyrThemeData.of(context));
  }

  static ZephyrRatingTheme resolve(
    BuildContext context,
    ZephyrRatingTheme? theme,
  ) {
    return theme ?? of(context);
  }

  static ZephyrRatingTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    return ZephyrRatingTheme(
      activeColor: Colors.amber,
      inactiveColor: Colors.grey.shade300,
      hoverColor: Colors.amber.shade300,
      textColor: Colors.grey.shade700,
      borderRadius: 4.0,
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  static Duration lerpDuration(Duration a, Duration b, double t) {
    return Duration(
      microseconds: ((a.inMicroseconds + (b.inMicroseconds - a.inMicroseconds) * t).round()),
    );
  }
}