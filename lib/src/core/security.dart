/// ZephyrUI Security Framework
///
/// Comprehensive security implementation for enterprise-grade Flutter applications
/// including input validation, XSS protection, RBAC, and audit logging.

library security_framework;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/core/event_bus.dart';
import 'package:zephyr_ui/src/domain/value_objects/component_id.dart';

/// Security Configuration
class ZephyrSecurityConfig {
  factory ZephyrSecurityConfig() =>
      _instance ??= ZephyrSecurityConfig._internal();

  ZephyrSecurityConfig._internal();
  static ZephyrSecurityConfig? _instance;

  bool _isInitialized = false;

  /// Security settings
  bool enableInputValidation = true;
  bool enableXSSProtection = true;
  bool enableRBAC = true;
  bool enableAuditLogging = true;
  bool enableRateLimiting = true;

  /// Rate limiting settings
  int maxRequestsPerMinute = 60;
  int maxRequestsPerHour = 1000;

  /// Session settings
  Duration sessionTimeout = const Duration(minutes: 30);
  int maxConcurrentSessions = 3;

  /// Initialize security framework
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize security components
    await _initializeInputValidation();
    await _initializeXSSProtection();
    await _initializeRBAC();
    await _initializeAuditLogging();
    await _initializeRateLimiting();

    _isInitialized = true;
  }

  Future<void> _initializeInputValidation() async {
    // Initialize input validation rules
    ZephyrInputValidator.initialize();
  }

  Future<void> _initializeXSSProtection() async {
    // Initialize XSS protection
    ZephyrXSSProtector.initialize();
  }

  Future<void> _initializeRBAC() async {
    // Initialize RBAC system
    ZephyrRBACManager.initialize();
  }

  Future<void> _initializeAuditLogging() async {
    // Initialize audit logging
    ZephyrAuditLogger.initialize();
  }

  Future<void> _initializeRateLimiting() async {
    // Initialize rate limiting
    ZephyrRateLimiter.initialize(
      maxRequestsPerMinute: maxRequestsPerMinute,
      maxRequestsPerHour: maxRequestsPerHour,
    );
  }

  bool get isInitialized => _isInitialized;
}

/// Input Validation System
class ZephyrInputValidator {
  static final Map<String, List<ValidationRule>> _validationRules = {};

  static void initialize() {
    // Register common validation rules
    registerRule('email', _emailValidationRules);
    registerRule('password', _passwordValidationRules);
    registerRule('username', _usernameValidationRules);
    registerRule('component_name', _componentNameValidationRules);
    registerRule('theme_name', _themeNameValidationRules);
  }

  static void registerRule(String fieldName, List<ValidationRule> rules) {
    _validationRules[fieldName] = rules;
  }

  static ValidationResult validate(String fieldName, String value) {
    final rules = _validationRules[fieldName];
    if (rules == null) {
      return ValidationResult.success();
    }

    final errors = <String>[];
    for (final rule in rules) {
      if (!rule.validator(value)) {
        errors.add(rule.errorMessage);
      }
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }

  static ValidationResult validateComponent(Map<String, dynamic> data) {
    final errors = <String>[];

    // Validate component name
    if (data.containsKey('name')) {
      final nameResult = validate('component_name', data['name']);
      if (!nameResult.isValid) {
        errors.addAll(nameResult.errors);
      }
    }

    // Validate component type
    if (data.containsKey('componentType')) {
      final type = data['componentType'] as String?;
      if (type == null || type.isEmpty) {
        errors.add('Component type cannot be empty');
      } else if (!RegExp(r'^[a-z_][a-z0-9_]*$').hasMatch(type)) {
        errors.add('Component type must be lowercase with underscores');
      }
    }

    // Validate theme if present
    if (data.containsKey('theme')) {
      final themeResult = validate('theme_name', data['theme']);
      if (!themeResult.isValid) {
        errors.addAll(themeResult.errors);
      }
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }

  static final List<ValidationRule> _emailValidationRules = [
    ValidationRule(
      validator: (value) => value.isNotEmpty,
      errorMessage: 'Email cannot be empty',
    ),
    ValidationRule(
      validator: (value) =>
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value),
      errorMessage: 'Invalid email format',
    ),
  ];

  static final List<ValidationRule> _passwordValidationRules = [
    ValidationRule(
      validator: (value) => value.length >= 8,
      errorMessage: 'Password must be at least 8 characters',
    ),
    ValidationRule(
      validator: (value) => RegExp(r'[A-Z]').hasMatch(value),
      errorMessage: 'Password must contain at least one uppercase letter',
    ),
    ValidationRule(
      validator: (value) => RegExp(r'[a-z]').hasMatch(value),
      errorMessage: 'Password must contain at least one lowercase letter',
    ),
    ValidationRule(
      validator: (value) => RegExp(r'[0-9]').hasMatch(value),
      errorMessage: 'Password must contain at least one number',
    ),
    ValidationRule(
      validator: (value) => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value),
      errorMessage: 'Password must contain at least one special character',
    ),
  ];

  static final List<ValidationRule> _usernameValidationRules = [
    ValidationRule(
      validator: (value) => value.length >= 3,
      errorMessage: 'Username must be at least 3 characters',
    ),
    ValidationRule(
      validator: (value) => value.length <= 20,
      errorMessage: 'Username must be no more than 20 characters',
    ),
    ValidationRule(
      validator: (value) => RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value),
      errorMessage:
          'Username can only contain letters, numbers, and underscores',
    ),
  ];

  static final List<ValidationRule> _componentNameValidationRules = [
    ValidationRule(
      validator: (value) => value.isNotEmpty,
      errorMessage: 'Component name cannot be empty',
    ),
    ValidationRule(
      validator: (value) => value.length <= 50,
      errorMessage: 'Component name must be no more than 50 characters',
    ),
    ValidationRule(
      validator: (value) => RegExp(r'^[a-zA-Z0-9\s\-_]+$').hasMatch(value),
      errorMessage:
          'Component name can only contain letters, numbers, spaces, hyphens, and underscores',
    ),
  ];

  static final List<ValidationRule> _themeNameValidationRules = [
    ValidationRule(
      validator: (value) => value.isNotEmpty,
      errorMessage: 'Theme name cannot be empty',
    ),
    ValidationRule(
      validator: (value) => value.length <= 30,
      errorMessage: 'Theme name must be no more than 30 characters',
    ),
    ValidationRule(
      validator: (value) => RegExp(r'^[a-zA-Z0-9\s\-_]+$').hasMatch(value),
      errorMessage:
          'Theme name can only contain letters, numbers, spaces, hyphens, and underscores',
    ),
  ];
}

/// Validation Rule
class ValidationRule {
  ValidationRule({
    required this.validator,
    required this.errorMessage,
  });
  final bool Function(String) validator;
  final String errorMessage;
}

/// Validation Result
class ValidationResult {
  ValidationResult.success()
      : isValid = true,
        errors = const [];

  ValidationResult.failure(this.errors) : isValid = false;
  final bool isValid;
  final List<String> errors;

  @override
  String toString() {
    return isValid
        ? 'ValidationResult.success'
        : 'ValidationResult.failure($errors)';
  }
}

/// XSS Protection System
class ZephyrXSSProtector {
  static void initialize() {
    // Initialize XSS protection patterns
  }

  static String sanitize(String input) {
    if (!ZephyrSecurityConfig().enableXSSProtection) {
      return input;
    }

    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('/', '&#x2F;');
  }

  static String sanitizeHtml(String input) {
    if (!ZephyrSecurityConfig().enableXSSProtection) {
      return input;
    }

    // Remove potentially dangerous HTML tags
    final dangerousPatterns = [
      RegExp(r'<script[^>]*>.*?</script>', caseSensitive: false),
      RegExp(r'<iframe[^>]*>.*?</iframe>', caseSensitive: false),
      RegExp(r'<object[^>]*>.*?</object>', caseSensitive: false),
      RegExp(r'<embed[^>]*>.*?</embed>', caseSensitive: false),
      RegExp(r'on\w+\s*=', caseSensitive: false),
      RegExp(r'javascript:', caseSensitive: false),
      RegExp(r'vbscript:', caseSensitive: false),
      RegExp(r'data:', caseSensitive: false),
    ];

    var sanitized = input;
    for (final pattern in dangerousPatterns) {
      sanitized = sanitized.replaceAll(pattern, '');
    }

    return sanitized;
  }

  static bool isSafe(String input) {
    final dangerousPatterns = [
      RegExp(r'<script', caseSensitive: false),
      RegExp(r'javascript:', caseSensitive: false),
      RegExp(r'on\w+\s*=', caseSensitive: false),
      RegExp(r'vbscript:', caseSensitive: false),
    ];

    return !dangerousPatterns.any((pattern) => pattern.hasMatch(input));
  }
}

/// Role-Based Access Control (RBAC)
class ZephyrRBACManager {
  static final Map<String, ZephyrRole> _roles = {};
  static final Map<String, Set<String>> _userRoles = {};

  static void initialize() {
    // Initialize default roles
    registerRole(ZephyrRole.admin);
    registerRole(ZephyrRole.developer);
    registerRole(ZephyrRole.designer);
    registerRole(ZephyrRole.viewer);
  }

  static void registerRole(ZephyrRole role) {
    _roles[role.name] = role;
  }

  static void assignRoleToUser(String userId, String roleName) {
    _userRoles[userId] ??= {};
    _userRoles[userId]!.add(roleName);
  }

  static void removeRoleFromUser(String userId, String roleName) {
    _userRoles[userId]?.remove(roleName);
  }

  static bool hasPermission(String userId, String permission) {
    final userRoles = _userRoles[userId] ?? {};

    for (final roleName in userRoles) {
      final role = _roles[roleName];
      if (role != null && role.permissions.contains(permission)) {
        return true;
      }
    }

    return false;
  }

  static bool hasRole(String userId, String roleName) {
    return _userRoles[userId]?.contains(roleName) ?? false;
  }

  static Set<String> getUserPermissions(String userId) {
    final permissions = <String>{};
    final userRoles = _userRoles[userId] ?? {};

    for (final roleName in userRoles) {
      final role = _roles[roleName];
      if (role != null) {
        permissions.addAll(role.permissions);
      }
    }

    return permissions;
  }
}

/// Role Definition
class ZephyrRole {
  ZephyrRole._({
    required this.name,
    required this.displayName,
    required this.permissions,
  });
  static final admin = ZephyrRole._(
    name: 'admin',
    displayName: 'Administrator',
    permissions: {
      'component.create',
      'component.read',
      'component.update',
      'component.delete',
      'theme.create',
      'theme.read',
      'theme.update',
      'theme.delete',
      'user.create',
      'user.read',
      'user.update',
      'user.delete',
      'system.configure',
    },
  );

  static final developer = ZephyrRole._(
    name: 'developer',
    displayName: 'Developer',
    permissions: {
      'component.create',
      'component.read',
      'component.update',
      'theme.create',
      'theme.read',
      'theme.update',
      'user.read',
    },
  );

  static final designer = ZephyrRole._(
    name: 'designer',
    displayName: 'Designer',
    permissions: {
      'component.read',
      'component.update',
      'theme.create',
      'theme.read',
      'theme.update',
    },
  );

  static final viewer = ZephyrRole._(
    name: 'viewer',
    displayName: 'Viewer',
    permissions: {
      'component.read',
      'theme.read',
    },
  );

  final String name;
  final String displayName;
  final Set<String> permissions;
}

/// Audit Logging System
class ZephyrAuditLogger {
  static final List<AuditLogEntry> _logs = [];
  static const int _maxLogEntries = 10000;

  static void initialize() {
    // Initialize audit logging
  }

  static void log(AuditLogEntry entry) {
    if (!ZephyrSecurityConfig().enableAuditLogging) {
      return;
    }

    _logs.add(entry);

    // Keep only the most recent entries
    if (_logs.length > _maxLogEntries) {
      _logs.removeRange(0, _logs.length - _maxLogEntries);
    }

    // Publish audit event
    ZephyrEventBus().publish(ZephyrSecurityEvent(
      type: 'audit_log',
      action: entry.action,
      userId: entry.userId,
      metadata: {
        'resource': entry.resource,
        'details': entry.details,
        'timestamp': entry.timestamp.toIso8601String(),
      },
    ));
  }

  static List<AuditLogEntry> getLogs({
    String? userId,
    String? action,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    var filteredLogs = List<AuditLogEntry>.from(_logs);

    if (userId != null) {
      filteredLogs = filteredLogs.where((log) => log.userId == userId).toList();
    }

    if (action != null) {
      filteredLogs = filteredLogs.where((log) => log.action == action).toList();
    }

    if (startTime != null) {
      filteredLogs = filteredLogs
          .where((log) => log.timestamp.isAfter(startTime))
          .toList();
    }

    if (endTime != null) {
      filteredLogs =
          filteredLogs.where((log) => log.timestamp.isBefore(endTime)).toList();
    }

    return filteredLogs;
  }

  static void clearLogs() {
    _logs.clear();
  }
}

/// Audit Log Entry
class AuditLogEntry {
  AuditLogEntry({
    required this.userId,
    required this.action,
    required this.resource,
    required this.details,
    this.ipAddress,
    this.userAgent,
  })  : id = ComponentId.generate().value,
        timestamp = DateTime.now();
  final String id;
  final String userId;
  final String action;
  final String resource;
  final Map<String, dynamic> details;
  final DateTime timestamp;
  final String? ipAddress;
  final String? userAgent;
}

/// Rate Limiting System
class ZephyrRateLimiter {
  static final Map<String, List<DateTime>> _requestTimestamps = {};
  static int _maxRequestsPerMinute = 60;
  static int _maxRequestsPerHour = 1000;

  static void initialize({
    int maxRequestsPerMinute = 60,
    int maxRequestsPerHour = 1000,
  }) {
    _maxRequestsPerMinute = maxRequestsPerMinute;
    _maxRequestsPerHour = maxRequestsPerHour;
  }

  static bool isAllowed(String userId) {
    if (!ZephyrSecurityConfig().enableRateLimiting) {
      return true;
    }

    final now = DateTime.now();
    final timestamps = _requestTimestamps[userId] ?? [];

    // Clean up old timestamps
    timestamps.removeWhere(
        (timestamp) => now.difference(timestamp) > const Duration(hours: 1));

    // Check per-minute limit
    final minuteAgo = now.subtract(const Duration(minutes: 1));
    final recentRequests =
        timestamps.where((timestamp) => timestamp.isAfter(minuteAgo)).length;

    if (recentRequests >= _maxRequestsPerMinute) {
      return false;
    }

    // Check per-hour limit
    if (timestamps.length >= _maxRequestsPerHour) {
      return false;
    }

    // Add current request
    timestamps.add(now);
    _requestTimestamps[userId] = timestamps;

    return true;
  }

  static int getRemainingRequests(String userId) {
    final now = DateTime.now();
    final timestamps = _requestTimestamps[userId] ?? [];

    // Clean up old timestamps
    timestamps.removeWhere(
        (timestamp) => now.difference(timestamp) > const Duration(hours: 1));

    final minuteAgo = now.subtract(const Duration(minutes: 1));
    final recentRequests =
        timestamps.where((timestamp) => timestamp.isAfter(minuteAgo)).length;

    return _maxRequestsPerMinute - recentRequests;
  }

  static void resetRateLimit(String userId) {
    _requestTimestamps[userId]?.clear();
  }
}

/// Security Event
class ZephyrSecurityEvent extends ZephyrDomainEvent {
  ZephyrSecurityEvent({
    required this.type,
    required this.action,
    required this.userId,
    required this.metadata,
  });
  final String type;
  final String action;
  final String userId;
  final Map<String, dynamic> metadata;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'action': action,
      'userId': userId,
      'metadata': metadata,
      'timestamp': timestamp.toIso8601String(),
      'eventId': eventId,
    };
  }
}

/// Security Extensions
extension ZephyrSecurityExtensions on BuildContext {
  bool hasPermission(String permission) {
    final userId = _getCurrentUserId();
    return ZephyrRBACManager.hasPermission(userId, permission);
  }

  bool hasRole(String roleName) {
    final userId = _getCurrentUserId();
    return ZephyrRBACManager.hasRole(userId, roleName);
  }

  Set<String> getPermissions() {
    final userId = _getCurrentUserId();
    return ZephyrRBACManager.getUserPermissions(userId);
  }

  void logSecurityEvent({
    required String action,
    required String resource,
    Map<String, dynamic> details = const {},
  }) {
    final userId = _getCurrentUserId();
    ZephyrAuditLogger.log(AuditLogEntry(
      userId: userId,
      action: action,
      resource: resource,
      details: details,
    ));
  }

  String _getCurrentUserId() {
    // In a real app, this would get the current user from authentication
    return 'anonymous';
  }
}

/// Security Widget Wrapper
class ZephyrSecurityWrapper extends StatelessWidget {
  const ZephyrSecurityWrapper({
    required this.requiredPermission,
    required this.child,
    super.key,
    this.fallback,
  });
  final Widget child;
  final String requiredPermission;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    if (context.hasPermission(requiredPermission)) {
      return child;
    }

    return fallback ?? const SizedBox.shrink();
  }
}
