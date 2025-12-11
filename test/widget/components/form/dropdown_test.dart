import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/form/select/select.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  group('VelocitySelect Widget Tests', () {
    late List<VelocitySelectItem<String>> testItems;

    setUp(() {
      testItems = [
        const VelocitySelectItem(
          value: 'option1',
          label: '选项 1',
        ),
        const VelocitySelectItem(
          value: 'option2',
          label: '选项 2',
        ),
        const VelocitySelectItem(
          value: 'option3',
          label: '选项 3',
          disabled: true,
        ),
      ];
    });

    testWidgets('renders basic select', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              value: null,
              items: testItems,
              hint: '请选择',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('请选择'), findsOneWidget);
      expect(find.byType(VelocitySelect<String>), findsOneWidget);
    });

    testWidgets('shows hint when no value selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              value: null,
              items: testItems,
              hint: '请选择一个选项',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('请选择一个选项'), findsOneWidget);
    });

    testWidgets('displays selected value', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              value: 'option1',
              items: testItems,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('选项 1'), findsOneWidget);
    });

    testWidgets('opens dropdown when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              value: null,
              items: testItems,
              hint: '请选择',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocitySelect<String>));
      await tester.pump();

      // Dropdown should be open
      expect(find.text('选项 1'), findsAtLeastNWidgets(1));
      expect(find.text('选项 2'), findsAtLeastNWidgets(1));
    });

    testWidgets('calls onChanged when option selected', (WidgetTester tester) async {
      String? selectedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              value: null,
              items: testItems,
              hint: '请选择',
              onChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocitySelect<String>));
      await tester.pump();

      await tester.tap(find.text('选项 1'));
      await tester.pump();

      expect(selectedValue, equals('option1'));
    });

    testWidgets('disables dropdown when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              value: null,
              items: testItems,
              hint: '请选择',
              disabled: true,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      // Disabled dropdown should not respond to taps
      await tester.tap(find.byType(VelocitySelect<String>));
      await tester.pump();
    });

    testWidgets('shows label when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              value: null,
              items: testItems,
              hint: '请选择',
              label: '选择一个选项',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('选择一个选项'), findsOneWidget);
    });

    testWidgets('handles disabled items correctly', (WidgetTester tester) async {
      String? selectedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySelect<String>(
              value: null,
              items: testItems,
              hint: '请选择',
              onChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocitySelect<String>));
      await tester.pump();

      // Try to select disabled item
      await tester.tap(find.text('选项 3'));
      await tester.pump();

      // Selected value should still be null
      expect(selectedValue, isNull);
    });
  });
}