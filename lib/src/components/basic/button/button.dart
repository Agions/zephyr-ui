/// VelocityUI 按钮组件
///
/// 提供多种样式的按钮组件，支持主题定制。
library velocity_button;

import 'package:flutter/material.dart';
import 'button_style.dart';

export 'button_style.dart';

/// 按钮类型
enum VelocityButtonType {
  primary,
  secondary,
  outline,
  text,
  danger,
  success,
  warning
}

/// 按钮尺寸
enum VelocityButtonSize { small, medium, large }

/// 图标位置
enum VelocityIconPosition { left, right }

/// VelocityUI 按钮组件
class VelocityButton extends StatelessWidget {
  /// 创建一个按钮
  const VelocityButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.type = VelocityButtonType.primary,
    this.size = VelocityButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = false,
    this.style,
  })  : _text = null,
        _icon = null,
        _iconPosition = VelocityIconPosition.left;

  /// 创建一个带文本的按钮
  const VelocityButton.text({
    super.key,
    required String text,
    this.onPressed,
    this.onLongPress,
    this.type = VelocityButtonType.primary,
    this.size = VelocityButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = false,
    this.style,
  })  : child = null,
        _text = text,
        _icon = null,
        _iconPosition = VelocityIconPosition.left;

  /// 创建一个带图标的按钮
  const VelocityButton.icon({
    super.key,
    required String text,
    required IconData icon,
    VelocityIconPosition iconPosition = VelocityIconPosition.left,
    this.onPressed,
    this.onLongPress,
    this.type = VelocityButtonType.primary,
    this.size = VelocityButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = false,
    this.style,
  })  : child = null,
        _text = text,
        _icon = icon,
        _iconPosition = iconPosition;

  final Widget? child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final VelocityButtonType type;
  final VelocityButtonSize size;
  final bool loading;
  final bool disabled;
  final bool fullWidth;
  final VelocityButtonStyle? style;

  final String? _text;
  final IconData? _icon;
  final VelocityIconPosition _iconPosition;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle =
        VelocityButtonStyle.resolve(type: type, size: size, customStyle: style);
    final effectiveDisabled = disabled || loading;

    Widget content = _buildContent(effectiveStyle);

    final bgColor = effectiveDisabled
        ? (effectiveStyle.disabledBackgroundColor ?? Colors.grey)
        : (effectiveStyle.backgroundColor ?? Colors.blue);

    Widget button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: effectiveDisabled ? null : onPressed,
        onLongPress: effectiveDisabled ? null : onLongPress,
        borderRadius: effectiveStyle.borderRadius,
        splashColor: effectiveStyle.splashColor,
        highlightColor: effectiveStyle.highlightColor,
        child: Container(
          padding: effectiveStyle.padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: effectiveStyle.borderRadius,
            border: effectiveStyle.border,
            boxShadow: effectiveStyle.boxShadow,
          ),
          child: content,
        ),
      ),
    );

    if (fullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _buildContent(VelocityButtonStyle effectiveStyle) {
    final effectiveDisabled = disabled || loading;
    final foregroundColor = effectiveDisabled
        ? (effectiveStyle.disabledForegroundColor ?? Colors.grey)
        : (effectiveStyle.foregroundColor ?? Colors.white);

    if (loading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: effectiveStyle.iconSize ?? 18,
            height: effectiveStyle.iconSize ?? 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
          if (_text != null) ...[
            SizedBox(width: effectiveStyle.iconSpacing ?? 8),
            Text(_text!,
                style:
                    effectiveStyle.textStyle?.copyWith(color: foregroundColor)),
          ],
        ],
      );
    }

    if (child != null) return child!;

    if (_icon != null && _text != null) {
      final iconWidget = Icon(_icon,
          size: effectiveStyle.iconSize ?? 18, color: foregroundColor);
      final textWidget = Text(_text!,
          style: effectiveStyle.textStyle?.copyWith(color: foregroundColor));

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _iconPosition == VelocityIconPosition.left
            ? [
                iconWidget,
                SizedBox(width: effectiveStyle.iconSpacing ?? 8),
                textWidget
              ]
            : [
                textWidget,
                SizedBox(width: effectiveStyle.iconSpacing ?? 8),
                iconWidget
              ],
      );
    }

    if (_text != null) {
      return Text(_text!,
          style: effectiveStyle.textStyle?.copyWith(color: foregroundColor));
    }

    return const SizedBox.shrink();
  }
}

/// VelocityUI 图标按钮组件
class VelocityIconButton extends StatelessWidget {
  const VelocityIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 40,
    this.iconSize = 20,
    this.style,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final VelocityIconButtonStyle? style;
  final bool disabled;
  final bool loading;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityIconButtonStyle.defaults();
    final effectiveDisabled = disabled || loading;

    final effectiveBackgroundColor = effectiveDisabled
        ? (effectiveStyle.disabledBackgroundColor ?? Colors.grey.shade200)
        : (effectiveStyle.backgroundColor ?? Colors.transparent);
    final effectiveIconColor = effectiveDisabled
        ? (effectiveStyle.disabledIconColor ?? Colors.grey)
        : (effectiveStyle.iconColor ?? Colors.grey.shade700);

    Widget button = Material(
      color: effectiveBackgroundColor,
      borderRadius:
          effectiveStyle.borderRadius ?? BorderRadius.circular(size / 2),
      child: InkWell(
        onTap: effectiveDisabled ? null : onPressed,
        borderRadius:
            effectiveStyle.borderRadius ?? BorderRadius.circular(size / 2),
        splashColor: effectiveStyle.splashColor,
        highlightColor: effectiveStyle.highlightColor,
        child: Container(
          width: size,
          height: size,
          decoration: effectiveStyle.border != null
              ? BoxDecoration(
                  borderRadius: effectiveStyle.borderRadius ??
                      BorderRadius.circular(size / 2),
                  border: effectiveStyle.border,
                )
              : null,
          child: Center(
            child: loading
                ? SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(effectiveIconColor),
                    ),
                  )
                : Icon(icon, size: iconSize, color: effectiveIconColor),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
