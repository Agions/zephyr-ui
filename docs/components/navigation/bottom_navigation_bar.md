# ZephyrBottomNavigationBar 底部导航栏组件

底部导航栏组件是ZephyrUI导航系统的核心组件，提供了移动端友好的底部导航功能。支持多种标签样式、动画效果和自定义样式，是构建移动应用主导航的理想选择。

## 🎯 组件概述

### 特性
- **多种标签样式**: 支持图标、文本、图标+文本等多种样式
- **流畅动画**: 内置平滑的切换动画效果
- **灵活布局**: 支持固定和滚动模式
- **丰富交互**: 支持点击、长按、滑动等交互
- **状态管理**: 完整的选中状态和徽章管理
- **主题适配**: 完整的主题系统支持

### 适用场景
- 移动应用主导航
- 标签页切换
- 功能模块导航
- 用户中心导航
- 社交应用导航
- 电商应用导航

## 🚀 基础用法

### 基本底部导航栏

```dart
class BasicBottomNavigationExample extends StatefulWidget {
  @override
  _BasicBottomNavigationExampleState createState() => _BasicBottomNavigationExampleState();
}

class _BasicBottomNavigationExampleState extends State<BasicBottomNavigationExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    Center(child: Text('发现', style: TextStyle(fontSize: 24))),
    Center(child: Text('消息', style: TextStyle(fontSize: 24))),
    Center(child: Text('我的', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '发现',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
```

### 带徽章的底部导航栏

```dart
class BadgeBottomNavigationExample extends StatefulWidget {
  @override
  _BadgeBottomNavigationExampleState createState() => _BadgeBottomNavigationExampleState();
}

class _BadgeBottomNavigationExampleState extends State<BadgeBottomNavigationExample> {
  int _currentIndex = 0;
  int _messageCount = 5;
  int _notificationCount = 12;

  final List<Widget> _pages = [
    Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    Center(child: Text('发现', style: TextStyle(fontSize: 24))),
    Center(child: Text('消息', style: TextStyle(fontSize: 24))),
    Center(child: Text('我的', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带徽章的底部导航栏'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              setState(() => _notificationCount = 0);
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 2) {
              _messageCount = 0; // 清除消息徽章
            }
          });
        },
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '发现',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
            badge: _messageCount > 0 ? _messageCount.toString() : null,
            badgeColor: Colors.red,
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
            badge: _notificationCount > 0 ? '!' : null,
            badgeColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
```

### 彩色底部导航栏

```dart
class ColoredBottomNavigationExample extends StatefulWidget {
  @override
  _ColoredBottomNavigationExampleState createState() => _ColoredBottomNavigationExampleState();
}

class _ColoredBottomNavigationExampleState extends State<ColoredBottomNavigationExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Container(color: Colors.blue[50], child: Center(child: Text('首页', style: TextStyle(fontSize: 24)))),
    Container(color: Colors.green[50], child: Center(child: Text('发现', style: TextStyle(fontSize: 24)))),
    Container(color: Colors.orange[50], child: Center(child: Text('消息', style: TextStyle(fontSize: 24)))),
    Container(color: Colors.purple[50], child: Center(child: Text('我的', style: TextStyle(fontSize: 24)))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: ZephyrBottomNavigationBarType.colored,
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
            selectedColor: Colors.blue,
            unselectedColor: Colors.grey,
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '发现',
            selectedColor: Colors.green,
            unselectedColor: Colors.grey,
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
            selectedColor: Colors.orange,
            unselectedColor: Colors.grey,
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
            selectedColor: Colors.purple,
            unselectedColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义样式

```dart
class CustomBottomNavigationExample extends StatefulWidget {
  @override
  _CustomBottomNavigationExampleState createState() => _CustomBottomNavigationExampleState();
}

class _CustomBottomNavigationExampleState extends State<CustomBottomNavigationExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('仪表板', style: TextStyle(fontSize: 24))),
    Center(child: Text('项目', style: TextStyle(fontSize: 24))),
    Center(child: Text('团队', style: TextStyle(fontSize: 24))),
    Center(child: Text('设置', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: ZephyrBottomNavigationBarType.custom,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        itemPadding: EdgeInsets.symmetric(vertical: 8),
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '仪表板',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: '项目',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '团队',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
}
```

### 带动画的底部导航栏

```dart
class AnimatedBottomNavigationExample extends StatefulWidget {
  @override
  _AnimatedBottomNavigationExampleState createState() => _AnimatedBottomNavigationExampleState();
}

class _AnimatedBottomNavigationExampleState extends State<AnimatedBottomNavigationExample>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _currentIndex == 0 ? _scaleAnimation.value : 1.0,
              child: Text(
                '第 ${_currentIndex + 1} 个页面',
                style: TextStyle(fontSize: 32),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              _animationController.forward().then((_) {
                _animationController.reverse();
              });
            }
          });
        },
        type: ZephyrBottomNavigationBarType.animated,
        animationDuration: Duration(milliseconds: 300),
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home, color: Colors.blue),
            label: '首页',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search, color: Colors.green),
            label: '搜索',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            selectedIcon: Icon(Icons.notifications, color: Colors.orange),
            label: '通知',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.person, color: Colors.purple),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
```

### 带背景图片的底部导航栏

```dart
class BackgroundBottomNavigationExample extends StatefulWidget {
  @override
  _BackgroundBottomNavigationExampleState createState() => _BackgroundBottomNavigationExampleState();
}

class _BackgroundBottomNavigationExampleState extends State<BackgroundBottomNavigationExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    Center(child: Text('发现', style: TextStyle(fontSize: 24))),
    Center(child: Text('消息', style: TextStyle(fontSize: 24))),
    Center(child: Text('我的', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: ZephyrBottomNavigationBarType.custom,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[400]!,
              Colors.purple[400]!,
            ],
          ),
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '发现',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
```

## 🔧 高级用法

### 可滚动的底部导航栏

```dart
class ScrollableBottomNavigationExample extends StatefulWidget {
  @override
  _ScrollableBottomNavigationExampleState createState() => _ScrollableBottomNavigationExampleState();
}

class _ScrollableBottomNavigationExampleState extends State<ScrollableBottomNavigationExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    Center(child: Text('发现', style: TextStyle(fontSize: 24))),
    Center(child: Text('消息', style: TextStyle(fontSize: 24))),
    Center(child: Text('我的', style: TextStyle(fontSize: 24))),
    Center(child: Text('更多', style: TextStyle(fontSize: 24))),
    Center(child: Text('设置', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: ZephyrBottomNavigationBarType.scrollable,
        itemWidth: 80,
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '发现',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: '更多',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
}
```

### 带长按菜单的底部导航栏

```dart
class LongPressBottomNavigationExample extends StatefulWidget {
  @override
  _LongPressBottomNavigationExampleState createState() => _LongPressBottomNavigationExampleState();
}

class _LongPressBottomNavigationExampleState extends State<LongPressBottomNavigationExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    Center(child: Text('发现', style: TextStyle(fontSize: 24))),
    Center(child: Text('消息', style: TextStyle(fontSize: 24))),
    Center(child: Text('我的', style: TextStyle(fontSize: 24))),
  ];

  void _showMenu(String title, List<String> options) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ...options.map((option) {
                return ListTile(
                  title: Text(option),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('选择了: $option')),
                    );
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        onLongPress: (index) {
          final titles = ['首页', '发现', '消息', '我的'];
          final menus = [
            ['刷新', '设置', '关于'],
            ['热门', '最新', '关注'],
            ['已读', '全部标记已读', '设置'],
            ['编辑资料', '退出登录'],
          ];
          _showMenu(titles[index], menus[index]);
        },
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '发现',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
            badge: '3',
            badgeColor: Colors.red,
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
```

### 带自定义图标的底部导航栏

```dart
class CustomIconBottomNavigationExample extends StatefulWidget {
  @override
  _CustomIconBottomNavigationExampleState createState() => _CustomIconBottomNavigationExampleState();
}

class _CustomIconBottomNavigationExampleState extends State<CustomIconBottomNavigationExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    Center(child: Text('发现', style: TextStyle(fontSize: 24))),
    Center(child: Text('发布', style: TextStyle(fontSize: 24))),
    Center(child: Text('消息', style: TextStyle(fontSize: 24))),
    Center(child: Text('我的', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: ZephyrBottomNavigationBarType.custom,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '首页',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: '发现',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
            selectedIcon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
            label: '发布',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            selectedIcon: Icon(Icons.message),
            label: '消息',
            badge: '5',
            badgeColor: Colors.red,
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
```

### 带指示器的底部导航栏

```dart
class IndicatorBottomNavigationExample extends StatefulWidget {
  @override
  _IndicatorBottomNavigationExampleState createState() => _IndicatorBottomNavigationExampleState();
}

class _IndicatorBottomNavigationExampleState extends State<IndicatorBottomNavigationExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    Center(child: Text('发现', style: TextStyle(fontSize: 24))),
    Center(child: Text('消息', style: TextStyle(fontSize: 24))),
    Center(child: Text('我的', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: ZephyrBottomNavigationBarType.indicator,
        indicatorColor: Colors.blue,
        indicatorHeight: 3,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        items: [
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '发现',
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
            badge: '2',
            badgeColor: Colors.red,
          ),
          ZephyrBottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrBottomNavigationBar()

```dart
const ZephyrBottomNavigationBar({
  Key? key,
  required List<ZephyrBottomNavigationBarItem> items,
  required int currentIndex,
  ValueChanged<int>? onTap,
  ValueChanged<int>? onLongPress,
  ZephyrBottomNavigationBarType type = ZephyrBottomNavigationBarType.fixed,
  Color? backgroundColor,
  Color? selectedItemColor,
  Color? unselectedItemColor,
  TextStyle? selectedLabelStyle,
  TextStyle? unselectedLabelStyle,
  double? elevation,
  EdgeInsetsGeometry? itemPadding,
  double? itemWidth,
  double? iconSize,
  Duration? animationDuration,
  Curve? animationCurve,
  BoxDecoration? decoration,
  bool showLabel = true,
  bool showUnselectedLabel = true,
  Color? indicatorColor,
  double? indicatorHeight,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `items`: 导航项目列表
- `currentIndex`: 当前选中索引
- `onTap`: 点击回调
- `onLongPress`: 长按回调
- `type`: 导航栏类型
- `backgroundColor`: 背景颜色
- `selectedItemColor`: 选中项颜色
- `unselectedItemColor`: 未选中项颜色
- `selectedLabelStyle`: 选中标签样式
- `unselectedLabelStyle`: 未选中标签样式
- `elevation`: 阴影高度
- `itemPadding`: 项目内边距
- `itemWidth`: 项目宽度
- `iconSize`: 图标大小
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `decoration`: 装饰
- `showLabel`: 是否显示标签
- `showUnselectedLabel`: 是否显示未选中标签
- `indicatorColor`: 指示器颜色
- `indicatorHeight`: 指示器高度
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrBottomNavigationBarItem()

```dart
const ZephyrBottomNavigationBarItem({
  Key? key,
  required Widget icon,
  Widget? selectedIcon,
  required String label,
  String? badge,
  Color? badgeColor,
  Color? selectedColor,
  Color? unselectedColor,
  String? tooltip,
  String? semanticLabel,
})
```

### 枚举类型

#### ZephyrBottomNavigationBarType

```dart
enum ZephyrBottomNavigationBarType {
  fixed,      // 固定模式
  shifting,   // 切换模式
  colored,    // 彩色模式
  custom,     // 自定义模式
  animated,   // 动画模式
  scrollable, // 可滚动模式
  indicator,  // 指示器模式
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrBottomNavigationBarTheme(
        defaultType: ZephyrBottomNavigationBarType.fixed,
        defaultBackgroundColor: Colors.white,
        defaultSelectedItemColor: Colors.blue,
        defaultUnselectedItemColor: Colors.grey[600],
        defaultSelectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        defaultUnselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        defaultElevation: 8,
        defaultIconSize: 24,
        defaultItemPadding: EdgeInsets.symmetric(vertical: 8),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        defaultBadgeColor: Colors.red,
        defaultIndicatorColor: Colors.blue,
        defaultIndicatorHeight: 3,
        showLabel: true,
        showUnselectedLabel: true,
        hoverColor: Colors.grey.withOpacity(0.1),
        focusColor: Colors.blue.withOpacity(0.1),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultType`: 默认导航栏类型
- `defaultBackgroundColor`: 默认背景颜色
- `defaultSelectedItemColor`: 默认选中项颜色
- `defaultUnselectedItemColor`: 默认未选中项颜色
- `defaultSelectedLabelStyle`: 默认选中标签样式
- `defaultUnselectedLabelStyle`: 默认未选中标签样式
- `defaultElevation`: 默认阴影高度
- `defaultIconSize`: 默认图标大小
- `defaultItemPadding`: 默认项目内边距
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `defaultBadgeColor`: 默认徽章颜色
- `defaultIndicatorColor`: 默认指示器颜色
- `defaultIndicatorHeight`: 默认指示器高度
- `showLabel`: 是否显示标签
- `showUnselectedLabel`: 是否显示未选中标签
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的导航项数量

```dart
// ✅ 好的做法：3-5个导航项
ZephyrBottomNavigationBar(
  items: [
    ZephyrBottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
    ZephyrBottomNavigationBarItem(icon: Icon(Icons.explore), label: '发现'),
    ZephyrBottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
    ZephyrBottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ],
)

// ✅ 好的做法：超过5个项使用可滚动模式
ZephyrBottomNavigationBar(
  type: ZephyrBottomNavigationBarType.scrollable,
  items: [
    // 6个以上的导航项
  ],
)

// ❌ 避免的做法：过多导航项且不可滚动
ZephyrBottomNavigationBar(
  type: ZephyrBottomNavigationBarType.fixed, // 空间不足
  items: [
    // 8个导航项，会导致拥挤
  ],
)
```

### 2. 清晰的图标和标签

```dart
// ✅ 好的做法：使用标准图标
ZephyrBottomNavigationBar(
  items: [
    ZephyrBottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    ZephyrBottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: '设置',
    ),
  ],
)

// ✅ 好的做法：使用有意义的标签
ZephyrBottomNavigationBar(
  items: [
    ZephyrBottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: '个人中心', // 清晰的描述
    ),
  ],
)

// ❌ 避免的做法：使用模糊的图标和标签
ZephyrBottomNavigationBar(
  items: [
    ZephyrBottomNavigationBarItem(
      icon: Icon(Icons.help), // 不明确的图标
      label: '功能', // 模糊的标签
    ),
  ],
)
```

### 3. 状态管理

```dart
// ✅ 好的做法：使用状态管理
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: _pages,
      ),
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: _items,
      ),
    );
  }
}

// ❌ 避免的做法：不一致的状态管理
ZephyrBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index); // 只改变索引，不改变页面
  },
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrBottomNavigationBar(
  semanticLabel: '主导航菜单',
  enableAccessibilityFeatures: true,
  items: [
    ZephyrBottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
      semanticLabel: '返回首页页面',
    ),
    ZephyrBottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: '设置',
      semanticLabel: '打开设置页面',
    ),
  ],
)

// ✅ 好的做法：提供工具提示
ZephyrBottomNavigationBar(
  items: [
    ZephyrBottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
      tooltip: '返回首页',
    ),
  ],
)

// ❌ 避免的做法：缺乏无障碍支持
ZephyrBottomNavigationBar(
  items: [
    ZephyrBottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
      // 缺乏语义信息
    ),
  ],
)
```

## 🔄 相关组件

- **ZephyrTabs**: 选项卡组件
- **ZephyrSideMenu**: 侧边菜单组件
- **ZephyrNavigationRail**: 导航栏组件
- **ZephyrBreadcrumb**: 面包屑导航组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种导航栏类型
- ✅ 支持徽章和自定义样式
- ✅ 支持动画效果
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/navigation/bottom_navigation_bar/`
**示例路径**: `example/lib/components/bottom_navigation_bar_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日