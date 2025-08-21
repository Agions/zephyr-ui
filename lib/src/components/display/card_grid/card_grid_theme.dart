import 'package:flutter/material.dart';

/// ZephyrUI 卡片网格主题配置
///
/// 定义卡片网格组件的视觉样式，包括颜色、字体、边框等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrCardGridTheme {
  /// 背景颜色
  final Color backgroundColor;
  
  /// 卡片背景颜色
  final Color cardBackgroundColor;
  
  /// 边框颜色
  final Color borderColor;
  
  /// 选中边框颜色
  final Color selectedBorderColor;
  
  /// 边框宽度
  final double borderWidth;
  
  /// 边框圆角
  final BorderRadius borderRadius;
  
  /// 阴影
  final List<BoxShadow> boxShadow;
  
  /// 标题文本样式
  final TextStyle titleStyle;
  
  /// 副标题文本样式
  final TextStyle subtitleStyle;
  
  /// 描述文本样式
  final TextStyle descriptionStyle;
  
  /// 内容内边距
  final EdgeInsets contentPadding;
  
  /// 操作区域内边距
  final EdgeInsets actionsPadding;
  
  /// 选中颜色
  final Color selectedColor;
  
  /// 悬停颜色
  final Color hoverColor;
  
  /// 禁用颜色
  final Color disabledColor;
  
  /// 图片错误颜色
  final Color imageErrorColor;
  
  /// 图片错误图标颜色
  final Color imageErrorIconColor;
  
  /// 空数据文本样式
  final TextStyle emptyTextStyle;
  
  /// 加载更多文本样式
  final TextStyle loadMoreTextStyle;
  
  /// 主色调
  final Color primaryColor;
  
  /// 创建卡片网格主题
  const ZephyrCardGridTheme({
    required this.backgroundColor,
    required this.cardBackgroundColor,
    required this.borderColor,
    required this.selectedBorderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.boxShadow,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.descriptionStyle,
    required this.contentPadding,
    required this.actionsPadding,
    required this.selectedColor,
    required this.hoverColor,
    required this.disabledColor,
    required this.imageErrorColor,
    required this.imageErrorIconColor,
    required this.emptyTextStyle,
    required this.loadMoreTextStyle,
    required this.primaryColor,
  });

  /// 创建明亮的卡片网格主题
  factory ZephyrCardGridTheme.light() {
    return ZephyrCardGridTheme(
      backgroundColor: const Color(0xFFF9FAFB),
      cardBackgroundColor: Colors.white,
      borderColor: const Color(0xFFE5E7EB),
      selectedBorderColor: const Color(0xFF3B82F6),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF111827),
      ),
      subtitleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF6B7280),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      actionsPadding: const EdgeInsets.all(12.0),
      selectedColor: const Color(0xFF3B82F6),
      hoverColor: const Color(0xFFF3F4F6),
      disabledColor: const Color(0xFFF3F4F6),
      imageErrorColor: const Color(0xFFF3F4F6),
      imageErrorIconColor: const Color(0xFF9CA3AF),
      emptyTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      loadMoreTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      primaryColor: const Color(0xFF3B82F6),
    );
  }

  /// 创建暗色的卡片网格主题
  factory ZephyrCardGridTheme.dark() {
    return ZephyrCardGridTheme(
      backgroundColor: const Color(0xFF111827),
      cardBackgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      selectedBorderColor: const Color(0xFF60A5FA),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF9FAFB),
      ),
      subtitleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF9CA3AF),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      actionsPadding: const EdgeInsets.all(12.0),
      selectedColor: const Color(0xFF60A5FA),
      hoverColor: const Color(0xFF374151),
      disabledColor: const Color(0xFF374151),
      imageErrorColor: const Color(0xFF374151),
      imageErrorIconColor: const Color(0xFF6B7280),
      emptyTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      loadMoreTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      primaryColor: const Color(0xFF60A5FA),
    );
  }

  /// 创建自定义卡片网格主题
  factory ZephyrCardGridTheme.custom({
    Color? backgroundColor,
    Color? cardBackgroundColor,
    Color? borderColor,
    Color? selectedBorderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? descriptionStyle,
    EdgeInsets? contentPadding,
    EdgeInsets? actionsPadding,
    Color? selectedColor,
    Color? hoverColor,
    Color? disabledColor,
    Color? imageErrorColor,
    Color? imageErrorIconColor,
    TextStyle? emptyTextStyle,
    TextStyle? loadMoreTextStyle,
    Color? primaryColor,
  }) {
    final baseTheme = ZephyrCardGridTheme.light();
    
    return ZephyrCardGridTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      cardBackgroundColor: cardBackgroundColor ?? baseTheme.cardBackgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      selectedBorderColor: selectedBorderColor ?? baseTheme.selectedBorderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      boxShadow: boxShadow ?? baseTheme.boxShadow,
      titleStyle: titleStyle ?? baseTheme.titleStyle,
      subtitleStyle: subtitleStyle ?? baseTheme.subtitleStyle,
      descriptionStyle: descriptionStyle ?? baseTheme.descriptionStyle,
      contentPadding: contentPadding ?? baseTheme.contentPadding,
      actionsPadding: actionsPadding ?? baseTheme.actionsPadding,
      selectedColor: selectedColor ?? baseTheme.selectedColor,
      hoverColor: hoverColor ?? baseTheme.hoverColor,
      disabledColor: disabledColor ?? baseTheme.disabledColor,
      imageErrorColor: imageErrorColor ?? baseTheme.imageErrorColor,
      imageErrorIconColor: imageErrorIconColor ?? baseTheme.imageErrorIconColor,
      emptyTextStyle: emptyTextStyle ?? baseTheme.emptyTextStyle,
      loadMoreTextStyle: loadMoreTextStyle ?? baseTheme.loadMoreTextStyle,
      primaryColor: primaryColor ?? baseTheme.primaryColor,
    );
  }

  /// 复制主题并修改部分属性
  ZephyrCardGridTheme copyWith({
    Color? backgroundColor,
    Color? cardBackgroundColor,
    Color? borderColor,
    Color? selectedBorderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? descriptionStyle,
    EdgeInsets? contentPadding,
    EdgeInsets? actionsPadding,
    Color? selectedColor,
    Color? hoverColor,
    Color? disabledColor,
    Color? imageErrorColor,
    Color? imageErrorIconColor,
    TextStyle? emptyTextStyle,
    TextStyle? loadMoreTextStyle,
    Color? primaryColor,
  }) {
    return ZephyrCardGridTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      contentPadding: contentPadding ?? this.contentPadding,
      actionsPadding: actionsPadding ?? this.actionsPadding,
      selectedColor: selectedColor ?? this.selectedColor,
      hoverColor: hoverColor ?? this.hoverColor,
      disabledColor: disabledColor ?? this.disabledColor,
      imageErrorColor: imageErrorColor ?? this.imageErrorColor,
      imageErrorIconColor: imageErrorIconColor ?? this.imageErrorIconColor,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      loadMoreTextStyle: loadMoreTextStyle ?? this.loadMoreTextStyle,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }

  /// 主题合并
  ZephyrCardGridTheme merge(ZephyrCardGridTheme? other) {
    if (other == null) return this;
    
    return copyWith(
      backgroundColor: other.backgroundColor,
      cardBackgroundColor: other.cardBackgroundColor,
      borderColor: other.borderColor,
      selectedBorderColor: other.selectedBorderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      boxShadow: other.boxShadow,
      titleStyle: other.titleStyle,
      subtitleStyle: other.subtitleStyle,
      descriptionStyle: other.descriptionStyle,
      contentPadding: other.contentPadding,
      actionsPadding: other.actionsPadding,
      selectedColor: other.selectedColor,
      hoverColor: other.hoverColor,
      disabledColor: other.disabledColor,
      imageErrorColor: other.imageErrorColor,
      imageErrorIconColor: other.imageErrorIconColor,
      emptyTextStyle: other.emptyTextStyle,
      loadMoreTextStyle: other.loadMoreTextStyle,
      primaryColor: other.primaryColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrCardGridTheme &&
      other.backgroundColor == backgroundColor &&
      other.cardBackgroundColor == cardBackgroundColor &&
      other.borderColor == borderColor &&
      other.selectedBorderColor == selectedBorderColor &&
      other.borderWidth == borderWidth &&
      other.borderRadius == borderRadius &&
      other.boxShadow == boxShadow &&
      other.titleStyle == titleStyle &&
      other.subtitleStyle == subtitleStyle &&
      other.descriptionStyle == descriptionStyle &&
      other.contentPadding == contentPadding &&
      other.actionsPadding == actionsPadding &&
      other.selectedColor == selectedColor &&
      other.hoverColor == hoverColor &&
      other.disabledColor == disabledColor &&
      other.imageErrorColor == imageErrorColor &&
      other.imageErrorIconColor == imageErrorIconColor &&
      other.emptyTextStyle == emptyTextStyle &&
      other.loadMoreTextStyle == loadMoreTextStyle &&
      other.primaryColor == primaryColor;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      cardBackgroundColor,
      borderColor,
      selectedBorderColor,
      borderWidth,
      borderRadius,
      boxShadow,
      titleStyle,
      subtitleStyle,
      descriptionStyle,
      contentPadding,
      actionsPadding,
      selectedColor,
      hoverColor,
      disabledColor,
      imageErrorColor,
      imageErrorIconColor,
      emptyTextStyle,
      loadMoreTextStyle,
      primaryColor,
    ]);
  }
}