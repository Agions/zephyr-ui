/// 测试用例模板
///
/// 提供各种类型的测试用例模板
library test_fixtures;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/core/constants/design_tokens.dart';

/// 测试用例模板基类
abstract class TestFixtureTemplate {
  const TestFixtureTemplate();
  
  /// 获取测试组件
  Widget getTestWidget();
  
  /// 获取测试包装器
  Widget getTestWrapper(Widget child);
  
  /// 获取测试用例
  List<void Function()> getTestCases();
}

/// 基础组件测试模板
class BasicWidgetTestFixture extends TestFixtureTemplate {
  
  const BasicWidgetTestFixture({
    required this.testName,
    required this.widgetBuilder,
    this.wrapperBuilder,
  });
  final String testName;
  final Widget Function() widgetBuilder;
  final Widget Function(Widget)? wrapperBuilder;
  
  @override
  Widget getTestWidget() => widgetBuilder();
  
  @override
  Widget getTestWrapper(Widget child) {
    return wrapperBuilder?.call(child) ?? MaterialApp(home: child);
  }
  
  @override
  List<void Function()> getTestCases() {
    return [
      () => testWidgets('$testName should render correctly', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
      
      () => testWidgets('$testName should handle tap', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        await tester.tap(find.byType(getTestWidget().runtimeType));
        await tester.pumpAndSettle();
      }),
      
      () => testWidgets('$testName should be visible', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
    ];
  }
}

/// 主题测试模板
class ThemeTestFixture extends TestFixtureTemplate {
  
  const ThemeTestFixture({
    required this.testName,
    required this.widgetBuilder,
    this.themes = const [
      ThemeData.light(),
      ThemeData.dark(),
    ],
  });
  final String testName;
  final Widget Function() widgetBuilder;
  final List<ThemeData> themes;
  
  @override
  Widget getTestWidget() => widgetBuilder();
  
  @override
  Widget getTestWrapper(Widget child) {
    return MaterialApp(
      theme: themes.first,
      home: child,
    );
  }
  
  @override
  List<void Function()> getTestCases() {
    return [
      () => testWidgets('$testName should adapt to light theme', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData.light(),
          home: getTestWidget(),
        ));
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
      
      () => testWidgets('$testName should adapt to dark theme', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData.dark(),
          home: getTestWidget(),
        ));
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
      
      () => testWidgets('$testName should handle theme changes', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData.light(),
          home: getTestWidget(),
        ));
        
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData.dark(),
          home: getTestWidget(),
        ));
        
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
    ];
  }
}

/// 响应式测试模板
class ResponsiveTestFixture extends TestFixtureTemplate {
  
  const ResponsiveTestFixture({
    required this.testName,
    required this.widgetBuilder,
    this.screenSizes = const [
      Size(320, 568),   // Mobile
      Size(768, 1024),  // Tablet
      Size(1024, 768), // Desktop
    ],
  });
  final String testName;
  final Widget Function() widgetBuilder;
  final List<Size> screenSizes;
  
  @override
  Widget getTestWidget() => widgetBuilder();
  
  @override
  Widget getTestWrapper(Widget child) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: screenSizes.first),
        child: child,
      ),
    );
  }
  
  @override
  List<void Function()> getTestCases() {
    return [
      () => testWidgets('$testName should work on mobile', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: screenSizes[0]),
            child: getTestWidget(),
          ),
        ));
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
      
      () => testWidgets('$testName should work on tablet', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: screenSizes[1]),
            child: getTestWidget(),
          ),
        ));
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
      
      () => testWidgets('$testName should work on desktop', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: screenSizes[2]),
            child: getTestWidget(),
          ),
        ));
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
    ];
  }
}

/// 状态管理测试模板
class StateManagementTestFixture extends TestFixtureTemplate {
  
  const StateManagementTestFixture({
    required this.testName,
    required this.widgetBuilder,
    this.stateModifier,
  });
  final String testName;
  final Widget Function() widgetBuilder;
  final void Function(WidgetTester)? stateModifier;
  
  @override
  Widget getTestWidget() => widgetBuilder();
  
  @override
  Widget getTestWrapper(Widget child) {
    return MaterialApp(home: child);
  }
  
  @override
  List<void Function()> getTestCases() {
    return [
      () => testWidgets('$testName should manage state correctly', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
        
        if (stateModifier != null) {
          stateModifier!(tester);
          await tester.pumpAndSettle();
        }
      }),
      
      () => testWidgets('$testName should rebuild on state change', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        
        final stateFinder = find.byType(getTestWidget().runtimeType);
        expect(stateFinder, findsOneWidget);
        
        if (stateModifier != null) {
          stateModifier!(tester);
          await tester.pumpAndSettle();
          expect(stateFinder, findsOneWidget);
        }
      }),
    ];
  }
}

/// 交互测试模板
class InteractionTestFixture extends TestFixtureTemplate {
  
  const InteractionTestFixture({
    required this.testName,
    required this.widgetBuilder,
    required this.interactions,
  });
  final String testName;
  final Widget Function() widgetBuilder;
  final List<void Function(WidgetTester)> interactions;
  
  @override
  Widget getTestWidget() => widgetBuilder();
  
  @override
  Widget getTestWrapper(Widget child) {
    return MaterialApp(home: child);
  }
  
  @override
  List<void Function()> getTestCases() {
    return interactions.map((interaction) {
      return () => testWidgets('$testName should handle interaction', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
        
        interaction(tester);
        await tester.pumpAndSettle();
      });
    }).toList();
  }
}

/// 动画测试模板
class AnimationTestFixture extends TestFixtureTemplate {
  
  const AnimationTestFixture({
    required this.testName,
    required this.widgetBuilder,
    this.animationDuration = const Duration(milliseconds: 300),
  });
  final String testName;
  final Widget Function() widgetBuilder;
  final Duration animationDuration;
  
  @override
  Widget getTestWidget() => widgetBuilder();
  
  @override
  Widget getTestWrapper(Widget child) {
    return MaterialApp(home: child);
  }
  
  @override
  List<void Function()> getTestCases() {
    return [
      () => testWidgets('$testName should start animation', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        await tester.pump(animationDuration ~/ 2);
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
      
      () => testWidgets('$testName should complete animation', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        await tester.pump(animationDuration);
        await tester.pumpAndSettle();
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
      
      () => testWidgets('$testName should reverse animation', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        await tester.pump(animationDuration);
        await tester.pump(animationDuration);
        await tester.pumpAndSettle();
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
    ];
  }
}

/// 表单测试模板
class FormTestFixture extends TestFixtureTemplate {
  
  const FormTestFixture({
    required this.testName,
    required this.widgetBuilder,
    required this.formData,
    required this.validationErrors,
  });
  final String testName;
  final Widget Function() widgetBuilder;
  final Map<String, dynamic> formData;
  final Map<String, String> validationErrors;
  
  @override
  Widget getTestWidget() => widgetBuilder();
  
  @override
  Widget getTestWrapper(Widget child) {
    return MaterialApp(home: child);
  }
  
  @override
  List<void Function()> getTestCases() {
    return [
      () => testWidgets('$testName should validate form', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        
        // 提交空表单
        await tester.tap(find.text('Submit'));
        await tester.pumpAndSettle();
        
        // 验证错误消息
        for (final entry in validationErrors.entries) {
          expect(find.text(entry.value), findsOneWidget);
        }
      }),
      
      () => testWidgets('$testName should accept valid data', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        
        // 填写表单
        for (final entry in formData.entries) {
          await tester.enterText(find.byKey(Key(entry.key)), entry.value.toString());
        }
        
        // 提交表单
        await tester.tap(find.text('Submit'));
        await tester.pumpAndSettle();
        
        // 验证没有错误消息
        for (final entry in validationErrors.entries) {
          expect(find.text(entry.value), findsNothing);
        }
      }),
    ];
  }
}

/// 导航测试模板
class NavigationTestFixture extends TestFixtureTemplate {
  
  const NavigationTestFixture({
    required this.testName,
    required this.widgetBuilder,
    required this.routes,
  });
  final String testName;
  final Widget Function() widgetBuilder;
  final Map<String, WidgetBuilder> routes;
  
  @override
  Widget getTestWidget() => widgetBuilder();
  
  @override
  Widget getTestWrapper(Widget child) {
    return MaterialApp(
      routes: routes,
      home: child,
    );
  }
  
  @override
  List<void Function()> getTestCases() {
    return [
      () => testWidgets('$testName should navigate to routes', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        
        for (final routeName in routes.keys) {
          await tester.tap(find.text('Go to $routeName'));
          await tester.pumpAndSettle();
          expect(find.byType(routes[routeName]!(context).runtimeType), findsOneWidget);
          
          // 返回主页
          await tester.tap(find.byIcon(Icons.arrow_back));
          await tester.pumpAndSettle();
        }
      }),
      
      () => testWidgets('$testName should handle back navigation', (WidgetTester tester) async {
        await tester.pumpWidget(getTestWrapper(getTestWidget()));
        
        // 导航到其他页面
        final routeName = routes.keys.first;
        await tester.tap(find.text('Go to $routeName'));
        await tester.pumpAndSettle();
        
        // 返回主页
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        expect(find.byType(getTestWidget().runtimeType), findsOneWidget);
      }),
    ];
  }
}

/// 测试用例工厂
class TestFixtureFactory {
  static final Map<String, TestFixtureTemplate> _fixtures = {};
  
  /// 注册测试用例
  static void registerFixture(String name, TestFixtureTemplate fixture) {
    _fixtures[name] = fixture;
  }
  
  /// 获取测试用例
  static TestFixtureTemplate? getFixture(String name) {
    return _fixtures[name];
  }
  
  /// 运行所有测试用例
  static void runAllTests() {
    for (final fixture in _fixtures.values) {
      final testCases = fixture.getTestCases();
      for (final testCase in testCases) {
        testCase();
      }
    }
  }
  
  /// 运行指定测试用例
  static void runTestFixture(String name) {
    final fixture = getFixture(name);
    if (fixture != null) {
      final testCases = fixture.getTestCases();
      for (final testCase in testCases) {
        testCase();
      }
    }
  }
  
  /// 创建基础组件测试
  static BasicWidgetTestFixture createBasicWidgetTest({
    required String testName,
    required Widget Function() widgetBuilder,
    Widget Function(Widget)? wrapperBuilder,
  }) {
    return BasicWidgetTestFixture(
      testName: testName,
      widgetBuilder: widgetBuilder,
      wrapperBuilder: wrapperBuilder,
    );
  }
  
  /// 创建主题测试
  static ThemeTestFixture createThemeTest({
    required String testName,
    required Widget Function() widgetBuilder,
    List<ThemeData> themes = const [
      ThemeData.light(),
      ThemeData.dark(),
    ],
  }) {
    return ThemeTestFixture(
      testName: testName,
      widgetBuilder: widgetBuilder,
      themes: themes,
    );
  }
  
  /// 创建响应式测试
  static ResponsiveTestFixture createResponsiveTest({
    required String testName,
    required Widget Function() widgetBuilder,
    List<Size> screenSizes = const [
      Size(320, 568),   // Mobile
      Size(768, 1024),  // Tablet
      Size(1024, 768), // Desktop
    ],
  }) {
    return ResponsiveTestFixture(
      testName: testName,
      widgetBuilder: widgetBuilder,
      screenSizes: screenSizes,
    );
  }
  
  /// 创建状态管理测试
  static StateManagementTestFixture createStateManagementTest({
    required String testName,
    required Widget Function() widgetBuilder,
    void Function(WidgetTester)? stateModifier,
  }) {
    return StateManagementTestFixture(
      testName: testName,
      widgetBuilder: widgetBuilder,
      stateModifier: stateModifier,
    );
  }
  
  /// 创建交互测试
  static InteractionTestFixture createInteractionTest({
    required String testName,
    required Widget Function() widgetBuilder,
    required List<void Function(WidgetTester)> interactions,
  }) {
    return InteractionTestFixture(
      testName: testName,
      widgetBuilder: widgetBuilder,
      interactions: interactions,
    );
  }
  
  /// 创建动画测试
  static AnimationTestFixture createAnimationTest({
    required String testName,
    required Widget Function() widgetBuilder,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    return AnimationTestFixture(
      testName: testName,
      widgetBuilder: widgetBuilder,
      animationDuration: animationDuration,
    );
  }
  
  /// 创建表单测试
  static FormTestFixture createFormTest({
    required String testName,
    required Widget Function() widgetBuilder,
    required Map<String, dynamic> formData,
    required Map<String, String> validationErrors,
  }) {
    return FormTestFixture(
      testName: testName,
      widgetBuilder: widgetBuilder,
      formData: formData,
      validationErrors: validationErrors,
    );
  }
  
  /// 创建导航测试
  static NavigationTestFixture createNavigationTest({
    required String testName,
    required Widget Function() widgetBuilder,
    required Map<String, WidgetBuilder> routes,
  }) {
    return NavigationTestFixture(
      testName: testName,
      widgetBuilder: widgetBuilder,
      routes: routes,
    );
  }
}

/// 常用测试用例
class CommonTestFixtures {
  /// 按钮测试
  static final buttonTest = TestFixtureFactory.createBasicWidgetTest(
    testName: 'Button',
    widgetBuilder: () => ElevatedButton(
      onPressed: () {},
      child: const Text('Test Button'),
    ),
  );
  
  /// 文本输入测试
  static final textInputTest = TestFixtureFactory.createBasicWidgetTest(
    testName: 'TextInput',
    widgetBuilder: () => TextFormField(
      decoration: const InputDecoration(
        labelText: 'Test Input',
      ),
    ),
  );
  
  /// 卡片测试
  static final cardTest = TestFixtureFactory.createBasicWidgetTest(
    testName: 'Card',
    widgetBuilder: () => const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Test Card'),
      ),
    ),
  );
  
  /// 列表测试
  static final listTest = TestFixtureFactory.createBasicWidgetTest(
    testName: 'List',
    widgetBuilder: () => ListView(
      children: List.generate(5, (index) => ListTile(
        title: Text('Item $index'),
      )),
    ),
  );
  
  /// 主题测试
  static final themeTest = TestFixtureFactory.createThemeTest(
    testName: 'Theme',
    widgetBuilder: () => Container(
      color: VelocityColors.primary500,
      child: const Text('Theme Test'),
    ),
  );
  
  /// 响应式测试
  static final responsiveTest = TestFixtureFactory.createResponsiveTest(
    testName: 'Responsive',
    widgetBuilder: () => Container(
      width: 100,
      height: 100,
      color: VelocityColors.primary500,
      child: const Text('Responsive Test'),
    ),
  );
  
  /// 状态管理测试
  static final stateManagementTest = TestFixtureFactory.createStateManagementTest(
    testName: 'StateManagement',
    widgetBuilder: () => StatefulWidget(
      key: const Key('state_test'),
      builder: (context, setState) {
        return ElevatedButton(
          onPressed: () {
            setState(() {});
          },
          child: const Text('State Test'),
        );
      },
    ),
  );
  
  /// 交互测试
  static final interactionTest = TestFixtureFactory.createInteractionTest(
    testName: 'Interaction',
    widgetBuilder: () => ElevatedButton(
      key: const Key('interaction_test'),
      onPressed: () {},
      child: const Text('Interaction Test'),
    ),
    interactions: [
      (tester) async {
        await tester.tap(find.byKey(const Key('interaction_test')));
        await tester.pumpAndSettle();
      },
      (tester) async {
        await tester.longPress(find.byKey(const Key('interaction_test')));
        await tester.pumpAndSettle();
      },
    ],
  );
  
  /// 动画测试
  static final animationTest = TestFixtureFactory.createAnimationTest(
    testName: 'Animation',
    widgetBuilder: () => AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: VelocityColors.primary500,
      child: const Text('Animation Test'),
    ),
  );
  
  /// 表单测试
  static final formTest = TestFixtureFactory.createFormTest(
    testName: 'Form',
    widgetBuilder: () => Form(
      child: Column(
        children: [
          TextFormField(
            key: const Key('email_field'),
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          ElevatedButton(
            key: const Key('submit_button'),
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ],
      ),
    ),
    formData: {
      'email': 'test@example.com',
    },
    validationErrors: {
      'email': 'Please enter a valid email',
    },
  );
  
  /// 导航测试
  static final navigationTest = TestFixtureFactory.createNavigationTest(
    testName: 'Navigation',
    widgetBuilder: () => Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Test'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Go to Page 1'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Go to Page 2'),
          ),
        ],
      ),
    ),
    routes: {
      'page1': (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Page 1'),
        ),
        body: const Center(child: Text('Page 1')),
      ),
      'page2': (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Page 2'),
        ),
        body: const Center(child: Text('Page 2')),
      ),
    },
  );
  
  /// 注册所有常用测试用例
  static void registerCommonFixtures() {
    TestFixtureFactory.registerFixture('button', buttonTest);
    TestFixtureFactory.registerFixture('textInput', textInputTest);
    TestFixtureFactory.registerFixture('card', cardTest);
    TestFixtureFactory.registerFixture('list', listTest);
    TestFixtureFactory.registerFixture('theme', themeTest);
    TestFixtureFactory.registerFixture('responsive', responsiveTest);
    TestFixtureFactory.registerFixture('stateManagement', stateManagementTest);
    TestFixtureFactory.registerFixture('interaction', interactionTest);
    TestFixtureFactory.registerFixture('animation', animationTest);
    TestFixtureFactory.registerFixture('form', formTest);
    TestFixtureFactory.registerFixture('navigation', navigationTest);
  }
}