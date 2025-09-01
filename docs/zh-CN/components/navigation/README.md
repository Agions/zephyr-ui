---
title: 导航组件
description: ZephyrUI 导航组件，包括标签页、底部导航栏、侧边菜单等导航相关组件
---

# 导航组件

导航组件用于页面导航和路由，提供了丰富的导航选项和交互体验。

## 📦 组件列表

| 组件 | 描述 | 链接 |
|------|------|------|
| [标签页](./tabs) | 支持滑动切换的标签页组件 | [查看文档](./tabs) |
| [底部导航栏](./bottom_navigation_bar) | 底部导航栏组件 | [查看文档](./bottom_navigation_bar) |
| [侧边菜单](./side_menu) | 支持多级菜单的侧边菜单组件 | [查看文档](./side_menu) |
| [步骤器](./stepper) | 支持线性流程的步骤器组件 | [查看文档](./stepper) |
| [分页器](./pagination) | 支持大数据量的分页器组件 | [查看文档](./pagination) |
| [导航栏](./navigation_rail) | 侧边导航栏组件 | [查看文档](./navigation_rail) |
| [树形控件](./tree) | 支持层级数据的树形控件组件 | [查看文档](./tree) |

## 🎯 使用示例

### 基本导航结构
```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class NavigationDemo extends StatefulWidget {
  @override
  _NavigationDemoState createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationDemo> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    Center(child: Text('首页内容')),
    Center(child: Text('发现内容')),
    Center(child: Text('消息内容')),
    Center(child: Text('我的内容')),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('导航示例'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: ZephyrBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
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

### 标签页导航
```dart
class TabsDemo extends StatefulWidget {
  @override
  _TabsDemoState createState() => _TabsDemoState();
}

class _TabsDemoState extends State<TabsDemo> {
  int _currentTab = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标签页示例'),
      ),
      body: Column(
        children: [
          ZephyrTabs(
            currentIndex: _currentTab,
            onTap: (index) {
              setState(() {
                _currentTab = index;
              });
            },
            tabs: [
              ZephyrTab(
                text: '推荐',
                icon: Icon(Icons.recommend),
              ),
              ZephyrTab(
                text: '关注',
                icon: Icon(Icons.favorite),
              ),
              ZephyrTab(
                text: '热门',
                icon: Icon(Icons.local_fire_department),
              ),
            ],
          ),
          
          Expanded(
            child: IndexedStack(
              index: _currentTab,
              children: [
                Center(child: Text('推荐内容')),
                Center(child: Text('关注内容')),
                Center(child: Text('热门内容')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### 侧边菜单
```dart
class SideMenuDemo extends StatefulWidget {
  @override
  _SideMenuDemoState createState() => _SideMenuDemoState();
}

class _SideMenuDemoState extends State<SideMenuDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('侧边菜单示例'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: ZephyrSideMenu(
        header: UserAccountsDrawerHeader(
          accountName: Text('张三'),
          accountEmail: Text('zhangsan@example.com'),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
          ),
        ),
        items: [
          ZephyrMenuItem(
            icon: Icon(Icons.home),
            title: '首页',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ZephyrMenuItem(
            icon: Icon(Icons.person),
            title: '个人中心',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ZephyrMenuItem(
            icon: Icon(Icons.settings),
            title: '设置',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ZephyrMenuItem(
            icon: Icon(Icons.logout),
            title: '退出登录',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Text('点击左上角菜单按钮打开侧边菜单'),
      ),
    );
  }
}
```

### 步骤器
```dart
class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('步骤器示例'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrStepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() {
                _currentStep++;
              });
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          steps: [
            ZephyrStep(
              title: Text('基本信息'),
              content: Column(
                children: [
                  ZephyrInput(
                    placeholder: '请输入姓名',
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 16),
                  ZephyrInput(
                    placeholder: '请输入邮箱',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            ZephyrStep(
              title: '详细信息'),
              content: Column(
                children: [
                  ZephyrInput(
                    placeholder: '请输入电话',
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 16),
                  ZephyrInput(
                    placeholder: '请输入地址',
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            ZephyrStep(
              title: '确认信息',
              content: Text('请确认您填写的信息是否正确'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 主题定制

导航组件支持完整的主题定制，可以通过 `ZephyrThemeData` 统一配置：

```dart
final theme = ZephyrThemeData(
  // 底部导航栏主题
  bottomNavigationBarTheme: ZephyrBottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    elevation: 8,
  ),
  
  // 标签页主题
  tabsTheme: ZephyrTabsThemeData(
    indicatorColor: Colors.blue,
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.grey,
    indicatorWeight: 3,
  ),
  
  // 侧边菜单主题
  sideMenuTheme: ZephyrSideMenuThemeData(
    backgroundColor: Colors.white,
    itemColor: Colors.black87,
    selectedItemColor: Colors.blue,
    elevation: 16,
  ),
  
  // 步骤器主题
  stepperTheme: ZephyrStepperThemeData(
    activeColor: Colors.blue,
    inactiveColor: Colors.grey,
    errorColor: Colors.red,
  ),
);

// 使用主题
ZephyrApp(
  theme: theme,
  home: NavigationDemo(),
)
```

## 📱 响应式设计

导航组件支持响应式设计，可以根据不同的设备尺寸自动调整样式：

```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    final deviceType = sizingInformation.deviceType;
    
    if (deviceType == DeviceType.mobile) {
      // 移动端使用底部导航栏
      return Scaffold(
        bottomNavigationBar: ZephyrBottomNavigationBar(
          items: [
            ZephyrBottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            ZephyrBottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '我的',
            ),
          ],
          onTap: (index) {},
        ),
        body: Center(child: Text('移动端导航')),
      );
    } else if (deviceType == DeviceType.tablet) {
      // 平板使用侧边导航栏
      return Scaffold(
        body: Row(
          children: [
            ZephyrNavigationRail(
              destinations: [
                ZephyrNavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: '首页',
                ),
                ZephyrNavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: '我的',
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (index) {},
            ),
            Expanded(
              child: Center(child: Text('平板端导航')),
            ),
          ],
        ),
      );
    } else {
      // 桌面使用侧边菜单
      return Scaffold(
        drawer: ZephyrSideMenu(
          items: [
            ZephyrMenuItem(
              icon: Icon(Icons.home),
              title: '首页',
              onTap: () {},
            ),
            ZephyrMenuItem(
              icon: Icon(Icons.person),
              title: '我的',
              onTap: () {},
            ),
          ],
        ),
        body: Center(child: Text('桌面端导航')),
      );
    }
  },
)
```

## 🌐 国际化

导航组件支持国际化，可以根据不同的语言环境显示不同的文本：

```dart
MaterialApp(
  localizationsDelegates: [
    ZephyrLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('zh', 'CN'),
    const Locale('en', 'US'),
  ],
  locale: Locale('zh', 'CN'),
  home: NavigationDemo(),
)
```

## 🧪 测试

导航组件提供了完整的测试覆盖：

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('导航组件测试', () {
    testWidgets('底部导航栏测试', (WidgetTester tester) async {
      int currentIndex = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ZephyrBottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                currentIndex = index;
              },
              items: [
                ZephyrBottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '首页',
                ),
                ZephyrBottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '我的',
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.byType(ZephyrBottomNavigationBar), findsOneWidget);
      expect(find.text('首页'), findsOneWidget);
      expect(find.text('我的'), findsOneWidget);
    });

    testWidgets('标签页测试', (WidgetTester tester) async {
      int currentTab = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrTabs(
            currentIndex: currentTab,
            onTap: (index) {
              currentTab = index;
            },
            tabs: [
              ZephyrTab(
                text: '推荐',
                icon: Icon(Icons.recommend),
              ),
              ZephyrTab(
                text: '关注',
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
        ),
      );
      
      expect(find.byType(ZephyrTabs), findsOneWidget);
      expect(find.text('推荐'), findsOneWidget);
      expect(find.text('关注'), findsOneWidget);
    });
  });
}
```

## 📚 相关资源

- [组件总览](../introduction) - 所有组件的概览
- [基础组件](../basic) - 基础UI组件
- [表单组件](../form) - 表单相关的组件
- [展示组件](../display) - 数据展示相关的组件
- [反馈组件](../feedback) - 用户反馈相关的组件
- [路由导航](../../guide/navigation) - 路由导航指南
- [主题定制](../../guide/theme-system) - 主题定制指南

## 🤝 贡献

我们欢迎所有形式的贡献！请阅读 [贡献指南](../../guide/contributing) 了解如何参与项目开发。

## 📄 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](../../../LICENSE) 文件。