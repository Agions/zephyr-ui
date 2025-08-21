/// ZephyrUI 开关组件
///
/// 提供各种样式的开关组件，支持自定义主题和动画。
library switch_widget;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:zephyr_ui/src/core/extensions/context_extensions.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 开关组件
///
/// 一个可定制的开关组件，支持多种样式和状态。
///
/// 示例用法:
/// ```dart
/// ZephyrSwitch(
///   value: isEnabled,
///   onChanged: (value) => setState(() => isEnabled = value),
/// )
/// ```
class ZephyrSwitch extends StatefulWidget {
  /// 创建一个开关组件
  const ZephyrSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size = ZephyrSize.md,
    this.variant = ZephyrVariant.primary,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.trackColor,
    this.focusColor,
    this.hoverColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.theme,
  }) : super(key: key);

  /// 开关状态
  final bool value;

  /// 状态变化回调
  final ValueChanged<bool>? onChanged;

  /// 尺寸
  final ZephyrSize size;

  /// 变体
  final ZephyrVariant variant;

  /// 激活状态颜色
  final Color? activeColor;

  /// 非激活状态颜色
  final Color? inactiveColor;

  /// 滑块颜色
  final Color? thumbColor;

  /// 轨道颜色
  final Color? trackColor;

  /// 焦点颜色
  final Color? focusColor;

  /// 悬停颜色
  final Color? hoverColor;

  /// 水波纹半径
  final double? splashRadius;

  /// Material 点击目标尺寸
  final MaterialTapTargetSize? materialTapTargetSize;

  /// 拖拽开始行为
  final DragStartBehavior dragStartBehavior;

  /// 鼠标光标
  final MouseCursor? mouseCursor;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 是否自动获取焦点
  final bool autofocus;

  /// 主题
  final ZephyrSwitchTheme? theme;

  @override
  State<ZephyrSwitch> createState() => _ZephyrSwitchState();
}

class _ZephyrSwitchState extends State<ZephyrSwitch>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: ZephyrAnimations.fast,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: ZephyrAnimations.easeInOut,
    );

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(ZephyrSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? ZephyrSwitchTheme.of(context, widget.variant);
    final isEnabled = widget.onChanged != null;

    return GestureDetector(
      onTap: isEnabled
          ? () {
              widget.onChanged!(!widget.value);
            }
          : null,
      child: Focus(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return _buildSwitch(context, effectiveTheme, isEnabled);
          },
        ),
      ),
    );
  }

  /// 构建开关
  Widget _buildSwitch(BuildContext context, ZephyrSwitchTheme theme, bool isEnabled) {
    final switchSize = _getSwitchSize();
    final thumbSize = _getThumbSize();
    final trackWidth = switchSize.width;
    final trackHeight = switchSize.height;
    final thumbOffset = _animation.value * (trackWidth - thumbSize - 4);

    final activeColor = widget.activeColor ?? theme.activeColor;
    final inactiveColor = widget.inactiveColor ?? theme.inactiveColor;
    final thumbColor = widget.thumbColor ?? theme.thumbColor;

    final trackColor = Color.lerp(
      inactiveColor,
      activeColor,
      _animation.value,
    )!;

    return Container(
      width: trackWidth,
      height: trackHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(trackHeight / 2),
        color: isEnabled ? trackColor : theme.disabledColor,
        border: theme.borderWidth > 0
            ? Border.all(
                color: theme.borderColor,
                width: theme.borderWidth,
              )
            : null,
      ),
      child: Stack(
        children: [
          // 滑块
          Positioned(
            left: 2 + thumbOffset,
            top: 2,
            child: Container(
              width: thumbSize,
              height: thumbSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isEnabled ? thumbColor : theme.disabledThumbColor,
                boxShadow: theme.thumbShadow,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 获取开关尺寸
  Size _getSwitchSize() {
    switch (widget.size) {
      case ZephyrSize.xs:
        return const Size(32, 18);
      case ZephyrSize.sm:
        return const Size(36, 20);
      case ZephyrSize.md:
        return const Size(44, 24);
      case ZephyrSize.lg:
        return const Size(52, 28);
      case ZephyrSize.xl:
        return const Size(60, 32);
    }
  }

  /// 获取滑块尺寸
  double _getThumbSize() {
    switch (widget.size) {
      case ZephyrSize.xs:
        return 14;
      case ZephyrSize.sm:
        return 16;
      case ZephyrSize.md:
        return 20;
      case ZephyrSize.lg:
        return 24;
      case ZephyrSize.xl:
        return 28;
    }
  }
}

/// ZephyrUI 带标签的开关
///
/// 包含标签和描述的开关组件。
class ZephyrLabeledSwitch extends StatelessWidget {
  /// 创建带标签的开关
  const ZephyrLabeledSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.size = ZephyrSize.md,
    this.variant = ZephyrVariant.primary,
    this.labelPosition = ZephyrPosition.right,
    this.spacing = ZephyrSpacing.md,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.trackColor,
    this.theme,
  }) : super(key: key);

  /// 开关状态
  final bool value;

  /// 状态变化回调
  final ValueChanged<bool>? onChanged;

  /// 标签文本
  final String? label;

  /// 描述文本
  final String? description;

  /// 尺寸
  final ZephyrSize size;

  /// 变体
  final ZephyrVariant variant;

  /// 标签位置
  final ZephyrPosition labelPosition;

  /// 间距
  final double spacing;

  /// 激活状态颜色
  final Color? activeColor;

  /// 非激活状态颜色
  final Color? inactiveColor;

  /// 滑块颜色
  final Color? thumbColor;

  /// 轨道颜色
  final Color? trackColor;

  /// 主题
  final ZephyrSwitchTheme? theme;

  @override
  Widget build(BuildContext context) {
    final switchWidget = ZephyrSwitch(
      value: value,
      onChanged: onChanged,
      size: size,
      variant: variant,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      thumbColor: thumbColor,
      trackColor: trackColor,
      theme: theme,
    );

    final labelWidget = _buildLabel(context);

    if (labelWidget == null) {
      return switchWidget;
    }

    switch (labelPosition) {
      case ZephyrPosition.left:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            labelWidget,
            SizedBox(width: spacing),
            switchWidget,
          ],
        );
      case ZephyrPosition.right:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            switchWidget,
            SizedBox(width: spacing),
            labelWidget,
          ],
        );
      case ZephyrPosition.top:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            labelWidget,
            SizedBox(height: spacing),
            switchWidget,
          ],
        );
      case ZephyrPosition.bottom:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            switchWidget,
            SizedBox(height: spacing),
            labelWidget,
          ],
        );
      default:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            switchWidget,
            SizedBox(width: spacing),
            labelWidget,
          ],
        );
    }
  }

  /// 构建标签
  Widget? _buildLabel(BuildContext context) {
    if (label == null && description == null) {
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Text(
            label!,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        if (label != null && description != null)
          const SizedBox(height: ZephyrSpacing.xs),
        if (description != null)
          Text(
            description!,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.zephyrTheme.zephyrTextTheme.secondaryColor,
            ),
          ),
      ],
    );
  }
}
