/// ZephyrUI 警告组件
///
/// 提供各种类型的警告和通知消息。
library alert;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 警告组件
///
/// 用于显示重要信息、警告、错误或成功消息的组件。
///
/// 示例用法:
/// ```dart
/// ZephyrAlert.success(
///   title: '成功',
///   message: '操作已成功完成',
/// )
/// ```
class ZephyrAlert extends StatelessWidget {
  /// 创建一个警告组件
  const ZephyrAlert({
    required this.variant,
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = false,
    this.theme,
  });

  /// 创建成功警告
  const ZephyrAlert.success({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = false,
    this.theme,
  }) : variant = ZephyrVariant.success;

  /// 创建警告
  const ZephyrAlert.warning({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = false,
    this.theme,
  }) : variant = ZephyrVariant.warning;

  /// 创建错误警告
  const ZephyrAlert.error({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = false,
    this.theme,
  }) : variant = ZephyrVariant.error;

  /// 创建信息警告
  const ZephyrAlert.info({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = false,
    this.theme,
  }) : variant = ZephyrVariant.info;

  /// 警告类型
  final ZephyrVariant variant;

  /// 标题
  final String? title;

  /// 消息内容
  final String? message;

  /// 自定义图标
  final Widget? icon;

  /// 操作按钮
  final List<Widget>? actions;

  /// 关闭回调
  final VoidCallback? onClose;

  /// 是否显示关闭按钮
  final bool showCloseButton;

  /// 主题
  final ZephyrAlertTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrAlertTheme.of(context, variant);

    return Container(
      padding: effectiveTheme.padding,
      margin: effectiveTheme.margin,
      decoration: BoxDecoration(
        color: effectiveTheme.backgroundColor,
        borderRadius: effectiveTheme.borderRadius,
        border: effectiveTheme.border,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null || _shouldShowDefaultIcon())
            Padding(
              padding: const EdgeInsets.only(right: ZephyrSpacing.md),
              child: _buildIcon(effectiveTheme),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) _buildTitle(effectiveTheme),
                if (message != null) _buildMessage(effectiveTheme),
                if (actions != null && actions!.isNotEmpty) _buildActions(),
              ],
            ),
          ),
          if (showCloseButton && onClose != null)
            _buildCloseButton(effectiveTheme),
        ],
      ),
    );
  }

  /// 是否显示默认图标
  bool _shouldShowDefaultIcon() {
    return variant != ZephyrVariant.neutral;
  }

  /// 构建图标
  Widget _buildIcon(ZephyrAlertTheme theme) {
    if (icon != null) return icon!;

    IconData iconData;
    switch (variant) {
      case ZephyrVariant.success:
        iconData = Icons.check_circle;
        break;
      case ZephyrVariant.warning:
        iconData = Icons.warning;
        break;
      case ZephyrVariant.error:
        iconData = Icons.error;
        break;
      case ZephyrVariant.info:
        iconData = Icons.info;
        break;
      default:
        iconData = Icons.info_outline;
    }

    return Icon(
      iconData,
      color: theme.iconColor,
      size: 20,
    );
  }

  /// 构建标题
  Widget _buildTitle(ZephyrAlertTheme theme) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: message != null ? ZephyrSpacing.xs : 0,
      ),
      child: Text(
        title!,
        style: theme.titleStyle,
      ),
    );
  }

  /// 构建消息
  Widget _buildMessage(ZephyrAlertTheme theme) {
    return Text(
      message!,
      style: theme.messageStyle,
    );
  }

  /// 构建操作按钮
  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.only(top: ZephyrSpacing.md),
      child: Wrap(
        spacing: ZephyrSpacing.sm,
        children: actions!,
      ),
    );
  }

  /// 构建关闭按钮
  Widget _buildCloseButton(ZephyrAlertTheme theme) {
    return IconButton(
      icon: Icon(
        Icons.close,
        size: 18,
        color: theme.iconColor,
      ),
      onPressed: onClose,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 24,
        minHeight: 24,
      ),
    );
  }
}

/// ZephyrUI 横幅警告
///
/// 全宽度的横幅样式警告组件。
class ZephyrBanner extends StatelessWidget {
  /// 创建横幅警告
  const ZephyrBanner({
    required this.variant,
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = true,
    this.theme,
  });

  /// 创建成功横幅
  const ZephyrBanner.success({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = true,
    this.theme,
  }) : variant = ZephyrVariant.success;

  /// 创建警告横幅
  const ZephyrBanner.warning({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = true,
    this.theme,
  }) : variant = ZephyrVariant.warning;

  /// 创建错误横幅
  const ZephyrBanner.error({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = true,
    this.theme,
  }) : variant = ZephyrVariant.error;

  /// 创建信息横幅
  const ZephyrBanner.info({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onClose,
    this.showCloseButton = true,
    this.theme,
  }) : variant = ZephyrVariant.info;

  /// 警告类型
  final ZephyrVariant variant;

  /// 标题
  final String? title;

  /// 消息内容
  final String? message;

  /// 自定义图标
  final Widget? icon;

  /// 操作按钮
  final List<Widget>? actions;

  /// 关闭回调
  final VoidCallback? onClose;

  /// 是否显示关闭按钮
  final bool showCloseButton;

  /// 主题
  final ZephyrAlertTheme? theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ZephyrAlert(
        variant: variant,
        title: title,
        message: message,
        icon: icon,
        actions: actions,
        onClose: onClose,
        showCloseButton: showCloseButton,
        theme: theme?.copyWith(
          borderRadius: BorderRadius.zero,
          margin: EdgeInsets.zero,
        ),
      ),
    );
  }
}
