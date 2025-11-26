import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/component_card.dart';

class AllComponentsDemo extends StatelessWidget {
  const AllComponentsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('全部组件演示'),
        elevation: 0,
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          _buildComponentGrid(context),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          _buildComponentGrid(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 40),
          _buildComponentGrid(context),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '全部组件演示',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '这里展示了 ZephyrUI 组件库中的所有组件，您可以点击每个组件查看详细的演示和使用方法。',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildComponentGrid(BuildContext context) {
    return const ResponsiveGrid(
      mobileColumns: 1,
      tabletColumns: 2,
      desktopColumns: 3,
      children: [
        ComponentCard(
          title: '基础组件',
          description: '按钮、文本、图标、卡片等基础UI组件',
          icon: Icons.widgets,
          color: Colors.blue,
          route: '/basic-components',
        ),
        ComponentCard(
          title: '表单组件',
          description: '输入框、选择器、表单验证等',
          icon: Icons.edit,
          color: Colors.green,
          route: '/form-components',
        ),
        ComponentCard(
          title: '布局组件',
          description: '容器、网格、折叠面板等',
          icon: Icons.grid_view,
          color: Colors.orange,
          route: '/layout-components',
        ),
        ComponentCard(
          title: '导航组件',
          description: '标签页、侧边栏、分页等',
          icon: Icons.navigation,
          color: Colors.purple,
          route: '/navigation-components',
        ),
        ComponentCard(
          title: '展示组件',
          description: '表格、列表、日历、时间线等',
          icon: Icons.view_quilt,
          color: Colors.red,
          route: '/display-components',
        ),
        ComponentCard(
          title: '反馈组件',
          description: '提示、进度、骨架屏等',
          icon: Icons.notifications,
          color: Colors.amber,
          route: '/feedback-components',
        ),
        ComponentCard(
          title: '高级组件',
          description: '图表、轮播、富文本编辑器等',
          icon: Icons.star,
          color: Colors.indigo,
          route: '/advanced-components',
        ),
        ComponentCard(
          title: '主题演示',
          description: '深色/浅色主题切换',
          icon: Icons.palette,
          color: Colors.teal,
          route: '/theme-demo',
        ),
        ComponentCard(
          title: '响应式演示',
          description: '不同设备尺寸适配',
          icon: Icons.devices,
          color: Colors.pink,
          route: '/responsive-demo',
        ),
      ],
    );
  }
}
