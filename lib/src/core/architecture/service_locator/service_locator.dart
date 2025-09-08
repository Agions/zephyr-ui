/// chromaUI Service Locator
///
/// Advanced service locator with enhanced capabilities:
/// - Hierarchical service resolution
/// - Service lifecycle management
/// - Dependency graph validation
/// - Performance monitoring
/// - Service discovery
library service_locator;

import 'package:flutter/foundation.dart';
import '../dependency_injection/dependency_injection.dart';

/// Enhanced service locator for chromaUI
class chromaServiceLocator {
  static final chromaServiceLocator _instance = chromaServiceLocator._internal();
  static chromaServiceLocator get instance => _instance;

  final Map<String, ServiceMetadata> _serviceMetadata = {};
  final List<ServiceDependency> _dependencyGraph = [];

  chromaServiceLocator._internal();

  /// Register a service with metadata
  void registerWithMetadata<T extends Object>(
    T instance, {
    String? instanceName,
    ServiceLifetime lifetime = ServiceLifetime.singleton,
    String? description,
    List<Type> dependencies = const [],
  }) {
    final key = _getKey<T>(instanceName);

    // Register the service
    switch (lifetime) {
      case ServiceLifetime.singleton:
        ServiceRegistrar.register<T>(instance, instanceName: instanceName);
        break;
      case ServiceLifetime.transient:
        ServiceRegistrar.registerFactory<T>(() => instance, instanceName: instanceName);
        break;
      case ServiceLifetime.scoped:
        ServiceRegistrar.registerLazySingleton<T>(() => instance, instanceName: instanceName);
        break;
    }

    // Store metadata
    _serviceMetadata[key] = ServiceMetadata(
      type: T,
      instanceName: instanceName,
      lifetime: lifetime,
      description: description,
      dependencies: dependencies,
      registrationTime: DateTime.now(),
    );

    // Record dependencies
    for (final dependency in dependencies) {
      _dependencyGraph.add(ServiceDependency(
        from: T,
        to: dependency,
        dependencyType: DependencyType.required,
      ));
    }

    if (kDebugMode) {
      debugPrint('Registered service: $T with lifetime: $lifetime');
    }
  }

  /// Get service metadata
  ServiceMetadata? getMetadata<T>({String? instanceName}) {
    final key = _getKey<T>(instanceName);
    return _serviceMetadata[key];
  }

  /// Get all registered services
  List<ServiceMetadata> getAllServices() {
    return _serviceMetadata.values.toList();
  }

  /// Validate dependency graph
  List<ServiceDependency> validateDependencies() {
    final issues = <ServiceDependency>[];

    for (final dependency in _dependencyGraph) {
      final dependencyKey = _getKeyFromType(dependency.to);
      if (!_serviceMetadata.containsKey(dependencyKey)) {
        issues.add(dependency);
      }
    }

    return issues;
  }

  /// Check for circular dependencies
  List<List<Type>> detectCircularDependencies() {
    final cycles = <List<Type>>[];
    final visited = <Type>{};
    final recursionStack = <Type>{};

    for (final service in _serviceMetadata.values) {
      if (!visited.contains(service.type)) {
        _detectCyclesDFS(service.type, visited, recursionStack, cycles);
      }
    }

    return cycles;
  }

  void _detectCyclesDFS(
    Type type,
    Set<Type> visited,
    Set<Type> recursionStack,
    List<List<Type>> cycles,
    [List<Type>? currentPath]
  ) {
    currentPath ??= <Type>[];

    visited.add(type);
    recursionStack.add(type);
    currentPath.add(type);

    final dependencies = _serviceMetadata.values
        .where((s) => s.dependencies.contains(type))
        .map((s) => s.type);

    for (final dependency in dependencies) {
      if (!visited.contains(dependency)) {
        _detectCyclesDFS(dependency, visited, recursionStack, cycles, currentPath);
      } else if (recursionStack.contains(dependency)) {
        final cycleStart = currentPath.indexOf(dependency);
        final cycle = currentPath.sublist(cycleStart);
        cycles.add(cycle);
      }
    }

    recursionStack.remove(type);
    currentPath.removeLast();
  }

  /// Dispose all services
  Future<void> disposeAll() async {
    for (final metadata in _serviceMetadata.values) {
      try {
        final instance = ServiceRegistrar.get<Object>(
          instanceName: metadata.instanceName,
        );

        if (instance is chromaUIService) {
          await instance.dispose();
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error disposing service ${metadata.type}: $e');
        }
      }
    }

    await ServiceRegistrar.reset();
    _serviceMetadata.clear();
    _dependencyGraph.clear();
  }

  String _getKey<T>(String? instanceName) {
    return '${T.toString()}_${instanceName ?? ''}';
  }

  String _getKeyFromType(Type type) {
    return '${type.toString()}_';
  }
}

/// Service metadata
class ServiceMetadata {
  final Type type;
  final String? instanceName;
  final ServiceLifetime lifetime;
  final String? description;
  final List<Type> dependencies;
  final DateTime registrationTime;

  ServiceMetadata({
    required this.type,
    required this.lifetime,
    required this.dependencies,
    required this.registrationTime,
    this.instanceName,
    this.description,
  });

  @override
  String toString() {
    return 'ServiceMetadata(type: $type, lifetime: $lifetime, dependencies: $dependencies)';
  }
}

/// Service lifetime options
enum ServiceLifetime {
  singleton,
  transient,
  scoped,
}

/// Dependency type
enum DependencyType {
  required,
  optional,
}

/// Service dependency relationship
class ServiceDependency {
  final Type from;
  final Type to;
  final DependencyType dependencyType;

  ServiceDependency({
    required this.from,
    required this.to,
    required this.dependencyType,
  });

  @override
  String toString() {
    return '$from -> $to (${dependencyType.name})';
  }
}
