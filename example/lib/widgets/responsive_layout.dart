import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 && 
           MediaQuery.of(context).size.width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    
    if (size >= 1024 && desktop != null) {
      return desktop!;
    } else if (size >= 768 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 16,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    int crossAxisCount;
    
    if (size >= 1024) {
      crossAxisCount = desktopColumns!;
    } else if (size >= 768) {
      crossAxisCount = tabletColumns!;
    } else {
      crossAxisCount = mobileColumns!;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
        
        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children.map((child) {
            return SizedBox(
              width: itemWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}

class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;

  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  T getValue(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    
    if (size >= 1024 && desktop != null) {
      return desktop!;
    } else if (size >= 768 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

class ResponsiveSpacing {
  static double getSpacing(BuildContext context, {double mobile = 16, double? tablet, double? desktop}) {
    return ResponsiveValue<double>(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    ).getValue(context);
  }

  static EdgeInsets getPadding(BuildContext context, {
    double mobile = 16,
    double? tablet,
    double? desktop,
  }) {
    final spacing = getSpacing(context, mobile: mobile, tablet: tablet, desktop: desktop);
    return EdgeInsets.all(spacing);
  }

  static EdgeInsets getHorizontalPadding(BuildContext context, {
    double mobile = 16,
    double? tablet,
    double? desktop,
  }) {
    final spacing = getSpacing(context, mobile: mobile, tablet: tablet, desktop: desktop);
    return EdgeInsets.symmetric(horizontal: spacing);
  }

  static EdgeInsets getVerticalPadding(BuildContext context, {
    double mobile = 16,
    double? tablet,
    double? desktop,
  }) {
    final spacing = getSpacing(context, mobile: mobile, tablet: tablet, desktop: desktop);
    return EdgeInsets.symmetric(vertical: spacing);
  }
}