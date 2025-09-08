/// chromaUI Responsive Utilities
///
/// Comprehensive responsive design utilities:
/// - Breakpoint management
/// - Screen size detection
/// - Responsive widget builders
/// - Adaptive layouts
/// - Device type detection
library responsive_utils;

import 'package:flutter/material.dart';
import '../../constants/design_tokens.dart';

/// Device types
enum DeviceType {
  mobile,
  tablet,
  desktop,
  watch,
}

/// Screen orientations
enum ScreenOrientation {
  portrait,
  landscape,
}

/// Responsive breakpoints
class ResponsiveBreakpoints {
  static const double mobile = chromaBreakpoints.sm;
  static const double tablet = chromaBreakpoints.md;
  static const double desktop = chromaBreakpoints.lg;
  static const double largeDesktop = chromaBreakpoints.xl;
}

/// Responsive utilities
class ResponsiveUtils {
  /// Get device type from screen width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < ResponsiveBreakpoints.mobile) {
      return DeviceType.mobile;
    } else if (width < ResponsiveBreakpoints.tablet) {
      return DeviceType.mobile;
    } else if (width < ResponsiveBreakpoints.desktop) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  /// Get screen orientation
  static ScreenOrientation getOrientation(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > size.height ? ScreenOrientation.landscape : ScreenOrientation.portrait;
  }

  /// Check if portrait orientation
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == ScreenOrientation.portrait;
  }

  /// Check if landscape orientation
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == ScreenOrientation.landscape;
  }

  /// Get screen width
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get screen aspect ratio
  static double getAspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width / size.height;
  }

  /// Get responsive value based on screen width
  static T getValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    final width = getWidth(context);
    final deviceType = getDeviceType(context);

    if (width >= ResponsiveBreakpoints.largeDesktop && largeDesktop != null) {
      return largeDesktop;
    } else if (width >= ResponsiveBreakpoints.desktop && desktop != null) {
      return desktop;
    } else if (width >= ResponsiveBreakpoints.tablet && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  /// Get responsive padding
  static EdgeInsetsGeometry getResponsivePadding(BuildContext context) {
    return getValue(
      context,
      mobile: const EdgeInsets.all(chromaSpacing.sm),
      tablet: const EdgeInsets.all(chromaSpacing.md),
      desktop: const EdgeInsets.all(chromaSpacing.lg),
      largeDesktop: const EdgeInsets.all(chromaSpacing.xl),
    );
  }

  /// Get responsive margin
  static EdgeInsetsGeometry getResponsiveMargin(BuildContext context) {
    return getValue(
      context,
      mobile: const EdgeInsets.all(chromaSpacing.sm),
      tablet: const EdgeInsets.all(chromaSpacing.md),
      desktop: const EdgeInsets.all(chromaSpacing.lg),
      largeDesktop: const EdgeInsets.all(chromaSpacing.xl),
    );
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final width = getWidth(context);
    final scaleFactor = width / ResponsiveBreakpoints.mobile;

    return baseFontSize * (scaleFactor.clamp(0.8, 1.5));
  }

  /// Get responsive border radius
  static double getResponsiveBorderRadius(BuildContext context, double baseRadius) {
    final width = getWidth(context);
    final scaleFactor = width / ResponsiveBreakpoints.mobile;

    return baseRadius * (scaleFactor.clamp(0.8, 1.2));
  }

  /// Get responsive elevation
  static double getResponsiveElevation(BuildContext context, double baseElevation) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return baseElevation * 0.8;
      case DeviceType.tablet:
        return baseElevation * 0.9;
      case DeviceType.desktop:
        return baseElevation * 1.0;
      case DeviceType.watch:
        return baseElevation * 0.6;
    }
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    final width = getWidth(context);
    final scaleFactor = width / ResponsiveBreakpoints.mobile;

    return baseSpacing * (scaleFactor.clamp(0.8, 1.3));
  }

  /// Get responsive columns count
  static int getResponsiveColumns(BuildContext context, {int mobile = 1, int tablet = 2, int desktop = 3, int largeDesktop = 4}) {
    return getValue(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// Get responsive grid delegate
  static SliverGridDelegate getResponsiveGridDelegate(
    BuildContext context, {
    double mainAxisSpacing = chromaSpacing.sm,
    double crossAxisSpacing = chromaSpacing.sm,
    double childAspectRatio = 1.0,
    int maxCrossAxisExtent = 200,
  }) {
    final columns = getResponsiveColumns(context);
    final width = getWidth(context);

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: columns,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
    );
  }

  /// Check if should show navigation rail
  static bool shouldShowNavigationRail(BuildContext context) {
    return isTablet(context) || isDesktop(context);
  }

  /// Check if should show bottom navigation
  static bool shouldShowBottomNavigation(BuildContext context) {
    return isMobile(context);
  }

  /// Check if should show drawer
  static bool shouldShowDrawer(BuildContext context) {
    return isMobile(context) || isTablet(context);
  }

  /// Get responsive dialog constraints
  static BoxConstraints getResponsiveDialogConstraints(BuildContext context) {
    final width = getWidth(context);

    if (width < ResponsiveBreakpoints.mobile) {
      return const BoxConstraints(maxWidth: 300);
    } else if (width < ResponsiveBreakpoints.tablet) {
      return const BoxConstraints(maxWidth: 400);
    } else if (width < ResponsiveBreakpoints.desktop) {
      return const BoxConstraints(maxWidth: 600);
    } else {
      return const BoxConstraints(maxWidth: 800);
    }
  }

  /// Get responsive sheet constraints
  static BoxConstraints getResponsiveSheetConstraints(BuildContext context) {
    final height = getHeight(context);

    if (height < 600) {
      return BoxConstraints(maxHeight: height * 0.8);
    } else {
      return BoxConstraints(maxHeight: height * 0.6);
    }
  }
}

/// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveUtils.getDeviceType(context);
    return builder(context, deviceType);
  }
}

/// Responsive layout widget
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        switch (deviceType) {
          case DeviceType.mobile:
            return mobile;
          case DeviceType.tablet:
            return tablet ?? mobile;
          case DeviceType.desktop:
            return desktop ?? tablet ?? mobile;
          case DeviceType.watch:
            return mobile;
        }
      },
    );
  }
}

/// Responsive container widget
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final Clip clipBehavior;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.decoration,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? ResponsiveUtils.getResponsivePadding(context);
    final responsiveMargin = margin ?? ResponsiveUtils.getResponsiveMargin(context);

    return Container(
      padding: responsivePadding,
      margin: responsiveMargin,
      width: width,
      height: height,
      decoration: decoration,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

/// Responsive grid widget
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final int? largeDesktopColumns;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mainAxisSpacing = chromaSpacing.sm,
    this.crossAxisSpacing = chromaSpacing.sm,
    this.childAspectRatio = 1.0,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.largeDesktopColumns,
  });

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.getValue(
      context,
      mobile: mobileColumns ?? 1,
      tablet: tabletColumns ?? 2,
      desktop: desktopColumns ?? 3,
      largeDesktop: largeDesktopColumns ?? 4,
    );

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

/// Responsive spacing widget
class ResponsiveSpacing extends StatelessWidget {
  final double? height;
  final double? width;

  const ResponsiveSpacing({
    super.key,
    this.height,
    this.width,
  });

  const ResponsiveSpacing.horizontal({super.key, double? width}) : height = null, width = width;

  const ResponsiveSpacing.vertical({super.key, double? height}) : height = height, width = null;

  @override
  Widget build(BuildContext context) {
    final responsiveHeight = height != null
        ? ResponsiveUtils.getResponsiveSpacing(context, height!)
        : null;
    final responsiveWidth = width != null
        ? ResponsiveUtils.getResponsiveSpacing(context, width!)
        : null;

    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
    );
  }
}

/// Responsive text widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveStyle = style?.copyWith(
      fontSize: style?.fontSize != null
          ? ResponsiveUtils.getResponsiveFontSize(context, style!.fontSize!)
          : null,
    );

    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

/// Responsive extension on BuildContext
extension ResponsiveContextExtension on BuildContext {
  DeviceType get deviceType => ResponsiveUtils.getDeviceType(this);

  bool get isMobile => ResponsiveUtils.isMobile(this);

  bool get isTablet => ResponsiveUtils.isTablet(this);

  bool get isDesktop => ResponsiveUtils.isDesktop(this);

  double get screenWidth => ResponsiveUtils.getWidth(this);

  double get screenHeight => ResponsiveUtils.getHeight(this);

  double get aspectRatio => ResponsiveUtils.getAspectRatio(this);

  ScreenOrientation get orientation => ResponsiveUtils.getOrientation(this);

  bool get isPortrait => ResponsiveUtils.isPortrait(this);

  bool get isLandscape => ResponsiveUtils.isLandscape(this);

  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    return ResponsiveUtils.getValue(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  EdgeInsetsGeometry get responsivePadding => ResponsiveUtils.getResponsivePadding(this);

  EdgeInsetsGeometry get responsiveMargin => ResponsiveUtils.getResponsiveMargin(this);

  double responsiveFontSize(double baseFontSize) {
    return ResponsiveUtils.getResponsiveFontSize(this, baseFontSize);
  }

  double responsiveBorderRadius(double baseRadius) {
    return ResponsiveUtils.getResponsiveBorderRadius(this, baseRadius);
  }

  double responsiveElevation(double baseElevation) {
    return ResponsiveUtils.getResponsiveElevation(this, baseElevation);
  }

  double responsiveSpacing(double baseSpacing) {
    return ResponsiveUtils.getResponsiveSpacing(this, baseSpacing);
  }

  int responsiveColumns({
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
    int largeDesktop = 4,
  }) {
    return ResponsiveUtils.getResponsiveColumns(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }
}
