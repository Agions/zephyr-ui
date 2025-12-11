import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例 - 结果页
class ResultExample extends StatelessWidget {
  const ResultExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result 结果页'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('成功结果', _buildSuccessResult()),
            _buildSection('错误结果', _buildErrorResult()),
            _buildSection('警告/信息结果', _buildWarningInfoResult()),
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

  Widget _buildSuccessResult() {
    return VelocityResult(
      type: VelocityResultType.success,
      title: '操作成功',
      subtitle: '提交的申请已成功受理，请等待审核。',
      actions: [
        VelocityButton(type: VelocityButtonType.primary, child: const Text('返回首页'), onPressed: () {}),
        VelocityButton(child: const Text('查看详情'), onPressed: () {}),
      ],
    );
  }

  Widget _buildErrorResult() {
    return VelocityResult(
      type: VelocityResultType.error,
      title: '操作失败',
      subtitle: '请检查网络连接后重试。',
      actions: [
        VelocityButton(type: VelocityButtonType.primary, child: const Text('重试'), onPressed: () {}),
      ],
    );
  }

  Widget _buildWarningInfoResult() {
    return Column(
      children: [
        const VelocityResult(
          type: VelocityResultType.warning,
          title: '存在风险',
          subtitle: '检测到当前环境可能存在安全风险。',
        ),
        const Divider(),
        VelocityResult(
          type: VelocityResultType.info,
          title: '版本更新',
          subtitle: '新版本 v1.2.0 已发布。',
          extra: const Text('包含多项性能优化和新功能。'),
          actions: [
            VelocityButton(size: VelocityButtonSize.small, child: const Text('去更新'), onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
