import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 徽章
class BadgeExample extends StatelessWidget {
  const BadgeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Badge 徽章'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicBadge()),
            _buildSection('红点徽章', _buildDotBadge()),
            _buildSection('最大值限制', _buildMaxBadge()),
            _buildSection('不同类型', _buildBadgeTypes()),
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

  Widget _buildBasicBadge() {
    return const Wrap(
      spacing: 24,
      children: [
        VelocityBadge(
          count: 5,
          child: Icon(Icons.notifications, size: 30),
        ),
        VelocityBadge(
          count: 0,
          showZero: true,
          child: Icon(Icons.shopping_cart, size: 30),
        ),
      ],
    );
  }

  Widget _buildDotBadge() {
    return const Wrap(
      spacing: 24,
      children: [
        VelocityBadge(
          dot: true,
          child: Text('我的消息'),
        ),
        VelocityBadge(
          dot: true,
          child: Icon(Icons.email, size: 30),
        ),
      ],
    );
  }

  Widget _buildMaxBadge() {
    return Wrap(
      spacing: 24,
      children: [
        VelocityBadge(
          count: 100,
          max: 99,
          child: Container(
            width: 40,
            height: 40,
            color: Colors.grey,
          ),
        ),
        VelocityBadge(
          count: 15,
          max: 10,
          child: Container(
            width: 40,
            height: 40,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeTypes() {
    return const Wrap(
      spacing: 24,
      children: [
        VelocityBadge(count: 5, type: VelocityBadgeType.error, child: Icon(Icons.home)),
        VelocityBadge(count: 5, type: VelocityBadgeType.success, child: Icon(Icons.home)),
        VelocityBadge(count: 5, type: VelocityBadgeType.warning, child: Icon(Icons.home)),
        VelocityBadge(count: 5, type: VelocityBadgeType.info, child: Icon(Icons.home)),
      ],
    );
  }
}
