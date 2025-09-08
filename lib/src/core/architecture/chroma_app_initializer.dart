import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../config_manager/app_config.dart';
import '../error_handling/error_handler.dart';
import '../error_handling/app_exception.dart';
import '../internationalization/i18n_manager.dart';
import '../theme/chroma_theme.dart';
import '../performance/performance_monitor.dart';
import '../memory/memory_optimizer.dart';
import 'dependency_injection/injection_config.dart';
import 'service_locator/chroma_service_locator.dart';

/// chromaUI 应用初始化器
/// 提供企业级应用的初始化流程
class chromaAppInitializer {
  static final chromaAppInitializer _instance = chromaAppInitializer._internal();

  /// 单例实例
  static chromaAppInitializer get instance => _instance;

  /// 初始化状态
  bool _isInitialized = false;

  /// 应用配置
  AppConfig? _appConfig;

  /// 日志服务
  Logger? _logger;

  /// 错误处理器
  ErrorHandler? _errorHandler;

  /// 国际化管理器
  I18nManager? _i18nManager;

  /// 性能监控器
  PerformanceMonitor? _performanceMonitor;

  /// 内存优化器
  MemoryOptimizer? _memoryOptimizer;

  chromaAppInitializer._internal();

  /// 是否已初始化
  bool get isInitialized => _isInitialized;

  /// 获取应用配置
  AppConfig? get appConfig => _appConfig;

  /// 获取日志服务
  Logger? get logger => _logger;

  /// 获取错误处理器
  ErrorHandler? get errorHandler => _errorHandler;

  /// 获取国际化管理器
  I18nManager? get i18nManager => _i18nManager;

  /// 获取性能监控器
  PerformanceMonitor? get performanceMonitor => _performanceMonitor;

  /// 获取内存优化器
  MemoryOptimizer? get memoryOptimizer => _memoryOptimizer;

  /// 初始化应用
  Future<void> initialize({
    String? environment,
    bool enablePerformanceMonitoring = true,
    bool enableMemoryOptimization = true,
    bool enableErrorHandling = true,
    bool enableInternationalization = true,
    Map<String, dynamic>? customConfig,
  }) async {
    if (_isInitialized) {
      throw StateError('chromaAppInitializer is already initialized');
    }

    try {
      // 1. 初始化依赖注入
      await _initializeDependencyInjection(environment: environment);

      // 2. 加载应用配置
      await _loadAppConfig(customConfig: customConfig);

      // 3. 初始化核心服务
      await _initializeCoreServices();

      // 4. 初始化错误处理
      if (enableErrorHandling) {
        await _initializeErrorHandling();
      }

      // 5. 初始化国际化
      if (enableInternationalization) {
        await _initializeInternationalization();
      }

      // 6. 初始化性能监控
      if (enablePerformanceMonitoring) {
        await _initializePerformanceMonitoring();
      }

      // 7. 初始化内存优化
      if (enableMemoryOptimization) {
        await _initializeMemoryOptimization();
      }

      // 8. 设置全局错误处理
      _setupGlobalErrorHandling();

      _isInitialized = true;

      _logger?.i('chromaUI initialized successfully');

    } catch (e, stackTrace) {
      throw Exception('Failed to initialize chromaUI: $e');
    }
  }

  /// 初始化依赖注入
  Future<void> _initializeDependencyInjection({String? environment}) async {
    await configureInjection(environment: environment);
  }

  /// 加载应用配置
  Future<void> _loadAppConfig({Map<String, dynamic>? customConfig}) async {
    final serviceLocator = chromaServiceLocator;
    _appConfig = await serviceLocator.get<AppConfig>();

    // 合并自定义配置
    if (customConfig != null) {
      _appConfig = _mergeConfig(_appConfig!, customConfig);
    }
  }

  /// 合并配置
  AppConfig _mergeConfig(AppConfig baseConfig, Map<String, dynamic> customConfig) {
    // 这里实现配置合并逻辑
    return baseConfig;
  }

  /// 初始化核心服务
  Future<void> _initializeCoreServices() async {
    final serviceLocator = chromaServiceLocator;

    // 获取核心服务
    _logger = serviceLocator.get<Logger>();
    _logger?.i('Core services initialized');
  }

  /// 初始化错误处理
  Future<void> _initializeErrorHandling() async {
    if (_logger == null) return;

    _errorHandler = ErrorHandlerFactory.createErrorHandler(_logger!);
    _logger?.i('Error handling initialized');
  }

  /// 初始化国际化
  Future<void> _initializeInternationalization() async {
    _i18nManager = I18nManager();
    await _i18nManager?.initialize();
    _logger?.i('Internationalization initialized');
  }

  /// 初始化性能监控
  Future<void> _initializePerformanceMonitoring() async {
    _performanceMonitor = PerformanceMonitor();
    await _performanceMonitor?.initialize();
    _logger?.i('Performance monitoring initialized');
  }

  /// 初始化内存优化
  Future<void> _initializeMemoryOptimization() async {
    _memoryOptimizer = MemoryOptimizer();
    await _memoryOptimizer?.initialize();
    _logger?.i('Memory optimization initialized');
  }

  /// 设置全局错误处理
  void _setupGlobalErrorHandling() {
    // Flutter错误处理
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };

    // Dart错误处理
    PlatformDispatcher.instance.onError = (error, stack) {
      _handlePlatformError(error, stack);
      return true;
    };
  }

  /// 处理Flutter错误
  void _handleFlutterError(FlutterErrorDetails details) {
    final exception = UnknownException(
      message: details.exception.toString(),
      originalException: details.exception,
      stackTrace: details.stack,
    );

    _errorHandler?.handleError(exception);
  }

  /// 处理平台错误
  void _handlePlatformError(Object error, StackTrace? stack) {
    final exception = UnknownException(
      message: error.toString(),
      originalException: error is Exception ? error : null,
      stackTrace: stack,
    );

    _errorHandler?.handleError(exception);
  }

  /// 重置初始化器
  Future<void> reset() async {
    if (!_isInitialized) {
      return;
    }

    try {
      // 清理资源
      await _performanceMonitor?.dispose();
      await _memoryOptimizer?.dispose();
      await _i18nManager?.dispose();

      // 重置依赖注入
      resetInjection();

      // 重置状态
      _isInitialized = false;
      _appConfig = null;
      _logger = null;
      _errorHandler = null;
      _i18nManager = null;
      _performanceMonitor = null;
      _memoryOptimizer = null;

    } catch (e) {
      throw Exception('Failed to reset chromaAppInitializer: $e');
    }
  }

  /// 获取主题数据
  ThemeData getThemeData({Brightness brightness = Brightness.light}) {
    if (_appConfig == null) {
      return chromaTheme.getLightTheme();
    }

    switch (brightness) {
      case Brightness.light:
        return chromaTheme.getLightTheme();
      case Brightness.dark:
        return chromaTheme.getDarkTheme();
    }
  }

  /// 获取应用信息
  Map<String, dynamic> getAppInfo() {
    return {
      'appName': _appConfig?.appName ?? 'chromaUI',
      'version': _appConfig?.version ?? '1.0.0',
      'environment': _appConfig?.environment ?? 'production',
      'isInitialized': _isInitialized,
    };
  }
}
