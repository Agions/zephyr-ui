import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/basic/chip/chip.dart';
import 'package:zephyr_ui/src/components/basic/chip/chip_theme.dart';
import 'package:zephyr_ui/src/core/theme/theme_data.dart';

void main() {
  group('ZephyrChip Widget Tests', () {
    late final ThemeData theme;

    setUpAll(() {
      final zephyrTheme = ZephyrThemeData.light();
      theme = ThemeData(
        brightness: zephyrTheme.brightness,
        primaryColor: zephyrTheme.primaryColor,
      );
    });

    testWidgets('renders standard chip with label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip(
              label: 'Standard Chip',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Standard Chip'), findsOneWidget);
    });

    testWidgets('renders choice chip with selected state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip.choice(
              label: 'Choice Chip',
              selected: true,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Choice Chip'), findsOneWidget);
    });

    testWidgets('renders filter chip with check icon when selected',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip.filter(
              label: 'Filter Chip',
              selected: true,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Filter Chip'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('renders input chip with delete icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip.input(
              label: 'Input Chip',
              onDeleted: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Input Chip'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('renders action chip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip.action(
              label: 'Action Chip',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Action Chip'), findsOneWidget);
    });

    testWidgets('handles chip with avatar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip(
              label: 'With Avatar',
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('A'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('With Avatar'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('handles chip with custom delete icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip.input(
              label: 'Custom Delete',
              deleteIcon: const Icon(Icons.clear),
              onDeleted: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Custom Delete'), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('handles disabled chip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip(
              label: 'Disabled',
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Disabled'), findsOneWidget);
    });

    testWidgets('handles chip press callback', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip(
              label: 'Press Me',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(pressed, isFalse);

      await tester.tap(find.byType(ZephyrChip));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('handles choice chip selection callback',
        (WidgetTester tester) async {
      bool? selected;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip.choice(
              label: 'Choice',
              onSelected: (value) {
                selected = value;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(selected, isNull);

      await tester.tap(find.byType(ZephyrChip));
      await tester.pump();

      expect(selected, isTrue);
    });

    testWidgets('handles filter chip selection callback',
        (WidgetTester tester) async {
      bool? selected;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip.filter(
              label: 'Filter',
              onSelected: (value) {
                selected = value;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(selected, isNull);

      await tester.tap(find.byType(ZephyrChip));
      await tester.pump();

      expect(selected, isTrue);
    });

    testWidgets('handles input chip delete callback',
        (WidgetTester tester) async {
      bool deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip.input(
              label: 'Input',
              onDeleted: () {
                deleted = true;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(deleted, isFalse);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(deleted, isTrue);
    });

    testWidgets('handles action chip press callback',
        (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip.action(
              label: 'Action',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(pressed, isFalse);

      await tester.tap(find.byType(ZephyrChip));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('does not trigger callbacks when disabled',
        (WidgetTester tester) async {
      bool pressed = false;
      bool? selected;
      bool deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: [
                ZephyrChip(
                  label: 'Disabled Standard',
                  enabled: false,
                  onPressed: () {
                    pressed = true;
                  },
                ),
                ZephyrChip.choice(
                  label: 'Disabled Choice',
                  enabled: false,
                  onSelected: (value) {
                    selected = value;
                  },
                ),
                ZephyrChip.input(
                  label: 'Disabled Input',
                  enabled: false,
                  onDeleted: () {
                    deleted = true;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsNWidgets(3));

      await tester.tap(find.text('Disabled Standard'));
      await tester.pump();
      expect(pressed, isFalse);

      await tester.tap(find.text('Disabled Choice'));
      await tester.pump();
      expect(selected, isNull);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      expect(deleted, isFalse);
    });

    testWidgets('handles long text with ellipsis', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: SizedBox(
              width: 100,
              child: ZephyrChip(
                label:
                    'This is a very long chip label that should be truncated',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(
          find.text('This is a very long chip label that should be truncated'),
          findsOneWidget);
    });

    testWidgets('handles special characters in label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip(
              label: '🔥 Hot & Spicy!',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('🔥 Hot & Spicy!'), findsOneWidget);
    });

    testWidgets('handles empty string label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip(
              label: '',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('handles all chip variants in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: [
                const ZephyrChip(label: 'Standard'),
                const ZephyrChip.choice(label: 'Choice'),
                const ZephyrChip.filter(label: 'Filter'),
                ZephyrChip.input(
                  label: 'Input',
                  onDeleted: () {},
                ),
                const ZephyrChip.action(label: 'Action'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsNWidgets(5));
      expect(find.text('Standard'), findsOneWidget);
      expect(find.text('Choice'), findsOneWidget);
      expect(find.text('Filter'), findsOneWidget);
      expect(find.text('Input'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);
    });

    testWidgets('handles chip with custom theme', (WidgetTester tester) async {
      final customTheme = ZephyrChipTheme(
        backgroundColor: Colors.purple,
        selectedBackgroundColor: Colors.deepPurple,
        disabledBackgroundColor: Colors.grey,
        textColor: Colors.white,
        selectedTextColor: Colors.white,
        disabledTextColor: Colors.grey,
        borderColor: Colors.purple,
        selectedBorderColor: Colors.deepPurple,
        disabledBorderColor: Colors.grey,
        deleteIconColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        borderRadius: BorderRadius.circular(8.0),
        borderWidth: 2.0,
        padding: const EdgeInsets.all(8.0),
        height: 40.0,
        iconSize: 20.0,
        spacing: 8.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip(
              label: 'Custom Theme',
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Custom Theme'), findsOneWidget);
    });

    testWidgets('handles chip with null values in constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip(
              label: 'Null Values',
              avatar: null,
              deleteIcon: null,
              onPressed: null,
              onDeleted: null,
              theme: null,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Null Values'), findsOneWidget);
    });

    testWidgets('handles chip with mixed properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip(
              label: 'Mixed',
              avatar: const Icon(Icons.star),
              selected: true,
              enabled: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Mixed'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('handles chip in different widget contexts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: [
                const Row(
                  children: [
                    Text('Tags: '),
                    ZephyrChip(label: 'Flutter'),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const ZephyrChip.choice(label: 'Selected'),
                ),
                const Wrap(
                  children: [
                    ZephyrChip.filter(label: 'Option 1'),
                    ZephyrChip.filter(label: 'Option 2'),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsNWidgets(4));
      expect(find.text('Flutter'), findsOneWidget);
      expect(find.text('Selected'), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('handles accessibility with semantic labels',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Semantics(
              label: 'Technology tag',
              child: const ZephyrChip(
                label: 'Flutter',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Flutter'), findsOneWidget);
    });

    testWidgets('handles chip with zero spacing', (WidgetTester tester) async {
      final customTheme = ZephyrChipTheme(
        backgroundColor: Colors.blue,
        selectedBackgroundColor: Colors.blue,
        disabledBackgroundColor: Colors.grey,
        textColor: Colors.white,
        selectedTextColor: Colors.white,
        disabledTextColor: Colors.grey,
        borderColor: Colors.blue,
        selectedBorderColor: Colors.blue,
        disabledBorderColor: Colors.grey,
        deleteIconColor: Colors.white,
        textStyle: const TextStyle(fontSize: 14),
        borderRadius: BorderRadius.circular(16.0),
        borderWidth: 1.0,
        padding: EdgeInsets.zero,
        height: 32.0,
        iconSize: 16.0,
        spacing: 0.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChip(
              label: 'No Spacing',
              avatar: const Icon(Icons.star),
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('No Spacing'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('handles chip with rectangular border radius',
        (WidgetTester tester) async {
      const customTheme = ZephyrChipTheme(
        backgroundColor: Colors.green,
        selectedBackgroundColor: Colors.green,
        disabledBackgroundColor: Colors.grey,
        textColor: Colors.white,
        selectedTextColor: Colors.white,
        disabledTextColor: Colors.grey,
        borderColor: Colors.green,
        selectedBorderColor: Colors.green,
        disabledBorderColor: Colors.grey,
        deleteIconColor: Colors.white,
        textStyle: TextStyle(fontSize: 14),
        borderRadius: BorderRadius.zero,
        borderWidth: 1.0,
        padding: EdgeInsets.all(8.0),
        height: 32.0,
        iconSize: 16.0,
        spacing: 4.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChip(
              label: 'Square',
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Square'), findsOneWidget);
    });
  });

  group('ZephyrChipGroup Widget Tests', () {
    late final ThemeData theme;

    setUpAll(() {
      final zephyrTheme = ZephyrThemeData.light();
      theme = ThemeData(
        brightness: zephyrTheme.brightness,
        primaryColor: zephyrTheme.primaryColor,
      );
    });

    testWidgets('renders chip group with multiple chips',
        (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(label: 'Option 1'),
        const ZephyrChipData(label: 'Option 2'),
        const ZephyrChipData(label: 'Option 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(find.byType(ZephyrChip), findsNWidgets(3));
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('handles chip group with pre-selected chips',
        (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(label: 'Option 1'),
        const ZephyrChipData(label: 'Option 2'),
        const ZephyrChipData(label: 'Option 3'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
              selectedChips: const [0, 2],
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(find.byType(ZephyrChip), findsNWidgets(3));
    });

    testWidgets('handles chip group selection callback',
        (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(label: 'Option 1'),
        const ZephyrChipData(label: 'Option 2'),
        const ZephyrChipData(label: 'Option 3'),
      ];

      List<int>? selectedChips;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
              onSelectionChanged: (selection) {
                selectedChips = selection;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(selectedChips, isNull);

      await tester.tap(find.text('Option 1'));
      await tester.pump();

      expect(selectedChips, isNotNull);
      expect(selectedChips!.length, 1);
      expect(selectedChips!.first, 0);
    });

    testWidgets('handles chip group with multi-select',
        (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(label: 'Option 1'),
        const ZephyrChipData(label: 'Option 2'),
        const ZephyrChipData(label: 'Option 3'),
      ];

      List<int>? selectedChips;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
              multiSelect: true,
              onSelectionChanged: (selection) {
                selectedChips = selection;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(selectedChips, isNull);

      await tester.tap(find.text('Option 1'));
      await tester.pump();

      expect(selectedChips, isNotNull);
      expect(selectedChips!.length, 1);
      expect(selectedChips!.first, 0);

      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedChips!.length, 2);
      expect(selectedChips!.contains(0), isTrue);
      expect(selectedChips!.contains(1), isTrue);
    });

    testWidgets('handles chip group with single select',
        (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(label: 'Option 1'),
        const ZephyrChipData(label: 'Option 2'),
        const ZephyrChipData(label: 'Option 3'),
      ];

      List<int>? selectedChips;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
              multiSelect: false,
              onSelectionChanged: (selection) {
                selectedChips = selection;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(selectedChips, isNull);

      await tester.tap(find.text('Option 1'));
      await tester.pump();

      expect(selectedChips, isNotNull);
      expect(selectedChips!.length, 1);
      expect(selectedChips!.first, 0);

      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedChips!.length, 1);
      expect(selectedChips!.first, 1);
    });

    testWidgets('handles chip group with disabled chips',
        (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(label: 'Enabled'),
        const ZephyrChipData(label: 'Disabled', enabled: false),
        const ZephyrChipData(label: 'Enabled'),
      ];

      List<int>? selectedChips;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
              onSelectionChanged: (selection) {
                selectedChips = selection;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(selectedChips, isNull);

      await tester.tap(find.text('Disabled').first);
      await tester.pump();

      expect(selectedChips, isNull);

      await tester.tap(find.text('Enabled').first);
      await tester.pump();

      expect(selectedChips, isNotNull);
      expect(selectedChips!.length, 1);
      expect(selectedChips!.first, 0);
    });

    testWidgets('handles chip group with avatars', (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(
          label: 'With Avatar',
          avatar: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('A'),
          ),
        ),
        const ZephyrChipData(label: 'Without Avatar'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(find.byType(ZephyrChip), findsNWidgets(2));
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('handles chip group with custom spacing',
        (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(label: 'Chip 1'),
        const ZephyrChipData(label: 'Chip 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
              spacing: 16.0,
              runSpacing: 12.0,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(find.byType(ZephyrChip), findsNWidgets(2));
    });

    testWidgets('handles chip group with custom theme',
        (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(label: 'Custom'),
      ];

      final customTheme = ZephyrChipTheme(
        backgroundColor: Colors.purple,
        selectedBackgroundColor: Colors.deepPurple,
        disabledBackgroundColor: Colors.grey,
        textColor: Colors.white,
        selectedTextColor: Colors.white,
        disabledTextColor: Colors.grey,
        borderColor: Colors.purple,
        selectedBorderColor: Colors.deepPurple,
        disabledBorderColor: Colors.grey,
        deleteIconColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
        borderRadius: BorderRadius.circular(8.0),
        borderWidth: 2.0,
        padding: const EdgeInsets.all(8.0),
        height: 40.0,
        iconSize: 20.0,
        spacing: 8.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Custom'), findsOneWidget);
    });

    testWidgets('handles chip group with empty chips list',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrChipGroup(
              chips: [],
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(find.byType(ZephyrChip), findsNothing);
    });

    testWidgets('handles chip group with null values',
        (WidgetTester tester) async {
      final chips = [
        const ZephyrChipData(label: 'Test'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrChipGroup(
              chips: chips,
              selectedChips: const [],
              multiSelect: false,
              onSelectionChanged: null,
              theme: null,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrChipGroup), findsOneWidget);
      expect(find.byType(ZephyrChip), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });
  });
}
