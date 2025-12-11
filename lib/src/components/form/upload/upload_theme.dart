/// VelocityUI 文件上传主题
library velocity_upload_theme;

import 'package:flutter/material.dart';

/// 文件上传主题
class VelocityUploadTheme {
  /// 创建文件上传主题
  const VelocityUploadTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textStyle,
  });

  /// 创建浅色主题
  factory VelocityUploadTheme.light() {
    return const VelocityUploadTheme(
      backgroundColor: Color(0xFFF9FAFB),
      borderColor: Color(0xFFE5E7EB),
      iconColor: Color(0xFF6B7280),
      textStyle: TextStyle(color: Color(0xFF374151)),
    );
  }

  /// 创建深色主题
  factory VelocityUploadTheme.dark() {
    return const VelocityUploadTheme(
      backgroundColor: Color(0xFF1F2937),
      borderColor: Color(0xFF374151),
      iconColor: Color(0xFF9CA3AF),
      textStyle: TextStyle(color: Color(0xFFF3F4F6)),
    );
  }

  /// 创建自定义主题
  factory VelocityUploadTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    TextStyle? textStyle,
  }) {
    return VelocityUploadTheme(
      backgroundColor: backgroundColor ?? const Color(0xFFF9FAFB),
      borderColor: borderColor ?? const Color(0xFFE5E7EB),
      iconColor: iconColor ?? const Color(0xFF6B7280),
      textStyle: textStyle ?? const TextStyle(color: Color(0xFF374151)),
    );
  }

  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final TextStyle textStyle;

  /// 复制主题并修改指定属性
  VelocityUploadTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    TextStyle? textStyle,
  }) {
    return VelocityUploadTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  /// 合并主题
  VelocityUploadTheme merge(VelocityUploadTheme other) {
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      iconColor: other.iconColor,
      textStyle: other.textStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is VelocityUploadTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.iconColor == iconColor &&
        other.textStyle == textStyle;
  }

  @override
  int get hashCode {
    return Object.hash(backgroundColor, borderColor, iconColor, textStyle);
  }
}
