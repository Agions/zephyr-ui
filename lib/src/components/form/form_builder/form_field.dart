import 'package:flutter/material.dart';
import 'form_validator.dart';

/// 表单字段类型
enum ZephyrFormFieldType {
  /// 文本输入
  text,
  
  /// 多行文本
  textarea,
  
  /// 密码输入
  password,
  
  /// 数字输入
  number,
  
  /// 邮箱输入
  email,
  
  /// 电话输入
  phone,
  
  /// 下拉选择
  select,
  
  /// 单选按钮组
  radio,
  
  /// 复选框组
  checkbox,
  
  /// 开关
  switchField,
  
  /// 滑块
  slider,
  
  /// 日期选择
  date,
  
  /// 时间选择
  time,
  
  /// 文件上传
  file,
  
  /// 富文本编辑器
  richText,
  
  /// 自定义组件
  custom,
}

/// 表单字段选项
class ZephyrFormFieldOption {
  /// 选项值
  final dynamic value;
  
  /// 选项标签
  final String label;
  
  /// 选项描述
  final String? description;
  
  /// 是否禁用
  final bool disabled;
  
  /// 附加数据
  final dynamic data;

  const ZephyrFormFieldOption({
    required this.value,
    required this.label,
    this.description,
    this.disabled = false,
    this.data,
  });
}

/// 表单字段配置
class ZephyrFormField {
  /// 字段名称
  final String name;
  
  /// 字段标签
  final String label;
  
  /// 字段类型
  final ZephyrFormFieldType type;
  
  /// 默认值
  final dynamic defaultValue;
  
  /// 占位符
  final String? placeholder;
  
  /// 帮助文本
  final String? helpText;
  
  /// 字段描述
  final String? description;
  
  /// 是否必填
  final bool required;
  
  /// 是否只读
  final bool readOnly;
  
  /// 是否禁用
  final bool disabled;
  
  /// 验证器列表
  final List<ZephyrFormValidator> validators;
  
  /// 选项列表（用于选择类字段）
  final List<ZephyrFormFieldOption>? options;
  
  /// 自定义组件构建器
  final Widget Function(
    String name,
    dynamic value,
    void Function(dynamic) onChanged,
    String? error,
  )? customBuilder;
  
  /// 前缀组件
  final Widget? prefix;
  
  /// 后缀组件
  final Widget? suffix;
  
  /// 字段可见性
  final bool Function(Map<String, dynamic> values)? visible;
  
  /// 字段启用性
  final bool Function(Map<String, dynamic> values)? enabled;
  
  /// 字段值变化回调
  final void Function(String name, dynamic value)? onChange;
  
  /// 字段失去焦点回调
  final void Function(String name, dynamic value)? onBlur;
  
  /// 附加数据
  final dynamic data;

  const ZephyrFormField({
    required this.name,
    required this.label,
    required this.type,
    this.defaultValue,
    this.placeholder,
    this.helpText,
    this.description,
    this.required = false,
    this.readOnly = false,
    this.disabled = false,
    this.validators = const [],
    this.options,
    this.customBuilder,
    this.prefix,
    this.suffix,
    this.visible,
    this.enabled,
    this.onChange,
    this.onBlur,
    this.data,
  });

  /// 获取字段验证器
  List<ZephyrFormValidator> get effectiveValidators {
    final validators = <ZephyrFormValidator>[];
    if (required) {
      validators.add(const ZephyrRequiredValidator());
    }
    validators.addAll(this.validators);
    return validators;
  }

  /// 验证字段值
  String? validate(dynamic value) {
    final compositeValidator = ZephyrCompositeValidator(effectiveValidators);
    return compositeValidator.validate(value);
  }

  /// 检查字段是否可见
  bool isVisible(Map<String, dynamic> values) {
    return visible?.call(values) ?? true;
  }

  /// 检查字段是否启用
  bool isEnabled(Map<String, dynamic> values) {
    if (disabled) return false;
    return enabled?.call(values) ?? true;
  }
}