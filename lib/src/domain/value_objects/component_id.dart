/// Component ID Value Object
///
/// Represents a unique identifier for UI components with validation logic.

class ComponentId {
  ComponentId(this.value) {
    if (value.isEmpty) {
      throw ArgumentError('Component ID cannot be empty');
    }
    if (value.length > 50) {
      throw ArgumentError('Component ID cannot be longer than 50 characters');
    }
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value)) {
      throw ArgumentError(
          'Component ID can only contain alphanumeric characters, hyphens, and underscores');
    }
  }

  /// Generate a new random component ID
  factory ComponentId.generate() {
    return ComponentId('comp_${DateTime.now().millisecondsSinceEpoch}');
  }
  final String value;

  /// Create a component ID from a string with validation
  static ComponentId? fromString(String? value) {
    if (value == null || value.isEmpty) return null;

    try {
      return ComponentId(value);
    } catch (e) {
      return null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ComponentId && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
