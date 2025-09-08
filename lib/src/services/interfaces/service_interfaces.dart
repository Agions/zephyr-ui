import '../interfaces/service_interfaces.dart';

/// Analytics service interface
abstract class AnalyticsServiceInterface {
  /// Initialize analytics service
  Future<void> initialize();
  
  /// Track user event
  Future<void> trackEvent(String eventName, {
    Map<String, dynamic>? parameters,
    String? userId,
  });
  
  /// Track screen view
  Future<void> trackScreenView(String screenName, {
    Map<String, dynamic>? parameters,
    String? userId,
  });
  
  /// Track user action
  Future<void> trackUserAction(String action, {
    Map<String, dynamic>? parameters,
    String? userId,
  });
  
  /// Track component usage
  Future<void> trackComponentUsage(String componentName, {
    Map<String, dynamic>? parameters,
    String? userId,
  });
  
  /// Track error
  Future<void> trackError(String error, {
    StackTrace? stackTrace,
    Map<String, dynamic>? parameters,
    String? userId,
  });
  
  /// Track performance metrics
  Future<void> trackPerformance(String metricName, Duration duration, {
    Map<String, dynamic>? parameters,
    String? userId,
  });
  
  /// Set user properties
  Future<void> setUserProperties(Map<String, dynamic> properties, {
    String? userId,
  });
  
  /// Set user ID
  Future<void> setUserId(String userId);
  
  /// Clear user ID
  Future<void> clearUserId();
  
  /// Enable/disable analytics
  Future<void> setAnalyticsEnabled(bool enabled);
  
  /// Check if analytics is enabled
  bool get isAnalyticsEnabled;
  
  /// Get analytics session ID
  String? get sessionId;
  
  /// Get analytics configuration
  Map<String, dynamic> getConfiguration();
  
  /// Update analytics configuration
  Future<void> updateConfiguration(Map<String, dynamic> config);
  
  /// Flush analytics events
  Future<void> flush();
  
  /// Opt out of analytics
  Future<void> optOut();
  
  /// Opt in to analytics
  Future<void> optIn();
}

/// Logging service interface
abstract class LoggingServiceInterface {
  /// Initialize logging service
  Future<void> initialize();
  
  /// Log debug message
  void debug(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  });
  
  /// Log info message
  void info(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  });
  
  /// Log warning message
  void warning(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  });
  
  /// Log error message
  void error(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  });
  
  /// Log fatal message
  void fatal(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  });
  
  /// Log verbose message
  void verbose(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  });
  
  /// Log wtf message (What a Terrible Failure)
  void wtf(String message, {
    Map<String, dynamic>? parameters,
    String? tag,
    StackTrace? stackTrace,
  });
  
  /// Set minimum log level
  void setLogLevel(LogLevel level);
  
  /// Get current log level
  LogLevel get logLevel;
  
  /// Add log listener
  void addLogListener(LogListener listener);
  
  /// Remove log listener
  void removeLogListener(LogListener listener);
  
  /// Get log history
  List<LogEntry> getLogHistory({int limit = 100});
  
  /// Clear log history
  void clearLogHistory();
  
  /// Export logs to file
  Future<String> exportLogsToFile(String filePath);
  
  /// Enable/disable logging
  void setLoggingEnabled(bool enabled);
  
  /// Check if logging is enabled
  bool get isLoggingEnabled;
  
  /// Get logging configuration
  Map<String, dynamic> getConfiguration();
  
  /// Update logging configuration
  Future<void> updateConfiguration(Map<String, dynamic> config);
}

/// Monitoring service interface
abstract class MonitoringServiceInterface {
  /// Initialize monitoring service
  Future<void> initialize();
  
  /// Start monitoring
  Future<void> startMonitoring();
  
  /// Stop monitoring
  Future<void> stopMonitoring();
  
  /// Track custom metric
  Future<void> trackMetric(String metricName, double value, {
    Map<String, dynamic>? tags,
  });
  
  /// Track counter
  Future<void> incrementCounter(String counterName, {
    double value = 1.0,
    Map<String, dynamic>? tags,
  });
  
  /// Track gauge
  Future<void> setGauge(String gaugeName, double value, {
    Map<String, dynamic>? tags,
  });
  
  /// Track histogram
  Future<void> trackHistogram(String histogramName, double value, {
    Map<String, dynamic>? tags,
  });
  
  /// Track timing
  Future<void> trackTiming(String timingName, Duration duration, {
    Map<String, dynamic>? tags,
  });
  
  /// Track exception
  Future<void> trackException(Object exception, StackTrace stackTrace, {
    Map<String, dynamic>? tags,
  });
  
  /// Track network request
  Future<void> trackNetworkRequest(String url, String method, {
    int? statusCode,
    Duration? duration,
    int? responseSize,
    Map<String, dynamic>? tags,
  });
  
  /// Track memory usage
  Future<void> trackMemoryUsage();
  
  /// Track CPU usage
  Future<void> trackCPUUsage();
  
  /// Track frame rate
  Future<void> trackFrameRate();
  
  /// Track battery usage
  Future<void> trackBatteryUsage();
  
  /// Track device metrics
  Future<void> trackDeviceMetrics();
  
  /// Set monitoring tags
  Future<void> setTags(Map<String, String> tags);
  
  /// Add monitoring listener
  void addMonitoringListener(MonitoringListener listener);
  
  /// Remove monitoring listener
  void removeMonitoringListener(MonitoringListener listener);
  
  /// Get monitoring data
  Map<String, dynamic> getMonitoringData();
  
  /// Get performance metrics
  Map<String, dynamic> getPerformanceMetrics();
  
  /// Get system metrics
  Map<String, dynamic> getSystemMetrics();
  
  /// Enable/disable monitoring
  Future<void> setMonitoringEnabled(bool enabled);
  
  /// Check if monitoring is enabled
  bool get isMonitoringEnabled;
  
  /// Get monitoring configuration
  Map<String, dynamic> getConfiguration();
  
  /// Update monitoring configuration
  Future<void> updateConfiguration(Map<String, dynamic> config);
  
  /// Generate monitoring report
  Future<String> generateReport();
  
  /// Export monitoring data
  Future<void> exportData(String filePath);
}

/// Storage service interface
abstract class StorageServiceInterface {
  /// Initialize storage service
  Future<void> initialize();
  
  /// Store data with key
  Future<void> setString(String key, String value);
  
  /// Store integer data
  Future<void> setInt(String key, int value);
  
  /// Store double data
  Future<void> setDouble(String key, double value);
  
  /// Store boolean data
  Future<void> setBool(String key, bool value);
  
  /// Store string list
  Future<void> setStringList(String key, List<String> value);
  
  /// Store object data
  Future<void> setObject<T>(String key, T value);
  
  /// Get string data
  Future<String?> getString(String key);
  
  /// Get integer data
  Future<int?> getInt(String key);
  
  /// Get double data
  Future<double?> getDouble(String key);
  
  /// Get boolean data
  Future<bool?> getBool(String key);
  
  /// Get string list
  Future<List<String>?> getStringList(String key);
  
  /// Get object data
  Future<T?> getObject<T>(String key);
  
  /// Check if key exists
  Future<bool> containsKey(String key);
  
  /// Remove data by key
  Future<void> remove(String key);
  
  /// Clear all data
  Future<void> clear();
  
  /// Get all keys
  Future<List<String>> getKeys();
  
  /// Get storage info
  Future<StorageInfo> getStorageInfo();
  
  /// Compress storage
  Future<void> compress();
  
  /// Backup storage
  Future<String> backup(String backupPath);
  
  /// Restore storage from backup
  Future<void> restore(String backupPath);
  
  /// Enable encryption
  Future<void> enableEncryption(String password);
  
  /// Disable encryption
  Future<void> disableEncryption();
  
  /// Check if encryption is enabled
  bool get isEncryptionEnabled;
  
  /// Set storage namespace
  Future<void> setNamespace(String namespace);
  
  /// Get current namespace
  String get namespace;
  
  /// Add storage listener
  void addStorageListener(StorageListener listener);
  
  /// Remove storage listener
  void removeStorageListener(StorageListener listener);
  
  /// Enable/disable storage
  Future<void> setStorageEnabled(bool enabled);
  
  /// Check if storage is enabled
  bool get isStorageEnabled;
  
  /// Get storage configuration
  Map<String, dynamic> getConfiguration();
  
  /// Update storage configuration
  Future<void> updateConfiguration(Map<String, dynamic> config);
}

/// Service manager interface
abstract class ServiceManagerInterface {
  /// Initialize all services
  Future<void> initializeServices();
  
  /// Register service
  void registerService<T>(T service);
  
  /// Unregister service
  void unregisterService<T>();
  
  /// Get service by type
  T getService<T>();
  
  /// Check if service is registered
  bool isServiceRegistered<T>();
  
  /// Get all registered services
  Map<Type, dynamic> getAllServices();
  
  /// Start all services
  Future<void> startAllServices();
  
  /// Stop all services
  Future<void> stopAllServices();
  
  /// Restart all services
  Future<void> restartAllServices();
  
  /// Get service status
  Map<Type, ServiceStatus> getServiceStatus();
  
  /// Add service listener
  void addServiceListener(ServiceListener listener);
  
  /// Remove service listener
  void removeServiceListener(ServiceListener listener);
  
  /// Enable/disable all services
  Future<void> setServicesEnabled(bool enabled);
  
  /// Check if services are enabled
  bool get areServicesEnabled;
}

/// Service status enum
enum ServiceStatus {
  notInitialized,
  initializing,
  initialized,
  starting,
  running,
  stopping,
  stopped,
  error,
}

/// Log level enum
enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  fatal,
  wtf,
}

/// Log entry class
class LogEntry {
  final LogLevel level;
  final String message;
  final DateTime timestamp;
  final Map<String, dynamic>? parameters;
  final String? tag;
  final StackTrace? stackTrace;
  
  LogEntry({
    required this.level,
    required this.message,
    required this.timestamp,
    this.parameters,
    this.tag,
    this.stackTrace,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'level': level.name,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'parameters': parameters,
      'tag': tag,
      'stackTrace': stackTrace?.toString(),
    };
  }
}

/// Storage info class
class StorageInfo {
  final int totalSize;
  final int usedSize;
  final int freeSize;
  final int keyCount;
  final DateTime lastModified;
  final String version;
  
  StorageInfo({
    required this.totalSize,
    required this.usedSize,
    required this.freeSize,
    required this.keyCount,
    required this.lastModified,
    required this.version,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'totalSize': totalSize,
      'usedSize': usedSize,
      'freeSize': freeSize,
      'keyCount': keyCount,
      'lastModified': lastModified.toIso8601String(),
      'version': version,
    };
  }
}

/// Service listener interface
abstract class ServiceListener {
  void onServiceStatusChanged(Type serviceType, ServiceStatus status);
  void onServiceError(Type serviceType, Object error, StackTrace stackTrace);
}

/// Log listener interface
abstract class LogListener {
  void onLogEntry(LogEntry entry);
}

/// Monitoring listener interface
abstract class MonitoringListener {
  void onMetricRecorded(String metricName, double value, Map<String, dynamic>? tags);
  void onExceptionTracked(Object exception, StackTrace stackTrace);
  void onPerformanceDataUpdated(Map<String, dynamic> data);
}

/// Storage listener interface
abstract class StorageListener {
  void onStorageChanged(String key, dynamic value);
  void onStorageCleared();
  void onStorageError(Object error, StackTrace stackTrace);
}