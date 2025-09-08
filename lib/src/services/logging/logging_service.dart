/// chromaUI Logging Service
///
/// Comprehensive logging service for application events:
/// - Structured logging with different levels
/// - Log filtering and formatting
/// - File and console output
/// - Error tracking and reporting
/// - Performance logging
library logging_service;

import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:chroma_ui/src/core/config/app_config.dart';
import 'package:chroma_ui/src/core/config/environment_config.dart';
import 'package:chroma_ui/src/core/config/feature_flags.dart';

/// Log levels
enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  fatal,
}

/// Log entry data class
class LogEntry {
  const LogEntry({
    required this.level,
    required this.message,
    required this.timestamp,
    this.loggerName,
    this.tag,
    this.metadata,
    this.stackTrace,
    this.error,
  });

  final LogLevel level;
  final String message;
  final DateTime timestamp;
  final String? loggerName;
  final String? tag;
  final Map<String, dynamic>? metadata;
  final StackTrace? stackTrace;
  final Object? error;

  /// Convert log entry to JSON
  Map<String, dynamic> toJson() {
    return {
      'level': level.name,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'loggerName': loggerName,
      'tag': tag,
      'metadata': metadata,
      'stackTrace': stackTrace?.toString(),
      'error': error?.toString(),
    };
  }

  /// Convert log entry to readable string
  @override
  String toString() {
    final levelStr = level.name.toUpperCase();
    final timeStr = timestamp.toIso8601String();
    final tagStr = tag != null ? '[$tag] ' : '';
    final loggerStr = loggerName != null ? '[$loggerName] ' : '';
    final errorStr = error != null ? '\nError: $error' : '';
    final stackStr = stackTrace != null ? '\nStackTrace:\n$stackTrace' : '';

    return '$timeStr $levelStr $tagStr$loggerStr$message$errorStr$stackStr';
  }
}

/// Log formatter interface
abstract class LogFormatter {
  String format(LogEntry entry);
}

/// Default log formatter
class DefaultLogFormatter implements LogFormatter {
  const DefaultLogFormatter();

  @override
  String format(LogEntry entry) {
    return entry.toString();
  }
}

/// JSON log formatter
class JsonLogFormatter implements LogFormatter {
  const JsonLogFormatter();

  @override
  String format(LogEntry entry) {
    return entry.toJson().toString();
  }
}

/// Log output interface
abstract class LogOutput {
  Future<void> write(LogEntry entry);
  Future<void> flush();
  Future<void> close();
}

/// Console log output
class ConsoleLogOutput implements LogOutput {
  ConsoleLogOutput({this.formatter = const DefaultLogFormatter()});

  final LogFormatter formatter;

  @override
  Future<void> write(LogEntry entry) async {
    if (kDebugMode) {
      developer.log(formatter.format(entry));
    }
  }

  @override
  Future<void> flush() async {
    // Nothing to flush for console output
  }

  @override
  Future<void> close() async {
    // Nothing to close for console output
  }
}

/// File log output
class FileLogOutput implements LogOutput {
  FileLogOutput({
    required this.logFilePath,
    this.formatter = const DefaultLogFormatter(),
  });

  final String logFilePath;
  final LogFormatter formatter;
  final IOSink? _sink = null;

  @override
  Future<void> write(LogEntry entry) async {
    // In a real implementation, this would write to a file
    // For now, we'll just print to console in debug mode
    if (kDebugMode) {
      developer.log('[FILE] ${formatter.format(entry)}');
    }
  }

  @override
  Future<void> flush() async {
    // In a real implementation, this would flush the file
  }

  @override
  Future<void> close() async {
    // In a real implementation, this would close the file
  }
}

/// Logger interface
abstract class Logger {
  void verbose(String message, {String? tag, Map<String, dynamic>? metadata});
  void debug(String message, {String? tag, Map<String, dynamic>? metadata});
  void info(String message, {String? tag, Map<String, dynamic>? metadata});
  void warning(String message, {String? tag, Map<String, dynamic>? metadata});
  void error(String message,
      {Object? error,
      StackTrace? stackTrace,
      String? tag,
      Map<String, dynamic>? metadata});
  void fatal(String message,
      {Object? error,
      StackTrace? stackTrace,
      String? tag,
      Map<String, dynamic>? metadata});

  void log(LogLevel level, String message,
      {Object? error,
      StackTrace? stackTrace,
      String? tag,
      Map<String, dynamic>? metadata});

  bool isLevelEnabled(LogLevel level);

  /// Set minimum log level
  void setLevel(LogLevel level);
}

/// Default logger implementation
class DefaultLogger implements Logger {
  DefaultLogger(this.name, this._loggingService);

  final String name;
  final LoggingService _loggingService;

  @override
  void verbose(String message, {String? tag, Map<String, dynamic>? metadata}) {
    _loggingService.log(LogLevel.verbose, message,
        loggerName: name, tag: tag, metadata: metadata);
  }

  @override
  void debug(String message, {String? tag, Map<String, dynamic>? metadata}) {
    _loggingService.log(LogLevel.debug, message,
        loggerName: name, tag: tag, metadata: metadata);
  }

  @override
  void info(String message, {String? tag, Map<String, dynamic>? metadata}) {
    _loggingService.log(LogLevel.info, message,
        loggerName: name, tag: tag, metadata: metadata);
  }

  @override
  void warning(String message, {String? tag, Map<String, dynamic>? metadata}) {
    _loggingService.log(LogLevel.warning, message,
        loggerName: name, tag: tag, metadata: metadata);
  }

  @override
  void error(String message,
      {Object? error,
      StackTrace? stackTrace,
      String? tag,
      Map<String, dynamic>? metadata}) {
    _loggingService.log(LogLevel.error, message,
        loggerName: name,
        error: error,
        stackTrace: stackTrace,
        tag: tag,
        metadata: metadata);
  }

  @override
  void fatal(String message,
      {Object? error,
      StackTrace? stackTrace,
      String? tag,
      Map<String, dynamic>? metadata}) {
    _loggingService.log(LogLevel.fatal, message,
        loggerName: name,
        error: error,
        stackTrace: stackTrace,
        tag: tag,
        metadata: metadata);
  }

  @override
  void log(LogLevel level, String message,
      {Object? error,
      StackTrace? stackTrace,
      String? tag,
      Map<String, dynamic>? metadata}) {
    _loggingService.log(level, message,
        loggerName: name,
        error: error,
        stackTrace: stackTrace,
        tag: tag,
        metadata: metadata);
  }

  @override
  bool isLevelEnabled(LogLevel level) {
    return _loggingService.isLevelEnabled(level);
  }

  @override
  void setLevel(LogLevel level) {
    _loggingService.setLevel(level);
  }
}

/// Logging service interface
abstract class LoggingService {
  /// Initialize the logging service
  Future<void> initialize();

  /// Log a message
  void log(
    LogLevel level,
    String message, {
    String? loggerName,
    String? tag,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Create a new logger
  Logger getLogger(String name);

  /// Set minimum log level
  void setLevel(LogLevel level);

  /// Check if log level is enabled
  bool isLevelEnabled(LogLevel level);

  /// Add log output
  void addOutput(LogOutput output);

  /// Remove log output
  void removeOutput(LogOutput output);

  /// Clear all outputs
  void clearOutputs();

  /// Enable/disable logging
  void setEnabled(bool enabled);

  /// Check if logging is enabled
  bool get isEnabled;

  /// Get current log level
  LogLevel get level;

  /// Flush all pending logs
  Future<void> flush();

  /// Close logging service
  Future<void> close();
}

/// Default logging service implementation
class DefaultLoggingService implements LoggingService {
  DefaultLoggingService._internal();

  static DefaultLoggingService? _instance;
  static DefaultLoggingService get instance =>
      _instance ??= DefaultLoggingService._internal();

  final List<LogOutput> _outputs = [];
  LogLevel _level = LogLevel.info;
  bool _isEnabled = true;
  final Map<String, Logger> _loggers = {};

  @override
  Future<void> initialize() async {
    if (!featureFlags.isEnabled('logging')) {
      if (kDebugMode) {
        developer.log('Logging service disabled by feature flag');
      }
      return;
    }

    _isEnabled =
        appConfig.enableAnalytics && environmentConfig.isAnalyticsEnabled;

    if (_isEnabled) {
      // Add default console output
      addOutput(ConsoleLogOutput());

      // Add file output in production
      if (environmentConfig.currentEnvironment == Environment.production) {
        addOutput(FileLogOutput(logFilePath: 'logs/app.log'));
      }

      if (kDebugMode) {
        developer.log('Logging service initialized with level: $_level');
      }
    }
  }

  @override
  void log(
    LogLevel level,
    String message, {
    String? loggerName,
    String? tag,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_isEnabled || !isEnabled(level)) return;

    final entry = LogEntry(
      level: level,
      message: message,
      timestamp: DateTime.now(),
      loggerName: loggerName,
      tag: tag,
      metadata: metadata,
      error: error,
      stackTrace: stackTrace,
    );

    for (final output in _outputs) {
      output.write(entry);
    }
  }

  @override
  Logger getLogger(String name) {
    return _loggers.putIfAbsent(name, () => DefaultLogger(name, this));
  }

  @override
  void setLevel(LogLevel level) {
    _level = level;
    if (kDebugMode) {
      developer.log('Log level set to: $level');
    }
  }

  @override
  bool isLevelEnabled(LogLevel level) {
    return level.index >= _level.index;
  }

  @override
  void addOutput(LogOutput output) {
    _outputs.add(output);
  }

  @override
  void removeOutput(LogOutput output) {
    _outputs.remove(output);
  }

  @override
  void clearOutputs() {
    _outputs.clear();
  }

  @override
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    if (kDebugMode) {
      developer.log('Logging service ${enabled ? 'enabled' : 'disabled'}');
    }
  }

  @override
  bool get isEnabled => _isEnabled;

  @override
  LogLevel get level => _level;

  @override
  Future<void> flush() async {
    for (final output in _outputs) {
      await output.flush();
    }
  }

  @override
  Future<void> close() async {
    await flush();
    for (final output in _outputs) {
      await output.close();
    }
    _outputs.clear();
    _loggers.clear();
  }
}

/// Logging utilities
class LoggingUtils {
  static final LoggingService _service = DefaultLoggingService.instance;

  /// Get root logger
  static Logger get root => _service.getLogger('root');

  /// Get logger for specific class
  static Logger getLogger<T>() {
    return _service.getLogger(T.toString());
  }

  /// Log app lifecycle events
  static void logAppLifecycle(String event, {Map<String, dynamic>? metadata}) {
    root.info('App lifecycle: $event', tag: 'lifecycle', metadata: metadata);
  }

  /// Log performance metrics
  static void logPerformance(String metric, Duration duration,
      {Map<String, dynamic>? metadata}) {
    root.info('Performance: $metric took ${duration.inMilliseconds}ms',
        tag: 'performance',
        metadata: {...?metadata, 'duration_ms': duration.inMilliseconds});
  }

  /// Log network requests
  static void logNetworkRequest(
    String method,
    String url, {
    int? statusCode,
    Duration? duration,
    Map<String, dynamic>? metadata,
  }) {
    final level = (statusCode != null && statusCode >= 400)
        ? LogLevel.warning
        : LogLevel.info;
    root.log(level, 'Network: $method $url - ${statusCode ?? 'pending'}',
        tag: 'network',
        metadata: {
          ...?metadata,
          'method': method,
          'url': url,
          'status_code': statusCode,
          'duration_ms': duration?.inMilliseconds
        });
  }

  /// Log user actions
  static void logUserAction(String action, {Map<String, dynamic>? metadata}) {
    root.info('User action: $action', tag: 'user', metadata: metadata);
  }

  /// Log errors with context
  static void logError(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
    Map<String, dynamic>? metadata,
  }) {
    root.error(message,
        error: error,
        stackTrace: stackTrace,
        tag: tag ?? 'error',
        metadata: metadata);
  }

  /// Log debug information
  static void logDebug(String message,
      {String? tag, Map<String, dynamic>? metadata}) {
    root.debug(message, tag: tag, metadata: metadata);
  }

  /// Create a logging timer
  static LoggingTimer startTimer(String name,
      {Map<String, dynamic>? metadata}) {
    return LoggingTimer(name, metadata: metadata);
  }
}

/// Logging timer for measuring execution time
class LoggingTimer {
  LoggingTimer(this.name, {this.metadata}) : _stopwatch = Stopwatch();

  final String name;
  final Map<String, dynamic>? metadata;
  final Stopwatch _stopwatch;

  /// Start the timer
  void start() {
    _stopwatch.start();
  }

  /// Stop the timer and log the elapsed time
  Duration stop() {
    _stopwatch.stop();
    final duration = _stopwatch.elapsed;
    LoggingUtils.logPerformance(name, duration, metadata: metadata);
    return duration;
  }

  /// Get current elapsed time
  Duration get elapsed => _stopwatch.elapsed;

  /// Check if timer is running
  bool get isRunning => _stopwatch.isRunning;
}
