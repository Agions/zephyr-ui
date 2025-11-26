/// UI Component Entity
///
/// Represents a UI component in the domain model with unique identity
/// and business logic for component lifecycle and state management.

import 'package:zephyr_ui/src/core/event_bus.dart';
import '../value_objects/component_id.dart';
import '../value_objects/size_value.dart';

class UIComponentEntity {
  UIComponentEntity({
    required this.id,
    required this.componentType,
    required this.name,
    required this.description,
    required this.size,
    this.isEnabled = true,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
  final ComponentId id;
  final String componentType;
  final String name;
  final String description;
  final SizeValue size;
  final bool isEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Create a copy of this entity with modified properties
  UIComponentEntity copyWith({
    ComponentId? id,
    String? componentType,
    String? name,
    String? description,
    SizeValue? size,
    bool? isEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UIComponentEntity(
      id: id ?? this.id,
      componentType: componentType ?? this.componentType,
      name: name ?? this.name,
      description: description ?? this.description,
      size: size ?? this.size,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// Enable the component
  UIComponentEntity enable() {
    if (isEnabled) return this;

    final updatedComponent = copyWith(isEnabled: true);
    ZephyrEventBus().publish(ZephyrComponentLifecycleEvent(
      componentType: componentType,
      componentId: id.value,
      lifecyclePhase: 'enabled',
      metadata: {'previousState': 'disabled'},
    ));

    return updatedComponent;
  }

  /// Disable the component
  UIComponentEntity disable() {
    if (!isEnabled) return this;

    final updatedComponent = copyWith(isEnabled: false);
    ZephyrEventBus().publish(ZephyrComponentLifecycleEvent(
      componentType: componentType,
      componentId: id.value,
      lifecyclePhase: 'disabled',
      metadata: {'previousState': 'enabled'},
    ));

    return updatedComponent;
  }

  /// Resize the component
  UIComponentEntity resize(SizeValue newSize) {
    if (size == newSize) return this;

    final updatedComponent = copyWith(size: newSize);
    ZephyrEventBus().publish(ZephyrUIEvent(
      componentId: id.value,
      eventType: 'resized',
      data: {
        'oldSize': size.value,
        'newSize': newSize.value,
      },
    ));

    return updatedComponent;
  }

  /// Check if the component is valid
  bool isValid() {
    return name.isNotEmpty && componentType.isNotEmpty && size.value > 0;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UIComponentEntity &&
        other.id == id &&
        other.componentType == componentType &&
        other.name == name &&
        other.size == size &&
        other.isEnabled == isEnabled;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        componentType.hashCode ^
        name.hashCode ^
        size.hashCode ^
        isEnabled.hashCode;
  }

  @override
  String toString() {
    return 'UIComponentEntity(id: ${id.value}, type: $componentType, name: $name, size: ${size.value})';
  }
}
