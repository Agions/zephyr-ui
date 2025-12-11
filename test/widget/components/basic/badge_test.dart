import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/display/badge/badge.dart';

void main() {
  group('VelocityBadge Widget Tests', () {
    late ThemeData theme;

    setUpAll(() {
      theme = ThemeData.light();
    });

    testWidgets('renders numeric badge with count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              count: 5,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('renders numeric badge with max count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              count: 15,
              max: 9,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('9+'), findsOneWidget);
    });

    testWidgets('renders dot badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              dot: true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
    });

    testWidgets('handles numeric badge with zero count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              count: 0,
              showZero: true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('handles numeric badge with max count exactly at limit',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              count: 9,
              max: 9,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(
          find.text('9'), findsOneWidget); // Should show exact count, not max+
    });

    testWidgets('handles numeric badge with large count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              count: 9999,
              max: 9999,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('9999'), findsOneWidget);
    });

    testWidgets('handles dot badge with custom style',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              dot: true,
              style: VelocityBadgeStyle(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(VelocityBadge);
      expect(badgeFinder, findsOneWidget);
    });

    testWidgets('handles numeric badge with very large count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              count: 999999,
              max: 99,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('handles badge with child widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              count: 3,
              child: Icon(Icons.notifications),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('handles badge with different types',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Column(
            children: const [
              VelocityBadge(
                count: 1,
                type: VelocityBadgeType.primary,
              ),
              VelocityBadge(
                count: 2,
                type: VelocityBadgeType.success,
              ),
              VelocityBadge(
                count: 3,
                type: VelocityBadgeType.warning,
              ),
              VelocityBadge(
                count: 4,
                type: VelocityBadgeType.error,
              ),
              VelocityBadge(
                count: 5,
                type: VelocityBadgeType.info,
              ),
            ],
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsNWidgets(5));
    });

    testWidgets('handles badge with custom offset',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              count: 3,
              offset: Offset(10, -10),
              child: Icon(Icons.notifications),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('handles accessibility with semantic labels',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Semantics(
              label: 'New notifications badge',
              child: const VelocityBadge(
                count: 3,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('handles badge in different widget contexts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: [
                const Row(
                  children: [
                    Text('Label: '),
                    VelocityBadge(
                      count: 5,
                      child: Icon(Icons.star),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const VelocityBadge(
                    count: 2,
                  ),
                ),
                const Stack(
                  children: [
                    Icon(Icons.notifications),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: VelocityBadge(
                        dot: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsNWidgets(3));
      expect(find.text('5'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });
  });
}
