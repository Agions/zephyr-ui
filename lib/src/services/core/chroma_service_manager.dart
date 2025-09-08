import 'dart:async';
import '../interfaces/service_interfaces.dart';

/// Core service manager for managing all chromaUI services
class chromaServiceManager implements ServiceManagerInterface {
  static final chromaServiceManager _instance = chromaServiceManager._internal();

  /// Singleton instance
  static chromaServiceManager get instance => _instance;

  final Map<Type, dynamic> _services = {};
  final Map<Type, ServiceStatus> _serviceStatus = {};
  final List<ServiceListener> _listeners = [];
  bool _servicesEnabled = true;

  chromaServiceManager._internal();

  @override
  Future<void> initializeServices() async {
    if (!_servicesEnabled) return;

    print('[ServiceManager] Initializing services...');

    // Initialize core services in order
    await _initializeService<LoggingServiceInterface>();
    await _initializeService<AnalyticsServiceInterface>();
    await _initializeService<MonitoringServiceInterface>();
    await _initializeService<StorageServiceInterface>();

    print('[ServiceManager] All services initialized');
  }

  Future<void> _initializeService<T>() async {
    final serviceType = T;

    try {
      _updateServiceStatus(serviceType, ServiceStatus.initializing);

      // Create service instance based on type
      dynamic service;
      if (serviceType == LoggingServiceInterface) {
        service = chromaLoggingService();
      } else if (serviceType == AnalyticsServiceInterface) {
        service = chromaAnalyticsService();
      } else if (serviceType == MonitoringServiceInterface) {
        service = chromaMonitoringService();
      } else if (serviceType == StorageServiceInterface) {
        service = chromaStorageService();
      } else {
        throw ArgumentError('Unknown service type: $serviceType');
      }

      // Register service
      _services[serviceType] = service;

      // Initialize service
      await service.initialize();

      _updateServiceStatus(serviceType, ServiceStatus.initialized);
      print('[ServiceManager] Service $serviceType initialized successfully');

    } catch (error, stackTrace) {
      _updateServiceStatus(serviceType, ServiceStatus.error);
      _notifyServiceError(serviceType, error, stackTrace);
      print('[ServiceManager] Failed to initialize service $serviceType: $error');
      rethrow;
    }
  }

  @override
  void registerService<T>(T service) {
    _services[T] = service;
    _updateServiceStatus(T, ServiceStatus.initialized);
    print('[ServiceManager] Service $T registered');
  }

  @override
  void unregisterService<T>() {
    _services.remove(T);
    _serviceStatus.remove(T);
    print('[ServiceManager] Service $T unregistered');
  }

  @override
  T getService<T>() {
    final service = _services[T];
    if (service == null) {
      throw StateError('Service $T is not registered');
    }
    return service as T;
  }

  @override
  bool isServiceRegistered<T>() {
    return _services.containsKey(T);
  }

  @override
  Map<Type, dynamic> getAllServices() {
    return Map.from(_services);
  }

  @override
  Future<void> startAllServices() async {
    if (!_servicesEnabled) return;

    print('[ServiceManager] Starting all services...');

    for (final entry in _services.entries) {
      await _startService(entry.key, entry.value);
    }

    print('[ServiceManager] All services started');
  }

  Future<void> _startService<T>(Type serviceType, dynamic service) async {
    try {
      _updateServiceStatus(serviceType, ServiceStatus.starting);

      // Start service if it has start method
      if (service is MonitoringServiceInterface) {
        await service.startMonitoring();
      }

      _updateServiceStatus(serviceType, ServiceStatus.running);
      print('[ServiceManager] Service $serviceType started');

    } catch (error, stackTrace) {
      _updateServiceStatus(serviceType, ServiceStatus.error);
      _notifyServiceError(serviceType, error, stackTrace);
      print('[ServiceManager] Failed to start service $serviceType: $error');
    }
  }

  @override
  Future<void> stopAllServices() async {
    print('[ServiceManager] Stopping all services...');

    for (final entry in _services.entries) {
      await _stopService(entry.key, entry.value);
    }

    print('[ServiceManager] All services stopped');
  }

  Future<void> _stopService<T>(Type serviceType, dynamic service) async {
    try {
      _updateServiceStatus(serviceType, ServiceStatus.stopping);

      // Stop service if it has stop method
      if (service is MonitoringServiceInterface) {
        await service.stopMonitoring();
      }

      _updateServiceStatus(serviceType, ServiceStatus.stopped);
      print('[ServiceManager] Service $serviceType stopped');

    } catch (error, stackTrace) {
      _updateServiceStatus(serviceType, ServiceStatus.error);
      _notifyServiceError(serviceType, error, stackTrace);
      print('[ServiceManager] Failed to stop service $serviceType: $error');
    }
  }

  @override
  Future<void> restartAllServices() async {
    print('[ServiceManager] Restarting all services...');
    await stopAllServices();
    await startAllServices();
    print('[ServiceManager] All services restarted');
  }

  @override
  Map<Type, ServiceStatus> getServiceStatus() {
    return Map.from(_serviceStatus);
  }

  @override
  void addServiceListener(ServiceListener listener) {
    _listeners.add(listener);
  }

  @override
  void removeServiceListener(ServiceListener listener) {
    _listeners.remove(listener);
  }

  @override
  Future<void> setServicesEnabled(bool enabled) async {
    if (_servicesEnabled == enabled) return;

    _servicesEnabled = enabled;

    if (enabled) {
      await startAllServices();
    } else {
      await stopAllServices();
    }
  }

  @override
  bool get areServicesEnabled => _servicesEnabled;

  void _updateServiceStatus(Type serviceType, ServiceStatus status) {
    _serviceStatus[serviceType] = status;
    _notifyServiceStatusChanged(serviceType, status);
  }

  void _notifyServiceStatusChanged(Type serviceType, ServiceStatus status) {
    for (final listener in _listeners) {
      try {
        listener.onServiceStatusChanged(serviceType, status);
      } catch (error) {
        print('[ServiceManager] Error in service listener: $error');
      }
    }
  }

  void _notifyServiceError(Type serviceType, Object error, StackTrace stackTrace) {
    for (final listener in _listeners) {
      try {
        listener.onServiceError(serviceType, error, stackTrace);
      } catch (e) {
        print('[ServiceManager] Error in service listener: $e');
      }
    }
  }

  /// Get service by name (convenience method)
  T? getServiceByName<T>(String name) {
    for (final entry in _services.entries) {
      if (entry.key.toString().contains(name)) {
        return entry.value as T;
      }
    }
    return null;
  }

  /// Get service status summary
  Map<String, dynamic> getStatusSummary() {
    return {
      'servicesEnabled': _servicesEnabled,
      'totalServices': _services.length,
      'runningServices': _serviceStatus.values.where((s) => s == ServiceStatus.running).length,
      'errorServices': _serviceStatus.values.where((s) => s == ServiceStatus.error).length,
      'services': _serviceStatus.map((key, value) => MapEntry(key.toString(), value.name)),
    };
  }
}

/// Logging service implementation
class chromaLoggingService implements LoggingServiceInterface {
  final List<LogEntry> _logHistory = [];
  final List<LogListener> _listeners = [];
  LogLevel _logLevel = LogLevel.info;
  bool _loggingEnabled = true;

  @override
  Future<void> initialize() async {
    print('[LoggingService] Initializing...');
    _logHistory.clear();
    _loggingEnabled = true;
    print('[LoggingService] Initialized');
  }

  @override
  void debug(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.debug, message, parameters, tag, stackTrace);
  }

  @override
  void info(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.info, message, parameters, tag, stackTrace);
  }

  @override
  void warning(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.warning, message, parameters, tag, stackTrace);
  }

  @override
  void error(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.error, message, parameters, tag, stackTrace);
  }

  @override
  void fatal(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.fatal, message, parameters, tag, stackTrace);
  }

  @override
  void verbose(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.verbose, message, parameters, tag, stackTrace);
  }

  @override
  void wtf(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.wtf, message, parameters, tag, stackTrace);
  }

  void _log(LogLevel level, String message,
    Map<String, dynamic>? parameters, String? tag, StackTrace? stackTrace) {

    if (!_loggingEnabled || level.index < _logLevel.index) return;

    final entry = LogEntry(
      level: level,
      message: message,
      timestamp: DateTime.now(),
      parameters: parameters,
      tag: tag,
      stackTrace: stackTrace,
    );

    _logHistory.add(entry);

    // Print to console
    final logMessage = '[${level.name.toUpperCase()}] ${entry.timestamp.toIso8601String()} - $message';
    if (tag != null) {
      print('$logMessage [$tag]');
    } else {
      print(logMessage);
    }

    if (parameters != null) {
      print('  Parameters: $parameters');
    }

    if (stackTrace != null) {
      print('  StackTrace: $stackTrace');
    }

    // Notify listeners
    for (final listener in _listeners) {
      try {
        listener.onLogEntry(entry);
      } catch (error) {
        print('[LoggingService] Error in log listener: $error');
      }
    }
  }

  @override
  void setLogLevel(LogLevel level) {
    _logLevel = level;
    print('[LoggingService] Log level set to: ${level.name}');
  }

  @override
  LogLevel get logLevel => _logLevel;

  @override
  void addLogListener(LogListener listener) {
    _listeners.add(listener);
  }

  @override
  void removeLogListener(LogListener listener) {
    _listeners.remove(listener);
  }

  @override
  List<LogEntry> getLogHistory({int limit = 100}) {
    return _logHistory.take(limit).toList();
  }

  @override
  void clearLogHistory() {
    _logHistory.clear();
    print('[LoggingService] Log history cleared');
  }

  @override
  Future<String> exportLogsToFile(String filePath) async {
    final logData = _logHistory.map((entry) => entry.toJson()).toList();
    final jsonString = '[${logData.map((e) => e.toString()).join(',')}]';

    // In a real implementation, this would write to a file
    print('[LoggingService] Logs exported to: $filePath');
    return jsonString;
  }

  @override
  void setLoggingEnabled(bool enabled) {
    _loggingEnabled = enabled;
    print('[LoggingService] Logging ${enabled ? 'enabled' : 'disabled'}');
  }

  @override
  bool get isLoggingEnabled => _loggingEnabled;

  @override
  Map<String, dynamic> getConfiguration() {
    return {
      'logLevel': _logLevel.name,
      'loggingEnabled': _loggingEnabled,
      'maxLogHistory': 1000,
    };
  }

  @override
  Future<void> updateConfiguration(Map<String, dynamic> config) async {
    if (config.containsKey('logLevel')) {
      _logLevel = LogLevel.values.firstWhere(
        (level) => level.name == config['logLevel'],
        orElse: () => LogLevel.info,
      );
    }

    if (config.containsKey('loggingEnabled')) {
      _loggingEnabled = config['loggingEnabled'];
    }

    print('[LoggingService] Configuration updated');
  }
}

/// Analytics service implementation
class chromaAnalyticsService implements AnalyticsServiceInterface {
  bool _analyticsEnabled = true;
  String? _sessionId;
  String? _userId;
  final List<Map<String, dynamic>> _eventQueue = [];

  @override
  Future<void> initialize() async {
    print('[AnalyticsService] Initializing...');
    _sessionId = _generateSessionId();
    _analyticsEnabled = true;
    print('[AnalyticsService] Initialized with session: $_sessionId');
  }

  @override
  Future<void> trackEvent(String eventName, {
    Map<String, dynamic>? parameters,
    String? userId,
  }) async {
    if (!_analyticsEnabled) return;

    final event = {
      'eventName': eventName,
      'parameters': parameters ?? {},
      'userId': userId ?? _userId,
      'sessionId': _sessionId,
      'timestamp': DateTime.now().toIso8601String(),
      'eventType': 'event',
    };

    _eventQueue.add(event);
    print('[AnalyticsService] Event tracked: $eventName');
    await _flushIfNecessary();
  }

  @override
  Future<void> trackScreenView(String screenName, {
    Map<String, dynamic>? parameters,
    String? userId,
  }) async {
    if (!_analyticsEnabled) return;

    final event = {
      'screenName': screenName,
      'parameters': parameters ?? {},
      'userId': userId ?? _userId,
      'sessionId': _sessionId,
      'timestamp': DateTime.now().toIso8601String(),
      'eventType': 'screen_view',
    };

    _eventQueue.add(event);
    print('[AnalyticsService] Screen view tracked: $screenName');
    await _flushIfNecessary();
  }

  @override
  Future<void> trackUserAction(String action, {
    Map<String, dynamic>? parameters,
    String? userId,
  }) async {
    await trackEvent('user_action', parameters: {
      'action': action,
      ...?parameters,
    }, userId: userId);
  }

  @override
  Future<void> trackComponentUsage(String componentName, {
    Map<String, dynamic>? parameters,
    String? userId,
  }) async {
    await trackEvent('component_usage', parameters: {
      'componentName': componentName,
      ...?parameters,
    }, userId: userId);
  }

  @override
  Future<void> trackError(String error, {
    StackTrace? stackTrace,
    Map<String, dynamic>? parameters,
    String? userId,
  }) async {
    await trackEvent('error', parameters: {
      'error': error,
      'stackTrace': stackTrace?.toString(),
      ...?parameters,
    }, userId: userId);
  }

  @override
  Future<void> trackPerformance(String metricName, Duration duration, {
    Map<String, dynamic>? parameters,
    String? userId,
  }) async {
    await trackEvent('performance', parameters: {
      'metricName': metricName,
      'duration': duration.inMilliseconds,
      ...?parameters,
    }, userId: userId);
  }

  @override
  Future<void> setUserProperties(Map<String, dynamic> properties, {
    String? userId,
  }) async {
    await trackEvent('user_properties_set', parameters: properties, userId: userId);
  }

  @override
  Future<void> setUserId(String userId) async {
    _userId = userId;
    print('[AnalyticsService] User ID set: $userId');
  }

  @override
  Future<void> clearUserId() async {
    _userId = null;
    print('[AnalyticsService] User ID cleared');
  }

  @override
  Future<void> setAnalyticsEnabled(bool enabled) async {
    _analyticsEnabled = enabled;
    print('[AnalyticsService] Analytics ${enabled ? 'enabled' : 'disabled'}');
  }

  @override
  bool get isAnalyticsEnabled => _analyticsEnabled;

  @override
  String? get sessionId => _sessionId;

  @override
  Map<String, dynamic> getConfiguration() {
    return {
      'analyticsEnabled': _analyticsEnabled,
      'sessionId': _sessionId,
      'userId': _userId,
      'eventQueueSize': _eventQueue.length,
    };
  }

  @override
  Future<void> updateConfiguration(Map<String, dynamic> config) async {
    if (config.containsKey('analyticsEnabled')) {
      _analyticsEnabled = config['analyticsEnabled'];
    }

    print('[AnalyticsService] Configuration updated');
  }

  @override
  Future<void> flush() async {
    if (_eventQueue.isEmpty) return;

    print('[AnalyticsService] Flushing ${_eventQueue.length} events');
    // In a real implementation, this would send to analytics service
    _eventQueue.clear();
  }

  @override
  Future<void> optOut() async {
    _analyticsEnabled = false;
    _eventQueue.clear();
    print('[AnalyticsService] Opted out of analytics');
  }

  @override
  Future<void> optIn() async {
    _analyticsEnabled = true;
    print('[AnalyticsService] Opted in to analytics');
  }

  String _generateSessionId() {
    return 'session_${DateTime.now().millisecondsSinceEpoch}_${_randomString(8)}';
  }

  String _randomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(DateTime.now().millisecond + DateTime.now().microsecond) % chars.length,
    ));
  }

  Future<void> _flushIfNecessary() async {
    if (_eventQueue.length >= 10) {
      await flush();
    }
  }
}

/// Monitoring service implementation
class chromaMonitoringService implements MonitoringServiceInterface {
  bool _monitoringEnabled = true;
  bool _isMonitoring = false;
  final List<MonitoringListener> _listeners = [];
  final Map<String, dynamic> _metrics = {};
  final Map<String, dynamic> _tags = {};
  Timer? _monitoringTimer;

  @override
  Future<void> initialize() async {
    print('[MonitoringService] Initializing...');
    _monitoringEnabled = true;
    _metrics.clear();
    _tags.clear();
    print('[MonitoringService] Initialized');
  }

  @override
  Future<void> startMonitoring() async {
    if (!_monitoringEnabled || _isMonitoring) return;

    print('[MonitoringService] Starting monitoring...');
    _isMonitoring = true;

    // Start periodic monitoring
    _monitoringTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _collectSystemMetrics();
    });

    print('[MonitoringService] Monitoring started');
  }

  @override
  Future<void> stopMonitoring() async {
    if (!_isMonitoring) return;

    print('[MonitoringService] Stopping monitoring...');
    _isMonitoring = false;
    _monitoringTimer?.cancel();
    _monitoringTimer = null;
    print('[MonitoringService] Monitoring stopped');
  }

  @override
  Future<void> trackMetric(String metricName, double value, {
    Map<String, dynamic>? tags,
  }) async {
    if (!_monitoringEnabled) return;

    _metrics[metricName] = {
      'value': value,
      'timestamp': DateTime.now().toIso8601String(),
      'tags': {..._tags, ...?tags},
    };

    _notifyMetricRecorded(metricName, value, {..._tags, ...?tags});
    print('[MonitoringService] Metric tracked: $metricName = $value');
  }

  @override
  Future<void> incrementCounter(String counterName, {
    double value = 1.0,
    Map<String, dynamic>? tags,
  }) async {
    final currentValue = _metrics[counterName]?['value'] as double? ?? 0.0;
    await trackMetric(counterName, currentValue + value, tags: tags);
  }

  @override
  Future<void> setGauge(String gaugeName, double value, {
    Map<String, dynamic>? tags,
  }) async {
    await trackMetric(gaugeName, value, tags: tags);
  }

  @override
  Future<void> trackHistogram(String histogramName, double value, {
    Map<String, dynamic>? tags,
  }) async {
    await trackMetric(histogramName, value, tags: tags);
  }

  @override
  Future<void> trackTiming(String timingName, Duration duration, {
    Map<String, dynamic>? tags,
  }) async {
    await trackMetric(timingName, duration.inMilliseconds.toDouble(), tags: tags);
  }

  @override
  Future<void> trackException(Object exception, StackTrace stackTrace, {
    Map<String, dynamic>? tags,
  }) async {
    _metrics['exception'] = {
      'exception': exception.toString(),
      'stackTrace': stackTrace.toString(),
      'timestamp': DateTime.now().toIso8601String(),
      'tags': {..._tags, ...?tags},
    };

    _notifyExceptionTracked(exception, stackTrace);
    print('[MonitoringService] Exception tracked: $exception');
  }

  @override
  Future<void> trackNetworkRequest(String url, String method, {
    int? statusCode,
    Duration? duration,
    int? responseSize,
    Map<String, dynamic>? tags,
  }) async {
    await trackMetric('network_request', duration?.inMilliseconds.toDouble() ?? 0.0, tags: {
      'url': url,
      'method': method,
      'statusCode': statusCode,
      'responseSize': responseSize,
      ...?tags,
    });
  }

  @override
  Future<void> trackMemoryUsage() async {
    // Simulate memory usage tracking
    final memoryUsage = (DateTime.now().millisecondsSinceEpoch % 100) + 50;
    await trackMetric('memory_usage', memoryUsage.toDouble());
  }

  @override
  Future<void> trackCPUUsage() async {
    // Simulate CPU usage tracking
    final cpuUsage = (DateTime.now().millisecondsSinceEpoch % 100) + 10;
    await trackMetric('cpu_usage', cpuUsage.toDouble());
  }

  @override
  Future<void> trackFrameRate() async {
    // Simulate frame rate tracking
    final frameRate = 60 - (DateTime.now().millisecondsSinceEpoch % 10);
    await trackMetric('frame_rate', frameRate.toDouble());
  }

  @override
  Future<void> trackBatteryUsage() async {
    // Simulate battery usage tracking
    final batteryLevel = (DateTime.now().millisecondsSinceEpoch % 100);
    await trackMetric('battery_level', batteryLevel.toDouble());
  }

  @override
  Future<void> trackDeviceMetrics() async {
    await trackMemoryUsage();
    await trackCPUUsage();
    await trackFrameRate();
    await trackBatteryUsage();
  }

  @override
  Future<void> setTags(Map<String, String> tags) async {
    _tags.addAll(tags);
    print('[MonitoringService] Tags updated: $tags');
  }

  @override
  void addMonitoringListener(MonitoringListener listener) {
    _listeners.add(listener);
  }

  @override
  void removeMonitoringListener(MonitoringListener listener) {
    _listeners.remove(listener);
  }

  @override
  Map<String, dynamic> getMonitoringData() {
    return {
      'metrics': _metrics,
      'tags': _tags,
      'isMonitoring': _isMonitoring,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  @override
  Map<String, dynamic> getPerformanceMetrics() {
    return {
      'memory_usage': _metrics['memory_usage'],
      'cpu_usage': _metrics['cpu_usage'],
      'frame_rate': _metrics['frame_rate'],
      'battery_level': _metrics['battery_level'],
    };
  }

  @override
  Map<String, dynamic> getSystemMetrics() {
    return {
      'uptime': DateTime.now().difference(DateTime(2024, 1, 1)).inMilliseconds,
      'session_count': _metrics['session_count'] ?? 0,
      'error_count': _metrics['error_count'] ?? 0,
    };
  }

  @override
  Future<void> setMonitoringEnabled(bool enabled) async {
    _monitoringEnabled = enabled;

    if (!enabled && _isMonitoring) {
      await stopMonitoring();
    }

    print('[MonitoringService] Monitoring ${enabled ? 'enabled' : 'disabled'}');
  }

  @override
  bool get isMonitoringEnabled => _monitoringEnabled;

  @override
  Map<String, dynamic> getConfiguration() {
    return {
      'monitoringEnabled': _monitoringEnabled,
      'isMonitoring': _isMonitoring,
      'tags': _tags,
      'metricsCount': _metrics.length,
    };
  }

  @override
  Future<void> updateConfiguration(Map<String, dynamic> config) async {
    if (config.containsKey('monitoringEnabled')) {
      await setMonitoringEnabled(config['monitoringEnabled']);
    }

    if (config.containsKey('tags')) {
      _tags.addAll(config['tags']);
    }

    print('[MonitoringService] Configuration updated');
  }

  @override
  Future<String> generateReport() async {
    final report = {
      'timestamp': DateTime.now().toIso8601String(),
      'monitoringData': getMonitoringData(),
      'performanceMetrics': getPerformanceMetrics(),
      'systemMetrics': getSystemMetrics(),
    };

    print('[MonitoringService] Report generated');
    return report.toString();
  }

  @override
  Future<void> exportData(String filePath) async {
    final data = getMonitoringData();
    print('[MonitoringService] Data exported to: $filePath');
    // In a real implementation, this would write to a file
  }

  void _collectSystemMetrics() {
    if (!_isMonitoring) return;

    trackDeviceMetrics();
  }

  void _notifyMetricRecorded(String metricName, double value, Map<String, dynamic>? tags) {
    for (final listener in _listeners) {
      try {
        listener.onMetricRecorded(metricName, value, tags);
      } catch (error) {
        print('[MonitoringService] Error in monitoring listener: $error');
      }
    }
  }

  void _notifyExceptionTracked(Object exception, StackTrace stackTrace) {
    for (final listener in _listeners) {
      try {
        listener.onExceptionTracked(exception, stackTrace);
      } catch (error) {
        print('[MonitoringService] Error in monitoring listener: $error');
      }
    }
  }

  void _notifyPerformanceDataUpdated(Map<String, dynamic> data) {
    for (final listener in _listeners) {
      try {
        listener.onPerformanceDataUpdated(data);
      } catch (error) {
        print('[MonitoringService] Error in monitoring listener: $error');
      }
    }
  }
}

/// Storage service implementation
class chromaStorageService implements StorageServiceInterface {
  final Map<String, dynamic> _storage = {};
  final List<StorageListener> _listeners = [];
  bool _storageEnabled = true;
  bool _encryptionEnabled = false;
  String _namespace = 'default';

  @override
  Future<void> initialize() async {
    print('[StorageService] Initializing...');
    _storage.clear();
    _storageEnabled = true;
    _encryptionEnabled = false;
    _namespace = 'default';
    print('[StorageService] Initialized');
  }

  @override
  Future<void> setString(String key, String value) async {
    await _set(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _set(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await _set(key, value);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _set(key, value);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _set(key, value);
  }

  @override
  Future<void> setObject<T>(String key, T value) async {
    await _set(key, value);
  }

  Future<void> _set(String key, dynamic value) async {
    if (!_storageEnabled) return;

    final namespacedKey = _getNamespacedKey(key);
    final oldValue = _storage[namespacedKey];
    _storage[namespacedKey] = value;

    print('[StorageService] Set $key = $value');
    _notifyStorageChanged(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _get<String>(key);
  }

  @override
  Future<int?> getInt(String key) async {
    return _get<int>(key);
  }

  @override
  Future<double?> getDouble(String key) async {
    return _get<double>(key);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _get<bool>(key);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    return _get<List<String>>(key);
  }

  @override
  Future<T?> getObject<T>(String key) async {
    return _get<T>(key);
  }

  Future<T?> _get<T>(String key) async {
    if (!_storageEnabled) return null;

    final namespacedKey = _getNamespacedKey(key);
    final value = _storage[namespacedKey];

    if (value is T) {
      return value as T;
    }

    return null;
  }

  @override
  Future<bool> containsKey(String key) async {
    if (!_storageEnabled) return false;

    final namespacedKey = _getNamespacedKey(key);
    return _storage.containsKey(namespacedKey);
  }

  @override
  Future<void> remove(String key) async {
    if (!_storageEnabled) return;

    final namespacedKey = _getNamespacedKey(key);
    _storage.remove(namespacedKey);

    print('[StorageService] Removed $key');
    _notifyStorageChanged(key, null);
  }

  @override
  Future<void> clear() async {
    if (!_storageEnabled) return;

    _storage.clear();
    print('[StorageService] Cleared all storage');
    _notifyStorageCleared();
  }

  @override
  Future<List<String>> getKeys() async {
    if (!_storageEnabled) return [];

    return _storage.keys.map((key) => _removeNamespace(key)).toList();
  }

  @override
  Future<StorageInfo> getStorageInfo() async {
    return StorageInfo(
      totalSize: 1000000, // 1MB mock limit
      usedSize: _storage.toString().length,
      freeSize: 1000000 - _storage.toString().length,
      keyCount: _storage.length,
      lastModified: DateTime.now(),
      version: '1.0.0',
    );
  }

  @override
  Future<void> compress() async {
    print('[StorageService] Compressing storage...');
    // Mock compression
    print('[StorageService] Storage compressed');
  }

  @override
  Future<String> backup(String backupPath) async {
    final backupData = {
      'timestamp': DateTime.now().toIso8601String(),
      'namespace': _namespace,
      'data': _storage,
    };

    print('[StorageService] Backup created at: $backupPath');
    return backupData.toString();
  }

  @override
  Future<void> restore(String backupPath) async {
    print('[StorageService] Restoring from: $backupPath');
    // Mock restore
    print('[StorageService] Storage restored');
  }

  @override
  Future<void> enableEncryption(String password) async {
    _encryptionEnabled = true;
    print('[StorageService] Encryption enabled');
  }

  @override
  Future<void> disableEncryption() async {
    _encryptionEnabled = false;
    print('[StorageService] Encryption disabled');
  }

  @override
  bool get isEncryptionEnabled => _encryptionEnabled;

  @override
  Future<void> setNamespace(String namespace) async {
    _namespace = namespace;
    print('[StorageService] Namespace set to: $namespace');
  }

  @override
  String get namespace => _namespace;

  @override
  void addStorageListener(StorageListener listener) {
    _listeners.add(listener);
  }

  @override
  void removeStorageListener(StorageListener listener) {
    _listeners.remove(listener);
  }

  @override
  Future<void> setStorageEnabled(bool enabled) async {
    _storageEnabled = enabled;
    print('[StorageService] Storage ${enabled ? 'enabled' : 'disabled'}');
  }

  @override
  bool get isStorageEnabled => _storageEnabled;

  @override
  Map<String, dynamic> getConfiguration() {
    return {
      'storageEnabled': _storageEnabled,
      'encryptionEnabled': _encryptionEnabled,
      'namespace': _namespace,
      'keyCount': _storage.length,
    };
  }

  @override
  Future<void> updateConfiguration(Map<String, dynamic> config) async {
    if (config.containsKey('storageEnabled')) {
      _storageEnabled = config['storageEnabled'];
    }

    if (config.containsKey('encryptionEnabled')) {
      _encryptionEnabled = config['encryptionEnabled'];
    }

    if (config.containsKey('namespace')) {
      _namespace = config['namespace'];
    }

    print('[StorageService] Configuration updated');
  }

  String _getNamespacedKey(String key) {
    return '$_namespace:$key';
  }

  String _removeNamespace(String namespacedKey) {
    return namespacedKey.replaceFirst('$_namespace:', '');
  }

  void _notifyStorageChanged(String key, dynamic value) {
    for (final listener in _listeners) {
      try {
        listener.onStorageChanged(key, value);
      } catch (error) {
        print('[StorageService] Error in storage listener: $error');
      }
    }
  }

  void _notifyStorageCleared() {
    for (final listener in _listeners) {
      try {
        listener.onStorageCleared();
      } catch (error) {
        print('[StorageService] Error in storage listener: $error');
      }
    }
  }
}
