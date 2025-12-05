import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 导航组件示例 - 标签页
class TabsExample extends StatelessWidget {
  const TabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs 标签页'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: VelocityTabs(
        tabs: const ['首页', '消息', '我的'],
        children: [
          _buildTabContent('首页内容', Icons.home),
          _buildTabContent('消息内容', Icons.message),
          _buildTabContent('我的内容', Icons.person),
        ],
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: VelocityColors.primary),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
