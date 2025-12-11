import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/form/radio/radio.dart';

void main() {
  group('VelocityRadio Widget Tests', () {
    testWidgets('renders radio with default properties',
        (WidgetTester tester) async {
      var groupValue = '1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRadio(
              value: '1',
              groupValue: groupValue,
              onChanged: (newValue) => groupValue = newValue ?? '1',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadio), findsOneWidget);
    });

    testWidgets('renders radio with label',
        (WidgetTester tester) async {
      var groupValue = '1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRadio(
              value: '1',
              groupValue: groupValue,
              onChanged: (newValue) => groupValue = newValue ?? '1',
              label: 'Option 1',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadio), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
    });

    testWidgets('handles radio selection',
        (WidgetTester tester) async {
      var groupValue = '1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocityRadio(
                  value: '1',
                  groupValue: groupValue,
                  onChanged: (newValue) => groupValue = newValue ?? '1',
                  label: 'Option 1',
                ),
                VelocityRadio(
                  value: '2',
                  groupValue: groupValue,
                  onChanged: (newValue) => groupValue = newValue ?? '1',
                  label: 'Option 2',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadio), findsNWidgets(2));
      expect(groupValue, '1');

      // Tap the second radio to select it
      await tester.tap(find.text('Option 2'));
      await tester.pump();
      expect(groupValue, '2');
    });

    testWidgets('handles disabled radio',
        (WidgetTester tester) async {
      var groupValue = '1';
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRadio(
              value: '2',
              groupValue: groupValue,
              onChanged: (newValue) {
                groupValue = newValue ?? '1';
                callbackCalled = true;
              },
              label: 'Disabled Option',
              disabled: true,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadio), findsOneWidget);
      expect(groupValue, '1');

      // Try to tap the disabled radio (should not trigger callback)
      await tester.tap(find.text('Disabled Option'));
      await tester.pump();
      expect(groupValue, '1');
      expect(callbackCalled, isFalse);
    });

    testWidgets('handles tap on label to toggle radio',
        (WidgetTester tester) async {
      var groupValue = '1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRadio(
              value: '2',
              groupValue: groupValue,
              onChanged: (newValue) => groupValue = newValue ?? '1',
              label: 'Clickable Label',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadio), findsOneWidget);
      expect(groupValue, '1');

      // Tap the label to toggle radio
      await tester.tap(find.text('Clickable Label'));
      await tester.pump();
      expect(groupValue, '2');
    });

    testWidgets('renders multiple radios in same screen',
        (WidgetTester tester) async {
      var groupValue = '2';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocityRadio(
                  value: '1',
                  groupValue: groupValue,
                  onChanged: (newValue) => groupValue = newValue ?? '2',
                  label: 'Option 1',
                ),
                VelocityRadio(
                  value: '2',
                  groupValue: groupValue,
                  onChanged: (newValue) => groupValue = newValue ?? '2',
                  label: 'Option 2',
                ),
                VelocityRadio(
                  value: '3',
                  groupValue: groupValue,
                  onChanged: (newValue) => groupValue = newValue ?? '2',
                  label: 'Option 3',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadio), findsNWidgets(3));
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('handles radio with null callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityRadio(
              value: '1',
              groupValue: '1',
              onChanged: null,
              label: 'No Callback',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadio), findsOneWidget);
    });

    testWidgets('handles radio with null group value',
        (WidgetTester tester) async {
      String? groupValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRadio(
              value: '1',
              groupValue: groupValue,
              onChanged: (newValue) => groupValue = newValue,
              label: 'Nullable Group Value',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocityRadio), findsOneWidget);
      expect(groupValue, isNull);

      // Tap the radio to select it
      await tester.tap(find.text('Nullable Group Value'));
      await tester.pump();
      expect(groupValue, '1');
    });
  });
}