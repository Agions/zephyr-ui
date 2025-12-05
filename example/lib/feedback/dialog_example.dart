import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例 - 对话框
class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog 对话框'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('提示对话框', _buildAlertDialog(context)),
            _buildSection('确认对话框', _buildConfirmDialog(context)),
            _buildSection('自定义内容', _buildCustomDialog(context)),
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

  Widget _buildAlertDialog(BuildContext context) {
    return VelocityButton.text(
      text: '显示提示对话框',
      onPressed: () {
        VelocityDialog.alert(
          context,
          title: '操作提示',
          content: '您的数据已成功保存！',
          confirmText: '知道了',
        );
      },
    );
  }

  Widget _buildConfirmDialog(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        VelocityButton.text(
          text: '确认删除',
          type: VelocityButtonType.danger,
          onPressed: () async {
            final result = await VelocityDialog.confirm(
              context,
              title: '确认删除',
              content: '删除后数据将无法恢复，您确定要继续吗？',
              confirmText: '删除',
              cancelText: '取消',
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result == true ? '已确认删除' : '已取消')),
              );
            }
          },
        ),
        VelocityButton.text(
          text: '确认提交',
          onPressed: () async {
            final result = await VelocityDialog.confirm(
              context,
              title: '确认提交',
              content: '提交后将无法修改，请确认信息是否正确。',
              confirmText: '确认提交',
              cancelText: '返回修改',
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result == true ? '已提交' : '已取消')),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildCustomDialog(BuildContext context) {
    return VelocityButton.text(
      text: '显示自定义对话框',
      type: VelocityButtonType.outline,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('用户反馈'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('请为我们的服务评分：'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < 4 ? Icons.star : Icons.star_border,
                        color: VelocityColors.warning,
                      ),
                      onPressed: () {},
                    );
                  }),
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    hintText: '请输入您的建议...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('提交'),
              ),
            ],
          ),
        );
      },
    );
  }
}
