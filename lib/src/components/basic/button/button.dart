import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 遵循Zephyr设计规范的按钮组件
///
/// 用于触发用户交互的操作。支持多种样式、尺寸和状态。
///
/// 示例用法:
/// ```dart
/// ZephyrButton.primary(
///   text: '提交',
///   onPressed: () => print('按钮点击'),
/// )
/// ```
class ZephyrButton extends StatelessWidget {
  /// 创建一个主要按钮，带有默认样式
  ///
  /// [text] 参数是必需的
  const ZephyrButton.primary({
    required this.text,
    super.key,
    VoidCallback? onPressed,
    this.icon,
    this.size = ZephyrButtonSize.medium,
    this.isFullWidth = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.theme,
  })  : onPressed = (isLoading || isDisabled) ? null : onPressed,
        _type = ZephyrButtonType.filled;

  /// 创建一个次要按钮，带有默认样式
  const ZephyrButton.secondary({
    required this.text,
    super.key,
    VoidCallback? onPressed,
    this.icon,
    this.size = ZephyrButtonSize.medium,
    this.isFullWidth = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.theme,
  })  : onPressed = (isLoading || isDisabled) ? null : onPressed,
        _type = ZephyrButtonType.outlined;

  /// 创建一个轮廓按钮，带有默认样式
  const ZephyrButton.outline({
    required this.text,
    super.key,
    VoidCallback? onPressed,
    this.icon,
    this.size = ZephyrButtonSize.medium,
    this.isFullWidth = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.theme,
  })  : onPressed = (isLoading || isDisabled) ? null : onPressed,
        _type = ZephyrButtonType.outlined;

  /// 创建一个文本按钮，带有默认样式
  const ZephyrButton.text({
    required this.text,
    super.key,
    VoidCallback? onPressed,
    this.icon,
    this.size = ZephyrButtonSize.medium,
    this.isFullWidth = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.theme,
  })  : onPressed = (isLoading || isDisabled) ? null : onPressed,
        _type = ZephyrButtonType.text;

  /// 创建图标按钮
  factory ZephyrButton.icon({
    required IconData icon,
    required VoidCallback? onPressed,
    Key? key,
    ZephyrButtonType type = ZephyrButtonType.filled,
    ZephyrButtonSize size = ZephyrButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    ZephyrButtonTheme? theme,
  }) {
    return ZephyrButton._internal(
      text: '', // 空文本
      type: type,
      size: size,
      isFullWidth: false,
      isLoading: isLoading,
      isDisabled: isDisabled,
      key: key,
      theme: theme,
      onPressed: (isLoading || isDisabled) ? null : onPressed,
      icon: icon,
    );
  }

  /// 内部构造函数
  const ZephyrButton._internal({
    required this.text,
    required ZephyrButtonType type,
    required this.size,
    required this.isFullWidth,
    required this.isLoading,
    required this.isDisabled,
    super.key,
    this.theme,
    this.onPressed,
    this.icon,
  })  : _type = type;

  /// 按钮显示的文本
  final String text;

  /// 点击按钮时的回调
  final VoidCallback? onPressed;

  /// 可选的图标
  final IconData? icon;

  /// 按钮尺寸
  final ZephyrButtonSize size;

  /// 是否占据全宽
  final bool isFullWidth;

  /// 是否处于加载状态
  final bool isLoading;

  /// 是否禁用
  final bool isDisabled;

  /// 按钮主题
  final ZephyrButtonTheme? theme;

  /// 内部按钮类型
  final ZephyrButtonType _type;

  @override
  Widget build(BuildContext context) {
    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
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

    switch (_type) {
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

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: text,
      child: Material(
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
