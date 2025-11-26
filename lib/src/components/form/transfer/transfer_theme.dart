import 'package:flutter/material.dart';

/// Zephyr穿梭框主题配置
///
/// 定义穿梭框的视觉外观和样式
class ZephyrTransferTheme {
  const ZephyrTransferTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.headerBackgroundColor,
    required this.headerBorderColor,
    required this.headerBorderWidth,
    required this.headerPadding,
    required this.headerTextStyle,
    required this.listBorderColor,
    required this.listBorderWidth,
    required this.listBorderRadius,
    required this.listPadding,
    required this.itemBackgroundColor,
    required this.itemSelectedBackgroundColor,
    required this.itemBorderColor,
    required this.itemSelectedBorderColor,
    required this.itemBorderWidth,
    required this.itemSelectedBorderWidth,
    required this.itemBorderRadius,
    required this.itemPadding,
    required this.itemMargin,
    required this.itemTitleStyle,
    required this.itemDescriptionStyle,
    required this.checkboxActiveColor,
    required this.checkboxCheckColor,
    required this.operationButtonBackgroundColor,
    required this.disabledOperationButtonBackgroundColor,
    required this.operationButtonBorderColor,
    required this.disabledOperationButtonBorderColor,
    required this.operationButtonBorderWidth,
    required this.operationButtonBorderRadius,
    required this.operationButtonWidth,
    required this.operationButtonHeight,
    required this.operationTextStyle,
    required this.disabledOperationTextStyle,
    required this.operationIconSize,
    required this.operationIconColor,
    required this.disabledOperationIconColor,
    required this.operationIconSpacing,
    required this.operationSpacing,
    required this.operationsPadding,
    required this.footerBorderColor,
    required this.footerBorderWidth,
    required this.footerPadding,
    required this.emptyTextStyle,
    required this.searchFillColor,
    required this.searchHintStyle,
    required this.searchTextStyle,
    required this.searchIconSize,
    required this.searchIconColor,
    required this.searchBorderRadius,
    required this.searchContentPadding,
  });

  /// 工厂构造函数 - 浅色主题
  factory ZephyrTransferTheme.light() {
    return const ZephyrTransferTheme(
      backgroundColor: Color(0xFFFFFFFF),
      borderColor: Color(0xFFE5E7EB),
      borderWidth: 1.0,
      borderRadius: 8.0,
      headerBackgroundColor: Color(0xFFF9FAFB),
      headerBorderColor: Color(0xFFE5E7EB),
      headerBorderWidth: 1.0,
      headerPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      headerTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1F2937),
      ),
      listBorderColor: Color(0xFFE5E7EB),
      listBorderWidth: 1.0,
      listBorderRadius: 6.0,
      listPadding: EdgeInsets.all(8),
      itemBackgroundColor: Color(0xFFFFFFFF),
      itemSelectedBackgroundColor: Color(0xFFEFF6FF),
      itemBorderColor: Color(0xFFE5E7EB),
      itemSelectedBorderColor: Color(0xFF3B82F6),
      itemBorderWidth: 1.0,
      itemSelectedBorderWidth: 1.0,
      itemBorderRadius: 4.0,
      itemPadding: EdgeInsets.all(12),
      itemMargin: EdgeInsets.only(bottom: 4),
      itemTitleStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1F2937),
      ),
      itemDescriptionStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      checkboxActiveColor: Color(0xFF3B82F6),
      checkboxCheckColor: Color(0xFFFFFFFF),
      operationButtonBackgroundColor: Color(0xFFFFFFFF),
      disabledOperationButtonBackgroundColor: Color(0xFFF3F4F6),
      operationButtonBorderColor: Color(0xFFD1D5DB),
      disabledOperationButtonBorderColor: Color(0xFFE5E7EB),
      operationButtonBorderWidth: 1.0,
      operationButtonBorderRadius: 4.0,
      operationButtonWidth: 80,
      operationButtonHeight: 32,
      operationTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1F2937),
      ),
      disabledOperationTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF9CA3AF),
      ),
      operationIconSize: 16,
      operationIconColor: Color(0xFF6B7280),
      disabledOperationIconColor: Color(0xFFD1D5DB),
      operationIconSpacing: 4,
      operationSpacing: 8,
      operationsPadding: EdgeInsets.symmetric(horizontal: 12),
      footerBorderColor: Color(0xFFE5E7EB),
      footerBorderWidth: 1.0,
      footerPadding: EdgeInsets.all(12),
      emptyTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      searchFillColor: Color(0xFFF9FAFB),
      searchHintStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      searchTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1F2937),
      ),
      searchIconSize: 16,
      searchIconColor: Color(0xFF9CA3AF),
      searchBorderRadius: 4.0,
      searchContentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    );
  }

  /// 工厂构造函数 - 深色主题
  factory ZephyrTransferTheme.dark() {
    return const ZephyrTransferTheme(
      backgroundColor: Color(0xFF1F2937),
      borderColor: Color(0xFF374151),
      borderWidth: 1.0,
      borderRadius: 8.0,
      headerBackgroundColor: Color(0xFF111827),
      headerBorderColor: Color(0xFF374151),
      headerBorderWidth: 1.0,
      headerPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      headerTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF9FAFB),
      ),
      listBorderColor: Color(0xFF374151),
      listBorderWidth: 1.0,
      listBorderRadius: 6.0,
      listPadding: EdgeInsets.all(8),
      itemBackgroundColor: Color(0xFF374151),
      itemSelectedBackgroundColor: Color(0xFF1E3A8A),
      itemBorderColor: Color(0xFF4B5563),
      itemSelectedBorderColor: Color(0xFF60A5FA),
      itemBorderWidth: 1.0,
      itemSelectedBorderWidth: 1.0,
      itemBorderRadius: 4.0,
      itemPadding: EdgeInsets.all(12),
      itemMargin: EdgeInsets.only(bottom: 4),
      itemTitleStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFFF9FAFB),
      ),
      itemDescriptionStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      checkboxActiveColor: Color(0xFF60A5FA),
      checkboxCheckColor: Color(0xFFFFFFFF),
      operationButtonBackgroundColor: Color(0xFF374151),
      disabledOperationButtonBackgroundColor: Color(0xFF111827),
      operationButtonBorderColor: Color(0xFF4B5563),
      disabledOperationButtonBorderColor: Color(0xFF1F2937),
      operationButtonBorderWidth: 1.0,
      operationButtonBorderRadius: 4.0,
      operationButtonWidth: 80,
      operationButtonHeight: 32,
      operationTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFFF9FAFB),
      ),
      disabledOperationTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF6B7280),
      ),
      operationIconSize: 16,
      operationIconColor: Color(0xFF9CA3AF),
      disabledOperationIconColor: Color(0xFF4B5563),
      operationIconSpacing: 4,
      operationSpacing: 8,
      operationsPadding: EdgeInsets.symmetric(horizontal: 12),
      footerBorderColor: Color(0xFF374151),
      footerBorderWidth: 1.0,
      footerPadding: EdgeInsets.all(12),
      emptyTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      searchFillColor: Color(0xFF111827),
      searchHintStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      searchTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFFF9FAFB),
      ),
      searchIconSize: 16,
      searchIconColor: Color(0xFF6B7280),
      searchBorderRadius: 4.0,
      searchContentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    );
  }

  /// 背景颜色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 边框圆角
  final double borderRadius;

  /// 头部背景颜色
  final Color headerBackgroundColor;

  /// 头部边框颜色
  final Color headerBorderColor;

  /// 头部边框宽度
  final double headerBorderWidth;

  /// 头部内边距
  final EdgeInsetsGeometry headerPadding;

  /// 头部文本样式
  final TextStyle headerTextStyle;

  /// 列表边框颜色
  final Color listBorderColor;

  /// 列表边框宽度
  final double listBorderWidth;

  /// 列表边框圆角
  final double listBorderRadius;

  /// 列表内边距
  final EdgeInsetsGeometry listPadding;

  /// 列表项背景颜色
  final Color itemBackgroundColor;

  /// 列表项选中背景颜色
  final Color itemSelectedBackgroundColor;

  /// 列表项边框颜色
  final Color itemBorderColor;

  /// 列表项选中边框颜色
  final Color itemSelectedBorderColor;

  /// 列表项边框宽度
  final double itemBorderWidth;

  /// 列表项选中边框宽度
  final double itemSelectedBorderWidth;

  /// 列表项边框圆角
  final double itemBorderRadius;

  /// 列表项内边距
  final EdgeInsetsGeometry itemPadding;

  /// 列表项外边距
  final EdgeInsetsGeometry itemMargin;

  /// 列表项标题样式
  final TextStyle itemTitleStyle;

  /// 列表项描述样式
  final TextStyle itemDescriptionStyle;

  /// 复选框激活颜色
  final Color checkboxActiveColor;

  /// 复选框勾选颜色
  final Color checkboxCheckColor;

  /// 操作按钮背景颜色
  final Color operationButtonBackgroundColor;

  /// 禁用操作按钮背景颜色
  final Color disabledOperationButtonBackgroundColor;

  /// 操作按钮边框颜色
  final Color operationButtonBorderColor;

  /// 禁用操作按钮边框颜色
  final Color disabledOperationButtonBorderColor;

  /// 操作按钮边框宽度
  final double operationButtonBorderWidth;

  /// 操作按钮边框圆角
  final double operationButtonBorderRadius;

  /// 操作按钮宽度
  final double operationButtonWidth;

  /// 操作按钮高度
  final double operationButtonHeight;

  /// 操作按钮文本样式
  final TextStyle operationTextStyle;

  /// 禁用操作按钮文本样式
  final TextStyle disabledOperationTextStyle;

  /// 操作图标大小
  final double operationIconSize;

  /// 操作图标颜色
  final Color operationIconColor;

  /// 禁用操作图标颜色
  final Color disabledOperationIconColor;

  /// 操作图标间距
  final double operationIconSpacing;

  /// 操作按钮间距
  final double operationSpacing;

  /// 操作区域内边距
  final EdgeInsetsGeometry operationsPadding;

  /// 底部边框颜色
  final Color footerBorderColor;

  /// 底部边框宽度
  final double footerBorderWidth;

  /// 底部内边距
  final EdgeInsetsGeometry footerPadding;

  /// 空数据文本样式
  final TextStyle emptyTextStyle;

  /// 搜索框填充颜色
  final Color searchFillColor;

  /// 搜索框提示样式
  final TextStyle searchHintStyle;

  /// 搜索框文本样式
  final TextStyle searchTextStyle;

  /// 搜索图标大小
  final double searchIconSize;

  /// 搜索图标颜色
  final Color searchIconColor;

  /// 搜索框圆角
  final double searchBorderRadius;

  /// 搜索框内容内边距
  final EdgeInsetsGeometry searchContentPadding;

  /// 复制并修改属性
  ZephyrTransferTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? headerBackgroundColor,
    Color? headerBorderColor,
    double? headerBorderWidth,
    EdgeInsetsGeometry? headerPadding,
    TextStyle? headerTextStyle,
    Color? listBorderColor,
    double? listBorderWidth,
    double? listBorderRadius,
    EdgeInsetsGeometry? listPadding,
    Color? itemBackgroundColor,
    Color? itemSelectedBackgroundColor,
    Color? itemBorderColor,
    Color? itemSelectedBorderColor,
    double? itemBorderWidth,
    double? itemSelectedBorderWidth,
    double? itemBorderRadius,
    EdgeInsetsGeometry? itemPadding,
    EdgeInsetsGeometry? itemMargin,
    TextStyle? itemTitleStyle,
    TextStyle? itemDescriptionStyle,
    Color? checkboxActiveColor,
    Color? checkboxCheckColor,
    Color? operationButtonBackgroundColor,
    Color? disabledOperationButtonBackgroundColor,
    Color? operationButtonBorderColor,
    Color? disabledOperationButtonBorderColor,
    double? operationButtonBorderWidth,
    double? operationButtonBorderRadius,
    double? operationButtonWidth,
    double? operationButtonHeight,
    TextStyle? operationTextStyle,
    TextStyle? disabledOperationTextStyle,
    double? operationIconSize,
    Color? operationIconColor,
    Color? disabledOperationIconColor,
    double? operationIconSpacing,
    double? operationSpacing,
    EdgeInsetsGeometry? operationsPadding,
    Color? footerBorderColor,
    double? footerBorderWidth,
    EdgeInsetsGeometry? footerPadding,
    TextStyle? emptyTextStyle,
    Color? searchFillColor,
    TextStyle? searchHintStyle,
    TextStyle? searchTextStyle,
    double? searchIconSize,
    Color? searchIconColor,
    double? searchBorderRadius,
    EdgeInsetsGeometry? searchContentPadding,
  }) {
    return ZephyrTransferTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerBorderColor: headerBorderColor ?? this.headerBorderColor,
      headerBorderWidth: headerBorderWidth ?? this.headerBorderWidth,
      headerPadding: headerPadding ?? this.headerPadding,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      listBorderColor: listBorderColor ?? this.listBorderColor,
      listBorderWidth: listBorderWidth ?? this.listBorderWidth,
      listBorderRadius: listBorderRadius ?? this.listBorderRadius,
      listPadding: listPadding ?? this.listPadding,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemSelectedBackgroundColor:
          itemSelectedBackgroundColor ?? this.itemSelectedBackgroundColor,
      itemBorderColor: itemBorderColor ?? this.itemBorderColor,
      itemSelectedBorderColor:
          itemSelectedBorderColor ?? this.itemSelectedBorderColor,
      itemBorderWidth: itemBorderWidth ?? this.itemBorderWidth,
      itemSelectedBorderWidth:
          itemSelectedBorderWidth ?? this.itemSelectedBorderWidth,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemPadding: itemPadding ?? this.itemPadding,
      itemMargin: itemMargin ?? this.itemMargin,
      itemTitleStyle: itemTitleStyle ?? this.itemTitleStyle,
      itemDescriptionStyle: itemDescriptionStyle ?? this.itemDescriptionStyle,
      checkboxActiveColor: checkboxActiveColor ?? this.checkboxActiveColor,
      checkboxCheckColor: checkboxCheckColor ?? this.checkboxCheckColor,
      operationButtonBackgroundColor:
          operationButtonBackgroundColor ?? this.operationButtonBackgroundColor,
      disabledOperationButtonBackgroundColor:
          disabledOperationButtonBackgroundColor ??
              this.disabledOperationButtonBackgroundColor,
      operationButtonBorderColor:
          operationButtonBorderColor ?? this.operationButtonBorderColor,
      disabledOperationButtonBorderColor: disabledOperationButtonBorderColor ??
          this.disabledOperationButtonBorderColor,
      operationButtonBorderWidth:
          operationButtonBorderWidth ?? this.operationButtonBorderWidth,
      operationButtonBorderRadius:
          operationButtonBorderRadius ?? this.operationButtonBorderRadius,
      operationButtonWidth: operationButtonWidth ?? this.operationButtonWidth,
      operationButtonHeight:
          operationButtonHeight ?? this.operationButtonHeight,
      operationTextStyle: operationTextStyle ?? this.operationTextStyle,
      disabledOperationTextStyle:
          disabledOperationTextStyle ?? this.disabledOperationTextStyle,
      operationIconSize: operationIconSize ?? this.operationIconSize,
      operationIconColor: operationIconColor ?? this.operationIconColor,
      disabledOperationIconColor:
          disabledOperationIconColor ?? this.disabledOperationIconColor,
      operationIconSpacing: operationIconSpacing ?? this.operationIconSpacing,
      operationSpacing: operationSpacing ?? this.operationSpacing,
      operationsPadding: operationsPadding ?? this.operationsPadding,
      footerBorderColor: footerBorderColor ?? this.footerBorderColor,
      footerBorderWidth: footerBorderWidth ?? this.footerBorderWidth,
      footerPadding: footerPadding ?? this.footerPadding,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      searchFillColor: searchFillColor ?? this.searchFillColor,
      searchHintStyle: searchHintStyle ?? this.searchHintStyle,
      searchTextStyle: searchTextStyle ?? this.searchTextStyle,
      searchIconSize: searchIconSize ?? this.searchIconSize,
      searchIconColor: searchIconColor ?? this.searchIconColor,
      searchBorderRadius: searchBorderRadius ?? this.searchBorderRadius,
      searchContentPadding: searchContentPadding ?? this.searchContentPadding,
    );
  }

  /// 合并另一个主题
  ZephyrTransferTheme merge(ZephyrTransferTheme other) {
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      headerBackgroundColor: other.headerBackgroundColor,
      headerBorderColor: other.headerBorderColor,
      headerBorderWidth: other.headerBorderWidth,
      headerPadding: other.headerPadding,
      headerTextStyle: other.headerTextStyle,
      listBorderColor: other.listBorderColor,
      listBorderWidth: other.listBorderWidth,
      listBorderRadius: other.listBorderRadius,
      listPadding: other.listPadding,
      itemBackgroundColor: other.itemBackgroundColor,
      itemSelectedBackgroundColor: other.itemSelectedBackgroundColor,
      itemBorderColor: other.itemBorderColor,
      itemSelectedBorderColor: other.itemSelectedBorderColor,
      itemBorderWidth: other.itemBorderWidth,
      itemSelectedBorderWidth: other.itemSelectedBorderWidth,
      itemBorderRadius: other.itemBorderRadius,
      itemPadding: other.itemPadding,
      itemMargin: other.itemMargin,
      itemTitleStyle: other.itemTitleStyle,
      itemDescriptionStyle: other.itemDescriptionStyle,
      checkboxActiveColor: other.checkboxActiveColor,
      checkboxCheckColor: other.checkboxCheckColor,
      operationButtonBackgroundColor: other.operationButtonBackgroundColor,
      disabledOperationButtonBackgroundColor:
          other.disabledOperationButtonBackgroundColor,
      operationButtonBorderColor: other.operationButtonBorderColor,
      disabledOperationButtonBorderColor:
          other.disabledOperationButtonBorderColor,
      operationButtonBorderWidth: other.operationButtonBorderWidth,
      operationButtonBorderRadius: other.operationButtonBorderRadius,
      operationButtonWidth: other.operationButtonWidth,
      operationButtonHeight: other.operationButtonHeight,
      operationTextStyle: other.operationTextStyle,
      disabledOperationTextStyle: other.disabledOperationTextStyle,
      operationIconSize: other.operationIconSize,
      operationIconColor: other.operationIconColor,
      disabledOperationIconColor: other.disabledOperationIconColor,
      operationIconSpacing: other.operationIconSpacing,
      operationSpacing: other.operationSpacing,
      operationsPadding: other.operationsPadding,
      footerBorderColor: other.footerBorderColor,
      footerBorderWidth: other.footerBorderWidth,
      footerPadding: other.footerPadding,
      emptyTextStyle: other.emptyTextStyle,
      searchFillColor: other.searchFillColor,
      searchHintStyle: other.searchHintStyle,
      searchTextStyle: other.searchTextStyle,
      searchIconSize: other.searchIconSize,
      searchIconColor: other.searchIconColor,
      searchBorderRadius: other.searchBorderRadius,
      searchContentPadding: other.searchContentPadding,
    );
  }

  /// 解析主题
  static ZephyrTransferTheme resolve(
      BuildContext context, ZephyrTransferTheme? theme) {
    if (theme != null) return theme;

    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? ZephyrTransferTheme.dark()
        : ZephyrTransferTheme.light();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrTransferTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.headerBackgroundColor == headerBackgroundColor &&
        other.headerBorderColor == headerBorderColor &&
        other.headerBorderWidth == headerBorderWidth &&
        other.headerPadding == headerPadding &&
        other.headerTextStyle == headerTextStyle &&
        other.listBorderColor == listBorderColor &&
        other.listBorderWidth == listBorderWidth &&
        other.listBorderRadius == listBorderRadius &&
        other.listPadding == listPadding &&
        other.itemBackgroundColor == itemBackgroundColor &&
        other.itemSelectedBackgroundColor == itemSelectedBackgroundColor &&
        other.itemBorderColor == itemBorderColor &&
        other.itemSelectedBorderColor == itemSelectedBorderColor &&
        other.itemBorderWidth == itemBorderWidth &&
        other.itemSelectedBorderWidth == itemSelectedBorderWidth &&
        other.itemBorderRadius == itemBorderRadius &&
        other.itemPadding == itemPadding &&
        other.itemMargin == itemMargin &&
        other.itemTitleStyle == itemTitleStyle &&
        other.itemDescriptionStyle == itemDescriptionStyle &&
        other.checkboxActiveColor == checkboxActiveColor &&
        other.checkboxCheckColor == checkboxCheckColor &&
        other.operationButtonBackgroundColor ==
            operationButtonBackgroundColor &&
        other.disabledOperationButtonBackgroundColor ==
            disabledOperationButtonBackgroundColor &&
        other.operationButtonBorderColor == operationButtonBorderColor &&
        other.disabledOperationButtonBorderColor ==
            disabledOperationButtonBorderColor &&
        other.operationButtonBorderWidth == operationButtonBorderWidth &&
        other.operationButtonBorderRadius == operationButtonBorderRadius &&
        other.operationButtonWidth == operationButtonWidth &&
        other.operationButtonHeight == operationButtonHeight &&
        other.operationTextStyle == operationTextStyle &&
        other.disabledOperationTextStyle == disabledOperationTextStyle &&
        other.operationIconSize == operationIconSize &&
        other.operationIconColor == operationIconColor &&
        other.disabledOperationIconColor == disabledOperationIconColor &&
        other.operationIconSpacing == operationIconSpacing &&
        other.operationSpacing == operationSpacing &&
        other.operationsPadding == operationsPadding &&
        other.footerBorderColor == footerBorderColor &&
        other.footerBorderWidth == footerBorderWidth &&
        other.footerPadding == footerPadding &&
        other.emptyTextStyle == emptyTextStyle &&
        other.searchFillColor == searchFillColor &&
        other.searchHintStyle == searchHintStyle &&
        other.searchTextStyle == searchTextStyle &&
        other.searchIconSize == searchIconSize &&
        other.searchIconColor == searchIconColor &&
        other.searchBorderRadius == searchBorderRadius &&
        other.searchContentPadding == searchContentPadding;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      headerBackgroundColor,
      headerBorderColor,
      headerBorderWidth,
      headerPadding,
      headerTextStyle,
      listBorderColor,
      listBorderWidth,
      listBorderRadius,
      listPadding,
      itemBackgroundColor,
      itemSelectedBackgroundColor,
      itemBorderColor,
      itemSelectedBorderColor,
      itemBorderWidth,
      itemSelectedBorderWidth,
      itemBorderRadius,
      itemPadding,
      itemMargin,
      itemTitleStyle,
      itemDescriptionStyle,
      checkboxActiveColor,
      checkboxCheckColor,
      operationButtonBackgroundColor,
      disabledOperationButtonBackgroundColor,
      operationButtonBorderColor,
      disabledOperationButtonBorderColor,
      operationButtonBorderWidth,
      operationButtonBorderRadius,
      operationButtonWidth,
      operationButtonHeight,
      operationTextStyle,
      disabledOperationTextStyle,
      operationIconSize,
      operationIconColor,
      disabledOperationIconColor,
      operationIconSpacing,
      operationSpacing,
      operationsPadding,
      footerBorderColor,
      footerBorderWidth,
      footerPadding,
      emptyTextStyle,
      searchFillColor,
      searchHintStyle,
      searchTextStyle,
      searchIconSize,
      searchIconColor,
      searchBorderRadius,
      searchContentPadding,
    ]);
  }
}
