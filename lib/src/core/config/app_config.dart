/// chromaUI Application Configuration
///
/// Centralized application configuration management:
/// - App settings
/// - User preferences
/// - Theme settings
/// - API configuration
/// - Third-party integrations
library app_config;

import 'package:flutter/foundation.dart';
import 'environment_config.dart';
import 'feature_flags.dart';

/// App configuration sections
enum AppConfigSection {
  general,
  theme,
  api,
  analytics,
  security,
  performance,
}

/// App configuration
class AppConfig {
  static AppConfig? _instance;
  static AppConfig get instance => _instance ??= AppConfig._internal();

  final Map<String, dynamic> _config = {};
  final Map<AppConfigSection, Map<String, dynamic>> _sections = {};

  AppConfig._internal();

  /// Initialize app configuration
  void initialize() {
    _initializeDefaultConfig();
    if (kDebugMode) {
      debugPrint('App configuration initialized');
    }
  }

  /// Initialize default configuration
  void _initializeDefaultConfig() {
    // General configuration
    _setSectionValue(AppConfigSection.general, 'app_name', 'chromaUI');
    _setSectionValue(AppConfigSection.general, 'app_version', '1.0.0');
    _setSectionValue(AppConfigSection.general, 'build_number', '1');
    _setSectionValue(AppConfigSection.general, 'debug_mode', kDebugMode);
    _setSectionValue(AppConfigSection.general, 'enable_crash_reporting', !kDebugMode);
    _setSectionValue(AppConfigSection.general, 'enable_analytics', !kDebugMode);

    // Theme configuration
    _setSectionValue(AppConfigSection.theme, 'default_theme', 'light');
    _setSectionValue(AppConfigSection.theme, 'enable_dark_mode', true);
    _setSectionValue(AppConfigSection.theme, 'enable_system_theme', true);
    _setSectionValue(AppConfigSection.theme, 'primary_color', '#2196F3');
    _setSectionValue(AppConfigSection.theme, 'secondary_color', '#009688');
    _setSectionValue(AppConfigSection.theme, 'font_family', 'Roboto');
    _setSectionValue(AppConfigSection.theme, 'font_size_scale', 1.0);
    _setSectionValue(AppConfigSection.theme, 'enable_animations', true);
    _setSectionValue(AppConfigSection.theme, 'animation_duration', 300);

    // API configuration
    _setSectionValue(AppConfigSection.api, 'base_url', environmentConfig.apiBaseUrl);
    _setSectionValue(AppConfigSection.api, 'timeout', environmentConfig.timeout.inSeconds);
    _setSectionValue(AppConfigSection.api, 'max_retry_attempts', environmentConfig.maxRetryAttempts);
    _setSectionValue(AppConfigSection.api, 'enable_caching', true);
    _setSectionValue(AppConfigSection.api, 'cache_duration', environmentConfig.cacheDuration.inMinutes);
    _setSectionValue(AppConfigSection.api, 'enable_compression', true);
    _setSectionValue(AppConfigSection.api, 'enable_ssl_pinning', false);

    // Analytics configuration
    _setSectionValue(AppConfigSection.analytics, 'enable_analytics', environmentConfig.isAnalyticsEnabled);
    _setSectionValue(AppConfigSection.analytics, 'tracking_id', environmentConfig.analyticsTrackingId);
    _setSectionValue(AppConfigSection.analytics, 'session_timeout', 30);
    _setSectionValue(AppConfigSection.analytics, 'enable_screen_tracking', true);
    _setSectionValue(AppConfigSection.analytics, 'enable_user_tracking', true);
    _setSectionValue(AppConfigSection.analytics, 'enable_event_tracking', true);

    // Security configuration
    _setSectionValue(AppConfigSection.security, 'enable_encryption', true);
    _setSectionValue(AppConfigSection.security, 'encryption_key', '');
    _setSectionValue(AppConfigSection.security, 'enable_biometric_auth', false);
    _setSectionValue(AppConfigSection.security, 'session_timeout', 30);
    _setSectionValue(AppConfigSection.security, 'max_login_attempts', 5);
    _setSectionValue(AppConfigSection.security, 'password_min_length', 8);
    _setSectionValue(AppConfigSection.security, 'enable_two_factor_auth', false);

    // Performance configuration
    _setSectionValue(AppConfigSection.performance, 'enable_performance_monitoring', environmentConfig.isPerformanceMonitoringEnabled);
    _setSectionValue(AppConfigSection.performance, 'enable_memory_optimization', true);
    _setSectionValue(AppConfigSection.performance, 'enable_lazy_loading', true);
    _setSectionValue(AppConfigSection.performance, 'enable_image_caching', true);
    _setSectionValue(AppConfigSection.performance, 'max_cache_size', 100);
    _setSectionValue(AppConfigSection.performance, 'cache_cleanup_interval', 60);
    _setSectionValue(AppConfigSection.performance, 'enable_frame_rate_monitoring', true);
    _setSectionValue(AppConfigSection.performance, 'target_frame_rate', 60);
  }

  /// Set section value
  void _setSectionValue(AppConfigSection section, String key, dynamic value) {
    if (!_sections.containsKey(section)) {
      _sections[section] = {};
    }
    _sections[section]![key] = value;
    _config['${section.name}_$key'] = value;
  }

  /// Get configuration value
  T? getValue<T>(String key, {T? defaultValue}) {
    return _config[key] as T? ?? defaultValue;
  }

  /// Get section configuration
  Map<String, dynamic> getSection(AppConfigSection section) {
    return Map<String, dynamic>.from(_sections[section] ?? {});
  }

  /// Get section value
  T? getSectionValue<T>(AppConfigSection section, String key, {T? defaultValue}) {
    return _sections[section]?[key] as T? ?? defaultValue;
  }

  /// Set configuration value
  void setValue<T>(String key, T value) {
    _config[key] = value;

    if (kDebugMode) {
      debugPrint('Configuration updated: $key = $value');
    }
  }

  /// Set section value
  void setSectionValue<T>(AppConfigSection section, String key, T value) {
    _setSectionValue(section, key, value);

    if (kDebugMode) {
      debugPrint('Section configuration updated: ${section.name}.$key = $value');
    }
  }

  /// Get all configuration
  Map<String, dynamic> getAllConfig() {
    return Map<String, dynamic>.from(_config);
  }

  /// Get app name
  String get appName => getValue('general_app_name', defaultValue: 'chromaUI')!;

  /// Get app version
  String get appVersion => getValue('general_app_version', defaultValue: '1.0.0')!;

  /// Get build number
  String get buildNumber => getValue('general_build_number', defaultValue: '1')!;

  /// Check if debug mode is enabled
  bool get isDebugMode => getValue('general_debug_mode', defaultValue: false)!;

  /// Check if crash reporting is enabled
  bool get enableCrashReporting => getValue('general_enable_crash_reporting', defaultValue: true)!;

  /// Check if analytics is enabled
  bool get enableAnalytics => getValue('general_enable_analytics', defaultValue: true)!;

  /// Get default theme
  String get defaultTheme => getValue('theme_default_theme', defaultValue: 'light')!;

  /// Check if dark mode is enabled
  bool get enableDarkMode => getValue('theme_enable_dark_mode', defaultValue: true)!;

  /// Check if system theme is enabled
  bool get enableSystemTheme => getValue('theme_enable_system_theme', defaultValue: true)!;

  /// Get primary color
  String get primaryColor => getValue('theme_primary_color', defaultValue: '#2196F3')!;

  /// Get secondary color
  String get secondaryColor => getValue('theme_secondary_color', defaultValue: '#009688')!;

  /// Get font family
  String get fontFamily => getValue('theme_font_family', defaultValue: 'Roboto')!;

  /// Get font size scale
  double get fontSizeScale => getValue('theme_font_size_scale', defaultValue: 1.0)!;

  /// Check if animations are enabled
  bool get enableAnimations => getValue('theme_enable_animations', defaultValue: true)!;

  /// Get animation duration
  int get animationDuration => getValue('theme_animation_duration', defaultValue: 300)!;

  /// Get API base URL
  String get apiBaseUrl => getValue('api_base_url', defaultValue: environmentConfig.apiBaseUrl)!;

  /// Get API timeout
  int get apiTimeout => getValue('api_timeout', defaultValue: 30)!;

  /// Get max retry attempts
  int get maxRetryAttempts => getValue('api_max_retry_attempts', defaultValue: 3)!;

  /// Check if caching is enabled
  bool get enableCaching => getValue('api_enable_caching', defaultValue: true)!;

  /// Get cache duration
  int get cacheDuration => getValue('api_cache_duration', defaultValue: 30)!;

  /// Check if compression is enabled
  bool get enableCompression => getValue('api_enable_compression', defaultValue: true)!;

  /// Check if SSL pinning is enabled
  bool get enableSslPinning => getValue('api_enable_ssl_pinning', defaultValue: false)!;

  /// Update configuration from feature flags
  void updateFromFeatureFlags() {
    // Update configuration based on feature flags
    if (featureFlags.isDisabled('analytics')) {
      setValue('general_enable_analytics', false);
      setValue('analytics_enable_analytics', false);
    }

    if (featureFlags.isDisabled('crash_reporting')) {
      setValue('general_enable_crash_reporting', false);
    }

    if (featureFlags.isDisabled('performance_monitoring')) {
      setValue('performance_enable_performance_monitoring', false);
    }

    if (kDebugMode) {
      debugPrint('Configuration updated from feature flags');
    }
  }

  /// Reset configuration to defaults
  void reset() {
    _config.clear();
    _sections.clear();
    _initializeDefaultConfig();

    if (kDebugMode) {
      debugPrint('Configuration reset to defaults');
    }
  }

  /// Export configuration
  Map<String, dynamic> export() {
    return {
      'config': getAllConfig(),
      'sections': _sections.map((key, value) => MapEntry(key.name, value)),
      'environment': environmentConfig.config,
      'feature_flags': featureFlags.getAllFlags().map((flag) => {
        'name': flag.name,
        'status': flag.status.name,
        'enabled': flag.isEnabled,
      }).toList(),
    };
  }

  /// Import configuration
  void import(Map<String, dynamic> data) {
    if (data.containsKey('config')) {
      _config.clear();
      _config.addAll(data['config'] as Map<String, dynamic>);
    }

    if (data.containsKey('sections')) {
      _sections.clear();
      final sections = data['sections'] as Map<String, dynamic>;
      for (final entry in sections.entries) {
        final section = AppConfigSection.values.firstWhere(
          (e) => e.name == entry.key,
          orElse: () => AppConfigSection.general,
        );
        _sections[section] = Map<String, dynamic>.from(entry.value as Map);
      }
    }

    if (kDebugMode) {
      debugPrint('Configuration imported successfully');
    }
  }
}

/// Global app config instance
final appConfig = AppConfig.instance;
