import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// Zephyr输入框组件
/// 
/// 提供多种输入类型和状态，支持验证、图标、前缀后缀等功能。
/// 
/// 示例用法:
/// ```dart
/// ZephyrInput(
///   placeholder: '请输入用户名',
///   prefixIcon: Icons.person,
///   onChanged: (value) => print(value),
/// )
/// ```
class ZephyrInput extends StatefulWidget {
  /// 创建标准输入框
  const ZephyrInput({
    super.key,
    this.placeholder,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.autoFocus = false,
    this.focusNode,
    this.controller,
    this.theme,
    this.errorText,
    this.helperText,
    this.counterText,
  });

  /// 占位符文本
  final String? placeholder;

  /// 初始值
  final String? initialValue;

  /// 值变化回调
  final ValueChanged<String>? onChanged;

  /// 提交回调
  final ValueChanged<String>? onSubmitted;

  /// 验证函数
  final String? Function(String?)? validator;

  /// 前缀图标
  final IconData? prefixIcon;

  /// 后缀图标
  final IconData? suffixIcon;

  /// 前缀文本
  final String? prefixText;

  /// 后缀文本
  final String? suffixText;

  /// 是否密码模式
  final bool obscureText;

  /// 是否启用
  final bool enabled;

  /// 是否只读
  final bool readOnly;

  /// 最大行数
  final int maxLines;

  /// 最大长度
  final int? maxLength;

  /// 键盘类型
  final TextInputType? keyboardType;

  /// 键盘动作
  final TextInputAction? textInputAction;

  /// 自动纠正
  final bool autocorrect;

  /// 启用建议
  final bool enableSuggestions;

  /// 自动聚焦
  final bool autoFocus;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 文本控制器
  final TextEditingController? controller;

  /// 主题
  final ZephyrInputTheme? theme;

  /// 错误文本
  final String? errorText;

  /// 帮助文本
  final String? helperText;

  /// 计数器文本
  final String? counterText;

  @override
  State<ZephyrInput> createState() => _ZephyrInputState();
}

class _ZephyrInputState extends State<ZephyrInput> {
  late TextEditingController _controller;
  FocusNode? _focusNode;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    
    _focusNode!.addListener(_onFocusChange);
    _controller.addListener(_onTextChanged);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode!.hasFocus;
    });
  }

  void _onTextChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(_controller.text);
    }
    
    // 实时验证
    if (widget.validator != null) {
      final error = widget.validator!(_controller.text);
      if (error != _errorText) {
        setState(() {
          _errorText = error;
        });
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrInputTheme.resolve(context, widget.theme);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(effectiveTheme),
        if (widget.errorText != null || _errorText != null)
          _buildErrorText(effectiveTheme)
        else if (widget.helperText != null)
          _buildHelperText(effectiveTheme),
      ],
    );
  }

  Widget _buildInputField(ZephyrInputTheme theme) {
    final isError = widget.errorText != null || _errorText != null;
    final fillColor = _getFillColor(theme, isError);
    final borderColor = _getBorderColor(theme, isError);
    
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      autofocus: widget.autoFocus,
      onSubmitted: widget.onSubmitted,
      style: theme.textStyle?.copyWith(
        color: widget.enabled ? theme.textColor : theme.disabledTextColor,
      ),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: theme.placeholderStyle,
        filled: true,
        fillColor: fillColor,
        enabled: widget.enabled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(theme.borderRadius),
          borderSide: BorderSide(color: borderColor, width: theme.borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(theme.borderRadius),
          borderSide: BorderSide(color: borderColor, width: theme.borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(theme.borderRadius),
          borderSide: BorderSide(color: theme.focusedBorderColor ?? Colors.blue, width: theme.focusedBorderWidth),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(theme.borderRadius),
          borderSide: BorderSide(color: theme.errorColor ?? Colors.red, width: theme.errorBorderWidth),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(theme.borderRadius),
          borderSide: BorderSide(color: theme.errorColor ?? Colors.red, width: theme.errorBorderWidth),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(theme.borderRadius),
          borderSide: BorderSide(color: theme.disabledBorderColor ?? Colors.grey, width: theme.disabledBorderWidth),
        ),
        contentPadding: theme.contentPadding,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: _getIconColor(theme, isError),
                size: theme.iconSize,
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? Icon(
                widget.suffixIcon,
                color: _getIconColor(theme, isError),
                size: theme.iconSize,
              )
            : null,
        prefixText: widget.prefixText,
        prefixStyle: theme.prefixStyle,
        suffixText: widget.suffixText,
        suffixStyle: theme.suffixStyle,
        counterText: widget.counterText,
        counterStyle: theme.counterStyle,
      ),
    );
  }

  Widget _buildErrorText(ZephyrInputTheme theme) {
    return Padding(
      padding: EdgeInsets.only(top: theme.errorSpacing),,
      child: Text(
        widget.errorText ?? _errorText ?? '',
        style: theme.errorStyle,
      ),
    );
  }

  Widget _buildHelperText(ZephyrInputTheme theme) {
    return Padding(
      padding: EdgeInsets.only(top: theme.helperSpacing),,
      child: Text(
        widget.helperText!,
        style: theme.helperStyle,
      ),
    );
  }

  Color _getFillColor(ZephyrInputTheme theme, bool isError) {
    if (!widget.enabled) return theme.disabledFillColor;
    if (isError) return theme.errorFillColor;
    if (_isFocused) return theme.focusedFillColor;
    return theme.fillColor;
  }

  Color _getBorderColor(ZephyrInputTheme theme, bool isError) {
    if (!widget.enabled) return theme.disabledBorderColor;
    if (isError) return theme.errorColor;
    if (_isFocused) return theme.focusedBorderColor;
    return theme.borderColor;
  }

  Color _getIconColor(ZephyrInputTheme theme, bool isError) {
    if (!widget.enabled) return theme.disabledIconColor;
    if (isError) return theme.errorColor;
    if (_isFocused) return theme.focusedIconColor;
    return theme.iconColor;
  }
}