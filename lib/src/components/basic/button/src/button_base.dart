import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 按钮基础实现类，处理按钮的核心渲染逻辑
class ZephyrButtonBase extends StatelessWidget {
  const ZephyrButtonBase({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.type,
    required this.size,
    this.icon,
    this.theme,
    this.isFullWidth = false,
    this.isLoading = false,
  }) : super(key: key);

  /// 按钮显示的文本
  final String text;

  /// 点击按钮时的回调
  final VoidCallback? onPressed;

  /// 可选的图标
  final IconData? icon;

  /// 按钮类型
  final ZephyrButtonType type;

  /// 按钮尺寸
  final ZephyrButtonSize size;

  /// 按钮主题
  final ZephyrButtonTheme? theme;

  /// 是否占据全宽
  final bool isFullWidth;

  /// 是否处于加载状态
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrButtonTheme.resolve(
      context,
      theme,
    );

    // 根据按钮类型和状态确定样式
    Color backgroundColor;
    Color textColor;
    Color? overlayColor;
    BoxBorder? border;
    double elevation;

    switch (type) {
      case ZephyrButtonType.filled:
        backgroundColor = effectiveTheme.primaryBackgroundColor!;
        textColor = effectiveTheme.primaryTextColor!;
        overlayColor = effectiveTheme.splashColor;
        elevation = effectiveTheme.elevation!;
        break;
      case ZephyrButtonType.outlined:
        backgroundColor = Colors.transparent;
        textColor = effectiveTheme.outlineTextColor!;
        border = Border.all(
          color: effectiveTheme.outlineColor!,
          width: 1.0,
        );
        elevation = 0.0;
        break;
      case ZephyrButtonType.text:
        backgroundColor = Colors.transparent;
        textColor = effectiveTheme.textButtonColor!;
        elevation = 0.0;
        break;
      case ZephyrButtonType.icon:
        backgroundColor = Colors.transparent;
        textColor = effectiveTheme.primaryTextColor!;
        elevation = 0.0;
        break;
      case ZephyrButtonType.fab:
        backgroundColor = effectiveTheme.primaryBackgroundColor!;
        textColor = effectiveTheme.primaryTextColor!;
        overlayColor = effectiveTheme.splashColor;
        elevation = effectiveTheme.elevation!;
        break;
    }

    // 禁用或加载状态下的样式覆盖
    if (onPressed == null) {
      backgroundColor = effectiveTheme.disabledBackgroundColor!;
      textColor = effectiveTheme.disabledTextColor!;
      elevation = effectiveTheme.disabledElevation!;
      border = null;
    }

    // 确定内边距和文本样式
    EdgeInsetsGeometry padding;
    TextStyle textStyle;

    switch (size) {
      case ZephyrButtonSize.small:
        padding = effectiveTheme.smallPadding!;
        textStyle = effectiveTheme.smallTextStyle!;
        break;
      case ZephyrButtonSize.medium:
        padding = effectiveTheme.mediumPadding!;
        textStyle = effectiveTheme.mediumTextStyle!;
        break;
      case ZephyrButtonSize.large:
        padding = effectiveTheme.largePadding!;
        textStyle = effectiveTheme.largeTextStyle!;
        break;
    }

    // 内容布局
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null && !isLoading) ...[
          Icon(icon, color: textColor, size: 16),
          const SizedBox(width: 8),
        ],
        if (isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                effectiveTheme.loadingColor!,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: textStyle.copyWith(color: textColor),
        ),
      ],
    );

    // 全宽模式下进行包装
    if (isFullWidth) {
      content = SizedBox(
        width: double.infinity,
        child: Center(child: content),
      );
    }

    return Material(
      color: backgroundColor,
      elevation: elevation,
      borderRadius: BorderRadius.circular(effectiveTheme.borderRadius!),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(effectiveTheme.borderRadius!),
        splashColor: overlayColor,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(effectiveTheme.borderRadius!),
            border: border,
          ),
          child: content,
        ),
      ),
    );
  }
}

/// 按钮尺寸变体
enum ZephyrButtonSize {
  /// 小型按钮
  small,

  /// 中型按钮 (默认)
  medium,

  /// 大型按钮
  large,
}
