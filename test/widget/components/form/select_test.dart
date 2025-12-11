import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/form/select/select.dart';

void main() {
  group('VelocitySelect Widget Tests', () {
    testWidgets('renders select with basic properties',
        (WidgetTester tester) async {
      final items = [
        const VelocitySelectItem(value: '1', label: 'Option 1'),
        const VelocitySelectItem(value: '2', label: 'Option 2'),
        const VelocitySelectItem(value: '3', label: 'Option 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              items: items,
              value: '1',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('renders select with hint',
        (WidgetTester tester) async {
      final items = [
        const VelocitySelectItem(value: '1', label: 'Option 1'),
        const VelocitySelectItem(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              items: items,
              value: null,
              onChanged: (value) {},
              hint: 'Select an option',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
      expect(find.text('Select an option'), findsOneWidget);
    });

    testWidgets('renders select with label',
        (WidgetTester tester) async {
      final items = [
        const VelocitySelectItem(value: '1', label: 'Option 1'),
        const VelocitySelectItem(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              items: items,
              value: '1',
              onChanged: (value) {},
              label: 'Select Label',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
      expect(find.text('Select Label'), findsOneWidget);
    });

    testWidgets('renders disabled select', (WidgetTester tester) async {
      final items = [
        const VelocitySelectItem(value: '1', label: 'Option 1'),
        const VelocitySelectItem(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              items: items,
              value: '1',
              onChanged: (value) {},
              disabled: true,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles option selection',
        (WidgetTester tester) async {
      final items = [
        const VelocitySelectItem(value: '1', label: 'Option 1'),
        const VelocitySelectItem(value: '2', label: 'Option 2'),
      ];

      String? selectedValue = '1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return VelocitySelect<String>(
                  items: items,
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
      expect(selectedValue, '1');

      // Tap the select to open dropdown
      await tester.tap(find.byWidgetPredicate((widget) => widget is VelocitySelect));
      await tester.pumpAndSettle();

      // Tap the second option
      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();

      expect(selectedValue, '2');
    });

    testWidgets('handles empty items list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              items: const [],
              value: null,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles single item', (WidgetTester tester) async {
      final items = [
        const VelocitySelectItem(value: '1', label: 'Single Option'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              items: items,
              value: '1',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles option with icon', (WidgetTester tester) async {
      final items = [
        const VelocitySelectItem(
          value: '1',
          label: 'Option with Icon',
          icon: Icons.star,
        ),
        const VelocitySelectItem(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              items: items,
              value: '1',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles disabled option', (WidgetTester tester) async {
      final items = [
        const VelocitySelectItem(value: '1', label: 'Enabled Option'),
        const VelocitySelectItem(
            value: '2', label: 'Disabled Option', disabled: true),
        const VelocitySelectItem(value: '3', label: 'Option 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              items: items,
              value: '1',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles multiple selects in same screen',
        (WidgetTester tester) async {
      final items1 = [
        const VelocitySelectItem(value: '1', label: 'Group 1 Option 1'),
        const VelocitySelectItem(value: '2', label: 'Group 1 Option 2'),
      ];

      final items2 = [
        const VelocitySelectItem(value: 'a', label: 'Group 2 Option A'),
        const VelocitySelectItem(value: 'b', label: 'Group 2 Option B'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocitySelect<String>(
                  items: items1,
                  value: '1',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                VelocitySelect<String>(
                  items: items2,
                  value: 'a',
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsNWidgets(2));
    });

    testWidgets('handles select with integer values',
        (WidgetTester tester) async {
      final items = [
        const VelocitySelectItem(value: 1, label: 'Option 1'),
        const VelocitySelectItem(value: 2, label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<int>(
              items: items,
              value: 1,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });
  });
}