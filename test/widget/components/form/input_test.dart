import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/form/input/input.dart';

void main() {
  group('VelocityInput Widget Tests', () {
    testWidgets('renders input with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Username',
              hint: 'Enter your username',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders input with controller', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial value');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              controller: controller,
              label: 'Test',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      controller.dispose();
    });

    testWidgets('renders password input',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Password',
              hint: 'Enter your password',
              obscureText: true,
              suffixIcon: Icons.visibility,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders email input',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Email',
              hint: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders textarea',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityTextArea(
              label: 'Description',
              hint: 'Enter your description',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles input with prefix icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Email',
              prefixIcon: Icons.email,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
    });

    testWidgets('handles input with suffix icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Search',
              suffixIcon: Icons.search,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
    });

    testWidgets('handles input with prefix widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Amount',
              prefix: Text(r'$'),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.text(r'$'), findsOneWidget);
    });

    testWidgets('handles input with suffix widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Price',
              suffix: Text('USD'),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.text('USD'), findsOneWidget);
    });

    testWidgets('handles disabled input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Disabled',
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles read-only input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Read-only',
              readOnly: true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles input with max length', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Limited',
              maxLength: 10,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('handles input callbacks', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: 'Callbacks',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
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
            body: VelocityInput(
              label: 'Null Values',
              controller: null,
              focusNode: null,
              hint: null,
              helper: null,
              error: null,
              prefixIcon: null,
              suffixIcon: null,
              prefix: null,
              suffix: null,
              onChanged: null,
              onSubmitted: null,
              onTap: null,
              validator: null,
              inputFormatters: null,
              keyboardType: null,
              textInputAction: null,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
    });

    testWidgets('handles multiple inputs in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocityInput(
                  label: 'First Name',
                  hint: 'Enter first name',
                ),
                SizedBox(height: 16),
                VelocityInput(
                  label: 'Last Name',
                  hint: 'Enter last name',
                ),
                SizedBox(height: 16),
                VelocityInput(
                  label: 'Email',
                  hint: 'Enter email',
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsNWidgets(3));
    });

    testWidgets('handles input with empty strings',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityInput(
              label: '',
              hint: '',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('renders textarea component',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityTextArea(
              label: 'Description',
              hint: 'Enter detailed description',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityInput), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
