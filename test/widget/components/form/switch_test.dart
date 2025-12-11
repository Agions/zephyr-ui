/// Switch组件基础测试
///
/// 测试VelocitySwitch组件的基本功能
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/form/switch/switch.dart';

void main() {
  group('VelocitySwitch', () {
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
            child: VelocitySwitch(
              value: false,
              onChanged: onChanged,
            ),
          ),
        ),
      );

      expect(find.byType(VelocitySwitch), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('点击开关应该切换状态', (WidgetTester tester) async {
      var localValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: StatefulBuilder(
              builder: (context, setState) {
                return VelocitySwitch(
                  value: localValue,
                  onChanged: (value) {
                    setState(() {
                      localValue = value;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      // 初始状态应该是false
      final switchWidget1 =
          tester.widget<VelocitySwitch>(find.byType(VelocitySwitch));
      expect(switchWidget1.value, isFalse);

      // 点击切换到true
      await tester.tap(find.byType(VelocitySwitch));
      await tester.pumpAndSettle();
      final switchWidget2 =
          tester.widget<VelocitySwitch>(find.byType(VelocitySwitch));
      expect(switchWidget2.value, isTrue);

      // 点击切换回false
      await tester.tap(find.byType(VelocitySwitch));
      await tester.pumpAndSettle();
      final switchWidget3 =
          tester.widget<VelocitySwitch>(find.byType(VelocitySwitch));
      expect(switchWidget3.value, isFalse);
    });

    testWidgets('禁用的开关不应该响应点击', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: VelocitySwitch(
              value: false,
              onChanged: onChanged,
              disabled: true,
            ),
          ),
        ),
      );

      expect(switchValue, isFalse);

      await tester.tap(find.byType(VelocitySwitch));
      await tester.pumpAndSettle();

      expect(switchValue, isFalse);
    });

    testWidgets('应该正确渲染带标签的开关', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: VelocitySwitch(
              value: false,
              onChanged: onChanged,
              label: 'Test Label',
            ),
          ),
        ),
      );

      expect(find.byType(VelocitySwitch), findsOneWidget);
      expect(find.text('Test Label'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('应该支持空回调', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Material(
            child: VelocitySwitch(
              value: false,
              onChanged: null,
              label: 'Disabled Switch',
            ),
          ),
        ),
      );

      expect(find.byType(VelocitySwitch), findsOneWidget);
    });

    testWidgets('应该正确显示初始状态', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Column(
              children: [
                VelocitySwitch(
                  value: true,
                  onChanged: onChanged,
                  label: 'Enabled',
                ),
                VelocitySwitch(
                  value: false,
                  onChanged: onChanged,
                  label: 'Disabled',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocitySwitch), findsNWidgets(2));
      expect(find.text('Enabled'), findsOneWidget);
      expect(find.text('Disabled'), findsOneWidget);
    });
  });
}
