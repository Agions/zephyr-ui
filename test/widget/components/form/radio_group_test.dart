import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/forms/radio_group/radio_group.dart';
import 'package:velocity_ui/src/components/forms/radio_group/radio_group_theme.dart';
import 'package:velocity_ui/src/core/theme/theme_data.dart';

void main() {
  group('VelocityRadioGroup Widget Tests', () {
    late final ThemeData theme;

    setUpAll(() {
      final velocityTheme = VelocityThemeData.light();
      theme = ThemeData(
        brightness: velocityTheme.brightness,
        primaryColor: velocityTheme.primaryColor,
      );
    });

    testWidgets('renders radio group with default properties',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2'),
        const VelocityRadioItem(value: '3', label: 'Option 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('renders radio group with horizontal layout',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup(
              items: items,
              value: '1',
              direction: VelocityRadioDirection.horizontal,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('handles radio selection callback',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2'),
      ];

      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(selectedValue, isNull);

      // Tap the second radio
      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedValue, isNotNull);
      expect(selectedValue, '2');
    });

    testWidgets('handles radio reselection callback',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2'),
      ];

      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(selectedValue, isNull);

      // Tap the first radio (already selected)
      await tester.tap(find.text('Option 1'));
      await tester.pump();

      expect(selectedValue, isNotNull);
      expect(selectedValue, '1');
    });

    testWidgets('handles disabled radio group', (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2'),
      ];

      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
              disabled: true,
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(selectedValue, isNull);

      // Try to tap the second radio (should not trigger callback)
      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedValue, isNull);
    });

    testWidgets('handles individual disabled radio items',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2', disabled: true),
        const VelocityRadioItem(value: '3', label: 'Option 3'),
      ];

      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(selectedValue, isNull);

      // Try to tap the disabled radio (should not trigger callback)
      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedValue, isNull);

      // Tap the enabled radio (should trigger callback)
      await tester.tap(find.text('Option 3'));
      await tester.pump();

      expect(selectedValue, isNotNull);
      expect(selectedValue, '3');
    });

    testWidgets('handles empty items list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityRadioGroup<String>(
              items: [],
              value: null,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(find.text('Option'), findsNothing);
    });

    testWidgets('handles single item', (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Single Option'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(find.text('Single Option'), findsOneWidget);
    });

    testWidgets('handles custom theme', (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2'),
      ];

      const customTheme = VelocityRadioGroupTheme(
        activeColor: Colors.purple,
        borderColor: Colors.grey,
        disabledBorderColor: Colors.grey,
        textStyle: TextStyle(fontSize: 14, color: Colors.black),
        selectedTextStyle: TextStyle(
            fontSize: 14, color: Colors.purple, fontWeight: FontWeight.bold),
        disabledTextStyle: TextStyle(fontSize: 14, color: Colors.grey),
        borderWidth: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('handles value updates from parent',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2'),
      ];

      var value = '1';

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    VelocityRadioGroup<String>(
                      items: items,
                      value: value,
                      onChanged: (newValue) {
                        setState(() {
                          value = newValue;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          value = '2';
                        });
                      },
                      child: const Text('Update Value'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);

      // Initially, first option should be selected
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);

      // Click the button to update value
      await tester.tap(find.text('Update Value'));
      await tester.pump();

      // Now second option should be selected
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('handles special characters in labels',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option with émojis 🔥'),
        const VelocityRadioItem(value: '2', label: 'Spëcial Chärs'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(find.text('Option with émojis 🔥'), findsOneWidget);
      expect(find.text('Spëcial Chärs'), findsOneWidget);
    });

    testWidgets('handles radio group in scrollable context',
        (WidgetTester tester) async {
      final items = List.generate(
        10,
        (index) => VelocityRadioItem(
          value: index.toString(),
          label: 'Option $index',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: SingleChildScrollView(
              child: VelocityRadioGroup(
                items: items,
                value: '5',
              ),
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(find.text('Option 0'), findsOneWidget);
      expect(find.text('Option 5'), findsOneWidget);
      expect(find.text('Option 9'), findsOneWidget);
    });

    testWidgets('handles multiple radio groups in same screen',
        (WidgetTester tester) async {
      final items1 = [
        const VelocityRadioItem(value: '1', label: 'Group 1 Option 1'),
        const VelocityRadioItem(value: '2', label: 'Group 1 Option 2'),
      ];

      final items2 = [
        const VelocityRadioItem(value: 'a', label: 'Group 2 Option A'),
        const VelocityRadioItem(value: 'b', label: 'Group 2 Option B'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: [
                VelocityRadioGroup<String>(
                  items: items1,
                  value: '1',
                ),
                const SizedBox(height: 20),
                VelocityRadioGroup<String>(
                  items: items2,
                  value: 'a',
                  direction: VelocityRadioDirection.horizontal,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsNWidgets(2));
      expect(find.text('Group 1 Option 1'), findsOneWidget);
      expect(find.text('Group 1 Option 2'), findsOneWidget);
      expect(find.text('Group 2 Option A'), findsOneWidget);
      expect(find.text('Group 2 Option B'), findsOneWidget);
    });

    testWidgets('handles radio group with null callback',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
              onChanged: null,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('handles radio group with mixed disabled states',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Enabled Option'),
        const VelocityRadioItem(
            value: '2', label: 'Disabled Option', disabled: true),
        const VelocityRadioItem(value: '3', label: 'Another Enabled Option'),
      ];

      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: '1',
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(selectedValue, isNull);

      // Should be able to select enabled options
      await tester.tap(find.text('Another Enabled Option'));
      await tester.pump();

      expect(selectedValue, isNotNull);
      expect(selectedValue, '3');

      // Should not be able to select disabled option
      await tester.tap(find.text('Disabled Option'));
      await tester.pump();

      expect(selectedValue, '3');
    });

    testWidgets('handles radio group with null initial value',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: '1', label: 'Option 1'),
        const VelocityRadioItem(value: '2', label: 'Option 2'),
      ];

      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<String>(
              items: items,
              value: null,
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(selectedValue, isNull);

      // Should be able to select an option
      await tester.tap(find.text('Option 1'));
      await tester.pump();

      expect(selectedValue, isNotNull);
      expect(selectedValue, '1');
    });

    testWidgets('handles radio group with integer values',
        (WidgetTester tester) async {
      final items = [
        const VelocityRadioItem(value: 1, label: 'Option 1'),
        const VelocityRadioItem(value: 2, label: 'Option 2'),
      ];

      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityRadioGroup<int>(
              items: items,
              value: 1,
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadioGroup),
          findsOneWidget);
      expect(selectedValue, isNull);

      // Should be able to select integer value
      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedValue, isNotNull);
      expect(selectedValue, 2);
    });
  });
}
