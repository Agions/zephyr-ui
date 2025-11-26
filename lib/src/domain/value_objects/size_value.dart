/// Size Value Object
///
/// Represents a size value with validation and business logic.

class SizeValue {
  SizeValue(this.value) {
    if (value < 0) {
      throw ArgumentError('Size value cannot be negative');
    }
    if (value > 1000) {
      throw ArgumentError('Size value cannot be larger than 1000');
    }
  }
  final double value;

  /// Create a size value with validation
  static SizeValue? fromDouble(double? value) {
    if (value == null || value < 0 || value > 1000) return null;
    return SizeValue(value);
  }

  /// Predefined size constants
  static final SizeValue xs = SizeValue(24);
  static final SizeValue sm = SizeValue(32);
  static final SizeValue md = SizeValue(40);
  static final SizeValue lg = SizeValue(48);
  static final SizeValue xl = SizeValue(56);

  /// Add another size value
  SizeValue operator +(SizeValue other) {
    return SizeValue(value + other.value);
  }

  /// Subtract another size value
  SizeValue operator -(SizeValue other) {
    return SizeValue(value - other.value);
  }

  /// Multiply by a factor
  SizeValue operator *(double factor) {
    return SizeValue(value * factor);
  }

  /// Divide by a factor
  SizeValue operator /(double factor) {
    return SizeValue(value / factor);
  }

  /// Check if this size is smaller than another
  bool operator <(SizeValue other) => value < other.value;

  /// Check if this size is smaller than or equal to another
  bool operator <=(SizeValue other) => value <= other.value;

  /// Check if this size is larger than another
  bool operator >(SizeValue other) => value > other.value;

  /// Check if this size is larger than or equal to another
  bool operator >=(SizeValue other) => value >= other.value;

  /// Get the appropriate size based on constraints
  static SizeValue getResponsiveSize({
    required SizeValue xs,
    required SizeValue sm,
    required SizeValue md,
    required SizeValue lg,
    required SizeValue xl,
    required double screenWidth,
  }) {
    if (screenWidth < 576) return xs;
    if (screenWidth < 768) return sm;
    if (screenWidth < 992) return md;
    if (screenWidth < 1200) return lg;
    return xl;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SizeValue && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();
}
