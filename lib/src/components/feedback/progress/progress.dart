/// ZephyrUI 进度条组件
///
/// 提供各种样式的进度指示器，支持线性和圆形进度条。
library progress;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 线性进度条
///
/// 显示任务完成进度的线性指示器。
///
/// 示例用法:
/// ```dart
/// ZephyrLinearProgress(
///   value: 0.7,
///   label: '70%',
/// )
/// ```
class ZephyrLinearProgress extends StatelessWidget {
  /// 创建线性进度条
  const ZephyrLinearProgress({
    super.key,
    this.value,
    this.label,
    this.showLabel = false,
    this.variant = ZephyrVariant.primary,
    this.size = ZephyrSize.md,
    this.backgroundColor,
    this.valueColor,
    this.borderRadius,
    this.minHeight,
    this.semanticsLabel,
    this.semanticsValue,
    this.theme,
  });

  /// 进度值 (0.0 到 1.0)，null 表示不确定进度
  final double? value;

  /// 标签文本
  final String? label;

  /// 是否显示标签
  final bool showLabel;

  /// 变体
  final ZephyrVariant variant;

  /// 尺寸
  final ZephyrSize size;

  /// 背景色
  final Color? backgroundColor;

  /// 进度条颜色
  final Color? valueColor;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 最小高度
  final double? minHeight;

  /// 语义标签
  final String? semanticsLabel;

  /// 语义值
  final String? semanticsValue;

  /// 主题
  final ZephyrProgressTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrProgressTheme.of(context, variant);
    final effectiveHeight = minHeight ?? _getHeight();
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(effectiveHeight / 2);

    Widget progressBar = Container(
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? effectiveTheme.backgroundColor,
        borderRadius: effectiveBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(
            valueColor ?? effectiveTheme.valueColor,
          ),
          minHeight: effectiveHeight,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        ),
      ),
    );

    if (showLabel && label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: effectiveTheme.labelStyle,
              ),
              if (value != null)
                Text(
                  '${(value! * 100).round()}%',
                  style: effectiveTheme.labelStyle,
                ),
            ],
          ),
          const SizedBox(height: ZephyrSpacing.xs),
          progressBar,
        ],
      );
    }

    return progressBar;
  }

  /// 获取进度条高度
  double _getHeight() {
    switch (size) {
      case ZephyrSize.xs:
        return 2;
      case ZephyrSize.sm:
        return 4;
      case ZephyrSize.md:
        return 6;
      case ZephyrSize.lg:
        return 8;
      case ZephyrSize.xl:
        return 12;
    }
  }
}

/// ZephyrUI 圆形进度条
///
/// 显示任务完成进度的圆形指示器。
class ZephyrCircularProgress extends StatelessWidget {
  /// 创建圆形进度条
  const ZephyrCircularProgress({
    super.key,
    this.value,
    this.size = ZephyrSize.md,
    this.variant = ZephyrVariant.primary,
    this.strokeWidth,
    this.backgroundColor,
    this.valueColor,
    this.strokeCap = StrokeCap.round,
    this.semanticsLabel,
    this.semanticsValue,
    this.child,
    this.theme,
  });

  /// 进度值 (0.0 到 1.0)，null 表示不确定进度
  final double? value;

  /// 尺寸
  final ZephyrSize size;

  /// 变体
  final ZephyrVariant variant;

  /// 线条宽度
  final double? strokeWidth;

  /// 背景色
  final Color? backgroundColor;

  /// 进度条颜色
  final Color? valueColor;

  /// 线条端点样式
  final StrokeCap strokeCap;

  /// 语义标签
  final String? semanticsLabel;

  /// 语义值
  final String? semanticsValue;

  /// 中心子组件
  final Widget? child;

  /// 主题
  final ZephyrProgressTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrProgressTheme.of(context, variant);
    final effectiveSize = _getSize();
    final effectiveStrokeWidth = strokeWidth ?? _getStrokeWidth();

    return SizedBox(
      width: effectiveSize,
      height: effectiveSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: effectiveStrokeWidth,
            backgroundColor: backgroundColor ?? effectiveTheme.backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              valueColor ?? effectiveTheme.valueColor,
            ),
            strokeCap: strokeCap,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue,
          ),
          if (child != null) child!,
        ],
      ),
    );
  }

  /// 获取圆形进度条尺寸
  double _getSize() {
    switch (size) {
      case ZephyrSize.xs:
        return 16;
      case ZephyrSize.sm:
        return 24;
      case ZephyrSize.md:
        return 32;
      case ZephyrSize.lg:
        return 48;
      case ZephyrSize.xl:
        return 64;
    }
  }

  /// 获取线条宽度
  double _getStrokeWidth() {
    switch (size) {
      case ZephyrSize.xs:
        return 2;
      case ZephyrSize.sm:
        return 2;
      case ZephyrSize.md:
        return 3;
      case ZephyrSize.lg:
        return 4;
      case ZephyrSize.xl:
        return 5;
    }
  }
}

/// ZephyrUI 步骤进度条
///
/// 显示多步骤流程进度的组件。
class ZephyrStepProgress extends StatelessWidget {
  /// 创建步骤进度条
  const ZephyrStepProgress({
    required this.steps,
    required this.currentStep,
    super.key,
    this.variant = ZephyrVariant.primary,
    this.direction = Axis.horizontal,
    this.showLabels = true,
    this.spacing = ZephyrSpacing.md,
    this.theme,
  });

  /// 步骤列表
  final List<ZephyrProgressStep> steps;

  /// 当前步骤索引
  final int currentStep;

  /// 变体
  final ZephyrVariant variant;

  /// 方向
  final Axis direction;

  /// 是否显示标签
  final bool showLabels;

  /// 间距
  final double spacing;

  /// 主题
  final ZephyrProgressTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrProgressTheme.of(context, variant);

    if (direction == Axis.horizontal) {
      return _buildHorizontalSteps(context, effectiveTheme);
    } else {
      return _buildVerticalSteps(context, effectiveTheme);
    }
  }

  /// 构建水平步骤
  Widget _buildHorizontalSteps(
      BuildContext context, ZephyrProgressTheme theme) {
    return Row(
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          _buildStep(context, theme, i),
          if (i < steps.length - 1) _buildConnector(context, theme, i),
        ],
      ],
    );
  }

  /// 构建垂直步骤
  Widget _buildVerticalSteps(BuildContext context, ZephyrProgressTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          _buildStep(context, theme, i),
          if (i < steps.length - 1) _buildVerticalConnector(context, theme, i),
        ],
      ],
    );
  }

  /// 构建单个步骤
  Widget _buildStep(
      BuildContext context, ZephyrProgressTheme theme, int index) {
    final step = steps[index];
    final isCompleted = index < currentStep;
    final isCurrent = index == currentStep;
    final isActive = isCompleted || isCurrent;

    Color stepColor;
    if (isCompleted) {
      stepColor = theme.valueColor;
    } else if (isCurrent) {
      stepColor = theme.valueColor;
    } else {
      stepColor = theme.backgroundColor;
    }

    Widget stepWidget = Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: stepColor,
        border: Border.all(
          color: isActive ? theme.valueColor : theme.backgroundColor,
          width: 2,
        ),
      ),
      child: Center(
        child: isCompleted
            ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
            : Text(
                '${index + 1}',
                style: TextStyle(
                  color: isActive ? Colors.white : theme.labelStyle.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
      ),
    );

    if (!showLabels || step.label == null) {
      return stepWidget;
    }

    if (direction == Axis.horizontal) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          stepWidget,
          const SizedBox(height: ZephyrSpacing.xs),
          Text(
            step.label!,
            style: theme.labelStyle.copyWith(
              color: isActive
                  ? theme.valueColor
                  : theme.labelStyle.color?.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          stepWidget,
          SizedBox(width: spacing),
          Expanded(
            child: Text(
              step.label!,
              style: theme.labelStyle.copyWith(
                color: isActive
                    ? theme.valueColor
                    : theme.labelStyle.color?.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      );
    }
  }

  /// 构建连接线
  Widget _buildConnector(
      BuildContext context, ZephyrProgressTheme theme, int index) {
    final isCompleted = index < currentStep - 1;

    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: ZephyrSpacing.sm),
        color: isCompleted ? theme.valueColor : theme.backgroundColor,
      ),
    );
  }

  /// 构建垂直连接线
  Widget _buildVerticalConnector(
      BuildContext context, ZephyrProgressTheme theme, int index) {
    final isCompleted = index < currentStep - 1;

    return Container(
      width: 2,
      height: 40,
      margin: const EdgeInsets.only(
          left: 15, top: ZephyrSpacing.xs, bottom: ZephyrSpacing.xs),
      color: isCompleted ? theme.valueColor : theme.backgroundColor,
    );
  }
}

/// 进度步骤
class ZephyrProgressStep {
  /// 创建进度步骤
  const ZephyrProgressStep({
    this.label,
    this.description,
    this.icon,
  });

  /// 标签
  final String? label;

  /// 描述
  final String? description;

  /// 图标
  final Widget? icon;
}
