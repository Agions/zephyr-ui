/// ZephyrUI DDD Architecture Configuration
///
/// Central configuration for setting up the DDD architecture layers,
/// dependency injection, and event system.

library ddd_config;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/core/dependency_injection.dart';
import 'package:zephyr_ui/src/core/event_bus.dart';
import 'package:zephyr_ui/src/infrastructure/index.dart';

/// DDD Architecture Configuration
class ZephyrDDDConfig {
  factory ZephyrDDDConfig() => _instance ??= ZephyrDDDConfig._internal();

  ZephyrDDDConfig._internal();
  static ZephyrDDDConfig? _instance;

  bool _isInitialized = false;

  /// Initialize the DDD architecture
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize service locator
    await _setupDependencyInjection();

    // Initialize event system
    _setupEventSystem();

    // Initialize infrastructure
    await _setupInfrastructure();

    _isInitialized = true;
  }

  /// Setup dependency injection
  Future<void> _setupDependencyInjection() async {
    final serviceLocator = ZephyrServiceLocator();

    // Register core services
    serviceLocator.registerSingleton(ZephyrEventBus());

    // Register infrastructure services
    serviceLocator.registerFactory(() => LocalStorageService());
    serviceLocator.registerFactory(() => SharedPreferencesService());
    serviceLocator.registerFactory(() => ThemeStorageService());

    // Register repositories
    serviceLocator.registerFactory(() => UIComponentRepositoryImpl());
    serviceLocator
        .registerFactory(() => ThemeRepositoryImpl(SharedPreferencesService()));
    serviceLocator.registerFactory(
        () => UserPreferencesRepositoryImpl(SharedPreferencesService()));

    // Register domain services
    serviceLocator.registerFactory(() => UIComponentService());
    serviceLocator.registerFactory(() => ThemeService());

    // Register application services
    serviceLocator.registerFactory(() => UIApplicationService());
    serviceLocator.registerFactory(() => ThemeApplicationService());
  }

  /// Setup event system
  void _setupEventSystem() {
    final eventBus = ZephyrEventBus();

    // Register global event handlers
    eventBus.subscribe<ZephyrThemeChangedEvent>((event) async {
      // Handle theme changes globally
      if (kDebugMode) {
        debugPrint('🎨 Theme changed to: ${event.themeMode}');
      }
    });

    eventBus.subscribe<ZephyrComponentLifecycleEvent>((event) async {
      // Handle component lifecycle events
      if (kDebugMode) {
        debugPrint(
            '🔄 Component ${event.componentType} ${event.lifecyclePhase}');
      }
    });
  }

  /// Setup infrastructure
  Future<void> _setupInfrastructure() async {
    // Initialize storage services
    final localStorage = ZephyrServiceLocator().get<LocalStorageService>();
    final sharedPreferences =
        ZephyrServiceLocator().get<SharedPreferencesService>();

    await localStorage.initialize();
    await sharedPreferences.initialize();
  }

  /// Get the DDD architecture widget
  Widget wrapWithArchitecture(Widget child) {
    return ZephyrServiceProvider(
      registerServices: (serviceLocator) async {
        await initialize();
      },
      child: child,
    );
  }

  /// Check if the DDD architecture is initialized
  bool get isInitialized => _isInitialized;
}

/// Extension for easy access to DDD services
extension ZephyrDDDExtensions on BuildContext {
  T getDomainService<T>() {
    return ZephyrServiceLocator().get<T>();
  }

  T getApplicationService<T>() {
    return ZephyrServiceLocator().get<T>();
  }

  void publishDomainEvent<T extends ZephyrDomainEvent>(T event) {
    ZephyrEventBus().publish(event);
  }

  void subscribeToDomainEvent<T extends ZephyrDomainEvent>(
    ZephyrEventHandler<T> handler,
  ) {
    ZephyrEventBus().subscribe(handler);
  }
}
