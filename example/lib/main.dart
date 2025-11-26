import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

// 导入服务
import 'services/theme_service.dart';

// 导入演示页面
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
import 'pages/home_page.dart';
import 'pages/interactive_demo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: const ZephyrUIDemoApp(),
    ),
  );
}

class ZephyrUIDemoApp extends StatelessWidget {
  const ZephyrUIDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return MaterialApp(
      title: 'ZephyrUI 专业组件库演示',
      theme: themeService.getTheme(context),
      darkTheme: themeService.getTheme(context),
      themeMode: themeService.themeMode,
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
        '/interactive': (context) => const InteractiveDemoPage(),
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('zh', 'CN'),
      ],
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 应用栏
          SliverAppBar(
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            title: const Text('ZephyrUI'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => _showSearchDialog(context),
                tooltip: '搜索组件',
              ),
              IconButton(
                icon: const Icon(Icons.palette),
                onPressed: () => _showThemeDialog(context, themeService),
                tooltip: '主题设置',
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => _showAboutDialog(context),
                tooltip: '关于',
              ),
            ],
          ),

          // 主要内容
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 欢迎横幅
                _buildWelcomeBanner(context),

                const SizedBox(height: 32),

                // 统计数据
                _buildStatistics(context),

                const SizedBox(height: 32),

                // 快速开始
                _buildQuickStart(context),

                const SizedBox(height: 32),

                // 核心组件分类
                _buildComponentCategories(context),

                const SizedBox(height: 32),

                // 特色功能
                _buildFeatures(context),

                const SizedBox(height: 32),

                // 开发者资源
                _buildDeveloperResources(context),

                const SizedBox(height: 32),

                // 页脚
                _buildFooter(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner(BuildContext context) {
    return const Container(
      width: double.infinity,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '欢迎使用 ZephyrUI',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '企业级 Flutter UI 组件库',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/complete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '开始体验',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 16),
              OutlinedButton(
                onPressed: () => _showDocumentation(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '查看文档',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            '54+',
            '专业组件',
            Icons.widgets,
            Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            '7',
            '组件分类',
            Icons.category,
            Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            '100%',
            'TypeScript 支持',
            Icons.code,
            Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '快速开始',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Card(
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                _buildStepCard(
                  '1',
                  '添加依赖',
                  '在 pubspec.yaml 中添加 ZephyrUI 依赖',
                  '''dependencies:
  zephyr_ui: ^0.1.0''',
                  context,
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
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

  Widget _buildStepCard(
    String step,
    String title,
    String description,
    String? code,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (code != null) ...[
          const SizedBox(height: 16),
          const Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildComponentCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '组件分类',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _buildCategoryCard(
              context,
              Icons.widgets,
              '基础组件',
              '8 个基础 UI 组件',
              Colors.blue,
              () => Navigator.pushNamed(context, '/avatar'),
            ),
            _buildCategoryCard(
              context,
              Icons.edit,
              '表单组件',
              '13 个表单相关组件',
              Colors.green,
              () => Navigator.pushNamed(context, '/complete'),
            ),
            _buildCategoryCard(
              context,
              Icons.navigation,
              '导航组件',
              '8 个导航相关组件',
              Colors.orange,
              () => Navigator.pushNamed(context, '/navigation'),
            ),
            _buildCategoryCard(
              context,
              Icons.notifications,
              '反馈组件',
              '6 个反馈相关组件',
              Colors.red,
              () => Navigator.pushNamed(context, '/complete'),
            ),
            _buildCategoryCard(
              context,
              Icons.table_chart,
              '数据展示',
              '13 个数据展示组件',
              Colors.purple,
              () => Navigator.pushNamed(context, '/complete'),
            ),
            _buildCategoryCard(
              context,
              Icons.view_quilt,
              '布局组件',
              '4 个布局相关组件',
              Colors.teal,
              () => Navigator.pushNamed(context, '/complete'),
            ),
            _buildCategoryCard(
              context,
              Icons.auto_awesome,
              '高级组件',
              '16 个高级功能组件',
              Colors.indigo,
              () => Navigator.pushNamed(context, '/advanced'),
            ),
            _buildCategoryCard(
              context,
              Icons.star,
              '特色组件',
              '评分、树形、导览等',
              Colors.amber,
              () => Navigator.pushNamed(context, '/rating'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: color),
              SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '查看详情',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatures(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '特色功能',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Card(
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                _buildFeatureItem(
                  Icons.palette,
                  '专业主题系统',
                  '8 种预设主题，支持自定义颜色，深色/浅色模式切换',
                  context,
                ),
                SizedBox(height: 20),
                _buildFeatureItem(
                  Icons.devices,
                  '响应式设计',
                  '适配手机、平板、桌面等多种设备尺寸',
                  context,
                ),
                SizedBox(height: 20),
                _buildFeatureItem(
                  Icons.accessibility,
                  '无障碍设计',
                  '符合 WCAG 标准，支持屏幕阅读器和键盘导航',
                  context,
                ),
                SizedBox(height: 20),
                _buildFeatureItem(
                  Icons.speed,
                  '性能优化',
                  '优化的渲染性能，流畅的用户体验',
                  context,
                ),
                SizedBox(height: 20),
                _buildFeatureItem(
                  Icons.code,
                  'TypeScript 支持',
                  '完整的类型提示，提供优秀的开发体验',
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
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
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
        Text(
          '开发者资源',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
              '文档中心',
              '完整的 API 文档和使用指南',
              () => _showDocumentation(context),
            ),
            _buildResourceCard(
              Icons.bug_report,
              '问题反馈',
              '报告问题和建议改进',
              () => _launchURL('https://github.com/agions/zephyr-ui/issues'),
            ),
            _buildResourceCard(
              Icons.chat,
              '社区讨论',
              '与其他开发者交流经验',
              () =>
                  _launchURL('https://github.com/agions/zephyr-ui/discussions'),
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
        borderRadius: BorderRadius.circular(16),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
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

  Widget _buildFooter(BuildContext context) {
    return const Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'ZephyrUI - 用 ❤️ 制作',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Version 0.1.0 • Licensed under MIT',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
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
          'ZephyrUI 是一个专业的 Flutter UI 组件库，提供 54+ 企业级组件，帮助开发者快速构建高质量的应用程序。',
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

  void _showThemeDialog(BuildContext context, ThemeService themeService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('主题设置'),
        content: const SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 主题模式
              Column(
                children: [
                  ListTile(
                    title: Text('浅色主题'),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.light,
                      groupValue: themeService.themeMode,
                      onChanged: (value) => themeService.setThemeMode(value!),
                    ),
                  ),
                  ListTile(
                    title: Text('深色主题'),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.dark,
                      groupValue: themeService.themeMode,
                      onChanged: (value) => themeService.setThemeMode(value!),
                    ),
                  ),
                  ListTile(
                    title: Text('跟随系统'),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.system,
                      groupValue: themeService.themeMode,
                      onChanged: (value) => themeService.setThemeMode(value!),
                    ),
                  ),
                ],
              ),

              Divider(),

              // 预设主题
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ThemeService.themePresets.length,
                  itemBuilder: (context, index) {
                    final preset = ThemeService.themePresets[index];
                    final isSelected = themeService.themePreset == index;

                    return GestureDetector(
                      onTap: () => themeService.applyThemePreset(index),
                      child: const Container(
                        width: 80,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.withValues(alpha: 0.3),
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: preset['primary'],
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: preset['accent'],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('搜索组件'),
        content: const SizedBox(
          width: double.maxFinite,
          child: TextField(
            decoration: InputDecoration(
              hintText: '输入组件名称...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
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

  void _showDocumentation(BuildContext context) {
    // 这里可以打开文档页面
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('文档功能正在开发中...'),
      ),
    );
  }

  void _launchURL(String url) {
    // 这里应该使用 url_launcher 包打开链接
    debugPrint('Opening URL: $url');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('将在浏览器中打开: $url'),
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
    return const Container(
      width: double.infinity,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '欢迎使用 ZephyrUI',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '专业的 Flutter UI 组件库',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/complete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('开始体验'),
              ),
              SizedBox(width: 16),
              OutlinedButton(
                onPressed: () =>
                    _launchURL('https://github.com/agions/zephyr-ui'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white),
                ),
                child: Text('查看 GitHub'),
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
          child: const Padding(
            padding: EdgeInsets.all(20),
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
                SizedBox(height: 16),
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
                SizedBox(height: 16),
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

  Widget _buildStepCard(String step, String title, String description,
      String? code, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step,
                  style: TextStyle(
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
          const Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              code,
              style: TextStyle(
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
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: color),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '查看详情',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
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
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                _buildFeatureItem(
                  Icons.palette,
                  '主题系统',
                  '支持深色/浅色主题，完全可定制的样式系统',
                  context,
                ),
                SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.devices,
                  '响应式设计',
                  '适配手机、平板、桌面等多种设备尺寸',
                  context,
                ),
                SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.accessibility,
                  '无障碍设计',
                  '符合 WCAG 标准，支持屏幕阅读器',
                  context,
                ),
                SizedBox(height: 16),
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
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
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
              () => _launchURL(
                  'https://github.com/agions/zephyr-ui/blob/main/README.md'),
            ),
            _buildResourceCard(
              Icons.description,
              'API 参考',
              '组件 API 文档和示例',
              () => _launchURL(
                  'https://github.com/agions/zephyr-ui/tree/main/docs'),
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
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
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
