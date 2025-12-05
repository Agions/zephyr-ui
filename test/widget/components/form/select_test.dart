import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/forms/select/select.dart';
import 'package:velocity_ui/src/core/constants/enums.dart';

void main() {
  group('VelocitySelect Widget Tests', () {
    testWidgets('renders select with basic properties',
        (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
        const VelocitySelectOption(value: '3', label: 'Option 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              value: '1',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('renders select with different sizes',
        (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocitySelect<String>(
                  options: options,
                  size: VelocitySize.sm,
                ),
                const SizedBox(height: 16),
                VelocitySelect<String>(
                  options: options,
                  size: VelocitySize.lg,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsNWidgets(2));
    });

    testWidgets('renders disabled select', (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles option selection callback',
        (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
      expect(selectedValue, isNull);
    });

    testWidgets('handles empty options list', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: [],
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles single option', (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Single Option'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              value: '1',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles option with icon', (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(
          value: '1',
          label: 'Option with Icon',
          icon: Icon(Icons.star),
        ),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              value: '1',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles option with description', (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(
          value: '1',
          label: 'Option 1',
          description: 'This is option 1 description',
        ),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              value: '1',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles disabled option', (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Enabled Option'),
        const VelocitySelectOption(
            value: '2', label: 'Disabled Option', disabled: true),
        const VelocitySelectOption(value: '3', label: 'Option 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles multiple selects in same screen',
        (WidgetTester tester) async {
      final options1 = [
        const VelocitySelectOption(value: '1', label: 'Group 1 Option 1'),
        const VelocitySelectOption(value: '2', label: 'Group 1 Option 2'),
      ];

      final options2 = [
        const VelocitySelectOption(value: 'a', label: 'Group 2 Option A'),
        const VelocitySelectOption(value: 'b', label: 'Group 2 Option B'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocitySelect<String>(
                  options: options1,
                ),
                const SizedBox(height: 16),
                VelocitySelect<String>(
                  options: options2,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsNWidgets(2));
    });

    testWidgets('handles select with null values in constructor',
        (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              onChanged: null,
              onFocusChange: null,
              validator: null,
              theme: null,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles select with integer values',
        (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: 1, label: 'Option 1'),
        const VelocitySelectOption(value: 2, label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<int>(
              options: options,
              value: 1,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles select with searchable option',
        (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              searchable: true,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('handles select with clearable option',
        (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              value: '1',
              clearable: true,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
    });

    testWidgets('renders select with prefix icon', (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              prefixIcon: const Icon(Icons.location_on),
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);
    });

    testWidgets('renders select with suffix icon', (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    });

    testWidgets('handles focus change callback', (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      bool? isFocused;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              onFocusChange: (focused) => isFocused = focused,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
      expect(isFocused, isNull);
    });

    testWidgets('handles validator callback', (WidgetTester tester) async {
      final options = [
        const VelocitySelectOption(value: '1', label: 'Option 1'),
        const VelocitySelectOption(value: '2', label: 'Option 2'),
      ];

      String? validationResult;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              options: options,
              validator: (value) {
                validationResult = value == null ? 'Required' : null;
                return validationResult;
              },
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySelect),
          findsOneWidget);
      expect(validationResult, isNull);
    });
  });
}
