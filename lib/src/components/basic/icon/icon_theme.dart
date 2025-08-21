import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

// Import lerpDouble from dart:ui instead of custom implementation
import 'dart:ui' as ui;

/// 定义ZephyrIcon的视觉属性
///
/// 此主题用于ZephyrIcon组件确定视觉样式，包括颜色、大小和不同状态下的样式。
class ZephyrIconTheme extends ThemeExtension<ZephyrIconTheme> {
  const ZephyrIconTheme({
    required this.defaultColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.errorColor,
    required this.warningColor,
    required this.successColor,
    required this.infoColor,
    required this.disabledColor,
    required this.defaultSize,
    required this.smallSize,
    required this.mediumSize,
    required this.largeSize,
  });

  /// 默认图标颜色
  final Color defaultColor;

  /// 主要图标颜色
  final Color primaryColor;

  /// 次要图标颜色
  final Color secondaryColor;

  /// 错误状态图标颜色
  final Color errorColor;

  /// 警告状态图标颜色
  final Color warningColor;

  /// 成功状态图标颜色
  final Color successColor;

  /// 信息状态图标颜色
  final Color infoColor;

  /// 禁用状态图标颜色
  final Color disabledColor;

  /// 默认图标尺寸
  final double defaultSize;

  /// 小型图标尺寸
  final double smallSize;

  /// 中型图标尺寸
  final double mediumSize;

  /// 大型图标尺寸
  final double largeSize;

  /// 从上下文获取主题
  static ZephyrIconTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrIconTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// 解析主题
  static ZephyrIconTheme resolve(
    BuildContext context,
    ZephyrIconTheme? theme,
  ) {
    if (theme != null) {
      return theme;
    }
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// 创建默认主题
  static ZephyrIconTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    return ZephyrIconTheme(
      defaultColor: isDark ? ZephyrColors.neutral200 : ZephyrColors.neutral700,
      primaryColor: zephyrTheme.primaryColor,
      secondaryColor: zephyrTheme.secondaryColor,
      errorColor: ZephyrColors.error500,
      warningColor: ZephyrColors.warning500,
      successColor: ZephyrColors.success500,
      infoColor: ZephyrColors.info500,
      disabledColor: isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
      defaultSize: 24.0,
      smallSize: 16.0,
      mediumSize: 24.0,
      largeSize: 32.0,
    );
  }

  @override
  ZephyrIconTheme copyWith({
    Color? defaultColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? errorColor,
    Color? warningColor,
    Color? successColor,
    Color? infoColor,
    Color? disabledColor,
    double? defaultSize,
    double? smallSize,
    double? mediumSize,
    double? largeSize,
  }) {
    return ZephyrIconTheme(
      defaultColor: defaultColor ?? this.defaultColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      errorColor: errorColor ?? this.errorColor,
      warningColor: warningColor ?? this.warningColor,
      successColor: successColor ?? this.successColor,
      infoColor: infoColor ?? this.infoColor,
      disabledColor: disabledColor ?? this.disabledColor,
      defaultSize: defaultSize ?? this.defaultSize,
      smallSize: smallSize ?? this.smallSize,
      mediumSize: mediumSize ?? this.mediumSize,
      largeSize: largeSize ?? this.largeSize,
    );
  }

  @override
  ZephyrIconTheme lerp(ThemeExtension<ZephyrIconTheme>? other, double t) {
    if (other is! ZephyrIconTheme) return this;
    
    return ZephyrIconTheme(
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t) ?? defaultColor,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t) ?? primaryColor,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t) ?? secondaryColor,
      errorColor: Color.lerp(errorColor, other.errorColor, t) ?? errorColor,
      warningColor: Color.lerp(warningColor, other.warningColor, t) ?? warningColor,
      successColor: Color.lerp(successColor, other.successColor, t) ?? successColor,
      infoColor: Color.lerp(infoColor, other.infoColor, t) ?? infoColor,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t) ?? disabledColor,
      defaultSize: ui.lerpDouble(defaultSize, other.defaultSize, t) ?? defaultSize,
      smallSize: ui.lerpDouble(smallSize, other.smallSize, t) ?? smallSize,
      mediumSize: ui.lerpDouble(mediumSize, other.mediumSize, t) ?? mediumSize,
      largeSize: ui.lerpDouble(largeSize, other.largeSize, t) ?? largeSize,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrIconTheme &&
        other.defaultColor == defaultColor &&
        other.primaryColor == primaryColor &&
        other.secondaryColor == secondaryColor &&
        other.errorColor == errorColor &&
        other.warningColor == warningColor &&
        other.successColor == successColor &&
        other.infoColor == infoColor &&
        other.disabledColor == disabledColor &&
        other.defaultSize == defaultSize &&
        other.smallSize == smallSize &&
        other.mediumSize == mediumSize &&
        other.largeSize == largeSize;
  }

  @override
  int get hashCode => Object.hash(
        defaultColor,
        primaryColor,
        secondaryColor,
        Object.hash(
          errorColor,
          warningColor,
          successColor,
          infoColor,
          disabledColor,
          defaultSize,
          smallSize,
          mediumSize,
          largeSize,
        ),
      );
}
