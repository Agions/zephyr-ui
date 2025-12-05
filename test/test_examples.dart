/// 测试示例
///
/// 展示如何使用测试框架编写测试用例
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/core/constants/design_tokens.dart';
import 'package:velocity_ui/test/lib/test_architecture.dart';
import 'package:velocity_ui/test/lib/test_fixtures.dart';

void main() {
  group('VelocityUI 测试示例', () {
    group('基础组件测试', () {
      testWidgets('按钮应该正确渲染', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('测试按钮'),
                ),
              ),
            ),
          ),
        );
        
        expect(find.text('测试按钮'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });
      
      testWidgets('按钮应该响应点击', (WidgetTester tester) async {
        var wasPressed = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    wasPressed = true;
                  },
                  child: const Text('测试按钮'),
                ),
              ),
            ),
          ),
        );
        
        await tester.tap(find.text('测试按钮'));
        await tester.pumpAndSettle();
        
        expect(wasPressed, isTrue);
      });
      
      testWidgets('文本输入应该接受文本', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: '测试输入',
                  ),
                ),
              ),
            ),
          ),
        );
        
        await tester.enterText(find.byType(TextFormField), 'Hello, World!');
        await tester.pumpAndSettle();
        
        expect(find.text('Hello, World!'), findsOneWidget);
      });
    });
    
    group('主题测试', () {
      testWidgets('组件应该适应亮色主题', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: Container(
                color: VelocityColors.primary500,
                child: const Text('主题测试'),
              ),
            ),
          ),
        );
        
        expect(find.text('主题测试'), findsOneWidget);
      });
      
      testWidgets('组件应该适应暗色主题', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: Container(
                color: VelocityColors.primary500,
                child: const Text('主题测试'),
              ),
            ),
          ),
        );
        
        expect(find.text('主题测试'), findsOneWidget);
      });
    });
    
    group('响应式测试', () {
      testWidgets('组件应该在移动端正确显示', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(320, 568)),
              child: Scaffold(
                body: Container(
                  width: 100,
                  height: 100,
                  color: VelocityColors.primary500,
                  child: const Text('响应式测试'),
                ),
              ),
            ),
          ),
        );
        
        expect(find.text('响应式测试'), findsOneWidget);
      });
      
      testWidgets('组件应该在桌面端正确显示', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(1024, 768)),
              child: Scaffold(
                body: Container(
                  width: 100,
                  height: 100,
                  color: VelocityColors.primary500,
                  child: const Text('响应式测试'),
                ),
              ),
            ),
          ),
        );
        
        expect(find.text('响应式测试'), findsOneWidget);
      });
    });
    
    group('状态管理测试', () {
      testWidgets('计数器应该正确更新状态', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    var count = 0;
                    return Column(
                      children: [
                        Text('计数: $count'),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              count++;
                            });
                          },
                          child: const Text('增加'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
        
        expect(find.text('计数: 0'), findsOneWidget);
        
        await tester.tap(find.text('增加'));
        await tester.pumpAndSettle();
        
        expect(find.text('计数: 1'), findsOneWidget);
      });
    });
    
    group('交互测试', () {
      testWidgets('列表应该支持滚动', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ListView(
                children: List.generate(50, (index) => ListTile(
                  title: Text('项目 $index'),
                )),
              ),
            ),
          ),
        );
        
        expect(find.text('项目 0'), findsOneWidget);
        expect(find.text('项目 49'), findsNothing);
        
        // 滚动到底部
        await tester.fling(find.text('项目 0'), const Offset(0, -500), 1000);
        await tester.pumpAndSettle();
        
        expect(find.text('项目 49'), findsOneWidget);
      });
      
      testWidgets('开关应该切换状态', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
        );
        
        expect(find.byType(Switch), findsOneWidget);
        
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();
        
        // 开关状态应该在回调中更新
      });
    });
    
    group('动画测试', () {
      testWidgets('动画容器应该执行动画', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 100,
                  height: 100,
                  color: VelocityColors.primary500,
                  child: const Text('动画测试'),
                ),
              ),
            ),
          ),
        );
        
        expect(find.text('动画测试'), findsOneWidget);
        
        // 等待动画完成
        await tester.pump(const Duration(milliseconds: 300));
        await tester.pumpAndSettle();
        
        expect(find.text('动画测试'), findsOneWidget);
      });
    });
    
    group('表单测试', () {
      testWidgets('表单应该验证输入', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '邮箱',
                      ),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return '请输入有效的邮箱地址';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('提交'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        
        // 提交空表单
        await tester.tap(find.text('提交'));
        await tester.pumpAndSettle();
        
        // 验证错误消息
        expect(find.text('请输入有效的邮箱地址'), findsOneWidget);
        
        // 输入有效邮箱
        await tester.enterText(find.byType(TextFormField), 'test@example.com');
        await tester.pumpAndSettle();
        
        // 再次提交
        await tester.tap(find.text('提交'));
        await tester.pumpAndSettle();
        
        // 错误消息应该消失
        expect(find.text('请输入有效的邮箱地址'), findsNothing);
      });
    });
    
    group('导航测试', () {
      testWidgets('应该能够在页面间导航', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              '/': (context) => Scaffold(
                appBar: AppBar(title: const Text('首页')),
                body: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  child: const Text('前往第二页'),
                ),
              ),
              '/second': (context) => Scaffold(
                appBar: AppBar(title: const Text('第二页')),
                body: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('返回首页'),
                ),
              ),
            },
            initialRoute: '/',
          ),
        );
        
        expect(find.text('首页'), findsOneWidget);
        expect(find.text('前往第二页'), findsOneWidget);
        
        // 导航到第二页
        await tester.tap(find.text('前往第二页'));
        await tester.pumpAndSettle();
        
        expect(find.text('第二页'), findsOneWidget);
        expect(find.text('返回首页'), findsOneWidget);
        
        // 返回首页
        await tester.tap(find.text('返回首页'));
        await tester.pumpAndSettle();
        
        expect(find.text('首页'), findsOneWidget);
      });
    });
    
    group('性能测试', () {
      testWidgets('按钮构建时间应该在阈值内', (WidgetTester tester) async {
        final widget = ElevatedButton(
          onPressed: () {},
          child: const Text('性能测试'),
        );
        
        final buildTime = await PerformanceTestUtils.measureBuildTime(
          tester,
          widget,
          warmUpCount: 5,
          measureCount: 10,
        );
        
        expect(buildTime.inMicroseconds, lessThan(1000));
      });
    });
    
    group('无障碍测试', () {
      testWidgets('按钮应该有语义标签', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('无障碍测试'),
                ),
              ),
            ),
          ),
        );
        
        final semantics = tester.semantics.find(find.byType(ElevatedButton));
        expect(semantics.label, '无障碍测试');
        expect(semantics.isButton, isTrue);
      });
      
      testWidgets('文本输入应该有语义提示', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: '请输入您的姓名',
                  ),
                ),
              ),
            ),
          ),
        );
        
        final semantics = tester.semantics.find(find.byType(TextFormField));
        expect(semantics.hint, '请输入您的姓名');
        expect(semantics.isTextField, isTrue);
      });
    });
  });
}

/// 自定义测试组件
class TestCounterWidget extends StatefulWidget {
  const TestCounterWidget({super.key});
  
  @override
  State<TestCounterWidget> createState() => _TestCounterWidgetState();
}

class _TestCounterWidgetState extends State<TestCounterWidget> {
  int _count = 0;
  
  void _increment() {
    setState(() {
      _count++;
    });
  }
  
  void _decrement() {
    setState(() {
      _count--;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('计数: $_count'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _decrement,
              child: const Text('-'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: _increment,
              child: const Text('+'),
            ),
          ],
        ),
      ],
    );
  }
}

/// 自定义测试套件
class CustomTestSuite {
  static void runCustomTests() {
    group('自定义组件测试', () {
      testWidgets('计数器应该正确初始化', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: TestCounterWidget(),
              ),
            ),
          ),
        );
        
        expect(find.text('计数: 0'), findsOneWidget);
      });
      
      testWidgets('计数器应该增加', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: TestCounterWidget(),
              ),
            ),
          ),
        );
        
        await tester.tap(find.text('+'));
        await tester.pumpAndSettle();
        
        expect(find.text('计数: 1'), findsOneWidget);
      });
      
      testWidgets('计数器应该减少', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: TestCounterWidget(),
              ),
            ),
          ),
        );
        
        await tester.tap(find.text('-'));
        await tester.pumpAndSettle();
        
        expect(find.text('计数: -1'), findsOneWidget);
      });
    });
  }
}