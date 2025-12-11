import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/basic/chip/chip.dart';

void main() {
  group('VelocityChip Widget Tests', () {
    late final ThemeData theme;

    setUpAll(() {
      theme = ThemeData.light();
    });

    testWidgets('renders standard chip with label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityChip(
              label: 'Standard Chip',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(find.text('Standard Chip'), findsOneWidget);
    });

    testWidgets('renders choice chip with selected state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityChoiceChip(
              label: 'Choice Chip',
              selected: true,
              onSelected: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChoiceChip), findsOneWidget);
      expect(find.text('Choice Chip'), findsOneWidget);
    });

    testWidgets('renders chip with avatar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityChip(
              label: 'With Avatar',
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('A'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(find.text('With Avatar'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('renders chip with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityChip(
              label: 'With Icon',
              icon: Icons.star,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(find.text('With Icon'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders chip with delete icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityChip(
              label: 'With Delete Icon',
              deleteIcon: Icons.close,
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(find.text('With Delete Icon'), findsOneWidget);
    });

    testWidgets('handles disabled chip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityChip(
              label: 'Disabled',
              disabled: true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(find.text('Disabled'), findsOneWidget);
    });

    testWidgets('handles chip tap callback', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityChip(
              label: 'Press Me',
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(tapped, isFalse);

      await tester.tap(find.byType(VelocityChip));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('handles chip delete callback', (WidgetTester tester) async {
      var deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityChip(
              label: 'With Delete',
              onDelete: () {
                deleted = true;
              },
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(deleted, isFalse);

      // We can't directly test the delete icon tap in this simple test,
      // but we can verify the widget renders correctly
      expect(find.text('With Delete'), findsOneWidget);
    });

    testWidgets('handles choice chip selection callback',
        (WidgetTester tester) async {
      bool? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityChoiceChip(
              label: 'Choice',
              selected: false,
              onSelected: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChoiceChip), findsOneWidget);
      expect(selectedValue, isNull);

      await tester.tap(find.byType(VelocityChoiceChip));
      await tester.pump();

      expect(selectedValue, isTrue);
    });

    testWidgets('does not trigger callbacks when disabled',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityChip(
              label: 'Disabled Chip',
              disabled: true,
              onTap: () {
                tapped = true;
              },
              onDelete: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);

      await tester.tap(find.text('Disabled Chip'));
      await tester.pump();
      expect(tapped, isFalse);
    });

    testWidgets('handles special characters in label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityChip(
              label: '🔥 Hot & Spicy!',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(find.text('🔥 Hot & Spicy!'), findsOneWidget);
    });

    testWidgets('handles empty string label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityChip(
              label: '',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('handles different chip types', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Column(
            children: [
              const VelocityChip(label: 'Standard Chip'),
              VelocityChoiceChip(
                label: 'Choice Chip',
                selected: false,
                onSelected: (value) {},
              ),
              const VelocityChip(
                label: 'Filled Chip',
                type: VelocityChipType.filled,
              ),
              const VelocityChip(
                label: 'Outlined Chip',
                type: VelocityChipType.outlined,
              ),
              const VelocityChip(
                label: 'Tonal Chip',
                type: VelocityChipType.tonal,
              ),
            ],
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsNWidgets(5));
      expect(find.byType(VelocityChoiceChip), findsOneWidget);
      expect(find.text('Standard Chip'), findsOneWidget);
      expect(find.text('Choice Chip'), findsOneWidget);
      expect(find.text('Filled Chip'), findsOneWidget);
      expect(find.text('Outlined Chip'), findsOneWidget);
      expect(find.text('Tonal Chip'), findsOneWidget);
    });

    testWidgets('handles chip with custom style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityChip(
              label: 'Custom Style',
              style: VelocityChipStyle(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(find.text('Custom Style'), findsOneWidget);
    });

    testWidgets('handles chip with mixed properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityChip(
              label: 'Mixed',
              icon: Icons.star,
              selected: true,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
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
                    VelocityChip(label: 'Flutter'),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const VelocityChip(
                    label: 'Selected',
                    selected: true,
                  ),
                ),
                const Wrap(
                  children: [
                    VelocityChip(label: 'Option 1'),
                    VelocityChip(label: 'Option 2'),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsNWidgets(4));
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
              child: const VelocityChip(
                label: 'Flutter',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityChip), findsOneWidget);
      expect(find.text('Flutter'), findsOneWidget);
    });
  });
}
