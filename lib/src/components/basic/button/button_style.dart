/// VelocityUI 按钮样式
///
/// 定义按钮的视觉样式。
library velocity_button_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 按钮样式配置
class VelocityButtonStyle {
  /// 创建按钮样式
  const VelocityButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.highlightColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.padding,
    this.textStyle,
    this.iconSize,
    this.iconSpacing,
  });

  /// 背景颜色
  final Color? backgroundColor;
  
  /// 前景颜色（文字、图标）
  final Color? foregroundColor;
  
  /// 禁用状态背景颜色
  final Color? disabledBackgroundColor;
  
  /// 禁用状态前景颜色
  final Color? disabledForegroundColor;
  
  /// 水波纹颜色
  final Color? splashColor;
  
  /// 高亮颜色
  final Color? highlightColor;
  
  /// 圆角
  final BorderRadius? borderRadius;
  
  /// 边框
  final Border? border;
  
  /// 阴影
  final List<BoxShadow>? boxShadow;
  
  /// 内边距
  final EdgeInsets? padding;
  
  /// 文字样式
  final TextStyle? textStyle;
  
  /// 图标尺寸
  final double? iconSize;
  
  /// 图标与文字间距
  final double? iconSpacing;

  /// 根据类型和尺寸解析样式
  static VelocityButtonStyle resolve({
    required dynamic type,
    required dynamic size,
    VelocityButtonStyle? customStyle,
  }) {
    final baseStyle = _getStyleForType(type);
    final sizeStyle = _getStyleForSize(size);
    
    return VelocityButtonStyle(
      backgroundColor: customStyle?.backgroundColor ?? baseStyle.backgroundColor,
      foregroundColor: customStyle?.foregroundColor ?? baseStyle.foregroundColor,
      disabledBackgroundColor: customStyle?.disabledBackgroundColor ?? baseStyle.disabledBackgroundColor,
      disabledForegroundColor: customStyle?.disabledForegroundColor ?? baseStyle.disabledForegroundColor,
      splashColor: customStyle?.splashColor ?? baseStyle.splashColor,
      highlightColor: customStyle?.highlightColor ?? baseStyle.highlightColor,
      borderRadius: customStyle?.borderRadius ?? sizeStyle.borderRadius,
      border: customStyle?.border ?? baseStyle.border,
      boxShadow: customStyle?.boxShadow ?? baseStyle.boxShadow,
      padding: customStyle?.padding ?? sizeStyle.padding,
      textStyle: customStyle?.textStyle ?? sizeStyle.textStyle,
      iconSize: customStyle?.iconSize ?? sizeStyle.iconSize,
      iconSpacing: customStyle?.iconSpacing ?? sizeStyle.iconSpacing,
    );
  }

  static VelocityButtonStyle _getStyleForType(dynamic type) {
    final typeName = type.toString().split('.').last;
    
    switch (typeName) {
      case 'primary':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.primary,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      case 'secondary':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.secondary,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      case 'outline':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.transparent,
          foregroundColor: VelocityColors.primary,
          disabledBackgroundColor: VelocityColors.transparent,
          disabledForegroundColor: VelocityColors.gray400,
          splashColor: VelocityColors.withOpacity(VelocityColors.primary, 0.1),
          highlightColor: VelocityColors.withOpacity(VelocityColors.primary, 0.05),
          border: Border.all(color: VelocityColors.primary, width: 1),
        );
      case 'text':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.transparent,
          foregroundColor: VelocityColors.primary,
          disabledBackgroundColor: VelocityColors.transparent,
          disabledForegroundColor: VelocityColors.gray400,
          splashColor: VelocityColors.withOpacity(VelocityColors.primary, 0.1),
          highlightColor: VelocityColors.withOpacity(VelocityColors.primary, 0.05),
        );
      case 'danger':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.error,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      case 'success':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.success,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      case 'warning':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.warning,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      default:
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.primary,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
    }
  }

  static VelocityButtonStyle _getStyleForSize(dynamic size) {
    final sizeName = size.toString().split('.').last;
    
    switch (sizeName) {
      case 'small':
        return const VelocityButtonStyle(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          iconSize: 16,
          iconSpacing: 6,
        );
      case 'medium':
        return const VelocityButtonStyle(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          iconSize: 18,
          iconSpacing: 8,
        );
      case 'large':
        return const VelocityButtonStyle(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          iconSize: 20,
          iconSpacing: 10,
        );
      default:
        return const VelocityButtonStyle(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          iconSize: 18,
          iconSpacing: 8,
        );
    }
  }

  /// 复制并修改
  VelocityButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? splashColor,
    Color? highlightColor,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? iconSize,
    double? iconSpacing,
  }) {
    return VelocityButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor ?? this.disabledForegroundColor,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconSize: iconSize ?? this.iconSize,
      iconSpacing: iconSpacing ?? this.iconSpacing,
    );
  }
}

/// 图标按钮样式配置
class VelocityIconButtonStyle {
  /// 创建图标按钮样式
  const VelocityIconButtonStyle({
    this.backgroundColor,
    this.iconColor,
    this.disabledBackgroundColor,
    this.disabledIconColor,
    this.splashColor,
    this.highlightColor,
    this.borderRadius,
    this.border,
  });

  /// 背景颜色
  final Color? backgroundColor;
  
  /// 图标颜色
  final Color? iconColor;
  
  /// 禁用状态背景颜色
  final Color? disabledBackgroundColor;
  
  /// 禁用状态图标颜色
  final Color? disabledIconColor;
  
  /// 水波纹颜色
  final Color? splashColor;
  
  /// 高亮颜色
  final Color? highlightColor;
  
  /// 圆角
  final BorderRadius? borderRadius;
  
  /// 边框
  final Border? border;

  /// 默认样式
  factory VelocityIconButtonStyle.defaults() {
    return VelocityIconButtonStyle(
      backgroundColor: VelocityColors.transparent,
      iconColor: VelocityColors.gray700,
      disabledBackgroundColor: VelocityColors.gray200,
      disabledIconColor: VelocityColors.gray400,
      splashColor: VelocityColors.withOpacity(VelocityColors.gray700, 0.1),
      highlightColor: VelocityColors.withOpacity(VelocityColors.gray700, 0.05),
    );
  }
}
