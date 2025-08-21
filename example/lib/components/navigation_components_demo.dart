import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/example_card.dart';

class NavigationComponentsDemo extends StatelessWidget {
  const NavigationComponentsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航组件'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '导航组件',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ZephyrUI 提供了多种导航组件，帮助用户在应用中轻松导航。',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTabsExample() {
    return ExampleCard(
      title: '标签页',
      code: '''DefaultTabController(
  length: 3,
  child: Column(
    children: [
      TabBar(
        tabs: [
          Tab(text: '标签1'),
          Tab(text: '标签2'),
          Tab(text: '标签3'),
        ],
      ),
      SizedBox(
        height: 200,
        child: TabBarView(
          children: [
            Center(child: Text('内容1')),
            Center(child: Text('内容2')),
            Center(child: Text('内容3')),
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
            '基础标签页',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: '首页'),
                      Tab(text: '发现'),
                      Tab(text: '我的'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTabContent('首页内容', Icons.home),
                        _buildTabContent('发现内容', Icons.explore),
                        _buildTabContent('我的内容', Icons.person),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '带图标的标签页',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    tabs: const [
                      Tab(icon: Icon(Icons.home), text: '首页'),
                      Tab(icon: Icon(Icons.search), text: '搜索'),
                      Tab(icon: Icon(Icons.favorite), text: '收藏'),
                      Tab(icon: Icon(Icons.settings), text: '设置'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        const Center(child: Text('首页内容')),
                        const Center(child: Text('搜索内容')),
                        const Center(child: Text('收藏内容')),
                        const Center(child: Text('设置内容')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
      title: '底部导航',
      code: '''Scaffold(
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: _currentIndex,
    onTap: (index) {
      setState(() {
        _currentIndex = index;
      });
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '首页',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
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
            '底部导航栏',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Text('内容区域'),
                  ),
                ),
                BottomNavigationBar(
                  currentIndex: 0,
                  onTap: (index) {},
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: '首页',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: '搜索',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: '收藏',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
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

  Widget _buildStepperExample() {
    return ExampleCard(
      title: '步骤指示器',
      code: '''Stepper(
  currentStep: _currentStep,
  onStepContinue: () {
    if (_currentStep < 2) {
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
  steps: [
    Step(
      title: Text('步骤 1'),
      content: Text('第一步的内容'),
    ),
    Step(
      title: Text('步骤 2'),
      content: Text('第二步的内容'),
    ),
    Step(
      title: Text('步骤 3'),
      content: Text('第三步的内容'),
    ),
  ],
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '垂直步骤指示器',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 400,
            child: Stepper(
              currentStep: 1,
              onStepContinue: () {},
              onStepCancel: () {},
              steps: [
                Step(
                  title: const Text('选择商品'),
                  content: const Text('选择您想要购买的商品'),
                  isActive: true,
                  state: StepState.complete,
                ),
                Step(
                  title: const Text('填写信息'),
                  content: const Text('填写收货地址和支付信息'),
                  isActive: true,
                  state: StepState.editing,
                ),
                Step(
                  title: const Text('确认订单'),
                  content: const Text('确认订单信息并支付'),
                  isActive: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}