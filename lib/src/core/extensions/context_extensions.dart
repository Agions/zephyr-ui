/// BuildContext 扩展
///
/// 为 BuildContext 添加便捷的扩展方法，简化常用操作。
library context_extensions;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// BuildContext 扩展
extension ZephyrContextExtensions on BuildContext {
  /// 获取 ZephyrTheme 数据
  ZephyrThemeData get zephyrTheme => ZephyrTheme.of(this);

  /// 获取 Material Theme 数据
  ThemeData get theme => Theme.of(this);

  /// 获取文本主题
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// 获取颜色方案
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// 获取媒体查询数据
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// 获取屏幕尺寸
  Size get screenSize => mediaQuery.size;

  /// 获取屏幕宽度
  double get screenWidth => screenSize.width;

  /// 获取屏幕高度
  double get screenHeight => screenSize.height;

  /// 获取安全区域内边距
  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  /// 获取视图内边距
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// 获取设备像素比
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// 获取文本缩放因子
  double get textScaleFactor => mediaQuery.textScaler.scale(1.0);

  /// 获取屏幕方向
  Orientation get orientation => mediaQuery.orientation;

  /// 判断是否为横屏
  bool get isLandscape => orientation == Orientation.landscape;

  /// 判断是否为竖屏
  bool get isPortrait => orientation == Orientation.portrait;

  /// 获取当前断点
  ZephyrBreakpoint get breakpoint => ZephyrResponsiveUtils.getBreakpoint(this);

  /// 判断是否为移动设备
  bool get isMobile => ZephyrResponsiveUtils.isMobile(this);

  /// 判断是否为平板设备
  bool get isTablet => ZephyrResponsiveUtils.isTablet(this);

  /// 判断是否为桌面设备
  bool get isDesktop => ZephyrResponsiveUtils.isDesktop(this);

  /// 获取响应式值
  T responsive<T>({
    T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
    required T defaultValue,
  }) {
    return ZephyrResponsiveUtils.responsive<T>(
      this,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      defaultValue: defaultValue,
    );
  }

  /// 获取响应式间距
  double get responsiveSpacing => ZephyrResponsiveUtils.getSpacing(this);

  /// 获取响应式字体大小
  double get responsiveFontSize => ZephyrResponsiveUtils.getFontSize(this);

  /// 获取最小触摸目标尺寸
  double get minTouchTargetSize =>
      ZephyrResponsiveUtils.getMinTouchTargetSize(this);

  /// 显示 SnackBar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textColor != null ? TextStyle(color: textColor) : null,
        ),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// 显示成功消息
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.primary,
      textColor: colorScheme.onPrimary,
    );
  }

  /// 显示错误消息
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
    );
  }

  /// 显示警告消息
  void showWarningSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  /// 显示信息消息
  void showInfoSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  /// 导航到新页面
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// 替换当前页面
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// 返回上一页
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// 返回到指定页面
  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// 清除所有页面并导航到新页面
  Future<T?> pushNamedAndClearStack<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// 显示对话框
  Future<T?> showZephyrDialog<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
  }) {
    return showDialog<T>(
      context: this,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
    );
  }

  /// 显示底部表单
  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext) builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  /// 隐藏键盘
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// 请求焦点
  void requestFocus(FocusNode focusNode) {
    FocusScope.of(this).requestFocus(focusNode);
  }

  /// 获取本地化数据
  Locale get locale => Localizations.localeOf(this);

  /// 判断是否为从右到左的语言
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  /// 判断是否为从左到右的语言
  bool get isLTR => !isRTL;
}
