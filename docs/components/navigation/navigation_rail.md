# ZephyrNavigationRail 导航栏组件

导航栏组件是ZephyrUI导航系统的重要组件，提供了侧边栏式的导航功能。支持多种显示模式、自定义样式和交互方式，是构建桌面应用、平板应用导航的理想选择。

## 🎯 组件概述

### 特性
- **多种显示模式**: 支持标准、扩展、最小化等多种模式
- **灵活布局**: 支持水平和垂直布局
- **丰富交互**: 支持点击、悬停、拖拽等交互
- **自定义样式**: 支持自定义颜色、图标、标签等样式
- **响应式设计**: 根据屏幕尺寸自动调整显示方式
- **主题适配**: 完整的主题系统支持

### 适用场景
- 桌面应用主导航
- 平板应用导航
- 管理后台导航
- 开发工具导航
- 设计工具导航
- 数据分析工具导航

## 🚀 基础用法

### 基本导航栏

```dart
class BasicNavigationRailExample extends StatefulWidget {
  @override
  _BasicNavigationRailExampleState createState() => _BasicNavigationRailExampleState();
}

class _BasicNavigationRailExampleState extends State<BasicNavigationRailExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('仪表板', style: TextStyle(fontSize: 24))),
    Center(child: Text('项目', style: TextStyle(fontSize: 24))),
    Center(child: Text('团队', style: TextStyle(fontSize: 24))),
    Center(child: Text('设置', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 导航栏
          ZephyrNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            destinations: [
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('仪表板'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.work),
                label: Text('项目'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('团队'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('设置'),
              ),
            ],
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
```

### 带标签的导航栏

```dart
class LabeledNavigationRailExample extends StatefulWidget {
  @override
  _LabeledNavigationRailExampleState createState() => _LabeledNavigationRailExampleState();
}

class _LabeledNavigationRailExampleState extends State<LabeledNavigationRailExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    Center(child: Text('搜索', style: TextStyle(fontSize: 24))),
    Center(child: Text('通知', style: TextStyle(fontSize: 24))),
    Center(child: Text('个人', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 带标签的导航栏
          ZephyrNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            labelType: ZephyrNavigationRailLabelType.all,
            destinations: [
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('首页'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.search),
                label: Text('搜索'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.notifications),
                label: Text('通知'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('个人'),
              ),
            ],
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
```

### 扩展导航栏

```dart
class ExtendedNavigationRailExample extends StatefulWidget {
  @override
  _ExtendedNavigationRailExampleState createState() => _ExtendedNavigationRailExampleState();
}

class _ExtendedNavigationRailExampleState extends State<ExtendedNavigationRailExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('文件管理', style: TextStyle(fontSize: 24))),
    Center(child: Text('代码编辑', style: TextStyle(fontSize: 24))),
    Center(child: Text('版本控制', style: TextStyle(fontSize: 24))),
    Center(child: Text('调试工具', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 扩展导航栏
          ZephyrNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            extended: true,
            leading: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.code, size: 32),
                  SizedBox(height: 8),
                  Text('开发工具', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.all(16),
              child: Icon(Icons.more_vert),
            ),
            destinations: [
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.folder),
                label: Text('文件管理'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.code),
                label: Text('代码编辑'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.source),
                label: Text('版本控制'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.bug_report),
                label: Text('调试工具'),
              ),
            ],
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
```

## 🎨 样式定制

### 彩色导航栏

```dart
class ColoredNavigationRailExample extends StatefulWidget {
  @override
  _ColoredNavigationRailExampleState createState() => _ColoredNavigationRailExampleState();
}

class _ColoredNavigationRailExampleState extends State<ColoredNavigationRailExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Container(color: Colors.blue[50], child: Center(child: Text('分析', style: TextStyle(fontSize: 24)))),
    Container(color: Colors.green[50], child: Center(child: Text('报告', style: TextStyle(fontSize: 24)))),
    Container(color: Colors.orange[50], child: Center(child: Text('设置', style: TextStyle(fontSize: 24)))),
    Container(color: Colors.purple[50], child: Center(child: Text('帮助', style: TextStyle(fontSize: 24)))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 彩色导航栏
          ZephyrNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey[600],
            indicatorColor: Colors.blue.withOpacity(0.1),
            labelType: ZephyrNavigationRailLabelType.selected,
            destinations: [
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.analytics),
                selectedIcon: Icon(Icons.analytics, color: Colors.blue),
                label: Text('分析'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.assessment),
                selectedIcon: Icon(Icons.assessment, color: Colors.green),
                label: Text('报告'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings, color: Colors.orange),
                label: Text('设置'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.help),
                selectedIcon: Icon(Icons.help, color: Colors.purple),
                label: Text('帮助'),
              ),
            ],
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
```

### 带背景的导航栏

```dart
class BackgroundNavigationRailExample extends StatefulWidget {
  @override
  _BackgroundNavigationRailExampleState createState() => _BackgroundNavigationRailExampleState();
}

class _BackgroundNavigationRailExampleState extends State<BackgroundNavigationRailExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('音乐库', style: TextStyle(fontSize: 24))),
    Center(child: Text('播放列表', style: TextStyle(fontSize: 24))),
    Center(child: Text('电台', style: TextStyle(fontSize: 24))),
    Center(child: Text('设置', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 带背景的导航栏
          ZephyrNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple[400]!,
                  Colors.purple[400]!,
                ],
              ),
            ),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            labelType: ZephyrNavigationRailLabelType.all,
            destinations: [
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.library_music),
                label: Text('音乐库'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.playlist_play),
                label: Text('播放列表'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.radio),
                label: Text('电台'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('设置'),
              ),
            ],
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
```

### 最小化导航栏

```dart
class MinimalNavigationRailExample extends StatefulWidget {
  @override
  _MinimalNavigationRailExampleState createState() => _MinimalNavigationRailExampleState();
}

class _MinimalNavigationRailExampleState extends State<MinimalNavigationRailExample> {
  int _selectedIndex = 0;
  bool _isExtended = false;

  final List<Widget> _pages = [
    Center(child: Text('概览', style: TextStyle(fontSize: 24))),
    Center(child: Text('日历', style: TextStyle(fontSize: 24))),
    Center(child: Text('任务', style: TextStyle(fontSize: 24))),
    Center(child: Text('联系人', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 最小化导航栏
          ZephyrNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            minWidth: 56,
            labelType: ZephyrNavigationRailLabelType.none,
            destinations: [
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('概览'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.calendar_today),
                label: Text('日历'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.task),
                label: Text('任务'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.contacts),
                label: Text('联系人'),
              ),
            ],
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _isExtended = !_isExtended);
        },
        child: Icon(_isExtended ? Icons.arrow_back : Icons.arrow_forward),
      ),
    );
  }
}
```

## 🔧 高级用法

### 带分组导航栏

```dart
class GroupedNavigationRailExample extends StatefulWidget {
  @override
  _GroupedNavigationRailExampleState createState() => _GroupedNavigationRailExampleState();
}

class _GroupedNavigationRailExampleState extends State<GroupedNavigationRailExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('收件箱', style: TextStyle(fontSize: 24))),
    Center(child: Text('已发送', style: TextStyle(fontSize: 24))),
    Center(child: Text('草稿', style: TextStyle(fontSize: 24))),
    Center(child: Text('垃圾箱', style: TextStyle(fontSize: 24))),
    Center(child: Text('设置', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 带分组的导航栏
          ZephyrNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            groupAlignment: 0.0,
            destinations: [
              // 邮件分组
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.inbox),
                label: Text('收件箱'),
                group: '邮件',
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.send),
                label: Text('已发送'),
                group: '邮件',
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.drafts),
                label: Text('草稿'),
                group: '邮件',
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.delete),
                label: Text('垃圾箱'),
                group: '邮件',
              ),
              // 设置分组
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('设置'),
                group: '系统',
              ),
            ],
            groupBuilder: (groupName) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  groupName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              );
            },
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
```

### 带徽章的导航栏

```dart
class BadgeNavigationRailExample extends StatefulWidget {
  @override
  _BadgeNavigationRailExampleState createState() => _BadgeNavigationRailExampleState();
}

class _BadgeNavigationRailExampleState extends State<BadgeNavigationRailExample> {
  int _selectedIndex = 0;
  int _messageCount = 3;
  int _notificationCount = 12;

  final List<Widget> _pages = [
    Center(child: Text('首页', style: TextStyle(fontSize: 24))),
    Center(child: Text('消息', style: TextStyle(fontSize: 24))),
    Center(child: Text('通知', style: TextStyle(fontSize: 24))),
    Center(child: Text('个人', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带徽章的导航栏'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              setState(() => _notificationCount = 0);
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // 带徽章的导航栏
          ZephyrNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
                if (index == 1) {
                  _messageCount = 0; // 清除消息徽章
                }
              });
            },
            labelType: ZephyrNavigationRailLabelType.selected,
            destinations: [
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('首页'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.message),
                label: Text('消息'),
                badge: _messageCount > 0 ? _messageCount.toString() : null,
                badgeColor: Colors.red,
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.notifications),
                label: Text('通知'),
                badge: _notificationCount > 0 ? '!' : null,
                badgeColor: Colors.orange,
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('个人'),
              ),
            ],
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
```

### 可拖拽的导航栏

```dart
class DraggableNavigationRailExample extends StatefulWidget {
  @override
  _DraggableNavigationRailExampleState createState() => _DraggableNavigationRailExampleState();
}

class _DraggableNavigationRailExampleState extends State<DraggableNavigationRailExample> {
  int _selectedIndex = 0;
  double _railWidth = 72;

  final List<Widget> _pages = [
    Center(child: Text('文件', style: TextStyle(fontSize: 24))),
    Center(child: Text('编辑', style: TextStyle(fontSize: 24))),
    Center(child: Text('视图', style: TextStyle(fontSize: 24))),
    Center(child: Text('运行', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 可拖拽的导航栏
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _railWidth += details.delta.dx;
                _railWidth = _railWidth.clamp(56, 200);
              });
            },
            child: ZephyrNavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              minWidth: _railWidth,
              labelType: _railWidth > 100 
                  ? ZephyrNavigationRailLabelType.all 
                  : ZephyrNavigationRailLabelType.none,
              destinations: [
                ZephyrNavigationRailDestination(
                  icon: Icon(Icons.folder),
                  label: Text('文件'),
                ),
                ZephyrNavigationRailDestination(
                  icon: Icon(Icons.edit),
                  label: Text('编辑'),
                ),
                ZephyrNavigationRailDestination(
                  icon: Icon(Icons.visibility),
                  label: Text('视图'),
                ),
                ZephyrNavigationRailDestination(
                  icon: Icon(Icons.play_arrow),
                  label: Text('运行'),
                ),
              ],
              trailing: Container(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.drag_handle),
              ),
            ),
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
```

### 响应式导航栏

```dart
class ResponsiveNavigationRailExample extends StatefulWidget {
  @override
  _ResponsiveNavigationRailExampleState createState() => _ResponsiveNavigationRailExampleState();
}

class _ResponsiveNavigationRailExampleState extends State<ResponsiveNavigationRailExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('仪表板', style: TextStyle(fontSize: 24))),
    Center(child: Text('分析', style: TextStyle(fontSize: 24))),
    Center(child: Text('报告', style: TextStyle(fontSize: 24))),
    Center(child: Text('设置', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // 根据屏幕宽度调整导航栏
    bool extended = screenWidth >= 1200;
    ZephyrNavigationRailLabelType labelType = 
        screenWidth >= 800 
            ? ZephyrNavigationRailLabelType.all 
            : ZephyrNavigationRailLabelType.selected;

    return Scaffold(
      body: Row(
        children: [
          // 响应式导航栏
          ZephyrNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            extended: extended,
            labelType: labelType,
            destinations: [
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('仪表板'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.analytics),
                label: Text('分析'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.assessment),
                label: Text('报告'),
              ),
              ZephyrNavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('设置'),
              ),
            ],
          ),
          // 主内容区域
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrNavigationRail()

```dart
const ZephyrNavigationRail({
  Key? key,
  required int selectedIndex,
  required ValueChanged<int> onDestinationSelected,
  required List<ZephyrNavigationRailDestination> destinations,
  ZephyrNavigationRailLabelType labelType = ZephyrNavigationRailLabelType.none,
  bool extended = false,
  double? minWidth,
  double? maxWidth,
  Widget? leading,
  Widget? trailing,
  Color? backgroundColor,
  Color? selectedItemColor,
  Color? unselectedItemColor,
  Color? indicatorColor,
  double? elevation,
  EdgeInsetsGeometry? padding,
  Decoration? decoration,
  String? group,
  Widget Function(String)? groupBuilder,
  double groupAlignment = -1.0,
  Duration? animationDuration,
  Curve? animationCurve,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `selectedIndex`: 当前选中索引
- `onDestinationSelected`: 目标选择回调
- `destinations`: 导航目标列表
- `labelType`: 标签显示类型
- `extended`: 是否扩展显示
- `minWidth`: 最小宽度
- `maxWidth`: 最大宽度
- `leading`: 前导组件
- `trailing`: 尾部组件
- `backgroundColor`: 背景颜色
- `selectedItemColor`: 选中项颜色
- `unselectedItemColor`: 未选中项颜色
- `indicatorColor`: 指示器颜色
- `elevation`: 阴影高度
- `padding`: 内边距
- `decoration`: 装饰
- `group`: 分组名称
- `groupBuilder`: 分组构建器
- `groupAlignment`: 分组对齐方式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrNavigationRailDestination()

```dart
const ZephyrNavigationRailDestination({
  Key? key,
  required Widget icon,
  Widget? selectedIcon,
  required String label,
  String? badge,
  Color? badgeColor,
  String? group,
  String? tooltip,
  String? semanticLabel,
})
```

### 枚举类型

#### ZephyrNavigationRailLabelType

```dart
enum ZephyrNavigationRailLabelType {
  none,     // 不显示标签
  selected, // 只显示选中项的标签
  all,      // 显示所有标签
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrNavigationRailTheme(
        defaultLabelType: ZephyrNavigationRailLabelType.selected,
        defaultExtended: false,
        defaultMinWidth: 72,
        defaultMaxWidth: 400,
        defaultBackgroundColor: Colors.white,
        defaultSelectedItemColor: Colors.blue,
        defaultUnselectedItemColor: Colors.grey[600],
        defaultIndicatorColor: Colors.blue.withOpacity(0.1),
        defaultElevation: 1,
        defaultPadding: EdgeInsets.symmetric(vertical: 8),
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeInOut,
        defaultBadgeColor: Colors.red,
        groupTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
        hoverColor: Colors.grey.withOpacity(0.1),
        focusColor: Colors.blue.withOpacity(0.1),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultLabelType`: 默认标签显示类型
- `defaultExtended`: 默认是否扩展显示
- `defaultMinWidth`: 默认最小宽度
- `defaultMaxWidth`: 默认最大宽度
- `defaultBackgroundColor`: 默认背景颜色
- `defaultSelectedItemColor`: 默认选中项颜色
- `defaultUnselectedItemColor`: 默认未选中项颜色
- `defaultIndicatorColor`: 默认指示器颜色
- `defaultElevation`: 默认阴影高度
- `defaultPadding`: 默认内边距
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `defaultBadgeColor`: 默认徽章颜色
- `groupTextStyle`: 分组文本样式
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的导航栏宽度

```dart
// ✅ 好的做法：根据使用场景设置合适的宽度
ZephyrNavigationRail(
  minWidth: 72, // 适合标准导航栏
  destinations: _buildDestinations(),
)

// ✅ 好的做法：扩展导航栏使用更大的宽度
ZephyrNavigationRail(
  extended: true,
  minWidth: 200, // 适合显示完整标签
  destinations: _buildDestinations(),
)

// ❌ 避免的做法：宽度过小
ZephyrNavigationRail(
  minWidth: 40, // 点击区域过小，用户体验差
  destinations: _buildDestinations(),
)
```

### 2. 合理的标签显示

```dart
// ✅ 好的做法：根据宽度选择标签显示
class ResponsiveNavigationRail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ZephyrNavigationRail(
      labelType: screenWidth >= 800 
          ? ZephyrNavigationRailLabelType.all 
          : ZephyrNavigationRailLabelType.selected,
      destinations: _buildDestinations(),
    );
  }
}

// ✅ 好的做法：扩展导航栏显示所有标签
ZephyrNavigationRail(
  extended: true,
  labelType: ZephyrNavigationRailLabelType.all,
  destinations: _buildDestinations(),
)

// ❌ 避免的做法：标签显示混乱
ZephyrNavigationRail(
  extended: false,
  labelType: ZephyrNavigationRailLabelType.all, // 空间不足时标签会重叠
  destinations: _buildDestinations(),
)
```

### 3. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整
class AdaptiveNavigationRail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth >= 1200) {
      return ZephyrNavigationRail(
        extended: true,
        destinations: _buildDestinations(),
      );
    } else if (screenWidth >= 800) {
      return ZephyrNavigationRail(
        labelType: ZephyrNavigationRailLabelType.all,
        destinations: _buildDestinations(),
      );
    } else {
      return ZephyrNavigationRail(
        labelType: ZephyrNavigationRailLabelType.none,
        destinations: _buildDestinations(),
      );
    }
  }
}

// ✅ 好的做法：提供拖拽调整
ZephyrNavigationRail(
  minWidth: _railWidth,
  onWidthChanged: (width) {
    setState(() => _railWidth = width);
  },
  destinations: _buildDestinations(),
)

// ❌ 避免的做法：不考虑响应式
ZephyrNavigationRail(
  extended: true, // 在小屏幕上占用过多空间
  destinations: _buildDestinations(),
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrNavigationRail(
  semanticLabel: '主导航菜单',
  enableAccessibilityFeatures: true,
  destinations: [
    ZephyrNavigationRailDestination(
      icon: Icon(Icons.dashboard),
      label: Text('仪表板'),
      semanticLabel: '打开仪表板',
    ),
    ZephyrNavigationRailDestination(
      icon: Icon(Icons.settings),
      label: Text('设置'),
      semanticLabel: '打开设置页面',
    ),
  ],
)

// ✅ 好的做法：提供工具提示
ZephyrNavigationRail(
  destinations: [
    ZephyrNavigationRailDestination(
      icon: Icon(Icons.dashboard),
      label: Text('仪表板'),
      tooltip: '查看仪表板',
    ),
  ],
)

// ❌ 避免的做法：缺乏无障碍支持
ZephyrNavigationRail(
  destinations: [
    ZephyrNavigationRailDestination(
      icon: Icon(Icons.dashboard),
      label: Text('仪表板'),
      // 缺乏语义信息
    ),
  ],
)
```

## 🔄 相关组件

- **ZephyrSideMenu**: 侧边菜单组件
- **ZephyrBottomNavigationBar**: 底部导航栏组件
- **ZephyrTabs**: 选项卡组件
- **ZephyrBreadcrumb**: 面包屑导航组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种导航栏类型
- ✅ 支持扩展和最小化模式
- ✅ 支持分组和徽章
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/navigation/navigation_rail/`
**示例路径**: `example/lib/components/navigation_rail_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日