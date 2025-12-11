/// VelocityUI 统计数值组件
library velocity_statistic;

import 'package:flutter/material.dart';
import 'statistic_style.dart';

export 'statistic_style.dart';

/// VelocityUI 统计数值
class VelocityStatistic extends StatelessWidget {
  const VelocityStatistic({
    super.key,
    required this.value,
    this.title,
    this.prefix,
    this.suffix,
    this.precision = 0,
    this.trend,
    this.trendValue,
    this.style,
  });

  final num value;
  final String? title;
  final Widget? prefix;
  final String? suffix;
  final int precision;
  final VelocityStatisticTrend? trend;
  final String? trendValue;
  final VelocityStatisticStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityStatisticStyle();
    final formattedValue =
        precision > 0 ? value.toStringAsFixed(precision) : value.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Padding(
              padding: EdgeInsets.only(bottom: effectiveStyle.titleSpacing),
              child: Text(title!, style: effectiveStyle.titleStyle)),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            if (prefix != null)
              Padding(
                  padding: EdgeInsets.only(right: effectiveStyle.prefixSpacing),
                  child: prefix),
            Text(formattedValue, style: effectiveStyle.valueStyle),
            if (suffix != null)
              Padding(
                  padding: EdgeInsets.only(left: effectiveStyle.suffixSpacing),
                  child: Text(suffix!, style: effectiveStyle.suffixStyle)),
          ],
        ),
        if (trend != null && trendValue != null)
          Padding(
            padding: EdgeInsets.only(top: effectiveStyle.trendSpacing),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  trend == VelocityStatisticTrend.up
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  size: effectiveStyle.trendIconSize,
                  color: trend == VelocityStatisticTrend.up
                      ? effectiveStyle.upColor
                      : effectiveStyle.downColor,
                ),
                SizedBox(width: 4),
                Text(trendValue!,
                    style: effectiveStyle.trendStyle.copyWith(
                        color: trend == VelocityStatisticTrend.up
                            ? effectiveStyle.upColor
                            : effectiveStyle.downColor)),
              ],
            ),
          ),
      ],
    );
  }
}

enum VelocityStatisticTrend { up, down }

/// VelocityUI 倒计时
class VelocityCountdown extends StatefulWidget {
  const VelocityCountdown({
    super.key,
    required this.endTime,
    this.onFinish,
    this.format = 'HH:mm:ss',
    this.style,
  });

  final DateTime endTime;
  final VoidCallback? onFinish;
  final String format;
  final VelocityCountdownStyle? style;

  @override
  State<VelocityCountdown> createState() => _VelocityCountdownState();
}

class _VelocityCountdownState extends State<VelocityCountdown> {
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _tick();
  }

  void _updateRemaining() =>
      _remaining = widget.endTime.difference(DateTime.now());

  void _tick() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(_updateRemaining);
      if (_remaining.isNegative) {
        widget.onFinish?.call();
      } else {
        _tick();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocityCountdownStyle();
    if (_remaining.isNegative)
      return Text('00:00:00', style: effectiveStyle.textStyle);

    final hours = _remaining.inHours.toString().padLeft(2, '0');
    final minutes = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');
    final days = _remaining.inDays;

    String text;
    if (widget.format.contains('dd')) {
      text = '$days天 $hours:$minutes:$seconds';
    } else {
      text = '$hours:$minutes:$seconds';
    }

    return Text(text, style: effectiveStyle.textStyle);
  }
}
