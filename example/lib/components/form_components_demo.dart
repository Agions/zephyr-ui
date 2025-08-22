import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/example_card.dart';
import '../services/theme_service.dart';
import 'package:provider/provider.dart';

class FormComponentsDemo extends StatefulWidget {
  const FormComponentsDemo({super.key});

  @override
  State<FormComponentsDemo> createState() => _FormComponentsDemoState();
}

class _FormComponentsDemoState extends State<FormComponentsDemo> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  
  bool _notificationsEnabled = true;
  bool _emailNotifications = false;
  bool _smsNotifications = true;
  double _volume = 0.7;
  String? _selectedCountry;
  bool _showPassword = false;
  bool _isLoading = false;
  
  final List<String> _countries = [
    '中国', '美国', '英国', '日本', '韩国', '德国', '法国', '澳大利亚'
  ];

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('表单组件'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
          ),
          IconButton(
            icon: Icon(themeService.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeService.toggleTheme(),
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          _buildInputExamples(),
          const SizedBox(height: 32),
          _buildSelectionExamples(),
          const SizedBox(height: 32),
          _buildFormValidationExample(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInputExamples(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildSelectionExamples(),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildFormValidationExample(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInputExamples(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildSelectionExamples(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildFormValidationExample(),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withValues(alpha: 0.1),
            Theme.of(context).primaryColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.form,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '表单组件',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '专业的表单组件库，支持验证、主题化和交互反馈',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              _buildFeatureChip(Icons.text_fields, '文本输入'),
              _buildFeatureChip(Icons.list, '选择器'),
              _buildFeatureChip(Icons.toggle_on, '开关组件'),
              _buildFeatureChip(Icons.tune, '滑块组件'),
              _buildFeatureChip(Icons.verified, '表单验证'),
              _buildFeatureChip(Icons.palette, '主题支持'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputExamples() {
    return ExampleCard(
      title: '输入组件',
      code: '''TextFormField(
  controller: _controller,
  decoration: InputDecoration(
    labelText: '用户名',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.person),
    suffixIcon: Icon(Icons.check_circle, color: Colors.green),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入用户名';
    }
    return null;
  },
  onChanged: (value) {
    // 实时验证
  },
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '实时验证输入框',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: '用户名',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.person),
              suffixIcon: _usernameController.text.isNotEmpty
                  ? Icon(
                      _validateUsername(_usernameController.text)
                          ? Icons.check_circle
                          : Icons.error,
                      color: _validateUsername(_usernameController.text)
                          ? Colors.green
                          : Colors.red,
                    )
                  : null,
              helperText: '用户名长度 3-20 个字符',
            ),
            validator: _validateUsername,
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: '邮箱',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.email),
              suffixIcon: _emailController.text.isNotEmpty
                  ? Icon(
                      _validateEmail(_emailController.text)
                          ? Icons.check_circle
                          : Icons.error,
                      color: _validateEmail(_emailController.text)
                          ? Colors.green
                          : Colors.red,
                    )
                  : null,
              helperText: '请输入有效的邮箱地址',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: '密码',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              ),
              helperText: '密码长度至少 6 个字符',
            ),
            obscureText: !_showPassword,
            validator: _validatePassword,
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '个人简介',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
              helperText: '最多 200 个字符',
            ),
            maxLines: 3,
            maxLength: 200,
            onChanged: (value) {
              if (value.length > 180) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('即将达到字符限制'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入用户名';
    }
    if (value.length < 3) {
      return '用户名长度不能少于 3 个字符';
    }
    if (value.length > 20) {
      return '用户名长度不能超过 20 个字符';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱地址';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    if (value.length < 6) {
      return '密码长度不能少于 6 个字符';
    }
    return null;
  }

  Widget _buildSelectionExamples() {
    return ExampleCard(
      title: '选择组件',
      code: '''DropdownButtonFormField<String>(
  decoration: InputDecoration(
    labelText: '选择选项',
    border: OutlineInputBorder(),
  ),
  items: countries.map((country) => DropdownMenuItem(
    value: country,
    child: Text(country),
  )).toList(),
  value: selectedCountry,
  onChanged: (value) {
    setState(() {
      selectedCountry = value;
    });
  },
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '交互式下拉选择',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: '选择国家',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.public),
              helperText: _selectedCountry == null ? '请选择一个国家' : '已选择: $_selectedCountry',
            ),
            items: _countries.map((country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 8),
                    Text(country),
                  ],
                ),
              );
            }).toList(),
            value: _selectedCountry,
            onChanged: (value) {
              setState(() {
                _selectedCountry = value;
              });
              if (value != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('已选择: $value'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 24),
          const Text(
            '智能开关组件',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.notifications),
                  title: const Text('推送通知'),
                  subtitle: Text(_notificationsEnabled ? '已启用' : '已禁用'),
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                      if (!value) {
                        _emailNotifications = false;
                        _smsNotifications = false;
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('推送通知${value ? '已启用' : '已禁用'}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                const Divider(),
                SwitchListTile(
                  secondary: const Icon(Icons.email),
                  title: const Text('邮件通知'),
                  subtitle: Text(_emailNotifications ? '已启用' : '已禁用'),
                  value: _emailNotifications && _notificationsEnabled,
                  onChanged: _notificationsEnabled ? (value) {
                    setState(() {
                      _emailNotifications = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('邮件通知${value ? '已启用' : '已禁用'}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  } : null,
                ),
                const Divider(),
                SwitchListTile(
                  secondary: const Icon(Icons.sms),
                  title: const Text('短信通知'),
                  subtitle: Text(_smsNotifications ? '已启用' : '已禁用'),
                  value: _smsNotifications && _notificationsEnabled,
                  onChanged: _notificationsEnabled ? (value) {
                    setState(() {
                      _smsNotifications = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('短信通知${value ? '已启用' : '已禁用'}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  } : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '高级滑块组件',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('音量'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${(_volume * 100).round()}%',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Slider(
                value: _volume,
                onChanged: (value) {
                  setState(() {
                    _volume = value;
                  });
                },
                divisions: 10,
                label: '${(_volume * 100).round()}%',
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.grey.shade300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.volume_mute),
                    onPressed: () => setState(() => _volume = 0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_down),
                    onPressed: () => setState(() => _volume = (_volume - 0.1).clamp(0, 1)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    onPressed: () => setState(() => _volume = (_volume + 0.1).clamp(0, 1)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_max),
                    onPressed: () => setState(() => _volume = 1),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormValidationExample() {
    return ExampleCard(
      title: '完整表单验证',
      code: '''Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          labelText: '用户名',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
        ),
        validator: _validateUsername,
      ),
      TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: '密码',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
        ),
        obscureText: true,
        validator: _validatePassword,
      ),
      SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _handleSubmit,
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text('登录'),
        ),
      ),
    ],
  ),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '智能登录表单',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: '用户名',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),
                        helperText: '请输入 3-20 个字符的用户名',
                      ),
                      validator: _validateUsername,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: '密码',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () => setState(() => _showPassword = !_showPassword),
                        ),
                        helperText: '密码长度至少 6 个字符',
                      ),
                      obscureText: !_showPassword,
                      validator: _validatePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _handleSubmit(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('记住我功能开发中'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        const Text('记住我'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('密码重置功能开发中'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text('忘记密码？'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('登录'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _formKey.currentState?.reset();
                              _usernameController.clear();
                              _passwordController.clear();
                              setState(() {
                                _showPassword = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('表单已重置'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            child: const Text('重置'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('注册功能开发中'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            child: const Text('注册账号'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '这是一个完整的表单验证示例，包含实时验证、状态管理和用户反馈。',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      // 模拟网络请求
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() => _isLoading = false);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('登录成功！欢迎 ${_usernameController.text}'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('表单组件说明'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('功能特性：', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• 实时表单验证'),
              Text('• 智能状态管理'),
              Text('• 用户友好的反馈'),
              Text('• 主题化支持'),
              Text('• 响应式设计'),
              SizedBox(height: 16),
              Text('包含组件：', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• 文本输入框'),
              Text('• 下拉选择器'),
              Text('• 开关组件'),
              Text('• 滑块组件'),
              Text('• 完整表单验证'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}