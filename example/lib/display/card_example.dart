import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 卡片
class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card 卡片'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicCard()),
            _buildSection('不同样式', _buildCardStyles()),
            _buildSection('可交互卡片', _buildInteractiveCard(context)),
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

  Widget _buildBasicCard() {
    return const VelocityCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('卡片标题', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('这是一个基础卡片示例，包含标题和内容。'),
        ],
      ),
    );
  }

  Widget _buildCardStyles() {
    return const Column(
      children: [
        VelocityCard(
          style: VelocityCardStyle(
            backgroundColor: VelocityColors.primary,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Text('自定义背景色和圆角', style: TextStyle(color: Colors.white)),
        ),
        SizedBox(height: 16),
        VelocityOutlinedCard(
          child: Text('轮廓样式卡片 (VelocityOutlinedCard)'),
        ),
        SizedBox(height: 16),
        VelocityFilledCard(
          child: Text('填充样式卡片 (VelocityFilledCard)'),
        ),
      ],
    );
  }

  Widget _buildInteractiveCard(BuildContext context) {
    return VelocityCard(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('点击了卡片')));
      },
      child: const Row(
        children: [
          Icon(Icons.touch_app, color: VelocityColors.primary),
          SizedBox(width: 16),
          Text('点击我试试'),
        ],
      ),
    );
  }
}
