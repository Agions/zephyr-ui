import 'package:flutter/material.dart';

/// 单选按钮选项
class RadioOption<T> {
  final T value;
  final String label;
  final String? subtitle;
  final Widget? icon;
  final bool enabled;
  final VoidCallback? onTap;

  const RadioOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.enabled = true,
    this.onTap,
  });

  /// 创建便捷的构造函数
  factory RadioOption.fromMap(Map<String, dynamic> map) {
    return RadioOption(
      value: map['value'],
      label: map['label'] ?? '',
      subtitle: map['subtitle'],
      enabled: map['enabled'] ?? true,
    );
  }

  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'label': label,
      'subtitle': subtitle,
      'enabled': enabled,
    };
  }
}

/// 下拉选择选项
class SelectOption<T> {
  final T value;
  final String label;
  final String? subtitle;
  final Widget? icon;
  final bool enabled;
  final VoidCallback? onTap;
  final List<SelectOption<T>>? children;

  const SelectOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.enabled = true,
    this.onTap,
    this.children,
  });

  /// 创建便捷的构造函数
  factory SelectOption.fromMap(Map<String, dynamic> map) {
    return SelectOption(
      value: map['value'],
      label: map['label'] ?? '',
      subtitle: map['subtitle'],
      enabled: map['enabled'] ?? true,
      children: map['children']?.map<SelectOption<T>>((child) => SelectOption.fromMap(child)).toList(),
    );
  }

  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'label': label,
      'subtitle': subtitle,
      'enabled': enabled,
      'children': children?.map((child) => child.toMap()).toList(),
    };
  }

  /// 创建分组选项
  factory SelectOption.group({
    required String label,
    required List<SelectOption<T>> children,
    Widget? icon,
    bool enabled = true,
  }) {
    return SelectOption(
      value: label as T, // 分组使用label作为value
      label: label,
      icon: icon,
      enabled: enabled,
      children: children,
    );
  }
}

/// 复选框选项
class CheckboxOption<T> {
  final T value;
  final String label;
  final String? subtitle;
  final Widget? icon;
  final bool enabled;
  final bool selected;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onChanged;

  const CheckboxOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.enabled = true,
    this.selected = false,
    this.onTap,
    this.onChanged,
  });

  /// 创建便捷的构造函数
  factory CheckboxOption.fromMap(Map<String, dynamic> map) {
    return CheckboxOption(
      value: map['value'],
      label: map['label'] ?? '',
      subtitle: map['subtitle'],
      enabled: map['enabled'] ?? true,
      selected: map['selected'] ?? false,
    );
  }

  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'label': label,
      'subtitle': subtitle,
      'enabled': enabled,
      'selected': selected,
    };
  }

  /// 创建副本
  CheckboxOption<T> copyWith({
    T? value,
    String? label,
    String? subtitle,
    Widget? icon,
    bool? enabled,
    bool? selected,
    VoidCallback? onTap,
    ValueChanged<bool>? onChanged,
  }) {
    return CheckboxOption(
      value: value ?? this.value,
      label: label ?? this.label,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      enabled: enabled ?? this.enabled,
      selected: selected ?? this.selected,
      onTap: onTap ?? this.onTap,
      onChanged: onChanged ?? this.onChanged,
    );
  }
}

/// 选项组工具类
class OptionUtils {
  /// 过滤启用的选项
  static List<T> filterEnabled<T extends RadioOption>(List<T> options) {
    return options.where((option) => option.enabled).toList();
  }

  /// 过滤选中的选项
  static List<T> filterSelected<T extends CheckboxOption>(List<T> options) {
    return options.where((option) => option.selected).toList();
  }

  /// 获取选中的值
  static List<dynamic> getSelectedValues<T extends CheckboxOption>(List<T> options) {
    return options.where((option) => option.selected).map((option) => option.value).toList();
  }

  /// 设置选中状态
  static List<dynamic> setSelected<T extends CheckboxOption>(
    List<T> options,
    Set<T> selectedValues,
  ) {
    return options.map((option) {
      return option.copyWith(
        selected: selectedValues.contains(option),
      );
    }).toList();
  }

  /// 查找选项
  static T? findOption<T extends RadioOption>(List<T> options, dynamic value) {
    try {
      return options.firstWhere((option) => option.value == value);
    } catch (e) {
      return null;
    }
  }

  /// 转换选项类型
  static List<SelectOption<R>> convertOptions<T, R>(
    List<T> options,
    R Function(T) converter,
    String Function(T) labelExtractor,
  ) {
    return options.map((option) {
      return SelectOption<R>(
        value: converter(option),
        label: labelExtractor(option),
      );
    }).toList();
  }
}