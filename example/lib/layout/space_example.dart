import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 布局组件示例 - 间距
class SpaceExample extends StatelessWidget {
  const SpaceExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Space 间距'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('VelocityRow (水平间距)', _buildRowSpace()),
            _buildSection('VelocityColumn (垂直间距)', _buildColumnSpace()),
            _buildSection('VelocitySpace (固定尺寸)', _buildFixedSpace()),
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
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: content,
        ),
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }

  Widget _buildBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: VelocityColors.primary.withOpacity(0.1),
      child: Text(text, style: const TextStyle(color: VelocityColors.primary)),
    );
  }

  Widget _buildRowSpace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Spacing = 16'),
        const SizedBox(height: 8),
        VelocityRow(
          spacing: 16,
          children: [
            _buildBox('Item 1'),
            _buildBox('Item 2'),
            _buildBox('Item 3'),
          ],
        ),
      ],
    );
  }

  Widget _buildColumnSpace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Spacing = 16'),
        const SizedBox(height: 8),
        VelocityColumn(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBox('Item 1'),
            _buildBox('Item 2'),
            _buildBox('Item 3'),
          ],
        ),
      ],
    );
  }

  Widget _buildFixedSpace() {
    return Column(
      children: [
        Row(
          children: [
            _buildBox('Left'),
            const VelocitySpace.horizontal(32),
            _buildBox('Right (32px space)'),
          ],
        ),
        const VelocitySpace.vertical(24),
        _buildBox('Bottom (24px space from above)'),
      ],
    );
  }
}
