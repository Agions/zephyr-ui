import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 折叠面板
class CollapseExample extends StatefulWidget {
  const CollapseExample({super.key});

  @override
  State<CollapseExample> createState() => _CollapseExampleState();
}

class _CollapseExampleState extends State<CollapseExample> {
  final List<VelocityAccordionItem> _items = const [
    VelocityAccordionItem(
      title: Text('标题 1'),
      child: Text('这里是内容 1，可以放置任何组件。'),
      initiallyExpanded: true,
    ),
    VelocityAccordionItem(
      title: Text('标题 2'),
      child: Text('这里是内容 2，可以放置任何组件。'),
    ),
    VelocityAccordionItem(
      title: Text('标题 3'),
      child: Text('这里是内容 3，可以放置任何组件。'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collapse 折叠面板'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础折叠', _buildBasicCollapse()),
            _buildSection('手风琴 (单选)', _buildAccordion()),
            _buildSection('手风琴 (多选)', _buildMultiAccordion()),
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

  Widget _buildBasicCollapse() {
    return const VelocityCollapse(
      title: Text('点击展开/收起'),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('折叠面板内容...'),
      ),
    );
  }

  Widget _buildAccordion() {
    return VelocityAccordion(items: _items);
  }

  Widget _buildMultiAccordion() {
    return VelocityAccordion(
      items: _items,
      allowMultiple: true,
    );
  }
}
