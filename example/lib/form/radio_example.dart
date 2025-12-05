import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 单选框
class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String? _selectedGender;
  String? _selectedSize = 'M';
  String? _selectedPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio 单选框'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicRadio()),
            _buildSection('横向排列', _buildHorizontalRadio()),
            _buildSection('禁用状态', _buildDisabledRadio()),
            _buildSection('使用场景', _buildUseCase()),
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

  Widget _buildBasicRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('选择性别：'),
        const SizedBox(height: 8),
        VelocityRadio<String>(
          value: '男',
          groupValue: _selectedGender,
          onChanged: (value) => setState(() => _selectedGender = value),
          label: '男',
        ),
        VelocityRadio<String>(
          value: '女',
          groupValue: _selectedGender,
          onChanged: (value) => setState(() => _selectedGender = value),
          label: '女',
        ),
        VelocityRadio<String>(
          value: '保密',
          groupValue: _selectedGender,
          onChanged: (value) => setState(() => _selectedGender = value),
          label: '保密',
        ),
        const SizedBox(height: 8),
        Text('已选择: ${_selectedGender ?? "未选择"}'),
      ],
    );
  }

  Widget _buildHorizontalRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('选择尺码：'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
            return VelocityRadio<String>(
              value: size,
              groupValue: _selectedSize,
              onChanged: (value) => setState(() => _selectedSize = value),
              label: size,
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Text('已选择: ${_selectedSize ?? "未选择"}'),
      ],
    );
  }

  Widget _buildDisabledRadio() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VelocityRadio<String>(
          value: 'disabled1',
          groupValue: null,
          onChanged: null,
          disabled: true,
          label: '禁用未选中',
        ),
        VelocityRadio<String>(
          value: 'disabled2',
          groupValue: 'disabled2',
          onChanged: null,
          disabled: true,
          label: '禁用已选中',
        ),
      ],
    );
  }

  Widget _buildUseCase() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('支付方式', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            VelocityRadio<String>(
              value: 'alipay',
              groupValue: _selectedPayment,
              onChanged: (value) => setState(() => _selectedPayment = value),
              label: '支付宝',
            ),
            VelocityRadio<String>(
              value: 'wechat',
              groupValue: _selectedPayment,
              onChanged: (value) => setState(() => _selectedPayment = value),
              label: '微信支付',
            ),
            VelocityRadio<String>(
              value: 'card',
              groupValue: _selectedPayment,
              onChanged: (value) => setState(() => _selectedPayment = value),
              label: '银行卡',
            ),
            const SizedBox(height: 16),
            VelocityButton.text(
              text: '确认支付',
              fullWidth: true,
              disabled: _selectedPayment == null,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('使用 $_selectedPayment 支付')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
