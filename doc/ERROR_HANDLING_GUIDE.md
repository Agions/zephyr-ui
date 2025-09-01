# ZephyrUI 错误处理指南

## 概述

ZephyrUI 提供了完整的错误处理机制，包括错误捕获、处理、恢复和报告。本指南将帮助您了解如何使用和实现错误处理功能。

## 快速开始

### 1. 初始化错误处理器

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化错误处理器
  ZephyrErrorHandler.instance.init(
    ZephyrErrorHandlerConfig(
      defaultStrategy: ZephyrErrorHandlingStrategy.showUserMessage,
      enableLogging: true,
      enableReporting: true,
      enableAutoRecovery: true,
      maxRetryAttempts: 3,
      showDetailedErrorsInDebug: true,
      onError: (error) {
        print('全局错误处理: ${error.message}');
      },
    ),
  );
  
  runApp(MyApp());
}
```

### 2. 基本错误处理

#### 使用错误边界

```dart
ZephyrErrorBoundary(
  config: ZephyrErrorBoundaryConfig(
    strategy: ZephyrErrorHandlingStrategy.showUserMessage,
    enableAutoRecovery: true,
    maxRetryAttempts: 3,
    onError: (error) {
      print('组件错误: ${error.message}');
    },
  ),
  child: YourWidget(),
)
```

#### 安全执行函数

```dart
// 异步安全执行
final result = await ZephyrErrorBoundary.safeExecute(
  () async {
    // 可能抛出异常的异步操作
    return await fetchData();
  },
  componentName: 'DataFetcher',
  context: context,
  onError: (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('数据加载失败')),
    );
  },
);

// 同步安全执行
try {
  ZephyrErrorBoundary.safeExecute(
    () {
      // 可能抛出异常的同步操作
      return processData();
    },
    componentName: 'DataProcessor',
    context: context,
    onError: (error) {
      // 处理错误
    },
  );
} catch (e) {
  // 这里的代码通常不会执行，因为错误已经被处理
}
```

## 错误类型

### 1. 基础错误类型

```dart
// 创建基础错误
final error = ZephyrError(
  code: ZephyrErrorCodes.unknownError,
  message: '发生未知错误',
  details: '错误详细信息',
  level: ZephyrErrorLevel.error,
  isRecoverable: true,
  recoverySuggestion: '请重试操作',
);

// 创建组件错误
final componentError = ZephyrComponentError(
  componentName: 'UserProfile',
  componentType: 'StatefulWidget',
  code: ZephyrErrorCodes.componentInitializationFailed,
  message: '组件初始化失败',
  componentProperties: {
    'userId': '123',
    'theme': 'dark',
  },
);

// 创建网络错误
final networkError = ZephyrNetworkError(
  code: ZephyrErrorCodes.networkError,
  message: '网络连接失败',
  statusCode: 500,
  url: 'https://api.example.com/users',
  method: 'GET',
);

// 创建验证错误
final validationError = ZephyrValidationError(
  code: ZephyrErrorCodes.validationError,
  message: '输入验证失败',
  field: 'email',
  value: 'invalid-email',
  validationRule: 'email_format',
);

// 创建无障碍错误
final accessibilityError = ZephyrAccessibilityError(
  code: ZephyrErrorCodes.missingSemantics,
  message: '缺少语义化标记',
  checkItem: 'semantic_label',
  wcagGuideline: '1.1.1',
  severity: ZephyrAccessibilitySeverity.serious,
);
```

### 2. 错误级别

```dart
// 调试信息
final debugError = ZephyrError(
  code: 'DEBUG_INFO',
  message: '调试信息',
  level: ZephyrErrorLevel.debug,
);

// 信息
final infoError = ZephyrError(
  code: 'INFO_MESSAGE',
  message: '信息消息',
  level: ZephyrErrorLevel.info,
);

// 警告
final warningError = ZephyrError(
  code: 'WARNING_MESSAGE',
  message: '警告消息',
  level: ZephyrErrorLevel.warning,
);

// 错误
final error = ZephyrError(
  code: 'ERROR_MESSAGE',
  message: '错误消息',
  level: ZephyrErrorLevel.error,
);

// 严重错误
final criticalError = ZephyrError(
  code: 'CRITICAL_ERROR',
  message: '严重错误',
  level: ZephyrErrorLevel.critical,
);

// 致命错误
final fatalError = ZephyrError(
  code: 'FATAL_ERROR',
  message: '致命错误',
  level: ZephyrErrorLevel.fatal,
);
```

## 错误处理策略

### 1. 可用策略

```dart
// 仅记录错误
ZephyrErrorHandlingStrategy.logOnly

// 显示用户友好的错误消息
ZephyrErrorHandlingStrategy.showUserMessage

// 显示详细的错误对话框
ZephyrErrorHandlingStrategy.showDetailedDialog

// 尝试自动恢复
ZephyrErrorHandlingStrategy.autoRecover

// 导航到错误页面
ZephyrErrorHandlingStrategy.navigateToErrorPage

// 重启应用
ZephyrErrorHandlingStrategy.restartApp
```

### 2. 策略使用示例

```dart
// 对不同错误类型使用不同策略
void handleError(ZephyrError error, BuildContext context) {
  ZephyrErrorHandlingStrategy strategy;
  
  switch (error.level) {
    case ZephyrErrorLevel.debug:
    case ZephyrErrorLevel.info:
      strategy = ZephyrErrorHandlingStrategy.logOnly;
      break;
    case ZephyrErrorLevel.warning:
      strategy = ZephyrErrorHandlingStrategy.showUserMessage;
      break;
    case ZephyrErrorLevel.error:
      strategy = error.isRecoverable 
          ? ZephyrErrorHandlingStrategy.autoRecover
          : ZephyrErrorHandlingStrategy.showUserMessage;
      break;
    case ZephyrErrorLevel.critical:
      strategy = ZephyrErrorHandlingStrategy.showDetailedDialog;
      break;
    case ZephyrErrorLevel.fatal:
      strategy = ZephyrErrorHandlingStrategy.navigateToErrorPage;
      break;
  }
  
  ZephyrErrorHandler.instance.handleError(
    error,
    context: context,
    strategy: strategy,
  );
}
```

## 组件级错误处理

### 1. 表单验证错误处理

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return ZephyrErrorBoundary(
      config: ZephyrErrorBoundaryConfig(
        strategy: ZephyrErrorHandlingStrategy.showUserMessage,
        onError: (error) {
          setState(() {
            _errorMessage = error.getLocalizedMessage(context);
          });
        },
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '邮箱'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入邮箱';
                }
                if (!value.contains('@')) {
                  return '请输入有效的邮箱地址';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '密码'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入密码';
                }
                if (value.length < 6) {
                  return '密码至少需要6个字符';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('登录'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ZephyrErrorBoundary.safeExecute(
          () async {
            final user = await _loginUser(
              _emailController.text,
              _passwordController.text,
            );
            // 处理登录成功
          },
          componentName: 'LoginForm',
          context: context,
          onError: (error) {
            setState(() {
              _errorMessage = error.getLocalizedMessage(context);
            });
          },
        );
      } catch (e) {
        // 这里通常不会执行，因为错误已经被处理
      }
    }
  }

  Future<User> _loginUser(String email, String password) async {
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));
    
    if (email == 'test@example.com' && password == 'password') {
      return User(name: '测试用户');
    } else {
      throw ZephyrValidationError(
        code: ZephyrErrorCodes.validationError,
        message: '用户名或密码错误',
        field: 'credentials',
        value: '$email:$password',
      );
    }
  }
}
```

### 2. 网络请求错误处理

```dart
class DataService {
  Future<T> fetchData<T>(
    String url, {
    Map<String, dynamic>? params,
    required T Function(Map<String, dynamic>) parser,
  }) async {
    try {
      final response = await ZephyrErrorBoundary.safeExecute(
        () => _makeRequest(url, params),
        componentName: 'DataService',
        onError: (error) {
          // 处理网络错误
          throw error; // 重新抛出以便调用者处理
        },
      );

      return parser(response);
    } on ZephyrNetworkError catch (error) {
      // 处理特定的网络错误
      switch (error.statusCode) {
        case 401:
          throw ZephyrError(
            code: ZephyrErrorCodes.unauthorized,
            message: '未授权访问',
            level: ZephyrErrorLevel.error,
            isRecoverable: false,
          );
        case 404:
          throw ZephyrError(
            code: ZephyrErrorCodes.notFound,
            message: '资源不存在',
            level: ZephyrErrorLevel.error,
            isRecoverable: false,
          );
        case 500:
          throw ZephyrError(
            code: ZephyrErrorCodes.serverError,
            message: '服务器错误',
            level: ZephyrErrorLevel.error,
            isRecoverable: true,
            recoverySuggestion: '请稍后重试',
          );
        default:
          rethrow;
      }
    }
  }

  Future<Map<String, dynamic>> _makeRequest(
    String url,
    Map<String, dynamic>? params,
  ) async {
    // 实际的网络请求实现
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ZephyrNetworkError(
        code: ZephyrErrorCodes.networkError,
        message: '网络请求失败',
        statusCode: response.statusCode,
        url: url,
        method: 'GET',
      );
    }
  }
}
```

### 3. 异步操作错误处理

```dart
class AsyncOperationWidget extends StatefulWidget {
  @override
  _AsyncOperationWidgetState createState() => _AsyncOperationWidgetState();
}

class _AsyncOperationWidgetState extends State<AsyncOperationWidget> {
  bool _isLoading = false;
  String? _errorMessage;
  String? _result;

  Future<void> _performAsyncOperation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _result = null;
    });

    try {
      _result = await ZephyrErrorBoundary.safeExecute(
        () async {
          await Future.delayed(const Duration(seconds: 2));
          
          // 模拟可能失败的操作
          if (DateTime.now().second % 3 == 0) {
            throw ZephyrError(
              code: ZephyrErrorCodes.operationFailed,
              message: '操作失败',
              level: ZephyrErrorLevel.error,
              isRecoverable: true,
              recoverySuggestion: '请重试',
            );
          }
          
          return '操作成功完成';
        },
        componentName: 'AsyncOperation',
        context: context,
        onError: (error) {
          setState(() {
            _errorMessage = error.getLocalizedMessage(context);
          });
        },
      );
    } catch (e) {
      // 错误已经被处理
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isLoading)
          const CircularProgressIndicator()
        else if (_errorMessage != null)
          Text(
            _errorMessage!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          )
        else if (_result != null)
          Text(_result!),
        ElevatedButton(
          onPressed: _isLoading ? null : _performAsyncOperation,
          child: Text(_isLoading ? '处理中...' : '开始操作'),
        ),
      ],
    );
  }
}
```

## 错误恢复机制

### 1. 自动恢复

```dart
class AutoRecoverableWidget extends StatefulWidget {
  @override
  _AutoRecoverableWidgetState createState() => _AutoRecoverableWidgetState();
}

class _AutoRecoverableWidgetState extends State<AutoRecoverableWidget> {
  int _retryCount = 0;
  bool _isRecovering = false;
  String? _data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      _data = await ZephyrErrorBoundary.safeExecute(
        () => _fetchDataWithRetry(),
        componentName: 'AutoRecoverableWidget',
        context: context,
        onError: (error) {
          if (_retryCount < 3) {
            _attemptRecovery(error);
          } else {
            setState(() {
              _data = null;
            });
          }
        },
      );
    } catch (e) {
      // 错误已经被处理
    }
  }

  Future<String> _fetchDataWithRetry() async {
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟偶尔失败
    if (DateTime.now().second % 2 == 0) {
      throw ZephyrError(
        code: ZephyrErrorCodes.networkError,
        message: '网络连接失败',
        level: ZephyrErrorLevel.error,
        isRecoverable: true,
      );
    }
    
    return '数据加载成功';
  }

  Future<void> _attemptRecovery(ZephyrError error) async {
    setState(() {
      _isRecovering = true;
    });

    try {
      // 注册恢复器
      ZephyrErrorHandler.instance.registerRecoverer(
        error.code,
        (error) async {
          _retryCount++;
          await Future.delayed(const Duration(seconds: 2));
          return _fetchDataWithRetry().then((data) {
            setState(() {
              _data = data;
            });
            return null;
          }).catchError((e) {
            return error;
          });
        },
      );

      // 尝试恢复
      await ZephyrErrorHandler.instance.handleError(
        error,
        context: context,
        strategy: ZephyrErrorHandlingStrategy.autoRecover,
      );
    } finally {
      setState(() {
        _isRecovering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isRecovering)
          const Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text('正在恢复...'),
            ],
          )
        else if (_data != null)
          Text(_data!)
        else if (_retryCount >= 3)
          const Text('恢复失败，请手动刷新'),
        ElevatedButton(
          onPressed: _retryCount >= 3 ? null : _loadData,
          child: Text(_retryCount >= 3 ? '重试次数用尽' : '重试'),
        ),
      ],
    );
  }
}
```

### 2. 手动恢复

```dart
class ManualRecoveryWidget extends StatefulWidget {
  @override
  _ManualRecoveryWidgetState createState() => _ManualRecoveryWidgetState();
}

class _ManualRecoveryWidgetState extends State<ManualRecoveryWidget> {
  ZephyrError? _error;
  String? _data;

  Future<void> _loadData() async {
    try {
      _data = await ZephyrErrorBoundary.safeExecute(
        () => _fetchData(),
        componentName: 'ManualRecoveryWidget',
        context: context,
        onError: (error) {
          setState(() {
            _error = error;
            _data = null;
          });
        },
      );
    } catch (e) {
      // 错误已经被处理
    }
  }

  Future<String> _fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟失败
    throw ZephyrError(
      code: ZephyrErrorCodes.networkError,
      message: '网络连接失败',
      level: ZephyrErrorLevel.error,
      isRecoverable: true,
      recoverySuggestion: '检查网络连接后重试',
    );
  }

  void _retry() {
    setState(() {
      _error = null;
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_error != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.error,
                  size: 48,
                ),
                const SizedBox(height: 8),
                Text(
                  _error!.getLocalizedMessage(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (_error!.recoverySuggestion != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!.recoverySuggestion!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _retry,
                  child: const Text('重试'),
                ),
              ],
            ),
          )
        else if (_data != null)
          Text(_data!)
        else
          ElevatedButton(
            onPressed: _loadData,
            child: const Text('加载数据'),
          ),
      ],
    );
  }
}
```

## 错误日志和报告

### 1. 自定义错误日志

```dart
class CustomErrorLogger {
  static void logError(ZephyrError error) {
    // 记录到控制台
    developer.log(
      'Error: ${error.message}',
      name: 'CustomErrorLogger',
      error: error.originalException,
      stackTrace: error.stackTrace,
    );

    // 记录到文件
    _logToFile(error);

    // 发送到错误跟踪服务
    _sendToErrorTrackingService(error);
  }

  static void _logToFile(ZephyrError error) {
    // 实现文件日志记录
    final logEntry = {
      'timestamp': error.timestamp.toIso8601String(),
      'code': error.code,
      'message': error.message,
      'level': error.level.name,
      'stackTrace': error.stackTrace?.toString(),
    };

    // 写入文件逻辑...
  }

  static void _sendToErrorTrackingService(ZephyrError error) {
    // 发送到错误跟踪服务
    // 如 Sentry, Firebase Crashlytics 等
  }
}

// 使用自定义日志记录器
ZephyrErrorHandler.instance.init(
  ZephyrErrorHandlerConfig(
    onError: (error) {
      CustomErrorLogger.logError(error);
    },
  ),
);
```

### 2. 错误报告生成

```dart
class ErrorReportGenerator {
  static Map<String, dynamic> generateReport(List<ZephyrError> errors) {
    final errorCounts = <String, int>{};
    final levelCounts = <ZephyrErrorLevel, int>{};
    
    for (final error in errors) {
      errorCounts[error.code] = (errorCounts[error.code] ?? 0) + 1;
      levelCounts[error.level] = (levelCounts[error.level] ?? 0) + 1;
    }

    return {
      'summary': {
        'totalErrors': errors.length,
        'uniqueErrors': errorCounts.length,
        'generatedAt': DateTime.now().toIso8601String(),
      },
      'errorCounts': errorCounts,
      'levelCounts': levelCounts.map((key, value) => MapEntry(key.name, value)),
      'errors': errors.map((e) => e.toJson()).toList(),
    };
  }

  static String generateHtmlReport(List<ZephyrError> errors) {
    final report = generateReport(errors);
    
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>错误报告</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            .error { margin: 10px 0; padding: 10px; border-left: 4px solid #f44336; }
            .debug { border-left-color: #2196f3; }
            .info { border-left-color: #4caf50; }
            .warning { border-left-color: #ff9800; }
            .error { border-left-color: #f44336; }
            .critical { border-left-color: #9c27b0; }
            .fatal { border-left-color: #795548; }
        </style>
    </head>
    <body>
        <h1>错误报告</h1>
        <p>生成时间: ${report['summary']['generatedAt']}</p>
        <p>总错误数: ${report['summary']['totalErrors']}</p>
        <p>唯一错误数: ${report['summary']['uniqueErrors']}</p>
        
        <h2>错误列表</h2>
        ${errors.map((e) => '''
        <div class="error ${e.level.name}">
            <h3>${e.message}</h3>
            <p><strong>代码:</strong> ${e.code}</p>
            <p><strong>级别:</strong> ${e.level.name}</p>
            <p><strong>时间:</strong> ${e.timestamp.toIso8601String()}</p>
            ${e.details != null ? '<p><strong>详情:</strong> ${e.details}</p>' : ''}
        </div>
        ''').join('')}
    </body>
    </html>
    ''';
  }
}
```

## 测试错误处理

### 1. 单元测试

```dart
void main() {
  group('错误处理测试', () {
    test('应该正确创建错误对象', () {
      final error = ZephyrError(
        code: ZephyrErrorCodes.unknownError,
        message: '测试错误',
        level: ZephyrErrorLevel.error,
      );

      expect(error.code, ZephyrErrorCodes.unknownError);
      expect(error.message, '测试错误');
      expect(error.level, ZephyrErrorLevel.error);
    });

    test('应该正确处理组件错误', () {
      final error = ZephyrComponentError(
        componentName: 'TestComponent',
        code: ZephyrErrorCodes.componentNotFound,
        message: '组件未找到',
      );

      expect(error.componentName, 'TestComponent');
      expect(error.code, ZephyrErrorCodes.componentNotFound);
    });

    test('应该正确处理网络错误', () {
      final error = ZephyrNetworkError(
        code: ZephyrErrorCodes.networkError,
        message: '网络错误',
        statusCode: 500,
        url: 'https://example.com',
      );

      expect(error.statusCode, 500);
      expect(error.url, 'https://example.com');
    });
  });
}
```

### 2. Widget测试

```dart
void main() {
  group('错误边界Widget测试', () {
    testWidgets('应该捕获子组件错误', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrErrorBoundary(
            child: ErrorProneWidget(),
          ),
        ),
      );

      // 触发错误
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // 验证错误被捕获
      expect(find.text('组件加载失败'), findsOneWidget);
    });

    testWidgets('应该支持错误恢复', (WidgetTester tester) async {
      int retryCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrErrorBoundary(
            config: ZephyrErrorBoundaryConfig(
              onRecover: (error) async {
                retryCount++;
                return retryCount < 2;
              },
            ),
            child: ErrorProneWidget(),
          ),
        ),
      );

      // 触发错误
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // 点击重试
      await tester.tap(find.text('重试'));
      await tester.pumpAndSettle();

      expect(retryCount, greaterThan(0));
    });
  });
}
```

## 最佳实践

### 1. 错误预防

```dart
// ✅ 好的做法 - 预防错误
class SafeUserService {
  Future<User?> getUser(String id) async {
    if (id.isEmpty) {
      throw ZephyrValidationError(
        code: ZephyrErrorCodes.invalidArgument,
        message: '用户ID不能为空',
        field: 'id',
      );
    }

    try {
      return await _fetchUserFromApi(id);
    } catch (e) {
      throw ZephyrNetworkError(
        code: ZephyrErrorCodes.networkError,
        message: '获取用户信息失败',
        originalException: e,
      );
    }
  }
}

// ❌ 不好的做法 - 不进行验证
class UnsafeUserService {
  Future<User?> getUser(String id) async {
    return await _fetchUserFromApi(id); // 可能因为空ID而失败
  }
}
```

### 2. 错误处理策略

```dart
// ✅ 好的做法 - 根据错误类型使用不同策略
void handleApiError(ZephyrError error, BuildContext context) {
  switch (error.level) {
    case ZephyrErrorLevel.debug:
    case ZephyrErrorLevel.info:
      // 只记录，不显示给用户
      break;
    case ZephyrErrorLevel.warning:
      // 显示警告
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
      break;
    case ZephyrErrorLevel.error:
      // 显示错误并提供恢复选项
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('错误'),
          content: Text(error.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('确定'),
            ),
          ],
        ),
      );
      break;
    case ZephyrErrorLevel.critical:
    case ZephyrErrorLevel.fatal:
      // 显示错误页面
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZephyrErrorPage(error: error),
        ),
      );
      break;
  }
}

// ❌ 不好的做法 - 所有错误都同样处理
void handleAllErrors(ZephyrError error, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(error.message)),
  );
}
```

### 3. 错误恢复

```dart
// ✅ 好的做法 - 提供有意义的恢复建议
class DataService {
  Future<Data> fetchData() async {
    try {
      return await _fetchFromNetwork();
    } on ZephyrNetworkError catch (error) {
      throw ZephyrError(
        code: error.code,
        message: '无法加载数据',
        level: ZephyrErrorLevel.error,
        isRecoverable: true,
        recoverySuggestion: '请检查网络连接后重试',
        originalException: error,
      );
    }
  }
}

// ❌ 不好的做法 - 不提供恢复信息
class BadDataService {
  Future<Data> fetchData() async {
    try {
      return await _fetchFromNetwork();
    } catch (e) {
      throw ZephyrError(
        code: ZephyrErrorCodes.operationFailed,
        message: '失败',
        level: ZephyrErrorLevel.error,
      );
    }
  }
}
```

## 性能优化

### 1. 避免过度错误处理

```dart
// ✅ 好的做法 - 只在必要时使用错误边界
class OptimizedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 简单的静态内容不需要错误边界
        Text('标题'),
        
        // 可能失败的操作需要错误边界
        ZephyrErrorBoundary(
          child: ComplexAsyncWidget(),
        ),
      ],
    );
  }
}

// ❌ 不好的做法 - 过度使用错误边界
class OverProtectedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrErrorBoundary(
      child: ZephyrErrorBoundary(
        child: ZephyrErrorBoundary(
          child: Text('简单的文本'),
        ),
      ),
    );
  }
}
```

### 2. 延迟错误处理

```dart
// ✅ 好的做法 - 延迟处理非关键错误
class LazyErrorHandler {
  static void logErrorLater(ZephyrError error) {
    // 使用微任务延迟处理
    Future.microtask(() {
      ZephyrErrorHandler.instance.handleError(error);
    });
  }
}

// ❌ 不好的做法 - 同步处理所有错误
class SynchronousErrorHandler {
  static void logErrorNow(ZephyrError error) {
    // 可能阻塞当前操作
    ZephyrErrorHandler.instance.handleError(error);
  }
}
```

## 总结

ZephyrUI 提供了完整的错误处理解决方案，通过合理使用错误边界、错误处理策略和恢复机制，您可以构建健壮的应用程序。记住：

1. **预防胜于治疗** - 在可能的情况下预防错误
2. **优雅降级** - 当错误发生时提供有意义的用户体验
3. **适当恢复** - 为可恢复的错误提供恢复机制
4. **持续监控** - 记录和分析错误以改进应用质量

通过遵循本指南中的最佳实践，您可以创建一个稳定、可靠且用户友好的应用程序。