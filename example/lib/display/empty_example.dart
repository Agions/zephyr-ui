import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 空状态
class EmptyExample extends StatelessWidget {
  const EmptyExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty 空状态'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法 (暂无数据)', const VelocityEmpty()),
            _buildSection('网络错误', const VelocityEmpty(type: VelocityEmptyType.noNetwork)),
            _buildSection('搜索无结果', const VelocityEmpty(type: VelocityEmptyType.noSearch)),
            _buildSection('加载失败', 
              VelocityEmpty(
                type: VelocityEmptyType.error,
                actionText: '重试',
                onAction: () {
                  print('点击重试');
                },
              ),
            ),
            _buildSection('自定义', 
              const VelocityEmpty(
                type: VelocityEmptyType.custom,
                icon: Icons.shopping_cart_outlined,
                title: '购物车为空',
                description: '快去选购心仪的商品吧',
              ),
            ),
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
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: content,
        ),
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }
}
