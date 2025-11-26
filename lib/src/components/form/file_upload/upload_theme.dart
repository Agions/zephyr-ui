import 'package:flutter/material.dart';

/// ZephyrUI 文件上传主题配置
/// 
/// 定义文件上传组件的视觉样式，包括颜色、字体、边框等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrUploadTheme {
  /// 背景颜色
  final Color backgroundColor;
  
  /// 边框颜色
  final Color borderColor;
  
  /// 边框宽度
  final double borderWidth;
  
  /// 边框圆角
  final BorderRadius borderRadius;
  
  /// 拖拽激活状态背景颜色
  final Color dragActiveColor;
  
  /// 拖拽激活状态边框颜色
  final Color dragActiveBorderColor;
  
  /// 图标颜色
  final Color iconColor;
  
  /// 文本样式
  final TextStyle textStyle;
  
  /// 副文本样式
  final TextStyle subtextStyle;
  
  /// 错误文本样式
  final TextStyle errorStyle;
  
  /// 文件项背景颜色
  final Color fileItemBackgroundColor;
  
  /// 文件项边框颜色
  final Color fileItemBorderColor;
  
  /// 文件项边框圆角
  final BorderRadius fileItemBorderRadius;
  
  /// 文件图标颜色
  final Color fileIconColor;
  
  /// 文件名称样式
  final TextStyle fileNameStyle;
  
  /// 文件大小样式
  final TextStyle fileSizeStyle;
  
  /// 移除图标颜色
  final Color removeIconColor;
  
  /// 按钮图标颜色
  final Color buttonIconColor;
  
  /// 按钮文本样式
  final TextStyle buttonTextStyle;
  
  /// 进度条背景颜色
  final Color progressBackgroundColor;
  
  /// 进度条颜色
  final Color progressColor;
  
  /// 进度条文本样式
  final TextStyle progressTextStyle;
  
  /// 创建文件上传主题
  const ZephyrUploadTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.dragActiveColor,
    required this.dragActiveBorderColor,
    required this.iconColor,
    required this.textStyle,
    required this.subtextStyle,
    required this.errorStyle,
    required this.fileItemBackgroundColor,
    required this.fileItemBorderColor,
    required this.fileItemBorderRadius,
    required this.fileIconColor,
    required this.fileNameStyle,
    required this.fileSizeStyle,
    required this.removeIconColor,
    required this.buttonIconColor,
    required this.buttonTextStyle,
    required this.progressBackgroundColor,
    required this.progressColor,
    required this.progressTextStyle,
  });
  
  /// 创建明亮的文件上传主题
  factory ZephyrUploadTheme.light() {
    return ZephyrUploadTheme(
      backgroundColor: const Color(0xFFF9FAFB),
      borderColor: const Color(0xFFE5E7EB),
      borderWidth: 2.0,
      borderRadius: const BorderRadius.circular(8.0),
      dragActiveColor: const Color(0xFFEFF6FF),
      dragActiveBorderColor: const Color(0xFF3B82F6),
      iconColor: const Color(0xFF6B7280),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF374151),
      ),
      subtextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      errorStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFFEF4444),
      ),
      fileItemBackgroundColor: Colors.white,
      fileItemBorderColor: const Color(0xFFE5E7EB),
      fileItemBorderRadius: BorderRadius.circular(6.0),
      fileIconColor: const Color(0xFF6B7280),
      fileNameStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF374151),
      ),
      fileSizeStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      removeIconColor: const Color(0xFF6B7280),
      buttonIconColor: const Color(0xFF3B82F6),
      buttonTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF3B82F6),
      ),
      progressBackgroundColor: const Color(0xFFE5E7EB),
      progressColor: const Color(0xFF3B82F6),
      progressTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
    );
  }
  
  /// 创建暗色的文件上传主题
  factory ZephyrUploadTheme.dark() {
    return ZephyrUploadTheme(
      backgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      borderWidth: 2.0,
      borderRadius: const BorderRadius.circular(8.0),
      dragActiveColor: const Color(0xFF1E3A8A),
      dragActiveBorderColor: const Color(0xFF60A5FA),
      iconColor: const Color(0xFF9CA3AF),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFFD1D5DB),
      ),
      subtextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      errorStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFFF87171),
      ),
      fileItemBackgroundColor: const Color(0xFF374151),
      fileItemBorderColor: const Color(0xFF4B5563),
      fileItemBorderRadius: BorderRadius.circular(6.0),
      fileIconColor: const Color(0xFF9CA3AF),
      fileNameStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFFD1D5DB),
      ),
      fileSizeStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      removeIconColor: const Color(0xFF9CA3AF),
      buttonIconColor: const Color(0xFF60A5FA),
      buttonTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF60A5FA),
      ),
      progressBackgroundColor: const Color(0xFF374151),
      progressColor: const Color(0xFF60A5FA),
      progressTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
    );
  }
  
  /// 创建自定义文件上传主题
  factory ZephyrUploadTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? dragActiveColor,
    Color? dragActiveBorderColor,
    Color? iconColor,
    TextStyle? textStyle,
    TextStyle? subtextStyle,
    TextStyle? errorStyle,
    Color? fileItemBackgroundColor,
    Color? fileItemBorderColor,
    BorderRadius? fileItemBorderRadius,
    Color? fileIconColor,
    TextStyle? fileNameStyle,
    TextStyle? fileSizeStyle,
    Color? removeIconColor,
    Color? buttonIconColor,
    TextStyle? buttonTextStyle,
    Color? progressBackgroundColor,
    Color? progressColor,
    TextStyle? progressTextStyle,
  }) {
    final baseTheme = ZephyrUploadTheme.light();
    
    return ZephyrUploadTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      dragActiveColor: dragActiveColor ?? baseTheme.dragActiveColor,
      dragActiveBorderColor: dragActiveBorderColor ?? baseTheme.dragActiveBorderColor,
      iconColor: iconColor ?? baseTheme.iconColor,
      textStyle: textStyle ?? baseTheme.textStyle,
      subtextStyle: subtextStyle ?? baseTheme.subtextStyle,
      errorStyle: errorStyle ?? baseTheme.errorStyle,
      fileItemBackgroundColor: fileItemBackgroundColor ?? baseTheme.fileItemBackgroundColor,
      fileItemBorderColor: fileItemBorderColor ?? baseTheme.fileItemBorderColor,
      fileItemBorderRadius: fileItemBorderRadius ?? baseTheme.fileItemBorderRadius,
      fileIconColor: fileIconColor ?? baseTheme.fileIconColor,
      fileNameStyle: fileNameStyle ?? baseTheme.fileNameStyle,
      fileSizeStyle: fileSizeStyle ?? baseTheme.fileSizeStyle,
      removeIconColor: removeIconColor ?? baseTheme.removeIconColor,
      buttonIconColor: buttonIconColor ?? baseTheme.buttonIconColor,
      buttonTextStyle: buttonTextStyle ?? baseTheme.buttonTextStyle,
      progressBackgroundColor: progressBackgroundColor ?? baseTheme.progressBackgroundColor,
      progressColor: progressColor ?? baseTheme.progressColor,
      progressTextStyle: progressTextStyle ?? baseTheme.progressTextStyle,
    );
  }
  
  /// 复制主题并修改部分属性
  ZephyrUploadTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? dragActiveColor,
    Color? dragActiveBorderColor,
    Color? iconColor,
    TextStyle? textStyle,
    TextStyle? subtextStyle,
    TextStyle? errorStyle,
    Color? fileItemBackgroundColor,
    Color? fileItemBorderColor,
    BorderRadius? fileItemBorderRadius,
    Color? fileIconColor,
    TextStyle? fileNameStyle,
    TextStyle? fileSizeStyle,
    Color? removeIconColor,
    Color? buttonIconColor,
    TextStyle? buttonTextStyle,
    Color? progressBackgroundColor,
    Color? progressColor,
    TextStyle? progressTextStyle,
  }) {
    return ZephyrUploadTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      dragActiveColor: dragActiveColor ?? this.dragActiveColor,
      dragActiveBorderColor: dragActiveBorderColor ?? this.dragActiveBorderColor,
      iconColor: iconColor ?? this.iconColor,
      textStyle: textStyle ?? this.textStyle,
      subtextStyle: subtextStyle ?? this.subtextStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      fileItemBackgroundColor: fileItemBackgroundColor ?? this.fileItemBackgroundColor,
      fileItemBorderColor: fileItemBorderColor ?? this.fileItemBorderColor,
      fileItemBorderRadius: fileItemBorderRadius ?? this.fileItemBorderRadius,
      fileIconColor: fileIconColor ?? this.fileIconColor,
      fileNameStyle: fileNameStyle ?? this.fileNameStyle,
      fileSizeStyle: fileSizeStyle ?? this.fileSizeStyle,
      removeIconColor: removeIconColor ?? this.removeIconColor,
      buttonIconColor: buttonIconColor ?? this.buttonIconColor,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      progressBackgroundColor: progressBackgroundColor ?? this.progressBackgroundColor,
      progressColor: progressColor ?? this.progressColor,
      progressTextStyle: progressTextStyle ?? this.progressTextStyle,
    );
  }
  
  /// 主题合并
  ZephyrUploadTheme merge(ZephyrUploadTheme? other) {
    if (other == null) return this;
    
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      dragActiveColor: other.dragActiveColor,
      dragActiveBorderColor: other.dragActiveBorderColor,
      iconColor: other.iconColor,
      textStyle: other.textStyle,
      subtextStyle: other.subtextStyle,
      errorStyle: other.errorStyle,
      fileItemBackgroundColor: other.fileItemBackgroundColor,
      fileItemBorderColor: other.fileItemBorderColor,
      fileItemBorderRadius: other.fileItemBorderRadius,
      fileIconColor: other.fileIconColor,
      fileNameStyle: other.fileNameStyle,
      fileSizeStyle: other.fileSizeStyle,
      removeIconColor: other.removeIconColor,
      buttonIconColor: other.buttonIconColor,
      buttonTextStyle: other.buttonTextStyle,
      progressBackgroundColor: other.progressBackgroundColor,
      progressColor: other.progressColor,
      progressTextStyle: other.progressTextStyle,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrUploadTheme &&
      other.backgroundColor == backgroundColor &&
      other.borderColor == borderColor &&
      other.borderWidth == borderWidth &&
      other.borderRadius == borderRadius &&
      other.dragActiveColor == dragActiveColor &&
      other.dragActiveBorderColor == dragActiveBorderColor &&
      other.iconColor == iconColor &&
      other.textStyle == textStyle &&
      other.subtextStyle == subtextStyle &&
      other.errorStyle == errorStyle &&
      other.fileItemBackgroundColor == fileItemBackgroundColor &&
      other.fileItemBorderColor == fileItemBorderColor &&
      other.fileItemBorderRadius == fileItemBorderRadius &&
      other.fileIconColor == fileIconColor &&
      other.fileNameStyle == fileNameStyle &&
      other.fileSizeStyle == fileSizeStyle &&
      other.removeIconColor == removeIconColor &&
      other.buttonIconColor == buttonIconColor &&
      other.buttonTextStyle == buttonTextStyle &&
      other.progressBackgroundColor == progressBackgroundColor &&
      other.progressColor == progressColor &&
      other.progressTextStyle == progressTextStyle;
  }
  
  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      dragActiveColor,
      dragActiveBorderColor,
      iconColor,
      textStyle,
      subtextStyle,
      errorStyle,
      fileItemBackgroundColor,
      fileItemBorderColor,
      fileItemBorderRadius,
      fileIconColor,
      fileNameStyle,
      fileSizeStyle,
      removeIconColor,
      buttonIconColor,
      buttonTextStyle,
      progressBackgroundColor,
      progressColor,
      progressTextStyle,
    ]);
  }
}