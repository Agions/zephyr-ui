/// ZephyrUI Security Demo
///
/// Demonstrates the comprehensive security framework implementation.

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class ZephyrSecurityDemo extends StatefulWidget {
  const ZephyrSecurityDemo({super.key});

  @override
  State<ZephyrSecurityDemo> createState() => _ZephyrSecurityDemoState();
}

class _ZephyrSecurityDemoState extends State<ZephyrSecurityDemo> {
  final _authService = ZephyrAuthService();
  final _securityConfig = ZephyrSecurityConfig();

  bool _isInitialized = false;
  String _status = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initializeSecurity();
  }

  Future<void> _initializeSecurity() async {
    try {
      await _securityConfig.initialize();
      setState(() {
        _isInitialized = true;
        _status = 'Security Framework Initialized';
      });
    } catch (e) {
      setState(() {
        _status = 'Failed to initialize: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Security Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.security),
            onPressed: _showSecurityStatus,
          ),
        ],
      ),
      body: _isInitialized ? _buildSecurityDemo() : _buildLoading(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(_status),
        ],
      ),
    );
  }

  Widget _buildSecurityDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSecurityStatus(),
          const SizedBox(height: 24),
          _buildInputValidationDemo(),
          const SizedBox(height: 24),
          _buildXSSProtectionDemo(),
          const SizedBox(height: 24),
          _buildRBACDemo(),
          const SizedBox(height: 24),
          _buildAuthenticationDemo(),
          const SizedBox(height: 24),
          _buildSecureStorageDemo(),
          const SizedBox(height: 24),
          _buildRateLimitingDemo(),
          const SizedBox(height: 24),
          _buildAuditLogDemo(),
        ],
      ),
    );
  }

  Widget _buildSecurityStatus() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security Framework Status',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
                '✅ Input Validation: ${_securityConfig.enableInputValidation ? 'Enabled' : 'Disabled'}'),
            Text(
                '✅ XSS Protection: ${_securityConfig.enableXSSProtection ? 'Enabled' : 'Disabled'}'),
            Text(
                '✅ RBAC: ${_securityConfig.enableRBAC ? 'Enabled' : 'Disabled'}'),
            Text(
                '✅ Audit Logging: ${_securityConfig.enableAuditLogging ? 'Enabled' : 'Disabled'}'),
            Text(
                '✅ Rate Limiting: ${_securityConfig.enableRateLimiting ? 'Enabled' : 'Disabled'}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInputValidationDemo() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final usernameController = TextEditingController();

    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Input Validation Demo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter username (3-20 chars, alphanumeric)',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter email address',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText:
                    'Enter password (8+ chars, mixed case, numbers, special chars)',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _validateInputs(
                  username: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
              child: Text('Validate Inputs'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildXSSProtectionDemo() {
    final inputController = TextEditingController();
    String sanitizedOutput = '';

    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'XSS Protection Demo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                labelText: 'Input with potential XSS',
                hintText: 'Try: <script>alert("XSS")</script>',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  sanitizedOutput =
                      ZephyrXSSProtector.sanitize(inputController.text);
                });
              },
              child: Text('Sanitize Input'),
            ),
            if (sanitizedOutput.isNotEmpty) ...[
              SizedBox(height: 16),
              Text(
                'Sanitized Output:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.grey[200],
                child: Text(sanitizedOutput),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRBACDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Role-Based Access Control Demo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            _buildRoleInfo('Admin', ZephyrRole.admin),
            _buildRoleInfo('Developer', ZephyrRole.developer),
            _buildRoleInfo('Designer', ZephyrRole.designer),
            _buildRoleInfo('Viewer', ZephyrRole.viewer),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showPermissionChecker,
              child: Text('Check Permissions'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleInfo(String title, ZephyrRole role) {
    return ExpansionTile(
      title: Text(title),
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Permissions:'),
              SizedBox(height: 4),
              ...role.permissions.map(
                (permission) =>
                    Text('• $permission', style: const TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuthenticationDemo() {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Authentication Demo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter username',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _registerUser(
                        username: usernameController.text,
                        password: passwordController.text,
                      );
                    },
                    child: Text('Register'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _loginUser(
                        username: usernameController.text,
                        password: passwordController.text,
                      );
                    },
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecureStorageDemo() {
    final keyController = TextEditingController();
    final valueController = TextEditingController();
    String? storedValue;

    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Secure Storage Demo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            TextField(
              controller: keyController,
              decoration: InputDecoration(
                labelText: 'Key',
                hintText: 'Enter storage key',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: valueController,
              decoration: InputDecoration(
                labelText: 'Value',
                hintText: 'Enter value to store',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await context.storeSecureData(
                        key: keyController.text,
                        value: valueController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data stored securely')),
                      );
                    },
                    child: Text('Store'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final value =
                          await context.retrieveSecureData(keyController.text);
                      setState(() {
                        storedValue = value;
                      });
                    },
                    child: Text('Retrieve'),
                  ),
                ),
              ],
            ),
            if (storedValue != null) ...[
              SizedBox(height: 16),
              Text(
                'Retrieved Value:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.grey[200],
                child: Text(storedValue!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRateLimitingDemo() {
    final userIdController = TextEditingController();
    int remainingRequests = 0;

    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate Limiting Demo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            Text(
                'Max requests per minute: ${_securityConfig.maxRequestsPerMinute}'),
            Text(
                'Max requests per hour: ${_securityConfig.maxRequestsPerHour}'),
            SizedBox(height: 16),
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                labelText: 'User ID',
                hintText: 'Enter user ID for rate limiting',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final isAllowed =
                          ZephyrRateLimiter.isAllowed(userIdController.text);
                      final remaining = ZephyrRateLimiter.getRemainingRequests(
                          userIdController.text);

                      setState(() {
                        remainingRequests = remaining;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isAllowed
                              ? 'Request allowed'
                              : 'Rate limit exceeded'),
                          backgroundColor:
                              isAllowed ? Colors.green : Colors.red,
                        ),
                      );
                    },
                    child: Text('Make Request'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ZephyrRateLimiter.resetRateLimit(userIdController.text);
                      setState(() {
                        remainingRequests =
                            _securityConfig.maxRequestsPerMinute;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Rate limit reset')),
                      );
                    },
                    child: Text('Reset Limit'),
                  ),
                ),
              ],
            ),
            if (remainingRequests > 0) ...[
              SizedBox(height: 16),
              Text('Remaining requests: $remainingRequests'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAuditLogDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Audit Log Demo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showAuditLogs,
              child: Text('View Audit Logs'),
            ),
          ],
        ),
      ),
    );
  }

  void _validateInputs({
    required String username,
    required String email,
    required String password,
  }) {
    final errors = <String>[];

    final usernameResult = ZephyrInputValidator.validate('username', username);
    if (!usernameResult.isValid) {
      errors.addAll(usernameResult.errors);
    }

    final emailResult = ZephyrInputValidator.validate('email', email);
    if (!emailResult.isValid) {
      errors.addAll(emailResult.errors);
    }

    final passwordResult = ZephyrInputValidator.validate('password', password);
    if (!passwordResult.isValid) {
      errors.addAll(passwordResult.errors);
    }

    if (errors.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All inputs are valid!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Validation errors:\n${errors.join('\n')}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showPermissionChecker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Checker'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Current user permissions:'),
            const SizedBox(height: 8),
            ...context.getPermissions().map(
                  (permission) => Text('• $permission'),
                ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _registerUser({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    try {
      final result = await _authService.register(
        username: username,
        email: '$username@example.com',
        password: password,
        role: 'viewer',
      );

      if (result.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User registered successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${result.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loginUser({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    try {
      final result = await _authService.login(
        username: username,
        password: password,
      );

      if (result.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${result.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSecurityStatus() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Security Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Framework Status: ${_securityConfig.isInitialized ? '✅ Initialized' : '❌ Not Initialized'}'),
            const SizedBox(height: 8),
            Text(
                'Input Validation: ${_securityConfig.enableInputValidation ? '✅ Enabled' : '❌ Disabled'}'),
            Text(
                'XSS Protection: ${_securityConfig.enableXSSProtection ? '✅ Enabled' : '❌ Disabled'}'),
            Text(
                'RBAC: ${_securityConfig.enableRBAC ? '✅ Enabled' : '❌ Disabled'}'),
            Text(
                'Audit Logging: ${_securityConfig.enableAuditLogging ? '✅ Enabled' : '❌ Disabled'}'),
            Text(
                'Rate Limiting: ${_securityConfig.enableRateLimiting ? '✅ Enabled' : '❌ Disabled'}'),
            const SizedBox(height: 8),
            Text(
                'Session Timeout: ${_securityConfig.sessionTimeout.inMinutes} minutes'),
            Text(
                'Max Requests/Minute: ${_securityConfig.maxRequestsPerMinute}'),
            Text('Max Requests/Hour: ${_securityConfig.maxRequestsPerHour}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAuditLogs() {
    final logs = ZephyrAuditLogger.getLogs();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Audit Logs'),
        content: const SizedBox(
          width: double.maxFinite,
          child: logs.isEmpty
              ? Text('No audit logs available')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[logs.length - 1 - index];
                    return ListTile(
                      title: Text(log.action),
                      subtitle: Text('${log.resource} - ${log.timestamp}'),
                      trailing: Text(log.userId),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
