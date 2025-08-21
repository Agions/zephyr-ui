/// ZephyrUI 复选框组件
///
/// 提供单个复选框功能，支持多种状态和主题定制。
library checkbox;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 复选框组件
///
/// 一个功能丰富的复选框组件，支持多种状态和自定义主题。
///
/// 示例用法:
/// ```dart
/// ZephyrCheckbox(
///   value: isChecked,
///   onChanged: (value) => setState(() => isChecked = value),
///   label: '我同意服务条款',
/// )
/// ```
class ZephyrCheckbox extends StatefulWidget {
  /// 创建一个复选框组件
  const ZephyrCheckbox({
    Key? key,
    required this.value,
    this.onChanged,
    this.label,
    this.sublabel,
    this.size = ZephyrSize.md,
    this.variant = ZephyrVariant.primary,
    this.disabled = false,
    this.readOnly = false,
    this.required = false,
    this.errorText,
    this.helperText,
    this.indeterminate = false,
    this.theme,
    this.semanticLabel,
    this.enableAccessibilityFeatures = true,
  }) : super(key: key);

  /// 当前选中状态
  final bool value;

  /// 状态变化回调
  final ValueChanged<bool>? onChanged;

  /// 标签文本
  final String? label;

  /// 子标签文本
  final String? sublabel;

  /// 尺寸
  final ZephyrSize size;

  /// 变体
  final ZephyrVariant variant;

  /// 是否禁用
  final bool disabled;

  /// 是否只读
  final bool readOnly;

  /// 是否必填
  final bool required;

  /// 错误文本
  final String? errorText;

  /// 帮助文本
  final String? helperText;

  /// 是否为不确定状态
  final bool indeterminate;

  /// 主题
  final ZephyrCheckboxTheme? theme;

  /// 语义标签
  final String? semanticLabel;

  /// 是否启用无障碍功能
  final bool enableAccessibilityFeatures;

  @override
  State<ZephyrCheckbox> createState() => _ZephyrCheckboxState();
}

class _ZephyrCheckboxState extends State<ZephyrCheckbox> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrCheckboxTheme.of(context);
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCheckbox(theme, hasError),
        if (widget.helperText != null || hasError) ...[
          const SizedBox(height: 4),
          _buildHelperText(theme, hasError),
        ],
      ],
    );
  }

  Widget _buildCheckbox(ZephyrCheckboxTheme theme, bool hasError) {
    return InkWell(
      onTap: widget.disabled || widget.readOnly ? null : _handleChanged,
      onHover: (hovered) {
        setState(() {
          _isHovered = hovered;
        });
      },
      onFocusChange: (focused) {
        setState(() {
          _isFocused = focused;
        });
      },
      borderRadius: BorderRadius.circular(theme.borderRadius),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCheckboxIcon(theme, hasError),
          if (widget.label != null) ...[
            const SizedBox(width: 8),
            _buildLabel(theme, hasError),
          ],
        ],
      ),
    );
  }

  Widget _buildCheckboxIcon(ZephyrCheckboxTheme theme, bool hasError) {
    final size = _getCheckboxSize();
    final effectiveColor = _getEffectiveColor(theme, hasError);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.borderRadius),
        border: Border.all(
          color: _getBorderColor(theme, hasError),
          width: theme.borderWidth,
        ),
        color: _getBackgroundColor(theme, hasError),
      ),
      child: Center(
        child: _buildCheckboxContent(theme, effectiveColor),
      ),
    );
  }

  Widget _buildCheckboxContent(ZephyrCheckboxTheme theme, Color color) {
    if (widget.indeterminate) {
      return Icon(
        Icons.remove,
        size: _getIconSize(),
        color: color,
      );
    }

    if (widget.value) {
      return Icon(
        Icons.check,
        size: _getIconSize(),
        color: color,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildLabel(ZephyrCheckboxTheme theme, bool hasError) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label!,
            style: _getTextStyle(theme, hasError),
            children: widget.required
                ? [
                    TextSpan(
                      text: ' *',
                      style: _getTextStyle(theme, hasError).copyWith(
                        color: theme.errorColor,
                      ),
                    ),
                  ]
                : null,
          ),
        ),
        if (widget.sublabel != null) ...[
          const SizedBox(height: 2),
          Text(
            widget.sublabel!,
            style: theme.sublabelStyle,
          ),
        ],
      ],
    );
  }

  Widget _buildHelperText(ZephyrCheckboxTheme theme, bool hasError) {
    final text = hasError ? widget.errorText! : widget.helperText!;
    final style = hasError ? theme.errorTextStyle : theme.helperTextStyle;

    return Text(
      text,
      style: style,
    );
  }

  void _handleChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(!widget.value);
    }
  }

  Color _getEffectiveColor(ZephyrCheckboxTheme theme, bool hasError) {
    if (widget.disabled) {
      return theme.disabledColor;
    }
    
    if (hasError) {
      return theme.errorColor;
    }
    
    if (widget.value || widget.indeterminate) {
      return theme.activeColor;
    }
    
    return theme.checkColor;
  }

  Color _getBorderColor(ZephyrCheckboxTheme theme, bool hasError) {
    if (widget.disabled) {
      return theme.disabledBorderColor;
    }
    
    if (hasError) {
      return theme.errorBorderColor;
    }
    
    if (_isFocused) {
      return theme.focusedBorderColor;
    }
    
    if (_isHovered) {
      return theme.hoverBorderColor;
    }
    
    return theme.borderColor;
  }

  Color? _getBackgroundColor(ZephyrCheckboxTheme theme, bool hasError) {
    if (widget.value || widget.indeterminate) {
      return widget.disabled ? theme.disabledBackgroundColor : theme.activeBackgroundColor;
    }
    
    if (_isHovered) {
      return theme.hoverBackgroundColor;
    }
    
    return null;
  }

  TextStyle _getTextStyle(ZephyrCheckboxTheme theme, bool hasError) {
    if (widget.disabled) {
      return theme.disabledTextStyle;
    }
    
    if (hasError) {
      return theme.errorTextStyle;
    }
    
    return theme.textStyle;
  }

  double _getCheckboxSize() {
    switch (widget.size) {
      case ZephyrSize.xs:
        return 16.0;
      case ZephyrSize.sm:
        return 18.0;
      case ZephyrSize.md:
        return 20.0;
      case ZephyrSize.lg:
        return 24.0;
      case ZephyrSize.xl:
        return 28.0;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ZephyrSize.xs:
        return 12.0;
      case ZephyrSize.sm:
        return 14.0;
      case ZephyrSize.md:
        return 16.0;
      case ZephyrSize.lg:
        return 18.0;
      case ZephyrSize.xl:
        return 20.0;
    }
  }
}

