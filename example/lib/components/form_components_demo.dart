import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/example_card.dart';

class FormComponentsDemo extends StatelessWidget {
  const FormComponentsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('表单组件'),
        elevation: 0,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '表单组件',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ZephyrUI 提供了丰富的表单组件，包括输入框、选择器、开关、滑块等，支持表单验证和自定义样式。',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildInputExamples() {
    return ExampleCard(
      title: '输入组件',
      code: '''TextField(
  decoration: InputDecoration(
    labelText: '用户名',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.person),
  ),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '文本输入框',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: '用户名',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: '邮箱',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: '密码',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: '个人简介',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionExamples() {
    return ExampleCard(
      title: '选择组件',
      code: '''DropdownButtonFormField<String>(
  decoration: InputDecoration(
    labelText: '选择选项',
    border: OutlineInputBorder(),
  ),
  items: [
    DropdownMenuItem(value: 'option1', child: Text('选项1')),
    DropdownMenuItem(value: 'option2', child: Text('选项2')),
  ],
  onChanged: (value) {},
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '下拉选择',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: '选择国家',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'cn', child: Text('中国')),
              DropdownMenuItem(value: 'us', child: Text('美国')),
              DropdownMenuItem(value: 'uk', child: Text('英国')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 24),
          const Text(
            '开关组件',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('推送通知'),
                  subtitle: const Text('接收应用推送通知'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('邮件通知'),
                  subtitle: const Text('接收邮件通知'),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('短信通知'),
                  subtitle: const Text('接收短信通知'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '滑块组件',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('音量'),
              Slider(
                value: 0.7,
                onChanged: (value) {},
                divisions: 10,
                label: '70%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormValidationExample() {
    return ExampleCard(
      title: '表单验证示例',
      code: '''Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(
          labelText: '邮箱',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || !value.contains('@')) {
            return '请输入有效的邮箱地址';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // 表单验证通过
          }
        },
        child: Text('提交'),
      ),
    ],
  ),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '登录表单',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: '用户名',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      errorText: '用户名不能为空',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: '密码',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      errorText: '密码长度不能少于6位',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      const Text('记住我'),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text('忘记密码？'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('登录'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}