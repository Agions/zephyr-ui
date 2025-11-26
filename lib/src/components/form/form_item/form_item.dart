import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// Zephyr表单项组件
///
/// 为表单字段提供统一的布局和验证功能，包括：
/// - 标签显示
/// - 必填标记
/// - 错误提示
/// - 帮助文本
/// - 验证逻辑
///
/// 示例用法:
/// ```dart
/// ZephyrFormItem(
///   label: '用户名',
///   required: true,
///   helperText: '请输入您的用户名',
///   validator: (value) {
///     if (value == null || value.isEmpty) {
///       return '用户名不能为空';
///     }
///     return null;
///   },
///   child: ZephyrInput(
///     placeholder: '请输入用户名',
///   ),
/// )
/// ```
class ZephyrFormItem extends StatefulWidget {
  /// 创建表单项
  const ZephyrFormItem({
    super.key,
    this.label,
    this.name,
    this.required = false,
    this.validator,
    this.helperText,
    this.errorText,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.theme,
    this.labelWidth,
    this.labelAlign,
    this.labelStyle,
    this.errorStyle,
    this.helperStyle,
    this.requiredMark = '*',
    this.showRequiredMark = true,
    this.layout = FormItemLayout.horizontal,
    this.contentFlex = 1,
    this.spacing = 8,
    this.child,
  });

  /// 标签文本
  final String? label;

  /// 字段名称
  final String? name;

  /// 是否必填
  final bool required;

  /// 验证函数
  final String? Function(dynamic)? validator;

  /// 帮助文本
  final String? helperText;

  /// 错误文本
  final String? errorText;

  /// 初始值
  final dynamic initialValue;

  /// 值变化回调
  final void Function(dynamic)? onChanged;

  /// 保存回调
  final void Function(dynamic)? onSaved;

  /// 主题
  final ZephyrFormItemTheme? theme;

  /// 标签宽度
  final double? labelWidth;

  /// 标签对齐方式
  final TextAlign? labelAlign;

  /// 标签样式
  final TextStyle? labelStyle;

  /// 错误样式
  final TextStyle? errorStyle;

  /// 帮助文本样式
  final TextStyle? helperStyle;

  /// 必填标记
  final String requiredMark;

  /// 是否显示必填标记
  final bool showRequiredMark;

  /// 布局方式
  final FormItemLayout layout;

  /// 内容区域弹性系数
  final int contentFlex;

  /// 间距
  final double spacing;

  /// 子组件
  final Widget? child;

  @override
  State<ZephyrFormItem> createState() => _ZephyrFormItemState();
}

class _ZephyrFormItemState extends State<ZephyrFormItem> {
  String? _errorText;
  dynamic _currentValue;
  bool _isTouched = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _registerWithForm();
  }

  void _registerWithForm() {
    if (widget.name != null) {
      final formState = ZephyrFormProvider.of(context);
      if (formState != null) {
        formState.setRequired(widget.name!, widget.required);
        formState.updateValue(widget.name!, widget.initialValue);
      }
    }
  }

  void _handleValueChanged(dynamic value) {
    setState(() {
      _currentValue = value;
      _isTouched = true;

      // 验证
      if (widget.validator != null) {
        _errorText = widget.validator!(value);
      }

      // 更新表单状态
      if (widget.name != null) {
        final formState = ZephyrFormProvider.of(context);
        if (formState != null) {
          formState.updateValue(widget.name!, value);
          formState.updateError(widget.name!, _errorText);
        }
      }

      // 触发回调
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    });
  }

  void _handleSaved(dynamic value) {
    if (widget.onSaved != null) {
      widget.onSaved!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrFormItemTheme.resolve(context, widget.theme);
    final formState = ZephyrFormProvider.of(context);

    // 从表单获取配置
    final labelWidth = widget.labelWidth ?? formState?.widget.labelWidth;
    final labelAlign = widget.labelAlign ?? formState?.widget.labelAlign;
    final showRequiredMark = widget.showRequiredMark && widget.required;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.layout == FormItemLayout.horizontal)
          _buildHorizontalLayout(
              effectiveTheme, labelWidth!, labelAlign!, showRequiredMark)
        else
          _buildVerticalLayout(effectiveTheme, showRequiredMark),
        if (_errorText != null || widget.errorText != null)
          _buildErrorText(effectiveTheme)
        else if (widget.helperText != null)
          _buildHelperText(effectiveTheme),
      ],
    );
  }

  Widget _buildHorizontalLayout(
    ZephyrFormItemTheme theme,
    double labelWidth,
    TextAlign labelAlign,
    bool showRequiredMark,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          SizedBox(
            width: labelWidth,
            child: _buildLabel(theme, labelAlign, showRequiredMark),
          ),
        SizedBox(width: widget.spacing),
        Expanded(
          flex: widget.contentFlex,
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildVerticalLayout(
    ZephyrFormItemTheme theme,
    bool showRequiredMark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          _buildLabel(theme, TextAlign.start, showRequiredMark),
        SizedBox(height: widget.spacing),
        _buildContent(),
      ],
    );
  }

  Widget _buildLabel(
    ZephyrFormItemTheme theme,
    TextAlign labelAlign,
    bool showRequiredMark,
  ) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.label,
            style: widget.labelStyle ?? theme.labelStyle,
          ),
          if (showRequiredMark)
            TextSpan(
              text: widget.requiredMark,
              style: widget.labelStyle?.copyWith(
                    color: theme.requiredColor,
                  ) ??
                  theme.labelStyle.copyWith(
                    color: theme.requiredColor,
                  ),
            ),
        ],
      ),
      textAlign: labelAlign,
    );
  }

  Widget _buildContent() {
    if (widget.child == null) {
      return const SizedBox.shrink();
    }

    // 为子组件包装表单字段
    return FormField<dynamic>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      onSaved: _handleSaved,
      builder: (field) {
        return _wrapChildWithCallbacks(widget.child!);
      },
    );
  }

  Widget _wrapChildWithCallbacks(Widget child) {
    // 根据子组件类型包装相应的回调
    if (child is ZephyrInput) {
      return ZephyrInput(
        placeholder: child.placeholder,
        initialValue: child.initialValue ?? widget.initialValue?.toString(),
        onChanged: (value) {
          _handleValueChanged(value);
          child.onChanged?.call(value);
        },
        onSubmitted: child.onSubmitted,
        validator: child.validator,
        prefixIcon: child.prefixIcon,
        suffixIcon: child.suffixIcon,
        prefixText: child.prefixText,
        suffixText: child.suffixText,
        obscureText: child.obscureText,
        enabled: child.enabled,
        readOnly: child.readOnly,
        maxLines: child.maxLines,
        maxLength: child.maxLength,
        keyboardType: child.keyboardType,
        textInputAction: child.textInputAction,
        autocorrect: child.autocorrect,
        enableSuggestions: child.enableSuggestions,
        autoFocus: child.autoFocus,
        focusNode: child.focusNode,
        controller: child.controller,
        theme: child.theme,
        errorText: _errorText ?? widget.errorText,
        helperText: child.helperText,
        counterText: child.counterText,
      );
    }

    // 处理 ZephyrInputNumber 组件
    if (child is ZephyrInputNumber) {
      return ZephyrInputNumber(
        placeholder: child.placeholder,
        initialValue: child.initialValue ?? widget.initialValue?.toDouble(),
        onChanged: (value) {
          _handleValueChanged(value);
          child.onChanged?.call(value);
        },
        onSubmitted: child.onSubmitted,
        validator: child.validator,
        min: child.min,
        max: child.max,
        step: child.step,
        precision: child.precision,
        enabled: child.enabled,
        readOnly: child.readOnly,
        showControls: child.showControls,
        autoFocus: child.autoFocus,
        focusNode: child.focusNode,
        controller: child.controller,
        theme: child.theme,
        errorText: _errorText ?? widget.errorText,
        helperText: child.helperText,
        prefix: child.prefix,
        suffix: child.suffix,
        format: child.format,
        parser: child.parser,
      );
    }

    // 其他类型的子组件可以在这里添加包装逻辑
    return child;
  }

  Widget _buildErrorText(ZephyrFormItemTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(top: theme.errorSpacing),
      child: Text(
        _errorText ?? widget.errorText ?? '',
        style: widget.errorStyle ?? theme.errorStyle,
      ),
    );
  }

  Widget _buildHelperText(ZephyrFormItemTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(top: theme.helperSpacing),
      child: Text(
        widget.helperText!,
        style: widget.helperStyle ?? theme.helperStyle,
      ),
    );
  }
}

/// 表单项布局方式
enum FormItemLayout {
  /// 水平布局（标签在左侧，内容在右侧）
  horizontal,

  /// 垂直布局（标签在上方，内容在下方）
  vertical,
}
