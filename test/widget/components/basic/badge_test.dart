import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/basic/badge/badge.dart';
import 'package:velocity_ui/src/core/theme/theme_data.dart';

void main() {
  group('VelocityBadge Widget Tests', () {
    late ThemeData theme;

    setUpAll(() {
      final velocityTheme = VelocityThemeData.light();
      theme = ThemeData(
        brightness: velocityTheme.brightness,
        primaryColor: velocityTheme.primaryColor,
      );
    });

    testWidgets('renders standard badge with text content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'New',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('New'), findsOneWidget);
    });

    testWidgets('renders numeric badge with count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.count(
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
            body: VelocityBadge.count(
              count: 15,
              maxCount: 9,
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
            body: VelocityBadge.dot(),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('handles custom backgroundColor', (WidgetTester tester) async {
      const customBackgroundColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'Custom',
              backgroundColor: customBackgroundColor,
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(VelocityBadge);
      expect(badgeFinder, findsOneWidget);

      final badge = tester.widget<VelocityBadge>(badgeFinder);
      expect(badge.backgroundColor, equals(customBackgroundColor));
    });

    testWidgets('handles custom textColor', (WidgetTester tester) async {
      const customTextColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'Custom',
              textColor: customTextColor,
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(VelocityBadge);
      expect(badgeFinder, findsOneWidget);

      final badge = tester.widget<VelocityBadge>(badgeFinder);
      expect(badge.textColor, equals(customTextColor));
    });

    testWidgets('handles custom borderRadius', (WidgetTester tester) async {
      const customBorderRadius = BorderRadius.all(Radius.circular(8.0));

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'Custom',
              borderRadius: customBorderRadius,
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(VelocityBadge);
      expect(badgeFinder, findsOneWidget);

      final badge = tester.widget<VelocityBadge>(badgeFinder);
      expect(badge.borderRadius, equals(customBorderRadius));
    });

    testWidgets('handles custom padding', (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(12.0);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'Custom',
              padding: customPadding,
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(VelocityBadge);
      expect(badgeFinder, findsOneWidget);

      final badge = tester.widget<VelocityBadge>(badgeFinder);
      expect(badge.padding, equals(customPadding));
    });

    testWidgets('handles custom border', (WidgetTester tester) async {
      const customBorderWidth = 2.0;
      const customBorderColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'Custom',
              borderWidth: customBorderWidth,
              borderColor: customBorderColor,
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(VelocityBadge);
      expect(badgeFinder, findsOneWidget);

      final badge = tester.widget<VelocityBadge>(badgeFinder);
      expect(badge.borderWidth, equals(customBorderWidth));
      expect(badge.borderColor, equals(customBorderColor));
    });

    testWidgets('handles numeric badge with zero count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.count(
              count: 0,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('handles numeric badge with negative count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.count(
              count: -5,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('-5'), findsOneWidget);
    });

    testWidgets('handles numeric badge with max count exactly at limit',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.count(
              count: 9,
              maxCount: 9,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(
          find.text('9'), findsOneWidget); // Should show exact count, not max+
    });

    testWidgets('handles numeric badge with max count null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.count(
              count: 9999,
              maxCount: null,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('9999'), findsOneWidget);
    });

    testWidgets('handles dot badge with custom backgroundColor',
        (WidgetTester tester) async {
      const customBackgroundColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.dot(
              backgroundColor: customBackgroundColor,
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(VelocityBadge);
      expect(badgeFinder, findsOneWidget);

      final badge = tester.widget<VelocityBadge>(badgeFinder);
      expect(badge.backgroundColor, equals(customBackgroundColor));
    });

    testWidgets('handles dot badge with custom border',
        (WidgetTester tester) async {
      const customBorderWidth = 1.0;
      const customBorderColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.dot(
              borderWidth: customBorderWidth,
              borderColor: customBorderColor,
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(VelocityBadge);
      expect(badgeFinder, findsOneWidget);

      final badge = tester.widget<VelocityBadge>(badgeFinder);
      expect(badge.borderWidth, equals(customBorderWidth));
      expect(badge.borderColor, equals(customBorderColor));
    });

    testWidgets('handles empty string content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: '',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('handles long text content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'Very Long Badge Text',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('Very Long Badge Text'), findsOneWidget);
    });

    testWidgets('handles special characters in content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: '🔥 Hot!',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('🔥 Hot!'), findsOneWidget);
    });

    testWidgets('handles numeric badge with very large count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.count(
              count: 999999,
              maxCount: 99,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('handles theme inheritance', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'Themed',
              backgroundColor: Colors.orange,
              textColor: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              borderWidth: 1.0,
              borderColor: Colors.brown,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('Themed'), findsOneWidget);
    });

    testWidgets('handles all badge types in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Column(
              children: [
                VelocityBadge(content: 'Text'),
                VelocityBadge.count(count: 5),
                VelocityBadge.dot(),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsNWidgets(3));
      expect(find.text('Text'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('handles badge with zero border width',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'No Border',
              borderWidth: 0.0,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('No Border'), findsOneWidget);
    });

    testWidgets('handles badge with zero padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'No Padding',
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('No Padding'), findsOneWidget);
    });

    testWidgets('handles badge with rectangular border radius',
        (WidgetTester tester) async {
      const rectangularBorderRadius = BorderRadius.all(Radius.circular(0.0));

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'Square',
              borderRadius: rectangularBorderRadius,
            ),
          ),
        ),
      );

      final badgeFinder = find.byType(VelocityBadge);
      expect(badgeFinder, findsOneWidget);

      final badge = tester.widget<VelocityBadge>(badgeFinder);
      expect(badge.borderRadius, equals(rectangularBorderRadius));
    });

    testWidgets('handles badge with mixed custom properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge(
              content: 'Mixed',
              backgroundColor: Colors.purple,
              textColor: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              borderWidth: 2.0,
              borderColor: Colors.orange,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('Mixed'), findsOneWidget);
    });

    testWidgets('handles numeric badge with mixed custom properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.count(
              count: 42,
              maxCount: 50,
              backgroundColor: Colors.teal,
              textColor: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              borderWidth: 1.5,
              borderColor: Colors.cyan,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('handles dot badge with mixed custom properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.dot(
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderWidth: 1.0,
              borderColor: Colors.pink,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('handles edge case with null values in constructor',
        (WidgetTester tester) async {
      // This should work with the factory constructor
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityBadge.count(
              count: 1,
              maxCount: null,
              backgroundColor: null,
              textColor: null,
              borderRadius: null,
              padding: null,
              borderWidth: null,
              borderColor: null,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('handles accessibility with semantic labels',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Semantics(
              label: 'New notifications badge',
              child: const VelocityBadge.count(
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
                    VelocityBadge(content: 'Hot'),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const VelocityBadge.count(count: 2),
                ),
                const Stack(
                  children: [
                    Icon(Icons.notifications),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: VelocityBadge.dot(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBadge), findsNWidgets(3));
      expect(find.text('Hot'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);

      // Find the specific SizedBox from the dot badge (4x4 size)
      final sizedBoxFinder = find.byWidgetPredicate((widget) =>
          widget is SizedBox && widget.width == 4.0 && widget.height == 4.0);
      expect(sizedBoxFinder, findsOneWidget);
    });
  });
}
