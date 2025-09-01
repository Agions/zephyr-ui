import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../routes/app_routes.dart';
import '../widgets/component_card.dart';
import '../widgets/feature_card.dart';
import '../widgets/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 组件库'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => _showThemeDialog(context, themeService),
            tooltip: '切换主题',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showAboutDialog(context),
            tooltip: '关于',
          ),
        ],
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
          _buildWelcomeBanner(context),
          const SizedBox(height: 32),
          _buildQuickStart(context),
          const SizedBox(height: 32),
          _buildComponentCategories(context),
          const SizedBox(height: 32),
          _buildFeatures(context),
          const SizedBox(height: 32),
          _buildResources(context),
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
          _buildWelcomeBanner(context),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: _buildQuickStart(context),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: _buildFeatures(context),
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildComponentCategories(context),
          const SizedBox(height: 40),
          _buildResources(context),
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
          _buildWelcomeBanner(context),
          const SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildQuickStart(context),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: _buildFeatures(context),
              ),
            ],
          ),
          const SizedBox(height: 48),
          _buildComponentCategories(context),
          const SizedBox(height: 48),
          _buildResources(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ZephyrUI',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '专业的 Flutter UI 组件库',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.allComponents),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('开始体验'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.themeDemo),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('主题演示'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '快速开始',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStepCard(
                  '1',
                  '添加依赖',
                  '在 pubspec.yaml 中添加 ZephyrUI 依赖',
                  '''dependencies:
  zephyr_ui: ^0.3.0''',
                  context,
                ),
                const SizedBox(height: 20),
                _buildStepCard(
                  '2',
                  '导入使用',
                  '在 Dart 文件中导入并使用组件',
                  '''import 'package:zephyr_ui/zephyr_ui.dart';

ZephyrButton(
  text: '点击我',
  onPressed: () {},
)''',
                  context,
                ),
                const SizedBox(height: 20),
                _buildStepCard(
                  '3',
                  '主题配置',
                  '配置全局主题和样式',
                  '''MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrThemeData(
        primaryColor: Colors.blue,
      ),
    ],
  ),
  home: MyApp(),
)''',
                  context,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.play_circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '新功能：交互式演示',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '现在您可以实时调整组件参数，查看效果变化！',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/interactive-demo');
                          },
                          child: const Text('体验交互式演示'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepCard(String step, String title, String description, String code, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComponentCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '组件分类',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ResponsiveGrid(
          children: [
            ComponentCard(
              title: '基础组件',
              description: '按钮、文本、图标等基础UI组件',
              icon: Icons.widgets,
              color: Colors.blue,
              route: AppRoutes.basicComponents,
            ),
            ComponentCard(
              title: '表单组件',
              description: '输入框、选择器、表单验证等',
              icon: Icons.edit,
              color: Colors.green,
              route: AppRoutes.formComponents,
            ),
            ComponentCard(
              title: '布局组件',
              description: '容器、网格、折叠面板等',
              icon: Icons.grid_view,
              color: Colors.orange,
              route: AppRoutes.layoutComponents,
            ),
            ComponentCard(
              title: '导航组件',
              description: '标签页、侧边栏、分页等',
              icon: Icons.navigation,
              color: Colors.purple,
              route: AppRoutes.navigationComponents,
            ),
            ComponentCard(
              title: '展示组件',
              description: '表格、列表、日历、时间线等',
              icon: Icons.view_quilt,
              color: Colors.red,
              route: AppRoutes.displayComponents,
            ),
            ComponentCard(
              title: '反馈组件',
              description: '提示、进度、骨架屏等',
              icon: Icons.notifications,
              color: Colors.amber,
              route: AppRoutes.feedbackComponents,
            ),
            ComponentCard(
              title: '高级组件',
              description: '图表、轮播、富文本编辑器等',
              icon: Icons.star,
              color: Colors.indigo,
              route: AppRoutes.advancedComponents,
            ),
            ComponentCard(
              title: '全部组件',
              description: '查看所有组件的完整演示',
              icon: Icons.apps,
              color: Colors.teal,
              route: AppRoutes.allComponents,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '核心特性',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            FeatureCard(
              icon: Icons.palette,
              title: '主题系统',
              description: '支持深色/浅色主题，完全可定制的样式系统',
              onTap: () => Navigator.pushNamed(context, AppRoutes.themeDemo),
            ),
            const SizedBox(height: 12),
            FeatureCard(
              icon: Icons.devices,
              title: '响应式设计',
              description: '适配手机、平板、桌面等多种设备尺寸',
              onTap: () => Navigator.pushNamed(context, AppRoutes.responsiveDemo),
            ),
            const SizedBox(height: 12),
            FeatureCard(
              icon: Icons.speed,
              title: '性能优化',
              description: '优化的渲染性能，流畅的用户体验',
              onTap: () => Navigator.pushNamed(context, AppRoutes.performanceDemo),
            ),
            const SizedBox(height: 12),
            FeatureCard(
              icon: Icons.accessibility,
              title: '无障碍设计',
              description: '符合 WCAG 标准，支持屏幕阅读器',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResources(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '开发者资源',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ResponsiveGrid(
          children: [
            ComponentCard(
              title: 'API 文档',
              description: '完整的 API 参考文档',
              icon: Icons.code,
              color: Colors.blue,
              route: '',
            ),
            ComponentCard(
              title: '使用指南',
              description: '详细的使用教程和最佳实践',
              icon: Icons.book,
              color: Colors.green,
              route: '',
            ),
            ComponentCard(
              title: 'GitHub',
              description: '开源代码和问题跟踪',
              icon: Icons.code,
              color: Colors.orange,
              route: '',
            ),
            ComponentCard(
              title: '社区',
              description: '加入开发者社区讨论',
              icon: Icons.people,
              color: Colors.purple,
              route: '',
            ),
          ],
        ),
      ],
    );
  }

  void _showThemeDialog(BuildContext context, ThemeService themeService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('主题设置'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('浅色主题'),
              value: ThemeMode.light,
              groupValue: themeService.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeService.setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('深色主题'),
              value: ThemeMode.dark,
              groupValue: themeService.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeService.setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('跟随系统'),
              value: ThemeMode.system,
              groupValue: themeService.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeService.setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('关于 ZephyrUI'),
        content: const Text(
          'ZephyrUI 是一个专业的 Flutter UI 组件库，提供企业级的组件和主题系统，帮助开发者快速构建高质量的应用程序。\n\n'
          '特性：\n'
          '• 60+ 高质量组件\n'
          '• 完整的主题系统\n'
          '• 响应式设计\n'
          '• 性能优化\n'
          '• 无障碍支持',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
