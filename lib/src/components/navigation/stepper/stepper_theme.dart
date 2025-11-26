import 'package:flutter/material.dart';

/// 定义ZephyrStepper的视觉属性
///
/// 此主题用于ZephyrStepper组件确定视觉样式，包括指示器颜色、大小、字体样式等。
class ZephyrStepperTheme {
  const ZephyrStepperTheme({
    required this.completedColor,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.disabledColor,
    this.errorColor,
    this.completeColor,
    this.connectorColor,
    this.connectorThickness,
    this.stepHeight,
    this.stepWidth,
    this.stepMargin,
    this.stepPadding,
    this.iconSize,
    this.indicatorSize,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.activeTitleTextStyle,
    this.activeSubtitleTextStyle,
    this.disabledTitleTextStyle,
    this.disabledSubtitleTextStyle,
    this.errorTitleTextStyle,
    this.errorSubtitleTextStyle,
    this.animationDuration,
    this.animationCurve,
  });

  /// 背景颜色
  final Color? backgroundColor;

  /// 激活状态颜色
  final Color? activeColor;

  /// 未激活状态颜色
  final Color? inactiveColor;

  /// 禁用状态颜色
  final Color? disabledColor;

  /// 错误状态颜色
  final Color? errorColor;

  /// 完成状态颜色
  final Color? completeColor;

  /// 已完成状态颜色
  final Color completedColor;

  /// 连接线颜色
  final Color? connectorColor;

  /// 连接线厚度
  final double? connectorThickness;

  /// 步骤高度
  final double? stepHeight;

  /// 步骤宽度
  final double? stepWidth;

  /// 步骤外边距
  final EdgeInsetsGeometry? stepMargin;

  /// 步骤内边距
  final EdgeInsetsGeometry? stepPadding;

  /// 图标大小
  final double? iconSize;

  /// 指示器大小
  final double? indicatorSize;

  /// 标题文本样式
  final TextStyle? titleTextStyle;

  /// 副标题文本样式
  final TextStyle? subtitleTextStyle;

  /// 激活状态标题文本样式
  final TextStyle? activeTitleTextStyle;

  /// 激活状态副标题文本样式
  final TextStyle? activeSubtitleTextStyle;

  /// 禁用状态标题文本样式
  final TextStyle? disabledTitleTextStyle;

  /// 禁用状态副标题文本样式
  final TextStyle? disabledSubtitleTextStyle;

  /// 错误状态标题文本样式
  final TextStyle? errorTitleTextStyle;

  /// 错误状态副标题文本样式
  final TextStyle? errorSubtitleTextStyle;

  /// 动画持续时间
  final Duration? animationDuration;

  /// 动画曲线
  final Curve? animationCurve;

  /// 创建当前主题的副本，并替换指定字段
  ZephyrStepperTheme copyWith({
    Color? backgroundColor,
    Color? activeColor,
    Color? inactiveColor,
    Color? disabledColor,
    Color? errorColor,
    Color? completeColor,
    Color? connectorColor,
    double? connectorThickness,
    double? stepHeight,
    double? stepWidth,
    EdgeInsetsGeometry? stepMargin,
    EdgeInsetsGeometry? stepPadding,
    double? iconSize,
    double? indicatorSize,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    TextStyle? activeTitleTextStyle,
    TextStyle? activeSubtitleTextStyle,
    TextStyle? disabledTitleTextStyle,
    TextStyle? disabledSubtitleTextStyle,
    TextStyle? errorTitleTextStyle,
    TextStyle? errorSubtitleTextStyle,
    Duration? animationDuration,
    Curve? animationCurve,
    Color? completedColor,
  }) {
    return ZephyrStepperTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      disabledColor: disabledColor ?? this.disabledColor,
      errorColor: errorColor ?? this.errorColor,
      completeColor: completeColor ?? this.completeColor,
      connectorColor: connectorColor ?? this.connectorColor,
      connectorThickness: connectorThickness ?? this.connectorThickness,
      stepHeight: stepHeight ?? this.stepHeight,
      stepWidth: stepWidth ?? this.stepWidth,
      stepMargin: stepMargin ?? this.stepMargin,
      stepPadding: stepPadding ?? this.stepPadding,
      iconSize: iconSize ?? this.iconSize,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      activeTitleTextStyle: activeTitleTextStyle ?? this.activeTitleTextStyle,
      activeSubtitleTextStyle:
          activeSubtitleTextStyle ?? this.activeSubtitleTextStyle,
      disabledTitleTextStyle:
          disabledTitleTextStyle ?? this.disabledTitleTextStyle,
      disabledSubtitleTextStyle:
          disabledSubtitleTextStyle ?? this.disabledSubtitleTextStyle,
      errorTitleTextStyle: errorTitleTextStyle ?? this.errorTitleTextStyle,
      errorSubtitleTextStyle:
          errorSubtitleTextStyle ?? this.errorSubtitleTextStyle,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      completedColor: completedColor ?? this.completedColor,
    );
  }

  /// 从父主题和当前主题解析出最终主题
  ///
  /// 如果当前主题的属性为null，则使用父主题的对应属性
  static ZephyrStepperTheme resolve(
    BuildContext context,
    ZephyrStepperTheme? theme,
  ) {
    final defaultTheme = _defaultTheme(context);

    if (theme == null) {
      return defaultTheme;
    }

    return ZephyrStepperTheme(
      backgroundColor: theme.backgroundColor ?? defaultTheme.backgroundColor,
      activeColor: theme.activeColor ?? defaultTheme.activeColor,
      inactiveColor: theme.inactiveColor ?? defaultTheme.inactiveColor,
      disabledColor: theme.disabledColor ?? defaultTheme.disabledColor,
      errorColor: theme.errorColor ?? defaultTheme.errorColor,
      completeColor: theme.completeColor ?? defaultTheme.completeColor,
      connectorColor: theme.connectorColor ?? defaultTheme.connectorColor,
      connectorThickness:
          theme.connectorThickness ?? defaultTheme.connectorThickness,
      stepHeight: theme.stepHeight ?? defaultTheme.stepHeight,
      stepWidth: theme.stepWidth ?? defaultTheme.stepWidth,
      stepMargin: theme.stepMargin ?? defaultTheme.stepMargin,
      stepPadding: theme.stepPadding ?? defaultTheme.stepPadding,
      iconSize: theme.iconSize ?? defaultTheme.iconSize,
      indicatorSize: theme.indicatorSize ?? defaultTheme.indicatorSize,
      titleTextStyle: theme.titleTextStyle ?? defaultTheme.titleTextStyle,
      subtitleTextStyle:
          theme.subtitleTextStyle ?? defaultTheme.subtitleTextStyle,
      activeTitleTextStyle:
          theme.activeTitleTextStyle ?? defaultTheme.activeTitleTextStyle,
      activeSubtitleTextStyle:
          theme.activeSubtitleTextStyle ?? defaultTheme.activeSubtitleTextStyle,
      disabledTitleTextStyle:
          theme.disabledTitleTextStyle ?? defaultTheme.disabledTitleTextStyle,
      disabledSubtitleTextStyle: theme.disabledSubtitleTextStyle ??
          defaultTheme.disabledSubtitleTextStyle,
      errorTitleTextStyle:
          theme.errorTitleTextStyle ?? defaultTheme.errorTitleTextStyle,
      errorSubtitleTextStyle:
          theme.errorSubtitleTextStyle ?? defaultTheme.errorSubtitleTextStyle,
      animationDuration:
          theme.animationDuration ?? defaultTheme.animationDuration,
      animationCurve: theme.animationCurve ?? defaultTheme.animationCurve,
      completedColor: theme.completedColor,
    );
  }

  /// 创建默认主题
  static ZephyrStepperTheme _defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return ZephyrStepperTheme(
      backgroundColor: Colors.transparent,
      activeColor: colorScheme.primary,
      inactiveColor: isDark ? Colors.white60 : Colors.black45,
      disabledColor: isDark ? Colors.white38 : Colors.black26,
      errorColor: colorScheme.error,
      completeColor: isDark ? Colors.green[300] : Colors.green[600],
      connectorColor: isDark ? Colors.white30 : Colors.black12,
      connectorThickness: 1.0,
      stepHeight: 72.0,
      stepWidth: double.infinity,
      stepMargin: const EdgeInsets.symmetric(vertical: 4.0),
      stepPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      iconSize: 20.0,
      indicatorSize: 32.0,
      titleTextStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 12.0,
        color: isDark ? Colors.white60 : Colors.black54,
      ),
      activeTitleTextStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: colorScheme.primary,
      ),
      activeSubtitleTextStyle: TextStyle(
        fontSize: 12.0,
        color: colorScheme.primary.withValues(alpha: 0.8),
      ),
      disabledTitleTextStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white38 : Colors.black38,
      ),
      disabledSubtitleTextStyle: TextStyle(
        fontSize: 12.0,
        color: isDark ? Colors.white30 : Colors.black38,
      ),
      errorTitleTextStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: colorScheme.error,
      ),
      errorSubtitleTextStyle: TextStyle(
        fontSize: 12.0,
        color: colorScheme.error.withValues(alpha: 0.8),
      ),
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
      completedColor: isDark ? Colors.green[300]! : Colors.green[600]!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrStepperTheme &&
        other.backgroundColor == backgroundColor &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor &&
        other.disabledColor == disabledColor &&
        other.errorColor == errorColor &&
        other.completeColor == completeColor &&
        other.connectorColor == connectorColor &&
        other.connectorThickness == connectorThickness &&
        other.stepHeight == stepHeight &&
        other.stepWidth == stepWidth &&
        other.stepMargin == stepMargin &&
        other.stepPadding == stepPadding &&
        other.iconSize == iconSize &&
        other.indicatorSize == indicatorSize &&
        other.titleTextStyle == titleTextStyle &&
        other.subtitleTextStyle == subtitleTextStyle &&
        other.activeTitleTextStyle == activeTitleTextStyle &&
        other.activeSubtitleTextStyle == activeSubtitleTextStyle &&
        other.disabledTitleTextStyle == disabledTitleTextStyle &&
        other.disabledSubtitleTextStyle == disabledSubtitleTextStyle &&
        other.errorTitleTextStyle == errorTitleTextStyle &&
        other.errorSubtitleTextStyle == errorSubtitleTextStyle &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve &&
        other.completedColor == completedColor;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        activeColor,
        inactiveColor,
        disabledColor,
        Object.hash(
          errorColor,
          completeColor,
          connectorColor,
          connectorThickness,
          stepHeight,
          stepWidth,
          stepMargin,
          stepPadding,
          iconSize,
          indicatorSize,
        ),
        Object.hash(
          titleTextStyle,
          subtitleTextStyle,
          activeTitleTextStyle,
          activeSubtitleTextStyle,
          disabledTitleTextStyle,
          disabledSubtitleTextStyle,
          errorTitleTextStyle,
          errorSubtitleTextStyle,
          animationDuration,
          animationCurve,
          completedColor,
        ),
      );
}
