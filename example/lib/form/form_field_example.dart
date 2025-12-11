import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 表单字段
class FormFieldExample extends StatelessWidget {
  const FormFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormField 表单字段'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础布局 (垂直)', _buildVerticalForm()),
            _buildSection('水平布局', _buildHorizontalForm()),
            _buildSection('带错误信息', _buildErrorForm()),
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

  Widget _buildVerticalForm() {
    return VelocityForm(
      children: [
        VelocityFormField(
          label: '用户名',
          required: true,
          child: VelocityInput(hint: '请输入用户名', onChanged: (v) {}),
        ),
        VelocityFormField(
          label: '密码',
          required: true,
          helper: '密码至少6位，包含字母和数字',
          child: VelocityInput(hint: '请输入密码', obscureText: true, onChanged: (v) {}),
        ),
      ],
    );
  }

  Widget _buildHorizontalForm() {
    return VelocityForm(
      spacing: 24,
      children: [
        VelocityFormField(
          label: '昵称',
          direction: Axis.horizontal,
          child: VelocityInput(hint: '请输入昵称', onChanged: (v) {}),
        ),
        VelocityFormField(
          label: '通知',
          direction: Axis.horizontal,
          child: VelocitySwitch(value: true, onChanged: (v) {}),
        ),
      ],
    );
  }

  Widget _buildErrorForm() {
    return VelocityFormField(
      label: '邮箱',
      required: true,
      error: '请输入有效的邮箱地址',
      child: VelocityInput(
        hint: '请输入邮箱',
        onChanged: (v) {},
        style: const VelocityInputStyle(borderColor: VelocityColors.error),
      ),
    );
  }
}
