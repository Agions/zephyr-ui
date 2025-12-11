import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 布局组件示例 - 网格
class GridExample extends StatelessWidget {
  const GridExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid 网格'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础网格 (2列)', _buildBasicGrid()),
            _buildSection('响应式网格', _buildResponsiveGrid()),
            _buildSection('流式布局 (Wrap)', _buildWrap()),
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

  Widget _buildBasicGrid() {
    return SizedBox(
      height: 200,
      child: VelocityGrid(
        columns: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.5,
        children: List.generate(4, (index) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: VelocityColors.primary.withOpacity(0.1 * (index + 2)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('Item ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
          );
        }),
      ),
    );
  }

  Widget _buildResponsiveGrid() {
    return SizedBox(
      height: 200,
      child: VelocityResponsiveGrid(
        minItemWidth: 100,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: List.generate(6, (index) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: VelocityColors.secondary.withOpacity(0.1 * (index + 2)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('R-Item ${index + 1}'),
          );
        }),
      ),
    );
  }

  Widget _buildWrap() {
    return VelocityWrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(10, (index) {
        return Chip(
          label: Text('Tag ${index + 1}'),
          backgroundColor: VelocityColors.gray100,
        );
      }),
    );
  }
}
