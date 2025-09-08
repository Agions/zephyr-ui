/// chromaUI Environment Configuration
///
/// Manages environment-specific settings and configurations:
/// - Development, staging, production environments
/// - Feature flags
/// - API endpoints
/// - Logging levels
/// - Performance settings
library environment_config;

import 'package:flutter/foundation.dart';

/// Environment types
enum Environment {
  development,
  staging,
  production,
}

/// Environment configuration
class EnvironmentConfig {
  static EnvironmentConfig? _instance;
  static EnvironmentConfig get instance => _instance ??= EnvironmentConfig._internal();

  Environment _currentEnvironment = Environment.development;

  EnvironmentConfig._internal();

  /// Current environment
  Environment get currentEnvironment => _currentEnvironment;

  /// Initialize environment
  void initialize(Environment environment) {
    _currentEnvironment = environment;
    if (kDebugMode) {
      debugPrint('Environment initialized: ${environment.name}');
    }
  }

  /// Check if current environment is development
  bool get isDevelopment => _currentEnvironment == Environment.development;

  /// Check if current environment is staging
  bool get isStaging => _currentEnvironment == Environment.staging;

  /// Check if current environment is production
  bool get isProduction => _currentEnvironment == Environment.production;

  /// Get API base URL
  String get apiBaseUrl {
    switch (_currentEnvironment) {
      case Environment.development:
        return 'https://dev-api.chromaui.com';
      case Environment.staging:
        return 'https://staging-api.chromaui.com';
      case Environment.production:
        return 'https://api.chromaui.com';
    }
  }

  /// Get WebSocket URL
  String get webSocketUrl {
    switch (_currentEnvironment) {
      case Environment.development:
        return 'wss://dev-api.chromaui.com/ws';
      case Environment.staging:
        return 'wss://staging-api.chromaui.com/ws';
      case Environment.production:
        return 'wss://api.chromaui.com/ws';
    }
  }

  /// Get logging level
  String get logLevel {
    switch (_currentEnvironment) {
      case Environment.development:
        return 'DEBUG';
      case Environment.staging:
        return 'INFO';
      case Environment.production:
        return 'WARNING';
    }
  }

  /// Get analytics tracking ID
  String get analyticsTrackingId {
    switch (_currentEnvironment) {
      case Environment.development:
        return 'dev-tracking-id';
      case Environment.staging:
        return 'staging-tracking-id';
      case Environment.production:
        return 'production-tracking-id';
    }
  }

  /// Check if debugging is enabled
  bool get isDebugMode {
    return kDebugMode || isDevelopment;
  }

  /// Get timeout duration
  Duration get timeout {
    switch (_currentEnvironment) {
      case Environment.development:
        return const Duration(seconds: 30);
      case Environment.staging:
        return const Duration(seconds: 20);
      case Environment.production:
        return const Duration(seconds: 15);
    }
  }

  /// Get cache duration
  Duration get cacheDuration {
    switch (_currentEnvironment) {
      case Environment.development:
        return const Duration(minutes: 5);
      case Environment.staging:
        return const Duration(minutes: 30);
      case Environment.production:
        return const Duration(hours: 1);
    }
  }

  /// Get maximum retry attempts
  int get maxRetryAttempts {
    switch (_currentEnvironment) {
      case Environment.development:
        return 1;
      case Environment.staging:
        return 3;
      case Environment.production:
        return 5;
    }
  }

  /// Check if performance monitoring is enabled
  bool get isPerformanceMonitoringEnabled {
    switch (_currentEnvironment) {
      case Environment.development:
        return true;
      case Environment.staging:
        return true;
      case Environment.production:
        return true;
    }
  }

  /// Check if crash reporting is enabled
  bool get isCrashReportingEnabled {
    switch (_currentEnvironment) {
      case Environment.development:
        return false;
      case Environment.staging:
        return true;
      case Environment.production:
        return true;
    }
  }

  /// Get Sentry DSN
  String get sentryDsn {
    switch (_currentEnvironment) {
      case Environment.development:
        return '';
      case Environment.staging:
        return 'https://staging-sentry-dsn';
      case Environment.production:
        return 'https://production-sentry-dsn';
    }
  }

  /// Check if analytics is enabled
  bool get isAnalyticsEnabled {
    switch (_currentEnvironment) {
      case Environment.development:
        return false;
      case Environment.staging:
        return true;
      case Environment.production:
        return true;
    }
  }

  /// Get CDN base URL
  String get cdnBaseUrl {
    switch (_currentEnvironment) {
      case Environment.development:
        return 'https://dev-cdn.chromaui.com';
      case Environment.staging:
        return 'https://staging-cdn.chromaui.com';
      case Environment.production:
        return 'https://cdn.chromaui.com';
    }
  }

  /// Environment-specific configuration
  Map<String, dynamic> get config {
    return {
      'environment': _currentEnvironment.name,
      'apiBaseUrl': apiBaseUrl,
      'webSocketUrl': webSocketUrl,
      'logLevel': logLevel,
      'analyticsTrackingId': analyticsTrackingId,
      'isDebugMode': isDebugMode,
      'timeout': timeout.inMilliseconds,
      'cacheDuration': cacheDuration.inMilliseconds,
      'maxRetryAttempts': maxRetryAttempts,
      'isPerformanceMonitoringEnabled': isPerformanceMonitoringEnabled,
      'isCrashReportingEnabled': isCrashReportingEnabled,
      'sentryDsn': sentryDsn,
      'isAnalyticsEnabled': isAnalyticsEnabled,
      'cdnBaseUrl': cdnBaseUrl,
    };
  }

  /// Update environment configuration
  void updateConfig(Map<String, dynamic> newConfig) {
    // This method allows runtime configuration updates
    if (kDebugMode) {
      debugPrint('Updating environment configuration: $newConfig');
    }

    // Implementation for updating specific config values
    // This would be expanded based on specific requirements
  }
}

/// Global environment config instance
final environmentConfig = EnvironmentConfig.instance;
