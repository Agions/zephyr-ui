/// chromaUI State Management System
///
/// A comprehensive state management solution that provides:
/// - Reactive state management
/// - Multiple state management patterns
/// - Performance optimization
/// - State persistence
/// - State synchronization
library state_management;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Base state management interface
abstract class chromaStateManager<T> {
  /// Current state value
  T get state;

  /// Stream of state changes
  Stream<T> get stateStream;

  /// Update state
  void updateState(T newState);

  /// Reset state to initial value
  void reset();

  /// Dispose resources
  void dispose();
}

/// Simple reactive state manager
class ReactiveStateManager<T> extends ChangeNotifier implements chromaStateManager<T> {
  T _state;
  final T _initialState;

  ReactiveStateManager(this._initialState) : _state = _initialState;

  @override
  T get state => _state;

  @override
  Stream<T> get stateStream {
    return Stream.fromIterable([_state]);
  }

  @override
  void updateState(T newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }

  @override
  void reset() {
    updateState(_initialState);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// State management with persistence
class PersistentStateManager<T> extends ReactiveStateManager<T> {
  final String storageKey;
  final Future<T?> Function(String key)? loadFunction;
  final Future<void> Function(String key, T value)? saveFunction;

  PersistentStateManager(
    T initialState, {
    required this.storageKey,
    this.loadFunction,
    this.saveFunction,
  }) : super(initialState);

  /// Load persisted state
  Future<void> loadPersistedState() async {
    try {
      final persistedState = await loadFunction?.call(storageKey);
      if (persistedState != null) {
        updateState(persistedState);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to load persisted state: $e');
      }
    }
  }

  /// Save current state
  Future<void> saveState() async {
    try {
      await saveFunction?.call(storageKey, state);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to save state: $e');
      }
    }
  }

  @override
  void updateState(T newState) {
    super.updateState(newState);
    saveState();
  }
}

/// State management with validation
class ValidatedStateManager<T> extends ReactiveStateManager<T> {
  final T Function(T) validator;
  String? _lastError;

  ValidatedStateManager(
    T initialState, {
    required this.validator,
  }) : super(initialState);

  String? get lastError => _lastError;

  bool get isValid => _lastError == null;

  @override
  void updateState(T newState) {
    try {
      final validatedState = validator(newState);
      _lastError = null;
      super.updateState(validatedState);
    } catch (e) {
      _lastError = e.toString();
      if (kDebugMode) {
        debugPrint('State validation failed: $e');
      }
    }
  }
}

/// State management with undo/redo functionality
class UndoRedoStateManager<T> extends ReactiveStateManager<T> {
  final List<T> _history = [];
  final List<T> _redoHistory = [];
  final int maxHistorySize;

  UndoRedoStateManager(
    T initialState, {
    this.maxHistorySize = 50,
  }) : super(initialState);

  bool get canUndo => _history.isNotEmpty;

  bool get canRedo => _redoHistory.isNotEmpty;

  @override
  void updateState(T newState) {
    if (state != newState) {
      _history.add(state);
      if (_history.length > maxHistorySize) {
        _history.removeAt(0);
      }
      _redoHistory.clear();
      super.updateState(newState);
    }
  }

  void undo() {
    if (canUndo) {
      final previousState = _history.removeLast();
      _redoHistory.add(state);
      super.updateState(previousState);
    }
  }

  void redo() {
    if (canRedo) {
      final nextState = _redoHistory.removeLast();
      _history.add(state);
      super.updateState(nextState);
    }
  }

  @override
  void reset() {
    _history.clear();
    _redoHistory.clear();
    super.reset();
  }
}

/// State management widget for Flutter
class StateManagerBuilder<T extends ChangeNotifier> extends StatefulWidget {
  final T stateManager;
  final Widget Function(BuildContext context, T stateManager) builder;
  final Widget? child;

  const StateManagerBuilder({
    super.key,
    required this.stateManager,
    required this.builder,
    this.child,
  });

  @override
  State<StateManagerBuilder<T>> createState() => _StateManagerBuilderState<T>();
}

class _StateManagerBuilderState<T extends ChangeNotifier>
    extends State<StateManagerBuilder<T>> {
  @override
  void initState() {
    super.initState();
    widget.stateManager.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    widget.stateManager.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.stateManager);
  }
}

/// State management provider for dependency injection
class StateManagerProvider {
  static final Map<String, chromaStateManager> _managers = {};

  static void register<T>(String key, chromaStateManager<T> manager) {
    _managers[key] = manager;
  }

  static chromaStateManager<T>? get<T>(String key) {
    return _managers[key] as chromaStateManager<T>?;
  }

  static void unregister(String key) {
    final manager = _managers.remove(key);
    manager?.dispose();
  }

  static void disposeAll() {
    for (final manager in _managers.values) {
      manager.dispose();
    }
    _managers.clear();
  }
}

/// State management utilities
class StateManagementUtils {
  /// Debounce state updates
  static void Function(T) debounce<T>(
    void Function(T) callback, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    Timer? timer;
    return (T value) {
      timer?.cancel();
      timer = Timer(duration, () => callback(value));
    };
  }

  /// Throttle state updates
  static void Function(T) throttle<T>(
    void Function(T) callback, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    Timer? timer;
    return (T value) {
      if (timer == null) {
        callback(value);
        timer = Timer(duration, () => timer = null);
      }
    };
  }
}
