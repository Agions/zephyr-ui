import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

/// 应用配置类
class AppConfig {
  final String appName;
  final String version;
  final String environment;
  final ApiConfig api;
  final ThemeConfig theme;
  final FeatureConfig features;
  final AnalyticsConfig analytics;
  final LoggingConfig logging;
  
  const AppConfig({
    required this.appName,
    required this.version,
    required this.environment,
    required this.api,
    required this.theme,
    required this.features,
    required this.analytics,
    required this.logging,
  });
  
  /// 从JSON创建配置
  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      appName: json['app_name'] as String,
      version: json['version'] as String,
      environment: json['environment'] as String,
      api: ApiConfig.fromJson(json['api'] as Map<String, dynamic>),
      theme: ThemeConfig.fromJson(json['theme'] as Map<String, dynamic>),
      features: FeatureConfig.fromJson(json['features'] as Map<String, dynamic>),
      analytics: AnalyticsConfig.fromJson(json['analytics'] as Map<String, dynamic>),
      logging: LoggingConfig.fromJson(json['logging'] as Map<String, dynamic>),
    );
  }
  
  /// 从YAML文件加载配置
  static Future<AppConfig> fromYaml(String path) async {
    final content = await rootBundle.loadString(path);
    final yaml = loadYaml(content) as YamlMap;
    return AppConfig.fromJson(_yamlToMap(yaml));
  }
  
  /// 转换YAML到Map
  static Map<String, dynamic> _yamlToMap(YamlMap yaml) {
    return yaml.nodes.map((key, value) => MapEntry(
      key.toString(),
      value is YamlMap ? _yamlToMap(value) : value,
    ));
  }
  
  /// 复制配置
  AppConfig copyWith({
    String? appName,
    String? version,
    String? environment,
    ApiConfig? api,
    ThemeConfig? theme,
    FeatureConfig? features,
    AnalyticsConfig? analytics,
    LoggingConfig? logging,
  }) {
    return AppConfig(
      appName: appName ?? this.appName,
      version: version ?? this.version,
      environment: environment ?? this.environment,
      api: api ?? this.api,
      theme: theme ?? this.theme,
      features: features ?? this.features,
      analytics: analytics ?? this.analytics,
      logging: logging ?? this.logging,
    );
  }
}

/// API配置
class ApiConfig {
  final String baseUrl;
  final int timeout;
  final int connectTimeout;
  final Map<String, String> headers;
  final bool enableLogging;
  
  const ApiConfig({
    required this.baseUrl,
    required this.timeout,
    required this.connectTimeout,
    required this.headers,
    required this.enableLogging,
  });
  
  factory ApiConfig.fromJson(Map<String, dynamic> json) {
    return ApiConfig(
      baseUrl: json['base_url'] as String,
      timeout: json['timeout'] as int,
      connectTimeout: json['connect_timeout'] as int,
      headers: Map<String, String>.from(json['headers'] as Map),
      enableLogging: json['enable_logging'] as bool,
    );
  }
}

/// 主题配置
class ThemeConfig {
  final String primaryColor;
  final String secondaryColor;
  final String fontFamily;
  final double borderRadius;
  final bool enableDarkMode;
  
  const ThemeConfig({
    required this.primaryColor,
    required this.secondaryColor,
    required this.fontFamily,
    required this.borderRadius,
    required this.enableDarkMode,
  });
  
  factory ThemeConfig.fromJson(Map<String, dynamic> json) {
    return ThemeConfig(
      primaryColor: json['primary_color'] as String,
      secondaryColor: json['secondary_color'] as String,
      fontFamily: json['font_family'] as String,
      borderRadius: (json['border_radius'] as num).toDouble(),
      enableDarkMode: json['enable_dark_mode'] as bool,
    );
  }
}

/// 功能配置
class FeatureConfig {
  final bool enableAnalytics;
  final bool enableCrashReporting;
  final bool enablePerformanceMonitoring;
  final bool enableOfflineMode;
  final List<String> enabledModules;
  
  const FeatureConfig({
    required this.enableAnalytics,
    required this.enableCrashReporting,
    required this.enablePerformanceMonitoring,
    required this.enableOfflineMode,
    required this.enabledModules,
  });
  
  factory FeatureConfig.fromJson(Map<String, dynamic> json) {
    return FeatureConfig(
      enableAnalytics: json['enable_analytics'] as bool,
      enableCrashReporting: json['enable_crash_reporting'] as bool,
      enablePerformanceMonitoring: json['enable_performance_monitoring'] as bool,
      enableOfflineMode: json['enable_offline_mode'] as bool,
      enabledModules: List<String>.from(json['enabled_modules'] as List),
    );
  }
}

/// 分析配置
class AnalyticsConfig {
  final String trackingId;
  final bool enableTracking;
  final Map<String, dynamic> customProperties;
  
  const AnalyticsConfig({
    required this.trackingId,
    required this.enableTracking,
    required this.customProperties,
  });
  
  factory AnalyticsConfig.fromJson(Map<String, dynamic> json) {
    return AnalyticsConfig(
      trackingId: json['tracking_id'] as String,
      enableTracking: json['enable_tracking'] as bool,
      customProperties: Map<String, dynamic>.from(json['custom_properties'] as Map),
    );
  }
}

/// 日志配置
class LoggingConfig {
  final String level;
  final bool enableConsole;
  final bool enableFile;
  final int maxFileSize;
  final int maxFiles;
  
  const LoggingConfig({
    required this.level,
    required this.enableConsole,
    required this.enableFile,
    required this.maxFileSize,
    required this.maxFiles,
  });
  
  factory LoggingConfig.fromJson(Map<String, dynamic> json) {
    return LoggingConfig(
      level: json['level'] as String,
      enableConsole: json['enable_console'] as bool,
      enableFile: json['enable_file'] as bool,
      maxFileSize: json['max_file_size'] as int,
      maxFiles: json['max_files'] as int,
    );
  }
}