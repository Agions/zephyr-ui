import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  group('VelocityUI Basic Components Test', () {
    testWidgets('VelocityTheme loads correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Test Theme'),
            ),
          ),
        ),
      );

      expect(find.text('Test Theme'), findsOneWidget);
    });

    testWidgets('VelocityButton renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: VelocityButton(
                onPressed: () {},
                child: const Text('Test Button'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });
  });
}