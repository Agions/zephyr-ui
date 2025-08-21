import 'package:flutter/material.dart';
import 'stepper_theme.dart';

/// 步骤信息
class ZephyrStep {
  const ZephyrStep({
    required this.title,
    this.subtitle,
    this.content,
    this.icon,
    this.state = ZephyrStepState.indexed,
  });

  /// 步骤标题
  final String title;

  /// 步骤副标题
  final String? subtitle;

  /// 步骤内容
  final Widget? content;

  /// 步骤图标
  final IconData? icon;

  /// 步骤状态
  final ZephyrStepState state;

  /// 创建一个新的步骤，并替换指定字段
  ZephyrStep copyWith({
    String? title,
    String? subtitle,
    Widget? content,
    IconData? icon,
    ZephyrStepState? state,
  }) {
    return ZephyrStep(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      icon: icon ?? this.icon,
      state: state ?? this.state,
    );
  }
}

/// 步骤状态
enum ZephyrStepState {
  /// 索引状态（显示数字）
  indexed,

  /// 禁用状态
  disabled,

  /// 错误状态
  error,

  /// 已完成状态
  complete,

  /// 编辑状态
  editing,
}

/// 步骤方向
enum ZephyrStepperDirection {
  /// 垂直方向
  vertical,

  /// 水平方向
  horizontal,
}

/// Zephyr UI步进器组件
///
/// 用于引导用户完成分步骤任务的导航组件，支持垂直和水平两种布局。
class ZephyrStepper extends StatefulWidget {
  /// 创建一个步进器组件
  const ZephyrStepper({
    Key? key,
    required this.steps,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
    this.direction = ZephyrStepperDirection.vertical,
    this.type = ZephyrStepperType.normal,
    this.theme,
    this.physics,
    this.allowStepTap = true,
  }) : super(key: key);

  /// 步骤列表
  final List<ZephyrStep> steps;

  /// 当前步骤索引
  final int currentStep;

  /// 点击步骤回调
  final ValueChanged<int>? onStepTapped;

  /// 继续按钮回调
  final VoidCallback? onStepContinue;

  /// 取消按钮回调
  final VoidCallback? onStepCancel;

  /// 控制按钮构建器
  final Widget Function(BuildContext,
      {VoidCallback? onStepContinue,
      VoidCallback? onStepCancel})? controlsBuilder;

  /// 步进器方向
  final ZephyrStepperDirection direction;

  /// 步进器类型
  final ZephyrStepperType type;

  /// 步进器主题
  final ZephyrStepperTheme? theme;

  /// 滚动物理特性
  final ScrollPhysics? physics;

  /// 是否允许点击步骤
  final bool allowStepTap;

  @override
  State<ZephyrStepper> createState() => _ZephyrStepperState();
}

/// 步进器类型
enum ZephyrStepperType {
  /// 标准样式，显示带连接线的指示器
  normal,

  /// 仅显示圆形指示器
  dots,

  /// 仅显示数字标签
  numbered,

  /// 迷你样式，更紧凑的布局
  mini,
}

class _ZephyrStepperState extends State<ZephyrStepper> {
  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrStepperTheme.resolve(context, widget.theme);

    switch (widget.direction) {
      case ZephyrStepperDirection.vertical:
        return _buildVerticalStepper(effectiveTheme);
      case ZephyrStepperDirection.horizontal:
        return _buildHorizontalStepper(effectiveTheme);
    }
  }

  Widget _buildVerticalStepper(ZephyrStepperTheme theme) {
    return ListView(
      shrinkWrap: true,
      physics: widget.physics,
      children: [
        for (int i = 0; i < widget.steps.length; i++)
          Column(
            children: [
              _buildVerticalStep(i, theme),
              if (i < widget.steps.length - 1) _buildVerticalConnector(i, theme)
            ],
          )
      ],
    );
  }

  Widget _buildVerticalStep(int index, ZephyrStepperTheme theme) {
    final step = widget.steps[index];
    final bool isActive = index == widget.currentStep;
    final bool isCompleted = index < widget.currentStep;

    // 确定步骤状态
    ZephyrStepState effectiveState = step.state;
    if (effectiveState == ZephyrStepState.indexed) {
      if (isActive) {
        effectiveState = ZephyrStepState.editing;
      } else if (isCompleted) {
        effectiveState = ZephyrStepState.complete;
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.allowStepTap && effectiveState != ZephyrStepState.disabled
            ? () => _handleStepTapped(index)
            : null,
        child: Container(
          margin: theme.stepMargin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildStepIcon(index, effectiveState, theme),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStepContent(index, effectiveState, theme),
                  ),
                ],
              ),
              if (isActive && step.content != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: theme.indicatorSize! + 12,
                    right: 0,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      step.content!,
                      if (widget.controlsBuilder != null)
                        widget.controlsBuilder!(
                          context,
                          onStepContinue: widget.onStepContinue,
                          onStepCancel: widget.onStepCancel,
                        )
                      else
                        _buildDefaultControls(theme),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalConnector(int index, ZephyrStepperTheme theme) {
    final bool isActive = index < widget.currentStep;
    final Color connectorColor =
        isActive ? theme.activeColor! : theme.connectorColor!;

    return Container(
      margin: EdgeInsets.only(left: theme.indicatorSize! / 2),
      width: theme.connectorThickness,
      height: 24.0,
      color: connectorColor,
    );
  }

  Widget _buildHorizontalStepper(ZephyrStepperTheme theme) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < widget.steps.length; i++) ...[
                _buildHorizontalStep(i, theme),
                if (i < widget.steps.length - 1)
                  _buildHorizontalConnector(i, theme)
              ]
            ],
          ),
        ),
        if (widget.steps[widget.currentStep].content != null)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                widget.steps[widget.currentStep].content!,
                if (widget.controlsBuilder != null)
                  widget.controlsBuilder!(
                    context,
                    onStepContinue: widget.onStepContinue,
                    onStepCancel: widget.onStepCancel,
                  )
                else
                  _buildDefaultControls(theme),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildHorizontalStep(int index, ZephyrStepperTheme theme) {
    final step = widget.steps[index];
    final bool isActive = index == widget.currentStep;
    final bool isCompleted = index < widget.currentStep;

    // 确定步骤状态
    ZephyrStepState effectiveState = step.state;
    if (effectiveState == ZephyrStepState.indexed) {
      if (isActive) {
        effectiveState = ZephyrStepState.editing;
      } else if (isCompleted) {
        effectiveState = ZephyrStepState.complete;
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.allowStepTap && effectiveState != ZephyrStepState.disabled
            ? () => _handleStepTapped(index)
            : null,
        child: Container(
          padding: theme.stepPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStepIcon(index, effectiveState, theme),
              const SizedBox(height: 8),
              _buildStepTitle(step, effectiveState, theme),
              if (step.subtitle != null) ...[
                const SizedBox(height: 2),
                _buildStepSubtitle(step, effectiveState, theme),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalConnector(int index, ZephyrStepperTheme theme) {
    final bool isActive = index < widget.currentStep;
    final Color connectorColor =
        isActive ? theme.activeColor! : theme.connectorColor!;

    return Container(
      width: 24.0,
      height: theme.connectorThickness,
      margin: EdgeInsets.only(top: theme.indicatorSize! / 2),
      color: connectorColor,
    );
  }

  Widget _buildStepIcon(
      int index, ZephyrStepState state, ZephyrStepperTheme theme) {
    final double indicatorSize = theme.indicatorSize!;
    final IconData? icon = widget.steps[index].icon;

    // 确定颜色和内容
    late Color iconColor;
    late Color backgroundColor;
    Widget? iconWidget;

    switch (state) {
      case ZephyrStepState.indexed:
        backgroundColor = theme.inactiveColor!;
        iconColor = Colors.white;
        iconWidget = Text(
          '${index + 1}',
          style: TextStyle(
            color: iconColor,
            fontSize: indicatorSize * 0.5,
            fontWeight: FontWeight.bold,
          ),
        );
        break;
      case ZephyrStepState.editing:
        backgroundColor = theme.activeColor!;
        iconColor = Colors.white;
        iconWidget = icon != null
            ? Icon(icon, color: iconColor, size: theme.iconSize)
            : Text(
                '${index + 1}',
                style: TextStyle(
                  color: iconColor,
                  fontSize: indicatorSize * 0.5,
                  fontWeight: FontWeight.bold,
                ),
              );
        break;
      case ZephyrStepState.complete:
        backgroundColor = theme.completeColor!;
        iconColor = Colors.white;
        iconWidget = Icon(
          Icons.check,
          color: iconColor,
          size: theme.iconSize,
        );
        break;
      case ZephyrStepState.disabled:
        backgroundColor = theme.disabledColor!;
        iconColor = Colors.white.withValues(alpha: 0.7);
        iconWidget = Text(
          '${index + 1}',
          style: TextStyle(
            color: iconColor,
            fontSize: indicatorSize * 0.5,
            fontWeight: FontWeight.bold,
          ),
        );
        break;
      case ZephyrStepState.error:
        backgroundColor = theme.errorColor!;
        iconColor = Colors.white;
        iconWidget = Icon(
          Icons.error_outline,
          color: iconColor,
          size: theme.iconSize,
        );
        break;
    }

    return Container(
      width: indicatorSize,
      height: indicatorSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(indicatorSize / 2),
      ),
      child: Center(child: iconWidget),
    );
  }

  Widget _buildStepContent(
      int index, ZephyrStepState state, ZephyrStepperTheme theme) {
    final step = widget.steps[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepTitle(step, state, theme),
        if (step.subtitle != null) ...[
          const SizedBox(height: 2),
          _buildStepSubtitle(step, state, theme),
        ]
      ],
    );
  }

  Widget _buildStepTitle(
      ZephyrStep step, ZephyrStepState state, ZephyrStepperTheme theme) {
    TextStyle? titleStyle;

    switch (state) {
      case ZephyrStepState.indexed:
        titleStyle = theme.titleTextStyle;
        break;
      case ZephyrStepState.editing:
        titleStyle = theme.activeTitleTextStyle;
        break;
      case ZephyrStepState.complete:
        titleStyle = theme.titleTextStyle;
        break;
      case ZephyrStepState.disabled:
        titleStyle = theme.disabledTitleTextStyle;
        break;
      case ZephyrStepState.error:
        titleStyle = theme.errorTitleTextStyle;
        break;
    }

    return Text(
      step.title,
      style: titleStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildStepSubtitle(
      ZephyrStep step, ZephyrStepState state, ZephyrStepperTheme theme) {
    TextStyle? subtitleStyle;

    switch (state) {
      case ZephyrStepState.indexed:
        subtitleStyle = theme.subtitleTextStyle;
        break;
      case ZephyrStepState.editing:
        subtitleStyle = theme.activeSubtitleTextStyle;
        break;
      case ZephyrStepState.complete:
        subtitleStyle = theme.subtitleTextStyle;
        break;
      case ZephyrStepState.disabled:
        subtitleStyle = theme.disabledSubtitleTextStyle;
        break;
      case ZephyrStepState.error:
        subtitleStyle = theme.errorSubtitleTextStyle;
        break;
    }

    return Text(
      step.subtitle!,
      style: subtitleStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDefaultControls(ZephyrStepperTheme theme) {
    final bool isLastStep = widget.currentStep == widget.steps.length - 1;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: widget.onStepContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.activeColor,
            ),
            child: Text(isLastStep ? '完成' : '继续'),
          ),
          const SizedBox(width: 8),
          if (widget.currentStep > 0)
            TextButton(
              onPressed: widget.onStepCancel,
              child: const Text('返回'),
            ),
        ],
      ),
    );
  }

  void _handleStepTapped(int index) {
    if (widget.onStepTapped != null) {
      widget.onStepTapped!(index);
    }
  }
}
