import 'package:flutter/material.dart';

/// ZephyrUI 表单构建器主题配置
///
/// 定义表单构建器组件的视觉样式，包括颜色、字体、边框等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrFormBuilderTheme {
  /// 背景颜色
  final Color backgroundColor;
  
  /// 边框颜色
  final Color borderColor;
  
  /// 边框宽度
  final double borderWidth;
  
  /// 边框圆角
  final BorderRadius borderRadius;
  
  /// 内边距
  final EdgeInsets padding;
  
  /// 字段间距
  final double fieldSpacing;
  
  /// 标签文本样式
  final TextStyle labelStyle;
  
  /// 输入框文本样式
  final TextStyle inputStyle;
  
  /// 占位符文本样式
  final TextStyle placeholderStyle;
  
  /// 帮助文本样式
  final TextStyle helpStyle;
  
  /// 错误文本样式
  final TextStyle errorStyle;
  
  /// 描述文本样式
  final TextStyle descriptionStyle;
  
  /// 主色调
  final Color primaryColor;
  
  /// 错误颜色
  final Color errorColor;
  
  /// 成功颜色
  final Color successColor;
  
  /// 警告颜色
  final Color warningColor;
  
  /// 禁用状态颜色
  final Color disabledColor;
  
  /// 焦点颜色
  final Color focusColor;
  
  /// 悬停颜色
  final Color hoverColor;
  
  /// 创建表单构建器主题
  const ZephyrFormBuilderTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.fieldSpacing,
    required this.labelStyle,
    required this.inputStyle,
    required this.placeholderStyle,
    required this.helpStyle,
    required this.errorStyle,
    required this.descriptionStyle,
    required this.primaryColor,
    required this.errorColor,
    required this.successColor,
    required this.warningColor,
    required this.disabledColor,
    required this.focusColor,
    required this.hoverColor,
  });
  
  /// 创建明亮的表单构建器主题
  factory ZephyrFormBuilderTheme.light() {
    return ZephyrFormBuilderTheme(
      backgroundColor: Colors.white,
      borderColor: const Color(0xFFE5E7EB),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(8.0),
      padding: const EdgeInsets.all(24.0),
      fieldSpacing: 16.0,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF374151),
      ),
      inputStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF111827),
      ),
      placeholderStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      helpStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      errorStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFFEF4444),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      primaryColor: const Color(0xFF3B82F6),
      errorColor: const Color(0xFFEF4444),
      successColor: const Color(0xFF10B981),
      warningColor: const Color(0xFFF59E0B),
      disabledColor: const Color(0xFFD1D5DB),
      focusColor: const Color(0xFF3B82F6),
      hoverColor: const Color(0xFFE5E7EB),
    );
  }
  
  /// 创建暗色的表单构建器主题
  factory ZephyrFormBuilderTheme.dark() {
    return ZephyrFormBuilderTheme(
      backgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(8.0),
      padding: const EdgeInsets.all(24.0),
      fieldSpacing: 16.0,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFFD1D5DB),
      ),
      inputStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFF9FAFB),
      ),
      placeholderStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      helpStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      errorStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFFF87171),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      primaryColor: const Color(0xFF60A5FA),
      errorColor: const Color(0xFFF87171),
      successColor: const Color(0xFF34D399),
      warningColor: const Color(0xFFFCD34D),
      disabledColor: const Color(0xFF4B5563),
      focusColor: const Color(0xFF60A5FA),
      hoverColor: const Color(0xFF374151),
    );
  }
  
  /// 创建自定义表单构建器主题
  factory ZephyrFormBuilderTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? fieldSpacing,
    TextStyle? labelStyle,
    TextStyle? inputStyle,
    TextStyle? placeholderStyle,
    TextStyle? helpStyle,
    TextStyle? errorStyle,
    TextStyle? descriptionStyle,
    Color? primaryColor,
    Color? errorColor,
    Color? successColor,
    Color? warningColor,
    Color? disabledColor,
    Color? focusColor,
    Color? hoverColor,
  }) {
    final baseTheme = ZephyrFormBuilderTheme.light();
    
    return ZephyrFormBuilderTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      padding: padding ?? baseTheme.padding,
      fieldSpacing: fieldSpacing ?? baseTheme.fieldSpacing,
      labelStyle: labelStyle ?? baseTheme.labelStyle,
      inputStyle: inputStyle ?? baseTheme.inputStyle,
      placeholderStyle: placeholderStyle ?? baseTheme.placeholderStyle,
      helpStyle: helpStyle ?? baseTheme.helpStyle,
      errorStyle: errorStyle ?? baseTheme.errorStyle,
      descriptionStyle: descriptionStyle ?? baseTheme.descriptionStyle,
      primaryColor: primaryColor ?? baseTheme.primaryColor,
      errorColor: errorColor ?? baseTheme.errorColor,
      successColor: successColor ?? baseTheme.successColor,
      warningColor: warningColor ?? baseTheme.warningColor,
      disabledColor: disabledColor ?? baseTheme.disabledColor,
      focusColor: focusColor ?? baseTheme.focusColor,
      hoverColor: hoverColor ?? baseTheme.hoverColor,
    );
  }
  
  /// 复制主题并修改部分属性
  ZephyrFormBuilderTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? fieldSpacing,
    TextStyle? labelStyle,
    TextStyle? inputStyle,
    TextStyle? placeholderStyle,
    TextStyle? helpStyle,
    TextStyle? errorStyle,
    TextStyle? descriptionStyle,
    Color? primaryColor,
    Color? errorColor,
    Color? successColor,
    Color? warningColor,
    Color? disabledColor,
    Color? focusColor,
    Color? hoverColor,
  }) {
    return ZephyrFormBuilderTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      fieldSpacing: fieldSpacing ?? this.fieldSpacing,
      labelStyle: labelStyle ?? this.labelStyle,
      inputStyle: inputStyle ?? this.inputStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      helpStyle: helpStyle ?? this.helpStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      primaryColor: primaryColor ?? this.primaryColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      disabledColor: disabledColor ?? this.disabledColor,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
    );
  }
  
  /// 主题合并
  ZephyrFormBuilderTheme merge(ZephyrFormBuilderTheme? other) {
    if (other == null) return this;
    
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      padding: other.padding,
      fieldSpacing: other.fieldSpacing,
      labelStyle: other.labelStyle,
      inputStyle: other.inputStyle,
      placeholderStyle: other.placeholderStyle,
      helpStyle: other.helpStyle,
      errorStyle: other.errorStyle,
      descriptionStyle: other.descriptionStyle,
      primaryColor: other.primaryColor,
      errorColor: other.errorColor,
      successColor: other.successColor,
      warningColor: other.warningColor,
      disabledColor: other.disabledColor,
      focusColor: other.focusColor,
      hoverColor: other.hoverColor,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrFormBuilderTheme &&
      other.backgroundColor == backgroundColor &&
      other.borderColor == borderColor &&
      other.borderWidth == borderWidth &&
      other.borderRadius == borderRadius &&
      other.padding == padding &&
      other.fieldSpacing == fieldSpacing &&
      other.labelStyle == labelStyle &&
      other.inputStyle == inputStyle &&
      other.placeholderStyle == placeholderStyle &&
      other.helpStyle == helpStyle &&
      other.errorStyle == errorStyle &&
      other.descriptionStyle == descriptionStyle &&
      other.primaryColor == primaryColor &&
      other.errorColor == errorColor &&
      other.successColor == successColor &&
      other.warningColor == warningColor &&
      other.disabledColor == disabledColor &&
      other.focusColor == focusColor &&
      other.hoverColor == hoverColor;
  }
  
  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      padding,
      fieldSpacing,
      labelStyle,
      inputStyle,
      placeholderStyle,
      helpStyle,
      errorStyle,
      descriptionStyle,
      primaryColor,
      errorColor,
      successColor,
      warningColor,
      disabledColor,
      focusColor,
      hoverColor,
    ]);
  }
}