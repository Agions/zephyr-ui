/// ZephyrUI 无障碍测试套件
///
/// 提供完整的无障碍测试用例和验证工具

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import '../../lib/src/core/accessibility/accessibility_test_tools.dart';
import '../../lib/src/components/accessibility/enhanced_input.dart';
import '../../lib/src/components/accessibility/accessibility_wrapper.dart';

void main() {
  group('ZephyrUI 无障碍测试套件', () {
    late WidgetTester tester;

    setUp(() {
      tester = WidgetTester(WidgetTesterBinding.instance);
    });

    group('无障碍输入组件测试', () {
      testWidgets('应该正确渲染无障碍输入组件', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleInput(
                labelText: '用户名',
                placeholder: '请输入用户名',
                helperText: '用户名长度应为3-20个字符',
                required: true,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '用户名不能为空';
                  }
                  if (value.length < 3) {
                    return '用户名至少需要3个字符';
                  }
                  return null;
                },
              ),
            ),
          ),
        );

        // 验证组件存在
        expect(find.byType(ZephyrAccessibleInput), findsOneWidget);
        expect(find.text('用户名'), findsOneWidget);
        expect(find.text('请输入用户名'), findsOneWidget);
        expect(find.text('用户名长度应为3-20个字符'), findsOneWidget);
        expect(find.text('*'), findsOneWidget); // 必填标记
      });

      testWidgets('应该正确处理输入验证', (WidgetTester tester) async {
        late String? validationResult;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleInput(
                labelText: '邮箱',
                placeholder: '请输入邮箱地址',
                required: true,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '邮箱不能为空';
                  }
                  if (!value.contains('@')) {
                    return '请输入有效的邮箱地址';
                  }
                  return null;
                },
              ),
            ),
          ),
        );

        // 输入无效邮箱
        await tester.enterText(find.byType(TextField), 'invalid-email');
        await tester.pumpAndSettle();

        // 验证错误消息显示
        expect(find.text('请输入有效的邮箱地址'), findsOneWidget);

        // 输入有效邮箱
        await tester.enterText(find.byType(TextField), 'test@example.com');
        await tester.pumpAndSettle();

        // 验证错误消息消失
        expect(find.text('请输入有效的邮箱地址'), findsNothing);
      });

      testWidgets('应该支持键盘导航', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleInput(
                labelText: '测试输入',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        // 测试Tab键导航
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pumpAndSettle();

        // 验证焦点转移
        final focusNode = tester.widget<FocusNode>(find.byType(FocusNode));
        expect(focusNode.hasFocus, isTrue);
      });

      testWidgets('应该有适当的语义化标记', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleInput(
                labelText: '用户名',
                placeholder: '请输入用户名',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        // 验证语义化属性
        await tester.expectAccessibility(
          widget: find.byType(ZephyrAccessibleInput),
          label: '用户名',
          hint: '请输入用户名',
          isTextField: true,
          isFocusable: true,
        );
      });
    });

    group('无障碍按钮组件测试', () {
      testWidgets('应该正确渲染无障碍按钮', (WidgetTester tester) async {
        bool wasPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleButton(
                text: '点击我',
                onPressed: () {
                  wasPressed = true;
                },
              ),
            ),
          ),
        );

        // 验证组件存在
        expect(find.byType(ZephyrAccessibleButton), findsOneWidget);
        expect(find.text('点击我'), findsOneWidget);

        // 测试点击
        await tester.tap(find.byType(ZephyrAccessibleButton));
        await tester.pumpAndSettle();

        // 验证回调被调用
        expect(wasPressed, isTrue);
      });

      testWidgets('应该支持键盘操作', (WidgetTester tester) async {
        bool wasPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleButton(
                text: '测试按钮',
                onPressed: () {
                  wasPressed = true;
                },
              ),
            ),
          ),
        );

        // 聚焦按钮
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pumpAndSettle();

        // 模拟Enter键
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();

        // 验证回调被调用
        expect(wasPressed, isTrue);
      });

      testWidgets('应该有适当的语义化标记', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleButton(
                text: '提交',
                onPressed: () {},
              ),
            ),
          ),
        );

        // 验证语义化属性
        await tester.expectAccessibility(
          widget: find.byType(ZephyrAccessibleButton),
          label: '提交',
          isButton: true,
          isEnabled: true,
          isFocusable: true,
        );
      });

      testWidgets('应该正确处理禁用状态', (WidgetTester tester) async {
        bool wasPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleButton(
                text: '禁用按钮',
                onPressed: () {
                  wasPressed = true;
                },
                isDisabled: true,
              ),
            ),
          ),
        );

        // 验证按钮被禁用
        final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(button.onPressed, isNull);

        // 测试点击（应该没有反应）
        await tester.tap(find.byType(ZephyrAccessibleButton));
        await tester.pumpAndSettle();

        // 验证回调没有被调用
        expect(wasPressed, isFalse);
      });
    });

    group('无障碍文本字段测试', () {
      testWidgets('应该正确渲染无障碍文本字段', (WidgetTester tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleTextField(
                controller: controller,
                label: '密码',
                hint: '请输入密码',
                isRequired: true,
                isObscured: true,
              ),
            ),
          ),
        );

        // 验证组件存在
        expect(find.byType(ZephyrAccessibleTextField), findsOneWidget);
        expect(find.text('密码'), findsOneWidget);
        expect(find.text('请输入密码'), findsOneWidget);
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      });

      testWidgets('应该支持密码显示/隐藏', (WidgetTester tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleTextField(
                controller: controller,
                label: '密码',
                isObscured: true,
              ),
            ),
          ),
        );

        // 输入密码
        await tester.enterText(find.byType(TextField), 'password123');
        await tester.pumpAndSettle();

        // 验证密码被隐藏
        expect(find.text('password123'), findsNothing);
        expect(find.text('***********'), findsOneWidget);

        // 点击显示密码按钮
        await tester.tap(find.byIcon(Icons.visibility_off));
        await tester.pumpAndSettle();

        // 验证密码显示
        expect(find.text('password123'), findsOneWidget);
      });

      testWidgets('应该有适当的语义化标记', (WidgetTester tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleTextField(
                controller: controller,
                label: '用户名',
                hint: '请输入用户名',
              ),
            ),
          ),
        );

        // 验证语义化属性
        await tester.expectAccessibility(
          widget: find.byType(ZephyrAccessibleTextField),
          label: '用户名',
          hint: '请输入用户名',
          isTextField: true,
          isFocusable: true,
        );
      });
    });

    group('无障碍包装器测试', () {
      testWidgets('应该正确包装组件', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibilityWrapper(
                config: ZephyrAccessibilityWrapperConfig(
                  enableSemantics: true,
                  enableKeyboardNavigation: true,
                  enableFocusIndicator: true,
                  semanticData: ZephyrSemanticData(
                    label: '测试组件',
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        );

        // 验证包装器存在
        expect(find.byType(ZephyrAccessibilityWrapper), findsOneWidget);
        expect(find.byType(Container), findsOneWidget);
      });

      testWidgets('应该应用语义化标记', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibilityWrapper(
                config: ZephyrAccessibilityWrapperConfig(
                  semanticData: ZephyrSemanticData(
                    label: '可点击区域',
                    hint: '点击此区域执行操作',
                  ),
                ),
                isInteractive: true,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        );

        // 验证语义化属性
        await tester.expectAccessibility(
          widget: find.byType(Container),
          label: '可点击区域',
          hint: '点击此区域执行操作',
        );
      });

      testWidgets('应该确保最小触摸目标尺寸', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibilityWrapper(
                config: ZephyrAccessibilityWrapperConfig(
                  minTouchTargetSize: 44.0,
                ),
                isInteractive: true,
                child: Container(
                  width: 20, // 小于最小尺寸
                  height: 20,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        );

        // 验证触摸目标尺寸
        final container = tester.widget<Container>(find.byType(Container));
        final constraints = tester.widget<ConstrainedBox>(find.byType(ConstrainedBox)).constraints;
        
        expect(constraints.minWidth, 44.0);
        expect(constraints.minHeight, 44.0);
      });
    });

    group('完整无障碍测试', () {
      testWidgets('应该通过完整的无障碍检查', (WidgetTester tester) async {
        final testWidget = MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ZephyrAccessibleInput(
                  labelText: '用户名',
                  placeholder: '请输入用户名',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                ZephyrAccessibleButton(
                  text: '提交',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );

        // 运行完整无障碍测试
        final result = await ZephyrAccessibilityTestTools.runFullAccessibilityTest(
          tester,
          testWidget,
          componentName: 'TestForm',
        );

        // 验证测试结果
        expect(result.score, greaterThanOrEqualTo(80.0));
        expect(result.complianceStatus, ZephyrAccessibilityComplianceStatus.fullyCompliant);
      });

      testWidgets('应该生成详细的测试报告', (WidgetTester tester) async {
        final results = <ZephyrAccessibilityTestResult>[];

        // 测试多个组件
        final testWidgets = [
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleInput(
                labelText: '用户名',
                onChanged: (value) {},
              ),
            ),
          ),
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleButton(
                text: '提交',
                onPressed: () {},
              ),
            ),
          ),
        ];

        for (final widget in testWidgets) {
          final result = await ZephyrAccessibilityTestTools.runFullAccessibilityTest(
            tester,
            widget,
            componentName: 'TestComponent',
          );
          results.add(result);
        }

        // 生成测试报告
        final report = ZephyrAccessibilityTestTools.generateTestReport(results);

        // 验证报告结构
        expect(report['summary'], isNotNull);
        expect(report['summary']['totalTests'], 2);
        expect(report['violationsByType'], isNotNull);
        expect(report['detailedResults'], isNotNull);
      });

      testWidgets('应该提供改进建议', (WidgetTester tester) async {
        // 故意创建一个有问题的组件
        final problematicWidget = MaterialApp(
          home: Scaffold(
            body: Container(
              width: 20, // 太小的触摸目标
              height: 20,
              color: Colors.red,
            ),
          ),
        );

        final result = await ZephyrAccessibilityTestTools.runFullAccessibilityTest(
          tester,
          problematicWidget,
          componentName: 'ProblematicComponent',
        );

        // 获取改进建议
        final suggestions = ZephyrAccessibilityTestTools.getImprovementSuggestions([result]);

        // 验证建议存在
        expect(suggestions, isNotEmpty);
        expect(suggestions.any((s) => s.contains('触摸目标')), isTrue);
      });
    });

    group('颜色对比度测试', () {
      testWidgets('应该检查文本颜色对比度', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Text(
                '测试文本',
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ),
        );

        // 运行颜色对比度检查
        final result = await ZephyrAccessibilityTestTools.runFullAccessibilityTest(
          tester,
          MaterialApp(
            home: Scaffold(
              body: Text(
                '测试文本',
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ),
          componentName: 'ContrastTest',
        );

        // 白色文本在黑色背景上应该有足够的对比度
        expect(result.violations.where((v) => v.check == ZephyrAccessibilityCheck.colorContrast), isEmpty);
      });
    });

    group('键盘导航测试', () {
      testWidgets('应该支持完整的键盘导航', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  ZephyrAccessibleInput(
                    labelText: '字段1',
                    onChanged: (value) {},
                  ),
                  ZephyrAccessibleInput(
                    labelText: '字段2',
                    onChanged: (value) {},
                  ),
                  ZephyrAccessibleButton(
                    text: '提交',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        // 测试Tab键导航
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pumpAndSettle();

        // 验证第一个输入框获得焦点
        expect(tester.widget<FocusNode>(find.byType(FocusNode).first).hasFocus, isTrue);

        // 再次按Tab键
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pumpAndSettle();

        // 验证第二个输入框获得焦点
        expect(tester.widget<FocusNode>(find.byType(FocusNode).last).hasFocus, isTrue);

        // 再次按Tab键
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pumpAndSettle();

        // 验证按钮获得焦点
        expect(find.byType(ZephyrAccessibleButton), findsOneWidget);
      });
    });

    group('屏幕阅读器支持测试', () {
      testWidgets('应该支持屏幕阅读器公告', (WidgetTester tester) async {
        bool wasAnnounced = false;

        // 模拟屏幕阅读器
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          const MethodChannel('flutter/accessibility'),
          (call) async {
            if (call.method == 'announce') {
              wasAnnounced = true;
              return null;
            }
            return null;
          },
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrAccessibleInput(
                labelText: '用户名',
                onChanged: (value) {},
                accessibilityConfig: ZephyrAccessibleInputConfig(
                  enableScreenReaderAnnouncement: true,
                ),
              ),
            ),
          ),
        );

        // 聚焦输入框
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();

        // 验证屏幕阅读器公告
        expect(wasAnnounced, isTrue);
      });
    });
  });
}