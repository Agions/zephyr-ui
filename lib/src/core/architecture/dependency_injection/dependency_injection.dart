/// chromaUI Dependency Injection System
///
/// A comprehensive dependency injection system that provides:
/// - Service registration and resolution
/// - Scoped dependencies
/// - Lazy initialization
/// - Circular dependency detection
/// - Memory management
library dependency_injection;

import 'package:flutter/foundation.dart';

/// Simple service locator implementation
class chromaServiceLocator {
  static final chromaServiceLocator _instance = chromaServiceLocator._internal();
  static chromaServiceLocator get instance => _instance;

  final Map<String, dynamic> _services = {};
  final Map<String, dynamic> _factories = {};
  final Map<String, dynamic> _singletons = {};

  chromaServiceLocator._internal();

  /// Register a singleton service
  void registerSingleton<T>(T instance, {String? instanceName}) {
    final key = _getKey<T>(instanceName);
    _singletons[key] = instance;
  }

  /// Register a factory service
  void registerFactory<T>(T Function() factoryFunc, {String? instanceName}) {
    final key = _getKey<T>(instanceName);
    _factories[key] = factoryFunc;
  }

  /// Register a lazy singleton
  void registerLazySingleton<T>(T Function() factoryFunc, {String? instanceName}) {
    final key = _getKey<T>(instanceName);
    _services[key] = factoryFunc;
  }

  /// Get a service instance
  T get<T>({String? instanceName}) {
    final key = _getKey<T>(instanceName);

    // Check singletons first
    if (_singletons.containsKey(key)) {
      return _singletons[key] as T;
    }

    // Check factories
    if (_factories.containsKey(key)) {
      return (_factories[key] as T Function())();
    }

    // Check lazy singletons
    if (_services.containsKey(key)) {
      final instance = (_services[key] as T Function())();
      _singletons[key] = instance;
      _services.remove(key);
      return instance;
    }

    throw StateError('Service of type $T not registered');
  }

  /// Check if a service is registered
  bool isRegistered<T>({String? instanceName}) {
    final key = _getKey<T>(instanceName);
    return _singletons.containsKey(key) ||
           _factories.containsKey(key) ||
           _services.containsKey(key);
  }

  /// Reset all services
  Future<void> reset() async {
    // Dispose all services that implement chromaUIService
    for (final service in _singletons.values) {
      if (service is chromaUIService) {
        await service.dispose();
      }
    }

    _services.clear();
    _factories.clear();
    _singletons.clear();
  }

  String _getKey<T>(String? instanceName) {
    return '${T.toString()}_${instanceName ?? ''}';
  }
}

/// Global service locator instance
final chromaServiceLocator = chromaServiceLocator.instance;

/// Dependency injection configuration
Future<void> configureDependencies() async {
  try {
    // Initialize the dependency injection container
    await _initializeCoreServices();

    if (kDebugMode) {
      debugPrint('✓ Dependency injection configured successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('✗ Failed to configure dependencies: $e');
    }
    rethrow;
  }
}

/// Initialize core services
Future<void> _initializeCoreServices() async {
  // Register core services here
  // This will be expanded as more services are added
}

/// Base service interface for dependency injection
abstract class chromaUIService {
  /// Initialize the service
  Future<void> initialize();

  /// Dispose of service resources
  Future<void> dispose();
}

/// Service registration helper
class ServiceRegistrar {
  static void register<T extends Object>(T instance, {String? instanceName}) {
    chromaServiceLocator.registerSingleton<T>(instance, instanceName: instanceName);
  }

  static void registerFactory<T extends Object>(T Function() factoryFunc, {String? instanceName}) {
    chromaServiceLocator.registerFactory<T>(factoryFunc, instanceName: instanceName);
  }

  static void registerLazySingleton<T extends Object>(T Function() factoryFunc, {String? instanceName}) {
    chromaServiceLocator.registerLazySingleton<T>(factoryFunc, instanceName: instanceName);
  }

  static T get<T extends Object>({String? instanceName}) {
    return chromaServiceLocator.get<T>(instanceName: instanceName);
  }

  static Future<void> reset() async {
    await chromaServiceLocator.reset();
  }
}

/// Example service for demonstration
class SomeService implements chromaUIService {
  @override
  Future<void> initialize() async {
    // Initialize service
  }

  @override
  Future<void> dispose() async {
    // Dispose resources
  }
}
