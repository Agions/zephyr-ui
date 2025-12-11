import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 布局组件示例 - 安全区域
class SafeAreaExample extends StatelessWidget {
  const SafeAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeArea 安全区域'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: VelocityColumn(
        spacing: 20,
        children: [
          _buildDemo(
            '基本安全区域',
            Container(
              color: Colors.amber,
              height: 200,
              child: const VelocitySafeArea(
                child: Center(child: Text('安全区域内容')),
              ),
            ),
          ),
          _buildDemo(
            '仅顶部安全区域',
            Container(
              color: Colors.blue[100],
              height: 100,
              child: const VelocitySafeArea.top(
                child: Center(child: Text('Top Only')),
              ),
            ),
          ),
          _buildDemo(
            '仅底部安全区域',
            Container(
              color: Colors.green[100],
              height: 100,
              child: const VelocitySafeArea.bottom(
                child: Center(child: Text('Bottom Only')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemo(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
}
