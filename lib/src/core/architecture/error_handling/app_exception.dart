import 'package:equatable/equatable.dart';

/// 应用异常基类
abstract class AppException extends Equatable implements Exception {
  final String message;
  final String? code;
  final dynamic stackTrace;
  final Map<String, dynamic>? details;
  
  const AppException({
    required this.message,
    this.code,
    this.stackTrace,
    this.details,
  });
  
  @override
  List<Object?> get props => [message, code, stackTrace, details];
  
  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// 网络异常
class NetworkException extends AppException {
  final int? statusCode;
  final String? url;
  
  const NetworkException({
    required String message,
    this.statusCode,
    this.url,
    String? code,
    dynamic stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code ?? 'NETWORK_ERROR',
          stackTrace: stackTrace,
          details: {
            'statusCode': statusCode,
            'url': url,
            ...?details,
          },
        );
}

/// 认证异常
class AuthenticationException extends AppException {
  const AuthenticationException({
    required String message,
    String? code,
    dynamic stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code ?? 'AUTH_ERROR',
          stackTrace: stackTrace,
          details: details,
        );
}

/// 授权异常
class AuthorizationException extends AppException {
  final String? requiredPermission;
  
  const AuthorizationException({
    required String message,
    this.requiredPermission,
    String? code,
    dynamic stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code ?? 'AUTHORIZATION_ERROR',
          stackTrace: stackTrace,
          details: {
            'requiredPermission': requiredPermission,
            ...?details,
          },
        );
}

/// 验证异常
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;
  
  const ValidationException({
    required String message,
    this.fieldErrors,
    String? code,
    dynamic stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code ?? 'VALIDATION_ERROR',
          stackTrace: stackTrace,
          details: {
            'fieldErrors': fieldErrors,
            ...?details,
          },
        );
}

/// 缓存异常
class CacheException extends AppException {
  final String? cacheKey;
  
  const CacheException({
    required String message,
    this.cacheKey,
    String? code,
    dynamic stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code ?? 'CACHE_ERROR',
          stackTrace: stackTrace,
          details: {
            'cacheKey': cacheKey,
            ...?details,
          },
        );
}

/// 配置异常
class ConfigurationException extends AppException {
  final String? configKey;
  
  const ConfigurationException({
    required String message,
    this.configKey,
    String? code,
    dynamic stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code ?? 'CONFIG_ERROR',
          stackTrace: stackTrace,
          details: {
            'configKey': configKey,
            ...?details,
          },
        );
}

/// 业务逻辑异常
class BusinessException extends AppException {
  final String? operation;
  
  const BusinessException({
    required String message,
    this.operation,
    String? code,
    dynamic stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code ?? 'BUSINESS_ERROR',
          stackTrace: stackTrace,
          details: {
            'operation': operation,
            ...?details,
          },
        );
}

/// 未知异常
class UnknownException extends AppException {
  final Exception? originalException;
  
  const UnknownException({
    required String message,
    this.originalException,
    String? code,
    dynamic stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code ?? 'UNKNOWN_ERROR',
          stackTrace: stackTrace,
          details: {
            'originalException': originalException?.toString(),
            ...?details,
          },
        );
}