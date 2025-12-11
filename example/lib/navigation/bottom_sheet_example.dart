import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 导航组件示例 - 底部面板
class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomSheet 底部面板'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础面板', _buildBasicSheet(context)),
            _buildSection('自定义内容', _buildCustomContentSheet(context)),
            _buildSection('操作列表', _buildActionListSheet(context)),
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

  Widget _buildBasicSheet(BuildContext context) {
    return VelocityButton(
      child: const Text('显示基础面板'),
      onPressed: () {
        VelocityBottomSheet.show(
          context: context,
          title: '基础面板',
          height: 200,
          child: const Center(child: Text('这里是内容区域')),
        );
      },
    );
  }

  Widget _buildCustomContentSheet(BuildContext context) {
    return VelocityButton(
      child: const Text('显示自定义内容'),
      onPressed: () {
        VelocityBottomSheet.show(
          context: context,
          title: '选择商品',
          showCloseButton: true,
          child: Column(
            children: [
              ListTile(title: const Text('商品 A'), trailing: VelocityCounter(value: 1, onChanged: (v){})),
              ListTile(title: const Text('商品 B'), trailing: VelocityCounter(value: 0, onChanged: (v){})),
              const SizedBox(height: 20),
              VelocityButton(
                fullWidth: true,
                type: VelocityButtonType.primary,
                child: const Text('确认添加'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionListSheet(BuildContext context) {
    return VelocityButton(
      child: const Text('显示操作列表'),
      onPressed: () {
        VelocityBottomSheet.showActions(
          context: context,
          title: '分享到',
          cancelText: '取消',
          actions: [
            VelocityBottomSheetAction(label: '微信', icon: Icons.wechat, onTap: () {}),
            VelocityBottomSheetAction(label: '朋友圈', icon: Icons.camera_alt, onTap: () {}),
            VelocityBottomSheetAction(label: '复制链接', icon: Icons.link, onTap: () {}),
          ],
        );
      },
    );
  }
}
