import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 导航组件示例 - 抽屉
class DrawerExample extends StatefulWidget {
  const DrawerExample({super.key});

  @override
  State<DrawerExample> createState() => _DrawerExampleState();
}

class _DrawerExampleState extends State<DrawerExample> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer 抽屉'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      drawer: VelocityDrawer(
        header: const UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: VelocityColors.primary),
          accountName: Text('Velocity UI'),
          accountEmail: Text('velocity@example.com'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('V', style: TextStyle(fontSize: 24, color: VelocityColors.primary)),
          ),
        ),
        items: [
          VelocityDrawerItem(icon: Icons.home, label: '首页', onTap: () => _onItemTapped(0)),
          VelocityDrawerItem(icon: Icons.message, label: '消息', onTap: () => _onItemTapped(1)),
          VelocityDrawerItem(icon: Icons.settings, label: '设置', onTap: () => _onItemTapped(2)),
          const VelocityDrawerItem.divider(),
          VelocityDrawerItem(icon: Icons.info, label: '关于', onTap: () => _onItemTapped(3)),
        ],
        selectedIndex: _selectedIndex,
        onItemTap: (index) {
          setState(() => _selectedIndex = index);
          Navigator.pop(context);
        },
        footer: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Version 1.0.0', style: TextStyle(color: Colors.grey)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('从左侧边缘向右滑动或点击左上角图标打开抽屉'),
            const SizedBox(height: 16),
            VelocityButton.text(
              text: '打开抽屉',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(height: 24),
            Text('当前选中项索引: $_selectedIndex'),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    // 处理导航逻辑
    print('点击了第 $index 项');
  }
}
