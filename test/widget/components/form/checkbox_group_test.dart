import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/forms/checkbox_group/checkbox_group.dart';
import 'package:velocity_ui/src/components/forms/checkbox_group/checkbox_group_theme.dart';
import 'package:velocity_ui/src/core/theme/theme_data.dart';

void main() {
  group('VelocityCheckboxGroup Widget Tests', () {
    late final ThemeData theme;

    setUpAll(() {
      final velocityTheme = VelocityThemeData.light();
      theme = ThemeData(
        brightness: velocityTheme.brightness,
        primaryColor: velocityTheme.primaryColor,
      );
    });

    testWidgets('renders checkbox group with default properties',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
        const VelocityCheckboxItem(value: '3', label: 'Option 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(3));
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('renders checkbox group with multiple selected values',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
        const VelocityCheckboxItem(value: '3', label: 'Option 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1', '3'],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(3));
    });

    testWidgets('renders checkbox group with horizontal layout',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
              direction: Axis.horizontal,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(2));
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('handles checkbox selection callback',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
      ];

      List<String>? selectedValues;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
              onChanged: (values) => selectedValues = values,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(selectedValues, isNull);

      // Tap the second checkbox
      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedValues, isNotNull);
      expect(selectedValues!.length, 2);
      expect(selectedValues!.contains('1'), isTrue);
      expect(selectedValues!.contains('2'), isTrue);
    });

    testWidgets('handles checkbox deselection callback',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
      ];

      List<String>? selectedValues;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1', '2'],
              onChanged: (values) => selectedValues = values,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(selectedValues, isNull);

      // Tap the first checkbox to deselect it
      await tester.tap(find.text('Option 1'));
      await tester.pump();

      expect(selectedValues, isNotNull);
      expect(selectedValues!.length, 1);
      expect(selectedValues!.contains('1'), isFalse);
      expect(selectedValues!.contains('2'), isTrue);
    });

    testWidgets('handles disabled checkbox group', (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
      ];

      List<String>? selectedValues;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
              disabled: true,
              onChanged: (values) => selectedValues = values,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(selectedValues, isNull);

      // Try to tap the second checkbox (should not trigger callback)
      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedValues, isNull);
    });

    testWidgets('handles individual disabled checkbox items',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2', disabled: true),
        const VelocityCheckboxItem(value: '3', label: 'Option 3'),
      ];

      List<String>? selectedValues;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
              onChanged: (values) => selectedValues = values,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(selectedValues, isNull);

      // Try to tap the disabled checkbox (should not trigger callback)
      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedValues, isNull);

      // Tap the enabled checkbox (should trigger callback)
      await tester.tap(find.text('Option 3'));
      await tester.pump();

      expect(selectedValues, isNotNull);
      expect(selectedValues!.length, 2);
      expect(selectedValues!.contains('1'), isTrue);
      expect(selectedValues!.contains('3'), isTrue);
    });

    testWidgets('handles custom spacing', (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
              spacing: 16.0,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(2));
    });

    testWidgets('handles empty items list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityCheckboxGroup(
              items: [],
              value: [],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNothing);
    });

    testWidgets('handles single item', (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Single Option'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text('Single Option'), findsOneWidget);
    });

    testWidgets('handles custom theme', (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
      ];

      const customTheme = VelocityCheckboxGroupTheme(
        activeColor: Colors.purple,
        checkColor: Colors.white,
        borderColor: Colors.grey,
        disabledBorderColor: Colors.grey,
        textStyle: TextStyle(fontSize: 14, color: Colors.black),
        disabledTextStyle: TextStyle(fontSize: 14, color: Colors.grey),
        borderWidth: 2.0,
        borderRadius: 8.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(2));
    });

    testWidgets('handles value updates from parent',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
      ];

      var values = <String>['1'];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    VelocityCheckboxGroup(
                      items: items,
                      value: values,
                      onChanged: (newValues) {
                        setState(() {
                          values = newValues;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          values = ['2'];
                        });
                      },
                      child: const Text('Update Values'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);

      // Initially, first option should be selected
      final firstCheckbox =
          tester.widget<Checkbox>(find.byType(Checkbox).first);
      expect(firstCheckbox.value, isTrue);

      // Click the button to update values
      await tester.tap(find.text('Update Values'));
      await tester.pump();

      // Now second option should be selected
      final checkboxes =
          tester.widgetList<Checkbox>(find.byType(Checkbox)).toList();
      expect(checkboxes[0].value, isFalse);
      expect(checkboxes[1].value, isTrue);
    });

    testWidgets('handles long labels', (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(
          value: '1',
          label:
              'This is a very long label that should wrap properly without causing any layout issues',
        ),
        const VelocityCheckboxItem(value: '2', label: 'Short label'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(2));
      expect(
          find.text(
              'This is a very long label that should wrap properly without causing any layout issues'),
          findsOneWidget);
    });

    testWidgets('handles special characters in labels',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option with émojis 🔥'),
        const VelocityCheckboxItem(value: '2', label: 'Spëcial Chärs'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(2));
      expect(find.text('Option with émojis 🔥'), findsOneWidget);
      expect(find.text('Spëcial Chärs'), findsOneWidget);
    });

    testWidgets('handles checkbox group in scrollable context',
        (WidgetTester tester) async {
      final items = List.generate(
        10,
        (index) => VelocityCheckboxItem(
          value: index.toString(),
          label: 'Option $index',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: SingleChildScrollView(
              child: VelocityCheckboxGroup(
                items: items,
                value: const ['0', '5'],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(10));
    });

    testWidgets('handles multiple checkbox groups in same screen',
        (WidgetTester tester) async {
      final items1 = [
        const VelocityCheckboxItem(value: '1', label: 'Group 1 Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Group 1 Option 2'),
      ];

      final items2 = [
        const VelocityCheckboxItem(value: 'a', label: 'Group 2 Option A'),
        const VelocityCheckboxItem(value: 'b', label: 'Group 2 Option B'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: [
                VelocityCheckboxGroup(
                  items: items1,
                  value: const ['1'],
                ),
                const SizedBox(height: 20),
                VelocityCheckboxGroup(
                  items: items2,
                  value: const ['a'],
                  direction: Axis.horizontal,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsNWidgets(2));
      expect(find.byType(Checkbox), findsNWidgets(4));
    });

    testWidgets('handles checkbox group with null callback',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Option 1'),
        const VelocityCheckboxItem(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
              onChanged: null,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(2));
    });

    testWidgets('handles checkbox group with mixed disabled states',
        (WidgetTester tester) async {
      final items = [
        const VelocityCheckboxItem(value: '1', label: 'Enabled Option'),
        const VelocityCheckboxItem(
            value: '2', label: 'Disabled Option', disabled: true),
        const VelocityCheckboxItem(value: '3', label: 'Another Enabled Option'),
      ];

      List<String>? selectedValues;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCheckboxGroup(
              items: items,
              value: const ['1'],
              onChanged: (values) => selectedValues = values,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckboxGroup), findsOneWidget);
      expect(selectedValues, isNull);

      // Should be able to select enabled options
      await tester.tap(find.text('Another Enabled Option'));
      await tester.pump();

      expect(selectedValues, isNotNull);
      expect(selectedValues!.length, 2);
      expect(selectedValues!.contains('1'), isTrue);
      expect(selectedValues!.contains('3'), isTrue);

      // Should not be able to select disabled option
      await tester.tap(find.text('Disabled Option'));
      await tester.pump();

      expect(selectedValues!.length, 2);
    });
  });
}
