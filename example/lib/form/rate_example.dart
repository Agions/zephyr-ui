import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 评分
class RateExample extends StatefulWidget {
  const RateExample({super.key});

  @override
  State<RateExample> createState() => _RateExampleState();
}

class _RateExampleState extends State<RateExample> {
  double _value1 = 3;
  double _value2 = 2.5;
  double _value3 = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate 评分'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicRate()),
            _buildSection('半星选择', _buildHalfRate()),
            _buildSection('自定义图标', _buildCustomIconRate()),
            _buildSection('只读/禁用', _buildDisabledRate()),
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

  Widget _buildBasicRate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VelocityRate(
          value: _value1,
          onChanged: (val) {
            setState(() => _value1 = val);
          },
        ),
        const SizedBox(height: 8),
        Text('当前评分: $_value1'),
      ],
    );
  }

  Widget _buildHalfRate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VelocityRate(
          value: _value2,
          allowHalf: true,
          onChanged: (val) {
            setState(() => _value2 = val);
          },
        ),
        const SizedBox(height: 8),
        Text('当前评分: $_value2'),
      ],
    );
  }

  Widget _buildCustomIconRate() {
    return VelocityRate(
      value: _value3,
      character: Icons.favorite,
      style: const VelocityRateStyle(activeColor: Colors.red),
      onChanged: (val) {
        setState(() => _value3 = val);
      },
    );
  }

  Widget _buildDisabledRate() {
    return const VelocityRate(
      value: 3.5,
      allowHalf: true,
      disabled: true,
    );
  }
}
