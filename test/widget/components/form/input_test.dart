import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/form/input/input.dart';

void main() {
  group('ZephyrInput Widget Tests', () {
    testWidgets('renders input with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Username',
              placeholder: 'Enter your username',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders input with controller', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial value');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              controller: controller,
              label: 'Test',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      controller.dispose();
    });

    testWidgets('renders input with initial value',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              initialValue: 'Hello World',
              label: 'Test',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders password input with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput.password(
              label: 'Password',
              placeholder: 'Enter your password',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('renders email input with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput.email(
              label: 'Email',
              placeholder: 'Enter your email',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders textarea with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput.textarea(
              label: 'Description',
              placeholder: 'Enter your description',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles input with prefix icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('handles input with suffix icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('handles input with prefix widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Amount',
              prefix: Text('\$'),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.text('\$'), findsOneWidget);
    });

    testWidgets('handles input with suffix widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Price',
              suffix: Text('USD'),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.text('USD'), findsOneWidget);
    });

    testWidgets('handles disabled input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Disabled',
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles read-only input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Read-only',
              readOnly: true,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles input with max length', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Limited',
              maxLength: 10,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles password visibility toggle',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput.password(
              label: 'Password',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsOneWidget);

      // Tap the visibility toggle
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('handles input callbacks', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Callbacks',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      // Test tap callback
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('handles input with null values in constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: 'Null Values',
              controller: null,
              initialValue: null,
              placeholder: null,
              helperText: null,
              errorText: null,
              prefixIcon: null,
              suffixIcon: null,
              prefix: null,
              suffix: null,
              onChanged: null,
              onSubmitted: null,
              onTap: null,
              onFocusChange: null,
              validator: null,
              inputFormatters: null,
              keyboardType: null,
              textInputAction: null,
              focusNode: null,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
    });

    testWidgets('handles multiple inputs in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ZephyrInput(
                  label: 'First Name',
                  placeholder: 'Enter first name',
                ),
                SizedBox(height: 16),
                ZephyrInput(
                  label: 'Last Name',
                  placeholder: 'Enter last name',
                ),
                SizedBox(height: 16),
                ZephyrInput.email(
                  label: 'Email',
                  placeholder: 'Enter email',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsNWidgets(3));
    });

    testWidgets('handles input with empty strings',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              label: '',
              placeholder: '',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
