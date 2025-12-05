import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/basic/divider/divider.dart';
import 'package:velocity_ui/src/components/basic/divider/divider_theme.dart';
import 'package:velocity_ui/src/core/theme/theme_data.dart';

void main() {
  group('VelocityDivider Widget Tests', () {
    late final ThemeData theme;

    setUpAll(() {
      final velocityTheme = VelocityThemeData.light();
      theme = ThemeData(
        brightness: velocityTheme.brightness,
        primaryColor: velocityTheme.primaryColor,
      );
    });

    testWidgets('renders horizontal divider with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(),
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
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.vertical(),
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

    testWidgets('applies custom color to horizontal divider',
        (WidgetTester tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              color: customColor,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, customColor);
    });

    testWidgets('applies custom color to vertical divider',
        (WidgetTester tester) async {
      const customColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.vertical(
              color: customColor,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, customColor);
    });

    testWidgets('applies custom thickness to horizontal divider',
        (WidgetTester tester) async {
      const customThickness = 3.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              thickness: customThickness,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      expect(container.constraints?.minHeight, customThickness);
    });

    testWidgets('applies custom thickness to vertical divider',
        (WidgetTester tester) async {
      const customThickness = 5.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.vertical(
              thickness: customThickness,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      expect(container.constraints?.minWidth, customThickness);
    });

    testWidgets('applies custom indent to horizontal divider',
        (WidgetTester tester) async {
      const customIndent = 20.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              indent: customIndent,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final margin = container.margin as EdgeInsetsDirectional;
      expect(margin.start, customIndent);
    });

    testWidgets('applies custom endIndent to horizontal divider',
        (WidgetTester tester) async {
      const customEndIndent = 30.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              endIndent: customEndIndent,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final margin = container.margin as EdgeInsetsDirectional;
      expect(margin.end, customEndIndent);
    });

    testWidgets('applies custom indent to vertical divider',
        (WidgetTester tester) async {
      const customIndent = 15.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.vertical(
              indent: customIndent,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final margin = container.margin as EdgeInsetsDirectional;
      expect(margin.top, customIndent);
    });

    testWidgets('applies custom endIndent to vertical divider',
        (WidgetTester tester) async {
      const customEndIndent = 25.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.vertical(
              endIndent: customEndIndent,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final margin = container.margin as EdgeInsetsDirectional;
      expect(margin.bottom, customEndIndent);
    });

    testWidgets('applies custom height to horizontal divider',
        (WidgetTester tester) async {
      const customHeight = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              height: customHeight,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, customHeight);
    });

    testWidgets('applies custom width to vertical divider',
        (WidgetTester tester) async {
      const customWidth = 40.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.vertical(
              width: customWidth,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.width, customWidth);
    });

    testWidgets('applies custom theme to horizontal divider',
        (WidgetTester tester) async {
      const customTheme = VelocityDividerTheme(
        color: Colors.purple,
        thickness: 2.0,
        indent: 10.0,
        endIndent: 10.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, customTheme.color);
      expect(container.constraints?.minHeight, customTheme.thickness);
    });

    testWidgets('applies custom theme to vertical divider',
        (WidgetTester tester) async {
      const customTheme = VelocityDividerTheme(
        color: Colors.green,
        thickness: 4.0,
        indent: 5.0,
        endIndent: 5.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.vertical(
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, customTheme.color);
      expect(container.constraints?.minWidth, customTheme.thickness);
    });

    testWidgets('handles zero thickness for horizontal divider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              thickness: 0.0,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      expect(container.constraints?.minHeight, 0.0);
    });

    testWidgets('handles zero thickness for vertical divider',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.vertical(
              thickness: 0.0,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      expect(container.constraints?.minWidth, 0.0);
    });

    testWidgets('handles zero indent and endIndent',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              indent: 0.0,
              endIndent: 0.0,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final margin = container.margin as EdgeInsetsDirectional;
      expect(margin.start, 0.0);
      expect(margin.end, 0.0);
    });

    testWidgets('handles large thickness values', (WidgetTester tester) async {
      const largeThickness = 10.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              thickness: largeThickness,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      expect(container.constraints?.minHeight, largeThickness);
    });

    testWidgets('handles edge case values', (WidgetTester tester) async {
      // Test with very small thickness value (but still valid)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              thickness: 0.1,
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

    testWidgets('handles null values in constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              color: null,
              thickness: null,
              indent: null,
              endIndent: null,
              height: null,
              theme: null,
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

    testWidgets('renders multiple dividers in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Column(
              children: [
                Text('Content 1'),
                VelocityDivider.horizontal(),
                Text('Content 2'),
                VelocityDivider.horizontal(),
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
          theme: theme,
          home: const Scaffold(
            body: Row(
              children: [
                Text('Left'),
                VelocityDivider.vertical(),
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

    testWidgets('handles divider with mixed properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              color: Colors.orange,
              thickness: 3.0,
              indent: 20.0,
              endIndent: 30.0,
              height: 40.0,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 40.0);

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.orange);
      expect(container.constraints?.minHeight, 3.0);
      final margin = container.margin as EdgeInsetsDirectional;
      expect(margin.start, 20.0);
      expect(margin.end, 30.0);
    });

    testWidgets('handles divider in different widget contexts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const VelocityDivider.horizontal(),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text('Item 1'),
                    VelocityDivider.vertical(),
                    Text('Item 2'),
                  ],
                ),
                const SizedBox(height: 20),
                const Card(
                  child: VelocityDivider.horizontal(),
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
          theme: theme,
          home: Scaffold(
            body: Semantics(
              label: 'Section divider',
              child: const VelocityDivider.horizontal(),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      expect(find.bySemanticsLabel('Section divider'), findsOneWidget);
    });

    testWidgets('handles divider with transparent color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              color: Colors.transparent,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.transparent);
    });

    testWidgets('handles divider with theme override',
        (WidgetTester tester) async {
      const customTheme = VelocityDividerTheme(
        color: Colors.cyan,
        thickness: 2.0,
        indent: 5.0,
        endIndent: 5.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              theme: customTheme,
              color: Colors.red, // This should override the theme color
              thickness: 4.0, // This should override the theme thickness
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.red); // Override should take precedence
      expect(container.constraints?.minHeight,
          4.0); // Override should take precedence
    });

    testWidgets('handles divider with spacing values',
        (WidgetTester tester) async {
      const customTheme = VelocityDividerTheme(
        color: Colors.brown,
        thickness: 1.0,
        verticalSpacing: 20.0,
        horizontalSpacing: 30.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      // The divider should use spacing values for overall size calculation
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, greaterThan(0));
    });

    testWidgets('handles divider in scrollable context',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ListView(
              children: [
                Container(height: 100, color: Colors.red),
                const VelocityDivider.horizontal(),
                Container(height: 100, color: Colors.blue),
                const VelocityDivider.horizontal(),
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

    testWidgets('handles divider with complex margin combinations',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityDivider.horizontal(
              indent: 25.0,
              endIndent: 35.0,
              thickness: 2.5,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDivider), findsOneWidget);
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VelocityDivider),
        matching: find.byType(Container),
      ));
      final margin = container.margin as EdgeInsetsDirectional;
      expect(margin.start, 25.0);
      expect(margin.end, 35.0);
      expect(container.constraints?.minHeight, 2.5);
    });
  });
}
