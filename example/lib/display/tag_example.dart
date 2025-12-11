import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 标签
class TagExample extends StatefulWidget {
  const TagExample({super.key});

  @override
  State<TagExample> createState() => _TagExampleState();
}

class _TagExampleState extends State<TagExample> {
  final List<String> _tags = ['标签1', '标签2', '标签3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tag 标签'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicTags()),
            _buildSection('不同类型', _buildTagTypes()),
            _buildSection('轮廓样式', _buildOutlinedTags()),
            _buildSection('可关闭标签', _buildClosableTags()),
            _buildSection('带图标标签', _buildIconTags()),
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

  Widget _buildBasicTags() {
    return const Wrap(
      spacing: 8,
      children: [
        VelocityTag(text: '默认标签'),
        VelocityTag(text: 'Primary', type: VelocityTagType.primary),
      ],
    );
  }

  Widget _buildTagTypes() {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VelocityTag(text: 'Default', type: VelocityTagType.default_),
        VelocityTag(text: 'Primary', type: VelocityTagType.primary),
        VelocityTag(text: 'Success', type: VelocityTagType.success),
        VelocityTag(text: 'Warning', type: VelocityTagType.warning),
        VelocityTag(text: 'Error', type: VelocityTagType.error),
        VelocityTag(text: 'Info', type: VelocityTagType.info),
      ],
    );
  }

  Widget _buildOutlinedTags() {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VelocityTag(text: 'Primary', type: VelocityTagType.primary, outlined: true),
        VelocityTag(text: 'Success', type: VelocityTagType.success, outlined: true),
        VelocityTag(text: 'Warning', type: VelocityTagType.warning, outlined: true),
        VelocityTag(text: 'Error', type: VelocityTagType.error, outlined: true),
      ],
    );
  }

  Widget _buildClosableTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ..._tags.map((tag) => VelocityTag(
          text: tag,
          closable: true,
          onClose: () {
            setState(() {
              _tags.remove(tag);
            });
          },
        )),
        VelocityButton.text(
          text: '重置',
          type: VelocityButtonType.text,
          size: VelocityButtonSize.small,
          onPressed: () {
            setState(() {
              _tags.clear();
              _tags.addAll(['标签1', '标签2', '标签3']);
            });
          },
        )
      ],
    );
  }

  Widget _buildIconTags() {
    return const Wrap(
      spacing: 8,
      children: [
        VelocityTag(text: '通过', type: VelocityTagType.success, icon: Icons.check_circle),
        VelocityTag(text: '警告', type: VelocityTagType.warning, icon: Icons.warning),
        VelocityTag(text: '错误', type: VelocityTagType.error, icon: Icons.error),
      ],
    );
  }
}
