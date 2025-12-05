/// VelocityUI 进度条组件
library velocity_progress;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';
import 'progress_style.dart';

export 'progress_style.dart';

/// 进度条类型
enum VelocityProgressType { linear, circular }

/// VelocityUI 进度条
class VelocityProgress extends StatelessWidget {
  const VelocityProgress({
    super.key,
    required this.value,
    this.type = VelocityProgressType.linear,
    this.showLabel = false,
    this.label,
    this.style,
  });

  final double value;
  final VelocityProgressType type;
  final bool showLabel;
  final String? label;
  final VelocityProgressStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityProgressStyle();
    final clampedValue = value.clamp(0.0, 1.0);
    
    if (type == VelocityProgressType.circular) {
      return SizedBox(
        width: effectiveStyle.circularSize,
        height: effectiveStyle.circularSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: clampedValue,
              strokeWidth: effectiveStyle.strokeWidth,
              backgroundColor: effectiveStyle.backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveStyle.color),
            ),
            if (showLabel)
              Text(label ?? '${(clampedValue * 100).toInt()}%', style: effectiveStyle.labelStyle),
          ],
        ),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null) Text(label!, style: effectiveStyle.labelStyle),
              Text('${(clampedValue * 100).toInt()}%', style: effectiveStyle.labelStyle),
            ],
          ),
          SizedBox(height: effectiveStyle.labelSpacing),
        ],
        Container(
          height: effectiveStyle.height,
          decoration: BoxDecoration(
            color: effectiveStyle.backgroundColor,
            borderRadius: effectiveStyle.borderRadius,
          ),
          child: Stack(
            children: [
              AnimatedFractionallySizedBox(
                duration: effectiveStyle.animationDuration,
                widthFactor: clampedValue,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: effectiveStyle.gradient,
                    color: effectiveStyle.gradient == null ? effectiveStyle.color : null,
                    borderRadius: effectiveStyle.borderRadius,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// VelocityUI 步骤进度
class VelocityStepProgress extends StatelessWidget {
  const VelocityStepProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.labels,
    this.style,
  });

  final int currentStep;
  final int totalSteps;
  final List<String>? labels;
  final VelocityStepProgressStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityStepProgressStyle();
    
    return Row(
      children: [
        for (int i = 0; i < totalSteps; i++) ...[
          Expanded(
            child: Column(
              children: [
                Container(
                  width: effectiveStyle.stepSize,
                  height: effectiveStyle.stepSize,
                  decoration: BoxDecoration(
                    color: i <= currentStep ? effectiveStyle.activeColor : effectiveStyle.inactiveColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: i <= currentStep ? effectiveStyle.activeColor : effectiveStyle.borderColor, width: 2),
                  ),
                  child: Center(
                    child: i < currentStep
                        ? Icon(Icons.check, size: effectiveStyle.stepSize * 0.6, color: VelocityColors.white)
                        : Text('${i + 1}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: i <= currentStep ? VelocityColors.white : effectiveStyle.borderColor)),
                  ),
                ),
                if (labels != null && i < labels!.length) ...[
                  const SizedBox(height: 8),
                  Text(labels![i], style: effectiveStyle.labelStyle.copyWith(color: i <= currentStep ? effectiveStyle.activeColor : effectiveStyle.borderColor), textAlign: TextAlign.center),
                ],
              ],
            ),
          ),
          if (i < totalSteps - 1)
            Expanded(
              child: Container(
                height: 2,
                color: i < currentStep ? effectiveStyle.activeColor : effectiveStyle.inactiveColor,
              ),
            ),
        ],
      ],
    );
  }
}
