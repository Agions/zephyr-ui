import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 输入框
class InputExample extends StatefulWidget {
  const InputExample({super.key});

  @override
  State<InputExample> createState() => _InputExampleState();
}

class _InputExampleState extends State<InputExample> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input 输入框'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicInput()),
            _buildSection('带图标', _buildIconInput()),
            _buildSection('密码输入', _buildPasswordInput()),
            _buildSection('验证状态', _buildValidationInput()),
            _buildSection('输入限制', _buildLimitedInput()),
            _buildSection('文本区域', _buildTextArea()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: VelocityColors.gray800,
            ),
          ),
        ),
        content,
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }

  Widget _buildBasicInput() {
    return Column(
      children: [
        VelocityInput(
          label: '用户名',
          hint: '请输入用户名',
          controller: _usernameController,
        ),
        const SizedBox(height: 16),
        const VelocityInput(
          label: '只读输入框',
          hint: '这是只读内容',
          readOnly: true,
        ),
        const SizedBox(height: 16),
        const VelocityInput(
          label: '禁用输入框',
          hint: '已禁用',
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildIconInput() {
    return const Column(
      children: [
        VelocityInput(
          label: '用户名',
          hint: '请输入用户名',
          prefixIcon: Icons.person,
        ),
        SizedBox(height: 16),
        VelocityInput(
          label: '邮箱',
          hint: '请输入邮箱',
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16),
        VelocityInput(
          label: '搜索',
          hint: '请输入搜索内容',
          prefixIcon: Icons.search,
          suffixIcon: Icons.clear,
        ),
      ],
    );
  }

  Widget _buildPasswordInput() {
    return VelocityInput(
      label: '密码',
      hint: '请输入密码',
      obscureText: true,
      prefixIcon: Icons.lock,
      controller: _passwordController,
    );
  }

  Widget _buildValidationInput() {
    return Column(
      children: [
        VelocityInput(
          label: '邮箱',
          hint: '请输入邮箱',
          prefixIcon: Icons.email,
          error: _emailError,
          onChanged: (value) {
            setState(() {
              if (value.isEmpty) {
                _emailError = null;
              } else if (!value.contains('@')) {
                _emailError = '请输入有效的邮箱地址';
              } else {
                _emailError = null;
              }
            });
          },
        ),
        const SizedBox(height: 16),
        const VelocityInput(
          label: '带帮助文本',
          hint: '请输入内容',
          helper: '这是一段帮助文本，用于说明输入要求',
        ),
      ],
    );
  }

  Widget _buildLimitedInput() {
    return const Column(
      children: [
        VelocityInput(
          label: '限制长度',
          hint: '最多输入 20 个字符',
          maxLength: 20,
          helper: '最多输入 20 个字符',
        ),
        SizedBox(height: 16),
        VelocityInput(
          label: '数字输入',
          hint: '只能输入数字',
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16),
        VelocityInput(
          label: '电话号码',
          hint: '请输入电话号码',
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildTextArea() {
    return const Column(
      children: [
        VelocityTextArea(
          label: '描述',
          hint: '请输入详细描述...',
          minLines: 3,
          maxLines: 6,
        ),
        SizedBox(height: 16),
        VelocityTextArea(
          label: '备注',
          hint: '请输入备注信息',
          maxLength: 200,
          helper: '最多输入 200 个字符',
        ),
      ],
    );
  }
}
