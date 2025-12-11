/// VelocityUI 评分组件
library velocity_rate;

import 'package:flutter/material.dart';
import 'rate_style.dart';

export 'rate_style.dart';

/// VelocityUI 评分
class VelocityRate extends StatelessWidget {
  const VelocityRate({
    super.key,
    required this.value,
    this.onChanged,
    this.count = 5,
    this.allowHalf = false,
    this.disabled = false,
    this.character,
    this.style,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final int count;
  final bool allowHalf;
  final bool disabled;
  final IconData? character;
  final VelocityRateStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityRateStyle();
    final icon = character ?? effectiveStyle.defaultIcon;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final starValue = index + 1;
        final isFull = value >= starValue;
        final isHalf = allowHalf && value > index && value < starValue;

        return GestureDetector(
          onTap: disabled
              ? null
              : () {
                  if (allowHalf) {
                    final newValue = value == starValue
                        ? starValue - 0.5
                        : (value == starValue - 0.5
                            ? starValue.toDouble()
                            : starValue.toDouble());
                    onChanged?.call(newValue);
                  } else {
                    onChanged?.call(starValue.toDouble());
                  }
                },
          child: Padding(
            padding: EdgeInsets.only(
                right: index < count - 1 ? effectiveStyle.spacing : 0),
            child: Stack(
              children: [
                Icon(icon,
                    size: effectiveStyle.size,
                    color: effectiveStyle.inactiveColor),
                if (isFull)
                  Icon(icon,
                      size: effectiveStyle.size,
                      color: disabled
                          ? effectiveStyle.disabledColor
                          : effectiveStyle.activeColor),
                if (isHalf)
                  ClipRect(
                    clipper: _HalfClipper(),
                    child: Icon(icon,
                        size: effectiveStyle.size,
                        color: disabled
                            ? effectiveStyle.disabledColor
                            : effectiveStyle.activeColor),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, size.width / 2, size.height);
  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}
