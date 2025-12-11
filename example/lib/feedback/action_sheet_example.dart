import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例 - 动作面板
class ActionSheetExample extends StatelessWidget {
  const ActionSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ActionSheet 动作面板'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicActionSheet(context)),
            _buildSection('带标题和描述', _buildTitleActionSheet(context)),
            _buildSection('包含警示项', _buildDestructiveActionSheet(context)),
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

  Widget _buildBasicActionSheet(BuildContext context) {
    return VelocityButton(
      child: const Text('显示动作面板'),
      onPressed: () {
        VelocityActionSheet.show(
          context: context,
          actions: [
            VelocityActionSheetItem(label: '选项一', onTap: () => print('选中选项一')),
            VelocityActionSheetItem(label: '选项二', onTap: () => print('选中选项二')),
            VelocityActionSheetItem(label: '选项三', onTap: () => print('选中选项三')),
          ],
          cancelAction: const VelocityActionSheetItem(label: '取消'),
        );
      },
    );
  }

  Widget _buildTitleActionSheet(BuildContext context) {
    return VelocityButton(
      child: const Text('带标题和描述'),
      onPressed: () {
        VelocityActionSheet.show(
          context: context,
          title: '上传图片',
          message: '请选择图片来源',
          actions: [
            const VelocityActionSheetItem(label: '从相册选择'),
            const VelocityActionSheetItem(label: '拍照'),
          ],
          cancelAction: const VelocityActionSheetItem(label: '取消'),
        );
      },
    );
  }

  Widget _buildDestructiveActionSheet(BuildContext context) {
    return VelocityButton(
      child: const Text('包含警示项'),
      onPressed: () {
        VelocityActionSheet.show(
          context: context,
          title: '确定要删除吗？',
          message: '删除后无法恢复',
          actions: [
            VelocityActionSheetItem(
              label: '删除',
              isDestructive: true,
              onTap: () => print('删除'),
            ),
          ],
          cancelAction: const VelocityActionSheetItem(label: '取消'),
        );
      },
    );
  }
}
