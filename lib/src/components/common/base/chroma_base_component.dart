import 'package:flutter/material.dart';
import '../interfaces/component_interface.dart';
import '../mixins/lifecycle_mixin.dart';
import '../mixins/service_locator_mixin.dart';

/// Base component class for all chromaUI components
/// Provides common functionality and standardized architecture
abstract class chromaBaseComponent<T extends StatefulWidget>
    extends Widget
    with chromaLifecycleMixin, chromaServiceLocatorMixin
    implements chromaComponentInterface {

  /// Component configuration
  final chromaComponentConfig config;

  /// Component unique identifier
  final String? componentId;

  /// Component theme data
  final ThemeData? theme;

  /// Component builder function
  final Widget Function(BuildContext context, T component) builder;

  const chromaBaseComponent({
    required this.builder,
    this.config = const chromaComponentConfig(),
    this.componentId,
    this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _chromaBaseComponentWrapper<T>(
      component: this as T,
      config: config,
      componentId: componentId,
      theme: theme,
      builder: builder,
    );
  }

  @override
  void onInit() {
    super.onInit();
    _registerServices();
  }

  @override
  void onDispose() {
    super.onDispose();
    _disposeServices();
  }

  @override
  void onUpdate() {
    super.onUpdate();
    _updateServices();
  }

  @override
  String get componentName => runtimeType.toString();

  @override
  Map<String, dynamic> getComponentMetadata() {
    return {
      'componentId': componentId,
      'componentType': componentName,
      'config': config.toJson(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Register component-specific services
  void _registerServices() {
    // Override in subclasses to register services
  }

  /// Dispose component-specific services
  void _disposeServices() {
    // Override in subclasses to dispose services
  }

  /// Update component-specific services
  void _updateServices() {
    // Override in subclasses to update services
  }
}

/// Component configuration class
class chromaComponentConfig {
  /// Whether to enable debug mode
  final bool debugMode;

  /// Whether to enable performance tracking
  final bool enablePerformanceTracking;

  /// Whether to enable analytics
  final bool enableAnalytics;

  /// Whether to enable error reporting
  final bool enableErrorReporting;

  /// Component priority for rendering
  final int priority;

  /// Whether the component is lazy loaded
  final bool lazyLoad;

  /// Component cache duration
  final Duration cacheDuration;

  const chromaComponentConfig({
    this.debugMode = false,
    this.enablePerformanceTracking = true,
    this.enableAnalytics = false,
    this.enableErrorReporting = true,
    this.priority = 0,
    this.lazyLoad = false,
    this.cacheDuration = const Duration(minutes: 5),
  });

  /// Create copy with updated values
  chromaComponentConfig copyWith({
    bool? debugMode,
    bool? enablePerformanceTracking,
    bool? enableAnalytics,
    bool? enableErrorReporting,
    int? priority,
    bool? lazyLoad,
    Duration? cacheDuration,
  }) {
    return chromaComponentConfig(
      debugMode: debugMode ?? this.debugMode,
      enablePerformanceTracking: enablePerformanceTracking ?? this.enablePerformanceTracking,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enableErrorReporting: enableErrorReporting ?? this.enableErrorReporting,
      priority: priority ?? this.priority,
      lazyLoad: lazyLoad ?? this.lazyLoad,
      cacheDuration: cacheDuration ?? this.cacheDuration,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'debugMode': debugMode,
      'enablePerformanceTracking': enablePerformanceTracking,
      'enableAnalytics': enableAnalytics,
      'enableErrorReporting': enableErrorReporting,
      'priority': priority,
      'lazyLoad': lazyLoad,
      'cacheDuration': cacheDuration.inMilliseconds,
    };
  }

  /// Create from JSON
  factory chromaComponentConfig.fromJson(Map<String, dynamic> json) {
    return chromaComponentConfig(
      debugMode: json['debugMode'] ?? false,
      enablePerformanceTracking: json['enablePerformanceTracking'] ?? true,
      enableAnalytics: json['enableAnalytics'] ?? false,
      enableErrorReporting: json['enableErrorReporting'] ?? true,
      priority: json['priority'] ?? 0,
      lazyLoad: json['lazyLoad'] ?? false,
      cacheDuration: Duration(
        milliseconds: json['cacheDuration'] ?? const Duration(minutes: 5).inMilliseconds,
      ),
    );
  }
}

/// Internal wrapper for base components
class _chromaBaseComponentWrapper<T extends StatefulWidget> extends StatefulWidget {
  final T component;
  final chromaComponentConfig config;
  final String? componentId;
  final ThemeData? theme;
  final Widget Function(BuildContext context, T component) builder;

  const _chromaBaseComponentWrapper({
    required this.component,
    required this.config,
    required this.componentId,
    required this.theme,
    required this.builder,
    super.key,
  });

  @override
  State<_chromaBaseComponentWrapper<T>> createState() => _chromaBaseComponentWrapperState<T>();
}

class _chromaBaseComponentWrapperState<T extends StatefulWidget>
    extends State<_chromaBaseComponentWrapper<T>> {
  late final chromaBaseComponent<T> _component;

  @override
  void initState() {
    super.initState();
    _component = widget.component as chromaBaseComponent<T>;
    _component.onInit();
  }

  @override
  void dispose() {
    _component.onDispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_chromaBaseComponentWrapper<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _component.onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    // Apply theme if provided
    Widget child = widget.builder(context, widget.component);

    if (widget.theme != null) {
      child = Theme(
        data: widget.theme!,
        child: child,
      );
    }

    // Performance tracking
    if (widget.config.enablePerformanceTracking) {
      child = _PerformanceTracker(
        componentId: widget.componentId,
        componentName: _component.componentName,
        child: child,
      );
    }

    // Error handling
    if (widget.config.enableErrorReporting) {
      child = _ErrorBoundary(
        componentId: widget.componentId,
        child: child,
      );
    }

    return child;
  }
}

/// Performance tracking widget
class _PerformanceTracker extends StatefulWidget {
  final String? componentId;
  final String componentName;
  final Widget child;

  const _PerformanceTracker({
    required this.componentId,
    required this.componentName,
    required this.child,
    super.key,
  });

  @override
  State<_PerformanceTracker> createState() => _PerformanceTrackerState();
}

class _PerformanceTrackerState extends State<_PerformanceTracker> {
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _logPerformance();
    super.dispose();
  }

  void _logPerformance() {
    // Log performance metrics
    final duration = _stopwatch.elapsedMilliseconds;
    print('[Performance] ${widget.componentName} (${widget.componentId}): ${duration}ms');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Error boundary widget
class _ErrorBoundary extends StatefulWidget {
  final String? componentId;
  final Widget child;

  const _ErrorBoundary({
    required this.componentId,
    required this.child,
    super.key,
  });

  @override
  State<_ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<_ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_error != null) {
        _reportError();
      }
    });
  }

  void _reportError() {
    print('[Error] Component ${widget.componentId}: $_error');
    print('[Stack Trace] $_stackTrace');
  }

  @override
  Widget build(BuildContext context) {
    return ErrorWidget.builder(
      _error ?? FlutterErrorDetails(
        exception: _error ?? Exception('Unknown error'),
        stack: _stackTrace,
      ),
    );
  }
}
