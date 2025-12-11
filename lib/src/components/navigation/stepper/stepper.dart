/// VelocityUI 步骤条组件
library velocity_stepper;

import 'package:flutter/material.dart';
import 'stepper_style.dart';

export 'stepper_style.dart';

/// 步骤方向
enum VelocityStepperDirection { horizontal, vertical }

/// 步骤状态
enum VelocityStepStatus { wait, process, finish, error }

/// VelocityUI 步骤条
class VelocityStepper extends StatelessWidget {
  const VelocityStepper({
    super.key,
    required this.steps,
    required this.currentStep,
    this.direction = VelocityStepperDirection.horizontal,
    this.onStepTap,
    this.style,
  });

  final List<VelocityStep> steps;
  final int currentStep;
  final VelocityStepperDirection direction;
  final ValueChanged<int>? onStepTap;
  final VelocityStepperStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityStepperStyle();

    if (direction == VelocityStepperDirection.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            _buildVerticalStep(i, effectiveStyle),
            if (i < steps.length - 1)
              _buildVerticalConnector(i, effectiveStyle),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Expanded(child: _buildHorizontalStep(i, effectiveStyle)),
          if (i < steps.length - 1)
            Expanded(child: _buildHorizontalConnector(i, effectiveStyle)),
        ],
      ],
    );
  }

  VelocityStepStatus _getStatus(int index) {
    if (steps[index].status != null) return steps[index].status!;
    if (index < currentStep) return VelocityStepStatus.finish;
    if (index == currentStep) return VelocityStepStatus.process;
    return VelocityStepStatus.wait;
  }

  Color _getStatusColor(VelocityStepStatus status, VelocityStepperStyle style) {
    switch (status) {
      case VelocityStepStatus.finish:
        return style.finishColor;
      case VelocityStepStatus.process:
        return style.processColor;
      case VelocityStepStatus.error:
        return style.errorColor;
      case VelocityStepStatus.wait:
        return style.waitColor;
    }
  }

  Widget _buildStepIcon(int index, VelocityStepperStyle style) {
    final status = _getStatus(index);
    final color = _getStatusColor(status, style);

    if (status == VelocityStepStatus.finish) {
      return Container(
        width: style.iconSize,
        height: style.iconSize,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child:
            Icon(Icons.check, size: style.iconSize * 0.6, color: Colors.white),
      );
    }
    if (status == VelocityStepStatus.error) {
      return Container(
        width: style.iconSize,
        height: style.iconSize,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child:
            Icon(Icons.close, size: style.iconSize * 0.6, color: Colors.white),
      );
    }
    return Container(
      width: style.iconSize,
      height: style.iconSize,
      decoration: BoxDecoration(
        color:
            status == VelocityStepStatus.process ? color : Colors.transparent,
        border: Border.all(color: color, width: 2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text('${index + 1}',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: status == VelocityStepStatus.process
                    ? Colors.white
                    : color)),
      ),
    );
  }

  Widget _buildHorizontalStep(int index, VelocityStepperStyle style) {
    final status = _getStatus(index);
    final color = _getStatusColor(status, style);

    return GestureDetector(
      onTap: onStepTap != null ? () => onStepTap!(index) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepIcon(index, style),
          SizedBox(height: style.labelSpacing),
          Text(steps[index].title,
              style: style.titleStyle.copyWith(
                  color: status == VelocityStepStatus.wait
                      ? style.waitColor
                      : color),
              textAlign: TextAlign.center),
          if (steps[index].subtitle != null)
            Text(steps[index].subtitle!,
                style: style.subtitleStyle, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildHorizontalConnector(int index, VelocityStepperStyle style) {
    final isActive = index < currentStep;
    return Container(
      height: style.connectorThickness,
      margin: EdgeInsets.only(bottom: style.labelSpacing + 20),
      color: isActive ? style.finishColor : style.waitColor,
    );
  }

  Widget _buildVerticalStep(int index, VelocityStepperStyle style) {
    final status = _getStatus(index);
    final color = _getStatusColor(status, style);

    return GestureDetector(
      onTap: onStepTap != null ? () => onStepTap!(index) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepIcon(index, style),
          SizedBox(width: style.labelSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(steps[index].title,
                    style: style.titleStyle.copyWith(
                        color: status == VelocityStepStatus.wait
                            ? style.waitColor
                            : color)),
                if (steps[index].subtitle != null)
                  Text(steps[index].subtitle!, style: style.subtitleStyle),
                if (steps[index].content != null)
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: steps[index].content!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalConnector(int index, VelocityStepperStyle style) {
    final isActive = index < currentStep;
    return Container(
      width: style.connectorThickness,
      height: 24,
      margin: EdgeInsets.only(
          left: style.iconSize / 2 - style.connectorThickness / 2),
      color: isActive ? style.finishColor : style.waitColor,
    );
  }
}

/// 步骤项
class VelocityStep {
  const VelocityStep(
      {required this.title, this.subtitle, this.content, this.status});
  final String title;
  final String? subtitle;
  final Widget? content;
  final VelocityStepStatus? status;
}
