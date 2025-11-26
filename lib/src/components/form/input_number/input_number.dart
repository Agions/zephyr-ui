import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import 'input_number_theme.dart';

/// Zephyr数字输入框组件
///
/// 专门用于数字输入，支持：
/// - 数字键盘
/// - 步进器控制
/// - 数值范围限制
/// - 格式化显示
/// - 增减按钮
///
/// 示例用法:
/// ```dart
/// ZephyrInputNumber(
///   placeholder: '请输入数量',
///   min: 0,
///   max: 100,
///   step: 1,
///   precision: 0,
///   onChanged: (value) => debugPrint(value),
/// )
/// ```
class ZephyrInputNumber extends StatefulWidget {
  /// 创建数字输入框
  const ZephyrInputNumber({
    super.key,
    this.placeholder,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.min,
    this.max,
    this.step = 1,
    this.precision = 0,
    this.enabled = true,
    this.readOnly = false,
    this.showControls = true,
    this.autoFocus = false,
    this.focusNode,
    this.controller,
    this.theme,
    this.errorText,
    this.helperText,
    this.prefix,
    this.suffix,
    this.format,
    this.parser,
  });

  /// 占位符文本
  final String? placeholder;

  /// 初始值
  final double? initialValue;

  /// 值变化回调
  final ValueChanged<double>? onChanged;

  /// 提交回调
  final ValueChanged<double>? onSubmitted;

  /// 验证函数
  final String? Function(double?)? validator;

  /// 最小值
  final double? min;

  /// 最大值
  final double? max;

  /// 步进值
  final double step;

  /// 小数精度
  final int precision;

  /// 是否启用
  final bool enabled;

  /// 是否只读
  final bool readOnly;

  /// 是否显示控制按钮
  final bool showControls;

  /// 自动聚焦
  final bool autoFocus;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 文本控制器
  final TextEditingController? controller;

  /// 主题
  final ZephyrInputNumberTheme? theme;

  /// 错误文本
  final String? errorText;

  /// 帮助文本
  final String? helperText;

  /// 前缀组件
  final Widget? prefix;

  /// 后缀组件
  final Widget? suffix;

  /// 格式化函数
  final String Function(double)? format;

  /// 解析函数
  final double? Function(String)? parser;

  @override
  State<ZephyrInputNumber> createState() => _ZephyrInputNumberState();
}

class _ZephyrInputNumberState extends State<ZephyrInputNumber> {
  late TextEditingController _controller;
  FocusNode? _focusNode;
  double? _currentValue;
  String? _errorText;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = widget.controller ??
        TextEditingController(
          text: _formatValue(widget.initialValue),
        );
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
    final text = _controller.text;
    if (text.isEmpty) {
      _updateValue(null);
      return;
    }

    final value = _parseValue(text);
    if (value != null) {
      _updateValue(value);
    }
  }

  void _updateValue(double? value) {
    // 范围检查
    if (value != null) {
      if (widget.min != null && value < widget.min!) {
        value = widget.min;
      }
      if (widget.max != null && value! > widget.max!) {
        value = widget.max;
      }
    }

    setState(() {
      _currentValue = value;

      // 验证
      if (widget.validator != null) {
        _errorText = widget.validator!(value);
      }

      // 更新文本
      _controller.text = _formatValue(value);

      // 触发回调
      if (widget.onChanged != null) {
        widget.onChanged!(value ?? 0);
      }
    });
  }

  String _formatValue(double? value) {
    if (value == null) return '';

    if (widget.format != null) {
      return widget.format!(value);
    }

    return value.toStringAsFixed(widget.precision);
  }

  double? _parseValue(String text) {
    if (widget.parser != null) {
      return widget.parser!(text);
    }

    return double.tryParse(text);
  }

  void _increment() {
    if (_currentValue == null) {
      _updateValue(widget.min ?? 0);
    } else {
      _updateValue(_currentValue! + widget.step);
    }
  }

  void _decrement() {
    if (_currentValue == null) {
      _updateValue(widget.min ?? 0);
    } else {
      _updateValue(_currentValue! - widget.step);
    }
  }

  bool _canIncrement() {
    if (_currentValue == null) {
      return widget.min == null || widget.min! < double.infinity;
    }
    if (widget.max != null) return _currentValue! < widget.max!;
    return true;
  }

  bool _canDecrement() {
    if (_currentValue == null) {
      return widget.min == null || widget.min! > double.negativeInfinity;
    }
    if (widget.min != null) return _currentValue! > widget.min!;
    return true;
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
    final effectiveTheme =
        ZephyrInputNumberTheme.resolve(context, widget.theme);

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

  Widget _buildInputField(ZephyrInputNumberTheme theme) {
    final isError = widget.errorText != null || _errorText != null;
    final fillColor = _getFillColor(theme, isError);
    final borderColor = _getBorderColor(theme, isError);

    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(
          color: borderColor,
          width: _getBorderWidth(theme, isError),
        ),
        borderRadius: const BorderRadius.circular(theme.borderRadius),
      ),
      child: Row(
        children: [
          if (widget.prefix != null)
            Padding(
              padding: theme.prefixPadding,
              child: widget.prefix,
            ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              autofocus: widget.autoFocus,
              keyboardType: TextInputType.numberWithOptions(
                decimal: widget.precision > 0,
                signed: widget.min != null && widget.min! < 0,
              ),
              style: TextStyle(
                color:
                    widget.enabled ? theme.textColor : theme.disabledTextColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: theme.placeholderStyle,
                border: InputBorder.none,
                contentPadding: theme.contentPadding,
                isDense: true,
              ),
              onSubmitted: (value) {
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!(_currentValue ?? 0);
                }
              },
            ),
          ),
          if (widget.suffix != null)
            Padding(
              padding: theme.suffixPadding,
              child: widget.suffix,
            ),
          if (widget.showControls && widget.enabled && !widget.readOnly)
            _buildControls(theme),
        ],
      ),
    );
  }

  Widget _buildControls(ZephyrInputNumberTheme theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControlButton(
          icon: Icons.keyboard_arrow_up,
          onPressed: _canIncrement() ? _increment : null,
          theme: theme,
        ),
        SizedBox(height: theme.controlSpacing),
        _buildControlButton(
          icon: Icons.keyboard_arrow_down,
          onPressed: _canDecrement() ? _decrement : null,
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required ZephyrInputNumberTheme theme,
  }) {
    final isEnabled = onPressed != null;

    return Container(
      width: theme.controlSize,
      height: theme.controlSize,
      decoration: BoxDecoration(
        color: isEnabled
            ? theme.controlBackgroundColor
            : theme.disabledControlBackgroundColor,
        borderRadius: const BorderRadius.circular(theme.controlBorderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: const BorderRadius.circular(theme.controlBorderRadius),
          child: Icon(
            icon,
            size: theme.controlIconSize,
            color: isEnabled
                ? theme.controlIconColor
                : theme.disabledControlIconColor,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorText(ZephyrInputNumberTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(top: theme.errorSpacing),
      child: Text(
        widget.errorText ?? _errorText ?? '',
        style: theme.errorStyle,
      ),
    );
  }

  Widget _buildHelperText(ZephyrInputNumberTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(top: theme.helperSpacing),
      child: Text(
        widget.helperText!,
        style: theme.helperStyle,
      ),
    );
  }

  Color _getFillColor(ZephyrInputNumberTheme theme, bool isError) {
    if (!widget.enabled) return theme.disabledFillColor;
    if (isError) return theme.errorFillColor;
    if (_isFocused) return theme.focusedFillColor;
    return theme.fillColor;
  }

  Color _getBorderColor(ZephyrInputNumberTheme theme, bool isError) {
    if (!widget.enabled) return theme.disabledBorderColor;
    if (isError) return theme.errorColor;
    if (_isFocused) return theme.focusedBorderColor;
    return theme.borderColor;
  }

  double _getBorderWidth(ZephyrInputNumberTheme theme, bool isError) {
    if (!widget.enabled) return theme.disabledBorderWidth;
    if (isError) return theme.errorBorderWidth;
    if (_isFocused) return theme.focusedBorderWidth;
    return theme.borderWidth;
  }
}
