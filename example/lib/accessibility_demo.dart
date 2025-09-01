/// ZephyrUI 无障碍和错误处理演示应用
///
/// 展示完整的无障碍功能和错误处理机制

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

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
        print('全局错误: ${error.message}');
      },
    ),
  );
  
  // 初始化无障碍管理器
  await ZephyrAccessibilityManager.instance.init(
    config: ZephyrAccessibilityManagerConfig(
      enabled: true,
      autoDetectSystemSettings: true,
      enableRealTimeChecking: false,
      defaultConfig: ZephyrAccessibilityConfig(
        enabledFeatures: {
          ZephyrAccessibilityFeature.screenReader,
          ZephyrAccessibilityFeature.keyboardNavigation,
          ZephyrAccessibilityFeature.highContrast,
          ZephyrAccessibilityFeature.reduceMotion,
        },
        textScaleFactor: 1.0,
        minTouchTargetSize: 44.0,
        focusColor: Colors.blue,
        focusBorderWidth: 2.0,
      ),
    ),
  );
  
  runApp(const AccessibilityDemoApp());
}

class AccessibilityDemoApp extends StatelessWidget {
  const AccessibilityDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrUI 无障碍演示',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AccessibilityDemoHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AccessibilityDemoHome extends StatefulWidget {
  const AccessibilityDemoHome({Key? key}) : super(key: key);

  @override
  State<AccessibilityDemoHome> createState() => _AccessibilityDemoHomeState();
}

class _AccessibilityDemoHomeState extends State<AccessibilityDemoHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FormDemoPage(),
    const ErrorHandlingDemoPage(),
    const AccessibilityFeaturesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 无障碍演示'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.text_fields),
            label: '表单',
          ),
          NavigationDestination(
            icon: Icon(Icons.error_outline),
            label: '错误处理',
          ),
          NavigationDestination(
            icon: Icon(Icons.accessibility_new),
            label: '无障碍功能',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
}

/// 表单演示页面
class FormDemoPage extends StatelessWidget {
  const FormDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '无障碍表单演示',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '这些表单组件都支持完整的无障碍功能，包括屏幕阅读器、键盘导航和错误处理。',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // 注册表单
          ZephyrErrorBoundary(
            config: ZephyrErrorBoundaryConfig(
              strategy: ZephyrErrorHandlingStrategy.showUserMessage,
            ),
            child: const RegistrationForm(),
          ),
          
          const SizedBox(height: 32),
          
          // 登录表单
          ZephyrErrorBoundary(
            config: ZephyrErrorBoundaryConfig(
              strategy: ZephyrErrorHandlingStrategy.showUserMessage,
            ),
            child: const LoginForm(),
          ),
        ],
      ),
    );
  }
}

/// 注册表单
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '用户注册',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              // 姓名输入
              ZephyrAccessibleInput(
                labelText: '姓名',
                placeholder: '请输入您的姓名',
                required: true,
                controller: _nameController,
                accessibilityConfig: ZephyrAccessibleInputConfig(
                  semanticLabel: '姓名输入框',
                  semanticHint: '请输入您的真实姓名',
                  enableLiveValidation: true,
                  showCharacterCount: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入姓名';
                  }
                  if (value.length < 2) {
                    return '姓名至少需要2个字符';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // 邮箱输入
              ZephyrAccessibleInput(
                labelText: '邮箱',
                placeholder: '请输入邮箱地址',
                required: true,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                accessibilityConfig: ZephyrAccessibleInputConfig(
                  semanticLabel: '邮箱输入框',
                  semanticHint: '请输入有效的邮箱地址',
                  enableLiveValidation: true,
                ),
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
              
              const SizedBox(height: 16),
              
              // 密码输入
              ZephyrAccessiblePasswordInput(
                labelText: '密码',
                placeholder: '请输入密码',
                required: true,
                controller: _passwordController,
                showPasswordStrength: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  if (value.length < 8) {
                    return '密码至少需要8个字符';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // 确认密码
              ZephyrAccessiblePasswordInput(
                labelText: '确认密码',
                placeholder: '请再次输入密码',
                required: true,
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请确认密码';
                  }
                  if (value != _passwordController.text) {
                    return '两次输入的密码不一致';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // 错误消息
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // 提交按钮
              SizedBox(
                width: double.infinity,
                child: ZephyrAccessibleButton(
                  text: _isLoading ? '注册中...' : '注册',
                  onPressed: _isLoading ? null : _handleSubmit,
                  semanticLabel: '注册账户按钮',
                  hint: '点击提交注册信息',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ZephyrErrorBoundary.safeExecute(
        () async {
          // 模拟网络请求
          await Future.delayed(const Duration(seconds: 2));
          
          // 模拟注册成功
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('注册成功！')),
            );
          }
        },
        componentName: 'RegistrationForm',
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
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

/// 登录表单
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '用户登录',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              // 邮箱输入
              ZephyrAccessibleInput(
                labelText: '邮箱',
                placeholder: '请输入邮箱地址',
                required: true,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
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
              
              const SizedBox(height: 16),
              
              // 密码输入
              ZephyrAccessiblePasswordInput(
                labelText: '密码',
                placeholder: '请输入密码',
                required: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // 记住我
              ZephyrAccessibleCheckbox(
                label: '记住我',
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value!;
                  });
                },
              ),
              
              const SizedBox(height: 24),
              
              // 提交按钮
              SizedBox(
                width: double.infinity,
                child: ZephyrAccessibleButton(
                  text: _isLoading ? '登录中...' : '登录',
                  onPressed: _isLoading ? null : _handleSubmit,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // 忘记密码链接
              Center(
                child: ZephyrAccessibleButton(
                  text: '忘记密码？',
                  type: ZephyrButtonType.text,
                  onPressed: () {
                    // 处理忘记密码
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ZephyrErrorBoundary.safeExecute(
        () async {
          // 模拟登录请求
          await Future.delayed(const Duration(seconds: 2));
          
          // 模拟登录验证
          if (_emailController.text == 'demo@example.com' && 
              _passwordController.text == 'password') {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('登录成功！')),
              );
            }
          } else {
            throw ZephyrValidationError(
              code: ZephyrErrorCodes.validationError,
              message: '邮箱或密码错误',
              field: 'credentials',
            );
          }
        },
        componentName: 'LoginForm',
        context: context,
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.getLocalizedMessage(context)),
              duration: const Duration(seconds: 5),
            ),
          );
        },
      );
    } catch (e) {
      // 错误已经被处理
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

/// 错误处理演示页面
class ErrorHandlingDemoPage extends StatelessWidget {
  const ErrorHandlingDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '错误处理演示',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '演示各种错误处理机制，包括错误边界、自动恢复和用户友好的错误消息。',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // 网络错误演示
          const NetworkErrorDemo(),
          
          const SizedBox(height: 24),
          
          // 组件错误演示
          const ComponentErrorDemo(),
          
          const SizedBox(height: 24),
          
          // 异步错误演示
          const AsyncErrorDemo(),
          
          const SizedBox(height: 24),
          
          // 验证错误演示
          const ValidationErrorDemo(),
        ],
      ),
    );
  }
}

/// 网络错误演示
class NetworkErrorDemo extends StatefulWidget {
  const NetworkErrorDemo({Key? key}) : super(key: key);

  @override
  State<NetworkErrorDemo> createState() => _NetworkErrorDemoState();
}

class _NetworkErrorDemoState extends State<NetworkErrorDemo> {
  bool _isLoading = false;
  String? _data;
  ZephyrError? _error;

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      _data = await ZephyrErrorBoundary.safeExecute(
        () async {
          await Future.delayed(const Duration(seconds: 1));
          
          // 模拟网络错误
          if (DateTime.now().second % 2 == 0) {
            throw ZephyrNetworkError(
              code: ZephyrErrorCodes.networkError,
              message: '网络连接失败',
              statusCode: 500,
              url: 'https://api.example.com/data',
              method: 'GET',
            );
          }
          
          return '数据加载成功！';
        },
        componentName: 'NetworkErrorDemo',
        context: context,
        onError: (error) {
          setState(() {
            _error = error;
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '网络错误处理',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '点击按钮模拟网络请求，有时会失败以演示错误处理。',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '网络错误',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _error!.getLocalizedMessage(context),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                    if (_error!.recoverySuggestion != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        '建议：${_error!.recoverySuggestion}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ],
                  ],
                ),
              )
            else if (_data != null)
              Text(
                _data!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            
            const SizedBox(height: 16),
            
            ZephyrAccessibleButton(
              text: '加载数据',
              onPressed: _isLoading ? null : _loadData,
            ),
          ],
        ),
      ),
    );
  }
}

/// 组件错误演示
class ComponentErrorDemo extends StatefulWidget {
  const ComponentErrorDemo({Key? key}) : super(key: key);

  @override
  State<ComponentErrorDemo> createState() => _ComponentErrorDemoState();
}

class _ComponentErrorDemoState extends State<ComponentErrorDemo> {
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '组件错误边界',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '错误边界可以捕获子组件的错误并显示友好的错误信息。',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            
            ZephyrErrorBoundary(
              config: ZephyrErrorBoundaryConfig(
                strategy: ZephyrErrorHandlingStrategy.showUserMessage,
                errorBuilder: (error) => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).colorScheme.error,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '组件发生了错误',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.message,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: _showError 
                  ? const ErrorProneComponent() 
                  : const NormalComponent(),
            ),
            
            const SizedBox(height: 16),
            
            ZephyrAccessibleButton(
              text: _showError ? '显示正常组件' : '触发错误',
              onPressed: () {
                setState(() {
                  _showError = !_showError;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 正常组件
class NormalComponent extends StatelessWidget {
  const NormalComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '这是一个正常的组件',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

/// 错误倾向组件
class ErrorProneComponent extends StatelessWidget {
  const ErrorProneComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 故意抛出错误
    throw ZephyrComponentError(
      componentName: 'ErrorProneComponent',
      code: ZephyrErrorCodes.componentRenderingFailed,
      message: '组件渲染失败',
      componentType: 'StatelessWidget',
    );
  }
}

/// 异步错误演示
class AsyncErrorDemo extends StatefulWidget {
  const AsyncErrorDemo({Key? key}) : super(key: key);

  @override
  State<AsyncErrorDemo> createState() => _AsyncErrorDemoState();
}

class _AsyncErrorDemoState extends State<AsyncErrorDemo> {
  Future<String>? _dataFuture;

  void _loadData() {
    setState(() {
      _dataFuture = _fetchData();
    });
  }

  Future<String> _fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    
    // 模拟异步错误
    throw ZephyrError(
      code: ZephyrErrorCodes.operationFailed,
      message: '异步操作失败',
      level: ZephyrErrorLevel.error,
      isRecoverable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '异步错误处理',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '异步错误边界可以处理异步操作中的错误。',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            
            ZephyrAsyncErrorBoundary(
              asyncBuilder: (context) async {
                return _dataFuture ??= await _fetchData();
              },
              loadingWidget: const Center(child: CircularProgressIndicator()),
              errorBuilder: (error) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.sync_problem,
                      color: Theme.of(context).colorScheme.error,
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '异步操作失败',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            ZephyrAccessibleButton(
              text: '重新加载',
              onPressed: _loadData,
            ),
          ],
        ),
      ),
    );
  }
}

/// 验证错误演示
class ValidationErrorDemo extends StatefulWidget {
  const ValidationErrorDemo({Key? key}) : super(key: key);

  @override
  State<ValidationErrorDemo> createState() => _ValidationErrorDemoState();
}

class _ValidationErrorDemoState extends State<ValidationErrorDemo> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '验证错误处理',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '实时验证和友好的错误消息提示。',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              
              ZephyrAccessibleInput(
                labelText: '邮箱',
                placeholder: '请输入邮箱地址',
                required: true,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                accessibilityConfig: ZephyrAccessibleInputConfig(
                  enableLiveValidation: true,
                ),
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
              
              const SizedBox(height: 16),
              
              ZephyrAccessibleInput(
                labelText: '年龄',
                placeholder: '请输入年龄',
                required: true,
                controller: _ageController,
                keyboardType: TextInputType.number,
                accessibilityConfig: ZephyrAccessibleInputConfig(
                  enableLiveValidation: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入年龄';
                  }
                  final age = int.tryParse(value);
                  if (age == null) {
                    return '请输入有效的数字';
                  }
                  if (age < 0 || age > 150) {
                    return '年龄必须在0-150之间';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              ZephyrAccessibleButton(
                text: '验证',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('验证通过！')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 无障碍功能演示页面
class AccessibilityFeaturesPage extends StatelessWidget {
  const AccessibilityFeaturesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '无障碍功能演示',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '演示各种无障碍功能，包括屏幕阅读器支持、键盘导航和焦点管理。',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // 键盘导航演示
          const KeyboardNavigationDemo(),
          
          const SizedBox(height: 24),
          
          // 语义化演示
          const SemanticsDemo(),
          
          const SizedBox(height: 24),
          
          // 焦点管理演示
          const FocusManagementDemo(),
          
          const SizedBox(height: 24),
          
          // 自适应演示
          const AdaptiveDemo(),
        ],
      ),
    );
  }
}

/// 键盘导航演示
class KeyboardNavigationDemo extends StatelessWidget {
  const KeyboardNavigationDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '键盘导航',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '使用Tab键在按钮间导航，Enter或Space键激活按钮。',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: ZephyrAccessibleButton(
                    text: '按钮 1',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('按钮 1 被点击')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ZephyrAccessibleButton(
                    text: '按钮 2',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('按钮 2 被点击')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ZephyrAccessibleButton(
                    text: '按钮 3',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('按钮 3 被点击')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 语义化演示
class SemanticsDemo extends StatelessWidget {
  const SemanticsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '语义化标记',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '这些元素都有适当的语义化标记，屏幕阅读器可以正确识别它们。',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            
            // 图像按钮
            ZephyrAccessibleButton(
              text: '搜索',
              icon: Icons.search,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('搜索功能')),
                );
              },
            ),
            
            const SizedBox(height: 8),
            
            // 图像
            ZephyrAccessibleImage(
              child: Image.network(
                'https://via.placeholder.com/150',
                width: 150,
                height: 150,
              ),
              description: '示例图片，150x150像素',
            ),
            
            const SizedBox(height: 8),
            
            // 自定义语义化组件
            ZephyrAccessibilityWrapper(
              config: ZephyrAccessibilityWrapperConfig(
                semanticData: ZephyrSemanticData(
                  label: '自定义操作区域',
                  hint: '点击执行自定义操作',
                ),
              ),
              isInteractive: true,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('自定义操作执行')),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('点击我'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 焦点管理演示
class FocusManagementDemo extends StatefulWidget {
  const FocusManagementDemo({Key? key}) : super(key: key);

  @override
  State<FocusManagementDemo> createState() => _FocusManagementDemoState();
}

class _FocusManagementDemoState extends State<FocusManagementDemo> {
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '焦点管理',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '点击按钮查看焦点指示器，使用Tab键在输入框间切换。',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            
            ZephyrAccessibleInput(
              labelText: '输入框 1',
              focusNode: _focusNode1,
              onSubmitted: (_) {
                _focusNode2.requestFocus();
              },
            ),
            
            const SizedBox(height: 8),
            
            ZephyrAccessibleInput(
              labelText: '输入框 2',
              focusNode: _focusNode2,
              onSubmitted: (_) {
                _focusNode3.requestFocus();
              },
            ),
            
            const SizedBox(height: 8),
            
            ZephyrAccessibleInput(
              labelText: '输入框 3',
              focusNode: _focusNode3,
              onSubmitted: (_) {
                _focusNode3.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 自适应演示
class AdaptiveDemo extends StatelessWidget {
  const AdaptiveDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '自适应无障碍',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '根据系统设置自动调整无障碍功能。',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            
            // 大文本演示
            Builder(
              builder: (context) {
                final textScaleFactor = MediaQuery.of(context).textScaleFactor;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '文本缩放: ${textScaleFactor.toStringAsFixed(1)}x',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '这是一段示例文本，会根据系统文本缩放设置自动调整大小。',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // 高对比度演示
            Builder(
              builder: (context) {
                final isHighContrast = MediaQuery.of(context).highContrast;
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isHighContrast ? Colors.black : Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '高对比度模式: ${isHighContrast ? "开启" : "关闭"}',
                    style: TextStyle(
                      color: isHighContrast ? Colors.white : Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 设置页面
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ZephyrAccessibilityConfig _config;

  @override
  void initState() {
    super.initState();
    _config = ZephyrAccessibilityManager.instance.currentConfig;
    
    // 监听配置变化
    ZephyrAccessibilityManager.instance.addConfigListener((config) {
      setState(() {
        _config = config;
      });
    });
  }

  @override
  void dispose() {
    ZephyrAccessibilityManager.instance.removeConfigListener((config) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '无障碍设置',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          
          // 文本缩放
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '文本缩放',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '当前缩放: ${_config.textScaleFactor.toStringAsFixed(1)}x',
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ZephyrAccessibleButton(
                          text: '减小',
                          onPressed: _config.textScaleFactor > 0.5
                              ? () {
                                  final newScale = _config.textScaleFactor - 0.1;
                                  ZephyrAccessibilityManager.instance.updateConfig(
                                    _config.copyWith(textScaleFactor: newScale),
                                  );
                                }
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ZephyrAccessibleButton(
                          text: '增大',
                          onPressed: _config.textScaleFactor < 3.0
                              ? () {
                                  final newScale = _config.textScaleFactor + 0.1;
                                  ZephyrAccessibilityManager.instance.updateConfig(
                                    _config.copyWith(textScaleFactor: newScale),
                                  );
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 高对比度
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ZephyrAccessibleSwitch(
                label: '高对比度模式',
                value: _config.highContrast,
                onChanged: (value) {
                  ZephyrAccessibilityManager.instance.updateConfig(
                    _config.copyWith(highContrast: value),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 减少动画
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ZephyrAccessibleSwitch(
                label: '减少动画',
                value: _config.reduceMotion,
                onChanged: (value) {
                  ZephyrAccessibilityManager.instance.updateConfig(
                    _config.copyWith(reduceMotion: value),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 屏幕阅读器
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ZephyrAccessibleSwitch(
                label: '屏幕阅读器支持',
                value: _config.enabledFeatures.contains(ZephyrAccessibilityFeature.screenReader),
                onChanged: (value) {
                  final features = Set<ZephyrAccessibilityFeature>.from(_config.enabledFeatures);
                  if (value) {
                    features.add(ZephyrAccessibilityFeature.screenReader);
                  } else {
                    features.remove(ZephyrAccessibilityFeature.screenReader);
                  }
                  ZephyrAccessibilityManager.instance.updateConfig(
                    _config.copyWith(enabledFeatures: features),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 重置设置
          ZephyrAccessibleButton(
            text: '重置为默认设置',
            onPressed: () {
              ZephyrAccessibilityManager.instance.resetToDefaults();
            },
          ),
        ],
      ),
    );
  }
}