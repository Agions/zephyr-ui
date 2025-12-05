import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/forms/dropdown/index.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  group('VelocityDropdown Widget Tests', () {
    late List<VelocityDropdownOption<String>> testOptions;
    late List<VelocityDropdownGroup<String>> testGroups;

    setUp(() {
      testOptions = [
        const VelocityDropdownOption(
          value: 'option1',
          label: '选项 1',
          description: '这是选项1的描述',
        ),
        const VelocityDropdownOption(
          value: 'option2',
          label: '选项 2',
          description: '这是选项2的描述',
        ),
        const VelocityDropdownOption(
          value: 'option3',
          label: '选项 3',
          disabled: true,
        ),
      ];

      testGroups = [
        VelocityDropdownGroup(
          title: '分组 1',
          options: [
            const VelocityDropdownOption(value: 'group1_option1', label: '分组1选项1'),
            const VelocityDropdownOption(value: 'group1_option2', label: '分组1选项2'),
          ],
        ),
        VelocityDropdownGroup(
          title: '分组 2',
          options: [
            const VelocityDropdownOption(value: 'group2_option1', label: '分组2选项1'),
            const VelocityDropdownOption(value: 'group2_option2', label: '分组2选项2'),
          ],
        ),
      ];
    });

    testWidgets('renders basic dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('请选择'), findsOneWidget);
      expect(find.byType(VelocityDropdown<String>), findsOneWidget);
    });

    testWidgets('shows placeholder when no value selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              placeholder: '请选择一个选项',
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
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              value: 'option1',
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
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocityDropdown<String>));
      await tester.pump();

      // Dropdown should be open
      expect(find.text('选项 1'), findsAtLeastNWidgets(1));
      expect(find.text('选项 2'), findsAtLeastNWidgets(1));
    });

    testWidgets('calls onChanged when option selected', (WidgetTester tester) async {
      String? selectedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              onChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocityDropdown<String>));
      await tester.pump();

      await tester.tap(find.text('选项 1'));
      await tester.pump();

      expect(selectedValue, equals('option1'));
    });

    testWidgets('supports multiple selection', (WidgetTester tester) async {
      var selectedValues = <String?>[];
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              type: VelocityDropdownType.multiple,
              onChanged: (values) {
                selectedValues = values as List<String?>;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocityDropdown<String>));
      await tester.pump();

      await tester.tap(find.text('选项 1'));
      await tester.pump();

      await tester.tap(find.text('选项 2'));
      await tester.pump();

      expect(selectedValues, contains('option1'));
      expect(selectedValues, contains('option2'));
    });

    testWidgets('shows search field when searchable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              searchable: true,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocityDropdown<String>));
      await tester.pump();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('搜索选项...'), findsOneWidget);
    });

    testWidgets('filters options based on search', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              searchable: true,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocityDropdown<String>));
      await tester.pump();

      await tester.enterText(find.byType(TextField), '选项 1');
      await tester.pump();

      expect(find.text('选项 1'), findsAtLeastNWidgets(1));
      expect(find.text('选项 2'), findsNothing);
    });

    testWidgets('displays grouped options', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: const [],
              grouped: true,
              groups: testGroups,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocityDropdown<String>));
      await tester.pump();

      expect(find.text('分组 1'), findsOneWidget);
      expect(find.text('分组 2'), findsOneWidget);
      expect(find.text('分组1选项1'), findsOneWidget);
    });

    testWidgets('shows clear button when clearable and value selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              value: 'option1',
              clearable: true,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('clears selection when clear button tapped', (WidgetTester tester) async {
      String? selectedValue = 'option1';
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              value: selectedValue,
              clearable: true,
              onChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      expect(selectedValue, isNull);
    });

    testWidgets('disables dropdown when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              disabled: true,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocityDropdown<String>));
      await tester.pump();

      // Dropdown should not open
      expect(find.text('选项 1', skipOffstage: false), findsOneWidget);
    });

    testWidgets('shows label when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              label: '选择一个选项',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('选择一个选项'), findsOneWidget);
    });

    testWidgets('shows required indicator when required', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              label: '必填选项',
              required: true,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('必填选项 *'), findsOneWidget);
    });

    testWidgets('validates selection with validator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              label: '必填选项',
              required: true,
              validator: (value) {
                if (value == null) return '请选择一个选项';
                return null;
              },
              onChanged: (value) {},
            ),
          ),
        ),
      );

      // Initially should show error
      expect(find.text('请选择一个选项'), findsOneWidget);

      // Select an option
      await tester.tap(find.byType(VelocityDropdown<String>));
      await tester.pump();

      await tester.tap(find.text('选项 1'));
      await tester.pump();

      // Error should disappear
      expect(find.text('请选择一个选项'), findsNothing);
    });

    testWidgets('shows helper text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              helperText: '请选择一个合适的选项',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('请选择一个合适的选项'), findsOneWidget);
    });

    testWidgets('shows error text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              errorText: '选择无效',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('选择无效'), findsOneWidget);
    });

    testWidgets('respects max selected items limit', (WidgetTester tester) async {
      var selectedValues = <String?>[];
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDropdownTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDropdown<String>(
              options: testOptions,
              type: VelocityDropdownType.multiple,
              maxSelectedItems: 1,
              onChanged: (values) {
                selectedValues = values as List<String?>;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VelocityDropdown<String>));
      await tester.pump();

      await tester.tap(find.text('选项 1'));
      await tester.pump();

      await tester.tap(find.text('选项 2'));
      await tester.pump();

      // Should only have one selected item
      expect(selectedValues.length, equals(1));
      expect(selectedValues.first, equals('option1'));
    });
  });
}