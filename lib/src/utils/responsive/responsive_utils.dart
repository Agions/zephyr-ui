/// 响应式工具类
/// 
/// 提供响应式设计相关的工具函数，帮助组件适配不同屏幕尺寸。
library responsive_utils;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 响应式工具类
class ZephyrResponsiveUtils {
  ZephyrResponsiveUtils._();

  /// 获取当前屏幕的断点
  static ZephyrBreakpoint getBreakpoint(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= ZephyrBreakpoints.xxl) {
      return ZephyrBreakpoint.xxl;
    } else if (width >= ZephyrBreakpoints.xl) {
      return ZephyrBreakpoint.xl;
    } else if (width >= ZephyrBreakpoints.lg) {
      return ZephyrBreakpoint.lg;
    } else if (width >= ZephyrBreakpoints.md) {
      return ZephyrBreakpoint.md;
    } else if (width >= ZephyrBreakpoints.sm) {
      return ZephyrBreakpoint.sm;
    } else {
      return ZephyrBreakpoint.xs;
    }
  }

  /// 判断是否为移动设备
  static bool isMobile(BuildContext context) {
    final breakpoint = getBreakpoint(context);
    return breakpoint == ZephyrBreakpoint.xs || breakpoint == ZephyrBreakpoint.sm;
  }

  /// 判断是否为平板设备
  static bool isTablet(BuildContext context) {
    final breakpoint = getBreakpoint(context);
    return breakpoint == ZephyrBreakpoint.md;
  }

  /// 判断是否为桌面设备
  static bool isDesktop(BuildContext context) {
    final breakpoint = getBreakpoint(context);
    return breakpoint == ZephyrBreakpoint.lg || 
           breakpoint == ZephyrBreakpoint.xl || 
           breakpoint == ZephyrBreakpoint.xxl;
  }

  /// 根据断点返回不同的值
  static T responsive<T>(
    BuildContext context, {
    T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
    required T defaultValue,
  }) {
    final breakpoint = getBreakpoint(context);
    
    switch (breakpoint) {
      case ZephyrBreakpoint.xs:
        return xs ?? defaultValue;
      case ZephyrBreakpoint.sm:
        return sm ?? xs ?? defaultValue;
      case ZephyrBreakpoint.md:
        return md ?? sm ?? xs ?? defaultValue;
      case ZephyrBreakpoint.lg:
        return lg ?? md ?? sm ?? xs ?? defaultValue;
      case ZephyrBreakpoint.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? defaultValue;
      case ZephyrBreakpoint.xxl:
        return xxl ?? xl ?? lg ?? md ?? sm ?? xs ?? defaultValue;
    }
  }

  /// 获取响应式列数
  static int getColumns(BuildContext context, {
    int xs = 1,
    int sm = 2,
    int md = 3,
    int lg = 4,
    int xl = 5,
    int xxl = 6,
  }) {
    return responsive<int>(
      context,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      defaultValue: xs,
    );
  }

  /// 获取响应式间距
  static double getSpacing(BuildContext context, {
    double xs = ZephyrSpacing.sm,
    double sm = ZephyrSpacing.md,
    double md = ZephyrSpacing.lg,
    double lg = ZephyrSpacing.xl,
    double xl = ZephyrSpacing.xxl,
    double xxl = ZephyrSpacing.xxxl,
  }) {
    return responsive<double>(
      context,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      defaultValue: xs,
    );
  }

  /// 获取响应式字体大小
  static double getFontSize(BuildContext context, {
    double xs = ZephyrTypography.fontSize14,
    double sm = ZephyrTypography.fontSize16,
    double md = ZephyrTypography.fontSize18,
    double lg = ZephyrTypography.fontSize20,
    double xl = ZephyrTypography.fontSize24,
    double xxl = ZephyrTypography.fontSize28,
  }) {
    return responsive<double>(
      context,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      defaultValue: xs,
    );
  }

  /// 获取安全区域内边距
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// 获取屏幕尺寸
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// 获取屏幕方向
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// 判断是否为横屏
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  /// 判断是否为竖屏
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  /// 获取设备像素比
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// 获取文本缩放因子
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1.0);
  }

  /// 计算响应式宽度百分比
  static double getWidthPercent(BuildContext context, double percent) {
    return getScreenSize(context).width * percent;
  }

  /// 计算响应式高度百分比
  static double getHeightPercent(BuildContext context, double percent) {
    return getScreenSize(context).height * percent;
  }

  /// 获取最小触摸目标尺寸
  static double getMinTouchTargetSize(BuildContext context) {
    return isMobile(context) ? 44.0 : 32.0;
  }
}

/// 响应式构建器
class ZephyrResponsiveBuilder extends StatelessWidget {
  /// 创建响应式构建器
  const ZephyrResponsiveBuilder({
    Key? key,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
    required this.builder,
  }) : super(key: key);

  /// 超小屏幕构建器
  final Widget Function(BuildContext context)? xs;
  
  /// 小屏幕构建器
  final Widget Function(BuildContext context)? sm;
  
  /// 中等屏幕构建器
  final Widget Function(BuildContext context)? md;
  
  /// 大屏幕构建器
  final Widget Function(BuildContext context)? lg;
  
  /// 超大屏幕构建器
  final Widget Function(BuildContext context)? xl;
  
  /// 超超大屏幕构建器
  final Widget Function(BuildContext context)? xxl;
  
  /// 默认构建器
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    final breakpoint = ZephyrResponsiveUtils.getBreakpoint(context);
    
    Widget Function(BuildContext context)? selectedBuilder;
    
    switch (breakpoint) {
      case ZephyrBreakpoint.xs:
        selectedBuilder = xs;
        break;
      case ZephyrBreakpoint.sm:
        selectedBuilder = sm ?? xs;
        break;
      case ZephyrBreakpoint.md:
        selectedBuilder = md ?? sm ?? xs;
        break;
      case ZephyrBreakpoint.lg:
        selectedBuilder = lg ?? md ?? sm ?? xs;
        break;
      case ZephyrBreakpoint.xl:
        selectedBuilder = xl ?? lg ?? md ?? sm ?? xs;
        break;
      case ZephyrBreakpoint.xxl:
        selectedBuilder = xxl ?? xl ?? lg ?? md ?? sm ?? xs;
        break;
    }
    
    return (selectedBuilder ?? builder)(context);
  }
}
