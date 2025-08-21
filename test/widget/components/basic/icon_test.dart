import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrIcon Tests', () {
    testWidgets('displays icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrIcon(Icons.home),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('handles different sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: const [
              ZephyrIcon(Icons.home, size: 16),
              ZephyrIcon(Icons.star, size: 24),
              ZephyrIcon(Icons.settings, size: 32),
            ],
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsNWidgets(3));
    });

    testWidgets('handles different colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: const [
              ZephyrIcon(Icons.home, color: Colors.red),
              ZephyrIcon(Icons.star, color: Colors.blue),
              ZephyrIcon(Icons.settings, color: Colors.green),
            ],
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsNWidgets(3));
    });

    testWidgets('handles onPressed callback', (WidgetTester tester) async {
      bool wasPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrIcon(
            Icons.home,
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      );

      await tester.tap(find.byType(ZephyrIcon));
      await tester.pump();

      expect(wasPressed, isTrue);
    });

    testWidgets('handles disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrIcon(
            Icons.home,
            onPressed: null,
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
    });

    testWidgets('handles semantic label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrIcon(
            Icons.home,
            semanticLabel: 'Home icon',
          ),
        ),
      );

      expect(find.bySemanticsLabel('Home icon'), findsOneWidget);
    });

    testWidgets('shows tooltip when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrIcon(
            Icons.home,
            tooltip: 'Go to home',
          ),
        ),
      );

      // Tooltip should be present but not visible until hovered
      expect(find.byTooltip('Go to home'), findsOneWidget);
    });
  });
}