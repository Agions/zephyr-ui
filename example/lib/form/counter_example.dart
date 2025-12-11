import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 计数器
class CounterExample extends StatefulWidget {
  const CounterExample({super.key});

  @override
  State<CounterExample> createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  int _value1 = 1;
  int _value2 = 10;
  int _value3 = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter 计数器'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicCounter()),
            _buildSection('设置步长 (Step=5)', _buildStepCounter()),
            _buildSection('禁用状态', _buildDisabledCounter()),
            _buildSection('隐藏输入框', _buildNoInputCounter()),
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

  Widget _buildBasicCounter() {
    return VelocityCounter(
      value: _value1,
      min: 0,
      max: 10,
      onChanged: (val) {
        setState(() => _value1 = val);
      },
    );
  }

  Widget _buildStepCounter() {
    return VelocityCounter(
      value: _value2,
      min: 0,
      max: 100,
      step: 5,
      onChanged: (val) {
        setState(() => _value2 = val);
      },
    );
  }

  Widget _buildDisabledCounter() {
    return VelocityCounter(
      value: 5,
      disabled: true,
      onChanged: (val) {},
    );
  }

  Widget _buildNoInputCounter() {
    return VelocityCounter(
      value: _value3,
      showInput: false,
      onChanged: (val) {
        setState(() => _value3 = val);
      },
    );
  }
}
