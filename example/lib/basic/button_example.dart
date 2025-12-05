import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 基础组件示例 - 按钮
class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button 按钮'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('按钮类型', _buildButtonTypes()),
            _buildSection('按钮尺寸', _buildButtonSizes()),
            _buildSection('图标按钮', _buildIconButtons()),
            _buildSection('按钮状态', _buildButtonStates()),
            _buildSection('全宽按钮', _buildFullWidthButtons()),
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

  Widget _buildButtonTypes() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        VelocityButton.text(text: '主要按钮', type: VelocityButtonType.primary, onPressed: () {}),
        VelocityButton.text(text: '次要按钮', type: VelocityButtonType.secondary, onPressed: () {}),
        VelocityButton.text(text: '轮廓按钮', type: VelocityButtonType.outline, onPressed: () {}),
        VelocityButton.text(text: '文本按钮', type: VelocityButtonType.text, onPressed: () {}),
        VelocityButton.text(text: '成功按钮', type: VelocityButtonType.success, onPressed: () {}),
        VelocityButton.text(text: '警告按钮', type: VelocityButtonType.warning, onPressed: () {}),
        VelocityButton.text(text: '危险按钮', type: VelocityButtonType.danger, onPressed: () {}),
      ],
    );
  }

  Widget _buildButtonSizes() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        VelocityButton.text(text: '小按钮', size: VelocityButtonSize.small, onPressed: () {}),
        VelocityButton.text(text: '中按钮', size: VelocityButtonSize.medium, onPressed: () {}),
        VelocityButton.text(text: '大按钮', size: VelocityButtonSize.large, onPressed: () {}),
      ],
    );
  }

  Widget _buildIconButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        VelocityButton.icon(text: '添加', icon: Icons.add, onPressed: () {}),
        VelocityButton.icon(text: '编辑', icon: Icons.edit, onPressed: () {}),
        VelocityButton.icon(
          text: '删除',
          icon: Icons.delete,
          type: VelocityButtonType.danger,
          onPressed: () {},
        ),
        VelocityButton.icon(
          text: '下一步',
          icon: Icons.arrow_forward,
          iconPosition: VelocityIconPosition.right,
          onPressed: () {},
        ),
        const VelocityIconButton(icon: Icons.favorite, tooltip: '收藏'),
        const VelocityIconButton(icon: Icons.share, tooltip: '分享'),
        const VelocityIconButton(icon: Icons.more_vert, tooltip: '更多'),
      ],
    );
  }

  Widget _buildButtonStates() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        VelocityButton.text(text: '正常状态', onPressed: () {}),
        VelocityButton.text(text: '加载状态', loading: true, onPressed: () {}),
        VelocityButton.text(text: '禁用状态', disabled: true, onPressed: () {}),
      ],
    );
  }

  Widget _buildFullWidthButtons() {
    return Column(
      children: [
        VelocityButton.text(
          text: '全宽主要按钮',
          fullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        VelocityButton.text(
          text: '全宽轮廓按钮',
          type: VelocityButtonType.outline,
          fullWidth: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
