import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 导航组件示例 - 导航栏
class NavbarExample extends StatefulWidget {
  const NavbarExample({super.key});

  @override
  State<NavbarExample> createState() => _NavbarExampleState();
}

class _NavbarExampleState extends State<NavbarExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VelocityNavbar(
        title: 'Navbar 导航栏',
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: null),
          IconButton(icon: Icon(Icons.more_vert), onPressed: null),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('顶部导航栏', _buildTopNavbar()),
            _buildSection('底部导航栏', _buildBottomNavbar()),
          ],
        ),
      ),
      bottomNavigationBar: VelocityBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          VelocityBottomNavbarItem(icon: Icons.home, label: '首页'),
          VelocityBottomNavbarItem(icon: Icons.category, label: '分类'),
          VelocityBottomNavbarItem(icon: Icons.shopping_cart, label: '购物车'),
          VelocityBottomNavbarItem(icon: Icons.person, label: '我的'),
        ],
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

  Widget _buildTopNavbar() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: VelocityColors.gray200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Scaffold(
        appBar: const VelocityNavbar(
          title: '标题',
          leading: Icon(Icons.menu),
          actions: [Icon(Icons.share)],
        ),
        body: Container(color: VelocityColors.gray50),
      ),
    );
  }

  Widget _buildBottomNavbar() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: VelocityColors.gray200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Scaffold(
        body: Container(color: VelocityColors.gray50),
        bottomNavigationBar: VelocityBottomNavbar(
          currentIndex: 0,
          onTap: (index) {},
          items: const [
            VelocityBottomNavbarItem(icon: Icons.home, label: '首页'),
            VelocityBottomNavbarItem(icon: Icons.message, label: '消息'),
            VelocityBottomNavbarItem(icon: Icons.person, label: '我的'),
          ],
        ),
      ),
    );
  }
}
