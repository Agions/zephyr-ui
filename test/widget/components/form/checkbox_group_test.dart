import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/form/checkbox/checkbox.dart';

void main() {
  group('VelocityCheckbox Widget Tests', () {
    testWidgets('renders checkbox with default properties',
        (WidgetTester tester) async {
      bool value = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityCheckbox(
              value: value,
              onChanged: (newValue) => value = newValue,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckbox), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('renders checkbox with label',
        (WidgetTester tester) async {
      bool value = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityCheckbox(
              value: value,
              onChanged: (newValue) => value = newValue,
              label: 'Option 1',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckbox), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
    });

    testWidgets('handles checkbox selection',
        (WidgetTester tester) async {
      bool value = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityCheckbox(
              value: value,
              onChanged: (newValue) => value = newValue,
              label: 'Option 1',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckbox), findsOneWidget);
      expect(value, isFalse);

      // Tap the checkbox to select it
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      expect(value, isTrue);
    });

    testWidgets('handles checkbox deselection',
        (WidgetTester tester) async {
      bool value = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityCheckbox(
              value: value,
              onChanged: (newValue) => value = newValue,
              label: 'Option 1',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckbox), findsOneWidget);
      expect(value, isTrue);

      // Tap the checkbox to deselect it
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      expect(value, isFalse);
    });

    testWidgets('handles disabled checkbox',
        (WidgetTester tester) async {
      bool value = false;
      bool callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityCheckbox(
              value: value,
              onChanged: (newValue) {
                value = newValue;
                callbackCalled = true;
              },
              label: 'Disabled Option',
              disabled: true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckbox), findsOneWidget);
      expect(value, isFalse);

      // Try to tap the disabled checkbox (should not trigger callback)
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      expect(value, isFalse);
      expect(callbackCalled, isFalse);
    });

    testWidgets('handles tap on label to toggle checkbox',
        (WidgetTester tester) async {
      bool value = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityCheckbox(
              value: value,
              onChanged: (newValue) => value = newValue,
              label: 'Clickable Label',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckbox), findsOneWidget);
      expect(value, isFalse);

      // Tap the label to toggle checkbox
      await tester.tap(find.text('Clickable Label'));
      await tester.pump();
      expect(value, isTrue);
    });

    testWidgets('renders multiple checkboxes in same screen',
        (WidgetTester tester) async {
      bool value1 = false;
      bool value2 = true;
      bool value3 = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocityCheckbox(
                  value: value1,
                  onChanged: (newValue) => value1 = newValue,
                  label: 'Option 1',
                ),
                VelocityCheckbox(
                  value: value2,
                  onChanged: (newValue) => value2 = newValue,
                  label: 'Option 2',
                ),
                VelocityCheckbox(
                  value: value3,
                  onChanged: (newValue) => value3 = newValue,
                  label: 'Option 3',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckbox), findsNWidgets(3));
      expect(find.byType(Checkbox), findsNWidgets(3));
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('handles checkbox with null callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityCheckbox(
              value: false,
              onChanged: null,
              label: 'No Callback',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCheckbox), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });
  });
}