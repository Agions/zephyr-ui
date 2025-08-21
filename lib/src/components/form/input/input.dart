/// ZephyrUI 输入组件
///
/// 提供各种类型的输入框，支持验证、格式化、前缀后缀等功能。
library input;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 输入组件
///
/// 一个功能丰富的输入框组件，支持多种输入类型和验证。
///
/// 示例用法:
/// ```dart
/// ZephyrInput(
///   label: '用户名',
///   placeholder: '请输入用户名',
///   onChanged: (value) => print(value),
/// )
/// ```
class ZephyrInput extends StatefulWidget {
  /// 创建一个输入组件
  const ZephyrInput({
    Key? key,
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.type = ZephyrInputType.text,
    this.size = ZephyrSize.md,
    this.variant = ZephyrVariant.outline,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onFocusChange,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.theme,
  }) : super(key: key);

  /// 创建密码输入框
  const ZephyrInput.password({
    Key? key,
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.size = ZephyrSize.md,
    this.variant = ZephyrVariant.outline,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onFocusChange,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
    this.focusNode,
    this.autofocus = false,
    this.theme,
  })  : type = ZephyrInputType.password,
        obscureText = true,
        maxLines = 1,
        minLines = null,
        keyboardType = TextInputType.visiblePassword,
        autocorrect = false,
        enableSuggestions = false,
        super(key: key);

  /// 创建邮箱输入框
  const ZephyrInput.email({
    Key? key,
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.size = ZephyrSize.md,
    this.variant = ZephyrVariant.outline,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onFocusChange,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
    this.focusNode,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.theme,
  })  : type = ZephyrInputType.email,
        obscureText = false,
        maxLines = 1,
        minLines = null,
        keyboardType = TextInputType.emailAddress,
        super(key: key);

  /// 创建多行文本输入框
  const ZephyrInput.textarea({
    Key? key,
    this.controller,
    this.initialValue,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.size = ZephyrSize.md,
    this.variant = ZephyrVariant.outline,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.maxLines = 4,
    this.minLines = 3,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onFocusChange,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
    this.focusNode,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.theme,
  })  : type = ZephyrInputType.textarea,
        obscureText = false,
        keyboardType = TextInputType.multiline,
        super(key: key);

  /// 文本控制器
  final TextEditingController? controller;

  /// 初始值
  final String? initialValue;

  /// 标签
  final String? label;

  /// 占位符
  final String? placeholder;

  /// 帮助文本
  final String? helperText;

  /// 错误文本
  final String? errorText;

  /// 输入类型
  final ZephyrInputType type;

  /// 尺寸
  final ZephyrSize size;

  /// 变体
  final ZephyrVariant variant;

  /// 是否启用
  final bool enabled;

  /// 是否只读
  final bool readOnly;

  /// 是否必填
  final bool required;

  /// 是否隐藏文本
  final bool obscureText;

  /// 最大行数
  final int? maxLines;

  /// 最小行数
  final int? minLines;

  /// 最大长度
  final int? maxLength;

  /// 前缀图标
  final Widget? prefixIcon;

  /// 后缀图标
  final Widget? suffixIcon;

  /// 前缀组件
  final Widget? prefix;

  /// 后缀组件
  final Widget? suffix;

  /// 值变化回调
  final ValueChanged<String>? onChanged;

  /// 提交回调
  final ValueChanged<String>? onSubmitted;

  /// 点击回调
  final VoidCallback? onTap;

  /// 焦点变化回调
  final ValueChanged<bool>? onFocusChange;

  /// 验证器
  final String? Function(String?)? validator;

  /// 输入格式化器
  final List<TextInputFormatter>? inputFormatters;

  /// 键盘类型
  final TextInputType? keyboardType;

  /// 文本输入动作
  final TextInputAction? textInputAction;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 是否自动获取焦点
  final bool autofocus;

  /// 是否自动纠错
  final bool autocorrect;

  /// 是否启用建议
  final bool enableSuggestions;

  /// 主题
  final ZephyrInputTheme? theme;

  @override
  State<ZephyrInput> createState() => _ZephyrInputState();
}

class _ZephyrInputState extends State<ZephyrInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
    _errorText = widget.errorText;

    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(ZephyrInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      setState(() {
        _errorText = widget.errorText;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    final isFocused = _focusNode.hasFocus;
    if (_isFocused != isFocused) {
      setState(() {
        _isFocused = isFocused;
      });
      widget.onFocusChange?.call(isFocused);
    }
  }

  void _handleChanged(String value) {
    // 执行验证
    if (widget.validator != null) {
      final error = widget.validator!(value);
      if (_errorText != error) {
        setState(() {
          _errorText = error;
        });
      }
    }

    widget.onChanged?.call(value);
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? ZephyrInputTheme.of(context, widget.variant);
    final hasError = _errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) _buildLabel(context, effectiveTheme),
        _buildInputField(context, effectiveTheme, hasError),
        if (widget.helperText != null || hasError) _buildHelperText(context, effectiveTheme, hasError),
      ],
    );
  }

  /// 构建标签
  Widget _buildLabel(BuildContext context, ZephyrInputTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ZephyrSpacing.xs),
      child: RichText(
        text: TextSpan(
          text: widget.label!,
          style: theme.labelStyle,
          children: widget.required
              ? [
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: ZephyrColors.error500),
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  /// 构建输入框
  Widget _buildInputField(BuildContext context, ZephyrInputTheme theme, bool hasError) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscureText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType ?? _getKeyboardType(),
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      inputFormatters: widget.inputFormatters,
      onChanged: _handleChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      style: theme.textStyle,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: theme.placeholderStyle,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildSuffixIcon(),
        prefix: widget.prefix,
        suffix: widget.suffix,
        filled: true,
        fillColor: hasError ? theme.errorBackgroundColor : theme.backgroundColor,
        border: _buildBorder(theme, hasError),
        enabledBorder: _buildBorder(theme, hasError),
        focusedBorder: _buildBorder(theme, hasError, focused: true),
        errorBorder: _buildBorder(theme, true),
        focusedErrorBorder: _buildBorder(theme, true, focused: true),
        contentPadding: _getContentPadding(),
        counterText: '',
      ),
    );
  }

  /// 构建后缀图标
  Widget? _buildSuffixIcon() {
    if (widget.type == ZephyrInputType.password) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          size: 20,
        ),
        onPressed: _toggleObscureText,
      );
    }
    return widget.suffixIcon;
  }

  /// 构建边框
  InputBorder _buildBorder(ZephyrInputTheme theme, bool hasError, {bool focused = false}) {
    final color = hasError
        ? theme.errorBorderColor
        : focused
            ? theme.focusedBorderColor
            : theme.borderColor;

    switch (widget.variant) {
      case ZephyrVariant.outline:
        return OutlineInputBorder(
          borderRadius: theme.borderRadius,
          borderSide: BorderSide(color: color, width: focused ? 2 : 1),
        );
      case ZephyrVariant.neutral:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: focused ? 2 : 1),
        );
      default:
        return OutlineInputBorder(
          borderRadius: theme.borderRadius,
          borderSide: BorderSide(color: color, width: focused ? 2 : 1),
        );
    }
  }

  /// 构建帮助文本
  Widget _buildHelperText(BuildContext context, ZephyrInputTheme theme, bool hasError) {
    final text = hasError ? _errorText! : widget.helperText!;
    final style = hasError ? theme.errorTextStyle : theme.helperTextStyle;

    return Padding(
      padding: const EdgeInsets.only(top: ZephyrSpacing.xs),
      child: Text(text, style: style),
    );
  }

  /// 获取键盘类型
  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case ZephyrInputType.email:
        return TextInputType.emailAddress;
      case ZephyrInputType.number:
        return TextInputType.number;
      case ZephyrInputType.phone:
        return TextInputType.phone;
      case ZephyrInputType.url:
        return TextInputType.url;
      case ZephyrInputType.textarea:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  /// 获取内容边距
  EdgeInsets _getContentPadding() {
    switch (widget.size) {
      case ZephyrSize.xs:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 6);
      case ZephyrSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ZephyrSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ZephyrSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
      case ZephyrSize.xl:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
    }
  }
}
