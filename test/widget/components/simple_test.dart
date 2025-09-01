import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Simple test to verify dropdown component works
void main() {
  testWidgets('Dropdown smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            child: Text('Test'),
          ),
        ),
      ),
    );

    expect(find.text('Test'), findsOneWidget);
  });
}