import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例 - 通知
class NotificationExample extends StatelessWidget {
  const NotificationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification 通知'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('通知类型', _buildNotificationTypes(context)),
            _buildSection('通知位置', _buildNotificationPositions(context)),
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

  Widget _buildNotificationTypes(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        VelocityButton.text(
          text: 'Info 通知',
          onPressed: () {
            VelocityNotification.show(
              context: context,
              title: '提示信息',
              message: '这是一条普通的信息通知',
              type: VelocityNotificationType.info,
            );
          },
        ),
        VelocityButton.text(
          text: 'Success 通知',
          type: VelocityButtonType.success,
          onPressed: () {
            VelocityNotification.show(
              context: context,
              title: '操作成功',
              message: '您的数据已成功保存',
              type: VelocityNotificationType.success,
            );
          },
        ),
        VelocityButton.text(
          text: 'Warning 通知',
          type: VelocityButtonType.warning,
          onPressed: () {
            VelocityNotification.show(
              context: context,
              title: '警告',
              message: '您的账户即将到期，请及时续费',
              type: VelocityNotificationType.warning,
            );
          },
        ),
        VelocityButton.text(
          text: 'Error 通知',
          type: VelocityButtonType.danger,
          onPressed: () {
            VelocityNotification.show(
              context: context,
              title: '错误',
              message: '网络连接失败，请检查网络设置',
              type: VelocityNotificationType.error,
            );
          },
        ),
      ],
    );
  }

  Widget _buildNotificationPositions(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        VelocityButton.text(
          text: '顶部通知',
          type: VelocityButtonType.outline,
          onPressed: () {
            VelocityNotification.show(
              context: context,
              title: '顶部通知',
              message: '这条通知显示在顶部',
              position: VelocityNotificationPosition.top,
            );
          },
        ),
        VelocityButton.text(
          text: '底部通知',
          type: VelocityButtonType.outline,
          onPressed: () {
            VelocityNotification.show(
              context: context,
              title: '底部通知',
              message: '这条通知显示在底部',
              position: VelocityNotificationPosition.bottom,
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
          text: '2秒后消失',
          type: VelocityButtonType.secondary,
          onPressed: () {
            VelocityNotification.show(
              context: context,
              title: '短时通知',
              message: '这条通知将在2秒后自动消失',
              duration: const Duration(seconds: 2),
            );
          },
        ),
        VelocityButton.text(
          text: '8秒后消失',
          type: VelocityButtonType.secondary,
          onPressed: () {
            VelocityNotification.show(
              context: context,
              title: '长时通知',
              message: '这条通知将在8秒后自动消失',
              duration: const Duration(seconds: 8),
            );
          },
        ),
      ],
    );
  }
}
