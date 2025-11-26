/// UI Component Repository Implementation
///
/// Provides implementation for UI component repository interface.

import 'dart:async';
import 'package:zephyr_ui/src/core/event_bus.dart';
import '../../domain/entities/ui_component_entity.dart';
import '../../domain/repositories/ui_component_repository.dart';

class UIComponentRepositoryImpl implements UIComponentRepository {
  final Map<String, UIComponentEntity> _components = {};

  @override
  Future<UIComponentEntity?> findById(String id) async {
    return _components[id];
  }

  @override
  Future<List<UIComponentEntity>> findAll() async {
    return _components.values.toList();
  }

  @override
  Future<List<UIComponentEntity>> findByType(String type) async {
    return _components.values.where((c) => c.componentType == type).toList();
  }

  @override
  Future<void> save(UIComponentEntity component) async {
    _components[component.id.value] = component;

    ZephyrEventBus().publish(ZephyrComponentLifecycleEvent(
      componentType: component.componentType,
      componentId: component.id.value,
      lifecyclePhase: 'saved',
      metadata: {'componentName': component.name},
    ));
  }

  @override
  Future<void> delete(String id) async {
    final component = _components.remove(id);
    if (component != null) {
      ZephyrEventBus().publish(ZephyrComponentLifecycleEvent(
        componentType: component.componentType,
        componentId: component.id.value,
        lifecyclePhase: 'deleted',
        metadata: {'componentName': component.name},
      ));
    }
  }

  @override
  Future<bool> exists(String id) async {
    return _components.containsKey(id);
  }

  @override
  Future<int> count() async {
    return _components.length;
  }
}
