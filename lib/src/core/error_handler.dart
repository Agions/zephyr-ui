import 'package:flutter/material.dart';

/// 错误处理策略枚举
enum ZephyrErrorHandlingStrategy {
  /// 显示错误消息
  showMessage,
  /// 静默处理
  silent,
  /// 记录日志
  log,
  /// 重试
  retry,
  /// 降级处理
  fallback,
}

/// 错误级别枚举
enum ZephyrErrorLevel {
  /// 信息级别
  info,
  /// 警告级别
  warning,
  /// 错误级别
  error,
  /// 严重错误级别
  critical,
}

/// 错误代码枚举
enum ZephyrErrorCodes {
  /// 未知错误
  unknown(1000),
  /// 网络错误
  network(1001),
  /// 认证错误
  authentication(1002),
  /// 权限错误
  authorization(1003),
  /// 验证错误
  validation(1004),
  /// 服务器错误
  server(1005),
  /// 客户端错误
  client(1006),
  /// 可访问性错误
  accessibility(1007),
  /// 主题错误
  theme(1008),
  /// 组件错误
  component(1009),
  /// 性能错误
  performance(1010);

  const ZephyrErrorCodes(this.code);
  final int code;
}

/// 错误处理器
class ZephyrErrorHandler {
  factory ZephyrErrorHandler() => _instance;
  
  ZephyrErrorHandler._internal();
  
  static final ZephyrErrorHandler _instance = ZephyrErrorHandler._internal();

  /// 处理错误
  void handleError(
    dynamic error, {
    ZephyrErrorHandlingStrategy strategy = ZephyrErrorHandlingStrategy.showMessage,
    ZephyrErrorLevel level = ZephyrErrorLevel.error,
    String? message,
    BuildContext? context,
  }) {
    debugPrint('Zephyr Error: ${error.toString()}');
    
    switch (strategy) {
      case ZephyrErrorHandlingStrategy.showMessage:
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message ?? error.toString()),
              backgroundColor: _getLevelColor(level),
            ),
          );
        }
        break;
      case ZephyrErrorHandlingStrategy.log:
        debugPrint('[$level] Error: $error');
        break;
      case ZephyrErrorHandlingStrategy.silent:
        // 静默处理，不显示任何信息
        break;
      case ZephyrErrorHandlingStrategy.retry:
        // 重试逻辑需要在调用方实现
        break;
      case ZephyrErrorHandlingStrategy.fallback:
        // 降级处理需要在调用方实现
        break;
    }
  }

  Color _getLevelColor(ZephyrErrorLevel level) {
    switch (level) {
      case ZephyrErrorLevel.info:
        return Colors.blue;
      case ZephyrErrorLevel.warning:
        return Colors.orange;
      case ZephyrErrorLevel.error:
        return Colors.red;
      case ZephyrErrorLevel.critical:
        return Colors.red.shade900;
    }
  }
}

/// 错误边界组件
class ZephyrErrorBoundary extends StatefulWidget {
  const ZephyrErrorBoundary({
    super.key,
    required this.child,
    this.strategy = ZephyrErrorHandlingStrategy.showMessage,
    this.errorWidget,
    this.onError,
  });

  final Widget child;
  final Widget? errorWidget;
  final ZephyrErrorHandlingStrategy strategy;
  final void Function(dynamic error, StackTrace? stackTrace)? onError;

  @override
  State<ZephyrErrorBoundary> createState() => _ZephyrErrorBoundaryState();

  /// 静态安全执行方法，用于错误边界外部的错误处理
  static T safeExecute<T>(T Function() action, {
    T? defaultValue,
    void Function(dynamic error, StackTrace? stackTrace)? onError,
  }) {
    try {
      return action();
    } catch (error, stackTrace) {
      onError?.call(error, stackTrace);
      return defaultValue ?? (throw error);
    }
  }

  /// 静态异步安全执行方法
  static Future<T> safeExecuteAsync<T>(Future<T> Function() action, {
    T? defaultValue,
    void Function(dynamic error, StackTrace? stackTrace)? onError,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      onError?.call(error, stackTrace);
      return defaultValue ?? (throw error);
    }
  }
}

class _ZephyrErrorBoundaryState extends State<ZephyrErrorBoundary> {
  dynamic _error;
  StackTrace? _stackTrace;

  /// 安全执行方法，用于在错误边界内执行可能抛出异常的代码
  T safeExecute<T>(T Function() action, {T? defaultValue}) {
    try {
      return action();
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
      return defaultValue ?? (throw error);
    }
  }

  /// 异步安全执行方法
  Future<T> safeExecuteAsync<T>(Future<T> Function() action, {T? defaultValue}) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
      return defaultValue ?? (throw error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorWidget ?? _buildErrorWidget(context);
    }
    return widget.child;
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          const Text(
            '出现错误',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _error.toString(),
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _error = null;
                _stackTrace = null;
              });
            },
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }

  void _handleError(dynamic error, StackTrace? stackTrace) {
    setState(() {
      _error = error;
      _stackTrace = stackTrace;
    });

    final errorHandler = ZephyrErrorHandler();
    errorHandler.handleError(
      error,
      strategy: widget.strategy,
      context: context,
    );

    widget.onError?.call(error, stackTrace);
  }
}

/// 错误边界配置类
class ZephyrErrorBoundaryConfig {
  final ZephyrErrorHandlingStrategy strategy;
  final Widget? errorWidget;
  final bool enableLogging;
  final bool enableReporting;
  final int maxRetryAttempts;

  const ZephyrErrorBoundaryConfig({
    this.strategy = ZephyrErrorHandlingStrategy.showMessage,
    this.errorWidget,
    this.enableLogging = true,
    this.enableReporting = false,
    this.maxRetryAttempts = 3,
  });
}

/// 验证错误类
class ZephyrValidationError implements Exception {
  final String message;
  final String? field;
  final dynamic value;

  ZephyrValidationError({
    required this.message,
    this.field,
    this.value,
  });

  @override
  String toString() {
    if (field != null) {
      return 'Validation error in $field: $message';
    }
    return 'Validation error: $message';
  }
}

/// 网络错误类
class ZephyrNetworkError implements Exception {
  final String message;
  final int? statusCode;
  final String? url;

  ZephyrNetworkError({
    required this.message,
    this.statusCode,
    this.url,
  });

  @override
  String toString() {
    return 'Network error${statusCode != null ? ' ($statusCode)' : ''}: $message${url != null ? ' ($url)' : ''}';
  }
}

/// 组件错误类
class ZephyrComponentError implements Exception {
  final String message;
  final String? component;
  final dynamic originalError;

  ZephyrComponentError({
    required this.message,
    this.component,
    this.originalError,
  });

  @override
  String toString() {
    return 'Component error${component != null ? ' in $component' : ''}: $message';
  }
}

/// 通用错误类
class ZephyrError implements Exception {
  final String message;
  final ZephyrErrorLevel level;
  final dynamic originalError;
  final StackTrace? stackTrace;

  ZephyrError({
    required this.message,
    this.level = ZephyrErrorLevel.error,
    this.originalError,
    this.stackTrace,
  });

  /// 获取本地化错误消息
  String getLocalizedMessage([BuildContext? context]) {
    // TODO: 实现国际化支持
    return message;
  }

  @override
  String toString() {
    return 'Error ($level): $message';
  }
}

/// 异步错误边界组件
class ZephyrAsyncErrorBoundary extends StatefulWidget {
  const ZephyrAsyncErrorBoundary({
    super.key,
    required this.child,
    this.loadingWidget,
    this.errorWidget,
    this.onRefresh,
    this.onError,
  });

  final Widget child;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Future<void> Function()? onRefresh;
  final void Function(dynamic error, StackTrace? stackTrace)? onError;

  @override
  State<ZephyrAsyncErrorBoundary> createState() => _ZephyrAsyncErrorBoundaryState();
}

class _ZephyrAsyncErrorBoundaryState extends State<ZephyrAsyncErrorBoundary> {
  dynamic _error;
  StackTrace? _stackTrace;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return widget.loadingWidget ?? const Center(child: CircularProgressIndicator());
    }
    
    if (_error != null) {
      return widget.errorWidget ?? _buildErrorWidget(context);
    }
    
    return widget.child;
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          const Text(
            '加载失败',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _error.toString(),
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _handleRefresh,
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    if (widget.onRefresh != null) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      try {
        await widget.onRefresh!();
      } catch (error, stackTrace) {
        setState(() {
          _error = error;
          _stackTrace = stackTrace;
        });
        widget.onError?.call(error, stackTrace);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void handleError(dynamic error, StackTrace? stackTrace) {
    setState(() {
      _error = error;
      _stackTrace = stackTrace;
      _isLoading = false;
    });
    widget.onError?.call(error, stackTrace);
  }
}