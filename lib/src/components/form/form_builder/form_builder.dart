import 'package:flutter/material.dart';
import 'form_builder_theme.dart';
import 'form_field.dart';

/// 表单状态
class ZephyrFormState {
  /// 字段值
  final Map<String, dynamic> values;
  
  /// 字段错误信息
  final Map<String, String?> errors;
  
  /// 字段触摸状态
  final Map<String, bool> touched;
  
  /// 表单是否有效
  final bool isValid;
  
  /// 表单是否提交中
  final bool isSubmitting;

  const ZephyrFormState({
    required this.values,
    required this.errors,
    required this.touched,
    required this.isValid,
    required this.isSubmitting,
  });

  /// 创建初始状态
  factory ZephyrFormState.initial(List<ZephyrFormField> fields) {
    final values = <String, dynamic>{};
    final errors = <String, String?>{};
    final touched = <String, bool>{};

    for (final field in fields) {
      values[field.name] = field.defaultValue;
      errors[field.name] = '';
      touched[field.name] = false;
    }

    return ZephyrFormState(
      values: values,
      errors: errors,
      touched: touched,
      isValid: true,
      isSubmitting: false,
    );
  }

  /// 复制并修改状态
  ZephyrFormState copyWith({
    Map<String, dynamic>? values,
    Map<String, String?>? errors,
    Map<String, bool>? touched,
    bool? isValid,
    bool? isSubmitting,
  }) {
    return ZephyrFormState(
      values: values ?? this.values,
      errors: errors ?? this.errors,
      touched: touched ?? this.touched,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

/// ZephyrUI 动态表单构建器
///
/// 一个功能强大的动态表单构建器，支持多种字段类型、验证规则、条件逻辑等。
///
/// 特性：
/// - 支持多种字段类型（文本、选择、日期、文件等）
/// - 内置验证规则（必填、长度、邮箱、数字等）
/// - 条件字段显示和启用
/// - 自定义字段组件
/// - 响应式设计
/// - 实时验证
/// - 主题支持
///
/// 示例用法：
/// ```dart
/// ZephyrFormBuilder(
///   fields: [
///     ZephyrFormField(
///       name: 'username',
///       label: '用户名',
///       type: ZephyrFormFieldType.text,
///       required: true,
///       validators: [
///         ZephyrLengthValidator(minLength: 3, maxLength: 20),
///       ],
///     ),
///     ZephyrFormField(
///       name: 'email',
///       label: '邮箱',
///       type: ZephyrFormFieldType.email,
///       required: true,
///     ),
///   ],
///   onSubmit: (values) {
///     print('表单提交: $values');
///   },
/// )
/// ```
class ZephyrFormBuilder extends StatefulWidget {
  /// 表单字段列表
  final List<ZephyrFormField> fields;
  
  /// 表单提交回调
  final Function(Map<String, dynamic> values) onSubmit;
  
  /// 表单值变化回调
  final Function(Map<String, dynamic> values) onChange;
  
  /// 表单字段变化回调
  final Function(String name, dynamic value) onFieldChange;
  
  /// 表单验证回调
  final Function(bool isValid, Map<String, String?> errors) onValidate;
  
  /// 主题数据
  final ZephyrFormBuilderTheme? theme;
  
  /// 是否自动验证
  final bool autoValidate;
  
  /// 是否显示描述
  final bool showDescription;
  
  /// 是否显示帮助文本
  final bool showHelpText;
  
  /// 布局方式
  final Axis layoutDirection;
  
  /// 字段间距
  final double? fieldSpacing;
  
  /// 提交按钮文本
  final String submitText;
  
  /// 重置按钮文本
  final String resetText;
  
  /// 是否显示提交按钮
  final bool showSubmitButton;
  
  /// 是否显示重置按钮
  final bool showResetButton;
  
  /// 提交按钮样式
  final ButtonStyle? submitButtonStyle;
  
  /// 重置按钮样式
  final ButtonStyle? resetButtonStyle;
  
  /// 创建表单构建器
  const ZephyrFormBuilder({
    Key? key,
    required this.fields,
    required this.onSubmit,
    required this.onChange,
    required this.onFieldChange,
    required this.onValidate,
    this.theme,
    this.autoValidate = true,
    this.showDescription = true,
    this.showHelpText = true,
    this.layoutDirection = Axis.vertical,
    this.fieldSpacing,
    this.submitText = '提交',
    this.resetText = '重置',
    this.showSubmitButton = true,
    this.showResetButton = false,
    this.submitButtonStyle,
    this.resetButtonStyle,
  }) : super(key: key);

  @override
  State<ZephyrFormBuilder> createState() => _ZephyrFormBuilderState();
}

class _ZephyrFormBuilderState extends State<ZephyrFormBuilder> {
  late ZephyrFormBuilderTheme _theme;
  late ZephyrFormState _formState;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrFormBuilderTheme.light();
    _formState = ZephyrFormState.initial(widget.fields);
  }

  @override
  void didUpdateWidget(ZephyrFormBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrFormBuilderTheme.light();
    }
  }

  void _updateFieldValue(String name, dynamic value) {
    setState(() {
      final newValues = Map<String, dynamic>.from(_formState.values);
      newValues[name] = value;
      
      final newErrors = Map<String, String?>.from(_formState.errors);
      if (widget.autoValidate) {
        final field = widget.fields.firstWhere((f) => f.name == name);
        newErrors[name] = field.validate(value) ?? '';
      }
      
      final newTouched = Map<String, bool>.from(_formState.touched);
      newTouched[name] = true;
      
      _formState = _formState.copyWith(
        values: newValues,
        errors: newErrors,
        touched: newTouched,
      );
    });

    widget.onFieldChange(name, value);
    widget.onChange(_formState.values);
  }

  void _validateField(String name) {
    final field = widget.fields.firstWhere((f) => f.name == name);
    final error = field.validate(_formState.values[name]);
    
    setState(() {
      final newErrors = Map<String, String?>.from(_formState.errors);
      newErrors[name] = error ?? '';
      _formState = _formState.copyWith(errors: newErrors);
    });
  }

  bool _validateForm() {
    final errors = <String, String?>{};
    var isValid = true;

    for (final field in widget.fields) {
      if (field.isVisible(_formState.values)) {
        final error = field.validate(_formState.values[field.name]);
        if (error != null) {
          errors[field.name] = error;
          isValid = false;
        }
      }
    }

    setState(() {
      _formState = _formState.copyWith(
        errors: errors,
        isValid: isValid,
      );
    });

    widget.onValidate(isValid, errors);
    return isValid;
  }

  Future<void> _submitForm() async {
    if (!_validateForm()) return;

    setState(() {
      _formState = _formState.copyWith(isSubmitting: true);
    });

    try {
      await widget.onSubmit(_formState.values);
    } finally {
      setState(() {
        _formState = _formState.copyWith(isSubmitting: false);
      });
    }
  }

  void _resetForm() {
    setState(() {
      _formState = ZephyrFormState.initial(widget.fields);
    });
    widget.onChange(_formState.values);
  }

  Widget _buildField(ZephyrFormField field) {
    if (!field.isVisible(_formState.values)) {
      return const SizedBox.shrink();
    }

    final isEnabled = field.isEnabled(_formState.values);
    final error = _formState.errors[field.name] ?? '';
    final value = _formState.values[field.name];

    return Padding(
      padding: EdgeInsets.only(bottom: widget.fieldSpacing ?? _theme.fieldSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标签
          Row(
            children: [
              Text(
                field.label,
                style: _theme.labelStyle.copyWith(
                  color: isEnabled 
                      ? _theme.labelStyle.color 
                      : _theme.disabledColor,
                ),
              ),
              if (field.required) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: _theme.labelStyle.copyWith(
                    color: _theme.errorColor,
                  ),
                ),
              ],
            ],
          ),
          
          if (widget.showDescription && field.description != null) ...[
            const SizedBox(height: 4),
            Text(
              field.description!,
              style: _theme.descriptionStyle,
            ),
          ],
          
          const SizedBox(height: 8),
          
          // 字段组件
          _buildFieldWidget(field, value, error, isEnabled),
          
          if (widget.showHelpText && field.helpText != null) ...[
            const SizedBox(height: 4),
            Text(
              field.helpText!,
              style: _theme.helpStyle,
            ),
          ],
          
          if (error.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              error,
              style: _theme.errorStyle,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFieldWidget(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    // 如果有自定义构建器，使用自定义构建器
    if (field.customBuilder != null) {
      return field.customBuilder!(
        field.name,
        value,
        (newValue) => _updateFieldValue(field.name, newValue),
        error.isNotEmpty ? error : null,
      );
    }

    // 根据字段类型构建对应的组件
    switch (field.type) {
      case ZephyrFormFieldType.text:
      case ZephyrFormFieldType.email:
      case ZephyrFormFieldType.phone:
      case ZephyrFormFieldType.password:
        return _buildTextField(field, value, error, isEnabled);
      
      case ZephyrFormFieldType.textarea:
        return _buildTextAreaField(field, value, error, isEnabled);
      
      case ZephyrFormFieldType.number:
        return _buildNumberField(field, value, error, isEnabled);
      
      case ZephyrFormFieldType.select:
        return _buildSelectField(field, value, error, isEnabled);
      
      case ZephyrFormFieldType.radio:
        return _buildRadioField(field, value, error, isEnabled);
      
      case ZephyrFormFieldType.checkbox:
        return _buildCheckboxField(field, value, error, isEnabled);
      
      case ZephyrFormFieldType.switchField:
        return _buildSwitchField(field, value, error, isEnabled);
      
      case ZephyrFormFieldType.slider:
        return _buildSliderField(field, value, error, isEnabled);
      
      case ZephyrFormFieldType.date:
        return _buildDateField(field, value, error, isEnabled);
      
      case ZephyrFormFieldType.time:
        return _buildTimeField(field, value, error, isEnabled);
      
      default:
        return _buildTextField(field, value, error, isEnabled);
    }
  }

  Widget _buildTextField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return TextField(
      enabled: isEnabled,
      controller: TextEditingController(text: value?.toString() ?? ''),
      obscureText: field.type == ZephyrFormFieldType.password,
      keyboardType: field.type == ZephyrFormFieldType.email
          ? TextInputType.emailAddress
          : field.type == ZephyrFormFieldType.phone
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
        hintText: field.placeholder,
        border: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.borderColor,
            width: _theme.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.focusColor,
            width: _theme.borderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: _theme.errorColor,
            width: _theme.borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: _theme.errorColor,
            width: _theme.borderWidth,
          ),
        ),
        prefixIcon: field.prefix,
        suffixIcon: field.suffix,
      ),
      style: _theme.inputStyle,
      onChanged: (newValue) => _updateFieldValue(field.name, newValue),
      onEditingComplete: () => _validateField(field.name),
    );
  }

  Widget _buildTextAreaField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return TextField(
      enabled: isEnabled,
      controller: TextEditingController(text: value?.toString() ?? ''),
      maxLines: 3,
      decoration: InputDecoration(
        hintText: field.placeholder,
        border: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.borderColor,
            width: _theme.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.focusColor,
            width: _theme.borderWidth,
          ),
        ),
      ),
      style: _theme.inputStyle,
      onChanged: (newValue) => _updateFieldValue(field.name, newValue),
      onEditingComplete: () => _validateField(field.name),
    );
  }

  Widget _buildNumberField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return TextField(
      enabled: isEnabled,
      controller: TextEditingController(text: value?.toString() ?? ''),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: field.placeholder,
        border: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.borderColor,
            width: _theme.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.focusColor,
            width: _theme.borderWidth,
          ),
        ),
      ),
      style: _theme.inputStyle,
      onChanged: (newValue) {
        final number = double.tryParse(newValue);
        _updateFieldValue(field.name, number);
      },
      onEditingComplete: () => _validateField(field.name),
    );
  }

  Widget _buildSelectField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return DropdownButtonFormField<dynamic>(
      value: value,
      items: field.options?.map((option) {
        return DropdownMenuItem<dynamic>(
          value: option.value,
          child: Text(option.label),
        );
      }).toList(),
      onChanged: isEnabled ? (newValue) {
        _updateFieldValue(field.name, newValue);
      } : null,
      decoration: InputDecoration(
        hintText: field.placeholder,
        border: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.borderColor,
            width: _theme.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.focusColor,
            width: _theme.borderWidth,
          ),
        ),
      ),
      style: _theme.inputStyle,
    );
  }

  Widget _buildRadioField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return Column(
      children: field.options?.map((option) {
        return RadioListTile<dynamic>(
          title: Text(option.label),
          value: option.value,
          groupValue: value,
          onChanged: isEnabled ? (newValue) {
            _updateFieldValue(field.name, newValue);
          } : null,
          activeColor: _theme.primaryColor,
        );
      }).toList() ?? [],
    );
  }

  Widget _buildCheckboxField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return Column(
      children: field.options?.map((option) {
        return CheckboxListTile(
          title: Text(option.label),
          value: (value as List?)?.contains(option.value) ?? false,
          onChanged: isEnabled ? (newValue) {
            final currentValues = List<dynamic>.from(value ?? []);
            if (newValue == true) {
              currentValues.add(option.value);
            } else {
              currentValues.remove(option.value);
            }
            _updateFieldValue(field.name, currentValues);
          } : null,
          activeColor: _theme.primaryColor,
        );
      }).toList() ?? [],
    );
  }

  Widget _buildSwitchField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return Switch(
      value: value ?? false,
      onChanged: isEnabled ? (newValue) {
        _updateFieldValue(field.name, newValue);
      } : null,
      activeColor: _theme.primaryColor,
    );
  }

  Widget _buildSliderField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return Slider(
      value: (value as num?)?.toDouble() ?? 0.0,
      onChanged: isEnabled ? (newValue) {
        _updateFieldValue(field.name, newValue);
      } : null,
      activeColor: _theme.primaryColor,
    );
  }

  Widget _buildDateField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return TextField(
      enabled: isEnabled,
      controller: TextEditingController(text: value?.toString() ?? ''),
      readOnly: true,
      decoration: InputDecoration(
        hintText: field.placeholder,
        border: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.borderColor,
            width: _theme.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.focusColor,
            width: _theme.borderWidth,
          ),
        ),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      style: _theme.inputStyle,
      onTap: isEnabled ? () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          _updateFieldValue(field.name, date);
        }
      } : null,
    );
  }

  Widget _buildTimeField(
    ZephyrFormField field,
    dynamic value,
    String error,
    bool isEnabled,
  ) {
    return TextField(
      enabled: isEnabled,
      controller: TextEditingController(text: value?.toString() ?? ''),
      readOnly: true,
      decoration: InputDecoration(
        hintText: field.placeholder,
        border: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.borderColor,
            width: _theme.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _theme.borderRadius,
          borderSide: BorderSide(
            color: error.isNotEmpty 
                ? _theme.errorColor 
                : _theme.focusColor,
            width: _theme.borderWidth,
          ),
        ),
        suffixIcon: const Icon(Icons.access_time),
      ),
      style: _theme.inputStyle,
      onTap: isEnabled ? () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          _updateFieldValue(field.name, time);
        }
      } : null,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.showResetButton) ...[
          TextButton(
            onPressed: _formState.isSubmitting ? null : _resetForm,
            style: widget.resetButtonStyle,
            child: Text(widget.resetText),
          ),
          const SizedBox(width: 16),
        ],
        if (widget.showSubmitButton)
          ElevatedButton(
            onPressed: _formState.isSubmitting ? null : _submitForm,
            style: widget.submitButtonStyle,
            child: _formState.isSubmitting
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : Text(widget.submitText),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: _theme.borderRadius,
        border: Border.all(
          color: _theme.borderColor,
          width: _theme.borderWidth,
        ),
      ),
      padding: _theme.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 表单字段
          ...widget.fields.map(_buildField).toList(),
          
          // 操作按钮
          if (widget.showSubmitButton || widget.showResetButton) ...[
            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ],
      ),
    );
  }
}