/// ZephyrUI DDD Architecture - Event Bus System
///
/// Provides a comprehensive event system for domain events and
/// cross-component communication following DDD principles.

library event_bus;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Base class for all domain events
abstract class ZephyrDomainEvent {
  ZephyrDomainEvent()
      : timestamp = DateTime.now(),
        eventId =
            '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecondsSinceEpoch}';
  final DateTime timestamp;
  final String eventId;

  Map<String, dynamic> toJson();
}

/// Event handler for domain events
typedef ZephyrEventHandler<T extends ZephyrDomainEvent> = Future<void> Function(
    T event);

/// Event bus for managing domain events
class ZephyrEventBus {
  factory ZephyrEventBus() => _instance;

  ZephyrEventBus._internal();
  static final ZephyrEventBus _instance = ZephyrEventBus._internal();

  final Map<Type, List<ZephyrEventHandler>> _handlers = {};
  final StreamController<ZephyrDomainEvent> _streamController =
      StreamController<ZephyrDomainEvent>.broadcast();

  /// Subscribe to a specific event type
  void subscribe<T extends ZephyrDomainEvent>(ZephyrEventHandler<T> handler) {
    final type = T;
    if (!_handlers.containsKey(type)) {
      _handlers[type] = [];
    }
    _handlers[type]!.add(handler as ZephyrEventHandler<ZephyrDomainEvent>);
  }

  /// Unsubscribe from a specific event type
  void unsubscribe<T extends ZephyrDomainEvent>(ZephyrEventHandler<T> handler) {
    final type = T;
    if (_handlers.containsKey(type)) {
      _handlers[type]!.remove(handler);
      if (_handlers[type]!.isEmpty) {
        _handlers.remove(type);
      }
    }
  }

  /// Publish an event
  Future<void> publish<T extends ZephyrDomainEvent>(T event) async {
    if (kDebugMode) {
      debugPrint('📢 Publishing event: ${event.runtimeType}');
    }

    // Add to stream for reactive programming
    _streamController.add(event);

    // Notify all handlers
    final type = event.runtimeType;
    if (_handlers.containsKey(type)) {
      final handlers = List<ZephyrEventHandler>.from(_handlers[type]!);
      for (final handler in handlers) {
        try {
          await handler(event);
        } catch (e) {
          if (kDebugMode) {
            debugPrint('❌ Error in event handler: $e');
          }
        }
      }
    }
  }

  /// Get stream of events for reactive programming
  Stream<T> on<T extends ZephyrDomainEvent>() {
    return _streamController.stream.where((event) => event is T).cast<T>();
  }

  /// Clear all subscriptions
  void clear() {
    _handlers.clear();
  }

  /// Dispose the event bus
  void dispose() {
    _streamController.close();
    clear();
  }
}

/// Event subscriber widget for automatic subscription management
class ZephyrEventSubscriber<T extends ZephyrDomainEvent>
    extends StatefulWidget {
  const ZephyrEventSubscriber({
    required this.child,
    required this.onEvent,
    super.key,
  });
  final Widget child;
  final ZephyrEventHandler<T> onEvent;

  @override
  State<ZephyrEventSubscriber<T>> createState() =>
      _ZephyrEventSubscriberState<T>();
}

class _ZephyrEventSubscriberState<T extends ZephyrDomainEvent>
    extends State<ZephyrEventSubscriber<T>> {
  @override
  void initState() {
    super.initState();
    ZephyrEventBus().subscribe<T>(widget.onEvent);
  }

  @override
  void dispose() {
    ZephyrEventBus().unsubscribe<T>(widget.onEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Common domain events for UI components
class ZephyrUIEvent extends ZephyrDomainEvent {
  ZephyrUIEvent({
    required this.componentId,
    required this.eventType,
    this.data = const {},
  });
  final String componentId;
  final String eventType;
  final Map<String, dynamic> data;

  @override
  Map<String, dynamic> toJson() {
    return {
      'componentId': componentId,
      'eventType': eventType,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      'eventId': eventId,
    };
  }
}

/// Theme changed event
class ZephyrThemeChangedEvent extends ZephyrDomainEvent {
  ZephyrThemeChangedEvent({
    required this.themeMode,
    required this.themeData,
  });
  final String themeMode;
  final Map<String, dynamic> themeData;

  @override
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode,
      'themeData': themeData,
      'timestamp': timestamp.toIso8601String(),
      'eventId': eventId,
    };
  }
}

/// Component lifecycle event
class ZephyrComponentLifecycleEvent extends ZephyrDomainEvent {
  ZephyrComponentLifecycleEvent({
    required this.componentType,
    required this.componentId,
    required this.lifecyclePhase,
    this.metadata = const {},
  });
  final String componentType;
  final String componentId;
  final String lifecyclePhase; // 'created', 'mounted', 'updated', 'disposed'
  final Map<String, dynamic> metadata;

  @override
  Map<String, dynamic> toJson() {
    return {
      'componentType': componentType,
      'componentId': componentId,
      'lifecyclePhase': lifecyclePhase,
      'metadata': metadata,
      'timestamp': timestamp.toIso8601String(),
      'eventId': eventId,
    };
  }
}
