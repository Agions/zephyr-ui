import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 布局组件示例 - 分隔线
class DividerExample extends StatelessWidget {
  const DividerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divider 分隔线'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('水平分隔线', _buildHorizontalDivider()),
            _buildSection('垂直分隔线', _buildVerticalDivider()),
            _buildSection('自定义样式', _buildStyledDivider()),
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
        // 这里不使用 Divider() 避免混淆，使用 Container 模拟
        Container(height: 1, color: Colors.grey.shade200),
      ],
    );
  }

  Widget _buildHorizontalDivider() {
    return const Column(
      children: [
        Text('上方内容'),
        VelocityDivider(),
        Text('下方内容'),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return const SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('左侧'),
          VelocityDivider(vertical: true),
          Text('中间'),
          VelocityDivider(vertical: true),
          Text('右侧'),
        ],
      ),
    );
  }

  Widget _buildStyledDivider() {
    return const Column(
      children: [
        VelocityDivider(
          style: VelocityDividerStyle(
            color: VelocityColors.primary,
            thickness: 2,
            margin: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        Text('自定义颜色和厚度'),
        VelocityDivider(
          style: VelocityDividerStyle(
            color: VelocityColors.warning,
            thickness: 4,
            length: 100, // 仅限制宽度
            margin: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        Text('自定义长度'),
      ],
    );
  }
}
