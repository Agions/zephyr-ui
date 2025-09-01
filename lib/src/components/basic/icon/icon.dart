import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 遵循Zephyr设计规范的图标组件
///
/// 提供了一系列预设的图标样式，便于创建一致的图标效果。
///
/// 示例用法:
/// ```dart
/// ZephyrIcon(
///   Icons.home,
///   size: ZephyrIconSize.medium,
///   status: ZephyrIconStatus.primary,
/// )
/// ```
class ZephyrIcon extends StatelessWidget {
  /// 创建一个标准图标组件
  ///
  /// [icon] 是要显示的图标
  const ZephyrIcon(
    this.icon, {
    Key? key,
    this.size = ZephyrIconSize.medium,
    this.status = ZephyrIconStatus.normal,
    this.color,
    this.customSize,
    this.semanticLabel,
    this.theme,
  }) : super(key: key);

  /// 创建一个小号图标
  factory ZephyrIcon.small(
    IconData icon, {
    Key? key,
    ZephyrIconStatus status = ZephyrIconStatus.normal,
    Color? color,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: ZephyrIconSize.small,
      status: status,
      color: color,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 创建一个中号图标
  factory ZephyrIcon.medium(
    IconData icon, {
    Key? key,
    ZephyrIconStatus status = ZephyrIconStatus.normal,
    Color? color,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: ZephyrIconSize.medium,
      status: status,
      color: color,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 创建一个大号图标
  factory ZephyrIcon.large(
    IconData icon, {
    Key? key,
    ZephyrIconStatus status = ZephyrIconStatus.normal,
    Color? color,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: ZephyrIconSize.large,
      status: status,
      color: color,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 创建一个主色图标
  factory ZephyrIcon.primary(
    IconData icon, {
    Key? key,
    ZephyrIconSize size = ZephyrIconSize.medium,
    Color? color,
    double? customSize,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: size,
      status: ZephyrIconStatus.primary,
      color: color,
      customSize: customSize,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 创建一个次要色图标
  factory ZephyrIcon.secondary(
    IconData icon, {
    Key? key,
    ZephyrIconSize size = ZephyrIconSize.medium,
    Color? color,
    double? customSize,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: size,
      status: ZephyrIconStatus.secondary,
      color: color,
      customSize: customSize,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 创建一个错误状态图标
  factory ZephyrIcon.error(
    IconData icon, {
    Key? key,
    ZephyrIconSize size = ZephyrIconSize.medium,
    Color? color,
    double? customSize,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: size,
      status: ZephyrIconStatus.error,
      color: color,
      customSize: customSize,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 创建一个警告状态图标
  factory ZephyrIcon.warning(
    IconData icon, {
    Key? key,
    ZephyrIconSize size = ZephyrIconSize.medium,
    Color? color,
    double? customSize,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: size,
      status: ZephyrIconStatus.warning,
      color: color,
      customSize: customSize,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 创建一个成功状态图标
  factory ZephyrIcon.success(
    IconData icon, {
    Key? key,
    ZephyrIconSize size = ZephyrIconSize.medium,
    Color? color,
    double? customSize,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: size,
      status: ZephyrIconStatus.success,
      color: color,
      customSize: customSize,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 创建一个信息状态图标
  factory ZephyrIcon.info(
    IconData icon, {
    Key? key,
    ZephyrIconSize size = ZephyrIconSize.medium,
    Color? color,
    double? customSize,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: size,
      status: ZephyrIconStatus.info,
      color: color,
      customSize: customSize,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 创建一个禁用状态图标
  factory ZephyrIcon.disabled(
    IconData icon, {
    Key? key,
    ZephyrIconSize size = ZephyrIconSize.medium,
    Color? color,
    double? customSize,
    String? semanticLabel,
    ZephyrIconTheme? theme,
  }) {
    return ZephyrIcon(
      icon,
      key: key,
      size: size,
      status: ZephyrIconStatus.disabled,
      color: color,
      customSize: customSize,
      semanticLabel: semanticLabel,
      theme: theme,
    );
  }

  /// 要显示的图标
  final IconData icon;

  /// 图标尺寸
  final ZephyrIconSize size;

  /// 图标状态
  final ZephyrIconStatus status;

  /// 图标颜色，覆盖状态颜色
  final Color? color;

  /// 自定义尺寸，覆盖预设尺寸
  final double? customSize;

  /// 图标的语义标签
  final String? semanticLabel;

  /// 图标主题
  final ZephyrIconTheme? theme;

  @override
  Widget build(BuildContext context) {
    ZephyrTheme.of(context);
    final effectiveTheme = ZephyrIconTheme.resolve(
      context,
      theme,
    );

    // 根据状态确定颜色
    Color? effectiveColor = color;
    if (effectiveColor == null) {
      switch (status) {
        case ZephyrIconStatus.normal:
          effectiveColor = effectiveTheme.defaultColor;
          break;
        case ZephyrIconStatus.primary:
          effectiveColor = effectiveTheme.primaryColor;
          break;
        case ZephyrIconStatus.secondary:
          effectiveColor = effectiveTheme.secondaryColor;
          break;
        case ZephyrIconStatus.error:
          effectiveColor = effectiveTheme.errorColor;
          break;
        case ZephyrIconStatus.warning:
          effectiveColor = effectiveTheme.warningColor;
          break;
        case ZephyrIconStatus.success:
          effectiveColor = effectiveTheme.successColor;
          break;
        case ZephyrIconStatus.info:
          effectiveColor = effectiveTheme.infoColor;
          break;
        case ZephyrIconStatus.disabled:
          effectiveColor = effectiveTheme.disabledColor;
          break;
      }
    }

    // 根据尺寸确定大小
    double? effectiveSize = customSize;
    if (effectiveSize == null) {
      switch (size) {
        case ZephyrIconSize.small:
          effectiveSize = effectiveTheme.smallSize;
          break;
        case ZephyrIconSize.medium:
          effectiveSize = effectiveTheme.mediumSize;
          break;
        case ZephyrIconSize.large:
          effectiveSize = effectiveTheme.largeSize;
          break;
      }
    }

    return Icon(
      icon,
      color: effectiveColor,
      size: effectiveSize,
      semanticLabel: semanticLabel,
    );
  }
}

/// 图标尺寸枚举
enum ZephyrIconSize {
  /// 小尺寸图标
  small,

  /// 中尺寸图标 (默认)
  medium,

  /// 大尺寸图标
  large,
}

/// 图标状态枚举
enum ZephyrIconStatus {
  /// 普通状态
  normal,

  /// 主色状态
  primary,

  /// 次要色状态
  secondary,

  /// 错误状态
  error,

  /// 警告状态
  warning,

  /// 成功状态
  success,

  /// 信息状态
  info,

  /// 禁用状态
  disabled,
}
