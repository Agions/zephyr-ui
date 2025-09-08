/// chromaUI 评分组件
///
/// 提供专业的评分展示和交互组件，支持多种样式和自定义

import 'package:flutter/material.dart';
import 'package:chroma_ui/chroma_ui.dart';

/// 评分图标类型
enum chromaRatingIconType {
  star,
  heart,
  thumb,
  circle,
  custom,
}

/// 评分大小
enum chromaRatingSize {
  small,
  medium,
  large,
  extraLarge,
}

/// 评分组件
class chromaRating extends StatefulWidget {
  final double value;
  final int max;
  final chromaRatingIconType iconType;
  final chromaRatingSize size;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? hoverColor;
  final bool allowHalfRating;
  final bool readonly;
  final bool showValue;
  final Widget? customIcon;
  final ValueChanged<double>? onChanged;
  final String? semanticLabel;
  final chromaRatingTheme? theme;

  const chromaRating({
    Key? key,
    required this.value,
    this.max = 5,
    this.iconType = chromaRatingIconType.star,
    this.size = chromaRatingSize.medium,
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
  }) : super(key: key);

  @override
  State<chromaRating> createState() => _chromaRatingState();
}

class _chromaRatingState extends State<chromaRating> {
  double _hoverValue = 0.0;
  bool _isHovering = false;

  double get _iconSize {
    switch (widget.size) {
      case chromaRatingSize.small:
        return 16.0;
      case chromaRatingSize.medium:
        return 24.0;
      case chromaRatingSize.large:
        return 32.0;
      case chromaRatingSize.extraLarge:
        return 48.0;
    }
  }

  double get _spacing {
    switch (widget.size) {
      case chromaRatingSize.small:
        return 2.0;
      case chromaRatingSize.medium:
        return 4.0;
      case chromaRatingSize.large:
        return 6.0;
      case chromaRatingSize.extraLarge:
        return 8.0;
    }
  }

  Color get _activeColor => widget.activeColor ?? Colors.amber;
  Color get _inactiveColor => widget.inactiveColor ?? Colors.grey.shade300;
  Color get _hoverColor => widget.hoverColor ?? Colors.amber.shade300;

  Widget _buildIcon(int index, {bool isActive = false, bool isHalf = false}) {
    final icon = switch (widget.iconType) {
      chromaRatingIconType.star => Icons.star,
      chromaRatingIconType.heart => Icons.favorite,
      chromaRatingIconType.thumb => Icons.thumb_up,
      chromaRatingIconType.circle => Icons.circle,
      chromaRatingIconType.custom => widget.customIcon ?? Icons.star,
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
    final effectiveTheme = chromaRatingTheme.resolve(context, widget.theme);

    return chromaPerformanceWidget(
      widgetName: 'chromaRating',
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
                  padding: EdgeInsets.only(right: index < widget.max - 1 ? _spacing : 0),
                  child: _buildRatingItem(index),
                );
              }),
            ),
            if (widget.showValue) ...[
              const SizedBox(width: 8),
              chromaText.body(
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
class chromaRatingDisplay extends StatelessWidget {
  final double value;
  final int max;
  final chromaRatingIconType iconType;
  final chromaRatingSize size;
  final Color? activeColor;
  final Color? inactiveColor;
  final Widget? customIcon;
  final bool showValue;
  final String? semanticLabel;
  final chromaRatingTheme? theme;

  const chromaRatingDisplay({
    Key? key,
    required this.value,
    this.max = 5,
    this.iconType = chromaRatingIconType.star,
    this.size = chromaRatingSize.medium,
    this.activeColor,
    this.inactiveColor,
    this.customIcon,
    this.showValue = false,
    this.semanticLabel,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chromaRating(
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
class chromaRatingTheme extends ThemeExtension<chromaRatingTheme> {
  final Color activeColor;
  final Color inactiveColor;
  final Color hoverColor;
  final Color textColor;
  final double borderRadius;
  final Duration animationDuration;

  const chromaRatingTheme({
    required this.activeColor,
    required this.inactiveColor,
    required this.hoverColor,
    required this.textColor,
    required this.borderRadius,
    required this.animationDuration,
  });

  @override
  chromaRatingTheme copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? hoverColor,
    Color? textColor,
    double? borderRadius,
    Duration? animationDuration,
  }) {
    return chromaRatingTheme(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      hoverColor: hoverColor ?? this.hoverColor,
      textColor: textColor ?? this.textColor,
      borderRadius: borderRadius ?? this.borderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  chromaRatingTheme lerp(ThemeExtension<chromaRatingTheme>? other, double t) {
    if (other is! chromaRatingTheme) {
      return this;
    }
    return chromaRatingTheme(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      borderRadius: ui.lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      animationDuration: lerpDuration(animationDuration, other.animationDuration, t),
    );
  }

  static chromaRatingTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<chromaRatingTheme>();
    return theme ?? _createDefaultTheme(chromaThemeData.of(context));
  }

  static chromaRatingTheme resolve(
    BuildContext context,
    chromaRatingTheme? theme,
  ) {
    return theme ?? of(context);
  }

  static chromaRatingTheme _createDefaultTheme(chromaThemeData chromaTheme) {
    return chromaRatingTheme(
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
