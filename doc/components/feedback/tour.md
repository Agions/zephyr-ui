# ZephyrTour 引导组件

引导组件是ZephyrUI反馈系统中的重要组件，用于向用户展示产品功能和使用方法。支持多种引导类型、自定义样式和交互方式，是提升用户体验的重要工具。

## 🎯 组件概述

### 特性
- **多种引导类型**: 支持步骤引导、功能引导、特性引导等多种类型
- **灵活样式**: 支持自定义颜色、位置、动画等样式
- **丰富交互**: 支持点击、滑动、跳过、完成等交互
- **多种布局**: 支持覆盖层、弹出框、侧边栏等多种布局
- **动画效果**: 内置平滑的显示/隐藏动画
- **主题适配**: 完整的主题系统支持

### 适用场景
- 新用户引导
- 功能介绍
- 产品特性展示
- 使用教程
- 更新说明
- 功能提示

## 🚀 基础用法

### 基本引导组件

```dart
class BasicTourExample extends StatefulWidget {
  @override
  _BasicTourExampleState createState() => _BasicTourExampleState();
}

class _BasicTourExampleState extends State<BasicTourExample> {
  bool _showTour = false;
  int _currentStep = 0;

  final List<ZephyrTourStep> _tourSteps = [
    ZephyrTourStep(
      id: 'welcome',
      title: '欢迎使用',
      content: '这是一个基本的产品引导示例',
      order: 0,
    ),
    ZephyrTourStep(
      id: 'navigation',
      title: '导航菜单',
      content: '点击这里可以访问不同的功能模块',
      targetKey: GlobalKey(), // 实际使用时需要绑定到具体控件
      order: 1,
    ),
    ZephyrTourStep(
      id: 'settings',
      title: '用户设置',
      content: '在这里可以管理您的个人设置',
      targetKey: GlobalKey(),
      order: 2,
    ),
    ZephyrTourStep(
      id: 'start',
      title: '开始使用',
      content: '现在您可以开始使用我们的产品了',
      order: 3,
    ),
  ];

  void _startTour() {
    setState(() {
      _showTour = true;
      _currentStep = 0;
    });
  }

  void _nextStep() {
    if (_currentStep < _tourSteps.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _completeTour() {
    setState(() => _showTour = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('引导已完成')),
    );
  }

  void _skipTour() {
    setState(() => _showTour = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('引导已跳过')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本引导组件'),
      ),
      body: Stack(
        children: [
          // 主内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTour,
                  child: Text('开始引导'),
                ),
                SizedBox(height: 24),
                // 模拟的一些UI元素
                Container(
                  width: 200,
                  height: 50,
                  color: Colors.blue[100],
                  child: Center(child: Text('导航菜单')),
                ),
                SizedBox(height: 16),
                Container(
                  width: 200,
                  height: 50,
                  color: Colors.green[100],
                  child: Center(child: Text('用户设置')),
                ),
              ],
            ),
          ),
          
          // 引导覆盖层
          if (_showTour)
            ZephyrTour(
              key: GlobalKey(),
              steps: _tourSteps,
              currentStepId: _tourSteps[_currentStep].id,
              autoStart: true,
              showSkipButton: true,
              showNextButton: true,
              showPreviousButton: true,
              showProgress: true,
              showStepNumbers: true,
              allowSkip: true,
              allowNavigation: true,
              onTourStart: () {
                print('Tour started');
              },
              onTourComplete: _completeTour,
              onTourSkip: _skipTour,
              onStepChange: (step) {
                setState(() {
                  _currentStep = _tourSteps.indexWhere((s) => s.id == step.id);
                });
              },
              child: Container(), // 需要提供child参数
            ),
        ],
      ),
    );
  }
}
```

### 功能引导组件

```dart
class FeatureTourExample extends StatefulWidget {
  @override
  _FeatureTourExampleState createState() => _FeatureTourExampleState();
}

class _FeatureTourExampleState extends State<FeatureTourExample> {
  bool _showFeatureTour = false;
  int _currentStep = 0;

  final List<ZephyrTourStep> _featureSteps = [
    ZephyrTourStep(
      id: 'search',
      title: '搜索功能',
      content: '使用搜索功能快速找到您需要的内容',
      targetKey: GlobalKey(),
      order: 0,
      customWidget: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, size: 48, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              '快速搜索',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('支持全文搜索和智能推荐'),
          ],
        ),
      ),
    ),
    ZephyrTourStep(
      id: 'favorite',
      title: '收藏功能',
      content: '收藏您喜欢的内容，方便以后查看',
      targetKey: GlobalKey(),
      order: 1,
    ),
    ZephyrTourStep(
      id: 'share',
      title: '分享功能',
      content: '将精彩内容分享给您的朋友',
      targetKey: GlobalKey(),
      order: 2,
    ),
    ZephyrTourStep(
      id: 'settings',
      title: '设置功能',
      content: '个性化您的使用体验',
      targetKey: GlobalKey(),
      order: 3,
    ),
  ];

  void _startFeatureTour() {
    setState(() {
      _showFeatureTour = true;
      _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('功能引导组件'),
      ),
      body: Stack(
        children: [
          // 主内容
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _startFeatureTour,
                  child: Text('开始功能引导'),
                ),
                SizedBox(height: 24),
                
                // 功能展示区域
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  children: [
                    _buildFeatureCard('搜索', Icons.search, Colors.blue),
                    _buildFeatureCard('收藏', Icons.favorite, Colors.red),
                    _buildFeatureCard('分享', Icons.share, Colors.green),
                    _buildFeatureCard('设置', Icons.settings, Colors.orange),
                  ],
                ),
              ],
            ),
          ),
          
          // 功能引导
          if (_showFeatureTour)
            ZephyrTour(
              key: GlobalKey(),
              steps: _featureSteps,
              currentStepId: _featureSteps[_currentStep].id,
              autoStart: true,
              theme: ZephyrTourTheme.light(),
              onTourComplete: () {
                setState(() => _showFeatureTour = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('功能引导已完成')),
                );
              },
              onTourSkip: () {
                setState(() => _showFeatureTour = false);
              },
              onStepChange: (step) {
                setState(() {
                  _currentStep = _featureSteps.indexWhere((s) => s.id == step.id);
                });
              },
              child: Container(),
            ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 产品特性引导组件

```dart
class ProductTourExample extends StatefulWidget {
  @override
  _ProductTourExampleState createState() => _ProductTourExampleState();
}

class _ProductTourExampleState extends State<ProductTourExample> {
  bool _showProductTour = false;
  int _currentStep = 0;

  final List<ZephyrTourStep> _productSteps = [
    ZephyrTourStep(
      id: 'performance',
      title: '高性能',
      content: '我们的产品具有卓越的性能表现',
      order: 0,
      customWidget: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue[200]!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.speed, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              '极致性能',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              '响应时间 < 100ms',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue[600],
              ),
            ),
          ],
        ),
      ),
    ),
    ZephyrTourStep(
      id: 'usability',
      title: '易用性',
      content: '简洁直观的用户界面，让您轻松上手',
      order: 1,
    ),
    ZephyrTourStep(
      id: 'security',
      title: '安全性',
      content: '采用先进的安全技术，保护您的数据',
      order: 2,
    ),
    ZephyrTourStep(
      id: 'scalability',
      title: '可扩展性',
      content: '灵活的架构，支持您的业务增长',
      order: 3,
    ),
  ];

  void _startProductTour() {
    setState(() {
      _showProductTour = true;
      _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('产品特性引导组件'),
      ),
      body: Stack(
        children: [
          // 主内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startProductTour,
                  child: Text('了解产品特性'),
                ),
                SizedBox(height: 32),
                
                // 产品特性展示
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildFeatureCard('高性能', Icons.speed, Colors.blue),
                    _buildFeatureCard('易用性', Icons.touch_app, Colors.green),
                    _buildFeatureCard('安全性', Icons.security, Colors.orange),
                    _buildFeatureCard('可扩展性', Icons.extension, Colors.purple),
                  ],
                ),
              ],
            ),
          ),
          
          // 产品特性引导
          if (_showProductTour)
            ZephyrTour(
              key: GlobalKey(),
              steps: _productSteps,
              currentStepId: _productSteps[_currentStep].id,
              autoStart: true,
              theme: ZephyrTourTheme(
                backgroundColor: Colors.white,
                textColor: Colors.black87,
                primaryColor: Colors.blue,
                overlayColor: Colors.black.withOpacity(0.5),
                highlightColor: Colors.blue.withOpacity(0.2),
                titleStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                contentStyle: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              onTourComplete: () {
                setState(() => _showProductTour = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('产品特性引导已完成')),
                );
              },
              onStepChange: (step) {
                setState(() {
                  _currentStep = _productSteps.indexWhere((s) => s.id == step.id);
                });
              },
              child: Container(),
            ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, Color color) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: color),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义样式引导组件

```dart
class CustomStyleTourExample extends StatefulWidget {
  @override
  _CustomStyleTourExampleState createState() => _CustomStyleTourExampleState();
}

class _CustomStyleTourExampleState extends State<CustomStyleTourExample> {
  bool _showTour = false;
  int _currentStep = 0;

  final List<ZephyrTourStep> _tourSteps = [
    ZephyrTourStep(
      id: 'welcome',
      title: '欢迎使用',
      content: '这是一个自定义样式的引导示例',
      order: 0,
    ),
    ZephyrTourStep(
      id: 'features',
      title: '功能介绍',
      content: '了解我们产品的核心功能',
      order: 1,
    ),
    ZephyrTourStep(
      id: 'start',
      title: '开始使用',
      content: '现在您可以开始使用我们的产品了',
      order: 2,
    ),
  ];

  void _startTour() {
    setState(() {
      _showTour = true;
      _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义样式引导组件'),
      ),
      body: Stack(
        children: [
          // 主内容
          Center(
            child: ElevatedButton(
              onPressed: _startTour,
              child: Text('开始自定义样式引导'),
            ),
          ),
          
          // 自定义样式引导
          if (_showTour)
            ZephyrTour(
              key: GlobalKey(),
              steps: _tourSteps,
              currentStepId: _tourSteps[_currentStep].id,
              autoStart: true,
              theme: ZephyrTourTheme(
                backgroundColor: Colors.purple[50],
                textColor: Colors.purple[800],
                primaryColor: Colors.purple,
                secondaryColor: Colors.purple[200],
                overlayColor: Colors.black.withOpacity(0.7),
                highlightColor: Colors.purple.withOpacity(0.3),
                highlightBorderColor: Colors.purple,
                highlightBorderRadius: 16,
                highlightPadding: 12,
                titleStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[800],
                ),
                contentStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.purple[600],
                  height: 1.6,
                ),
                buttonStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                tooltipDecoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple[200]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                tooltipPadding: EdgeInsets.all(20),
              ),
              overlayColor: Colors.black.withOpacity(0.6),
              animationDuration: Duration(milliseconds: 400),
              onTourComplete: () {
                setState(() => _showTour = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('自定义样式引导已完成')),
                );
              },
              onStepChange: (step) {
                setState(() {
                  _currentStep = _tourSteps.indexWhere((s) => s.id == step.id);
                });
              },
              child: Container(),
            ),
        ],
      ),
    );
  }
}
```

### 侧边栏引导组件

```dart
class SidebarTourExample extends StatefulWidget {
  @override
  _SidebarTourExampleState createState() => _SidebarTourExampleState();
}

class _SidebarTourExampleState extends State<SidebarTourExample> {
  bool _showTour = false;
  int _currentStep = 0;

  final List<ZephyrTourStep> _tourSteps = [
    ZephyrTourStep(
      id: 'sidebar',
      title: '侧边栏导航',
      content: '使用侧边栏快速访问不同功能',
      targetKey: GlobalKey(),
      order: 0,
    ),
    ZephyrTourStep(
      id: 'profile',
      title: '用户信息',
      content: '查看和编辑您的个人信息',
      targetKey: GlobalKey(),
      order: 1,
    ),
    ZephyrTourStep(
      id: 'settings',
      title: '设置选项',
      content: '自定义您的应用设置',
      targetKey: GlobalKey(),
      order: 2,
    ),
  ];

  void _startTour() {
    setState(() {
      _showTour = true;
      _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('侧边栏引导组件'),
      ),
      body: Stack(
        children: [
          // 主内容
          Row(
            children: [
              // 侧边栏
              Container(
                width: 200,
                color: Colors.grey[100],
                child: Column(
                  children: [
                    _buildSidebarItem('首页', Icons.home),
                    _buildSidebarItem('用户', Icons.person),
                    _buildSidebarItem('设置', Icons.settings),
                  ],
                ),
              ),
              
              // 内容区域
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: _startTour,
                    child: Text('开始侧边栏引导'),
                  ),
                ),
              ),
            ],
          ),
          
          // 侧边栏引导
          if (_showTour)
            ZephyrTour(
              key: GlobalKey(),
              steps: _tourSteps,
              currentStepId: _tourSteps[_currentStep].id,
              autoStart: true,
              tooltipOffset: Offset(-220, 0), // 向左偏移显示
              onTourComplete: () {
                setState(() => _showTour = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('侧边栏引导已完成')),
                );
              },
              onStepChange: (step) {
                setState(() {
                  _currentStep = _tourSteps.indexWhere((s) => s.id == step.id);
                });
              },
              child: Container(),
            ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 12),
          Text(title),
        ],
      ),
    );
  }
}
```

## 🔧 高级用法

### 可交互引导组件

```dart
class InteractiveTourExample extends StatefulWidget {
  @override
  _InteractiveTourExampleState createState() => _InteractiveTourExampleState();
}

class _InteractiveTourExampleState extends State<InteractiveTourExample> {
  bool _showTour = false;
  int _currentStep = 0;
  bool _buttonClicked = false;
  bool _switchToggled = false;

  final List<ZephyrTourStep> _tourSteps = [
    ZephyrTourStep(
      id: 'button',
      title: '交互按钮',
      content: '点击这个按钮来体验交互式引导',
      targetKey: GlobalKey(),
      order: 0,
      onShow: () {
        // 当步骤显示时的回调
        print('Button step shown');
      },
      onComplete: () {
        // 当步骤完成时的回调
        setState(() => _buttonClicked = true);
      },
    ),
    ZephyrTourStep(
      id: 'switch',
      title: '交互开关',
      content: '切换这个开关来体验交互式引导',
      targetKey: GlobalKey(),
      order: 1,
      onComplete: () {
        setState(() => _switchToggled = !_switchToggled);
      },
    ),
    ZephyrTourStep(
      id: 'complete',
      title: '引导完成',
      content: '恭喜您完成了交互式引导',
      order: 2,
    ),
  ];

  void _startTour() {
    setState(() {
      _showTour = true;
      _currentStep = 0;
      _buttonClicked = false;
      _switchToggled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可交互引导组件'),
      ),
      body: Stack(
        children: [
          // 主内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTour,
                  child: Text('开始交互式引导'),
                ),
                SizedBox(height: 32),
                
                // 交互元素
                ElevatedButton(
                  onPressed: () {
                    setState(() => _buttonClicked = true);
                  },
                  child: Text(_buttonClicked ? '已点击' : '点击我'),
                ),
                SizedBox(height: 16),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('开关:'),
                    SizedBox(width: 8),
                    Switch(
                      value: _switchToggled,
                      onChanged: (value) {
                        setState(() => _switchToggled = value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 交互式引导
          if (_showTour)
            ZephyrTour(
              key: GlobalKey(),
              steps: _tourSteps,
              currentStepId: _tourSteps[_currentStep].id,
              autoStart: true,
              storageKey: 'interactive_tour',
              persistenceMode: ZephyrTourPersistence.sharedPreferences,
              onTourComplete: () {
                setState(() => _showTour = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('交互式引导已完成')),
                );
              },
              onStepChange: (step) {
                setState(() {
                  _currentStep = _tourSteps.indexWhere((s) => s.id == step.id);
                });
                // 记录步骤完成
                print('Step completed: ${step.title}');
              },
              child: Container(),
            ),
        ],
      ),
    );
  }
}
```

### 条件引导组件

```dart
class ConditionalTourExample extends StatefulWidget {
  @override
  _ConditionalTourExampleState createState() => _ConditionalTourExampleState();
}

class _ConditionalTourExampleState extends State<ConditionalTourExample> {
  bool _showTour = false;
  int _currentStep = 0;
  bool _hasPremium = false;
  bool _hasCompletedSetup = false;

  List<ZephyrTourStep> get _tourSteps {
    final steps = <ZephyrTourStep>[
      ZephyrTourStep(
        id: 'welcome',
        title: '欢迎使用',
        content: '欢迎使用我们的产品',
        order: 0,
      ),
      ZephyrTourStep(
        id: 'basic',
        title: '基本功能',
        content: '了解产品的基本功能',
        order: 1,
      ),
    ];

    // 根据条件添加不同的步骤
    if (!_hasCompletedSetup) {
      steps.add(ZephyrTourStep(
        id: 'setup',
        title: '完成设置',
        content: '请先完成基本设置',
        order: 2,
        isOptional: false,
      ));
    }

    if (!_hasPremium) {
      steps.add(ZephyrTourStep(
        id: 'premium',
        title: '升级到高级版',
        content: '解锁更多高级功能',
        order: 3,
        isOptional: true,
      ));
    }

    steps.add(ZephyrTourStep(
      id: 'start',
      title: '开始使用',
      content: '现在您可以开始使用了',
      order: 4,
    ));

    return steps;
  }

  void _startTour() {
    setState(() {
      _showTour = true;
      _currentStep = 0;
    });
  }

  void _completeSetup() {
    setState(() => _hasCompletedSetup = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('设置已完成')),
    );
  }

  void _upgradeToPremium() {
    setState(() => _hasPremium = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已升级到高级版')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('条件引导组件'),
      ),
      body: Stack(
        children: [
          // 主内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTour,
                  child: Text('开始条件引导'),
                ),
                SizedBox(height: 32),
                
                // 状态显示
                Text('设置状态: ${_hasCompletedSetup ? "已完成" : "未完成"}'),
                Text('会员状态: ${_hasPremium ? "高级版" : "免费版"}'),
                SizedBox(height: 16),
                
                // 操作按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _hasCompletedSetup ? null : _completeSetup,
                      child: Text('完成设置'),
                    ),
                    ElevatedButton(
                      onPressed: _hasPremium ? null : _upgradeToPremium,
                      child: Text('升级高级版'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 条件引导
          if (_showTour)
            ZephyrTour(
              key: GlobalKey(),
              steps: _tourSteps,
              currentStepId: _tourSteps[_currentStep].id,
              autoStart: true,
              allowSkip: true,
              showSkipButton: true,
              onTourComplete: () {
                setState(() => _showTour = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('条件引导已完成')),
                );
              },
              onStepChange: (step) {
                setState(() {
                  _currentStep = _tourSteps.indexWhere((s) => s.id == step.id);
                });
              },
              child: Container(),
            ),
        ],
      ),
    );
  }
}
```

### 动态引导组件

```dart
class DynamicTourExample extends StatefulWidget {
  @override
  _DynamicTourExampleState createState() => _DynamicTourExampleState();
}

class _DynamicTourExampleState extends State<DynamicTourExample> {
  bool _showTour = false;
  int _currentStep = 0;
  List<ZephyrTourStep> _tourSteps = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTourSteps();
  }

  Future<void> _loadTourSteps() async {
    // 模拟从服务器加载引导步骤
    await Future.delayed(Duration(milliseconds: 1000));
    
    setState(() {
      _tourSteps = [
        ZephyrTourStep(
          id: 'dynamic1',
          title: '动态步骤 1',
          content: '这是从服务器加载的第一个步骤',
          order: 0,
        ),
        ZephyrTourStep(
          id: 'dynamic2',
          title: '动态步骤 2',
          content: '这是从服务器加载的第二个步骤',
          order: 1,
        ),
        ZephyrTourStep(
          id: 'dynamic3',
          title: '动态步骤 3',
          content: '这是从服务器加载的第三个步骤',
          order: 2,
        ),
      ];
      _isLoading = false;
    });
  }

  void _startTour() {
    if (_isLoading) return;
    
    setState(() {
      _showTour = true;
      _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态引导组件'),
      ),
      body: Stack(
        children: [
          // 主内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _startTour,
                  child: Text(_isLoading ? '加载中...' : '开始动态引导'),
                ),
                SizedBox(height: 32),
                
                // 模拟的UI元素
                Container(
                  width: 200,
                  height: 50,
                  color: Colors.blue[100],
                  child: Center(child: Text('功能1')),
                ),
                SizedBox(height: 16),
                Container(
                  width: 200,
                  height: 50,
                  color: Colors.green[100],
                  child: Center(child: Text('功能2')),
                ),
              ],
            ),
          ),
          
          // 动态引导
          if (_showTour && _tourSteps.isNotEmpty)
            ZephyrTour(
              key: GlobalKey(),
              steps: _tourSteps,
              currentStepId: _tourSteps[_currentStep].id,
              autoStart: true,
              onTourComplete: () {
                setState(() => _showTour = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('动态引导已完成')),
                );
              },
              onStepChange: (step) {
                setState(() {
                  _currentStep = _tourSteps.indexWhere((s) => s.id == step.id);
                });
                // 发送分析事件
                _analytics.logEvent('tour_step_completed', {
                  'step_id': step.id,
                  'step_title': step.title,
                });
              },
              child: Container(),
            ),
        ],
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrTour()

```dart
ZephyrTour({
  Key? key,
  required List<ZephyrTourStep> steps,
  ZephyrTourTheme? theme,
  VoidCallback? onTourStart,
  VoidCallback? onTourComplete,
  VoidCallback? onTourSkip,
  void Function(ZephyrTourStep step)? onStepChange,
  bool autoStart = false,
  bool showSkipButton = true,
  bool showNextButton = true,
  bool showPreviousButton = true,
  bool showProgress = true,
  bool showStepNumbers = true,
  bool allowSkip = true,
  bool allowNavigation = true,
  Duration animationDuration = const Duration(milliseconds: 300),
  Color overlayColor = const Color(0x80000000),
  double highlightPadding = 8,
  double highlightBorderRadius = 8,
  Offset tooltipOffset = const Offset(0, 8),
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
  String? storageKey,
  ZephyrTourPersistence persistenceMode = ZephyrTourPersistence.none,
  String? startStepId,
  String? currentStepId,
  required Widget child,
})
```

**参数说明：**
- `steps`: 引导步骤列表
- `theme`: 主题配置
- `onTourStart`: 引导开始回调
- `onTourComplete`: 引导完成回调
- `onTourSkip`: 引导跳过回调
- `onStepChange`: 步骤变化回调
- `autoStart`: 是否自动开始
- `showSkipButton`: 是否显示跳过按钮
- `showNextButton`: 是否显示下一步按钮
- `showPreviousButton`: 是否显示上一步按钮
- `showProgress`: 是否显示进度
- `showStepNumbers`: 是否显示步骤编号
- `allowSkip`: 是否允许跳过
- `allowNavigation`: 是否允许导航
- `animationDuration`: 动画持续时间
- `overlayColor`: 覆盖层颜色
- `highlightPadding`: 高亮区域内边距
- `highlightBorderRadius`: 高亮区域圆角
- `tooltipOffset`: 工具提示偏移
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能
- `storageKey`: 存储键
- `persistenceMode`: 持久化模式
- `startStepId`: 开始步骤ID
- `currentStepId`: 当前步骤ID
- `child`: 子组件

#### ZephyrTourStep()

```dart
ZephyrTourStep({
  required String id,
  required String title,
  required String content,
  GlobalKey? targetKey,
  Rect? targetRect,
  int order = 0,
  bool isOptional = false,
  Widget? customWidget,
  String? nextStepId,
  String? previousStepId,
  VoidCallback? onShow,
  VoidCallback? onComplete,
  VoidCallback? onSkip,
  Map<String, dynamic>? metadata,
})
```

### 枚举类型

#### ZephyrTourPersistence

```dart
enum ZephyrTourPersistence {
  none,        // 不持久化
  localStorage, // 使用本地存储
  sharedPreferences, // 使用共享首选项
  memory,       // 仅内存中
}
```

### 样式类

#### ZephyrTourTheme

```dart
class ZephyrTourTheme {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? disabledColor;
  final Color? overlayColor;
  final Color? highlightColor;
  final Color? highlightBorderColor;
  final double? highlightBorderRadius;
  final double? highlightPadding;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final TextStyle? buttonStyle;
  final TextStyle? skipButtonStyle;
  final Duration? animationDuration;
  final BoxDecoration? tooltipDecoration;
  final EdgeInsetsGeometry? tooltipPadding;
  
  // 工厂构造函数
  factory ZephyrTourTheme.light();
  factory ZephyrTourTheme.dark();
  ZephyrTourTheme copyWith({...});
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrTourThemeData(
        defaultTheme: ZephyrTourTheme.light(),
        animationDuration: Duration(milliseconds: 300),
        defaultOverlayColor: Colors.black.withOpacity(0.5),
        defaultHighlightColor: Colors.white.withOpacity(0.2),
        defaultHighlightPadding: 8.0,
        defaultHighlightBorderRadius: 8.0,
        semanticLabel: 'Feature tour',
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultTheme`: 默认主题
- `animationDuration`: 动画持续时间
- `defaultOverlayColor`: 默认覆盖层颜色
- `defaultHighlightColor`: 默认高亮颜色
- `defaultHighlightPadding`: 默认高亮区域内边距
- `defaultHighlightBorderRadius`: 默认高亮区域圆角
- `semanticLabel`: 语义标签

## 🏆 最佳实践

### 1. 合理的引导内容设计

```dart
// ✅ 好的做法：简洁明了的引导内容
ZephyrTourStep(
  id: 'search',
  title: '搜索功能',
  content: '使用搜索框快速找到您需要的内容',
  order: 0,
)

// ✅ 好的做法：重点突出核心功能
ZephyrTourStep(
  id: 'favorite',
  title: '收藏功能',
  content: '点击心形图标收藏您喜欢的内容',
  order: 1,
)

// ✅ 好的做法：提供具体的操作指导
ZephyrTourStep(
  id: 'share',
  title: '分享内容',
  content: '点击分享按钮将内容分享给朋友',
  order: 2,
)

// ❌ 避免的做法：内容过长或模糊
ZephyrTourStep(
  id: 'feature',
  title: '功能介绍',
  content: '这是一个非常长的描述，包含了太多信息，用户可能无法记住所有内容，而且描述不够具体，用户不知道应该做什么', // 内容过长
)
```

### 2. 用户体验优化

```dart
// ✅ 好的做法：提供跳过选项
ZephyrTour(
  showSkipButton: true,
  allowSkip: true,
  onTourSkip: () => _handleSkip(),
)

// ✅ 好的做法：显示进度
ZephyrTour(
  showProgress: true,
  showStepNumbers: true,
)

// ✅ 好的做法：支持导航控制
ZephyrTour(
  showNextButton: true,
  showPreviousButton: true,
  allowNavigation: true,
)

// ❌ 避免的做法：强制完成引导
ZephyrTour(
  showSkipButton: false, // 用户无法跳过
  allowSkip: false,
  // 缺乏进度显示
)
```

### 3. 交互设计

```dart
// ✅ 好的做法：支持交互式引导
ZephyrTourStep(
  id: 'button',
  title: '点击按钮',
  content: '请点击这个按钮继续',
  targetKey: _buttonKey,
  onComplete: () => _handleButtonClick(),
)

// ✅ 好的做法：条件引导
if (_needsSetup) {
  ZephyrTourStep(
    id: 'setup',
    title: '完成设置',
    content: '请先完成基本设置',
    isOptional: false,
  );
}

// ✅ 好的做法：持久化引导状态
ZephyrTour(
  storageKey: 'onboarding_tour',
  persistenceMode: ZephyrTourPersistence.sharedPreferences,
)

// ❌ 避免的做法：缺乏交互反馈
ZephyrTourStep(
  id: 'button',
  title: '点击按钮',
  content: '请点击按钮',
  // 缺乏交互处理
)
```

### 4. 性能优化

```dart
// ✅ 好的做法：按需加载引导
void _showTourIfNeeded() {
  if (_shouldShowTour && !_isTourCompleted) {
    setState(() => _showTour = true);
  }
}

// ✅ 好的做法：优化动画性能
ZephyrTour(
  animationDuration: Duration(milliseconds: 300),
)

// ✅ 好的做法：避免过度渲染
ZephyrTour(
  steps: _tourSteps, // 使用缓存的步骤
)

// ❌ 避免的做法：频繁重建引导
Widget _buildTour() {
  return ZephyrTour(
    steps: _buildSteps(), // 每次都重新构建
  );
}
```

## 🔄 相关组件

- **ZephyrTooltip**: 工具提示组件
- **ZephyrPopover**: 弹出框组件
- **ZephyrDialog**: 对话框组件
- **ZephyrModal**: 模态框组件
- **ZephyrTutorial**: 教程组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种引导类型
- ✅ 支持自定义样式和动画
- ✅ 支持交互式引导
- ✅ 支持条件引导
- ✅ 支持持久化
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/feedback/tour/`
**示例路径**: `example/lib/components/tour_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日