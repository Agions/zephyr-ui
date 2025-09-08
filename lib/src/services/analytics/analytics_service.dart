/// chromaUI Analytics Service
///
/// Comprehensive analytics service for tracking user interactions:
/// - Event tracking
/// - User behavior analysis
/// - Performance metrics
/// - Error tracking
/// - Custom analytics
library analytics_service;

import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'dart:async';
import '../../core/config/app_config.dart';
import '../../core/config/environment_config.dart';
import '../../core/config/feature_flags.dart';

/// Analytics event types
enum AnalyticsEventType {
  screenView,
  userAction,
  performance,
  error,
  custom,
}

/// Analytics event data class
class AnalyticsEvent {
  final String name;
  final AnalyticsEventType type;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;
  final String? userId;
  final String? sessionId;

  AnalyticsEvent({
    required this.name,
    required this.type,
    this.parameters = const {},
    DateTime? timestamp,
    this.userId,
    this.sessionId,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Create a copy of this event with updated values
  AnalyticsEvent copyWith({
    String? name,
    AnalyticsEventType? type,
    Map<String, dynamic>? parameters,
    DateTime? timestamp,
    String? userId,
    String? sessionId,
  }) {
    return AnalyticsEvent(
      name: name ?? this.name,
      type: type ?? this.type,
      parameters: parameters ?? this.parameters,
      timestamp: timestamp ?? this.timestamp,
      userId: userId ?? this.userId,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.name,
      'parameters': parameters,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
      'sessionId': sessionId,
    };
  }
}

/// Analytics service interface
abstract class AnalyticsService {
  /// Initialize the analytics service
  Future<void> initialize();

  /// Track an analytics event
  Future<void> trackEvent(AnalyticsEvent event);

  /// Track screen view
  Future<void> trackScreenView(String screenName, {Map<String, dynamic>? parameters});

  /// Track user action
  Future<void> trackUserAction(String action, {Map<String, dynamic>? parameters});

  /// Track performance metric
  Future<void> trackPerformance(String metric, double value, {Map<String, dynamic>? parameters});

  /// Track error
  Future<void> trackError(String error, StackTrace? stackTrace, {Map<String, dynamic>? parameters});

  /// Set user ID
  Future<void> setUserId(String? userId);

  /// Set user properties
  Future<void> setUserProperties(Map<String, dynamic> properties);

  /// Set session ID
  Future<void> setSessionId(String sessionId);

  /// Enable/disable analytics
  Future<void> setEnabled(bool enabled);

  /// Check if analytics is enabled
  bool get isEnabled;

  /// Get current user ID
  String? get userId;

  /// Get current session ID
  String? get sessionId;

  /// Dispose of resources
  Future<void> dispose();
}

/// Default analytics service implementation
class DefaultAnalyticsService implements AnalyticsService {
  DefaultAnalyticsService._internal();

  static DefaultAnalyticsService? _instance;
  static DefaultAnalyticsService get instance => _instance ??= DefaultAnalyticsService._internal();

  final List<AnalyticsEvent> _events = [];
  final StreamController<AnalyticsEvent> _eventController = StreamController.broadcast();
  bool _isEnabled = false;
  String? _userId;
  String? _sessionId;
  Timer? _batchTimer;

  @override
  Future<void> initialize() async {
    if (!featureFlags.isEnabled('analytics')) {
      if (kDebugMode) {
        debugPrint('Analytics service disabled by feature flag');
      }
      return;
    }

    _isEnabled = appConfig.enableAnalytics && environmentConfig.isAnalyticsEnabled;

    if (_isEnabled) {
      _sessionId = _generateSessionId();
      _startBatchTimer();

      if (kDebugMode) {
        debugPrint('Analytics service initialized with session ID: $_sessionId');
      }
    }
  }

  @override
  Future<void> trackEvent(AnalyticsEvent event) async {
    if (!_isEnabled) return;

    final enrichedEvent = event.copyWith(
      userId: _userId,
      sessionId: _sessionId,
    );

    _events.add(enrichedEvent);
    _eventController.add(enrichedEvent);

    if (kDebugMode) {
      debugPrint('Analytics event tracked: ${enrichedEvent.name}');
    }
  }

  @override
  Future<void> trackScreenView(String screenName, {Map<String, dynamic>? parameters}) async {
    await trackEvent(AnalyticsEvent(
      name: 'screen_view',
      type: AnalyticsEventType.screenView,
      parameters: {
        'screen_name': screenName,
        ...?parameters,
      },
    ));
  }

  @override
  Future<void> trackUserAction(String action, {Map<String, dynamic>? parameters}) async {
    await trackEvent(AnalyticsEvent(
      name: 'user_action',
      type: AnalyticsEventType.userAction,
      parameters: {
        'action': action,
        ...?parameters,
      },
    ));
  }

  @override
  Future<void> trackPerformance(String metric, double value, {Map<String, dynamic>? parameters}) async {
    await trackEvent(AnalyticsEvent(
      name: 'performance',
      type: AnalyticsEventType.performance,
      parameters: {
        'metric': metric,
        'value': value,
        ...?parameters,
      },
    ));
  }

  @override
  Future<void> trackError(String error, StackTrace? stackTrace, {Map<String, dynamic>? parameters}) async {
    await trackEvent(AnalyticsEvent(
      name: 'error',
      type: AnalyticsEventType.error,
      parameters: {
        'error': error,
        'stack_trace': stackTrace?.toString(),
        ...?parameters,
      },
    ));
  }

  @override
  Future<void> setUserId(String? userId) async {
    _userId = userId;
    if (kDebugMode) {
      debugPrint('Analytics user ID set to: $userId');
    }
  }

  @override
  Future<void> setUserProperties(Map<String, dynamic> properties) async {
    await trackEvent(AnalyticsEvent(
      name: 'user_properties',
      type: AnalyticsEventType.custom,
      parameters: properties,
    ));
  }

  @override
  Future<void> setSessionId(String sessionId) async {
    _sessionId = sessionId;
    if (kDebugMode) {
      debugPrint('Analytics session ID set to: $sessionId');
    }
  }

  @override
  Future<void> setEnabled(bool enabled) async {
    _isEnabled = enabled;
    if (enabled) {
      _startBatchTimer();
    } else {
      _stopBatchTimer();
    }

    if (kDebugMode) {
      debugPrint('Analytics service ${enabled ? 'enabled' : 'disabled'}');
    }
  }

  @override
  bool get isEnabled => _isEnabled;

  @override
  String? get userId => _userId;

  @override
  String? get sessionId => _sessionId;

  @override
  Future<void> dispose() async {
    _stopBatchTimer();
    await _eventController.close();
  }

  /// Stream of analytics events
  Stream<AnalyticsEvent> get events => _eventController.stream;

  /// Get all tracked events
  List<AnalyticsEvent> getAllEvents() {
    return List.from(_events);
  }

  /// Clear all events
  void clearEvents() {
    _events.clear();
  }

  /// Get events by type
  List<AnalyticsEvent> getEventsByType(AnalyticsEventType type) {
    return _events.where((event) => event.type == type).toList();
  }

  /// Get events by name
  List<AnalyticsEvent> getEventsByName(String name) {
    return _events.where((event) => event.name == name).toList();
  }

  /// Get events in date range
  List<AnalyticsEvent> getEventsInDateRange(DateTime start, DateTime end) {
    return _events.where((event) =>
      event.timestamp.isAfter(start) && event.timestamp.isBefore(end)
    ).toList();
  }

  /// Start batch timer for periodic processing
  void _startBatchTimer() {
    _batchTimer?.cancel();
    _batchTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _processBatch();
    });
  }

  /// Stop batch timer
  void _stopBatchTimer() {
    _batchTimer?.cancel();
    _batchTimer = null;
  }

  /// Process batch of events
  void _processBatch() {
    if (_events.isEmpty) return;

    // In a real implementation, this would send events to a backend
    if (kDebugMode) {
      debugPrint('Processing batch of ${_events.length} analytics events');
    }

    // Clear processed events
    _events.clear();
  }

  /// Generate session ID
  String _generateSessionId() {
    return 'session_${DateTime.now().millisecondsSinceEpoch}_${_generateRandomString(8)}';
  }

  /// Generate random string
  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = math.Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
}

/// Analytics helper class
class AnalyticsHelper {
  static final AnalyticsService _service = DefaultAnalyticsService.instance;

  /// Track button click
  static Future<void> trackButtonClick(String buttonName, {Map<String, dynamic>? parameters}) async {
    await _service.trackUserAction('button_click', parameters: {
      'button_name': buttonName,
      ...?parameters,
    });
  }

  /// Track form submission
  static Future<void> trackFormSubmission(String formName, {Map<String, dynamic>? parameters}) async {
    await _service.trackUserAction('form_submission', parameters: {
      'form_name': formName,
      ...?parameters,
    });
  }

  /// Track navigation
  static Future<void> trackNavigation(String fromScreen, String toScreen, {Map<String, dynamic>? parameters}) async {
    await _service.trackUserAction('navigation', parameters: {
      'from_screen': fromScreen,
      'to_screen': toScreen,
      ...?parameters,
    });
  }

  /// Track search
  static Future<void> trackSearch(String query, int resultCount, {Map<String, dynamic>? parameters}) async {
    await _service.trackUserAction('search', parameters: {
      'query': query,
      'result_count': resultCount,
      ...?parameters,
    });
  }

  /// Track purchase
  static Future<void> trackPurchase(String productId, double amount, {Map<String, dynamic>? parameters}) async {
    await _service.trackUserAction('purchase', parameters: {
      'product_id': productId,
      'amount': amount,
      ...?parameters,
    });
  }

  /// Track app launch
  static Future<void> trackAppLaunch({Map<String, dynamic>? parameters}) async {
    await _service.trackEvent(AnalyticsEvent(
      name: 'app_launch',
      type: AnalyticsEventType.custom,
      parameters: parameters ?? {},
    ));
  }

  /// Track app background
  static Future<void> trackAppBackground({Map<String, dynamic>? parameters}) async {
    await _service.trackEvent(AnalyticsEvent(
      name: 'app_background',
      type: AnalyticsEventType.custom,
      parameters: parameters ?? {},
    ));
  }

  /// Track app foreground
  static Future<void> trackAppForeground({Map<String, dynamic>? parameters}) async {
    await _service.trackEvent(AnalyticsEvent(
      name: 'app_foreground',
      type: AnalyticsEventType.custom,
      parameters: parameters ?? {},
    ));
  }

  /// Track feature usage
  static Future<void> trackFeatureUsage(String featureName, {Map<String, dynamic>? parameters}) async {
    await _service.trackUserAction('feature_usage', parameters: {
      'feature_name': featureName,
      ...?parameters,
    });
  }

  /// Track error with context
  static Future<void> trackErrorWithContext(String error, {
    StackTrace? stackTrace,
    String? screen,
    String? action,
    Map<String, dynamic>? parameters,
  }) async {
    await _service.trackError(error, stackTrace, parameters: {
      'screen': screen,
      'action': action,
      ...?parameters,
    });
  }

  /// Track performance metric with context
  static Future<void> trackPerformanceWithContext(String metric, double value, {
    String? screen,
    String? action,
    Map<String, dynamic>? parameters,
  }) async {
    await _service.trackPerformance(metric, value, parameters: {
      'screen': screen,
      'action': action,
      ...?parameters,
    });
  }
}
