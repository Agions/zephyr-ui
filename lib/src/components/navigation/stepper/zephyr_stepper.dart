/// ZephyrUI 步骤指示器组件
/// 
/// 提供专业的步骤流程展示组件，支持多种样式和交互

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 步骤指示器类型
enum ZephyrStepperType {
  horizontal,
  vertical,
  wizard,
}

/// 步骤状态
enum ZephyrStepState {
  notReached,
  current,
  completed,
  error,
}

/// 步骤模型
class ZephyrStep {
  final String id;
  final String title;
  final String? subtitle;
  final Widget? content;
  final Widget? icon;
  final bool isOptional;
  final bool isActive;
  final ZephyrStepState state;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ZephyrStep({
    required this.id,
    required this.title,
    this.subtitle,
    this.content,
    this.icon,
    this.isOptional = false,
    this.isActive = false,
    this.state = ZephyrStepState.notReached,
    this.onTap,
    this.trailing,
  });
}

/// 步骤指示器组件
class ZephyrStepper extends StatefulWidget {
  final List<ZephyrStep> steps;
  final ZephyrStepperType type;
  final int currentStep;
  final ValueChanged<int>? onStepTapped;
  final VoidCallback? onStepContinue;
  final VoidCallback? onStepCancel;
  final bool showControls;
  final bool showStepNumbers;
  final bool showStepTitles;
  final EdgeInsetsGeometry padding;
  final ZephyrStepperTheme? theme;

  const ZephyrStepper({
    Key? key,
    required this.steps,
    this.type = ZephyrStepperType.horizontal,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.showControls = true,
    this.showStepNumbers = true,
    this.showStepTitles = true,
    this.padding = const EdgeInsets.all(16.0),
    this.theme,
  }) : super(key: key);

  @override
  State<ZephyrStepper> createState() => _ZephyrStepperState();
}

class _ZephyrStepperState extends State<ZephyrStepper> {
  late int _currentStep;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.currentStep;
  }

  @override
  void didUpdateWidget(ZephyrStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentStep = widget.currentStep;
  }

  void _handleStepTapped(int index) {
    if (widget.onStepTapped != null) {
      widget.onStepTapped!(index);
    } else {
      setState(() {
        _currentStep = index;
      });
    }
  }

  void _handleContinue() {
    if (widget.onStepContinue != null) {
      widget.onStepContinue!();
    } else if (_currentStep < widget.steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _handleCancel() {
    if (widget.onStepCancel != null) {
      widget.onStepCancel!();
    } else if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrStepperTheme.resolve(context, widget.theme);
    
    return ZephyrPerformanceWidget(
      widgetName: 'ZephyrStepper',
      child: Container(
        padding: widget.padding,
        child: Column(
          children: [
            _buildStepperHeader(effectiveTheme),
            if (widget.type == ZephyrStepperType.wizard) ...[
              const SizedBox(height: 24),
              _buildStepContent(),
            ],
            if (widget.showControls) ...[
              const SizedBox(height: 24),
              _buildControls(effectiveTheme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStepperHeader(ZephyrStepperTheme effectiveTheme) {
    switch (widget.type) {
      case ZephyrStepperType.horizontal:
        return _buildHorizontalStepper(effectiveTheme);
      case ZephyrStepperType.vertical:
        return _buildVerticalStepper(effectiveTheme);
      case ZephyrStepperType.wizard:
        return _buildWizardStepper(effectiveTheme);
    }
  }

  Widget _buildHorizontalStepper(ZephyrStepperTheme effectiveTheme) {
    return Row(
      children: List.generate(widget.steps.length, (index) {
        final step = widget.steps[index];
        final isLast = index == widget.steps.length - 1;
        final isCurrent = index == _currentStep;
        final isCompleted = index < _currentStep;
        final isError = step.state == ZephyrStepState.error;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: _buildStepIndicator(
                  step,
                  index,
                  effectiveTheme,
                  isCurrent: isCurrent,
                  isCompleted: isCompleted,
                  isError: isError,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isCompleted 
                        ? effectiveTheme.completedColor 
                        : effectiveTheme.inactiveColor,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildVerticalStepper(ZephyrStepperTheme effectiveTheme) {
    return Column(
      children: List.generate(widget.steps.length, (index) {
        final step = widget.steps[index];
        final isLast = index == widget.steps.length - 1;
        final isCurrent = index == _currentStep;
        final isCompleted = index < _currentStep;
        final isError = step.state == ZephyrStepState.error;

        return Column(
          children: [
            InkWell(
              onTap: step.onTap ?? (() => _handleStepTapped(index)),
              borderRadius: BorderRadius.circular(effectiveTheme.borderRadius),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStepIndicator(
                    step,
                    index,
                    effectiveTheme,
                    isCurrent: isCurrent,
                    isCompleted: isCompleted,
                    isError: isError,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStepInfo(step, effectiveTheme),
                  ),
                ],
              ),
            ),
            if (!isLast)
              Container(
                margin: const EdgeInsets.only(left: 12),
                width: 2,
                height: 24,
                color: isCompleted 
                    ? effectiveTheme.completedColor 
                    : effectiveTheme.inactiveColor,
              ),
            if (!isLast) const SizedBox(height: 16),
          ],
        );
      }),
    );
  }

  Widget _buildWizardStepper(ZephyrStepperTheme effectiveTheme) {
    return Row(
      children: List.generate(widget.steps.length, (index) {
        final step = widget.steps[index];
        final isCurrent = index == _currentStep;
        final isCompleted = index < _currentStep;
        final isError = step.state == ZephyrStepState.error;

        return Expanded(
          child: Column(
            children: [
              InkWell(
                onTap: step.onTap ?? (() => _handleStepTapped(index)),
                borderRadius: BorderRadius.circular(effectiveTheme.borderRadius),
                child: _buildStepIndicator(
                  step,
                  index,
                  effectiveTheme,
                  isCurrent: isCurrent,
                  isCompleted: isCompleted,
                  isError: isError,
                ),
              ),
              if (widget.showStepTitles && step.title.isNotEmpty) ...[
                const SizedBox(height: 8),
                ZephyrText.caption(
                  text: step.title,
                  color: isCurrent 
                      ? effectiveTheme.activeTextColor 
                      : effectiveTheme.textColor,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStepIndicator(
    ZephyrStep step,
    int index,
    ZephyrStepperTheme effectiveTheme, {
    bool isCurrent = false,
    bool isCompleted = false,
    bool isError = false,
  }) {
    final size = effectiveTheme.stepSize;
    final color = isError
        ? effectiveTheme.errorColor
        : isCompleted
            ? effectiveTheme.completedColor
            : isCurrent
                ? effectiveTheme.activeColor
                : effectiveTheme.inactiveColor;

    Widget child;
    if (step.icon != null) {
      child = IconTheme(
        data: IconThemeData(
          color: Colors.white,
          size: size * 0.6,
        ),
        child: step.icon!,
      );
    } else if (widget.showStepNumbers) {
      child = ZephyrText.body(
        text: '${index + 1}',
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else {
      child = const SizedBox.shrink();
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: effectiveTheme.borderColor,
          width: effectiveTheme.borderWidth,
        ),
      ),
      child: Center(child: child),
    );
  }

  Widget _buildStepInfo(ZephyrStep step, ZephyrStepperTheme effectiveTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ZephyrText.subtitle(
                text: step.title,
                color: step.isActive 
                    ? effectiveTheme.activeTextColor 
                    : effectiveTheme.textColor,
              ),
            ),
            if (step.isOptional)
              ZephyrText.caption(
                text: '(可选)',
                color: effectiveTheme.subtitleColor,
              ),
            if (step.trailing != null) step.trailing!,
          ],
        ),
        if (step.subtitle != null) ...[
          const SizedBox(height: 4),
          ZephyrText.body(
            text: step.subtitle!,
            color: effectiveTheme.subtitleColor,
          ),
        ],
      ],
    );
  }

  Widget _buildStepContent() {
    if (_currentStep >= 0 && _currentStep < widget.steps.length) {
      final step = widget.steps[_currentStep];
      return step.content ?? const SizedBox.shrink();
    }
    return const SizedBox.shrink();
  }

  Widget _buildControls(ZephyrStepperTheme effectiveTheme) {
    final isFirstStep = _currentStep == 0;
    final isLastStep = _currentStep == widget.steps.length - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isFirstStep)
          ZephyrButton.outline(
            text: '上一步',
            onPressed: _handleCancel,
            icon: const Icon(Icons.arrow_back),
          ),
        const Spacer(),
        if (!isLastStep)
          ZephyrButton.primary(
            text: '下一步',
            onPressed: _handleContinue,
            icon: const Icon(Icons.arrow_forward),
          )
        else
          ZephyrButton.primary(
            text: '完成',
            onPressed: _handleContinue,
            icon: const Icon(Icons.check),
          ),
      ],
    );
  }
}

/// 步骤指示器主题
class ZephyrStepperTheme extends ThemeExtension<ZephyrStepperTheme> {
  final Color activeColor;
  final Color completedColor;
  final Color inactiveColor;
  final Color errorColor;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final Color activeTextColor;
  final Color subtitleColor;
  final double stepSize;
  final double borderRadius;
  final Duration animationDuration;

  const ZephyrStepperTheme({
    required this.activeColor,
    required this.completedColor,
    required this.inactiveColor,
    required this.errorColor,
    required this.borderColor,
    required this.borderWidth,
    required this.textColor,
    required this.activeTextColor,
    required this.subtitleColor,
    required this.stepSize,
    required this.borderRadius,
    required this.animationDuration,
  });

  @override
  ZephyrStepperTheme copyWith({
    Color? activeColor,
    Color? completedColor,
    Color? inactiveColor,
    Color? errorColor,
    Color? borderColor,
    double? borderWidth,
    Color? textColor,
    Color? activeTextColor,
    Color? subtitleColor,
    double? stepSize,
    double? borderRadius,
    Duration? animationDuration,
  }) {
    return ZephyrStepperTheme(
      activeColor: activeColor ?? this.activeColor,
      completedColor: completedColor ?? this.completedColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      errorColor: errorColor ?? this.errorColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      textColor: textColor ?? this.textColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      stepSize: stepSize ?? this.stepSize,
      borderRadius: borderRadius ?? this.borderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  ZephyrStepperTheme lerp(ThemeExtension<ZephyrStepperTheme>? other, double t) {
    if (other is! ZephyrStepperTheme) {
      return this;
    }
    return ZephyrStepperTheme(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      completedColor: Color.lerp(completedColor, other.completedColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderWidth: ui.lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      activeTextColor: Color.lerp(activeTextColor, other.activeTextColor, t)!,
      subtitleColor: Color.lerp(subtitleColor, other.subtitleColor, t)!,
      stepSize: ui.lerpDouble(stepSize, other.stepSize, t) ?? stepSize,
      borderRadius: ui.lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      animationDuration: ZephyrRatingTheme.lerpDuration(animationDuration, other.animationDuration, t),
    );
  }

  static ZephyrStepperTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrStepperTheme>();
    return theme ?? _createDefaultTheme(ZephyrThemeData.of(context));
  }

  static ZephyrStepperTheme resolve(
    BuildContext context,
    ZephyrStepperTheme? theme,
  ) {
    return theme ?? of(context);
  }

  static ZephyrStepperTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    return ZephyrStepperTheme(
      activeColor: Colors.blue,
      completedColor: Colors.green,
      inactiveColor: Colors.grey.shade300,
      errorColor: Colors.red,
      borderColor: Colors.white,
      borderWidth: 2.0,
      textColor: Colors.grey.shade700,
      activeTextColor: Colors.blue.shade800,
      subtitleColor: Colors.grey.shade600,
      stepSize: 32.0,
      borderRadius: 8.0,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}