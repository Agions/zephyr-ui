/// ZephyrUI 单选框组件
///
/// 提供单个单选框功能，支持多种状态和主题定制。
library radio;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 单选框组件
///
/// 一个功能丰富的单选框组件，支持多种状态和自定义主题。
///
/// 示例用法:
/// ```dart
/// ZephyrRadio<bool>(
///   value: true,
///   groupValue: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   label: '选项1',
/// )
/// ```
class ZephyrRadio<T> extends StatefulWidget {
  /// 创建一个单选框组件
  const ZephyrRadio({
    super.key,
    required this.value,
    required this.groupValue,
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
    this.theme,
    this.semanticLabel,
    this.enableAccessibilityFeatures = true,
  });

  /// 当前选项的值
  final T value;

  /// 当前选中的值
  final T? groupValue;

  /// 状态变化回调
  final ValueChanged<T?>? onChanged;

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

  /// 主题
  final ZephyrRadioTheme? theme;

  /// 语义标签
  final String? semanticLabel;

  /// 是否启用无障碍功能
  final bool enableAccessibilityFeatures;

  @override
  State<ZephyrRadio<T>> createState() => _ZephyrRadioState<T>();
}

class _ZephyrRadioState<T> extends State<ZephyrRadio<T>> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrRadioTheme.of(context);
    final hasError = widget.errorText != null;
    final isSelected = widget.value == widget.groupValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRadio(theme, isSelected, hasError),
        if (widget.helperText != null || hasError) ...[
          const SizedBox(height: 4),
          _buildHelperText(theme, hasError),
        ],
      ],
    );
  }

  Widget _buildRadio(ZephyrRadioTheme theme, bool isSelected, bool hasError) {
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
      borderRadius: const BorderRadius.circular(_getRadioSize()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRadioIcon(theme, isSelected, hasError),
          if (widget.label != null) ...[
            const SizedBox(width: 8),
            _buildLabel(theme, hasError),
          ],
        ],
      ),
    );
  }

  Widget _buildRadioIcon(ZephyrRadioTheme theme, bool isSelected, bool hasError) {
    final size = _getRadioSize();
    final effectiveColor = _getEffectiveColor(theme, isSelected, hasError);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _getBorderColor(theme, isSelected, hasError),
          width: theme.borderWidth,
        ),
        color: _getBackgroundColor(theme, isSelected),
      ),
      child: isSelected ? _buildRadioContent(theme, effectiveColor) : null,
    );
  }

  Widget _buildRadioContent(ZephyrRadioTheme theme, Color color) {
    final dotSize = _getDotSize();

    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildLabel(ZephyrRadioTheme theme, bool hasError) {
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

  Widget _buildHelperText(ZephyrRadioTheme theme, bool hasError) {
    final text = hasError ? widget.errorText! : widget.helperText!;
    final style = hasError ? theme.errorTextStyle : theme.helperTextStyle;

    return Text(
      text,
      style: style,
    );
  }

  void _handleChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(widget.value);
    }
  }

  Color _getEffectiveColor(ZephyrRadioTheme theme, bool isSelected, bool hasError) {
    if (widget.disabled) {
      return theme.disabledColor;
    }
    
    if (hasError) {
      return theme.errorColor;
    }
    
    if (isSelected) {
      return theme.activeColor;
    }
    
    return theme.activeColor;
  }

  Color _getBorderColor(ZephyrRadioTheme theme, bool isSelected, bool hasError) {
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
    
    if (isSelected) {
      return theme.activeBorderColor;
    }
    
    return theme.borderColor;
  }

  Color? _getBackgroundColor(ZephyrRadioTheme theme, bool isSelected) {
    if (isSelected) {
      return widget.disabled ? theme.disabledBackgroundColor : theme.activeBackgroundColor;
    }
    
    if (_isHovered) {
      return theme.hoverBackgroundColor;
    }
    
    return null;
  }

  TextStyle _getTextStyle(ZephyrRadioTheme theme, bool hasError) {
    if (widget.disabled) {
      return theme.disabledTextStyle;
    }
    
    if (hasError) {
      return theme.errorTextStyle;
    }
    
    return theme.textStyle;
  }

  double _getRadioSize() {
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

  double _getDotSize() {
    switch (widget.size) {
      case ZephyrSize.xs:
        return 8.0;
      case ZephyrSize.sm:
        return 9.0;
      case ZephyrSize.md:
        return 10.0;
      case ZephyrSize.lg:
        return 12.0;
      case ZephyrSize.xl:
        return 14.0;
    }
  }
}
