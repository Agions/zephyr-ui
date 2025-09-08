import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../config_manager/app_config.dart';
import '../service_locator/chroma_service_locator.dart';

/// 依赖注入模块配置
@module
abstract class InjectionModule {

  /// 应用配置
  @preResolve
  Future<AppConfig> get appConfig async {
    const environment = String.fromEnvironment('APP_ENV', defaultValue: 'production');
    return AppConfig.fromYaml('config/$environment.yaml');
  }

  /// 日志服务
  @lazySingleton
  Logger get logger => Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  /// HTTP客户端
  @lazySingleton
  Dio dio(AppConfig config) {
    final dio = Dio(BaseOptions(
      baseUrl: config.api.baseUrl,
      connectTimeout: Duration(milliseconds: config.api.connectTimeout),
      receiveTimeout: Duration(milliseconds: config.api.timeout),
      headers: config.api.headers,
    ));

    // 添加拦截器
    if (config.api.enableLogging) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
    }

    return dio;
  }

  /// 服务定位器
  @lazySingleton
  chromaServiceLocator get serviceLocator => chromaServiceLocator.instance;

  /// 应用信息
  @lazySingleton
  Future<Map<String, dynamic>> get appInfo async {
    final config = await appConfig;
    return {
      'appName': config.appName,
      'version': config.version,
      'environment': config.environment,
    };
  }
}
