/// chromaUI Feature Flags
///
/// Manages feature flags for enabling/disabling features:
/// - Remote configuration support
/// - A/B testing support
/// - Progressive feature rollout
/// - Environment-specific features
/// - User-specific features
library feature_flags;

import 'package:flutter/foundation.dart';
import 'environment_config.dart';

/// Feature flag categories
enum FeatureCategory {
  ui,
  performance,
  analytics,
  security,
  experimental,
}

/// Feature flag status
enum FeatureStatus {
  disabled,
  enabled,
  limited,
  beta,
}

/// Feature flag metadata
class FeatureFlag {
  final String name;
  final String description;
  final FeatureCategory category;
  final FeatureStatus status;
  final bool isRemote;
  final DateTime? lastUpdated;
  final Map<String, dynamic> metadata;

  const FeatureFlag({
    required this.name,
    required this.description,
    required this.category,
    required this.status,
    this.isRemote = false,
    this.lastUpdated,
    this.metadata = const {},
  });

  bool get isEnabled => status == FeatureStatus.enabled || status == FeatureStatus.beta;

  bool get isDisabled => status == FeatureStatus.disabled;

  bool get isLimited => status == FeatureStatus.limited;

  bool get isBeta => status == FeatureStatus.beta;

  FeatureFlag copyWith({
    String? name,
    String? description,
    FeatureCategory? category,
    FeatureStatus? status,
    bool? isRemote,
    DateTime? lastUpdated,
    Map<String, dynamic>? metadata,
  }) {
    return FeatureFlag(
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      isRemote: isRemote ?? this.isRemote,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// Feature flags manager
class FeatureFlags {
  static FeatureFlags? _instance;
  static FeatureFlags get instance => _instance ??= FeatureFlags._internal();

  final Map<String, FeatureFlag> _flags = {};
  final Map<String, dynamic> _remoteConfig = {};

  FeatureFlags._internal();

  /// Initialize feature flags
  void initialize() {
    _registerDefaultFlags();
    if (kDebugMode) {
      debugPrint('Feature flags initialized with ${_flags.length} flags');
    }
  }

  /// Register default feature flags
  void _registerDefaultFlags() {
    // UI Features
    _registerFlag(FeatureFlag(
      name: 'enhanced_animations',
      description: 'Enhanced animations and transitions',
      category: FeatureCategory.ui,
      status: FeatureStatus.enabled,
    ));

    _registerFlag(FeatureFlag(
      name: 'dark_mode',
      description: 'Dark mode support',
      category: FeatureCategory.ui,
      status: FeatureStatus.enabled,
    ));

    _registerFlag(FeatureFlag(
      name: 'responsive_design',
      description: 'Responsive design system',
      category: FeatureCategory.ui,
      status: FeatureStatus.enabled,
    ));

    _registerFlag(FeatureFlag(
      name: 'material_you',
      description: 'Material You design system',
      category: FeatureCategory.ui,
      status: FeatureStatus.beta,
    ));

    // Performance Features
    _registerFlag(FeatureFlag(
      name: 'performance_monitoring',
      description: 'Performance monitoring and optimization',
      category: FeatureCategory.performance,
      status: FeatureStatus.enabled,
    ));

    _registerFlag(FeatureFlag(
      name: 'lazy_loading',
      description: 'Lazy loading of components',
      category: FeatureCategory.performance,
      status: FeatureStatus.enabled,
    ));

    _registerFlag(FeatureFlag(
      name: 'memory_optimization',
      description: 'Memory optimization features',
      category: FeatureCategory.performance,
      status: FeatureStatus.enabled,
    ));

    _registerFlag(FeatureFlag(
      name: 'caching',
      description: 'Advanced caching system',
      category: FeatureCategory.performance,
      status: FeatureStatus.enabled,
    ));

    // Analytics Features
    _registerFlag(FeatureFlag(
      name: 'analytics',
      description: 'Analytics and user tracking',
      category: FeatureCategory.analytics,
      status: FeatureStatus.limited,
    ));

    _registerFlag(FeatureFlag(
      name: 'crash_reporting',
      description: 'Crash reporting and error tracking',
      category: FeatureCategory.analytics,
      status: FeatureStatus.limited,
    ));

    // Security Features
    _registerFlag(FeatureFlag(
      name: 'encryption',
      description: 'Data encryption features',
      category: FeatureCategory.security,
      status: FeatureStatus.enabled,
    ));

    _registerFlag(FeatureFlag(
      name: 'biometric_auth',
      description: 'Biometric authentication',
      category: FeatureCategory.security,
      status: FeatureStatus.beta,
    ));

    // Experimental Features
    _registerFlag(FeatureFlag(
      name: 'experimental_components',
      description: 'Experimental components',
      category: FeatureCategory.experimental,
      status: FeatureStatus.disabled,
    ));

    _registerFlag(FeatureFlag(
      name: 'ai_features',
      description: 'AI-powered features',
      category: FeatureCategory.experimental,
      status: FeatureStatus.disabled,
    ));
  }

  /// Register a feature flag
  void _registerFlag(FeatureFlag flag) {
    _flags[flag.name] = flag;
  }

  /// Check if a feature is enabled
  bool isEnabled(String featureName) {
    final flag = _flags[featureName];
    if (flag == null) {
      if (kDebugMode) {
        debugPrint('Feature flag not found: $featureName');
      }
      return false;
    }

    // Check remote config override
    if (flag.isRemote && _remoteConfig.containsKey(featureName)) {
      return _remoteConfig[featureName] as bool;
    }

    // Environment-specific overrides
    if (environmentConfig.isDevelopment) {
      return true; // Enable all features in development
    }

    return flag.isEnabled;
  }

  /// Check if a feature is disabled
  bool isDisabled(String featureName) {
    return !isEnabled(featureName);
  }

  /// Check if a feature is in beta
  bool isBeta(String featureName) {
    final flag = _flags[featureName];
    return flag?.isBeta ?? false;
  }

  /// Check if a feature is limited
  bool isLimited(String featureName) {
    final flag = _flags[featureName];
    return flag?.isLimited ?? false;
  }

  /// Get feature flag
  FeatureFlag? getFlag(String featureName) {
    return _flags[featureName];
  }

  /// Get all feature flags
  List<FeatureFlag> getAllFlags() {
    return _flags.values.toList();
  }

  /// Get flags by category
  List<FeatureFlag> getFlagsByCategory(FeatureCategory category) {
    return _flags.values.where((flag) => flag.category == category).toList();
  }

  /// Get enabled flags
  List<FeatureFlag> getEnabledFlags() {
    return _flags.values.where((flag) => isEnabled(flag.name)).toList();
  }

  /// Get disabled flags
  List<FeatureFlag> getDisabledFlags() {
    return _flags.values.where((flag) => isDisabled(flag.name)).toList();
  }

  /// Update feature flag status
  void updateFlagStatus(String featureName, FeatureStatus status) {
    final flag = _flags[featureName];
    if (flag != null) {
      _flags[featureName] = flag.copyWith(
        status: status,
        lastUpdated: DateTime.now(),
      );

      if (kDebugMode) {
        debugPrint('Updated feature flag $featureName to $status');
      }
    }
  }

  /// Update remote configuration
  void updateRemoteConfig(Map<String, dynamic> config) {
    _remoteConfig.clear();
    _remoteConfig.addAll(config);

    if (kDebugMode) {
      debugPrint('Updated remote configuration with ${config.length} values');
    }
  }

  /// Reset to default flags
  void reset() {
    _flags.clear();
    _remoteConfig.clear();
    _registerDefaultFlags();

    if (kDebugMode) {
      debugPrint('Feature flags reset to defaults');
    }
  }

  /// Get feature flag statistics
  Map<String, dynamic> getStatistics() {
    final total = _flags.length;
    final enabled = getEnabledFlags().length;
    final disabled = getDisabledFlags().length;
    final beta = _flags.values.where((flag) => flag.isBeta).length;
    final limited = _flags.values.where((flag) => flag.isLimited).length;

    return {
      'total': total,
      'enabled': enabled,
      'disabled': disabled,
      'beta': beta,
      'limited': limited,
      'remote': _remoteConfig.length,
    };
  }
}

/// Global feature flags instance
final featureFlags = FeatureFlags.instance;
