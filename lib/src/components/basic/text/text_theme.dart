import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 定义ZephyrText的视觉属性
///
/// 此主题用于ZephyrText组件确定视觉样式，包括颜色、大小、字重等。
class ZephyrTextTheme extends ThemeExtension<ZephyrTextTheme> {
  const ZephyrTextTheme({
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.primaryColor,
    required this.secondaryColor,
    required this.errorColor,
    required this.disabledColor,
  });

  /// 大号标题文本样式
  final TextStyle headlineLarge;

  /// 中号标题文本样式
  final TextStyle headlineMedium;

  /// 小号标题文本样式
  final TextStyle headlineSmall;

  /// 大号标题文本样式
  final TextStyle titleLarge;

  /// 中号标题文本样式
  final TextStyle titleMedium;

  /// 小号标题文本样式
  final TextStyle titleSmall;

  /// 大号正文文本样式
  final TextStyle bodyLarge;

  /// 中号正文文本样式
  final TextStyle bodyMedium;

  /// 小号正文文本样式
  final TextStyle bodySmall;

  /// 大号标签文本样式
  final TextStyle labelLarge;

  /// 中号标签文本样式
  final TextStyle labelMedium;

  /// 小号标签文本样式
  final TextStyle labelSmall;

  /// 主要文本颜色
  final Color primaryColor;

  /// 次要文本颜色
  final Color secondaryColor;

  /// 错误文本颜色
  final Color errorColor;

  /// 禁用状态文本颜色
  final Color disabledColor;

  /// 从上下文获取主题
  static ZephyrTextTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrTextTheme>();
    if (theme != null) return theme;

    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// 解析主题
  static ZephyrTextTheme resolve(
    BuildContext context,
    ZephyrTextTheme? theme,
  ) {
    if (theme != null) {
      return theme;
    }
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// 合并主题
  ZephyrTextTheme merge(ZephyrTextTheme? other) {
    if (other == null) return this;
    return copyWith(
      headlineLarge: other.headlineLarge,
      headlineMedium: other.headlineMedium,
      headlineSmall: other.headlineSmall,
      titleLarge: other.titleLarge,
      titleMedium: other.titleMedium,
      titleSmall: other.titleSmall,
      bodyLarge: other.bodyLarge,
      bodyMedium: other.bodyMedium,
      bodySmall: other.bodySmall,
      labelLarge: other.labelLarge,
      labelMedium: other.labelMedium,
      labelSmall: other.labelSmall,
      primaryColor: other.primaryColor,
      secondaryColor: other.secondaryColor,
      errorColor: other.errorColor,
      disabledColor: other.disabledColor,
    );
  }

  /// 创建默认主题
  static ZephyrTextTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;
    final textTheme = Theme.of(zephyrTheme.context!).textTheme;

    return ZephyrTextTheme(
      headlineLarge: textTheme.headlineLarge ?? TextStyle(
        fontSize: ZephyrTypography.fontSize32,
        fontWeight: ZephyrTypography.fontWeightBold,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_2,
      ),
      headlineMedium: textTheme.headlineMedium ?? TextStyle(
        fontSize: ZephyrTypography.fontSize28,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_3,
      ),
      headlineSmall: textTheme.headlineSmall ?? TextStyle(
        fontSize: ZephyrTypography.fontSize24,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_3,
      ),
      titleLarge: textTheme.titleLarge ?? TextStyle(
        fontSize: ZephyrTypography.fontSize22,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_3,
      ),
      titleMedium: textTheme.titleMedium ?? TextStyle(
        fontSize: ZephyrTypography.fontSize18,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_4,
      ),
      titleSmall: textTheme.titleSmall ?? TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_4,
      ),
      bodyLarge: textTheme.bodyLarge ?? TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_5,
      ),
      bodyMedium: textTheme.bodyMedium ?? TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral200 : ZephyrColors.neutral800,
        height: ZephyrTypography.lineHeight1_5,
      ),
      bodySmall: textTheme.bodySmall ?? TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral700,
        height: ZephyrTypography.lineHeight1_4,
      ),
      labelLarge: textTheme.labelLarge ?? TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral200 : ZephyrColors.neutral700,
        height: ZephyrTypography.lineHeight1_2,
      ),
      labelMedium: textTheme.labelMedium ?? TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral600,
        height: ZephyrTypography.lineHeight1_2,
      ),
      labelSmall: textTheme.labelSmall ?? TextStyle(
        fontSize: ZephyrTypography.fontSize11,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral500,
        height: ZephyrTypography.lineHeight1_2,
      ),
      primaryColor: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
      secondaryColor: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral600,
      errorColor: ZephyrColors.error500,
      disabledColor: isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
    );
  }

  @override
  ZephyrTextTheme copyWith({
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    Color? primaryColor,
    Color? secondaryColor,
    Color? errorColor,
    Color? disabledColor,
  }) {
    return ZephyrTextTheme(
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      errorColor: errorColor ?? this.errorColor,
      disabledColor: disabledColor ?? this.disabledColor,
    );
  }

  @override
  ZephyrTextTheme lerp(ThemeExtension<ZephyrTextTheme>? other, double t) {
    if (other is! ZephyrTextTheme) return this;

    return ZephyrTextTheme(
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t) ?? headlineLarge,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t) ?? headlineMedium,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t) ?? headlineSmall,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t) ?? titleLarge,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t) ?? titleMedium,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t) ?? titleSmall,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t) ?? bodyLarge,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t) ?? bodyMedium,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t) ?? bodySmall,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t) ?? labelLarge,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t) ?? labelMedium,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t) ?? labelSmall,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t) ?? primaryColor,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t) ?? secondaryColor,
      errorColor: Color.lerp(errorColor, other.errorColor, t) ?? errorColor,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t) ?? disabledColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrTextTheme &&
        other.headlineLarge == headlineLarge &&
        other.headlineMedium == headlineMedium &&
        other.headlineSmall == headlineSmall &&
        other.titleLarge == titleLarge &&
        other.titleMedium == titleMedium &&
        other.titleSmall == titleSmall &&
        other.bodyLarge == bodyLarge &&
        other.bodyMedium == bodyMedium &&
        other.bodySmall == bodySmall &&
        other.labelLarge == labelLarge &&
        other.labelMedium == labelMedium &&
        other.labelSmall == labelSmall &&
        other.primaryColor == primaryColor &&
        other.secondaryColor == secondaryColor &&
        other.errorColor == errorColor &&
        other.disabledColor == disabledColor;
  }

  @override
  int get hashCode => Object.hash(
        headlineLarge,
        headlineMedium,
        headlineSmall,
        titleLarge,
        titleMedium,
        titleSmall,
        Object.hash(
          bodyLarge,
          bodyMedium,
          bodySmall,
          labelLarge,
          labelMedium,
          labelSmall,
          primaryColor,
          secondaryColor,
          errorColor,
          disabledColor,
        ),
      );
}
