import 'package:flutter/material.dart';
import 'card_theme.dart';

/// Zephyr UI卡片组件
///
/// 一个多功能的卡片组件，支持多种视觉样式变体，包括标准、扁平、高阴影、填充和轮廓样式
class ZephyrCard extends StatefulWidget {
  /// 创建一个Zephyr卡片组件
  const ZephyrCard({
    Key? key,
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
    this.variant = ZephyrCardVariant.standard,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.enabled = true,
    this.splashColor,
    this.highlightColor,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  /// 创建一个扁平卡片（无阴影）
  factory ZephyrCard.flat({
    Key? key,
    Widget? child,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    String? semanticLabel,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enabled = true,
  }) {
    return ZephyrCard(
      key: key,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      margin: margin,
      padding: padding,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: enabled,
      elevation: 0,
      variant: ZephyrCardVariant.flat,
      child: child,
    );
  }

  /// 创建一个带阴影的卡片
  factory ZephyrCard.elevated({
    Key? key,
    Widget? child,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    String? semanticLabel,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enabled = true,
  }) {
    return ZephyrCard(
      key: key,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      margin: margin,
      padding: padding,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: enabled,
      variant: ZephyrCardVariant.elevated,
      child: child,
    );
  }

  /// 创建一个填充卡片（有背景色但无阴影）
  factory ZephyrCard.filled({
    Key? key,
    Widget? child,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    String? semanticLabel,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enabled = true,
  }) {
    return ZephyrCard(
      key: key,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      margin: margin,
      padding: padding,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: enabled,
      elevation: 0,
      variant: ZephyrCardVariant.filled,
      child: child,
    );
  }

  /// 创建一个描边卡片（只有边框，无背景和阴影）
  factory ZephyrCard.outlined({
    Key? key,
    Widget? child,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    String? semanticLabel,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enabled = true,
  }) {
    return ZephyrCard(
      key: key,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      margin: margin,
      padding: padding,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      onLongPress: onLongPress,
      onHover: onHover,
      semanticLabel: semanticLabel,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: enabled,
      elevation: 0,
      variant: ZephyrCardVariant.outlined,
      child: child,
    );
  }

  /// 卡片内容
  final Widget? child;

  /// 卡片背景色
  ///
  /// 如果为null，将使用主题中的backgroundColor
  final Color? backgroundColor;

  /// 卡片内容颜色
  ///
  /// 如果为null，将使用主题中的foregroundColor
  final Color? foregroundColor;

  /// 卡片阴影颜色
  ///
  /// 如果为null，将使用主题中的shadowColor
  final Color? shadowColor;

  /// Material 3表面色调
  ///
  /// 如果为null，将使用主题中的surfaceTintColor
  final Color? surfaceTintColor;

  /// 卡片阴影高度
  ///
  /// 如果为null，将使用主题中相应变体的elevation值
  final double? elevation;

  /// 卡片圆角半径
  ///
  /// 如果为null，将使用主题中的borderRadius
  final BorderRadius? borderRadius;

  /// 卡片边框宽度（仅用于outlined变体）
  ///
  /// 如果为null，将使用主题中的borderWidth
  final double? borderWidth;

  /// 卡片边框颜色（仅用于outlined变体）
  ///
  /// 如果为null，将使用主题中的borderColor
  final Color? borderColor;

  /// 卡片内边距
  ///
  /// 如果为null，将使用主题中的padding
  final EdgeInsetsGeometry? padding;

  /// 卡片外边距
  ///
  /// 如果为null，将使用主题中的margin
  final EdgeInsetsGeometry? margin;

  /// 卡片宽度
  final double? width;

  /// 卡片高度
  final double? height;

  /// 卡片裁剪行为
  final Clip clipBehavior;

  /// 卡片变体
  ///
  /// 默认为[ZephyrCardVariant.standard]
  final ZephyrCardVariant variant;

  /// 点击卡片时的回调
  final VoidCallback? onTap;

  /// 长按卡片时的回调
  final VoidCallback? onLongPress;

  /// 鼠标悬停在卡片上时的回调
  final ValueChanged<bool>? onHover;

  /// 卡片的语义标签
  final String? semanticLabel;

  /// 卡片是否启用
  ///
  /// 当设置为false时，卡片将不响应点击事件
  final bool enabled;

  /// 点击水波纹颜色
  final Color? splashColor;

  /// 高亮颜色
  final Color? highlightColor;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 是否自动获取焦点
  final bool autofocus;

  @override
  State<ZephyrCard> createState() => _ZephyrCardState();
}

class _ZephyrCardState extends State<ZephyrCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrCardTheme>() ??
        ZephyrCardTheme.fallback(context);

    // 确定最终使用的属性值
    final backgroundColor = widget.backgroundColor ?? theme.backgroundColor;
    final foregroundColor = widget.foregroundColor ?? theme.foregroundColor;
    final shadowColor = widget.shadowColor ?? theme.shadowColor;
      final borderRadius = widget.borderRadius ?? theme.borderRadius;
    final padding = widget.padding ?? theme.padding;
    final margin = widget.margin ?? theme.margin;
    // 根据变体确定阴影高度
    double baseElevation =
        widget.elevation ?? theme.getElevation(widget.variant);

    // 根据交互状态调整阴影高度
    double currentElevation = baseElevation;
    if (widget.enabled) {
      if (_isHovered) {
        currentElevation += theme.hoverElevationDelta;
      }
    } else {
      currentElevation = 0;
    }

    // 根据变体设置边框
    BoxBorder? border;
    if (widget.variant == ZephyrCardVariant.outlined) {
      final borderWidth = widget.borderWidth ?? theme.borderWidth;
      final borderColor = widget.borderColor ??
          theme.borderColor ??
          Theme.of(context).dividerColor;
      border = Border.all(
        width: borderWidth,
        color: borderColor,
      );
    }

    // 构建卡片内容
    Widget content = widget.child ?? const SizedBox();

    // 应用前景色（如果有）
    if (foregroundColor != null) {
      content = DefaultTextStyle(
        style:
            DefaultTextStyle.of(context).style.copyWith(color: foregroundColor),
        child: IconTheme(
          data: IconThemeData(color: foregroundColor),
          child: content,
        ),
      );
    }

    // 应用内边距
    content = Padding(
      padding: padding,
      child: content,
    );

    // 构建卡片容器
    Widget card = AnimatedContainer(
      duration: theme.animationDuration,
      curve: theme.animationCurve,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: border,
        boxShadow: currentElevation > 0
            ? [
                BoxShadow(
                  color: shadowColor?.withValues(alpha: 0.2) ??
                      Colors.black.withValues(alpha: 0.2),
                  blurRadius: currentElevation * 4,
                  spreadRadius: currentElevation / 2,
                  offset: Offset(0, currentElevation),
                ),
              ]
            : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        clipBehavior: widget.clipBehavior,
        borderRadius: borderRadius,
        child: content,
      ),
    );

    // 添加外边距
    card = Padding(
      padding: margin,
      child: card,
    );

    // 添加交互行为
    if (widget.enabled &&
        (widget.onTap != null || widget.onLongPress != null)) {
      card = Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: widget.enabled,
        child: InkWell(
          splashColor: widget.splashColor,
          highlightColor: widget.highlightColor,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          onHover: (value) {
            setState(() {
              _isHovered = value;
            });
            if (widget.onHover != null) {
              widget.onHover!(value);
            }
          },
          onHighlightChanged: (value) {
            setState(() {
              _isPressed = value;
            });
          },
          child: Opacity(
            opacity: _isPressed ? theme.pressedOpacity : 1.0,
            child: card,
          ),
        ),
      );
    } else {
      card = Semantics(
        label: widget.semanticLabel,
        button: false,
        enabled: widget.enabled,
        child: card,
      );
    }

    return card;
  }
}
