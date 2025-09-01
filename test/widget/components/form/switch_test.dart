/// Switch组件基础测试
///
/// 测试ZephyrSwitch组件的基本功能
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/forms/switch/switch.dart';
import 'package:zephyr_ui/src/components/forms/switch/switch_theme.dart';
import 'package:zephyr_ui/src/core/constants/enums.dart';

void main() {
  group('ZephyrSwitch', () {
    late bool switchValue;
    late ValueChanged<bool>? onChanged;

    setUp(() {
      switchValue = false;
      onChanged = (value) {
        switchValue = value;
      };
    });

    testWidgets('应该正确渲染开关组件', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ZephyrSwitch(
              value: false,
              onChanged: onChanged,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrSwitch), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('点击开关应该切换状态', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ZephyrSwitch(
              value: false,
              onChanged: onChanged,
            ),
          ),
        ),
      );

      expect(switchValue, isFalse);

      await tester.tap(find.byType(ZephyrSwitch));
      await tester.pumpAndSettle();
      expect(switchValue, isTrue);

      await tester.tap(find.byType(ZephyrSwitch));
      await tester.pumpAndSettle();
      expect(switchValue, isFalse);
    });

    testWidgets('禁用的开关不应该响应点击', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Material(
            child: ZephyrSwitch(
              value: false,
              onChanged: null,
            ),
          ),
        ),
      );

      expect(switchValue, isFalse);

      await tester.tap(find.byType(ZephyrSwitch));
      await tester.pumpAndSettle();

      expect(switchValue, isFalse);
    });

    testWidgets('应该支持不同尺寸', (WidgetTester tester) async {
      for (final size in ZephyrSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrSwitch(
                value: false,
                onChanged: onChanged,
                size: size,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrSwitch), findsOneWidget);
      }
    });

    testWidgets('应该支持不同变体', (WidgetTester tester) async {
      for (final variant in ZephyrVariant.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrSwitch(
                value: false,
                onChanged: onChanged,
                variant: variant,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrSwitch), findsOneWidget);
      }
    });

    testWidgets('应该支持自定义颜色', (WidgetTester tester) async {
      const customColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ZephyrSwitch(
              value: true,
              onChanged: onChanged,
              activeColor: customColor,
              thumbColor: customColor,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrSwitch), findsOneWidget);
    });

    testWidgets('应该支持自定义主题', (WidgetTester tester) async {
      final customTheme = ZephyrSwitchTheme(
        activeColor: Colors.red,
        inactiveColor: Colors.blue,
        thumbColor: Colors.green,
        disabledColor: Colors.grey,
        disabledThumbColor: Colors.black38,
        borderColor: Colors.purple,
        borderWidth: 2.0,
        thumbShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 2.0,
            offset: const Offset(0, 1),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ZephyrSwitch(
              value: false,
              onChanged: onChanged,
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrSwitch), findsOneWidget);
    });

    testWidgets('应该正确处理焦点', (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ZephyrSwitch(
              value: false,
              onChanged: onChanged,
              focusNode: focusNode,
              autofocus: true,
            ),
          ),
        ),
      );

      expect(focusNode.hasFocus, isTrue);

      focusNode.dispose();
    });

    testWidgets('应该支持焦点管理', (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ZephyrSwitch(
              value: false,
              onChanged: onChanged,
              focusNode: focusNode,
              autofocus: true,
            ),
          ),
        ),
      );

      expect(focusNode.hasFocus, isTrue);

      focusNode.dispose();
    });

    testWidgets('应该正确显示滑块动画', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ZephyrSwitch(
              value: false,
              onChanged: onChanged,
            ),
          ),
        ),
      );

      // 验证初始状态
      expect(switchValue, isFalse);

      // 点击切换状态
      await tester.tap(find.byType(ZephyrSwitch));
      await tester.pumpAndSettle();

      expect(switchValue, isTrue);

      // 验证动画完成
      expect(tester.binding.hasScheduledFrame, isFalse);
    });
  });

  group('ZephyrLabeledSwitch', () {
    testWidgets('应该正确渲染带标签的开关', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ZephyrLabeledSwitch(
              value: false,
              onChanged: (value) {},
              label: 'Test Label',
              description: 'Test Description',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrLabeledSwitch), findsOneWidget);
      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.byType(ZephyrSwitch), findsOneWidget);
    });

    testWidgets('应该支持不同的标签位置', (WidgetTester tester) async {
      for (final position in ZephyrPosition.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrLabeledSwitch(
                value: false,
                onChanged: (value) {},
                label: 'Test Label',
                labelPosition: position,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrLabeledSwitch), findsOneWidget);
        expect(find.text('Test Label'), findsOneWidget);
      }
    });

    testWidgets('应该在没有标签时正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ZephyrLabeledSwitch(
              value: false,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrLabeledSwitch), findsOneWidget);
      expect(find.byType(ZephyrSwitch), findsOneWidget);
    });
  });
}
