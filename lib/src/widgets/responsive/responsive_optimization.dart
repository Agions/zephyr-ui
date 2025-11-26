/// ZephyrUI 响应式设计优化工具
///
/// 提供响应式设计的优化和工具函数。
library responsive_optimization;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/utils/performance/performance_optimizer.dart';
import 'package:zephyr_ui/src/utils/responsive/responsive_utils.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 响应式断点
class ZephyrResponsiveBreakpoints {
  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double largeDesktop = 1440;
}

/// 响应式值
class ZephyrResponsiveValue<T> {
  const ZephyrResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });
  final T mobile;
  final T? tablet;
  final T? desktop;
  final T? largeDesktop;

  /// 获取当前屏幕尺寸对应的值
  T getValue(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= ZephyrResponsiveBreakpoints.largeDesktop &&
        largeDesktop != null) {
      return largeDesktop!;
    }
    if (width >= ZephyrResponsiveBreakpoints.desktop && desktop != null) {
      return desktop!;
    }
    if (width >= ZephyrResponsiveBreakpoints.tablet && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}

/// 响应式构建器
class ZephyrResponsiveBuilder extends StatelessWidget {
  const ZephyrResponsiveBuilder({
    required this.builder,
    super.key,
  });
  final Widget Function(BuildContext context, ZephyrBreakpoint screenType)
      builder;

  @override
  Widget build(BuildContext context) {
    final screenType = ZephyrResponsiveUtils.getBreakpoint(context);
    return builder(context, screenType);
  }
}

/// 响应式布局
class ZephyrResponsiveLayout extends StatelessWidget {
  const ZephyrResponsiveLayout({
    required this.mobile,
    super.key,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= ZephyrResponsiveBreakpoints.largeDesktop &&
        largeDesktop != null) {
      return largeDesktop!;
    }
    if (width >= ZephyrResponsiveBreakpoints.desktop && desktop != null) {
      return desktop!;
    }
    if (width >= ZephyrResponsiveBreakpoints.tablet && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}

/// 优化的响应式网格
class ZephyrResponsiveGrid extends StatelessWidget {
  const ZephyrResponsiveGrid({
    required this.children,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.childAspectRatio,
    super.key,
    this.padding,
    this.controller,
    this.shrinkWrap = false,
  });
  final List<Widget> children;
  final ZephyrResponsiveValue<int> crossAxisCount;
  final ZephyrResponsiveValue<double> mainAxisSpacing;
  final ZephyrResponsiveValue<double> crossAxisSpacing;
  final ZephyrResponsiveValue<double> childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return ZephyrPerformanceUtils.measureTime(
      'ZephyrResponsiveGrid_build',
      () => GridView.builder(
        controller: controller,
        padding: padding,
        shrinkWrap: shrinkWrap,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount.getValue(context),
          mainAxisSpacing: mainAxisSpacing.getValue(context),
          crossAxisSpacing: crossAxisSpacing.getValue(context),
          childAspectRatio: childAspectRatio.getValue(context),
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}

/// 响应式间距
class ZephyrResponsiveSpacing extends StatelessWidget {
  const ZephyrResponsiveSpacing({
    required this.value,
    super.key,
    this.child,
    this.axis,
  });
  final ZephyrResponsiveValue<double> value;
  final Widget? child;
  final Axis? axis;

  @override
  Widget build(BuildContext context) {
    final spacing = value.getValue(context);

    if (child != null) {
      if (axis == Axis.horizontal) {
        return Row(
          children: [
            SizedBox(width: spacing),
            child!,
            SizedBox(width: spacing),
          ],
        );
      } else {
        return Column(
          children: [
            SizedBox(height: spacing),
            child!,
            SizedBox(height: spacing),
          ],
        );
      }
    }

    return axis == Axis.horizontal
        ? SizedBox(width: spacing)
        : SizedBox(height: spacing);
  }
}

/// 响应式容器
class ZephyrResponsiveContainer extends StatelessWidget {
  const ZephyrResponsiveContainer({
    required this.child,
    super.key,
    this.maxWidth,
    this.maxHeight,
    this.padding,
    this.alignment,
    this.decoration,
  });
  final Widget child;
  final ZephyrResponsiveValue<double>? maxWidth;
  final ZephyrResponsiveValue<double>? maxHeight;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    final effectiveMaxWidth = maxWidth?.getValue(context);
    final effectiveMaxHeight = maxHeight?.getValue(context);

    return Container(
      constraints: BoxConstraints(
        maxWidth: effectiveMaxWidth ?? double.infinity,
        maxHeight: effectiveMaxHeight ?? double.infinity,
      ),
      padding: padding,
      alignment: alignment,
      decoration: decoration,
      child: child,
    );
  }
}

/// 响应式字体大小
class ZephyrResponsiveText extends StatelessWidget {
  const ZephyrResponsiveText({
    required this.data,
    required this.fontSize,
    super.key,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });
  final String data;
  final ZephyrResponsiveValue<double> fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: fontSize.getValue(context),
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// 响应式边距
class ZephyrResponsivePadding extends StatelessWidget {
  const ZephyrResponsivePadding({
    required this.child,
    required this.padding,
    super.key,
  });
  final Widget child;
  final ZephyrResponsiveValue<EdgeInsetsGeometry> padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding.getValue(context),
      child: child,
    );
  }
}

/// 响应式尺寸
class ZephyrResponsiveSizedBox extends StatelessWidget {
  const ZephyrResponsiveSizedBox({
    super.key,
    this.child,
    this.width,
    this.height,
  });
  final Widget? child;
  final ZephyrResponsiveValue<double>? width;
  final ZephyrResponsiveValue<double>? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.getValue(context),
      height: height?.getValue(context),
      child: child,
    );
  }
}

/// 响应式边框半径
class ZephyrResponsiveBorderRadius extends StatelessWidget {
  const ZephyrResponsiveBorderRadius({
    required this.child,
    required this.borderRadius,
    super.key,
  });
  final Widget child;
  final ZephyrResponsiveValue<BorderRadiusGeometry> borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius.getValue(context),
      child: child,
    );
  }
}

/// 响应式方向
class ZephyrResponsiveOrientationBuilder extends StatelessWidget {
  const ZephyrResponsiveOrientationBuilder({
    required this.builder,
    super.key,
  });
  final Widget Function(BuildContext context, Orientation orientation) builder;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return builder(context, orientation);
  }
}

/// 响应式主题
class ZephyrResponsiveTheme extends StatelessWidget {
  const ZephyrResponsiveTheme({
    required this.child,
    super.key,
    this.lightTheme,
    this.darkTheme,
  });
  final Widget child;
  final ZephyrResponsiveValue<ThemeData>? lightTheme;
  final ZephyrResponsiveValue<ThemeData>? darkTheme;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    ThemeData? effectiveTheme;
    if (isDark && darkTheme != null) {
      effectiveTheme = darkTheme?.getValue(context);
    } else if (!isDark && lightTheme != null) {
      effectiveTheme = lightTheme?.getValue(context);
    }

    if (effectiveTheme != null) {
      return Theme(
        data: effectiveTheme,
        child: child,
      );
    }

    return child;
  }
}

/// 响应式断点监听器
class ZephyrResponsiveBreakpointListener extends StatefulWidget {
  const ZephyrResponsiveBreakpointListener({
    required this.child,
    super.key,
    this.onBreakpointChange,
    this.initialScreenType = ZephyrBreakpoint.xs,
  });
  final Widget child;
  final Function(ZephyrBreakpoint)? onBreakpointChange;
  final ZephyrBreakpoint initialScreenType;

  @override
  State<ZephyrResponsiveBreakpointListener> createState() =>
      _ZephyrResponsiveBreakpointListenerState();
}

class _ZephyrResponsiveBreakpointListenerState
    extends State<ZephyrResponsiveBreakpointListener> {
  ZephyrBreakpoint _currentScreenType = ZephyrBreakpoint.xs;

  @override
  void initState() {
    super.initState();
    _currentScreenType = widget.initialScreenType;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkBreakpoint();
  }

  void _checkBreakpoint() {
    final newScreenType = ZephyrResponsiveUtils.getBreakpoint(context);
    if (newScreenType != _currentScreenType) {
      setState(() {
        _currentScreenType = newScreenType;
      });
      widget.onBreakpointChange?.call(newScreenType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
