import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 基础组件示例 - 链接
class LinkExample extends StatelessWidget {
  const LinkExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link 链接'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicLink(context)),
            _buildSection('不同颜色', _buildColorLinks(context)),
            _buildSection('带图标', _buildIconLinks(context)),
            _buildSection('禁用状态', _buildDisabledLinks()),
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

  void _onTap(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('点击了: $text'), duration: const Duration(milliseconds: 500)));
  }

  Widget _buildBasicLink(BuildContext context) {
    return Row(
      children: [
        VelocityLink(text: '默认链接', onTap: () => _onTap(context, '默认链接')),
        const SizedBox(width: 20),
        VelocityLink(text: '下划线链接', underline: true, onTap: () => _onTap(context, '下划线链接')),
      ],
    );
  }

  Widget _buildColorLinks(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: [
        VelocityLink(
          text: 'Primary Link',
          style: const VelocityLinkStyle(color: VelocityColors.primary),
          onTap: () => _onTap(context, 'Primary'),
        ),
        VelocityLink(
          text: 'Success Link',
          style: const VelocityLinkStyle(color: VelocityColors.success),
          onTap: () => _onTap(context, 'Success'),
        ),
        VelocityLink(
          text: 'Warning Link',
          style: const VelocityLinkStyle(color: VelocityColors.warning),
          onTap: () => _onTap(context, 'Warning'),
        ),
        VelocityLink(
          text: 'Error Link',
          style: const VelocityLinkStyle(color: VelocityColors.error),
          onTap: () => _onTap(context, 'Error'),
        ),
      ],
    );
  }

  Widget _buildIconLinks(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: [
        VelocityLink(
          text: '编辑',
          icon: Icons.edit,
          onTap: () => _onTap(context, '编辑'),
        ),
        VelocityLink(
          text: '查看详情',
          icon: Icons.arrow_forward,
          underline: true,
          style: const VelocityLinkStyle(color: VelocityColors.primary),
          onTap: () => _onTap(context, '查看详情'),
        ),
      ],
    );
  }

  Widget _buildDisabledLinks() {
    return const Row(
      children: [
        VelocityLink(text: '禁用链接', disabled: true),
        SizedBox(width: 20),
        VelocityLink(text: '带图标禁用', icon: Icons.delete, disabled: true),
      ],
    );
  }
}
