import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例 - Toast 轻提示
class ToastExample extends StatelessWidget {
  const ToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast 轻提示'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Toast 类型', _buildToastTypes(context)),
            _buildSection('Toast 位置', _buildToastPositions(context)),
            _buildSection('自定义持续时间', _buildCustomDuration(context)),
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

  Widget _buildToastTypes(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        VelocityButton.text(
          text: 'Info',
          onPressed: () {
            VelocityToast.show(
              context,
              message: '这是一条普通提示',
              type: VelocityToastType.info,
            );
          },
        ),
        VelocityButton.text(
          text: 'Success',
          type: VelocityButtonType.success,
          onPressed: () {
            VelocityToast.show(
              context,
              message: '操作成功！',
              type: VelocityToastType.success,
            );
          },
        ),
        VelocityButton.text(
          text: 'Warning',
          type: VelocityButtonType.warning,
          onPressed: () {
            VelocityToast.show(
              context,
              message: '请注意！',
              type: VelocityToastType.warning,
            );
          },
        ),
        VelocityButton.text(
          text: 'Error',
          type: VelocityButtonType.danger,
          onPressed: () {
            VelocityToast.show(
              context,
              message: '操作失败',
              type: VelocityToastType.error,
            );
          },
        ),
      ],
    );
  }

  Widget _buildToastPositions(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        VelocityButton.text(
          text: '顶部显示',
          type: VelocityButtonType.outline,
          onPressed: () {
            VelocityToast.show(
              context,
              message: '顶部提示',
              position: VelocityToastPosition.top,
            );
          },
        ),
        VelocityButton.text(
          text: '中间显示',
          type: VelocityButtonType.outline,
          onPressed: () {
            VelocityToast.show(
              context,
              message: '中间提示',
              position: VelocityToastPosition.center,
            );
          },
        ),
        VelocityButton.text(
          text: '底部显示',
          type: VelocityButtonType.outline,
          onPressed: () {
            VelocityToast.show(
              context,
              message: '底部提示',
              position: VelocityToastPosition.bottom,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCustomDuration(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        VelocityButton.text(
          text: '1秒',
          type: VelocityButtonType.secondary,
          onPressed: () {
            VelocityToast.show(
              context,
              message: '1秒后消失',
              duration: const Duration(seconds: 1),
            );
          },
        ),
        VelocityButton.text(
          text: '3秒',
          type: VelocityButtonType.secondary,
          onPressed: () {
            VelocityToast.show(
              context,
              message: '3秒后消失',
              duration: const Duration(seconds: 3),
            );
          },
        ),
        VelocityButton.text(
          text: '5秒',
          type: VelocityButtonType.secondary,
          onPressed: () {
            VelocityToast.show(
              context,
              message: '5秒后消失',
              duration: const Duration(seconds: 5),
            );
          },
        ),
      ],
    );
  }
}
