import 'package:logger/logger.dart';
import 'app_exception.dart';

/// 错误处理器接口
abstract class ErrorHandler {
  /// 处理异常
  void handleError(AppException exception);
  
  /// 处理未知异常
  void handleUnknownException(dynamic exception);
  
  /// 记录错误
  void logError(AppException exception);
}

/// 默认错误处理器
class DefaultErrorHandler implements ErrorHandler {
  final Logger _logger;
  
  const DefaultErrorHandler(this._logger);
  
  @override
  void handleError(AppException exception) {
    // 记录错误
    logError(exception);
    
    // 根据异常类型进行特定处理
    switch (exception.runtimeType) {
      case NetworkException:
        _handleNetworkException(exception as NetworkException);
        break;
      case AuthenticationException:
        _handleAuthenticationException(exception as AuthenticationException);
        break;
      case AuthorizationException:
        _handleAuthorizationException(exception as AuthorizationException);
        break;
      case ValidationException:
        _handleValidationException(exception as ValidationException);
        break;
      case CacheException:
        _handleCacheException(exception as CacheException);
        break;
      case ConfigurationException:
        _handleConfigurationException(exception as ConfigurationException);
        break;
      case BusinessException:
        _handleBusinessException(exception as BusinessException);
        break;
      default:
        _handleUnknownException(exception);
    }
  }
  
  @override
  void handleUnknownException(dynamic exception) {
    final appException = UnknownException(
      message: 'Unknown error occurred',
      originalException: exception is Exception ? exception : null,
    );
    handleError(appException);
  }
  
  @override
  void logError(AppException exception) {
    _logger.e(
      'Error occurred: ${exception.message}',
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }
  
  void _handleNetworkException(NetworkException exception) {
    _logger.w(
      'Network error: ${exception.message}',
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }
  
  void _handleAuthenticationException(AuthenticationException exception) {
    _logger.w(
      'Authentication error: ${exception.message}',
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }
  
  void _handleAuthorizationException(AuthorizationException exception) {
    _logger.w(
      'Authorization error: ${exception.message}',
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }
  
  void _handleValidationException(ValidationException exception) {
    _logger.w(
      'Validation error: ${exception.message}',
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }
  
  void _handleCacheException(CacheException exception) {
    _logger.w(
      'Cache error: ${exception.message}',
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }
  
  void _handleConfigurationException(ConfigurationException exception) {
    _logger.w(
      'Configuration error: ${exception.message}',
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }
  
  void _handleBusinessException(BusinessException exception) {
    _logger.w(
      'Business error: ${exception.message}',
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }
  
  void _handleUnknownException(AppException exception) {
    _logger.e(
      'Unknown error: ${exception.message}',
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }
}

/// 错误处理器工厂
class ErrorHandlerFactory {
  static ErrorHandler createErrorHandler(Logger logger) {
    return DefaultErrorHandler(logger);
  }
}