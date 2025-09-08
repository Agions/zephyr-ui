/// Component interface for all chromaUI components
abstract class chromaComponentInterface {
  /// Get component name
  String get componentName;

  /// Get component metadata
  Map<String, dynamic> getComponentMetadata();

  /// Validate component configuration
  bool validateConfiguration();

  /// Get component dependencies
  List<String> getDependencies();

  /// Get component events
  List<String> getSupportedEvents();

  /// Handle component event
  void handleEvent(String event, dynamic data);

  /// Check if component is ready
  bool get isReady;

  /// Get component state
  Map<String, dynamic> getState();

  /// Set component state
  void setState(Map<String, dynamic> state);
}

/// Component lifecycle interface
abstract class chromaLifecycleInterface {
  /// Called when component is initialized
  void onInit();

  /// Called when component is disposed
  void onDispose();

  /// Called when component is updated
  void onUpdate();

  /// Called when component is paused
  void onPause();

  /// Called when component is resumed
  void onResume();
}

/// Service locator interface for components
abstract class chromaServiceLocatorInterface {
  /// Get service by type
  T getService<T>();

  /// Register service
  void registerService<T>(T service, {String? name});

  /// Unregister service
  void unregisterService<T>({String? name});

  /// Check if service is registered
  bool isRegistered<T>({String? name});

  /// Get all services
  Map<Type, dynamic> getAllServices();

  /// Clear all services
  void clearServices();
}

/// Component factory interface
abstract class chromaComponentFactoryInterface {
  /// Create component by type
  Widget createComponent(String componentType, Map<String, dynamic> config);

  /// Register component type
  void registerComponentType(String componentType, Widget Function(Map<String, dynamic>) builder);

  /// Get registered component types
  List<String> getRegisteredComponentTypes();

  /// Check if component type is registered
  bool isComponentTypeRegistered(String componentType);

  /// Create component with configuration
  Widget createComponentWithConfig(String componentType, chromaComponentConfig config);
}

/// Theme interface for components
abstract class chromaThemeInterface {
  /// Get theme data
  ThemeData getThemeData();

  /// Get theme extension
  T getThemeExtension<T>();

  /// Check if theme extension is available
  bool hasThemeExtension<T>();

  /// Get color scheme
  ColorScheme getColorScheme();

  /// Get text theme
  TextTheme getTextTheme();

  /// Get component theme
  Map<String, dynamic> getComponentTheme(String componentName);
}

/// Analytics interface for components
abstract class chromaAnalyticsInterface {
  /// Track component event
  void trackEvent(String eventName, {Map<String, dynamic>? parameters});

  /// Track component error
  void trackError(String error, {StackTrace? stackTrace, Map<String, dynamic>? parameters});

  /// Track component performance
  void trackPerformance(String metricName, Duration duration, {Map<String, dynamic>? parameters});

  /// Track component usage
  void trackUsage(String componentName, {Map<String, dynamic>? parameters});

  /// Set user properties
  void setUserProperties(Map<String, dynamic> properties);

  /// Set component properties
  void setComponentProperties(String componentName, Map<String, dynamic> properties);
}

/// Performance monitoring interface
abstract class chromaPerformanceInterface {
  /// Start performance measurement
  void startMeasurement(String metricName);

  /// Stop performance measurement
  Duration stopMeasurement(String metricName);

  /// Track memory usage
  void trackMemoryUsage();

  /// Track frame rate
  void trackFrameRate();

  /// Get performance metrics
  Map<String, dynamic> getPerformanceMetrics();

  /// Clear performance metrics
  void clearMetrics();

  /// Set performance threshold
  void setPerformanceThreshold(String metricName, Duration threshold);

  /// Check if performance threshold is exceeded
  bool isPerformanceThresholdExceeded(String metricName);
}

/// Error handling interface
abstract class chromaErrorHandlingInterface {
  /// Handle error
  void handleError(Object error, StackTrace stackTrace, {String? componentId});

  /// Report error
  void reportError(Object error, StackTrace stackTrace, {String? componentId});

  /// Get error logs
  List<Map<String, dynamic>> getErrorLogs();

  /// Clear error logs
  void clearErrorLogs();

  /// Set error handler
  void setErrorHandler(Function(Object, StackTrace) handler);

  /// Enable/disable error reporting
  void setErrorReportingEnabled(bool enabled);
}

/// Configuration interface
abstract class chromaConfigurationInterface {
  /// Get configuration value
  T? getConfigValue<T>(String key);

  /// Set configuration value
  void setConfigValue<T>(String key, T value);

  /// Get all configuration
  Map<String, dynamic> getAllConfig();

  /// Load configuration from file
  Future<void> loadConfiguration(String filePath);

  /// Save configuration to file
  Future<void> saveConfiguration(String filePath);

  /// Validate configuration
  bool validateConfiguration();

  /// Get configuration schema
  Map<String, dynamic> getConfigurationSchema();
}

/// State management interface
abstract class chromaStateManagerInterface {
  /// Get state value
  T? getStateValue<T>(String key);

  /// Set state value
  void setStateValue<T>(String key, T value);

  /// Get all state
  Map<String, dynamic> getAllState();

  /// Clear state
  void clearState();

  /// Subscribe to state changes
  void subscribeToStateChanges(Function(Map<String, dynamic>) callback);

  /// Unsubscribe from state changes
  void unsubscribeFromStateChanges(Function(Map<String, dynamic>) callback);

  /// Get state history
  List<Map<String, dynamic>> getStateHistory();

  /// Clear state history
  void clearStateHistory();
}

/// Event system interface
abstract class chromaEventSystemInterface {
  /// Emit event
  void emitEvent(String eventName, {dynamic data});

  /// Listen to event
  void listenToEvent(String eventName, Function(dynamic) callback);

  /// Stop listening to event
  void stopListeningToEvent(String eventName, Function(dynamic) callback);

  /// Get all event listeners
  Map<String, List<Function(dynamic)>> getEventListeners();

  /// Clear all event listeners
  void clearEventListeners();

  /// Get event history
  List<Map<String, dynamic>> getEventHistory();

  /// Clear event history
  void clearEventHistory();
}

/// Component registry interface
abstract class chromaComponentRegistryInterface {
  /// Register component
  void registerComponent(String componentType, Widget Function(Map<String, dynamic>) builder);

  /// Unregister component
  void unregisterComponent(String componentType);

  /// Get component builder
  Widget Function(Map<String, dynamic>)? getComponentBuilder(String componentType);

  /// Get all registered components
  List<String> getRegisteredComponents();

  /// Check if component is registered
  bool isComponentRegistered(String componentType);

  /// Get component metadata
  Map<String, dynamic>? getComponentMetadata(String componentType);
}
