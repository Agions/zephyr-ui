import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/accessibility/accessibility_wrapper.dart';
import 'package:zephyr_ui/src/core/accessibility/accessibility_types.dart';

void main() {
  group('ZephyrAccessibilityWrapper', () {
    testWidgets('should create wrapper with default config', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            child: Container(key: Key('test-child')),
          ),
        ),
      );

      expect(find.byKey(Key('test-child')), findsOneWidget);
    });

    testWidgets('should apply text scaling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableTextScaling: true,
              textScaleFactor: 2.0,
            ),
            child: Text('Test Text', key: Key('test-text')),
          ),
        ),
      );

      final textFinder = find.byKey(Key('test-text'));
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      final mediaQuery = MediaQuery.of(tester.element(textFinder));
      expect(mediaQuery.textScaleFactor, equals(2.0));
    });

    testWidgets('should apply touch target size for interactive components', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableTouchTargetSize: true,
              minTouchTargetSize: 60.0,
            ),
            isInteractive: true,
            child: Container(key: Key('interactive-child')),
          ),
        ),
      );

      final containerFinder = find.byKey(Key('interactive-child'));
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      final constraints = (container.child! as ConstrainedBox).constraints;
      expect(constraints.minWidth, equals(60.0));
      expect(constraints.minHeight, equals(60.0));
    });

    testWidgets('should not apply touch target size for non-interactive components', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableTouchTargetSize: true,
              minTouchTargetSize: 60.0,
            ),
            isInteractive: false,
            child: Container(key: Key('non-interactive-child')),
          ),
        ),
      );

      final containerFinder = find.byKey(Key('non-interactive-child'));
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      expect(container.child, isNot(isA<ConstrainedBox>()));
    });

    testWidgets('should apply focus indicator for interactive components', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableFocusIndicator: true,
              focusColor: Colors.red,
              focusBorderWidth: 3.0,
            ),
            isInteractive: true,
            child: Container(key: Key('focus-child')),
          ),
        ),
      );

      final containerFinder = find.byKey(Key('focus-child'));
      expect(containerFinder, findsOneWidget);

      // Should be wrapped in Focus widget
      final focusFinder = find.byType(Focus);
      expect(focusFinder, findsOneWidget);
    });

    testWidgets('should apply keyboard navigation for interactive components', (WidgetTester tester) async {
      var enterPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableKeyboardNavigation: true,
            ),
            isInteractive: true,
            keyboardCallbacks: {
              'onEnter': () {
                enterPressed = true;
              },
            },
            child: Container(key: Key('keyboard-child')),
          ),
        ),
      );

      final containerFinder = find.byKey(Key('keyboard-child'));
      expect(containerFinder, findsOneWidget);

      // Should be wrapped in Focus widget
      final focusFinder = find.byType(Focus);
      expect(focusFinder, findsOneWidget);

      // Test keyboard navigation
      final focusNode = tester.widget<Focus>(focusFinder).focusNode;
      focusNode.requestFocus();
      
      // Simulate Enter key press
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      expect(enterPressed, isTrue);
    });

    testWidgets('should apply semantics for button component', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableSemantics: true,
            ),
            componentType: 'button',
            isInteractive: true,
            child: Container(key: Key('button-child')),
          ),
        ),
      );

      final semanticsFinder = find.byType(Semantics);
      expect(semanticsFinder, findsOneWidget);

      final semantics = tester.widget<Semantics>(semanticsFinder);
      expect(semantics.button, isTrue);
    });

    testWidgets('should apply semantics for header component', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableSemantics: true,
            ),
            componentType: 'header',
            isInteractive: false,
            child: Container(key: Key('header-child')),
          ),
        ),
      );

      final semanticsFinder = find.byType(Semantics);
      expect(semanticsFinder, findsOneWidget);

      final semantics = tester.widget<Semantics>(semanticsFinder);
      expect(semantics.header, isTrue);
    });

    testWidgets('should apply semantics for image component', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableSemantics: true,
            ),
            componentType: 'image',
            isInteractive: false,
            child: Container(key: Key('image-child')),
          ),
        ),
      );

      final semanticsFinder = find.byType(Semantics);
      expect(semanticsFinder, findsOneWidget);

      final semantics = tester.widget<Semantics>(semanticsFinder);
      expect(semantics.image, isTrue);
    });

    testWidgets('should apply semantics for text field component', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableSemantics: true,
            ),
            componentType: 'textfield',
            isForm: true,
            isInteractive: true,
            child: Container(key: Key('textfield-child')),
          ),
        ),
      );

      final semanticsFinder = find.byType(Semantics);
      expect(semanticsFinder, findsOneWidget);

      final semantics = tester.widget<Semantics>(semanticsFinder);
      expect(semantics.textField, isTrue);
    });

    testWidgets('should apply custom semantic data', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibilityWrapper(
            config: ZephyrAccessibilityWrapperConfig(
              enableSemantics: true,
              semanticData: ZephyrSemanticData(
                label: 'Custom Label',
                hint: 'Custom Hint',
                value: 'Custom Value',
                checked: true,
                selected: false,
                disabled: false,
              ),
            ),
            child: Container(key: Key('custom-semantics-child')),
          ),
        ),
      );

      final semanticsFinder = find.byType(Semantics);
      expect(semanticsFinder, findsOneWidget);

      final semantics = tester.widget<Semantics>(semanticsFinder);
      expect(semantics.label, equals('Custom Label'));
      expect(semantics.hint, equals('Custom Hint'));
      expect(semantics.value, equals('Custom Value'));
      expect(semantics.checked, isTrue);
      expect(semantics.selected, isFalse);
      expect(semantics.enabled, isTrue);
    });
  });

  group('ZephyrAccessibleButton', () {
    testWidgets('should create accessible button with text', (WidgetTester tester) async {
      var buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleButton(
            text: 'Test Button',
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);

      // Test button press
      await tester.tap(find.text('Test Button'));
      await tester.pump();

      expect(buttonPressed, isTrue);
    });

    testWidgets('should create accessible button with icon', (WidgetTester tester) async {
      var buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleButton(
            text: 'Icon Button',
            icon: Icons.star,
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      );

      expect(find.text('Icon Button'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);

      // Test button press
      await tester.tap(find.byIcon(Icons.star));
      await tester.pump();

      expect(buttonPressed, isTrue);
    });

    testWidgets('should handle disabled button', (WidgetTester tester) async {
      var buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleButton(
            text: 'Disabled Button',
            onPressed: () {
              buttonPressed = true;
            },
            isDisabled: true,
          ),
        ),
      );

      expect(find.text('Disabled Button'), findsOneWidget);

      // Test button press - should not trigger
      await tester.tap(find.text('Disabled Button'));
      await tester.pump();

      expect(buttonPressed, isFalse);
    });

    testWidgets('should handle loading button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleButton(
            text: 'Loading Button',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      );

      expect(find.text('加载中...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle full width button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAccessibleButton(
              text: 'Full Width Button',
              onPressed: () {},
              isFullWidth: true,
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsOneWidget);

      final button = tester.widget<ElevatedButton>(buttonFinder);
      expect(button.style?.minimumSize?.width, equals(double.infinity));
    });

    testWidgets('should apply custom semantic label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleButton(
            text: 'Button Text',
            onPressed: () {},
            semanticLabel: 'Custom Semantic Label',
          ),
        ),
      );

      final semanticsFinder = find.byType(Semantics);
      expect(semanticsFinder, findsOneWidget);

      final semantics = tester.widget<Semantics>(semanticsFinder);
      expect(semantics.label, equals('Custom Semantic Label'));
    });

    testWidgets('should support keyboard navigation', (WidgetTester tester) async {
      var buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleButton(
            text: 'Keyboard Button',
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      );

      // Focus the button
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      // Press Enter
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      expect(buttonPressed, isTrue);

      // Reset
      buttonPressed = false;

      // Press Space
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();

      expect(buttonPressed, isTrue);
    });
  });

  group('ZephyrAccessibleTextField', () {
    testWidgets('should create accessible text field', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleTextField(
            controller: controller,
            label: 'Test Label',
            hint: 'Test Hint',
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Hint'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Clean up
      controller.dispose();
    });

    testWidgets('should show required indicator', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleTextField(
            controller: controller,
            label: 'Required Field',
            isRequired: true,
          ),
        ),
      );

      expect(find.text('Required Field'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);

      // Clean up
      controller.dispose();
    });

    testWidgets('should show error message', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleTextField(
            controller: controller,
            label: 'Error Field',
            errorText: 'This field is required',
          ),
        ),
      );

      expect(find.text('Error Field'), findsOneWidget);
      expect(find.text('This field is required'), findsOneWidget);

      // Clean up
      controller.dispose();
    });

    testWidgets('should handle obscured text field', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleTextField(
            controller: controller,
            label: 'Password',
            isObscured: true,
          ),
        ),
      );

      expect(find.text('Password'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);

      // Clean up
      controller.dispose();
    });

    testWidgets('should handle text changes', (WidgetTester tester) async {
      final controller = TextEditingController();
      var changedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleTextField(
            controller: controller,
            label: 'Input Field',
            onChanged: (value) {
              changedValue = value;
            },
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Hello World');
      await tester.pump();

      expect(controller.text, equals('Hello World'));
      expect(changedValue, equals('Hello World'));

      // Clean up
      controller.dispose();
    });

    testWidgets('should handle text submission', (WidgetTester tester) async {
      final controller = TextEditingController();
      var submittedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleTextField(
            controller: controller,
            label: 'Input Field',
            onSubmitted: (value) {
              submittedValue = value;
            },
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Hello World');
      await tester.pump();

      // Submit with Enter key
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      expect(submittedValue, equals('Hello World'));

      // Clean up
      controller.dispose();
    });

    testWidgets('should support keyboard navigation', (WidgetTester tester) async {
      final controller = TextEditingController();
      var submittedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleTextField(
            controller: controller,
            label: 'Input Field',
            onSubmitted: (value) {
              submittedValue = value;
            },
          ),
        ),
      );

      // Focus the field
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      // Submit with Enter key
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      expect(submittedValue, equals(''));

      // Clean up
      controller.dispose();
    });
  });

  group('ZephyrAccessibleCheckbox', () {
    testWidgets('should create accessible checkbox', (WidgetTester tester) async {
      var checkboxValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleCheckbox(
            value: checkboxValue,
            label: 'Test Checkbox',
            onChanged: (value) {
              checkboxValue = value;
            },
          ),
        ),
      );

      expect(find.text('Test Checkbox'), findsOneWidget);
      expect(find.byType(CheckboxListTile), findsOneWidget);

      // Test checkbox toggle
      await tester.tap(find.text('Test Checkbox'));
      await tester.pump();

      expect(checkboxValue, isTrue);
    });

    testWidgets('should handle disabled checkbox', (WidgetTester tester) async {
      var checkboxValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleCheckbox(
            value: checkboxValue,
            label: 'Disabled Checkbox',
            onChanged: (value) {
              checkboxValue = value;
            },
            isDisabled: true,
          ),
        ),
      );

      expect(find.text('Disabled Checkbox'), findsOneWidget);

      // Test checkbox toggle - should not work
      await tester.tap(find.text('Disabled Checkbox'));
      await tester.pump();

      expect(checkboxValue, isFalse);
    });

    testWidgets('should support keyboard navigation', (WidgetTester tester) async {
      var checkboxValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleCheckbox(
            value: checkboxValue,
            label: 'Keyboard Checkbox',
            onChanged: (value) {
              checkboxValue = value;
            },
          ),
        ),
      );

      // Focus the checkbox
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      // Toggle with Space key
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();

      expect(checkboxValue, isTrue);

      // Toggle with Enter key
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      expect(checkboxValue, isFalse);
    });
  });

  group('ZephyrAccessibleSwitch', () {
    testWidgets('should create accessible switch', (WidgetTester tester) async {
      var switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleSwitch(
            value: switchValue,
            label: 'Test Switch',
            onChanged: (value) {
              switchValue = value;
            },
          ),
        ),
      );

      expect(find.text('Test Switch'), findsOneWidget);
      expect(find.byType(SwitchListTile), findsOneWidget);

      // Test switch toggle
      await tester.tap(find.text('Test Switch'));
      await tester.pump();

      expect(switchValue, isTrue);
    });

    testWidgets('should handle disabled switch', (WidgetTester tester) async {
      var switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleSwitch(
            value: switchValue,
            label: 'Disabled Switch',
            onChanged: (value) {
              switchValue = value;
            },
            isDisabled: true,
          ),
        ),
      );

      expect(find.text('Disabled Switch'), findsOneWidget);

      // Test switch toggle - should not work
      await tester.tap(find.text('Disabled Switch'));
      await tester.pump();

      expect(switchValue, isFalse);
    });

    testWidgets('should support keyboard navigation', (WidgetTester tester) async {
      var switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleSwitch(
            value: switchValue,
            label: 'Keyboard Switch',
            onChanged: (value) {
              switchValue = value;
            },
          ),
        ),
      );

      // Focus the switch
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      // Toggle with Space key
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();

      expect(switchValue, isTrue);

      // Toggle with Enter key
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      expect(switchValue, isFalse);
    });
  });
}