import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 复选框
class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool _single = false;
  bool _agreed = false;
  final List<String> _selectedFruits = [];
  final _allFruits = ['苹果', '香蕉', '橙子', '草莓', '葡萄'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox 复选框'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicCheckbox()),
            _buildSection('带标签', _buildLabeledCheckbox()),
            _buildSection('复选框组', _buildCheckboxGroup()),
            _buildSection('禁用状态', _buildDisabledCheckbox()),
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

  Widget _buildBasicCheckbox() {
    return Row(
      children: [
        VelocityCheckbox(
          value: _single,
          onChanged: (value) => setState(() => _single = value),
        ),
        const SizedBox(width: 8),
        Text(_single ? '已选中' : '未选中'),
      ],
    );
  }

  Widget _buildLabeledCheckbox() {
    return VelocityCheckbox(
      value: _agreed,
      onChanged: (value) => setState(() => _agreed = value),
      label: '我已阅读并同意用户协议',
    );
  }

  Widget _buildCheckboxGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('选择您喜欢的水果：'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: _allFruits.map((fruit) {
            return VelocityCheckbox(
              value: _selectedFruits.contains(fruit),
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _selectedFruits.add(fruit);
                  } else {
                    _selectedFruits.remove(fruit);
                  }
                });
              },
              label: fruit,
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Text('已选择: ${_selectedFruits.isEmpty ? "无" : _selectedFruits.join(", ")}'),
      ],
    );
  }

  Widget _buildDisabledCheckbox() {
    return const Column(
      children: [
        Row(
          children: [
            VelocityCheckbox(
              value: false,
              onChanged: null,
              disabled: true,
            ),
            SizedBox(width: 8),
            Text('禁用未选中'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            VelocityCheckbox(
              value: true,
              onChanged: null,
              disabled: true,
            ),
            SizedBox(width: 8),
            Text('禁用已选中'),
          ],
        ),
        SizedBox(height: 8),
        VelocityCheckbox(
          value: false,
          onChanged: null,
          disabled: true,
          label: '禁用带标签',
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
            const Text('注册表单', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            VelocityCheckbox(
              value: _agreed,
              onChanged: (value) => setState(() => _agreed = value),
              label: '我已阅读并同意《服务条款》和《隐私政策》',
            ),
            const SizedBox(height: 16),
            VelocityButton.text(
              text: '注册',
              fullWidth: true,
              disabled: !_agreed,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('注册成功！')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
