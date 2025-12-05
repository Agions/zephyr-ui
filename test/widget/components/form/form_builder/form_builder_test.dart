import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/form/form_builder/form_builder.dart';
import 'package:velocity_ui/src/components/form/form_builder/form_field.dart';
import 'package:velocity_ui/src/components/form/form_builder/form_validator.dart';
import 'package:velocity_ui/src/components/form/form_builder/form_builder_theme.dart';

void main() {
  group('VelocityFormBuilder', () {
    late List<VelocityFormField> testFields;

    setUp(() {
      testFields = [
        const VelocityFormField(
          name: 'username',
          label: '用户名',
          type: VelocityFormFieldType.text,
          required: true,
          validators: [
            VelocityLengthValidator(minLength: 3, maxLength: 20),
          ],
        ),
        const VelocityFormField(
          name: 'email',
          label: '邮箱',
          type: VelocityFormFieldType.email,
          required: true,
        ),
        const VelocityFormField(
          name: 'age',
          label: '年龄',
          type: VelocityFormFieldType.number,
          defaultValue: 18,
        ),
      ];
    });

    testWidgets('renders form with fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityFormBuilder(
              fields: testFields,
              onSubmit: (values) {},
              onChange: (values) {},
              onFieldChange: (name, value) {},
              onValidate: (isValid, errors) {},
            ),
          ),
        ),
      );

      expect(find.text('用户名'), findsOneWidget);
      expect(find.text('邮箱'), findsOneWidget);
      expect(find.text('年龄'), findsOneWidget);
    });

    testWidgets('handles field value changes', (WidgetTester tester) async {
      Map<String, dynamic>? currentValues;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityFormBuilder(
              fields: testFields,
              onSubmit: (values) {},
              onChange: (values) {
                currentValues = values;
              },
              onFieldChange: (name, value) {},
              onValidate: (isValid, errors) {},
            ),
          ),
        ),
      );

      // Enter username
      await tester.enterText(find.byType(TextField).first, 'testuser');
      await tester.pump();

      expect(currentValues?['username'], equals('testuser'));
    });

    testWidgets('validates required fields', (WidgetTester tester) async {
      var isValid = false;
      Map<String, String?>? errors;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityFormBuilder(
              fields: testFields,
              onSubmit: (values) {},
              onChange: (values) {},
              onFieldChange: (name, value) {},
              onValidate: (valid, errs) {
                isValid = valid;
                errors = errs;
              },
            ),
          ),
        ),
      );

      // Try to submit without filling required fields
      await tester.tap(find.text('提交'));
      await tester.pump();

      expect(isValid, isFalse);
      expect(errors?['username'], isNotNull);
      expect(errors?['email'], isNotNull);
    });

    testWidgets('validates email format', (WidgetTester tester) async {
      String? emailError;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityFormBuilder(
              fields: testFields,
              onSubmit: (values) {},
              onChange: (values) {},
              onFieldChange: (name, value) {},
              onValidate: (isValid, errors) {
                emailError = errors['email'];
              },
            ),
          ),
        ),
      );

      // Try to submit with invalid email
      await tester.enterText(find.byType(TextField).last, 'invalid-email');
      await tester.pump();
      
      await tester.tap(find.text('提交'));
      await tester.pump();

      expect(emailError, isNotNull);
    });

    testWidgets('validates field length', (WidgetTester tester) async {
      String? usernameError;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityFormBuilder(
              fields: testFields,
              onSubmit: (values) {},
              onChange: (values) {},
              onFieldChange: (name, value) {},
              onValidate: (isValid, errors) {
                usernameError = errors['username'];
              },
            ),
          ),
        ),
      );

      // Enter username that's too short
      await tester.enterText(find.byType(TextField).first, 'ab');
      await tester.pump();
      
      // Try to submit to trigger validation
      await tester.tap(find.text('提交'));
      await tester.pump();

      expect(usernameError, isNotNull);
    });

    testWidgets('handles form submission', (WidgetTester tester) async {
      var submitted = false;
      Map<String, dynamic>? submittedValues;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityFormBuilder(
              fields: testFields,
              onSubmit: (values) {
                submitted = true;
                submittedValues = values;
              },
              onChange: (values) {},
              onFieldChange: (name, value) {},
              onValidate: (valid, errs) {},
            ),
          ),
        ),
      );

      // Fill required fields - find by widget type and enter text
      final textFields = find.byType(TextField);
      expect(textFields, findsAtLeastNWidgets(2));
      
      await tester.enterText(textFields.at(0), 'testuser');
      await tester.enterText(textFields.at(1), 'test@example.com');
      await tester.pump();

      // Submit form
      await tester.tap(find.text('提交'));
      await tester.pump(); // Trigger the tap
      await tester.pumpAndSettle(); // Wait for async operations to complete

  
      expect(submitted, isTrue);
      expect(submittedValues?['username'], equals('testuser'));
      expect(submittedValues?['email'], equals('test@example.com'));
    });

    testWidgets('handles form reset', (WidgetTester tester) async {
      Map<String, dynamic>? currentValues;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityFormBuilder(
              fields: testFields,
              onSubmit: (values) {},
              onChange: (values) {
                currentValues = values;
              },
              onFieldChange: (name, value) {},
              onValidate: (isValid, errors) {},
              showResetButton: true,
            ),
          ),
        ),
      );

      // Enter some values
      await tester.enterText(find.byType(TextField).first, 'testuser');
      await tester.pump();

      expect(currentValues?['username'], equals('testuser'));

      // Reset form
      await tester.tap(find.text('重置'));
      await tester.pump(); // Trigger the tap
      await tester.pumpAndSettle(); // Wait for async operations to complete

      expect(currentValues?['username'], isNull);
    });

    testWidgets('applies custom theme', (WidgetTester tester) async {
      final customTheme = VelocityFormBuilderTheme.custom(
        primaryColor: Colors.red,
        labelStyle: const TextStyle(fontSize: 16),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityFormBuilder(
              fields: testFields,
              onSubmit: (values) {},
              onChange: (values) {},
              onFieldChange: (name, value) {},
              onValidate: (isValid, errors) {},
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.text('用户名'), findsOneWidget);
    });

    testWidgets('supports different field types', (WidgetTester tester) async {
      final fields = [
        const VelocityFormField(
          name: 'text',
          label: '文本',
          type: VelocityFormFieldType.text,
        ),
        const VelocityFormField(
          name: 'textarea',
          label: '多行文本',
          type: VelocityFormFieldType.textarea,
        ),
        const VelocityFormField(
          name: 'password',
          label: '密码',
          type: VelocityFormFieldType.password,
        ),
        const VelocityFormField(
          name: 'select',
          label: '选择',
          type: VelocityFormFieldType.select,
          options: [
            VelocityFormFieldOption(value: 'option1', label: '选项1'),
            VelocityFormFieldOption(value: 'option2', label: '选项2'),
          ],
        ),
        const VelocityFormField(
          name: 'switch',
          label: '开关',
          type: VelocityFormFieldType.switchField,
        ),
        const VelocityFormField(
          name: 'slider',
          label: '滑块',
          type: VelocityFormFieldType.slider,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: VelocityFormBuilder(
                fields: fields,
                onSubmit: (values) {},
                onChange: (values) {},
                onFieldChange: (name, value) {},
                onValidate: (isValid, errors) {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('文本'), findsOneWidget);
      expect(find.text('多行文本'), findsOneWidget);
      expect(find.text('密码'), findsOneWidget);
      expect(find.text('选择'), findsOneWidget);
      expect(find.text('开关'), findsOneWidget);
      expect(find.text('滑块'), findsOneWidget);
    });
  });

  group('VelocityFormValidator', () {
    test('required validator validates empty values', () {
      const validator = VelocityRequiredValidator();
      expect(validator.validate(null), isNotNull);
      expect(validator.validate(''), isNotNull);
      expect(validator.validate('test'), isNull);
    });

    test('length validator validates string length', () {
      const validator = VelocityLengthValidator(minLength: 3, maxLength: 10);
      expect(validator.validate('ab'), isNotNull);
      expect(validator.validate('abcdefghijk'), isNotNull);
      expect(validator.validate('abc'), isNull);
      expect(validator.validate('abcdefghij'), isNull);
    });

    test('email validator validates email format', () {
      const validator = VelocityEmailValidator();
      expect(validator.validate('invalid-email'), isNotNull);
      expect(validator.validate('test@example.com'), isNull);
    });

    test('number validator validates numeric values', () {
      const validator = VelocityNumberValidator(minValue: 0, maxValue: 100);
      expect(validator.validate('abc'), isNotNull);
      expect(validator.validate('-1'), isNotNull);
      expect(validator.validate('101'), isNotNull);
      expect(validator.validate('50'), isNull);
    });

    test('regex validator validates pattern', () {
      final validator = VelocityRegexValidator(RegExp(r'^[A-Z]+$'));
      expect(validator.validate('abc'), isNotNull);
      expect(validator.validate('ABC'), isNull);
    });

    test('composite validator validates with multiple validators', () {
      const validator = VelocityCompositeValidator([
        VelocityRequiredValidator(),
        VelocityLengthValidator(minLength: 3),
      ]);
      expect(validator.validate(null), isNotNull);
      expect(validator.validate('ab'), isNotNull);
      expect(validator.validate('abc'), isNull);
    });
  });

  group('VelocityFormField', () {
    test('creates field with required parameters', () {
      const field = VelocityFormField(
        name: 'test',
        label: 'Test Field',
        type: VelocityFormFieldType.text,
      );
      expect(field.name, equals('test'));
      expect(field.label, equals('Test Field'));
      expect(field.type, equals(VelocityFormFieldType.text));
      expect(field.required, isFalse);
    });

    test('creates field with all parameters', () {
      const field = VelocityFormField(
        name: 'test',
        label: 'Test Field',
        type: VelocityFormFieldType.text,
        required: true,
        placeholder: 'Enter value',
        helpText: 'This is a test field',
        description: 'Test field description',
        defaultValue: 'default',
        validators: [VelocityRequiredValidator()],
      );
      expect(field.name, equals('test'));
      expect(field.label, equals('Test Field'));
      expect(field.required, isTrue);
      expect(field.placeholder, equals('Enter value'));
      expect(field.helpText, equals('This is a test field'));
      expect(field.description, equals('Test field description'));
      expect(field.defaultValue, equals('default'));
      expect(field.validators, isNotEmpty);
    });

    test('validates field value', () {
      const field = VelocityFormField(
        name: 'test',
        label: 'Test Field',
        type: VelocityFormFieldType.text,
        required: true,
        validators: [
          VelocityLengthValidator(minLength: 3),
        ],
      );
      expect(field.validate(null), isNotNull);
      expect(field.validate('ab'), isNotNull);
      expect(field.validate('abc'), isNull);
    });

    test('checks field visibility', () {
      final field = VelocityFormField(
        name: 'test',
        label: 'Test Field',
        type: VelocityFormFieldType.text,
        visible: (values) => values['show'] == true,
      );
      expect(field.isVisible({'show': true}), isTrue);
      expect(field.isVisible({'show': false}), isFalse);
    });

    test('checks field enabled state', () {
      final field = VelocityFormField(
        name: 'test',
        label: 'Test Field',
        type: VelocityFormFieldType.text,
        enabled: (values) => values['enable'] == true,
      );
      expect(field.isEnabled({'enable': true}), isTrue);
      expect(field.isEnabled({'enable': false}), isFalse);
    });
  });

  group('VelocityFormFieldOption', () {
    test('creates option with required parameters', () {
      const option = VelocityFormFieldOption(
        value: 'test',
        label: 'Test Option',
      );
      expect(option.value, equals('test'));
      expect(option.label, equals('Test Option'));
      expect(option.disabled, isFalse);
    });

    test('creates option with all parameters', () {
      const option = VelocityFormFieldOption(
        value: 'test',
        label: 'Test Option',
        description: 'Test option description',
        disabled: true,
        data: {'key': 'value'},
      );
      expect(option.value, equals('test'));
      expect(option.label, equals('Test Option'));
      expect(option.description, equals('Test option description'));
      expect(option.disabled, isTrue);
      expect(option.data, equals({'key': 'value'}));
    });
  });

  group('VelocityFormBuilderTheme', () {
    test('creates light theme', () {
      final theme = VelocityFormBuilderTheme.light();
      expect(theme.backgroundColor, equals(Colors.white));
      expect(theme.primaryColor, equals(const Color(0xFF3B82F6)));
    });

    test('creates dark theme', () {
      final theme = VelocityFormBuilderTheme.dark();
      expect(theme.backgroundColor, equals(const Color(0xFF1F2937)));
      expect(theme.primaryColor, equals(const Color(0xFF60A5FA)));
    });

    test('creates custom theme', () {
      final theme = VelocityFormBuilderTheme.custom(
        primaryColor: Colors.red,
        labelStyle: const TextStyle(fontSize: 16),
      );
      expect(theme.primaryColor, equals(Colors.red));
      expect(theme.labelStyle.fontSize, equals(16));
    });

    test('copies theme with modifications', () {
      final theme = VelocityFormBuilderTheme.light();
      final modified = theme.copyWith(primaryColor: Colors.blue);
      expect(modified.primaryColor, equals(Colors.blue));
      expect(modified.backgroundColor, equals(theme.backgroundColor));
    });

    test('merges themes', () {
      final theme1 = VelocityFormBuilderTheme.light();
      final theme2 = VelocityFormBuilderTheme.custom(primaryColor: Colors.red);
      final merged = theme1.merge(theme2);
      expect(merged.primaryColor, equals(Colors.red));
      expect(merged.backgroundColor, equals(theme1.backgroundColor));
    });

    test('compares themes for equality', () {
      final theme1 = VelocityFormBuilderTheme.light();
      final theme2 = VelocityFormBuilderTheme.light();
      expect(theme1, equals(theme2));
    });

    test('computes hash code', () {
      final theme = VelocityFormBuilderTheme.light();
      expect(theme.hashCode, isA<int>());
    });
  });

  group('VelocityFormState', () {
    test('creates initial state', () {
      final fields = [
        const VelocityFormField(
          name: 'test',
          label: 'Test',
          type: VelocityFormFieldType.text,
          defaultValue: 'default',
        ),
      ];
      final state = VelocityFormState.initial(fields);
      expect(state.values['test'], equals('default'));
      expect(state.isValid, isTrue);
      expect(state.isSubmitting, isFalse);
    });

    test('copies state with modifications', () {
      final fields = [
        const VelocityFormField(
          name: 'test',
          label: 'Test',
          type: VelocityFormFieldType.text,
        ),
      ];
      final state = VelocityFormState.initial(fields);
      final modified = state.copyWith(
        values: {'test': 'modified'},
        isValid: false,
      );
      expect(modified.values['test'], equals('modified'));
      expect(modified.isValid, isFalse);
    });
  });
}