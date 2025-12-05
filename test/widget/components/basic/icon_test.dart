import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  group('VelocityIcon Tests', () {
    testWidgets('displays icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: VelocityIcon(Icons.home),
        ),
      );

      expect(find.byType(VelocityIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('handles different sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Column(
            children: [
              VelocityIcon(Icons.home, size: 16),
              VelocityIcon(Icons.star, size: 24),
              VelocityIcon(Icons.settings, size: 32),
            ],
          ),
        ),
      );

      expect(find.byType(VelocityIcon), findsNWidgets(3));
    });

    testWidgets('handles different colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Column(
            children: [
              VelocityIcon(Icons.home, color: Colors.red),
              VelocityIcon(Icons.star, color: Colors.blue),
              VelocityIcon(Icons.settings, color: Colors.green),
            ],
          ),
        ),
      );

      expect(find.byType(VelocityIcon), findsNWidgets(3));
    });

    testWidgets('handles onPressed callback', (WidgetTester tester) async {
      var wasPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: VelocityIcon(
            Icons.home,
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      );

      await tester.tap(find.byType(VelocityIcon));
      await tester.pump();

      expect(wasPressed, isTrue);
    });

    testWidgets('handles disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: VelocityIcon(
            Icons.home,
            onPressed: null,
          ),
        ),
      );

      expect(find.byType(VelocityIcon), findsOneWidget);
    });

    testWidgets('handles semantic label', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: VelocityIcon(
            Icons.home,
            semanticLabel: 'Home icon',
          ),
        ),
      );

      expect(find.bySemanticsLabel('Home icon'), findsOneWidget);
    });

    testWidgets('shows tooltip when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: VelocityIcon(
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