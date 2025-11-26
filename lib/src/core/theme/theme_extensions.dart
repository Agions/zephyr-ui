/// ZephyrUI 主题扩展系统
///
/// 提供统一的主题扩展，用于访问设计令牌和自定义主题属性
library theme_extensions;

import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'design_tokens.dart';

/// 颜色主题扩展
@immutable
class ZephyrColorsExtension extends ThemeExtension<ZephyrColorsExtension> {
  const ZephyrColorsExtension({
    required this.primary,
    required this.primaryContainer,
    required this.onPrimary,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.onSecondary,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.tertiaryContainer,
    required this.onTertiary,
    required this.onTertiaryContainer,
    required this.error,
    required this.errorContainer,
    required this.onError,
    required this.onErrorContainer,
    required this.outline,
    required this.outlineVariant,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.shadow,
    required this.scrim,
    required this.success,
    required this.successContainer,
    required this.onSuccess,
    required this.onSuccessContainer,
    required this.warning,
    required this.warningContainer,
    required this.onWarning,
    required this.onWarningContainer,
    required this.info,
    required this.infoContainer,
    required this.onInfo,
    required this.onInfoContainer,
  });

  final Color primary;
  final Color primaryContainer;
  final Color onPrimary;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color secondaryContainer;
  final Color onSecondary;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color tertiaryContainer;
  final Color onTertiary;
  final Color onTertiaryContainer;
  final Color error;
  final Color errorContainer;
  final Color onError;
  final Color onErrorContainer;
  final Color outline;
  final Color outlineVariant;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;
  final Color shadow;
  final Color scrim;
  final Color success;
  final Color successContainer;
  final Color onSuccess;
  final Color onSuccessContainer;
  final Color warning;
  final Color warningContainer;
  final Color onWarning;
  final Color onWarningContainer;
  final Color info;
  final Color infoContainer;
  final Color onInfo;
  final Color onInfoContainer;

  /// 创建亮色主题的颜色扩展
  static const light = ZephyrColorsExtension(
    primary: ZephyrColorTokens.primary50,
    primaryContainer: ZephyrColorTokens.primary90,
    onPrimary: ZephyrColorTokens.primary100,
    onPrimaryContainer: ZephyrColorTokens.primary10,
    secondary: ZephyrColorTokens.secondary50,
    secondaryContainer: ZephyrColorTokens.secondary90,
    onSecondary: ZephyrColorTokens.secondary100,
    onSecondaryContainer: ZephyrColorTokens.secondary10,
    tertiary: ZephyrColorTokens.primary40,
    tertiaryContainer: ZephyrColorTokens.primary90,
    onTertiary: ZephyrColorTokens.primary100,
    onTertiaryContainer: ZephyrColorTokens.primary10,
    error: ZephyrColorTokens.error50,
    errorContainer: ZephyrColorTokens.error90,
    onError: ZephyrColorTokens.error100,
    onErrorContainer: ZephyrColorTokens.error10,
    outline: ZephyrColorTokens.neutral50,
    outlineVariant: ZephyrColorTokens.neutral80,
    surface: ZephyrColorTokens.neutral98,
    onSurface: ZephyrColorTokens.neutral10,
    surfaceVariant: ZephyrColorTokens.neutral90,
    onSurfaceVariant: ZephyrColorTokens.neutral30,
    inverseSurface: ZephyrColorTokens.neutral20,
    onInverseSurface: ZephyrColorTokens.neutral95,
    inversePrimary: ZephyrColorTokens.primary80,
    shadow: ZephyrColorTokens.neutral0,
    scrim: ZephyrColorTokens.neutral0,
    success: ZephyrColorTokens.success50,
    successContainer: ZephyrColorTokens.success90,
    onSuccess: ZephyrColorTokens.success100,
    onSuccessContainer: ZephyrColorTokens.success10,
    warning: ZephyrColorTokens.warning50,
    warningContainer: ZephyrColorTokens.warning90,
    onWarning: ZephyrColorTokens.warning100,
    onWarningContainer: ZephyrColorTokens.warning10,
    info: ZephyrColorTokens.info50,
    infoContainer: ZephyrColorTokens.info90,
    onInfo: ZephyrColorTokens.info100,
    onInfoContainer: ZephyrColorTokens.info10,
  );

  /// 创建暗色主题的颜色扩展
  static const dark = ZephyrColorsExtension(
    primary: ZephyrColorTokens.primary80,
    primaryContainer: ZephyrColorTokens.primary30,
    onPrimary: ZephyrColorTokens.primary20,
    onPrimaryContainer: ZephyrColorTokens.primary90,
    secondary: ZephyrColorTokens.secondary80,
    secondaryContainer: ZephyrColorTokens.secondary30,
    onSecondary: ZephyrColorTokens.secondary20,
    onSecondaryContainer: ZephyrColorTokens.secondary90,
    tertiary: ZephyrColorTokens.primary80,
    tertiaryContainer: ZephyrColorTokens.primary30,
    onTertiary: ZephyrColorTokens.primary20,
    onTertiaryContainer: ZephyrColorTokens.primary90,
    error: ZephyrColorTokens.error80,
    errorContainer: ZephyrColorTokens.error30,
    onError: ZephyrColorTokens.error20,
    onErrorContainer: ZephyrColorTokens.error90,
    outline: ZephyrColorTokens.neutral60,
    outlineVariant: ZephyrColorTokens.neutral30,
    surface: ZephyrColorTokens.neutral6,
    onSurface: ZephyrColorTokens.neutral90,
    surfaceVariant: ZephyrColorTokens.neutral30,
    onSurfaceVariant: ZephyrColorTokens.neutral80,
    inverseSurface: ZephyrColorTokens.neutral90,
    onInverseSurface: ZephyrColorTokens.neutral20,
    inversePrimary: ZephyrColorTokens.primary40,
    shadow: ZephyrColorTokens.neutral0,
    scrim: ZephyrColorTokens.neutral0,
    success: ZephyrColorTokens.success80,
    successContainer: ZephyrColorTokens.success30,
    onSuccess: ZephyrColorTokens.success20,
    onSuccessContainer: ZephyrColorTokens.success90,
    warning: ZephyrColorTokens.warning80,
    warningContainer: ZephyrColorTokens.warning30,
    onWarning: ZephyrColorTokens.warning20,
    onWarningContainer: ZephyrColorTokens.warning90,
    info: ZephyrColorTokens.info80,
    infoContainer: ZephyrColorTokens.info30,
    onInfo: ZephyrColorTokens.info20,
    onInfoContainer: ZephyrColorTokens.info90,
  );

  @override
  ZephyrColorsExtension copyWith({
    Color? primary,
    Color? primaryContainer,
    Color? onPrimary,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? secondaryContainer,
    Color? onSecondary,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? tertiaryContainer,
    Color? onTertiary,
    Color? onTertiaryContainer,
    Color? error,
    Color? errorContainer,
    Color? onError,
    Color? onErrorContainer,
    Color? outline,
    Color? outlineVariant,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? shadow,
    Color? scrim,
    Color? success,
    Color? successContainer,
    Color? onSuccess,
    Color? onSuccessContainer,
    Color? warning,
    Color? warningContainer,
    Color? onWarning,
    Color? onWarningContainer,
    Color? info,
    Color? infoContainer,
    Color? onInfo,
    Color? onInfoContainer,
  }) {
    return ZephyrColorsExtension(
      primary: primary ?? this.primary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimary: onPrimary ?? this.onPrimary,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondary: onSecondary ?? this.onSecondary,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiary: onTertiary ?? this.onTertiary,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      error: error ?? this.error,
      errorContainer: errorContainer ?? this.errorContainer,
      onError: onError ?? this.onError,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      onSuccess: onSuccess ?? this.onSuccess,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarning: onWarning ?? this.onWarning,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfo: onInfo ?? this.onInfo,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
    );
  }

  @override
  ZephyrColorsExtension lerp(ThemeExtension<ZephyrColorsExtension>? other, double t) {
    if (other is! ZephyrColorsExtension) {
      return this;
    }
    return ZephyrColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      onPrimaryContainer: Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryContainer: Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      onSecondaryContainer: Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      tertiaryContainer: Color.lerp(tertiaryContainer, other.tertiaryContainer, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      onTertiaryContainer: Color.lerp(onTertiaryContainer, other.onTertiaryContainer, t)!,
      error: Color.lerp(error, other.error, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      onErrorContainer: Color.lerp(onErrorContainer, other.onErrorContainer, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant: Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      onInverseSurface: Color.lerp(onInverseSurface, other.onInverseSurface, t)!,
      inversePrimary: Color.lerp(inversePrimary, other.inversePrimary, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      success: Color.lerp(success, other.success, t)!,
      successContainer: Color.lerp(successContainer, other.successContainer, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      onInfoContainer: Color.lerp(onInfoContainer, other.onInfoContainer, t)!,
    );
  }
}

/// 间距主题扩展
@immutable
class ZephyrSpacingExtension extends ThemeExtension<ZephyrSpacingExtension> {
  const ZephyrSpacingExtension({
    required this.nano,
    required this.micro,
    required this.tiny,
    required this.small,
    required this.medium,
    required this.regular,
    required this.large,
    required this.extraLarge,
    required this.huge,
    required this.massive,
    required this.gigantic,
    required this.componentGap,
    required this.sectionGap,
    required this.pagePadding,
    required this.dialogPadding,
  });

  final double nano;
  final double micro;
  final double tiny;
  final double small;
  final double medium;
  final double regular;
  final double large;
  final double extraLarge;
  final double huge;
  final double massive;
  final double gigantic;
  final double componentGap;
  final double sectionGap;
  final double pagePadding;
  final double dialogPadding;

  /// 创建亮色主题的间距扩展
  static const light = ZephyrSpacingExtension(
    nano: ZephyrSpacingTokens.nano,
    micro: ZephyrSpacingTokens.micro,
    tiny: ZephyrSpacingTokens.tiny,
    small: ZephyrSpacingTokens.small,
    medium: ZephyrSpacingTokens.medium,
    regular: ZephyrSpacingTokens.regular,
    large: ZephyrSpacingTokens.large,
    extraLarge: ZephyrSpacingTokens.extraLarge,
    huge: ZephyrSpacingTokens.huge,
    massive: ZephyrSpacingTokens.massive,
    gigantic: ZephyrSpacingTokens.gigantic,
    componentGap: ZephyrSpacingTokens.componentGap,
    sectionGap: ZephyrSpacingTokens.sectionGap,
    pagePadding: ZephyrSpacingTokens.pagePadding,
    dialogPadding: ZephyrSpacingTokens.dialogPadding,
  );

  /// 创建暗色主题的间距扩展
  static const dark = ZephyrSpacingExtension(
    nano: ZephyrSpacingTokens.nano,
    micro: ZephyrSpacingTokens.micro,
    tiny: ZephyrSpacingTokens.tiny,
    small: ZephyrSpacingTokens.small,
    medium: ZephyrSpacingTokens.medium,
    regular: ZephyrSpacingTokens.regular,
    large: ZephyrSpacingTokens.large,
    extraLarge: ZephyrSpacingTokens.extraLarge,
    huge: ZephyrSpacingTokens.huge,
    massive: ZephyrSpacingTokens.massive,
    gigantic: ZephyrSpacingTokens.gigantic,
    componentGap: ZephyrSpacingTokens.componentGap,
    sectionGap: ZephyrSpacingTokens.sectionGap,
    pagePadding: ZephyrSpacingTokens.pagePadding,
    dialogPadding: ZephyrSpacingTokens.dialogPadding,
  );

  @override
  ZephyrSpacingExtension copyWith({
    double? nano,
    double? micro,
    double? tiny,
    double? small,
    double? medium,
    double? regular,
    double? large,
    double? extraLarge,
    double? huge,
    double? massive,
    double? gigantic,
    double? componentGap,
    double? sectionGap,
    double? pagePadding,
    double? dialogPadding,
  }) {
    return ZephyrSpacingExtension(
      nano: nano ?? this.nano,
      micro: micro ?? this.micro,
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      regular: regular ?? this.regular,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
      huge: huge ?? this.huge,
      massive: massive ?? this.massive,
      gigantic: gigantic ?? this.gigantic,
      componentGap: componentGap ?? this.componentGap,
      sectionGap: sectionGap ?? this.sectionGap,
      pagePadding: pagePadding ?? this.pagePadding,
      dialogPadding: dialogPadding ?? this.dialogPadding,
    );
  }

  @override
  ZephyrSpacingExtension lerp(ThemeExtension<ZephyrSpacingExtension>? other, double t) {
    if (other is! ZephyrSpacingExtension) {
      return this;
    }
    return ZephyrSpacingExtension(
      nano: lerpDouble(nano, other.nano, t)!,
      micro: lerpDouble(micro, other.micro, t)!,
      tiny: lerpDouble(tiny, other.tiny, t)!,
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      regular: lerpDouble(regular, other.regular, t)!,
      large: lerpDouble(large, other.large, t)!,
      extraLarge: lerpDouble(extraLarge, other.extraLarge, t)!,
      huge: lerpDouble(huge, other.huge, t)!,
      massive: lerpDouble(massive, other.massive, t)!,
      gigantic: lerpDouble(gigantic, other.gigantic, t)!,
      componentGap: lerpDouble(componentGap, other.componentGap, t)!,
      sectionGap: lerpDouble(sectionGap, other.sectionGap, t)!,
      pagePadding: lerpDouble(pagePadding, other.pagePadding, t)!,
      dialogPadding: lerpDouble(dialogPadding, other.dialogPadding, t)!,
    );
  }
}

/// 字体主题扩展
@immutable
class ZephyrTypographyExtension extends ThemeExtension<ZephyrTypographyExtension> {
  const ZephyrTypographyExtension({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
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
    required this.lineHeightTight,
    required this.lineHeightNormal,
    required this.lineHeightRelaxed,
    required this.lineHeightLoose,
    required this.weightThin,
    required this.weightExtraLight,
    required this.weightLight,
    required this.weightRegular,
    required this.weightMedium,
    required this.weightSemiBold,
    required this.weightBold,
    required this.weightExtraBold,
    required this.weightBlack,
    required this.letterSpacingTight,
    required this.letterSpacingNormal,
    required this.letterSpacingWide,
    required this.letterSpacingExtraWide,
  });

  final double displayLarge;
  final double displayMedium;
  final double displaySmall;
  final double headlineLarge;
  final double headlineMedium;
  final double headlineSmall;
  final double titleLarge;
  final double titleMedium;
  final double titleSmall;
  final double bodyLarge;
  final double bodyMedium;
  final double bodySmall;
  final double labelLarge;
  final double labelMedium;
  final double labelSmall;
  final double lineHeightTight;
  final double lineHeightNormal;
  final double lineHeightRelaxed;
  final double lineHeightLoose;
  final FontWeight weightThin;
  final FontWeight weightExtraLight;
  final FontWeight weightLight;
  final FontWeight weightRegular;
  final FontWeight weightMedium;
  final FontWeight weightSemiBold;
  final FontWeight weightBold;
  final FontWeight weightExtraBold;
  final FontWeight weightBlack;
  final double letterSpacingTight;
  final double letterSpacingNormal;
  final double letterSpacingWide;
  final double letterSpacingExtraWide;

  /// 创建亮色主题的字体扩展
  static const light = ZephyrTypographyExtension(
    displayLarge: ZephyrTypographyTokens.displayLarge,
    displayMedium: ZephyrTypographyTokens.displayMedium,
    displaySmall: ZephyrTypographyTokens.displaySmall,
    headlineLarge: ZephyrTypographyTokens.headlineLarge,
    headlineMedium: ZephyrTypographyTokens.headlineMedium,
    headlineSmall: ZephyrTypographyTokens.headlineSmall,
    titleLarge: ZephyrTypographyTokens.titleLarge,
    titleMedium: ZephyrTypographyTokens.titleMedium,
    titleSmall: ZephyrTypographyTokens.titleSmall,
    bodyLarge: ZephyrTypographyTokens.bodyLarge,
    bodyMedium: ZephyrTypographyTokens.bodyMedium,
    bodySmall: ZephyrTypographyTokens.bodySmall,
    labelLarge: ZephyrTypographyTokens.labelLarge,
    labelMedium: ZephyrTypographyTokens.labelMedium,
    labelSmall: ZephyrTypographyTokens.labelSmall,
    lineHeightTight: ZephyrTypographyTokens.lineHeightTight,
    lineHeightNormal: ZephyrTypographyTokens.lineHeightNormal,
    lineHeightRelaxed: ZephyrTypographyTokens.lineHeightRelaxed,
    lineHeightLoose: ZephyrTypographyTokens.lineHeightLoose,
    weightThin: ZephyrTypographyTokens.weightThin,
    weightExtraLight: ZephyrTypographyTokens.weightExtraLight,
    weightLight: ZephyrTypographyTokens.weightLight,
    weightRegular: ZephyrTypographyTokens.weightRegular,
    weightMedium: ZephyrTypographyTokens.weightMedium,
    weightSemiBold: ZephyrTypographyTokens.weightSemiBold,
    weightBold: ZephyrTypographyTokens.weightBold,
    weightExtraBold: ZephyrTypographyTokens.weightExtraBold,
    weightBlack: ZephyrTypographyTokens.weightBlack,
    letterSpacingTight: ZephyrTypographyTokens.letterSpacingTight,
    letterSpacingNormal: ZephyrTypographyTokens.letterSpacingNormal,
    letterSpacingWide: ZephyrTypographyTokens.letterSpacingWide,
    letterSpacingExtraWide: ZephyrTypographyTokens.letterSpacingExtraWide,
  );

  /// 创建暗色主题的字体扩展
  static const dark = ZephyrTypographyExtension(
    displayLarge: ZephyrTypographyTokens.displayLarge,
    displayMedium: ZephyrTypographyTokens.displayMedium,
    displaySmall: ZephyrTypographyTokens.displaySmall,
    headlineLarge: ZephyrTypographyTokens.headlineLarge,
    headlineMedium: ZephyrTypographyTokens.headlineMedium,
    headlineSmall: ZephyrTypographyTokens.headlineSmall,
    titleLarge: ZephyrTypographyTokens.titleLarge,
    titleMedium: ZephyrTypographyTokens.titleMedium,
    titleSmall: ZephyrTypographyTokens.titleSmall,
    bodyLarge: ZephyrTypographyTokens.bodyLarge,
    bodyMedium: ZephyrTypographyTokens.bodyMedium,
    bodySmall: ZephyrTypographyTokens.bodySmall,
    labelLarge: ZephyrTypographyTokens.labelLarge,
    labelMedium: ZephyrTypographyTokens.labelMedium,
    labelSmall: ZephyrTypographyTokens.labelSmall,
    lineHeightTight: ZephyrTypographyTokens.lineHeightTight,
    lineHeightNormal: ZephyrTypographyTokens.lineHeightNormal,
    lineHeightRelaxed: ZephyrTypographyTokens.lineHeightRelaxed,
    lineHeightLoose: ZephyrTypographyTokens.lineHeightLoose,
    weightThin: ZephyrTypographyTokens.weightThin,
    weightExtraLight: ZephyrTypographyTokens.weightExtraLight,
    weightLight: ZephyrTypographyTokens.weightLight,
    weightRegular: ZephyrTypographyTokens.weightRegular,
    weightMedium: ZephyrTypographyTokens.weightMedium,
    weightSemiBold: ZephyrTypographyTokens.weightSemiBold,
    weightBold: ZephyrTypographyTokens.weightBold,
    weightExtraBold: ZephyrTypographyTokens.weightExtraBold,
    weightBlack: ZephyrTypographyTokens.weightBlack,
    letterSpacingTight: ZephyrTypographyTokens.letterSpacingTight,
    letterSpacingNormal: ZephyrTypographyTokens.letterSpacingNormal,
    letterSpacingWide: ZephyrTypographyTokens.letterSpacingWide,
    letterSpacingExtraWide: ZephyrTypographyTokens.letterSpacingExtraWide,
  );

  @override
  ZephyrTypographyExtension copyWith({
    double? displayLarge,
    double? displayMedium,
    double? displaySmall,
    double? headlineLarge,
    double? headlineMedium,
    double? headlineSmall,
    double? titleLarge,
    double? titleMedium,
    double? titleSmall,
    double? bodyLarge,
    double? bodyMedium,
    double? bodySmall,
    double? labelLarge,
    double? labelMedium,
    double? labelSmall,
    double? lineHeightTight,
    double? lineHeightNormal,
    double? lineHeightRelaxed,
    double? lineHeightLoose,
    FontWeight? weightThin,
    FontWeight? weightExtraLight,
    FontWeight? weightLight,
    FontWeight? weightRegular,
    FontWeight? weightMedium,
    FontWeight? weightSemiBold,
    FontWeight? weightBold,
    FontWeight? weightExtraBold,
    FontWeight? weightBlack,
    double? letterSpacingTight,
    double? letterSpacingNormal,
    double? letterSpacingWide,
    double? letterSpacingExtraWide,
  }) {
    return ZephyrTypographyExtension(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
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
      lineHeightTight: lineHeightTight ?? this.lineHeightTight,
      lineHeightNormal: lineHeightNormal ?? this.lineHeightNormal,
      lineHeightRelaxed: lineHeightRelaxed ?? this.lineHeightRelaxed,
      lineHeightLoose: lineHeightLoose ?? this.lineHeightLoose,
      weightThin: weightThin ?? this.weightThin,
      weightExtraLight: weightExtraLight ?? this.weightExtraLight,
      weightLight: weightLight ?? this.weightLight,
      weightRegular: weightRegular ?? this.weightRegular,
      weightMedium: weightMedium ?? this.weightMedium,
      weightSemiBold: weightSemiBold ?? this.weightSemiBold,
      weightBold: weightBold ?? this.weightBold,
      weightExtraBold: weightExtraBold ?? this.weightExtraBold,
      weightBlack: weightBlack ?? this.weightBlack,
      letterSpacingTight: letterSpacingTight ?? this.letterSpacingTight,
      letterSpacingNormal: letterSpacingNormal ?? this.letterSpacingNormal,
      letterSpacingWide: letterSpacingWide ?? this.letterSpacingWide,
      letterSpacingExtraWide: letterSpacingExtraWide ?? this.letterSpacingExtraWide,
    );
  }

  @override
  ZephyrTypographyExtension lerp(ThemeExtension<ZephyrTypographyExtension>? other, double t) {
    if (other is! ZephyrTypographyExtension) {
      return this;
    }
    return ZephyrTypographyExtension(
      displayLarge: lerpDouble(displayLarge, other.displayLarge, t)!,
      displayMedium: lerpDouble(displayMedium, other.displayMedium, t)!,
      displaySmall: lerpDouble(displaySmall, other.displaySmall, t)!,
      headlineLarge: lerpDouble(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: lerpDouble(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: lerpDouble(headlineSmall, other.headlineSmall, t)!,
      titleLarge: lerpDouble(titleLarge, other.titleLarge, t)!,
      titleMedium: lerpDouble(titleMedium, other.titleMedium, t)!,
      titleSmall: lerpDouble(titleSmall, other.titleSmall, t)!,
      bodyLarge: lerpDouble(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: lerpDouble(bodyMedium, other.bodyMedium, t)!,
      bodySmall: lerpDouble(bodySmall, other.bodySmall, t)!,
      labelLarge: lerpDouble(labelLarge, other.labelLarge, t)!,
      labelMedium: lerpDouble(labelMedium, other.labelMedium, t)!,
      labelSmall: lerpDouble(labelSmall, other.labelSmall, t)!,
      lineHeightTight: lerpDouble(lineHeightTight, other.lineHeightTight, t)!,
      lineHeightNormal: lerpDouble(lineHeightNormal, other.lineHeightNormal, t)!,
      lineHeightRelaxed: lerpDouble(lineHeightRelaxed, other.lineHeightRelaxed, t)!,
      lineHeightLoose: lerpDouble(lineHeightLoose, other.lineHeightLoose, t)!,
      weightThin: weightThin,
      weightExtraLight: weightExtraLight,
      weightLight: weightLight,
      weightRegular: weightRegular,
      weightMedium: weightMedium,
      weightSemiBold: weightSemiBold,
      weightBold: weightBold,
      weightExtraBold: weightExtraBold,
      weightBlack: weightBlack,
      letterSpacingTight: lerpDouble(letterSpacingTight, other.letterSpacingTight, t)!,
      letterSpacingNormal: lerpDouble(letterSpacingNormal, other.letterSpacingNormal, t)!,
      letterSpacingWide: lerpDouble(letterSpacingWide, other.letterSpacingWide, t)!,
      letterSpacingExtraWide: lerpDouble(letterSpacingExtraWide, other.letterSpacingExtraWide, t)!,
    );
  }
}

/// 圆角主题扩展
@immutable
class ZephyrBorderRadiusExtension extends ThemeExtension<ZephyrBorderRadiusExtension> {
  const ZephyrBorderRadiusExtension({
    required this.none,
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
    required this.circular,
  });

  final double none;
  final double extraSmall;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double circular;

  /// 创建亮色主题的圆角扩展
  static const light = ZephyrBorderRadiusExtension(
    none: ZephyrRadiusTokens.none,
    extraSmall: ZephyrRadiusTokens.extraSmall,
    small: ZephyrRadiusTokens.small,
    medium: ZephyrRadiusTokens.medium,
    large: ZephyrRadiusTokens.large,
    extraLarge: ZephyrRadiusTokens.extraLarge,
    circular: ZephyrRadiusTokens.circular,
  );

  /// 创建暗色主题的圆角扩展
  static const dark = ZephyrBorderRadiusExtension(
    none: ZephyrRadiusTokens.none,
    extraSmall: ZephyrRadiusTokens.extraSmall,
    small: ZephyrRadiusTokens.small,
    medium: ZephyrRadiusTokens.medium,
    large: ZephyrRadiusTokens.large,
    extraLarge: ZephyrRadiusTokens.extraLarge,
    circular: ZephyrRadiusTokens.circular,
  );

  @override
  ZephyrBorderRadiusExtension copyWith({
    double? none,
    double? extraSmall,
    double? small,
    double? medium,
    double? large,
    double? extraLarge,
    double? circular,
  }) {
    return ZephyrBorderRadiusExtension(
      none: none ?? this.none,
      extraSmall: extraSmall ?? this.extraSmall,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
      circular: circular ?? this.circular,
    );
  }

  @override
  ZephyrBorderRadiusExtension lerp(ThemeExtension<ZephyrBorderRadiusExtension>? other, double t) {
    if (other is! ZephyrBorderRadiusExtension) {
      return this;
    }
    return ZephyrBorderRadiusExtension(
      none: lerpDouble(none, other.none, t)!,
      extraSmall: lerpDouble(extraSmall, other.extraSmall, t)!,
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      large: lerpDouble(large, other.large, t)!,
      extraLarge: lerpDouble(extraLarge, other.extraLarge, t)!,
      circular: lerpDouble(circular, other.circular, t)!,
    );
  }
}

/// 阴影主题扩展
@immutable
class ZephyrShadowExtension extends ThemeExtension<ZephyrShadowExtension> {
  const ZephyrShadowExtension({
    required this.none,
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
  });

  final List<BoxShadow> none;
  final List<BoxShadow> extraSmall;
  final List<BoxShadow> small;
  final List<BoxShadow> medium;
  final List<BoxShadow> large;
  final List<BoxShadow> extraLarge;

  /// 创建亮色主题的阴影扩展
  static const light = ZephyrShadowExtension(
    none: ZephyrShadowTokens.none,
    extraSmall: ZephyrShadowTokens.extraSmall,
    small: ZephyrShadowTokens.small,
    medium: ZephyrShadowTokens.medium,
    large: ZephyrShadowTokens.large,
    extraLarge: ZephyrShadowTokens.extraLarge,
  );

  /// 创建暗色主题的阴影扩展
  static const dark = ZephyrShadowExtension(
    none: ZephyrShadowTokens.none,
    extraSmall: ZephyrShadowTokens.extraSmall,
    small: ZephyrShadowTokens.small,
    medium: ZephyrShadowTokens.medium,
    large: ZephyrShadowTokens.large,
    extraLarge: ZephyrShadowTokens.extraLarge,
  );

  @override
  ZephyrShadowExtension copyWith({
    List<BoxShadow>? none,
    List<BoxShadow>? extraSmall,
    List<BoxShadow>? small,
    List<BoxShadow>? medium,
    List<BoxShadow>? large,
    List<BoxShadow>? extraLarge,
  }) {
    return ZephyrShadowExtension(
      none: none ?? this.none,
      extraSmall: extraSmall ?? this.extraSmall,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
    );
  }

  @override
  ZephyrShadowExtension lerp(ThemeExtension<ZephyrShadowExtension>? other, double t) {
    if (other is! ZephyrShadowExtension) {
      return this;
    }
    return ZephyrShadowExtension(
      none: none,
      extraSmall: extraSmall,
      small: small,
      medium: medium,
      large: large,
      extraLarge: extraLarge,
    );
  }
}

/// 动画主题扩展
@immutable
class ZephyrAnimationExtension extends ThemeExtension<ZephyrAnimationExtension> {
  const ZephyrAnimationExtension({
    required this.ultraFast,
    required this.extraFast,
    required this.fast,
    required this.normal,
    required this.slow,
    required this.extraSlow,
    required this.ultraSlow,
    required this.linear,
    required this.easeIn,
    required this.easeOut,
    required this.easeInOut,
    required this.easeInQuad,
    required this.easeOutQuad,
    required this.easeInOutQuad,
    required this.easeInCubic,
    required this.easeOutCubic,
    required this.easeInOutCubic,
    required this.bounceIn,
    required this.bounceOut,
    required this.elasticIn,
    required this.elasticOut,
  });

  final Duration ultraFast;
  final Duration extraFast;
  final Duration fast;
  final Duration normal;
  final Duration slow;
  final Duration extraSlow;
  final Duration ultraSlow;
  final Curve linear;
  final Curve easeIn;
  final Curve easeOut;
  final Curve easeInOut;
  final Curve easeInQuad;
  final Curve easeOutQuad;
  final Curve easeInOutQuad;
  final Curve easeInCubic;
  final Curve easeOutCubic;
  final Curve easeInOutCubic;
  final Curve bounceIn;
  final Curve bounceOut;
  final Curve elasticIn;
  final Curve elasticOut;

  /// 创建亮色主题的动画扩展
  static const light = ZephyrAnimationExtension(
    ultraFast: ZephyrAnimationTokens.ultraFast,
    extraFast: ZephyrAnimationTokens.extraFast,
    fast: ZephyrAnimationTokens.fast,
    normal: ZephyrAnimationTokens.normal,
    slow: ZephyrAnimationTokens.slow,
    extraSlow: ZephyrAnimationTokens.extraSlow,
    ultraSlow: ZephyrAnimationTokens.ultraSlow,
    linear: ZephyrAnimationTokens.linear,
    easeIn: ZephyrAnimationTokens.easeIn,
    easeOut: ZephyrAnimationTokens.easeOut,
    easeInOut: ZephyrAnimationTokens.easeInOut,
    easeInQuad: ZephyrAnimationTokens.easeInQuad,
    easeOutQuad: ZephyrAnimationTokens.easeOutQuad,
    easeInOutQuad: ZephyrAnimationTokens.easeInOutQuad,
    easeInCubic: ZephyrAnimationTokens.easeInCubic,
    easeOutCubic: ZephyrAnimationTokens.easeOutCubic,
    easeInOutCubic: ZephyrAnimationTokens.easeInOutCubic,
    bounceIn: ZephyrAnimationTokens.bounceIn,
    bounceOut: ZephyrAnimationTokens.bounceOut,
    elasticIn: ZephyrAnimationTokens.elasticIn,
    elasticOut: ZephyrAnimationTokens.elasticOut,
  );

  /// 创建暗色主题的动画扩展
  static const dark = ZephyrAnimationExtension(
    ultraFast: ZephyrAnimationTokens.ultraFast,
    extraFast: ZephyrAnimationTokens.extraFast,
    fast: ZephyrAnimationTokens.fast,
    normal: ZephyrAnimationTokens.normal,
    slow: ZephyrAnimationTokens.slow,
    extraSlow: ZephyrAnimationTokens.extraSlow,
    ultraSlow: ZephyrAnimationTokens.ultraSlow,
    linear: ZephyrAnimationTokens.linear,
    easeIn: ZephyrAnimationTokens.easeIn,
    easeOut: ZephyrAnimationTokens.easeOut,
    easeInOut: ZephyrAnimationTokens.easeInOut,
    easeInQuad: ZephyrAnimationTokens.easeInQuad,
    easeOutQuad: ZephyrAnimationTokens.easeOutQuad,
    easeInOutQuad: ZephyrAnimationTokens.easeInOutQuad,
    easeInCubic: ZephyrAnimationTokens.easeInCubic,
    easeOutCubic: ZephyrAnimationTokens.easeOutCubic,
    easeInOutCubic: ZephyrAnimationTokens.easeInOutCubic,
    bounceIn: ZephyrAnimationTokens.bounceIn,
    bounceOut: ZephyrAnimationTokens.bounceOut,
    elasticIn: ZephyrAnimationTokens.elasticIn,
    elasticOut: ZephyrAnimationTokens.elasticOut,
  );

  @override
  ZephyrAnimationExtension copyWith({
    Duration? ultraFast,
    Duration? extraFast,
    Duration? fast,
    Duration? normal,
    Duration? slow,
    Duration? extraSlow,
    Duration? ultraSlow,
    Curve? linear,
    Curve? easeIn,
    Curve? easeOut,
    Curve? easeInOut,
    Curve? easeInQuad,
    Curve? easeOutQuad,
    Curve? easeInOutQuad,
    Curve? easeInCubic,
    Curve? easeOutCubic,
    Curve? easeInOutCubic,
    Curve? bounceIn,
    Curve? bounceOut,
    Curve? elasticIn,
    Curve? elasticOut,
  }) {
    return ZephyrAnimationExtension(
      ultraFast: ultraFast ?? this.ultraFast,
      extraFast: extraFast ?? this.extraFast,
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
      extraSlow: extraSlow ?? this.extraSlow,
      ultraSlow: ultraSlow ?? this.ultraSlow,
      linear: linear ?? this.linear,
      easeIn: easeIn ?? this.easeIn,
      easeOut: easeOut ?? this.easeOut,
      easeInOut: easeInOut ?? this.easeInOut,
      easeInQuad: easeInQuad ?? this.easeInQuad,
      easeOutQuad: easeOutQuad ?? this.easeOutQuad,
      easeInOutQuad: easeInOutQuad ?? this.easeInOutQuad,
      easeInCubic: easeInCubic ?? this.easeInCubic,
      easeOutCubic: easeOutCubic ?? this.easeOutCubic,
      easeInOutCubic: easeInOutCubic ?? this.easeInOutCubic,
      bounceIn: bounceIn ?? this.bounceIn,
      bounceOut: bounceOut ?? this.bounceOut,
      elasticIn: elasticIn ?? this.elasticIn,
      elasticOut: elasticOut ?? this.elasticOut,
    );
  }

  @override
  ZephyrAnimationExtension lerp(ThemeExtension<ZephyrAnimationExtension>? other, double t) {
    if (other is! ZephyrAnimationExtension) {
      return this;
    }
    return ZephyrAnimationExtension(
      ultraFast: ultraFast,
      extraFast: extraFast,
      fast: fast,
      normal: normal,
      slow: slow,
      extraSlow: extraSlow,
      ultraSlow: ultraSlow,
      linear: linear,
      easeIn: easeIn,
      easeOut: easeOut,
      easeInOut: easeInOut,
      easeInQuad: easeInQuad,
      easeOutQuad: easeOutQuad,
      easeInOutQuad: easeInOutQuad,
      easeInCubic: easeInCubic,
      easeOutCubic: easeOutCubic,
      easeInOutCubic: easeInOutCubic,
      bounceIn: bounceIn,
      bounceOut: bounceOut,
      elasticIn: elasticIn,
      elasticOut: elasticOut,
    );
  }
}