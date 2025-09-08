/// chromaUI Mobile Configuration
///
/// Mobile-specific configuration settings for iOS and Android platforms
class MobileConfig {
  // Touch and gesture settings
  static const double minTouchTargetSize = 44.0;
  static const double defaultButtonHeight = 48.0;
  static const double defaultButtonMinWidth = 88.0;
  static const double defaultPadding = 16.0;
  static const double defaultSpacing = 8.0;

  // Animation settings
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  // Screen size breakpoints
  static const double smallScreenBreakpoint = 360.0;
  static const double mediumScreenBreakpoint = 600.0;
  static const double largeScreenBreakpoint = 840.0;

  // Typography scale
  static const Map<String, double> textScaleFactors = {
    'small': 0.9,
    'normal': 1.0,
    'large': 1.1,
    'xlarge': 1.2,
  };

  // Mobile-specific features
  static const bool enableHapticFeedback = true;
  static const bool enablePullToRefresh = true;
  static const bool enableSwipeGestures = true;
  static const bool enablePullDownToDismiss = true;

  // Performance settings
  static const int maxImageCacheSize = 100; // MB
  static const int maxMemoryCacheSize = 50; // MB
  static const int maxConcurrentLoads = 4;

  // File upload settings
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> allowedVideoFormats = ['mp4', 'mov', 'avi'];

  // Camera settings
  static const double maxCameraPreviewWidth = 1920.0;
  static const double maxCameraPreviewHeight = 1080.0;
  static const Duration maxVideoDuration = Duration(minutes: 5);

  // Location settings
  static const Duration locationUpdateInterval = Duration(seconds: 10);
  static const double locationAccuracy = 10.0; // meters

  // Notification settings
  static const Duration notificationTimeout = Duration(seconds: 5);
  static const int maxNotificationTitleLength = 50;
  static const int maxNotificationBodyLength = 200;
}
