# ZephyrTabs 选项卡组件

选项卡组件是ZephyrUI导航系统的核心组件，提供了灵活的标签页导航功能。支持多种布局模式、动画效果和自定义样式，是构建多页面应用、内容分类展示的理想选择。

## 🎯 组件概述

### 特性
- **多种布局模式**: 支持水平、垂直、滚动等多种布局
- **流畅动画**: 内置平滑的切换动画效果
- **灵活布局**: 支持自定义宽度、高度和位置
- **丰富交互**: 支持点击、滑动、拖拽等交互方式
- **动态管理**: 支持动态添加、删除、禁用标签页
- **主题适配**: 完整的主题系统支持

### 适用场景
- 多页面应用导航
- 内容分类展示
- 设置页面分组
- 数据表格切换
- 表单步骤导航
- 文档分类浏览

## 🚀 基础用法

### 基本选项卡

```dart
class BasicTabsExample extends StatefulWidget {
  @override
  _BasicTabsExampleState createState() => _BasicTabsExampleState();
}

class _BasicTabsExampleState extends State<BasicTabsExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本选项卡'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '首页'),
            Tab(text: '发现'),
            Tab(text: '我的'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent('首页内容', Icons.home),
          _buildTabContent('发现内容', Icons.explore),
          _buildTabContent('我的内容', Icons.person),
        ],
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 带图标的选项卡

```dart
class IconTabsExample extends StatefulWidget {
  @override
  _IconTabsExampleState createState() => _IconTabsExampleState();
}

class _IconTabsExampleState extends State<IconTabsExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带图标的选项卡'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: '首页',
            ),
            Tab(
              icon: Icon(Icons.search),
              text: '搜索',
            ),
            Tab(
              icon: Icon(Icons.notifications),
              text: '通知',
            ),
            Tab(
              icon: Icon(Icons.settings),
              text: '设置',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent('首页', Icons.home, Colors.blue),
          _buildTabContent('搜索', Icons.search, Colors.green),
          _buildTabContent('通知', Icons.notifications, Colors.orange),
          _buildTabContent('设置', Icons.settings, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 64, color: color),
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
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

### 可滚动的选项卡

```dart
class ScrollableTabsExample extends StatefulWidget {
  @override
  _ScrollableTabsExampleState createState() => _ScrollableTabsExampleState();
}

class _ScrollableTabsExampleState extends State<ScrollableTabsExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<TabData> _tabs = [
    TabData('推荐', Icons.recommend),
    TabData('热点', Icons.local_fire_department),
    TabData('科技', Icons.computer),
    TabData('体育', Icons.sports_soccer),
    TabData('娱乐', Icons.movie),
    TabData('财经', Icons.attach_money),
    TabData('教育', Icons.school),
    TabData('健康', Icons.health_and_safety),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可滚动选项卡'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((tab) => Tab(
            icon: Icon(tab.icon),
            text: tab.title,
          )).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) => _buildTabContent(tab)).toList(),
      ),
    );
  }

  Widget _buildTabContent(TabData tab) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(tab.icon, size: 64, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            '${tab.title}内容',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '这是${tab.title}分类的内容展示',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class TabData {
  final String title;
  final IconData icon;

  TabData(this.title, this.icon);
}
```

## 🎨 样式定制

### 自定义选项卡样式

```dart
class CustomTabsExample extends StatefulWidget {
  @override
  _CustomTabsExampleState createState() => _CustomTabsExampleState();
}

class _CustomTabsExampleState extends State<CustomTabsExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义样式选项卡'),
        bottom: TabBar(
          controller: _tabController,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 3,
            ),
            insets: EdgeInsets.symmetric(horizontal: 16),
          ),
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          tabs: [
            Tab(text: '新闻'),
            Tab(text: '体育'),
            Tab(text: '娱乐'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCustomTabContent('新闻', Icons.article, Colors.blue),
          _buildCustomTabContent('体育', Icons.sports_soccer, Colors.green),
          _buildCustomTabContent('娱乐', Icons.movie, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildCustomTabContent(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, size: 48, color: Colors.white),
            ),
            SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '这是自定义样式的$title内容',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 垂直选项卡

```dart
class VerticalTabsExample extends StatefulWidget {
  @override
  _VerticalTabsExampleState createState() => _VerticalTabsExampleState();
}

class _VerticalTabsExampleState extends State<VerticalTabsExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('垂直选项卡'),
      ),
      body: Row(
        children: [
          // 垂直选项卡
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                right: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    '导航菜单',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      border: Border(
                        left: BorderSide(
                          color: Colors.blue,
                          width: 3,
                        ),
                      ),
                    ),
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey[700],
                    indicatorColor: Colors.transparent,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.dashboard),
                        text: '仪表板',
                      ),
                      Tab(
                        icon: Icons.work),
                        text: '项目',
                      ),
                      Tab(
                        icon: Icons.people),
                        text: '团队',
                      ),
                      Tab(
                        icon: Icons.settings),
                        text: '设置',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 内容区域
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildVerticalTabContent('仪表板', Icons.dashboard, Colors.blue),
                _buildVerticalTabContent('项目', Icons.work, Colors.green),
                _buildVerticalTabContent('团队', Icons.people, Colors.orange),
                _buildVerticalTabContent('设置', Icons.settings, Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalTabContent(String title, IconData icon, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: color),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '这是$title页面的内容展示',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🔧 高级用法

### 动态选项卡

```dart
class DynamicTabsExample extends StatefulWidget {
  @override
  _DynamicTabsExampleState createState() => _DynamicTabsExampleState();
}

class _DynamicTabsExampleState extends State<DynamicTabsExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<TabData> _tabs = [
    TabData('首页', Icons.home),
    TabData('发现', Icons.explore),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态选项卡'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addTab,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((tab) => Tab(
            icon: Icon(tab.icon),
            text: tab.title,
          )).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) => _buildDynamicTabContent(tab)).toList(),
      ),
    );
  }

  Widget _buildDynamicTabContent(TabData tab) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(tab.icon, size: 64, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            '${tab.title}内容',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          if (_tabs.length > 2)
            ElevatedButton(
              onPressed: () => _removeTab(tab),
              child: Text('关闭此标签页'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  void _addTab() {
    final newTabIndex = _tabs.length + 1;
    final newTab = TabData('页面 $newTabIndex', Icons.tab);
    
    setState(() {
      _tabs.add(newTab);
      _tabController = TabController(length: _tabs.length, vsync: this);
    });
    
    // 切换到新添加的标签页
    _tabController.animateTo(_tabs.length - 1);
  }

  void _removeTab(TabData tab) {
    if (_tabs.length <= 1) return;
    
    final currentIndex = _tabController.index;
    final removeIndex = _tabs.indexOf(tab);
    
    setState(() {
      _tabs.remove(tab);
      _tabController = TabController(length: _tabs.length, vsync: this);
    });
    
    // 如果删除的是当前标签页，切换到前一个标签页
    if (removeIndex == currentIndex && currentIndex > 0) {
      _tabController.animateTo(currentIndex - 1);
    } else if (removeIndex < currentIndex) {
      _tabController.animateTo(currentIndex - 1);
    }
  }
}
```

### 带标签页的表单

```dart
class FormTabsExample extends StatefulWidget {
  @override
  _FormTabsExampleState createState() => _FormTabsExampleState();
}

class _FormTabsExampleState extends State<FormTabsExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // 表单数据
  final Map<String, dynamic> _formData = {
    'basic': {},
    'contact': {},
    'preferences': {},
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表单选项卡'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '基本信息'),
            Tab(text: '联系方式'),
            Tab(text: '偏好设置'),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildBasicInfoTab(),
            _buildContactTab(),
            _buildPreferencesTab(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _previousTab,
                child: Text('上一步'),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _nextTab,
                child: Text('下一步'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '基本信息',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '姓名',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _formData['basic']['name'] = value,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '年龄',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onSaved: (value) => _formData['basic']['age'] = value,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '职业',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _formData['basic']['occupation'] = value,
          ),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '联系方式',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '邮箱',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => _formData['contact']['email'] = value,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '电话',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            onSaved: (value) => _formData['contact']['phone'] = value,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '地址',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onSaved: (value) => _formData['contact']['address'] = value,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '偏好设置',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SwitchListTile(
            title: Text('接收邮件通知'),
            value: _formData['preferences']['emailNotifications'] ?? false,
            onChanged: (value) {
              setState(() {
                _formData['preferences']['emailNotifications'] = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('接收短信通知'),
            value: _formData['preferences']['smsNotifications'] ?? false,
            onChanged: (value) {
              setState(() {
                _formData['preferences']['smsNotifications'] = value;
              });
            },
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: '语言偏好',
              border: OutlineInputBorder(),
            ),
            value: _formData['preferences']['language'],
            items: [
              DropdownMenuItem(value: 'zh', child: Text('中文')),
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'ja', child: Text('日本語')),
            ],
            onChanged: (value) {
              setState(() {
                _formData['preferences']['language'] = value;
              });
            },
          ),
        ],
      ),
    );
  }

  void _previousTab() {
    if (_tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
    }
  }

  void _nextTab() {
    if (_tabController.index < 2) {
      _tabController.animateTo(_tabController.index + 1);
    } else {
      _submitForm();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('表单提交成功！')),
      );
      print('表单数据: $_formData');
    }
  }
}
```

### 带缓存的选项卡

```dart
class CachedTabsExample extends StatefulWidget {
  @override
  _CachedTabsExampleState createState() => _CachedTabsExampleState();
}

class _CachedTabsExampleState extends State<CachedTabsExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<int, Widget> _cachedTabs = {};
  final List<Future<Widget>> _tabFutures = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeTabs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeTabs() {
    _tabFutures = [
      _loadTabContent('首页', Icons.home, Colors.blue),
      _loadTabContent('发现', Icons.explore, Colors.green),
      _loadTabContent('我的', Icons.person, Colors.orange),
    ];
  }

  Future<Widget> _loadTabContent(String title, IconData icon, Color color) async {
    // 模拟异步加载
    await Future.delayed(Duration(seconds: 1));
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: color),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '这是$title的内容（已缓存）',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带缓存的选项卡'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '首页'),
            Tab(text: '发现'),
            Tab(text: '我的'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabWithCache(0),
          _buildTabWithCache(1),
          _buildTabWithCache(2),
        ],
      ),
    );
  }

  Widget _buildTabWithCache(int index) {
    if (_cachedTabs.containsKey(index)) {
      return _cachedTabs[index]!;
    }

    return FutureBuilder<Widget>(
      future: _tabFutures[index],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('加载中...'),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text('加载失败'),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          _cachedTabs[index] = snapshot.data!;
          return snapshot.data!;
        } else {
          return Center(child: Text('没有数据'));
        }
      },
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrTabs()

```dart
const ZephyrTabs({
  Key? key,
  required List<ZephyrTab> tabs,
  required List<Widget> children,
  int initialIndex = 0,
  ValueChanged<int>? onChanged,
  ValueChanged<int>? onTap,
  Duration? animationDuration,
  Curve? animationCurve,
  ZephyrTabsIndicator indicator = ZephyrTabsIndicator.underline,
  Color? indicatorColor,
  double indicatorWeight = 2,
  EdgeInsetsGeometry? indicatorPadding,
  Color? labelColor,
  Color? unselectedLabelColor,
  TextStyle? labelStyle,
  TextStyle? unselectedLabelStyle,
  double? labelPadding,
  bool isScrollable = false,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  ZephyrTabsAlignment alignment = ZephyrTabsAlignment.start,
  bool enableSwipe = true,
  bool enableKeyboardNavigation = true,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `tabs`: 选项卡列表
- `children`: 内容列表
- `initialIndex`: 初始选中索引
- `onChanged`: 切换回调
- `onTap`: 点击回调
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `indicator`: 指示器类型
- `indicatorColor`: 指示器颜色
- `indicatorWeight`: 指示器宽度
- `indicatorPadding`: 指示器内边距
- `labelColor`: 标签颜色
- `unselectedLabelColor`: 未选中标签颜色
- `labelStyle`: 标签样式
- `unselectedLabelStyle`: 未选中标签样式
- `labelPadding`: 标签内边距
- `isScrollable`: 是否可滚动
- `padding`: 内边距
- `margin`: 外边距
- `alignment`: 对齐方式
- `enableSwipe`: 是否启用滑动
- `enableKeyboardNavigation`: 是否启用键盘导航
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrTab()

```dart
const ZephyrTab({
  Key? key,
  required Widget child,
  IconData? icon,
  String? text,
  Widget? customWidget,
  bool enabled = true,
  String? tooltip,
  String? semanticLabel,
})
```

### 枚举类型

#### ZephyrTabsIndicator

```dart
enum ZephyrTabsIndicator {
  underline,    // 下划线
  background,   // 背景
  border,       // 边框
  none,         // 无
}
```

#### ZephyrTabsAlignment

```dart
enum ZephyrTabsAlignment {
  start,    // 开始对齐
  center,   // 居中对齐
  end,      // 结束对齐
  fill,     // 填充
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrTabsTheme(
        indicatorColor: Colors.blue,
        indicatorWeight: 2,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: EdgeInsets.symmetric(horizontal: 16),
        hoverColor: Colors.grey.withOpacity(0.1),
        selectedBackgroundColor: Colors.blue.withOpacity(0.1),
        disabledColor: Colors.grey[400],
        dividerColor: Colors.grey[300],
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `indicatorColor`: 指示器颜色
- `indicatorWeight`: 指示器宽度
- `labelColor`: 标签颜色
- `unselectedLabelColor`: 未选中标签颜色
- `labelStyle`: 标签样式
- `unselectedLabelStyle`: 未选中标签样式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `indicatorPadding`: 指示器内边距
- `labelPadding`: 标签内边距
- `hoverColor`: 悬停颜色
- `selectedBackgroundColor`: 选中背景颜色
- `disabledColor`: 禁用颜色
- `dividerColor`: 分割线颜色

## 🏆 最佳实践

### 1. 合理的选项卡数量

```dart
// ✅ 好的做法：选项卡数量适中
ZephyrTabs(
  tabs: [
    ZephyrTab(text: '首页'),
    ZephyrTab(text: '发现'),
    ZephyrTab(text: '我的'),
  ],
  children: [...],
)

// ✅ 好的做法：大量选项卡时使用滚动
ZephyrTabs(
  isScrollable: true,
  tabs: [
    // 多个选项卡
  ],
  children: [...],
)

// ❌ 避免的做法：选项卡过多且不可滚动
ZephyrTabs(
  tabs: [
    // 8个以上选项卡
  ],
  children: [...],
)
```

### 2. 性能优化

```dart
// ✅ 好的做法：使用AutomaticKeepAliveClientMixin保持状态
class _TabContentState extends State<TabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return YourContent();
  }
}

// ✅ 好的做法：避免在选项卡中使用复杂的动画
ZephyrTabs(
  children: [
    _buildSimpleTabContent(),
    _buildSimpleTabContent(),
  ],
)

// ❌ 避免的做法：在选项卡中使用复杂的动画
ZephyrTabs(
  children: [
    _buildComplexAnimatedContent(),
    _buildComplexAnimatedContent(),
  ],
)
```

### 3. 用户体验

```dart
// ✅ 好的做法：提供加载状态
ZephyrTabs(
  children: [
    FutureBuilder(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return YourContent(snapshot.data);
      },
    ),
  ],
)

// ✅ 好的做法：提供错误处理
ZephyrTabs(
  children: [
    FutureBuilder(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('加载失败'));
        }
        return YourContent(snapshot.data);
      },
    ),
  ],
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：为选项卡添加语义标签
ZephyrTabs(
  semanticLabel: '主要内容导航',
  enableAccessibilityFeatures: true,
  tabs: [
    ZephyrTab(
      text: '首页',
      semanticLabel: '返回首页',
    ),
    ZephyrTab(
      text: '设置',
      semanticLabel: '打开设置页面',
    ),
  ],
  children: [...],
)
```

## 🔄 相关组件

- **ZephyrSideMenu**: 侧边菜单组件
- **ZephyrBottomNavigationBar**: 底部导航栏
- **ZephyrStepper**: 步骤条组件
- **ZephyrPagination**: 分页组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基础选项卡功能
- ✅ 支持多种布局模式
- ✅ 支持动态选项卡管理
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/navigation/tabs/`
**示例路径**: `example/lib/components/tabs_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日