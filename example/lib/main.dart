import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

// 导入所有演示页面
import 'components/rating_demo.dart';
import 'components/tree_demo.dart';
import 'components/tour_demo.dart';
import 'components/complete_demo.dart';
import 'components/avatar_demo.dart';
import 'components/badge_demo.dart';
import 'components/card_demo.dart';
import 'components/chip_demo.dart';
import 'components/divider_demo.dart';
import 'components/navigation_demo.dart';
import 'components/advanced_demo.dart';

void main() {
  runApp(const ZephyrUIDemoApp());
}

class ZephyrUIDemoApp extends StatelessWidget {
  const ZephyrUIDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrUI 专业组件库演示',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const DemoHomePage(),
      routes: {
        '/rating': (context) => const RatingDemo(),
        '/tree': (context) => const TreeDemo(),
        '/tour': (context) => const TourDemo(),
        '/complete': (context) => const CompleteComponentDemo(),
        '/avatar': (context) => const AvatarDemo(),
        '/badge': (context) => const BadgeDemo(),
        '/card': (context) => const CardDemo(),
        '/chip': (context) => const ChipDemo(),
        '/divider': (context) => const DividerDemo(),
        '/navigation': (context) => const NavigationComponentsDemo(),
        '/advanced': (context) => const AdvancedComponentsDemo(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 专业组件库'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showAboutDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => _toggleTheme(context),
          ),
        ],
      ),
      body: const _HomeContent(),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('关于 ZephyrUI'),
        content: const Text(
          'ZephyrUI 是一个专业的 Flutter UI 组件库，提供企业级的组件和主题系统，帮助开发者快速构建高质量的应用程序。',
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

  void _toggleTheme(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('主题设置'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('浅色主题'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: ThemeMode.system,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('深色主题'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: ThemeMode.system,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('跟随系统'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: ThemeMode.system,
                onChanged: (value) {},
              ),
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
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 欢迎横幅
          _buildWelcomeBanner(context),

          const SizedBox(height: 32),

          // 快速开始
          _buildQuickStart(context),

          const SizedBox(height: 32),

          // 核心组件展示
          _buildCoreComponents(context),

          const SizedBox(height: 32),

          // 高级功能
          _buildAdvancedFeatures(context),

          const SizedBox(height: 32),

          // 开发者资源
          _buildDeveloperResources(context),
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
            '欢迎使用 ZephyrUI',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '专业的 Flutter UI 组件库',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/complete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('开始体验'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () => _launchURL('https://github.com/agions/zephyr-ui'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('查看 GitHub'),
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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStepCard(
                  '1',
                  '添加依赖',
                  '在 pubspec.yaml 中添加 ZephyrUI 依赖',
                  '''dependencies:
  zephyr_ui: ^1.0.0''',
                  context,
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepCard(String step, String title, String description, String? code, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
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
        if (code != null) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCoreComponents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '核心组件',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
          children: [
            _buildComponentCard(
              context,
              Icons.person,
              '头像组件',
              '用户头像和图像标识',
              Colors.blue,
              '/avatar',
            ),
            _buildComponentCard(
              context,
              Icons.star,
              '评分组件',
              '交互式星级评分，支持半星显示',
              Colors.amber,
              '/rating',
            ),
            _buildComponentCard(
              context,
              Icons.account_tree,
              '树形组件',
              '层次结构数据展示，支持展开折叠',
              Colors.green,
              '/tree',
            ),
            _buildComponentCard(
              context,
              Icons.tour,
              '导览组件',
              '功能引导和用户教程',
              Colors.blue,
              '/tour',
            ),
            _buildComponentCard(
              context,
              Icons.notifications,
              '徽章组件',
              '计数和状态指示徽章',
              Colors.red,
              '/badge',
            ),
            _buildComponentCard(
              context,
              Icons.dashboard,
              '卡片组件',
              '内容卡片和容器',
              Colors.orange,
              '/card',
            ),
            _buildComponentCard(
              context,
              Icons.label,
              '标签组件',
              '标签和分类指示',
              Colors.purple,
              '/chip',
            ),
            _buildComponentCard(
              context,
              Icons.widgets,
              '完整示例',
              '所有组件的完整演示',
              Colors.purple,
              '/complete',
            ),
            _buildComponentCard(
              context,
              Icons.navigation,
              '导航组件',
              '完整的导航解决方案',
              Colors.indigo,
              '/navigation',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildComponentCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color color,
    String route,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '查看详情',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdvancedFeatures(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '高级功能',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildFeatureItem(
                  Icons.palette,
                  '主题系统',
                  '支持深色/浅色主题，完全可定制的样式系统',
                  context,
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.devices,
                  '响应式设计',
                  '适配手机、平板、桌面等多种设备尺寸',
                  context,
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.accessibility,
                  '无障碍设计',
                  '符合 WCAG 标准，支持屏幕阅读器',
                  context,
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.speed,
                  '性能优化',
                  '优化的渲染性能，流畅的用户体验',
                  context,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    IconData icon,
    String title,
    String description,
    BuildContext context,
  ) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Theme.of(context).primaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
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
    );
  }

  Widget _buildDeveloperResources(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '开发者资源',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildResourceCard(
              Icons.code,
              'GitHub 仓库',
              '开源代码和问题跟踪',
              () => _launchURL('https://github.com/agions/zephyr-ui'),
            ),
            _buildResourceCard(
              Icons.book,
              'README 文档',
              '项目说明和使用指南',
              () => _launchURL('https://github.com/agions/zephyr-ui/blob/main/README.md'),
            ),
            _buildResourceCard(
              Icons.description,
              'API 参考',
              '组件 API 文档和示例',
              () => _launchURL('https://github.com/agions/zephyr-ui/tree/main/docs'),
            ),
            _buildResourceCard(
              Icons.bug_report,
              '问题反馈',
              '报告问题和建议改进',
              () => _launchURL('https://github.com/agions/zephyr-ui/issues'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResourceCard(
    IconData icon,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) {
    // 这里应该使用 url_launcher 包打开链接
    debugPrint('Opening URL: $url');
  }
}

// 扩展方法
extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}
