import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 选择器
class SelectExample extends StatefulWidget {
  const SelectExample({super.key});

  @override
  State<SelectExample> createState() => _SelectExampleState();
}

class _SelectExampleState extends State<SelectExample> {
  String? _selectedFruit;
  String? _selectedCity;
  String? _selectedLanguage;

  final List<VelocitySelectItem<String>> _fruits = [
    const VelocitySelectItem(value: 'apple', label: '苹果', icon: Icons.apple),
    const VelocitySelectItem(value: 'banana', label: '香蕉'),
    const VelocitySelectItem(value: 'orange', label: '橙子'),
    const VelocitySelectItem(value: 'grape', label: '葡萄', disabled: true),
  ];

  final List<VelocitySelectItem<String>> _cities = [
    const VelocitySelectItem(value: 'beijing', label: '北京'),
    const VelocitySelectItem(value: 'shanghai', label: '上海'),
    const VelocitySelectItem(value: 'guangzhou', label: '广州'),
    const VelocitySelectItem(value: 'shenzhen', label: '深圳'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select 选择器'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicSelect()),
            _buildSection('带图标', _buildIconSelect()),
            _buildSection('禁用状态', _buildDisabledSelect()),
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

  Widget _buildBasicSelect() {
    return VelocitySelect<String>(
      value: _selectedCity,
      items: _cities,
      label: '选择城市',
      hint: '请选择所在城市',
      onChanged: (value) => setState(() => _selectedCity = value),
    );
  }

  Widget _buildIconSelect() {
    return VelocitySelect<String>(
      value: _selectedFruit,
      items: _fruits,
      label: '选择水果',
      hint: '请选择喜欢的水果',
      onChanged: (value) => setState(() => _selectedFruit = value),
    );
  }

  Widget _buildDisabledSelect() {
    return Column(
      children: [
        VelocitySelect<String>(
          value: _selectedLanguage,
          items: const [
            VelocitySelectItem(value: 'dart', label: 'Dart'),
            VelocitySelectItem(value: 'java', label: 'Java'),
          ],
          label: '禁用选择器',
          hint: '无法选择',
          disabled: true,
          onChanged: (value) => setState(() => _selectedLanguage = value),
        ),
      ],
    );
  }
}
