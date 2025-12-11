import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/layout/divider/divider.dart';

void main() {
  group('VelocityDivider Widget Tests', () {
    testWidgets('renders horizontal divider with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: VelocityDivider(),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      expect(
          find.descendant(
            of: find.byType(VelocityDivider),
            matching: find.byType(Container),
          ),
          findsOneWidget);
    });

    testWidgets('renders vertical divider with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: VelocityDivider(vertical: true),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      expect(
          find.descendant(
            of: find.byType(VelocityDivider),
            matching: find.byType(Container),
          ),
          findsOneWidget);
    });

    testWidgets('applies custom style to horizontal divider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: VelocityDivider(
              style: VelocityDividerStyle(
                color: Colors.red,
                thickness: 3.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
    });

    testWidgets('applies custom style to vertical divider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: VelocityDivider(
              vertical: true,
              style: VelocityDividerStyle(
                color: Colors.blue,
                thickness: 5.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
    });

    testWidgets('renders multiple dividers in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: Column(
              children: [
                Text('Content 1'),
                VelocityDivider(),
                Text('Content 2'),
                VelocityDivider(),
                Text('Content 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsNWidgets(2));
      expect(
          find.descendant(
            of: find.byType(VelocityDivider),
            matching: find.byType(Container),
          ),
          findsNWidgets(2));
    });

    testWidgets('renders vertical divider in row layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: Row(
              children: [
                Text('Left'),
                VelocityDivider(vertical: true),
                Text('Right'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      expect(
          find.descendant(
            of: find.byType(VelocityDivider),
            matching: find.byType(Container),
          ),
          findsOneWidget);
    });

    testWidgets('handles divider in different widget contexts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const VelocityDivider(),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text('Item 1'),
                    VelocityDivider(vertical: true),
                    Text('Item 2'),
                  ],
                ),
                const SizedBox(height: 20),
                const Card(
                  child: VelocityDivider(),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsNWidgets(3));
      expect(
          find.descendant(
            of: find.byType(VelocityDivider),
            matching: find.byType(Container),
          ),
          findsNWidgets(3));
    });

    testWidgets('handles accessibility with semantic properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Semantics(
              label: 'Section divider',
              child: const VelocityDivider(),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      expect(find.bySemanticsLabel('Section divider'), findsOneWidget);
    });

    testWidgets('handles divider in scrollable context',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                Container(height: 100, color: Colors.red),
                const VelocityDivider(),
                Container(height: 100, color: Colors.blue),
                const VelocityDivider(),
                Container(height: 100, color: Colors.green),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsNWidgets(2));
      expect(
          find.descendant(
            of: find.byType(VelocityDivider),
            matching: find.byType(Container),
          ),
          findsNWidgets(2));
    });
  });
}
