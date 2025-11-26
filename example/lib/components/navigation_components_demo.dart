import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/example_card.dart';
import '../services/theme_service.dart';
import 'package:provider/provider.dart';

class NavigationComponentsDemo extends StatefulWidget {
  const NavigationComponentsDemo({super.key});

  @override
  State<NavigationComponentsDemo> createState() =>
      _NavigationComponentsDemoState();
}

class _NavigationComponentsDemoState extends State<NavigationComponentsDemo> {
  int _bottomNavIndex = 0;
  int _currentStep = 1;
  int _tabIndex = 0;
  int _scrollableTabindex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    const Center(child: Text('搜索', style: TextStyle(fontSize: 24))),
    const Center(child: Text('收藏', style: TextStyle(fontSize: 24))),
    const Center(child: Text('我的', style: TextStyle(fontSize: 24))),
  ];

  final List<String> _stepTitles = ['选择商品', '填写信息', '确认订单', '支付完成'];
  final List<String> _stepContents = [
    '浏览并选择您想要购买的商品',
    '填写收货地址和支付信息',
    '确认订单信息并选择支付方式',
    '完成支付，等待收货'
  ];

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('导航组件'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
          ),
          IconButton(
            icon: Icon(
                themeService.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeService.toggleTheme(),
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
          _buildIntroduction(),
          const SizedBox(height: 32),
          _buildTabsExample(),
          const SizedBox(height: 32),
          _buildBottomNavExample(),
          const SizedBox(height: 32),
          _buildStepperExample(),
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
          _buildTabsExample(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildBottomNavExample(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildStepperExample(),
              ),
            ],
          ),
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
          _buildTabsExample(),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildBottomNavExample(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildStepperExample(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return const Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.navigation,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '导航组件',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '专业的导航解决方案，提升用户体验',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              _buildFeatureChip(Icons.tab, '标签页'),
              _buildFeatureChip(Icons.bottom_navigation, '底部导航'),
              _buildFeatureChip(Icons.stairs, '步骤指示器'),
              _buildFeatureChip(Icons.menu, '抽屉导航'),
              _buildFeatureChip(Icons.breadcrumbs, '面包屑'),
              _buildFeatureChip(Icons.swipe, '手势导航'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return const Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabsExample() {
    return ExampleCard(
      title: '智能标签页',
      code: '''DefaultTabController(
  length: 3,
  child: Column(
    children: [
      TabBar(
        onTap: (index) {
          // 标签切换回调
        },
        tabs: [
          Tab(text: '首页'),
          Tab(text: '发现'),
          Tab(text: '我的'),
        ],
      ),
      Expanded(
        child: TabBarView(
          children: [
            _buildHomeTab(),
            _buildDiscoverTab(),
            _buildProfileTab(),
          ],
        ),
      ),
    ],
  ),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '交互式标签页',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 300,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      onTap: (index) {
                        setState(() => _tabIndex = index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('切换到: ${['首页', '发现', '我的'][index]}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: '首页'),
                        Tab(text: '发现'),
                        Tab(text: '我的'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildInteractiveTabContent('首页', Icons.home,
                              '欢迎来到首页！这里是您最常用的功能入口。', ['快速开始', '最近使用', '推荐内容']),
                          _buildInteractiveTabContent('发现', Icons.explore,
                              '探索更多精彩内容和功能。', ['热门推荐', '最新动态', '分类浏览']),
                          _buildInteractiveTabContent('我的', Icons.person,
                              '个人信息和设置管理。', ['个人资料', '账户设置', '使用统计']),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '可滚动标签页',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 250,
              child: DefaultTabController(
                length: 6,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      onTap: (index) {
                        setState(() => _scrollableTabindex = index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('切换到: ${[
                              '首页',
                              '搜索',
                              '收藏',
                              '设置',
                              '帮助',
                              '关于'
                            ][index]}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(icon: Icon(Icons.home), text: '首页'),
                        Tab(icon: Icon(Icons.search), text: '搜索'),
                        Tab(icon: Icon(Icons.favorite), text: '收藏'),
                        Tab(icon: Icon(Icons.settings), text: '设置'),
                        Tab(icon: Icon(Icons.help), text: '帮助'),
                        Tab(icon: Icon(Icons.info), text: '关于'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildScrollableTabContent('首页', Icons.home, '主页内容'),
                          _buildScrollableTabContent(
                              '搜索', Icons.search, '搜索功能'),
                          _buildScrollableTabContent(
                              '收藏', Icons.favorite, '收藏列表'),
                          _buildScrollableTabContent(
                              '设置', Icons.settings, '系统设置'),
                          _buildScrollableTabContent('帮助', Icons.help, '帮助中心'),
                          _buildScrollableTabContent('关于', Icons.info, '关于我们'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveTabContent(
      String title, IconData icon, String description, List<String> items) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon,
                  size: 32, color: Theme.of(context).colorScheme.primary),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                      child: Text('${index + 1}'),
                    ),
                    title: Text(items[index]),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('点击了: ${items[index]}'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableTabContent(
      String title, IconData icon, String content) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                size: 48, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavExample() {
    return ExampleCard(
      title: '智能底部导航',
      code: '''Scaffold(
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: _currentIndex,
    onTap: (index) {
      setState(() {
        _currentIndex = index;
      });
    },
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        activeIcon: Icon(Icons.home, color: Colors.blue),
        label: '首页',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        activeIcon: Icon(Icons.search, color: Colors.blue),
        label: '搜索',
      ),
    ],
  ),
  body: _pages[_currentIndex],
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '交互式底部导航',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: _buildBottomNavContent(),
                  ),
                ),
                BottomNavigationBar(
                  currentIndex: _bottomNavIndex,
                  onTap: (index) {
                    setState(() => _bottomNavIndex = index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('切换到: ${['首页', '搜索', '收藏', '我的'][index]}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedItemColor: Colors.grey,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home,
                          color: Theme.of(context).colorScheme.primary),
                      label: '首页',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search_outlined),
                      activeIcon: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.primary),
                      label: '搜索',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      activeIcon: Icon(Icons.favorite,
                          color: Theme.of(context).colorScheme.primary),
                      label: '收藏',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      activeIcon: Icon(Icons.person,
                          color: Theme.of(context).colorScheme.primary),
                      label: '我的',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '带徽章的底部导航',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  height: 150,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications, size: 48, color: Colors.blue),
                        SizedBox(height: 8),
                        Text('通知中心', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 4),
                        Text('您有新的消息',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                BottomNavigationBar(
                  currentIndex: 0,
                  onTap: (index) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('点击了: ${['首页', '消息', '发现', '我的'][index]}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedItemColor: Colors.grey,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: '首页',
                    ),
                    BottomNavigationBarItem(
                      icon: Stack(
                        children: [
                          Icon(Icons.notifications_outlined),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      label: '消息',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore_outlined),
                      label: '发现',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: '我的',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavContent() {
    final List<Widget> contents = [
      _buildPageContent('首页', Icons.home, '欢迎回到首页！', ['今日推荐', '最近使用', '快捷功能']),
      _buildPageContent(
          '搜索', Icons.search, '搜索您需要的内容', ['热门搜索', '搜索历史', '高级搜索']),
      _buildPageContent(
          '收藏', Icons.favorite, '您收藏的内容', ['文章收藏', '图片收藏', '链接收藏']),
      _buildPageContent('我的', Icons.person, '个人中心', ['个人信息', '设置', '帮助']),
    ];

    return contents[_bottomNavIndex];
  }

  Widget _buildPageContent(
      String title, IconData icon, String description, List<String> features) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: features.map((feature) {
            return const Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                feature,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStepperExample() {
    return ExampleCard(
      title: '智能步骤指示器',
      code: '''Stepper(
  currentStep: _currentStep,
  onStepContinue: () {
    if (_currentStep < steps.length - 1) {
      setState(() {
        _currentStep += 1;
      });
    }
  },
  onStepCancel: () {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  },
  onStepTapped: (index) {
    setState(() {
      _currentStep = index;
    });
  },
  steps: [
    Step(
      title: Text('步骤 1'),
      content: Text('第一步的内容'),
      isActive: _currentStep >= 0,
      state: _currentStep > 0 ? StepState.complete : StepState.indexed,
    ),
  ],
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '交互式步骤指示器',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 500,
              child: Stepper(
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < _stepTitles.length - 1) {
                    setState(() => _currentStep++);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '进入步骤 ${_currentStep + 1}: ${_stepTitles[_currentStep]}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('所有步骤已完成！'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '返回步骤 ${_currentStep + 1}: ${_stepTitles[_currentStep]}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                },
                onStepTapped: (index) {
                  setState(() => _currentStep = index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('跳转到步骤 ${index + 1}: ${_stepTitles[index]}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                controlsBuilder: (context, details) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (_currentStep > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: details.onStepCancel,
                              child: Text('上一步'),
                            ),
                          ),
                        if (_currentStep > 0) SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: Text(_currentStep == _stepTitles.length - 1
                                ? '完成'
                                : '下一步'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                steps: List.generate(_stepTitles.length, (index) {
                  return Step(
                    title: Text(_stepTitles[index]),
                    content: const Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _stepContents[index],
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 12),
                          if (index == 0) _buildStep1Content(),
                          if (index == 1) _buildStep2Content(),
                          if (index == 2) _buildStep3Content(),
                          if (index == 3) _buildStep4Content(),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= index,
                    state: _getStepState(index),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '当前进度: 步骤 ${_currentStep + 1}/${_stepTitles.length} - ${_stepTitles[_currentStep]}',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StepState _getStepState(int index) {
    if (index < _currentStep) {
      return StepState.complete;
    } else if (index == _currentStep) {
      return StepState.editing;
    } else {
      return StepState.indexed;
    }
  }

  Widget _buildStep1Content() {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '商品名称',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_cart),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '数量',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.format_list_numbered),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep2Content() {
    return const Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: '收货地址',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
          maxLines: 2,
        ),
        SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            labelText: '联系电话',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildStep3Content() {
    return Column(
      children: [
        const Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('订单摘要', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('商品总价:'),
                  Text('¥299.00'),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('运费:'),
                  Text('¥10.00'),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('总计:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('¥309.00',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep4Content() {
    return Column(
      children: [
        const Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 48),
              SizedBox(height: 8),
              Text('订单已完成！',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('感谢您的购买，我们将尽快为您发货。'),
            ],
          ),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('导航组件说明'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('功能特性：', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• 交互式标签页切换'),
              Text('• 智能底部导航'),
              Text('• 步骤指示器'),
              Text('• 状态管理'),
              Text('• 用户反馈'),
              Text('• 主题化支持'),
              SizedBox(height: 16),
              Text('包含组件：', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• TabBar 和 TabBarView'),
              Text('• BottomNavigationBar'),
              Text('• Stepper'),
              Text('• PageView'),
              Text('• Drawer'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}
