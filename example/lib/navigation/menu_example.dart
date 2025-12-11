import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 导航组件示例 - 菜单
class MenuExample extends StatelessWidget {
  const MenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu 菜单'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('点击下方按钮弹出菜单', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            VelocityMenu(
              items: const [
                VelocityMenuItem(label: '发起群聊', value: 'chat', icon: Icons.chat_bubble_outline),
                VelocityMenuItem(label: '添加朋友', value: 'add', icon: Icons.person_add_alt),
                VelocityMenuItem(label: '扫一扫', value: 'scan', icon: Icons.qr_code_scanner),
                VelocityMenuItem.divider(),
                VelocityMenuItem(label: '收付款', value: 'money', icon: Icons.payment),
              ],
              onSelected: (value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('选中了: $value')));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: VelocityColors.primary, borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 4),
                    Text('功能菜单', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
