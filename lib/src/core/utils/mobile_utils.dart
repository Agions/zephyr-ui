import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/mobile_config.dart';

/// chromaUI Mobile Utilities
///
/// Mobile-specific utilities for touch interactions, gestures, and device optimizations
class chromaMobileUtils {
  /// Check if the device is a tablet
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = size.width * size.width + size.height * size.height;
    return diagonal > 1100 * 1100; // Rough tablet detection
  }

  /// Get appropriate touch target size based on device type
  static double getTouchTargetSize(BuildContext context) {
    if (isTablet(context)) {
      return MobileConfig.minTouchTargetSize * 1.2;
    }
    return MobileConfig.minTouchTargetSize;
  }

  /// Get safe area padding for mobile devices
  static EdgeInsets getSafePadding(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return EdgeInsets.only(
      top: padding.top,
      bottom: padding.bottom + 8, // Extra padding for bottom navigation
      left: padding.left,
      right: padding.right,
    );
  }

  /// Trigger haptic feedback
  static void triggerHapticFeedback({
    HapticFeedbackType type = HapticFeedbackType.lightImpact,
  }) {
    if (!MobileConfig.enableHapticFeedback) return;

    switch (type) {
      case HapticFeedbackType.lightImpact:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.mediumImpact:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavyImpact:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selectionClick:
        HapticFeedback.selectionClick();
        break;
    }
  }

  /// Show toast notification
  static void showToast({
    required String message,
    BuildContext? context,
    ToastDuration duration = ToastDuration.short,
    ToastGravity gravity = ToastGravity.bottom,
  }) {
    // This would integrate with fluttertoast package
    // Implementation would be added when the package is available
  }

  /// Get device orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  /// Get appropriate text scale factor for accessibility
  static double getTextScaleFactor(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final platformBrightness = mediaQuery.platformBrightness;

    // Adjust text scale based on device type and accessibility settings
    if (isTablet(context)) {
      return mediaQuery.textScaleFactor * 0.9;
    }

    return mediaQuery.textScaleFactor;
  }

  /// Get appropriate keyboard type for mobile input
  static TextInputType getKeyboardTypeForInput(String inputType) {
    switch (inputType.toLowerCase()) {
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'number':
        return TextInputType.number;
      case 'url':
        return TextInputType.url;
      case 'multiline':
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  /// Format file size for mobile display
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  /// Check if file size is within mobile limits
  static bool isFileSizeValid(int bytes) {
    return bytes <= MobileConfig.maxFileSize;
  }

  /// Get appropriate animation duration based on device performance
  static Duration getAnimationDuration({
    bool isFast = false,
    bool isSlow = false,
  }) {
    if (isFast) {
      return MobileConfig.fastAnimationDuration;
    } else if (isSlow) {
      return MobileConfig.slowAnimationDuration;
    }
    return MobileConfig.defaultAnimationDuration;
  }
}

/// Haptic feedback types
enum HapticFeedbackType {
  lightImpact,
  mediumImpact,
  heavyImpact,
  selectionClick,
}

/// Toast duration options
enum ToastDuration {
  short,
  long,
}

/// Toast gravity options
enum ToastGravity {
  top,
  center,
  bottom,
}
