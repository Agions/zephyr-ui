import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 文字提示
class TooltipExample extends StatelessWidget {
  const TooltipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tooltip 文字提示'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicTooltip()),
            _buildSection('弹出气泡 (Popover)', _buildPopover()),
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

  Widget _buildBasicTooltip() {
    return const Wrap(
      spacing: 16,
      children: [
        VelocityTooltip(
          message: '这是提示文字',
          child: Text('长按查看提示'),
        ),
        VelocityTooltip(
          message: 'Bottom Tooltip',
          position: VelocityTooltipPosition.bottom,
          child: VelocityButton(onPressed: null, child: Text('下方提示')),
        ),
      ],
    );
  }

  Widget _buildPopover() {
    return const Center(
      child: VelocityPopover(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VelocityListTile(title: Text('选项一'), dense: true),
            VelocityListTile(title: Text('选项二'), dense: true),
            VelocityListTile(title: Text('选项三'), dense: true),
          ],
        ),
        child: VelocityButton(
          onPressed: null,
          child: Text('点击弹出菜单'), // Popover 会接管手势
        ),
      ),
    );
  }
}
