import 'dart:async';
import '../interfaces/component_interfaces.dart';

/// Lifecycle mixin for components
mixin chromaLifecycleMixin implements chromaLifecycleInterface {
  bool _isInitialized = false;
  bool _isDisposed = false;
  bool _isPaused = false;

  @override
  void onInit() {
    if (_isInitialized) return;
    _isInitialized = true;
    _isDisposed = false;
    _isPaused = false;
  }

  @override
  void onDispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    _isInitialized = false;
    _isPaused = false;
  }

  @override
  void onUpdate() {
    if (!_isInitialized || _isDisposed) return;
    // Handle updates
  }

  @override
  void onPause() {
    if (_isPaused) return;
    _isPaused = true;
  }

  @override
  void onResume() {
    if (!_isPaused) return;
    _isPaused = false;
  }

  /// Check if component is initialized
  bool get isInitialized => _isInitialized;

  /// Check if component is disposed
  bool get isDisposed => _isDisposed;

  /// Check if component is paused
  bool get isPaused => _isPaused;

  /// Check if component is active
  bool get isActive => _isInitialized && !_isDisposed && !_isPaused;
}

/// Service locator mixin for components
mixin chromaServiceLocatorMixin implements chromaServiceLocatorInterface {
  final Map<Type, dynamic> _services = {};
  final Map<String, dynamic> _namedServices = {};

  @override
  T getService<T>() {
    final service = _services[T];
    if (service == null) {
      throw StateError('Service of type $T is not registered');
    }
    return service as T;
  }

  @override
  void registerService<T>(T service, {String? name}) {
    if (name != null) {
      _namedServices[name] = service;
    } else {
      _services[T] = service;
    }
  }

  @override
  void unregisterService<T>({String? name}) {
    if (name != null) {
      _namedServices.remove(name);
    } else {
      _services.remove(T);
    }
  }

  @override
  bool isRegistered<T>({String? name}) {
    if (name != null) {
      return _namedServices.containsKey(name);
    }
    return _services.containsKey(T);
  }

  @override
  Map<Type, dynamic> getAllServices() {
    return Map.from(_services);
  }

  @override
  void clearServices() {
    _services.clear();
    _namedServices.clear();
  }

  /// Get service by name
  T? getServiceByName<T>(String name) {
    final service = _namedServices[name];
    return service is T ? service : null;
  }

  /// Get all named services
  Map<String, dynamic> getNamedServices() {
    return Map.from(_namedServices);
  }
}

/// Theme mixin for components
mixin chromaThemeMixin implements chromaThemeInterface {
  ThemeData? _themeData;
  final Map<Type, dynamic> _themeExtensions = {};

  @override
  ThemeData getThemeData() {
    return _themeData ?? ThemeData.light();
  }

  @override
  T getThemeExtension<T>() {
    final extension = _themeExtensions[T];
    if (extension == null) {
      throw StateError('Theme extension of type $T is not available');
    }
    return extension as T;
  }

  @override
  bool hasThemeExtension<T>() {
    return _themeExtensions.containsKey(T);
  }

  @override
  ColorScheme getColorScheme() {
    return getThemeData().colorScheme;
  }

  @override
  TextTheme getTextTheme() {
    return getThemeData().textTheme;
  }

  @override
  Map<String, dynamic> getComponentTheme(String componentName) {
    // Return component-specific theme configuration
    return {};
  }

  /// Set theme data
  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
  }

  /// Add theme extension
  void addThemeExtension<T>(T extension) {
    _themeExtensions[T] = extension;
  }

  /// Remove theme extension
  void removeThemeExtension<T>() {
    _themeExtensions.remove(T);
  }
}

/// Analytics mixin for components
mixin chromaAnalyticsMixin implements chromaAnalyticsInterface {
  final List<Map<String, dynamic>> _eventLog = [];
  final List<Map<String, dynamic>> _errorLog = [];
  final List<Map<String, dynamic>> _performanceLog = [];

  @override
  void trackEvent(String eventName, {Map<String, dynamic>? parameters}) {
    final event = {
      'eventName': eventName,
      'timestamp': DateTime.now().toIso8601String(),
      'parameters': parameters ?? {},
    };
    _eventLog.add(event);
    print('[Analytics] Event: $eventName');
  }

  @override
  void trackError(String error, {StackTrace? stackTrace, Map<String, dynamic>? parameters}) {
    final errorEvent = {
      'error': error,
      'stackTrace': stackTrace?.toString(),
      'timestamp': DateTime.now().toIso8601String(),
      'parameters': parameters ?? {},
    };
    _errorLog.add(errorEvent);
    print('[Analytics] Error: $error');
  }

  @override
  void trackPerformance(String metricName, Duration duration, {Map<String, dynamic>? parameters}) {
    final performanceEvent = {
      'metricName': metricName,
      'duration': duration.inMilliseconds,
      'timestamp': DateTime.now().toIso8601String(),
      'parameters': parameters ?? {},
    };
    _performanceLog.add(performanceEvent);
    print('[Analytics] Performance: $metricName - ${duration.inMilliseconds}ms');
  }

  @override
  void trackUsage(String componentName, {Map<String, dynamic>? parameters}) {
    trackEvent('component_usage', parameters: {
      'componentName': componentName,
      ...?parameters,
    });
  }

  @override
  void setUserProperties(Map<String, dynamic> properties) {
    print('[Analytics] User properties updated: $properties');
  }

  @override
  void setComponentProperties(String componentName, Map<String, dynamic> properties) {
    print('[Analytics] Component properties updated for $componentName: $properties');
  }

  /// Get event log
  List<Map<String, dynamic>> getEventLog() => List.from(_eventLog);

  /// Get error log
  List<Map<String, dynamic>> getErrorLog() => List.from(_errorLog);

  /// Get performance log
  List<Map<String, dynamic>> getPerformanceLog() => List.from(_performanceLog);

  /// Clear all logs
  void clearLogs() {
    _eventLog.clear();
    _errorLog.clear();
    _performanceLog.clear();
  }
}

/// Performance monitoring mixin
mixin chromaPerformanceMixin implements chromaPerformanceInterface {
  final Map<String, Stopwatch> _measurements = {};
  final Map<String, Duration> _metrics = {};
  final Map<String, Duration> _thresholds = {};

  @override
  void startMeasurement(String metricName) {
    _measurements[metricName] = Stopwatch()..start();
  }

  @override
  Duration stopMeasurement(String metricName) {
    final stopwatch = _measurements[metricName];
    if (stopwatch == null) {
      throw StateError('No measurement started for metric: $metricName');
    }

    stopwatch.stop();
    final duration = stopwatch.elapsed;
    _metrics[metricName] = duration;
    _measurements.remove(metricName);

    return duration;
  }

  @override
  void trackMemoryUsage() {
    // Simulate memory tracking
    final memoryUsage = (DateTime.now().millisecondsSinceEpoch % 100) + 50; // Mock data
    _metrics['memory_usage'] = Duration(milliseconds: memoryUsage);
    print('[Performance] Memory usage: ${memoryUsage}MB');
  }

  @override
  void trackFrameRate() {
    // Simulate frame rate tracking
    final frameRate = 60 - (DateTime.now().millisecondsSinceEpoch % 10); // Mock data
    _metrics['frame_rate'] = Duration(milliseconds: (1000 ~/ frameRate));
    print('[Performance] Frame rate: ${frameRate}FPS');
  }

  @override
  Map<String, dynamic> getPerformanceMetrics() {
    return Map.from(_metrics);
  }

  @override
  void clearMetrics() {
    _metrics.clear();
    _measurements.clear();
  }

  @override
  void setPerformanceThreshold(String metricName, Duration threshold) {
    _thresholds[metricName] = threshold;
  }

  @override
  bool isPerformanceThresholdExceeded(String metricName) {
    final threshold = _thresholds[metricName];
    final metric = _metrics[metricName];

    if (threshold == null || metric == null) {
      return false;
    }

    return metric > threshold;
  }

  /// Get all thresholds
  Map<String, Duration> getThresholds() => Map.from(_thresholds);
}

/// Error handling mixin
mixin chromaErrorHandlingMixin implements chromaErrorHandlingInterface {
  final List<Map<String, dynamic>> _errorLogs = [];
  Function(Object, StackTrace)? _errorHandler;
  bool _errorReportingEnabled = true;

  @override
  void handleError(Object error, StackTrace stackTrace, {String? componentId}) {
    print('[Error] Component: $componentId, Error: $error');

    if (_errorHandler != null) {
      _errorHandler!(error, stackTrace);
    }

    if (_errorReportingEnabled) {
      reportError(error, stackTrace, componentId: componentId);
    }
  }

  @override
  void reportError(Object error, StackTrace stackTrace, {String? componentId}) {
    final errorLog = {
      'error': error.toString(),
      'stackTrace': stackTrace.toString(),
      'componentId': componentId,
      'timestamp': DateTime.now().toIso8601String(),
    };
    _errorLogs.add(errorLog);

    // In a real implementation, this would send to error tracking service
    print('[Error Reporting] Error reported for component: $componentId');
  }

  @override
  List<Map<String, dynamic>> getErrorLogs() => List.from(_errorLogs);

  @override
  void clearErrorLogs() {
    _errorLogs.clear();
  }

  @override
  void setErrorHandler(Function(Object, StackTrace) handler) {
    _errorHandler = handler;
  }

  @override
  void setErrorReportingEnabled(bool enabled) {
    _errorReportingEnabled = enabled;
  }

  /// Get error reporting status
  bool get isErrorReportingEnabled => _errorReportingEnabled;
}

/// Event system mixin
mixin chromaEventSystemMixin implements chromaEventSystemInterface {
  final Map<String, List<Function(dynamic)>> _eventListeners = {};
  final List<Map<String, dynamic>> _eventHistory = [];

  @override
  void emitEvent(String eventName, {dynamic data}) {
    final event = {
      'eventName': eventName,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    };
    _eventHistory.add(event);

    final listeners = _eventListeners[eventName] ?? [];
    for (final listener in listeners) {
      try {
        listener(data);
      } catch (e, stackTrace) {
        print('[Event System] Error in event listener for $eventName: $e');
      }
    }
  }

  @override
  void listenToEvent(String eventName, Function(dynamic) callback) {
    _eventListeners.putIfAbsent(eventName, () => []).add(callback);
  }

  @override
  void stopListeningToEvent(String eventName, Function(dynamic) callback) {
    final listeners = _eventListeners[eventName];
    if (listeners != null) {
      listeners.remove(callback);
      if (listeners.isEmpty) {
        _eventListeners.remove(eventName);
      }
    }
  }

  @override
  Map<String, List<Function(dynamic)>> getEventListeners() {
    return Map.from(_eventListeners);
  }

  @override
  void clearEventListeners() {
    _eventListeners.clear();
  }

  @override
  List<Map<String, dynamic>> getEventHistory() => List.from(_eventHistory);

  @override
  void clearEventHistory() {
    _eventHistory.clear();
  }
}

/// State management mixin
mixin chromaStateManagementMixin implements chromaStateManagerInterface {
  final Map<String, dynamic> _state = {};
  final List<Map<String, dynamic>> _stateHistory = [];
  final List<Function(Map<String, dynamic>)> _stateChangeListeners = [];

  @override
  T? getStateValue<T>(String key) {
    return _state[key] as T?;
  }

  @override
  void setStateValue<T>(String key, T value) {
    _state[key] = value;
    _notifyStateChangeListeners();
  }

  @override
  Map<String, dynamic> getAllState() {
    return Map.from(_state);
  }

  @override
  void clearState() {
    _state.clear();
    _notifyStateChangeListeners();
  }

  @override
  void subscribeToStateChanges(Function(Map<String, dynamic>) callback) {
    _stateChangeListeners.add(callback);
  }

  @override
  void unsubscribeFromStateChanges(Function(Map<String, dynamic>) callback) {
    _stateChangeListeners.remove(callback);
  }

  @override
  List<Map<String, dynamic>> getStateHistory() {
    return List.from(_stateHistory);
  }

  @override
  void clearStateHistory() {
    _stateHistory.clear();
  }

  /// Notify state change listeners
  void _notifyStateChangeListeners() {
    final currentState = Map.from(_state);
    _stateHistory.add({
      'state': currentState,
      'timestamp': DateTime.now().toIso8601String(),
    });

    for (final listener in _stateChangeListeners) {
      try {
        listener(currentState);
      } catch (e) {
        print('[State Management] Error in state change listener: $e');
      }
    }
  }
}
