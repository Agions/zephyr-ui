/// ZephyrUI Authentication & Authorization System
///
/// Comprehensive authentication and authorization middleware for enterprise security.

library auth_middleware;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/core/security.dart';

/// Authentication Service
class ZephyrAuthService {
  factory ZephyrAuthService() => _instance ??= ZephyrAuthService._internal();

  ZephyrAuthService._internal();
  static ZephyrAuthService? _instance;

  final Map<String, ZephyrUser> _users = {};
  final Map<String, String> _sessions = {};
  final Map<String, DateTime> _sessionExpiry = {};

  /// Register a new user
  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
    String? role,
  }) async {
    // Validate input
    final usernameValidation =
        ZephyrInputValidator.validate('username', username);
    if (!usernameValidation.isValid) {
      return AuthResult.failure(usernameValidation.errors.join(', '));
    }

    final emailValidation = ZephyrInputValidator.validate('email', email);
    if (!emailValidation.isValid) {
      return AuthResult.failure(emailValidation.errors.join(', '));
    }

    final passwordValidation =
        ZephyrInputValidator.validate('password', password);
    if (!passwordValidation.isValid) {
      return AuthResult.failure(passwordValidation.errors.join(', '));
    }

    // Check if user already exists
    if (_users.values
        .any((user) => user.username == username || user.email == email)) {
      return AuthResult.failure('User already exists');
    }

    // Create new user
    final user = ZephyrUser(
      id: _generateUserId(),
      username: username,
      email: email,
      passwordHash: _hashPassword(password),
      role: role ?? 'viewer',
      isActive: true,
      createdAt: DateTime.now(),
    );

    _users[user.id] = user;

    // Assign default role
    ZephyrRBACManager.assignRoleToUser(user.id, user.role);

    // Log registration
    ZephyrAuditLogger.log(AuditLogEntry(
      userId: user.id,
      action: 'register',
      resource: 'user',
      details: {'username': username, 'email': email},
    ));

    return AuthResult.success(user);
  }

  /// Login user
  Future<AuthResult> login({
    required String username,
    required String password,
  }) async {
    // Find user by username
    final user = _users.values.firstWhere(
      (u) => u.username == username,
      orElse: () => throw Exception('User not found'),
    );

    // Check if user is active
    if (!user.isActive) {
      return AuthResult.failure('Account is disabled');
    }

    // Verify password
    if (!_verifyPassword(password, user.passwordHash)) {
      // Log failed login attempt
      ZephyrAuditLogger.log(AuditLogEntry(
        userId: user.id,
        action: 'login_failed',
        resource: 'user',
        details: {'reason': 'invalid_password'},
      ));

      return AuthResult.failure('Invalid credentials');
    }

    // Create session
    final sessionId = _generateSessionId();
    _sessions[sessionId] = user.id;
    _sessionExpiry[sessionId] =
        DateTime.now().add(ZephyrSecurityConfig().sessionTimeout);

    // Log successful login
    ZephyrAuditLogger.log(AuditLogEntry(
      userId: user.id,
      action: 'login',
      resource: 'user',
      details: {'session_id': sessionId},
    ));

    return AuthResult.success(user, sessionId: sessionId);
  }

  /// Logout user
  Future<void> logout(String sessionId) async {
    final userId = _sessions[sessionId];
    if (userId != null) {
      _sessions.remove(sessionId);
      _sessionExpiry.remove(sessionId);

      // Log logout
      ZephyrAuditLogger.log(AuditLogEntry(
        userId: userId,
        action: 'logout',
        resource: 'user',
        details: {'session_id': sessionId},
      ));
    }
  }

  /// Get current user from session
  ZephyrUser? getCurrentUser(String sessionId) {
    final userId = _sessions[sessionId];
    if (userId == null) return null;

    // Check session expiry
    final expiryTime = _sessionExpiry[sessionId];
    if (expiryTime != null && DateTime.now().isAfter(expiryTime)) {
      _sessions.remove(sessionId);
      _sessionExpiry.remove(sessionId);
      return null;
    }

    return _users[userId];
  }

  /// Validate session
  bool validateSession(String sessionId) {
    return getCurrentUser(sessionId) != null;
  }

  /// Refresh session
  bool refreshSession(String sessionId) {
    if (_sessions.containsKey(sessionId)) {
      _sessionExpiry[sessionId] =
          DateTime.now().add(ZephyrSecurityConfig().sessionTimeout);
      return true;
    }
    return false;
  }

  /// Change password
  Future<AuthResult> changePassword({
    required String sessionId,
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = getCurrentUser(sessionId);
    if (user == null) {
      return AuthResult.failure('Invalid session');
    }

    // Verify current password
    if (!_verifyPassword(currentPassword, user.passwordHash)) {
      return AuthResult.failure('Current password is incorrect');
    }

    // Validate new password
    final passwordValidation =
        ZephyrInputValidator.validate('password', newPassword);
    if (!passwordValidation.isValid) {
      return AuthResult.failure(passwordValidation.errors.join(', '));
    }

    // Update password
    user.passwordHash = _hashPassword(newPassword);
    _users[user.id] = user;

    // Log password change
    ZephyrAuditLogger.log(AuditLogEntry(
      userId: user.id,
      action: 'change_password',
      resource: 'user',
      details: {},
    ));

    return AuthResult.success(user);
  }

  /// Get all users (admin only)
  List<ZephyrUser> getAllUsers() {
    return _users.values.toList();
  }

  /// Update user role
  Future<bool> updateUserRole(String userId, String newRole) async {
    final user = _users[userId];
    if (user == null) return false;

    // Remove old role
    ZephyrRBACManager.removeRoleFromUser(userId, user.role);

    // Update user
    user.role = newRole;
    _users[userId] = user;

    // Assign new role
    ZephyrRBACManager.assignRoleToUser(userId, newRole);

    // Log role change
    ZephyrAuditLogger.log(AuditLogEntry(
      userId: userId,
      action: 'role_changed',
      resource: 'user',
      details: {'old_role': user.role, 'new_role': newRole},
    ));

    return true;
  }

  String _generateUserId() {
    return 'user_${DateTime.now().millisecondsSinceEpoch}_${_users.length}';
  }

  String _generateSessionId() {
    return 'session_${DateTime.now().millisecondsSinceEpoch}_${_sessions.length}';
  }

  String _hashPassword(String password) {
    // In a real app, use a proper password hashing algorithm like bcrypt
    return password.hashCode.toString();
  }

  bool _verifyPassword(String password, String hash) {
    return _hashPassword(password) == hash;
  }
}

/// User Model
class ZephyrUser {
  ZephyrUser({
    required this.id,
    required this.username,
    required this.email,
    required this.passwordHash,
    required this.role,
    required this.isActive,
    required this.createdAt,
    this.lastLoginAt,
  });
  final String id;
  final String username;
  final String email;
  String passwordHash;
  String role;
  bool isActive;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }
}

/// Authentication Result
class AuthResult {
  AuthResult.success(this.user, {this.sessionId})
      : isSuccess = true,
        error = null;

  AuthResult.failure(this.error)
      : isSuccess = false,
        user = null,
        sessionId = null;
  final bool isSuccess;
  final ZephyrUser? user;
  final String? sessionId;
  final String? error;

  bool get hasError => error != null;
}

/// Authorization Middleware
class ZephyrAuthMiddleware {
  factory ZephyrAuthMiddleware() => _instance;

  ZephyrAuthMiddleware._internal();
  static final ZephyrAuthMiddleware _instance =
      ZephyrAuthMiddleware._internal();

  /// Check if user is authenticated
  bool isAuthenticated(String sessionId) {
    return ZephyrAuthService().validateSession(sessionId);
  }

  /// Check if user has specific permission
  bool hasPermission(String sessionId, String permission) {
    final user = ZephyrAuthService().getCurrentUser(sessionId);
    if (user == null) return false;

    return ZephyrRBACManager.hasPermission(user.id, permission);
  }

  /// Check if user has specific role
  bool hasRole(String sessionId, String role) {
    final user = ZephyrAuthService().getCurrentUser(sessionId);
    if (user == null) return false;

    return ZephyrRBACManager.hasRole(user.id, role);
  }

  /// Require authentication
  Future<AuthResult> requireAuth(String sessionId) async {
    if (!isAuthenticated(sessionId)) {
      return AuthResult.failure('Authentication required');
    }

    final user = ZephyrAuthService().getCurrentUser(sessionId);
    return AuthResult.success(user, sessionId: sessionId);
  }

  /// Require specific permission
  Future<AuthResult> requirePermission(
      String sessionId, String permission) async {
    final authResult = await requireAuth(sessionId);
    if (!authResult.isSuccess) {
      return authResult;
    }

    if (!hasPermission(sessionId, permission)) {
      return AuthResult.failure('Insufficient permissions');
    }

    return authResult;
  }

  /// Require specific role
  Future<AuthResult> requireRole(String sessionId, String role) async {
    final authResult = await requireAuth(sessionId);
    if (!authResult.isSuccess) {
      return authResult;
    }

    if (!hasRole(sessionId, role)) {
      return AuthResult.failure('Insufficient role');
    }

    return authResult;
  }
}

/// Authentication Guard Widget
class ZephyrAuthGuard extends StatefulWidget {
  const ZephyrAuthGuard({
    required this.child,
    super.key,
    this.requiredPermission = '',
    this.fallback,
    this.onUnauthorized,
  });
  final Widget child;
  final String requiredPermission;
  final Widget? fallback;
  final void Function()? onUnauthorized;

  @override
  State<ZephyrAuthGuard> createState() => _ZephyrAuthGuardState();
}

class _ZephyrAuthGuardState extends State<ZephyrAuthGuard> {
  String? _sessionId;
  bool _isAuthenticated = false;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    // In a real app, get session ID from secure storage
    _sessionId = 'demo_session';

    if (_sessionId != null) {
      final middleware = ZephyrAuthMiddleware();

      if (widget.requiredPermission.isEmpty) {
        _isAuthenticated = middleware.isAuthenticated(_sessionId!);
      } else {
        final result = await middleware.requirePermission(
            _sessionId!, widget.requiredPermission);
        _isAuthenticated = result.isSuccess;
        _hasPermission = result.isSuccess;
      }
    }

    if (mounted) {
      setState(() {});

      if (!_isAuthenticated ||
          !(_hasPermission || widget.requiredPermission.isEmpty)) {
        widget.onUnauthorized?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated &&
        (_hasPermission || widget.requiredPermission.isEmpty)) {
      return widget.child;
    }

    return widget.fallback ?? const _UnauthorizedWidget();
  }
}

class _UnauthorizedWidget extends StatelessWidget {
  const _UnauthorizedWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Unauthorized',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'You don\'t have permission to access this resource',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate to login
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Authentication Extensions
extension ZephyrAuthExtensions on BuildContext {
  String? get currentSessionId {
    // In a real app, get session ID from secure storage
    return 'demo_session';
  }

  ZephyrUser? get currentUser {
    final sessionId = currentSessionId;
    if (sessionId == null) return null;
    return ZephyrAuthService().getCurrentUser(sessionId);
  }

  bool get isAuthenticated {
    final sessionId = currentSessionId;
    if (sessionId == null) return false;
    return ZephyrAuthMiddleware().isAuthenticated(sessionId);
  }

  bool hasPermission(String permission) {
    final sessionId = currentSessionId;
    if (sessionId == null) return false;
    return ZephyrAuthMiddleware().hasPermission(sessionId, permission);
  }

  bool hasRole(String role) {
    final sessionId = currentSessionId;
    if (sessionId == null) return false;
    return ZephyrAuthMiddleware().hasRole(sessionId, role);
  }

  Future<AuthResult> requireAuth() async {
    final sessionId = currentSessionId;
    if (sessionId == null) {
      return AuthResult.failure('No active session');
    }
    return ZephyrAuthMiddleware().requireAuth(sessionId);
  }

  Future<AuthResult> requirePermission(String permission) async {
    final sessionId = currentSessionId;
    if (sessionId == null) {
      return AuthResult.failure('No active session');
    }
    return ZephyrAuthMiddleware().requirePermission(sessionId, permission);
  }

  Future<AuthResult> requireRole(String role) async {
    final sessionId = currentSessionId;
    if (sessionId == null) {
      return AuthResult.failure('No active session');
    }
    return ZephyrAuthMiddleware().requireRole(sessionId, role);
  }
}
