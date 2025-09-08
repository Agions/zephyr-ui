import 'package:flutter/material.dart';
import 'package:flutter_ui/src/core/theme/theme.dart';

class chromaTokens {
  const chromaTokens({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.radii,
    required this.shadows,
    required this.animations,
  });

  final chromaColors colors;
  final chromaTypography typography;
  final chromaSpacing spacing;
  final chromaRadii radii;
  final chromaShadows shadows;
  final chromaAnimations animations;
}

class chromaColors {
  const chromaColors({
    // Define color tokens here
    required this.primary,
    required this.secondary,
    required this.success,
    required this.warning,
    required this.error,
    required this.background,
    required this.surface,
    required this.onPrimary,
    required this.onSecondary,
    // ... add other colors
  });

  final Color primary;
  final Color secondary;
  final Color success;
  final Color warning;
  final Color error;
  final Color background;
  final Color surface;
  final Color onPrimary;
  final Color onSecondary;
}

class chromaTypography {
  const chromaTypography({
    // Define typography tokens here
    required this.headline1,
    required this.bodyText1,
    required this.caption,
    // ... add other text styles
  });

  final TextStyle headline1;
  final TextStyle bodyText1;
  final TextStyle caption;
}

class chromaSpacing {
  const chromaSpacing({
    // Define spacing tokens here
    required this.xxs,
    required this.xs,
    required this.s,
    required this.m,
    required this.l,
    required this.xl,
    required this.xxl,
  });

  final double xxs;
  final double xs;
  final double s;
  final double m;
  final double l;
  final double xl;
  final double xxl;
}

class chromaRadii {
  const chromaRadii({
    // Define radii tokens here
    required this.s,
    required this.m,
    required this.l,
    required this.full,
  });

  final Radius s;
  final Radius m;
  final Radius l;
  final Radius full;
}

class chromaShadows {
  const chromaShadows({
    // Define shadow tokens here
    required this.s,
    required this.m,
    required this.l,
  });

  final List<BoxShadow> s;
  final List<BoxShadow> m;
  final List<BoxShadow> l;
}

class chromaAnimations {
  const chromaAnimations({
    // Define animation tokens here
    required this.defaultCurve,
    required this.defaultDuration,
  });

  final Curve defaultCurve;
  final Duration defaultDuration;
}
