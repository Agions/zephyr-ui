import 'package:get_it/get_it.dart';

/// chromaUI 服务定位器
/// 提供统一的服务访问接口
class chromaServiceLocator {
  static final chromaServiceLocator _instance = chromaServiceLocator._internal();

  /// 单例实例
  static chromaServiceLocator get instance => _instance;

  /// 依赖注入容器
  final GetIt _getIt = GetIt.instance;

  chromaServiceLocator._internal();

  /// 注册服务
  void register<T extends Object>(T instance, {String? instanceName}) {
    _getIt.registerSingleton<T>(instance, instanceName: instanceName);
  }

  /// 注册懒加载服务
  void registerLazy<T extends Object>(T Function() factory, {String? instanceName}) {
    _getIt.registerLazySingleton<T>(factory, instanceName: instanceName);
  }

  /// 注册工厂方法
  void registerFactory<T extends Object>(T Function() factory, {String? instanceName}) {
    _getIt.registerFactory<T>(factory, instanceName: instanceName);
  }

  /// 获取服务
  T get<T extends Object>({String? instanceName}) {
    return _getIt<T>(instanceName: instanceName);
  }

  /// 检查服务是否已注册
  bool isRegistered<T extends Object>({String? instanceName}) {
    return _getIt.isRegistered<T>(instanceName: instanceName);
  }

  /// 注销服务
  void unregister<T extends Object>({String? instanceName}) {
    _getIt.unregister<T>(instanceName: instanceName);
  }

  /// 重置所有服务
  void reset() {
    _getIt.reset();
  }

  /// 获取所有已注册的服务
  Map<String, dynamic> getRegisteredServices() {
    return _getIt.dump();
  }
}

/// 全局服务定位器实例
final chromaServiceLocator = chromaServiceLocator.instance;
