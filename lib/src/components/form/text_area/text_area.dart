/// ZephyrUI 文本域组件
///
/// 提供专用的多行文本输入功能，支持自动高度调整、字符计数等功能。
library text_area;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import 'text_area_theme.dart';

/// ZephyrUI 文本域组件
///
/// 一个功能丰富的多行文本输入组件，支持自动高度、字符计数等功能。
///
/// 示例用法:
/// ```dart
/// ZephyrTextArea(
///   label: '描述',
///   placeholder: '请输入详细描述...',
///   minLines: 3,
///   maxLines: 10,
///   maxLength: 500,
///   onChanged: (value) => print(value),
/// )
/// ```
class ZephyrTextArea extends StatefulWidget {
  /// 创建一个文本域组件
  const ZephyrTextArea({
    super.key,
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
    this.minLines = 3,
    this.maxLines = 10,
    this.maxLength,
    this.autoHeight = true,
    this.showCharacterCount = false,
    this.expands = false,
    this.alignLabelWithHint = false,
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
    this.scrollController,
    this.scrollPhysics,
    this.theme,
  });

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

  /// 最小行数
  final int minLines;

  /// 最大行数
  final int maxLines;

  /// 最大字符数
  final int? maxLength;

  /// 是否自动调整高度
  final bool autoHeight;

  /// 是否显示字符计数
  final bool showCharacterCount;

  /// 是否填充可用空间
  final bool expands;

  /// 标签是否与提示对齐
  final bool alignLabelWithHint;

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

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 滚动物理特性
  final ScrollPhysics? scrollPhysics;

  /// 主题
  final ZephyrTextAreaTheme? theme;

  @override
  State<ZephyrTextArea> createState() => _ZephyrTextAreaState();
}

class _ZephyrTextAreaState extends State<ZephyrTextArea> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;
  int _currentLength = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _currentLength = _controller.text.length;
    _errorText = widget.errorText;

    _controller.addListener(_handleTextChange);
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(ZephyrTextArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      setState(() {
        _errorText = widget.errorText;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _focusNode.removeListener(_handleFocusChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleTextChange() {
    final newLength = _controller.text.length;
    if (newLength != _currentLength) {
      setState(() {
        _currentLength = newLength;
      });
    }
    _handleChanged(_controller.text);
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

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? ZephyrTextAreaTheme.of(context, widget.variant);
    final hasError = _errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) _buildLabel(context, effectiveTheme),
        _buildTextArea(context, effectiveTheme, hasError),
        if (widget.helperText != null || hasError || widget.showCharacterCount) 
          _buildFooter(context, effectiveTheme, hasError),
      ],
    );
  }

  /// 构建标签
  Widget _buildLabel(BuildContext context, ZephyrTextAreaTheme theme) {
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

  /// 构建文本域
  Widget _buildTextArea(BuildContext context, ZephyrTextAreaTheme theme, bool hasError) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.autoHeight ? null : widget.maxLines,
      minLines: widget.autoHeight ? widget.minLines : null,
      maxLength: widget.maxLength,
      expands: widget.expands,
      keyboardType: TextInputType.multiline,
      textInputAction: widget.textInputAction ?? TextInputAction.newline,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      inputFormatters: widget.inputFormatters,
      onChanged: _handleChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      style: theme.textStyle,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: theme.placeholderStyle,
        prefix: widget.prefix,
        suffix: widget.suffix,
        filled: true,
        fillColor: hasError ? theme.errorBackgroundColor : theme.backgroundColor,
        border: _buildBorder(theme, hasError),
        enabledBorder: _buildBorder(theme, hasError),
        focusedBorder: _buildBorder(theme, hasError, focused: true),
        errorBorder: _buildBorder(theme, true),
        focusedErrorBorder: _buildBorder(theme, true, focused: true),
        disabledBorder: _buildBorder(theme, hasError, disabled: true),
        contentPadding: _getContentPadding(),
        counterText: '',
        alignLabelWithHint: widget.alignLabelWithHint,
      ),
    );
  }

  /// 构建页脚（帮助文本和字符计数）
  Widget _buildFooter(BuildContext context, ZephyrTextAreaTheme theme, bool hasError) {
    return Padding(
      padding: const EdgeInsets.only(top: ZephyrSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.helperText != null || hasError)
            Expanded(
              child: _buildHelperText(theme, hasError),
            ),
          if (widget.showCharacterCount && widget.maxLength != null) ...[
            const SizedBox(width: 8),
            _buildCharacterCount(theme, hasError),
          ],
        ],
      ),
    );
  }

  /// 构建帮助文本
  Widget _buildHelperText(ZephyrTextAreaTheme theme, bool hasError) {
    final text = hasError ? _errorText! : widget.helperText!;
    final style = hasError ? theme.errorTextStyle : theme.helperTextStyle;

    return Text(
      text,
      style: style,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 构建字符计数
  Widget _buildCharacterCount(ZephyrTextAreaTheme theme, bool hasError) {
    final isNearLimit = widget.maxLength != null && _currentLength > widget.maxLength! * 0.9;
    final isOverLimit = widget.maxLength != null && _currentLength > widget.maxLength!;
    
    final textStyle = hasError || isOverLimit
        ? theme.errorTextStyle
        : isNearLimit
            ? theme.warningTextStyle
            : theme.characterCountStyle;

    return Text(
      '$_currentLength/${widget.maxLength}',
      style: textStyle,
    );
  }

  /// 构建边框
  InputBorder _buildBorder(ZephyrTextAreaTheme theme, bool hasError, {
    bool focused = false,
    bool disabled = false,
  }) {
    final color = hasError
        ? theme.errorBorderColor
        : disabled
            ? theme.disabledBorderColor
            : focused
                ? theme.focusedBorderColor
                : theme.borderColor;

    switch (widget.variant) {
      case ZephyrVariant.outline:
        return OutlineInputBorder(
          borderRadius: theme.borderRadius,
          borderSide: const BorderSide(color: color, width: focused ? 2 : 1),
        );
      case ZephyrVariant.neutral:
        return UnderlineInputBorder(
          borderSide: const BorderSide(color: color, width: focused ? 2 : 1),
        );
      default:
        return OutlineInputBorder(
          borderRadius: theme.borderRadius,
          borderSide: const BorderSide(color: color, width: focused ? 2 : 1),
        );
    }
  }

  /// 获取内容边距
  EdgeInsets _getContentPadding() {
    switch (widget.size) {
      case ZephyrSize.xs:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 8);
      case ZephyrSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
      case ZephyrSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ZephyrSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
      case ZephyrSize.xl:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
    }
  }
}