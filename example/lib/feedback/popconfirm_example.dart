import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例 - 确认气泡
class PopconfirmExample extends StatelessWidget {
  const PopconfirmExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popconfirm 确认气泡'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicUsage(context)),
            _buildSection('自定义按钮文字', _buildCustomButtons(context)),
            _buildSection('带描述内容', _buildWithContent(context)),
            _buildSection('不同触发元素', _buildDifferentTriggers(context)),
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

  Widget _buildBasicUsage(BuildContext context) {
    return VelocityPopconfirm(
      title: '确定要删除吗？',
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已确认删除')),
        );
      },
      onCancel: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已取消')),
        );
      },
      child: const VelocityButton.text(
        text: '删除',
        type: VelocityButtonType.danger,
        onPressed: null,
      ),
    );
  }

  Widget _buildCustomButtons(BuildContext context) {
    return VelocityPopconfirm(
      title: '确定要提交吗？',
      confirmText: '是的，提交',
      cancelText: '再想想',
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已提交')),
        );
      },
      child: const VelocityButton.text(
        text: '提交表单',
        onPressed: null,
      ),
    );
  }

  Widget _buildWithContent(BuildContext context) {
    return VelocityPopconfirm(
      title: '确定要注销账户吗？',
      content: '注销后，您的所有数据将被永久删除，且无法恢复。',
      confirmText: '确认注销',
      cancelText: '取消',
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('账户已注销')),
        );
      },
      child: const VelocityButton.text(
        text: '注销账户',
        type: VelocityButtonType.danger,
        onPressed: null,
      ),
    );
  }

  Widget _buildDifferentTriggers(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        VelocityPopconfirm(
          title: '确认删除？',
          onConfirm: () {},
          child: const VelocityIconButton(
            icon: Icons.delete,
            tooltip: '删除',
          ),
        ),
        VelocityPopconfirm(
          title: '确认编辑？',
          onConfirm: () {},
          child: const VelocityIconButton(
            icon: Icons.edit,
            tooltip: '编辑',
          ),
        ),
        VelocityPopconfirm(
          title: '确认收藏？',
          onConfirm: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: VelocityColors.gray300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_border, size: 16),
                SizedBox(width: 4),
                Text('收藏'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
