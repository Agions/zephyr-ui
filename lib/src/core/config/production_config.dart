/// ZephyrUI 生产环境配置
///
/// 定义生产环境的配置和优化设置。
library production_config;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// ZephyrUI 生产环境配置
class ZephyrProductionConfig {
  ZephyrProductionConfig._();

  /// 是否启用性能监控
  static const bool enablePerformanceMonitoring = kDebugMode;

  /// 是否启用调试信息
  static const bool enableDebugInfo = kDebugMode;

  /// 是否启用错误报告
  static const bool enableErrorReporting = !kDebugMode;

  /// 是否启用分析
  static const bool enableAnalytics = !kDebugMode;

  /// 默认动画时长（生产环境可能需要更快的动画）
  static const Duration defaultAnimationDuration =
      kDebugMode ? Duration(milliseconds: 300) : Duration(milliseconds: 200);

  /// 默认动画曲线
  static const Curve defaultAnimationCurve = Curves.easeInOut;

  /// 是否启用无障碍功能
  static const bool enableAccessibility = true;

  /// 是否启用语义化
  static const bool enableSemantics = true;

  /// 最大缓存大小
  static const int maxCacheSize = kDebugMode ? 50 : 100;

  /// 图片缓存大小
  static const int imageCacheSize = kDebugMode ? 50 : 200;

  /// 网络超时时间
  static const Duration networkTimeout = Duration(seconds: 30);

  /// 重试次数
  static const int maxRetryCount = 3;

  /// 是否启用预加载
  static const bool enablePreloading = !kDebugMode;

  /// 是否启用懒加载
  static const bool enableLazyLoading = true;

  /// 批处理大小
  static const int batchSize = 20;

  /// 虚拟化阈值
  static const int virtualizationThreshold = 50;

  /// 是否启用树摇优化
  static const bool enableTreeShaking = !kDebugMode;

  /// 是否启用代码分割
  static const bool enableCodeSplitting = !kDebugMode;

  /// 日志级别
  static LogLevel get logLevel {
    if (kDebugMode) {
      return LogLevel.debug;
    } else if (kProfileMode) {
      return LogLevel.info;
    } else {
      return LogLevel.error;
    }
  }

  /// 获取优化的滚动物理
  static ScrollPhysics get optimizedScrollPhysics {
    if (kDebugMode) {
      return const BouncingScrollPhysics();
    } else {
      return const ClampingScrollPhysics();
    }
  }

  /// 获取优化的列表配置
  static Map<String, dynamic> get optimizedListConfig {
    return {
      'cacheExtent': kDebugMode ? 250.0 : 500.0,
      'addAutomaticKeepAlives': !kDebugMode,
      'addRepaintBoundaries': true,
      'addSemanticIndexes': enableSemantics,
    };
  }

  /// 获取优化的图片配置
  static Map<String, dynamic> get optimizedImageConfig {
    return {
      'cacheWidth': kDebugMode ? null : 800,
      'cacheHeight': kDebugMode ? null : 600,
      'filterQuality': kDebugMode ? FilterQuality.medium : FilterQuality.low,
      'isAntiAlias': !kDebugMode,
    };
  }

  /// 获取优化的文本配置
  static Map<String, dynamic> get optimizedTextConfig {
    return {
      'maxLines': kDebugMode ? null : 10,
      'overflow': TextOverflow.ellipsis,
      'softWrap': true,
      'textWidthBasis': TextWidthBasis.parent,
    };
  }

  /// 获取内存优化配置
  static Map<String, dynamic> get memoryOptimizationConfig {
    return {
      'enableImageCache': true,
      'imageCacheSize': imageCacheSize,
      'enableWidgetCache': !kDebugMode,
      'maxCacheSize': maxCacheSize,
      'enableGarbageCollection': !kDebugMode,
      'gcInterval': const Duration(minutes: 5),
    };
  }

  /// 获取网络优化配置
  static Map<String, dynamic> get networkOptimizationConfig {
    return {
      'timeout': networkTimeout,
      'maxRetries': maxRetryCount,
      'enableCompression': !kDebugMode,
      'enableCaching': !kDebugMode,
      'cacheMaxAge': const Duration(hours: 1),
      'enableConnectionPooling': !kDebugMode,
    };
  }

  /// 获取渲染优化配置
  static Map<String, dynamic> get renderOptimizationConfig {
    return {
      'enableRepaintBoundary': !kDebugMode,
      'enableClipping': true,
      'enableAntiAliasing': !kDebugMode,
      'enableDithering': false,
      'enableMipmaps': !kDebugMode,
    };
  }

  /// 获取动画优化配置
  static Map<String, dynamic> get animationOptimizationConfig {
    return {
      'duration': defaultAnimationDuration,
      'curve': defaultAnimationCurve,
      'enableHardwareAcceleration': !kDebugMode,
      'enableImplicitAnimations': true,
      'enablePhysicsSimulation': kDebugMode,
      'reducedMotion': false,
    };
  }

  /// 获取无障碍配置
  static Map<String, dynamic> get accessibilityConfig {
    return {
      'enableSemantics': enableSemantics,
      'enableScreenReader': enableAccessibility,
      'enableHighContrast': false,
      'enableLargeText': false,
      'enableReducedMotion': false,
      'semanticTimeout': const Duration(seconds: 5),
    };
  }

  /// 获取错误处理配置
  static Map<String, dynamic> get errorHandlingConfig {
    return {
      'enableErrorReporting': enableErrorReporting,
      'enableCrashReporting': !kDebugMode,
      'enableErrorBoundary': true,
      'enableFallbackUI': !kDebugMode,
      'maxErrorCount': 10,
      'errorTimeout': const Duration(seconds: 30),
    };
  }

  /// 获取分析配置
  static Map<String, dynamic> get analyticsConfig {
    return {
      'enableAnalytics': enableAnalytics,
      'enableUserTracking': false,
      'enablePerformanceTracking': !kDebugMode,
      'enableErrorTracking': !kDebugMode,
      'batchSize': 10,
      'flushInterval': const Duration(minutes: 5),
    };
  }

  /// 初始化生产环境配置
  static void initialize() {
    if (kDebugMode) {
      debugPrint('ZephyrUI: Debug mode configuration loaded');
    } else {
      debugPrint('ZephyrUI: Production mode configuration loaded');
    }

    // 设置错误处理
    _setupErrorHandling();

    // 设置内存管理
    _setupMemoryManagement();

    // 设置性能监控
    _setupPerformanceMonitoring();
  }

  /// 设置错误处理
  static void _setupErrorHandling() {
    if (enableErrorReporting) {
      FlutterError.onError = (FlutterErrorDetails details) {
        // 在生产环境中，可以将错误发送到错误报告服务
        debugPrint('ZephyrUI Error: ${details.exception}');
      };
    }
  }

  /// 设置内存管理
  static void _setupMemoryManagement() {
    if (!kDebugMode) {
      // 在生产环境中启用内存优化
      PaintingBinding.instance.imageCache.maximumSize = imageCacheSize;
      PaintingBinding.instance.imageCache.maximumSizeBytes = 100 << 20; // 100MB
    }
  }

  /// 设置性能监控
  static void _setupPerformanceMonitoring() {
    if (enablePerformanceMonitoring) {
      // 在调试模式下启用性能监控
      WidgetsBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
        for (final timing in timings) {
          final buildDuration = timing.buildDuration.inMicroseconds / 1000.0;
          final rasterDuration = timing.rasterDuration.inMicroseconds / 1000.0;

          if (buildDuration > 16.0 || rasterDuration > 16.0) {
            debugPrint(
              'ZephyrUI Performance Warning: '
              'Build: ${buildDuration.toStringAsFixed(1)}ms, '
              'Raster: ${rasterDuration.toStringAsFixed(1)}ms',
            );
          }
        }
      });
    }
  }

  /// 获取环境信息
  static Map<String, dynamic> getEnvironmentInfo() {
    return {
      'isDebugMode': kDebugMode,
      'isProfileMode': kProfileMode,
      'isReleaseMode': kReleaseMode,
      'platform': defaultTargetPlatform.name,
      'enablePerformanceMonitoring': enablePerformanceMonitoring,
      'enableErrorReporting': enableErrorReporting,
      'enableAnalytics': enableAnalytics,
      'logLevel': logLevel.name,
    };
  }
}

/// 日志级别
enum LogLevel {
  debug,
  info,
  warning,
  error,
  none,
}

/// 日志级别扩展
extension LogLevelExtension on LogLevel {
  String get name {
    switch (this) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARNING';
      case LogLevel.error:
        return 'ERROR';
      case LogLevel.none:
        return 'NONE';
    }
  }

  int get level {
    switch (this) {
      case LogLevel.debug:
        return 0;
      case LogLevel.info:
        return 1;
      case LogLevel.warning:
        return 2;
      case LogLevel.error:
        return 3;
      case LogLevel.none:
        return 4;
    }
  }
}
