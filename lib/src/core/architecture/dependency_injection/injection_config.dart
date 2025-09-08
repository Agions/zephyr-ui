import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// 依赖注入配置
@injectableInit
Future<void> configureInjection({String? environment}) async {
  final getIt = GetIt.instance;
  
  // 配置环境
  environment ??= 'production';
  
  // 初始化依赖注入
  await $initGetIt(getIt, environment: environment);
  
  // 注册全局单例
  _registerGlobalSingletons(getIt);
  
  // 注册懒加载服务
  _registerLazySingletons(getIt);
  
  // 注册工厂方法
  _registerFactories(getIt);
}

/// 注册全局单例
void _registerGlobalSingletons(GetIt getIt) {
  // 这里注册需要立即初始化的单例
}

/// 注册懒加载服务
void _registerLazySingletons(GetIt getIt) {
  // 这里注册懒加载的单例
}

/// 注册工厂方法
void _registerFactories(GetIt getIt) {
  // 这里注册工厂方法
}

/// 获取依赖注入容器
GetIt get getIt => GetIt.instance;

/// 重置依赖注入容器（主要用于测试）
void resetInjection() {
  getIt.reset();
}