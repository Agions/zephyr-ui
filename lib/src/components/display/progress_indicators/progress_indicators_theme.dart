import 'package:flutter/material.dart';

/// ZephyrUI 进度指示器主题配置
///
/// 定义进度指示器组件的视觉样式，包括颜色、字体、大小等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrProgressIndicatorsTheme {
  /// 背景颜色
  final Color backgroundColor;
  
  /// 缓冲颜色
  final Color bufferColor;
  
  /// 主色调
  final Color primaryColor;
  
  /// 成功颜色
  final Color successColor;
  
  /// 警告颜色
  final Color warningColor;
  
  /// 错误颜色
  final Color errorColor;
  
  /// 信息颜色
  final Color infoColor;
  
  /// 文本颜色
  final Color textColor;
  
  /// 文本样式
  final TextStyle textStyle;
  
  /// 标签样式
  final TextStyle labelStyle;
  
  /// 创建进度指示器主题
  const ZephyrProgressIndicatorsTheme({
    required this.backgroundColor,
    required this.bufferColor,
    required this.primaryColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,
    required this.infoColor,
    required this.textColor,
    required this.textStyle,
    required this.labelStyle,
  });

  /// 创建明亮的进度指示器主题
  factory ZephyrProgressIndicatorsTheme.light() {
    return ZephyrProgressIndicatorsTheme(
      backgroundColor: const Color(0xFFE5E7EB),
      bufferColor: const Color(0xFFD1D5DB),
      primaryColor: const Color(0xFF3B82F6),
      successColor: const Color(0xFF10B981),
      warningColor: const Color(0xFFF59E0B),
      errorColor: const Color(0xFFEF4444),
      infoColor: const Color(0xFF6366F1),
      textColor: const Color(0xFF374151),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF111827),
      ),
      labelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
    );
  }

  /// 创建暗色的进度指示器主题
  factory ZephyrProgressIndicatorsTheme.dark() {
    return ZephyrProgressIndicatorsTheme(
      backgroundColor: const Color(0xFF374151),
      bufferColor: const Color(0xFF4B5563),
      primaryColor: const Color(0xFF60A5FA),
      successColor: const Color(0xFF34D399),
      warningColor: const Color(0xFFFCD34D),
      errorColor: const Color(0xFFF87171),
      infoColor: const Color(0xFF818CF8),
      textColor: const Color(0xFFD1D5DB),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF9FAFB),
      ),
      labelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
    );
  }

  /// 创建自定义进度指示器主题
  factory ZephyrProgressIndicatorsTheme.custom({
    Color? backgroundColor,
    Color? bufferColor,
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    Color? textColor,
    TextStyle? textStyle,
    TextStyle? labelStyle,
  }) {
    final baseTheme = ZephyrProgressIndicatorsTheme.light();
    
    return ZephyrProgressIndicatorsTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      bufferColor: bufferColor ?? baseTheme.bufferColor,
      primaryColor: primaryColor ?? baseTheme.primaryColor,
      successColor: successColor ?? baseTheme.successColor,
      warningColor: warningColor ?? baseTheme.warningColor,
      errorColor: errorColor ?? baseTheme.errorColor,
      infoColor: infoColor ?? baseTheme.infoColor,
      textColor: textColor ?? baseTheme.textColor,
      textStyle: textStyle ?? baseTheme.textStyle,
      labelStyle: labelStyle ?? baseTheme.labelStyle,
    );
  }

  /// 复制主题并修改部分属性
  ZephyrProgressIndicatorsTheme copyWith({
    Color? backgroundColor,
    Color? bufferColor,
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    Color? textColor,
    TextStyle? textStyle,
    TextStyle? labelStyle,
  }) {
    return ZephyrProgressIndicatorsTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bufferColor: bufferColor ?? this.bufferColor,
      primaryColor: primaryColor ?? this.primaryColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      infoColor: infoColor ?? this.infoColor,
      textColor: textColor ?? this.textColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }

  /// 主题合并
  ZephyrProgressIndicatorsTheme merge(ZephyrProgressIndicatorsTheme? other) {
    if (other == null) return this;
    
    return copyWith(
      backgroundColor: other.backgroundColor,
      bufferColor: other.bufferColor,
      primaryColor: other.primaryColor,
      successColor: other.successColor,
      warningColor: other.warningColor,
      errorColor: other.errorColor,
      infoColor: other.infoColor,
      textColor: other.textColor,
      textStyle: other.textStyle,
      labelStyle: other.labelStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrProgressIndicatorsTheme &&
      other.backgroundColor == backgroundColor &&
      other.bufferColor == bufferColor &&
      other.primaryColor == primaryColor &&
      other.successColor == successColor &&
      other.warningColor == warningColor &&
      other.errorColor == errorColor &&
      other.infoColor == infoColor &&
      other.textColor == textColor &&
      other.textStyle == textStyle &&
      other.labelStyle == labelStyle;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      bufferColor,
      primaryColor,
      successColor,
      warningColor,
      errorColor,
      infoColor,
      textColor,
      textStyle,
      labelStyle,
    ]);
  }
}