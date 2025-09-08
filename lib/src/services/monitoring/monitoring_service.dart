/// chromaUI Monitoring Service
///
/// Comprehensive monitoring service for application health:
/// - Performance monitoring
/// - Error tracking and crash reporting
/// - Resource usage monitoring
/// - Network monitoring
/// - Health checks
library monitoring_service;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:chroma_ui/src/core/config/environment_config.dart';
import 'package:chroma_ui/src/core/config/feature_flags.dart';

/// Monitor event types
enum MonitorEventType {
  performance,
  error,
  crash,
  network,
  resource,
  health,
}

/// Monitor event data class
class MonitorEvent {
  const MonitorEvent({
    required this.type,
    required this.name,
    required this.data,
    required this.timestamp,
    this.sessionId,
    this.userId,
  });
  final MonitorEventType type;
  final String name;
  final Map<String, dynamic> data;
  final DateTime timestamp;
  final String? sessionId;
  final String? userId;

  /// Convert monitor event to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'name': name,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      'sessionId': sessionId,
      'userId': userId,
    };
  }
}

/// Performance metrics
class PerformanceMetrics {
  const PerformanceMetrics({
    required this.responseTime,
    required this.memoryUsage,
    required this.cpuUsage,
    required this.frameRate,
    required this.timestamp,
  });
  final Duration responseTime;
  final int memoryUsage;
  final double cpuUsage;
  final int frameRate;
  final DateTime timestamp;

  Map<String, dynamic> toJson() {
    return {
      'responseTimeMs': responseTime.inMilliseconds,
      'memoryUsageBytes': memoryUsage,
      'cpuUsagePercent': cpuUsage,
      'frameRate': frameRate,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Error info
class ErrorInfo {
  const ErrorInfo({
    required this.error,
    required this.timestamp,
    required this.severity,
    this.stackTrace,
    this.context,
    this.metadata,
  });
  final String error;
  final StackTrace? stackTrace;
  final String? context;
  final Map<String, dynamic>? metadata;
  final DateTime timestamp;
  final ErrorSeverity severity;

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'stackTrace': stackTrace?.toString(),
      'context': context,
      'metadata': metadata,
      'timestamp': timestamp.toIso8601String(),
      'severity': severity.name,
    };
  }
}

/// Error severity levels
enum ErrorSeverity {
  low,
  medium,
  high,
  critical,
}

/// Health status
enum HealthStatus {
  healthy,
  degraded,
  unhealthy,
  unknown,
}

/// Health check result
class HealthCheckResult {
  const HealthCheckResult({
    required this.name,
    required this.status,
    required this.timestamp,
    this.message,
    this.responseTime,
  });
  final String name;
  final HealthStatus status;
  final String? message;
  final Duration? responseTime;
  final DateTime timestamp;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status.name,
      'message': message,
      'responseTimeMs': responseTime?.inMilliseconds,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// Monitoring service interface
abstract class MonitoringService {
  /// Initialize the monitoring service
  Future<void> initialize();

  /// Record a monitor event
  Future<void> recordEvent(MonitorEvent event);

  /// Record performance metrics
  Future<void> recordPerformance(PerformanceMetrics metrics);

  /// Record an error
  Future<void> recordError(ErrorInfo error);

  /// Record a crash
  Future<void> recordCrash(String crashReport,
      {String? context, Map<String, dynamic>? metadata});

  /// Perform health check
  Future<HealthCheckResult> performHealthCheck(
      String name, Future<bool> Function() check);

  /// Start monitoring
  Future<void> startMonitoring();

  /// Stop monitoring
  Future<void> stopMonitoring();

  /// Get current health status
  HealthStatus get healthStatus;

  /// Get recent events
  List<MonitorEvent> getRecentEvents(
      {Duration duration = const Duration(hours: 1)});

  /// Get performance metrics
  List<PerformanceMetrics> getPerformanceMetrics(
      {Duration duration = const Duration(hours: 1)});

  /// Get error reports
  List<ErrorInfo> getErrorReports(
      {Duration duration = const Duration(hours: 1)});

  /// Enable/disable monitoring
  void setEnabled(bool enabled);

  /// Check if monitoring is enabled
  bool get isEnabled;

  /// Clear all collected data
  void clearData();

  /// Dispose of resources
  Future<void> dispose();
}

/// Default monitoring service implementation
class DefaultMonitoringService implements MonitoringService {
  DefaultMonitoringService._internal();
  static DefaultMonitoringService? _instance;
  static DefaultMonitoringService get instance =>
      _instance ??= DefaultMonitoringService._internal();

  final List<MonitorEvent> _events = [];
  final List<PerformanceMetrics> _performanceMetrics = [];
  final List<ErrorInfo> _errors = [];
  final List<HealthCheckResult> _healthChecks = [];
  final StreamController<MonitorEvent> _eventController =
      StreamController.broadcast();
  final StreamController<PerformanceMetrics> _performanceController =
      StreamController.broadcast();
  final StreamController<ErrorInfo> _errorController =
      StreamController.broadcast();

  bool _isEnabled = false;
  bool _isMonitoring = false;
  Timer? _monitoringTimer;
  HealthStatus _healthStatus = HealthStatus.unknown;

  @override
  Future<void> initialize() async {
    if (!featureFlags.isEnabled('monitoring')) {
      if (kDebugMode) {
        debugPrint('Monitoring service disabled by feature flag');
      }
      return;
    }

    _isEnabled = environmentConfig.isPerformanceMonitoringEnabled;

    if (_isEnabled) {
      if (kDebugMode) {
        debugPrint('Monitoring service initialized');
      }

      // Start automatic monitoring
      await startMonitoring();
    }
  }

  @override
  Future<void> recordEvent(MonitorEvent event) async {
    if (!_isEnabled) return;

    _events.add(event);
    _eventController.add(event);

    if (kDebugMode) {
      debugPrint('Monitor event recorded: ${event.name}');
    }
  }

  @override
  Future<void> recordPerformance(PerformanceMetrics metrics) async {
    if (!_isEnabled) return;

    _performanceMetrics.add(metrics);
    _performanceController.add(metrics);

    // Keep only last 1000 metrics
    if (_performanceMetrics.length > 1000) {
      _performanceMetrics.removeRange(0, _performanceMetrics.length - 1000);
    }
  }

  @override
  Future<void> recordError(ErrorInfo error) async {
    if (!_isEnabled) return;

    _errors.add(error);
    _errorController.add(error);

    // Update health status based on error severity
    if (error.severity == ErrorSeverity.critical) {
      _healthStatus = HealthStatus.unhealthy;
    } else if (error.severity == ErrorSeverity.high &&
        _healthStatus == HealthStatus.healthy) {
      _healthStatus = HealthStatus.degraded;
    }

    if (kDebugMode) {
      debugPrint('Error recorded: ${error.error}');
    }
  }

  @override
  Future<void> recordCrash(String crashReport,
      {String? context, Map<String, dynamic>? metadata}) async {
    final error = ErrorInfo(
      error: crashReport,
      context: context ?? 'Crash',
      metadata: metadata,
      timestamp: DateTime.now(),
      severity: ErrorSeverity.critical,
    );

    await recordError(error);
    _healthStatus = HealthStatus.unhealthy;

    if (kDebugMode) {
      debugPrint('Crash recorded: $crashReport');
    }
  }

  @override
  Future<HealthCheckResult> performHealthCheck(
      String name, Future<bool> Function() check) async {
    final stopwatch = Stopwatch()..start();
    final timestamp = DateTime.now();

    try {
      final isHealthy = await check();
      stopwatch.stop();
      final responseTime = stopwatch.elapsed;

      final result = HealthCheckResult(
        name: name,
        status: isHealthy ? HealthStatus.healthy : HealthStatus.unhealthy,
        responseTime: responseTime,
        timestamp: timestamp,
      );

      _healthChecks.add(result);

      // Update overall health status
      _updateOverallHealthStatus();

      return result;
    } catch (e) {
      stopwatch.stop();
      final responseTime = stopwatch.elapsed;

      final result = HealthCheckResult(
        name: name,
        status: HealthStatus.unhealthy,
        message: e.toString(),
        responseTime: responseTime,
        timestamp: timestamp,
      );

      _healthChecks.add(result);
      _updateOverallHealthStatus();

      return result;
    }
  }

  @override
  Future<void> startMonitoring() async {
    if (!_isEnabled || _isMonitoring) return;

    _isMonitoring = true;

    // Start periodic monitoring
    _monitoringTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      await _collectMetrics();
    });

    if (kDebugMode) {
      debugPrint('Monitoring started');
    }
  }

  @override
  Future<void> stopMonitoring() async {
    if (!_isMonitoring) return;

    _isMonitoring = false;
    _monitoringTimer?.cancel();
    _monitoringTimer = null;

    if (kDebugMode) {
      debugPrint('Monitoring stopped');
    }
  }

  @override
  HealthStatus get healthStatus => _healthStatus;

  @override
  List<MonitorEvent> getRecentEvents(
      {Duration duration = const Duration(hours: 1)}) {
    final cutoff = DateTime.now().subtract(duration);
    return _events.where((event) => event.timestamp.isAfter(cutoff)).toList();
  }

  @override
  List<PerformanceMetrics> getPerformanceMetrics(
      {Duration duration = const Duration(hours: 1)}) {
    final cutoff = DateTime.now().subtract(duration);
    return _performanceMetrics
        .where((metrics) => metrics.timestamp.isAfter(cutoff))
        .toList();
  }

  @override
  List<ErrorInfo> getErrorReports(
      {Duration duration = const Duration(hours: 1)}) {
    final cutoff = DateTime.now().subtract(duration);
    return _errors.where((error) => error.timestamp.isAfter(cutoff)).toList();
  }

  @override
  void setEnabled(bool enabled) {
    _isEnabled = enabled;

    if (enabled) {
      startMonitoring();
    } else {
      stopMonitoring();
    }

    if (kDebugMode) {
      debugPrint('Monitoring service ${enabled ? 'enabled' : 'disabled'}');
    }
  }

  @override
  bool get isEnabled => _isEnabled;

  @override
  void clearData() {
    _events.clear();
    _performanceMetrics.clear();
    _errors.clear();
    _healthChecks.clear();
    _healthStatus = HealthStatus.unknown;
  }

  @override
  Future<void> dispose() async {
    await stopMonitoring();
    await _eventController.close();
    await _performanceController.close();
    await _errorController.close();
    clearData();
  }

  /// Collect system metrics
  Future<void> _collectMetrics() async {
    final metrics = PerformanceMetrics(
      responseTime: const Duration(milliseconds: 100), // Simulated
      memoryUsage: _getCurrentMemoryUsage(),
      cpuUsage: _getCurrentCpuUsage(),
      frameRate: _getCurrentFrameRate(),
      timestamp: DateTime.now(),
    );

    await recordPerformance(metrics);
  }

  /// Get current memory usage (simulated)
  int _getCurrentMemoryUsage() {
    // In a real implementation, this would use platform-specific APIs
    return 1024 * 1024 * 50; // 50MB placeholder
  }

  /// Get current CPU usage (simulated)
  double _getCurrentCpuUsage() {
    // In a real implementation, this would use platform-specific APIs
    return 0.1; // 10% CPU usage placeholder
  }

  /// Get current frame rate (simulated)
  int _getCurrentFrameRate() {
    // In a real implementation, this would use Flutter's frame timing
    return 60; // 60 FPS placeholder
  }

  /// Update overall health status
  void _updateOverallHealthStatus() {
    if (_healthChecks.isEmpty) {
      _healthStatus = HealthStatus.unknown;
      return;
    }

    final hasUnhealthy =
        _healthChecks.any((check) => check.status == HealthStatus.unhealthy);
    final hasDegraded =
        _healthChecks.any((check) => check.status == HealthStatus.degraded);

    if (hasUnhealthy) {
      _healthStatus = HealthStatus.unhealthy;
    } else if (hasDegraded) {
      _healthStatus = HealthStatus.degraded;
    } else {
      _healthStatus = HealthStatus.healthy;
    }
  }

  /// Stream of monitor events
  Stream<MonitorEvent> get events => _eventController.stream;

  /// Stream of performance metrics
  Stream<PerformanceMetrics> get performanceMetrics =>
      _performanceController.stream;

  /// Stream of error reports
  Stream<ErrorInfo> get errorReports => _errorController.stream;
}

/// Monitoring utilities
class MonitoringUtils {
  static final MonitoringService _service = DefaultMonitoringService.instance;

  /// Record performance metric
  static Future<void> recordPerformance(String name, Duration duration,
      {Map<String, dynamic>? metadata}) async {
    final metrics = PerformanceMetrics(
      responseTime: duration,
      memoryUsage: 0, // Placeholder
      cpuUsage: 0.0, // Placeholder
      frameRate: 0, // Placeholder
      timestamp: DateTime.now(),
    );

    await _service.recordPerformance(metrics);
  }

  /// Record error with context
  static Future<void> recordError(
    String error, {
    StackTrace? stackTrace,
    String? context,
    ErrorSeverity severity = ErrorSeverity.medium,
    Map<String, dynamic>? metadata,
  }) async {
    final errorInfo = ErrorInfo(
      error: error,
      stackTrace: stackTrace,
      context: context,
      metadata: metadata,
      timestamp: DateTime.now(),
      severity: severity,
    );

    await _service.recordError(errorInfo);
  }

  /// Record exception
  static Future<void> recordException(
    Object exception,
    StackTrace stackTrace, {
    String? context,
    Map<String, dynamic>? metadata,
  }) async {
    await recordError(
      exception.toString(),
      stackTrace: stackTrace,
      context: context,
      severity: ErrorSeverity.high,
      metadata: metadata,
    );
  }

  /// Create and start a performance monitor
  static PerformanceMonitor startPerformanceMonitor(String name,
      {Map<String, dynamic>? metadata}) {
    return PerformanceMonitor(name, metadata: metadata);
  }

  /// Check if service is healthy
  static Future<HealthCheckResult> checkHealth(
      String name, Future<bool> Function() check) async {
    return await _service.performHealthCheck(name, check);
  }
}

/// Performance monitor for measuring execution time
class PerformanceMonitor {
  PerformanceMonitor(this.name, {this.metadata}) : _stopwatch = Stopwatch();

  final String name;
  final Map<String, dynamic>? metadata;
  final Stopwatch _stopwatch;

  /// Start the monitor
  void start() {
    _stopwatch.start();
  }

  /// Stop the monitor and record the performance
  Duration stop() {
    _stopwatch.stop();
    final duration = _stopwatch.elapsed;
    MonitoringUtils.recordPerformance(name, duration, metadata: metadata);
    return duration;
  }

  /// Get current elapsed time
  Duration get elapsed => _stopwatch.elapsed;

  /// Check if monitor is running
  bool get isRunning => _stopwatch.isRunning;
}
