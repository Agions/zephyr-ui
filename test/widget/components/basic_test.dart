import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrUI Basic Components Test', () {
    testWidgets('ZephyrTheme loads correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrThemeData.light(),
            ],
          ),
          home: const Scaffold(
            body: Center(
              child: Text('Test Theme'),
            ),
          ),
        ),
      );

      expect(find.text('Test Theme'), findsOneWidget);
    });

    testWidgets('ZephyrButton renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrThemeData.light(),
            ],
          ),
          home: const Scaffold(
            body: Center(
              child: ZephyrButton(
                onPressed: () {},
                child: Text('Test Button'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });
  });
}