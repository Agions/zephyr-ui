/// VelocityUI 滑块组件
library velocity_slider;

import 'package:flutter/material.dart';
import 'slider_style.dart';

export 'slider_style.dart';

/// VelocityUI 滑块
class VelocitySlider extends StatelessWidget {
  const VelocitySlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
    this.divisions,
    this.label,
    this.showLabel = false,
    this.disabled = false,
    this.style,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool showLabel;
  final bool disabled;
  final VelocitySliderStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocitySliderStyle();
    
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: disabled ? effectiveStyle.disabledActiveColor : effectiveStyle.activeColor,
        inactiveTrackColor: disabled ? effectiveStyle.disabledInactiveColor : effectiveStyle.inactiveColor,
        thumbColor: disabled ? effectiveStyle.disabledThumbColor : effectiveStyle.thumbColor,
        overlayColor: effectiveStyle.overlayColor,
        trackHeight: effectiveStyle.trackHeight,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: effectiveStyle.thumbRadius),
        overlayShape: RoundSliderOverlayShape(overlayRadius: effectiveStyle.overlayRadius),
        valueIndicatorColor: effectiveStyle.activeColor,
        valueIndicatorTextStyle: effectiveStyle.labelStyle,
        showValueIndicator: showLabel ? ShowValueIndicator.always : ShowValueIndicator.never,
      ),
      child: Slider(
        value: value,
        onChanged: disabled ? null : onChanged,
        min: min,
        max: max,
        divisions: divisions,
        label: label ?? value.toStringAsFixed(0),
      ),
    );
  }
}

/// VelocityUI 范围滑块
class VelocityRangeSlider extends StatelessWidget {
  const VelocityRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
    this.divisions,
    this.labels,
    this.showLabels = false,
    this.disabled = false,
    this.style,
  });

  final RangeValues values;
  final ValueChanged<RangeValues>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final RangeLabels? labels;
  final bool showLabels;
  final bool disabled;
  final VelocitySliderStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocitySliderStyle();
    
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: disabled ? effectiveStyle.disabledActiveColor : effectiveStyle.activeColor,
        inactiveTrackColor: disabled ? effectiveStyle.disabledInactiveColor : effectiveStyle.inactiveColor,
        thumbColor: disabled ? effectiveStyle.disabledThumbColor : effectiveStyle.thumbColor,
        overlayColor: effectiveStyle.overlayColor,
        trackHeight: effectiveStyle.trackHeight,
        rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: effectiveStyle.thumbRadius),
        overlayShape: RoundSliderOverlayShape(overlayRadius: effectiveStyle.overlayRadius),
        valueIndicatorColor: effectiveStyle.activeColor,
        valueIndicatorTextStyle: effectiveStyle.labelStyle,
        showValueIndicator: showLabels ? ShowValueIndicator.always : ShowValueIndicator.never,
      ),
      child: RangeSlider(
        values: values,
        onChanged: disabled ? null : onChanged,
        min: min,
        max: max,
        divisions: divisions,
        labels: labels ?? RangeLabels(values.start.toStringAsFixed(0), values.end.toStringAsFixed(0)),
      ),
    );
  }
}
