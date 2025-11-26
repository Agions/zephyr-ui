/// ZephyrUI 主题扩展机制
///
/// 提供灵活的主题扩展和自定义功能
library theme_extension;

import 'package:flutter/material.dart';
import 'design_tokens.dart';

/// 主题扩展基类
abstract class ZephyrThemeExtension<T extends ZephyrThemeExtension<T>> {
  /// 创建主题扩展实例
  const ZephyrThemeExtension();

  /// 复制并替换属性
  T copyWith();

  /// 从另一个主题扩展合并属性
  T merge(T? other);

  /// 主题扩展工厂
  static T create<T extends ZephyrThemeExtension<T>>(T Function() factory) {
    return factory();
  }
}

/// 颜色方案扩展
class ZephyrColorSchemeExtension
    extends ZephyrThemeExtension<ZephyrColorSchemeExtension> {
  const ZephyrColorSchemeExtension({
    this.success = const ZephyrSuccessColors(),
    this.warning = const ZephyrWarningColors(),
    this.info = const ZephyrInfoColors(),
    this.neutral = const ZephyrNeutralColors(),
  });

  final ZephyrSuccessColors success;
  final ZephyrWarningColors warning;
  final ZephyrInfoColors info;
  final ZephyrNeutralColors neutral;

  @override
  ZephyrColorSchemeExtension copyWith({
    ZephyrSuccessColors? success,
    ZephyrWarningColors? warning,
    ZephyrInfoColors? info,
    ZephyrNeutralColors? neutral,
  }) {
    return ZephyrColorSchemeExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      neutral: neutral ?? this.neutral,
    );
  }

  @override
  ZephyrColorSchemeExtension merge(ZephyrColorSchemeExtension? other) {
    if (other == null) return this;

    return copyWith(
      success: success.merge(other.success),
      warning: warning.merge(other.warning),
      info: info.merge(other.info),
      neutral: neutral.merge(other.neutral),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrColorSchemeExtension &&
        other.success == success &&
        other.warning == warning &&
        other.info == info &&
        other.neutral == neutral;
  }

  @override
  int get hashCode => Object.hashAll([success, warning, info, neutral]);
}

/// 成功颜色
class ZephyrSuccessColors {
  const ZephyrSuccessColors({
    this.color = ZephyrColorTokens.success50,
    this.onColor = ZephyrColorTokens.neutral0,
    this.colorContainer = ZephyrColorTokens.success90,
    this.onColorContainer = ZephyrColorTokens.success10,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;

  ZephyrSuccessColors copyWith({
    Color? color,
    Color? onColor,
    Color? colorContainer,
    Color? onColorContainer,
  }) {
    return ZephyrSuccessColors(
      color: color ?? this.color,
      onColor: onColor ?? this.onColor,
      colorContainer: colorContainer ?? this.colorContainer,
      onColorContainer: onColorContainer ?? this.onColorContainer,
    );
  }

  ZephyrSuccessColors merge(ZephyrSuccessColors? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      onColor: other.onColor,
      colorContainer: other.colorContainer,
      onColorContainer: other.onColorContainer,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrSuccessColors &&
        other.color == color &&
        other.onColor == onColor &&
        other.colorContainer == colorContainer &&
        other.onColorContainer == onColorContainer;
  }

  @override
  int get hashCode =>
      Object.hashAll([color, onColor, colorContainer, onColorContainer]);
}

/// 警告颜色
class ZephyrWarningColors {
  const ZephyrWarningColors({
    this.color = ZephyrColorTokens.warning50,
    this.onColor = ZephyrColorTokens.neutral0,
    this.colorContainer = ZephyrColorTokens.warning90,
    this.onColorContainer = ZephyrColorTokens.warning10,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;

  ZephyrWarningColors copyWith({
    Color? color,
    Color? onColor,
    Color? colorContainer,
    Color? onColorContainer,
  }) {
    return ZephyrWarningColors(
      color: color ?? this.color,
      onColor: onColor ?? this.onColor,
      colorContainer: colorContainer ?? this.colorContainer,
      onColorContainer: onColorContainer ?? this.onColorContainer,
    );
  }

  ZephyrWarningColors merge(ZephyrWarningColors? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      onColor: other.onColor,
      colorContainer: other.colorContainer,
      onColorContainer: other.onColorContainer,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrWarningColors &&
        other.color == color &&
        other.onColor == onColor &&
        other.colorContainer == colorContainer &&
        other.onColorContainer == onColorContainer;
  }

  @override
  int get hashCode =>
      Object.hashAll([color, onColor, colorContainer, onColorContainer]);
}

/// 信息颜色
class ZephyrInfoColors {
  const ZephyrInfoColors({
    this.color = ZephyrColorTokens.info50,
    this.onColor = ZephyrColorTokens.neutral0,
    this.colorContainer = ZephyrColorTokens.info90,
    this.onColorContainer = ZephyrColorTokens.info10,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;

  ZephyrInfoColors copyWith({
    Color? color,
    Color? onColor,
    Color? colorContainer,
    Color? onColorContainer,
  }) {
    return ZephyrInfoColors(
      color: color ?? this.color,
      onColor: onColor ?? this.onColor,
      colorContainer: colorContainer ?? this.colorContainer,
      onColorContainer: onColorContainer ?? this.onColorContainer,
    );
  }

  ZephyrInfoColors merge(ZephyrInfoColors? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      onColor: other.onColor,
      colorContainer: other.colorContainer,
      onColorContainer: other.onColorContainer,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrInfoColors &&
        other.color == color &&
        other.onColor == onColor &&
        other.colorContainer == colorContainer &&
        other.onColorContainer == onColorContainer;
  }

  @override
  int get hashCode =>
      Object.hashAll([color, onColor, colorContainer, onColorContainer]);
}

/// 中性颜色
class ZephyrNeutralColors {
  const ZephyrNeutralColors({
    this.color = ZephyrColorTokens.neutral50,
    this.onColor = ZephyrColorTokens.neutral0,
    this.colorContainer = ZephyrColorTokens.neutral90,
    this.onColorContainer = ZephyrColorTokens.neutral10,
    this.outline = ZephyrColorTokens.neutral40,
    this.outlineVariant = ZephyrColorTokens.neutral80,
    this.scrim = ZephyrColorTokens.neutral0,
    this.shadow = ZephyrColorTokens.neutral0,
    this.surfaceTint = ZephyrColorTokens.primary60,
    this.inverseSurface = ZephyrColorTokens.neutral20,
    this.onInverseSurface = ZephyrColorTokens.neutral95,
    this.inversePrimary = ZephyrColorTokens.primary80,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
  final Color outline;
  final Color outlineVariant;
  final Color scrim;
  final Color shadow;
  final Color surfaceTint;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;

  ZephyrNeutralColors copyWith({
    Color? color,
    Color? onColor,
    Color? colorContainer,
    Color? onColorContainer,
    Color? outline,
    Color? outlineVariant,
    Color? scrim,
    Color? shadow,
    Color? surfaceTint,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
  }) {
    return ZephyrNeutralColors(
      color: color ?? this.color,
      onColor: onColor ?? this.onColor,
      colorContainer: colorContainer ?? this.colorContainer,
      onColorContainer: onColorContainer ?? this.onColorContainer,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      scrim: scrim ?? this.scrim,
      shadow: shadow ?? this.shadow,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
    );
  }

  ZephyrNeutralColors merge(ZephyrNeutralColors? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      onColor: other.onColor,
      colorContainer: other.colorContainer,
      onColorContainer: other.onColorContainer,
      outline: other.outline,
      outlineVariant: other.outlineVariant,
      scrim: other.scrim,
      shadow: other.shadow,
      surfaceTint: other.surfaceTint,
      inverseSurface: other.inverseSurface,
      onInverseSurface: other.onInverseSurface,
      inversePrimary: other.inversePrimary,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrNeutralColors &&
        other.color == color &&
        other.onColor == onColor &&
        other.colorContainer == colorContainer &&
        other.onColorContainer == onColorContainer &&
        other.outline == outline &&
        other.outlineVariant == outlineVariant &&
        other.scrim == scrim &&
        other.shadow == shadow &&
        other.surfaceTint == surfaceTint &&
        other.inverseSurface == inverseSurface &&
        other.onInverseSurface == onInverseSurface &&
        other.inversePrimary == inversePrimary;
  }

  @override
  int get hashCode => Object.hashAll([
        color,
        onColor,
        colorContainer,
        onColorContainer,
        outline,
        outlineVariant,
        scrim,
        shadow,
        surfaceTint,
        inverseSurface,
        onInverseSurface,
        inversePrimary,
      ]);
}

/// 形状主题扩展
class ZephyrShapeThemeExtension
    extends ZephyrThemeExtension<ZephyrShapeThemeExtension> {
  const ZephyrShapeThemeExtension({
    this.small = ZephyrRadiusTokens.small,
    this.medium = ZephyrRadiusTokens.medium,
    this.large = ZephyrRadiusTokens.large,
    this.extraLarge = ZephyrRadiusTokens.extraLarge,
  });

  final double small;
  final double medium;
  final double large;
  final double extraLarge;

  @override
  ZephyrShapeThemeExtension copyWith({
    double? small,
    double? medium,
    double? large,
    double? extraLarge,
  }) {
    return ZephyrShapeThemeExtension(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
    );
  }

  @override
  ZephyrShapeThemeExtension merge(ZephyrShapeThemeExtension? other) {
    if (other == null) return this;
    return copyWith(
      small: other.small,
      medium: other.medium,
      large: other.large,
      extraLarge: other.extraLarge,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrShapeThemeExtension &&
        other.small == small &&
        other.medium == medium &&
        other.large == large &&
        other.extraLarge == extraLarge;
  }

  @override
  int get hashCode => Object.hashAll([small, medium, large, extraLarge]);
}

/// 间距主题扩展
class ZephyrSpacingThemeExtension
    extends ZephyrThemeExtension<ZephyrSpacingThemeExtension> {
  const ZephyrSpacingThemeExtension({
    this.micro = ZephyrSpacingTokens.micro,
    this.small = ZephyrSpacingTokens.small,
    this.medium = ZephyrSpacingTokens.medium,
    this.large = ZephyrSpacingTokens.large,
    this.extraLarge = ZephyrSpacingTokens.extraLarge,
  });

  final double micro;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;

  @override
  ZephyrSpacingThemeExtension copyWith({
    double? micro,
    double? small,
    double? medium,
    double? large,
    double? extraLarge,
  }) {
    return ZephyrSpacingThemeExtension(
      micro: micro ?? this.micro,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
    );
  }

  @override
  ZephyrSpacingThemeExtension merge(ZephyrSpacingThemeExtension? other) {
    if (other == null) return this;
    return copyWith(
      micro: other.micro,
      small: other.small,
      medium: other.medium,
      large: other.large,
      extraLarge: other.extraLarge,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrSpacingThemeExtension &&
        other.micro == micro &&
        other.small == small &&
        other.medium == medium &&
        other.large == large &&
        other.extraLarge == extraLarge;
  }

  @override
  int get hashCode => Object.hashAll([micro, small, medium, large, extraLarge]);
}
