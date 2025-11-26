/// ZephyrUI DDD Architecture - Dependency Injection Container
///
/// Provides a centralized dependency injection system for managing
/// dependencies across all layers of the DDD architecture.

library dependency_injection;

import 'package:flutter/material.dart';

/// Service locator for managing dependencies
class ZephyrServiceLocator {
  factory ZephyrServiceLocator() => _instance;

  ZephyrServiceLocator._internal();
  static final ZephyrServiceLocator _instance =
      ZephyrServiceLocator._internal();

  final Map<Type, dynamic> _services = {};
  final Map<Type, Function> _factories = {};

  /// Register a singleton service
  void registerSingleton<T>(T service) {
    _services[T] = service;
  }

  /// Register a factory for creating services
  void registerFactory<T>(Function factory) {
    _factories[T] = factory;
  }

  /// Get a registered service
  T get<T>() {
    if (_services.containsKey(T)) {
      return _services[T] as T;
    }

    if (_factories.containsKey(T)) {
      final factory = _factories[T];
      if (factory != null) {
        final service = factory() as T;
        _services[T] = service;
        return service;
      }
    }

    throw StateError('Service of type $T is not registered');
  }

  /// Check if a service is registered
  bool isRegistered<T>() {
    return _services.containsKey(T) || _factories.containsKey(T);
  }

  /// Clear all registered services
  void clear() {
    _services.clear();
    _factories.clear();
  }
}

/// Extension for easy access to service locator
extension ZephyrServiceLocatorExtension on BuildContext {
  T getZephyrService<T>() {
    return ZephyrServiceLocator().get<T>();
  }
}

/// Widget for providing services to the widget tree
class ZephyrServiceProvider extends StatefulWidget {
  const ZephyrServiceProvider({
    required this.child,
    required this.registerServices,
    super.key,
  });
  final Widget child;
  final Function(ZephyrServiceLocator) registerServices;

  @override
  State<ZephyrServiceProvider> createState() => _ZephyrServiceProviderState();
}

class _ZephyrServiceProviderState extends State<ZephyrServiceProvider> {
  @override
  void initState() {
    super.initState();
    widget.registerServices(ZephyrServiceLocator());
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
