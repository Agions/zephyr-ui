/// VelocityUI 文件上传样式
library velocity_upload_style;

import 'package:flutter/material.dart';

/// 文件上传样式
class VelocityUploadStyle {
  /// 创建文件上传样式
  const VelocityUploadStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textStyle,
  });

  /// 创建浅色主题样式
  factory VelocityUploadStyle.light() {
    return const VelocityUploadStyle(
      backgroundColor: Color(0xFFF9FAFB),
      borderColor: Color(0xFFE5E7EB),
      iconColor: Color(0xFF6B7280),
      textStyle: TextStyle(color: Color(0xFF374151)),
    );
  }

  /// 创建深色主题样式
  factory VelocityUploadStyle.dark() {
    return const VelocityUploadStyle(
      backgroundColor: Color(0xFF1F2937),
      borderColor: Color(0xFF374151),
      iconColor: Color(0xFF9CA3AF),
      textStyle: TextStyle(color: Color(0xFFF3F4F6)),
    );
  }

  /// 创建自定义主题样式
  factory VelocityUploadStyle.custom({
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    TextStyle? textStyle,
  }) {
    return VelocityUploadStyle(
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

  /// 复制样式并修改指定属性
  VelocityUploadStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    TextStyle? textStyle,
  }) {
    return VelocityUploadStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
