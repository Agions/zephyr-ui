import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 导航组件示例 - 分段控制器
class SegmentedExample extends StatefulWidget {
  const SegmentedExample({super.key});

  @override
  State<SegmentedExample> createState() => _SegmentedExampleState();
}

class _SegmentedExampleState extends State<SegmentedExample> {
  int _value1 = 0;
  String _value2 = 'daily';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segmented 分段控制器'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicSegmented()),
            _buildSection('带图标', _buildIconSegmented()),
            _buildSection('禁用状态', _buildDisabledSegmented()),
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
        Center(child: content),
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }

  Widget _buildBasicSegmented() {
    return VelocitySegmented<int>(
      value: _value1,
      segments: const [
        VelocitySegment(value: 0, label: 'Map'),
        VelocitySegment(value: 1, label: 'Transit'),
        VelocitySegment(value: 2, label: 'Satellite'),
      ],
      onChanged: (val) => setState(() => _value1 = val),
    );
  }

  Widget _buildIconSegmented() {
    return VelocitySegmented<String>(
      value: _value2,
      segments: const [
        VelocitySegment(value: 'daily', label: 'Daily', icon: Icons.calendar_view_day),
        VelocitySegment(value: 'weekly', label: 'Weekly', icon: Icons.calendar_view_week),
        VelocitySegment(value: 'monthly', label: 'Monthly', icon: Icons.calendar_view_month),
      ],
      onChanged: (val) => setState(() => _value2 = val),
    );
  }

  Widget _buildDisabledSegmented() {
    return VelocitySegmented<int>(
      value: 1,
      disabled: true,
      segments: const [
        VelocitySegment(value: 0, label: 'Disabled 1'),
        VelocitySegment(value: 1, label: 'Disabled 2'),
      ],
      onChanged: (val) {},
    );
  }
}
