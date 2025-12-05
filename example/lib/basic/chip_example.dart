import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 基础组件示例 - Chip 芯片
class ChipExample extends StatefulWidget {
  const ChipExample({super.key});

  @override
  State<ChipExample> createState() => _ChipExampleState();
}

class _ChipExampleState extends State<ChipExample> {
  final Set<String> _selectedTags = {'Flutter'};
  final List<String> _tags = ['Flutter', 'Dart', 'iOS', 'Android', 'Web'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chip 芯片'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicChips()),
            _buildSection('Chip 类型', _buildChipTypes()),
            _buildSection('带图标的 Chip', _buildIconChips()),
            _buildSection('可删除的 Chip', _buildDeletableChips()),
            _buildSection('选择 Chip', _buildChoiceChips()),
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

  Widget _buildBasicChips() {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VelocityChip(label: '标签'),
        VelocityChip(label: 'Flutter'),
        VelocityChip(label: 'VelocityUI'),
      ],
    );
  }

  Widget _buildChipTypes() {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VelocityChip(label: '填充样式', type: VelocityChipType.filled),
        VelocityChip(label: '轮廓样式', type: VelocityChipType.outlined),
        VelocityChip(label: '柔和样式', type: VelocityChipType.tonal),
      ],
    );
  }

  Widget _buildIconChips() {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VelocityChip(label: '设置', icon: Icons.settings),
        VelocityChip(label: '用户', icon: Icons.person),
        VelocityChip(label: '消息', icon: Icons.message),
        VelocityChip(
          label: '头像',
          avatar: CircleAvatar(
            radius: 10,
            backgroundColor: VelocityColors.primary,
            child: Text('A', style: TextStyle(fontSize: 10, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildDeletableChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VelocityChip(label: 'Flutter', onDelete: () {}),
        VelocityChip(label: 'Dart', onDelete: () {}),
        VelocityChip(label: 'Mobile', onDelete: () {}),
      ],
    );
  }

  Widget _buildChoiceChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _tags.map((tag) {
        return VelocityChoiceChip(
          label: tag,
          selected: _selectedTags.contains(tag),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedTags.add(tag);
              } else {
                _selectedTags.remove(tag);
              }
            });
          },
        );
      }).toList(),
    );
  }
}
