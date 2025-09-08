import 'package:flutter/material.dart';
import 'package:chroma_ui/src/core/theme/chroma_colors.dart';
import 'package:chroma_ui/src/core/theme/chroma_spacing.dart';
import 'package:chroma_ui/src/core/theme/chroma_typography.dart';

class chromaFormValidationSystem<T> extends StatefulWidget {
  final Widget child;
  final List<FormFieldValidator<T>> validators;
  final List<CrossFieldValidator<T>> crossFieldValidators;
  final Map<String, dynamic> initialValues;
  final Map<String, FocusNode> focusNodes;
  final bool autovalidate;
  final bool enabled;
  final ValueChanged<Map<String, dynamic>>? onChanged;
  final ValueChanged<Map<String, dynamic>>? onSaved;
  final ValueChanged<Map<String, dynamic>>? onSubmit;
  final VoidCallback? onReset;
  final Duration debounceDuration;
  final ValidationMode validationMode;
  final Widget Function(BuildContext, Map<String, FormFieldState>)? builder;

  const chromaFormValidationSystem({
    required this.child,
    this.validators = const [],
    this.crossFieldValidators = const [],
    this.initialValues = const {},
    this.focusNodes = const {},
    this.autovalidate = false,
    this.enabled = true,
    this.onChanged,
    this.onSaved,
    this.onSubmit,
    this.onReset,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.validationMode = ValidationMode.onChange,
    this.builder,
    super.key,
  });

  @override
  State<chromaFormValidationSystem<T>> createState() => _chromaFormValidationSystemState<T>();

  static _chromaFormValidationSystemState<T> of<T>(BuildContext context) {
    return context.findAncestorStateOfType<_chromaFormValidationSystemState<T>>()!;
  }
}

class _chromaFormValidationSystemState<T> extends State<chromaFormValidationSystem<T>> {
  final Map<String, FormFieldState<dynamic>> _fields = {};
  final Map<String, dynamic> _values = {};
  final Map<String, String> _errors = {};
  bool _isValid = false;
  bool _isDirty = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _values.addAll(widget.initialValues);
  }

  void registerField(String fieldName, FormFieldState<dynamic> fieldState) {
    _fields[fieldName] = fieldState;
    if (widget.initialValues.containsKey(fieldName)) {
      fieldState.didChange(widget.initialValues[fieldName]);
    }
  }

  void unregisterField(String fieldName) {
    _fields.remove(fieldName);
    _values.remove(fieldName);
    _errors.remove(fieldName);
  }

  void updateValue(String fieldName, dynamic value) {
    if (!_isDirty) {
      _isDirty = true;
    }

    _values[fieldName] = value;
    widget.onChanged?.call(Map.from(_values));

    if (widget.autovalidate || widget.validationMode == ValidationMode.onChange) {
      validateField(fieldName, value);
    }
  }

  void updateError(String fieldName, String? error) {
    if (error != null) {
      _errors[fieldName] = error;
    } else {
      _errors.remove(fieldName);
    }
    _updateValidity();
  }

  String? validateField(String fieldName, dynamic value) {
    final fieldValidators = widget.validators.where((v) => v.fieldName == fieldName);

    for (final validator in fieldValidators) {
      final result = validator.validate(value, _values);
      if (result != null) {
        updateError(fieldName, result);
        return result;
      }
    }

    // Cross-field validation
    for (final crossValidator in widget.crossFieldValidators) {
      if (crossValidator.fields.contains(fieldName)) {
        final result = crossValidator.validate(_values);
        if (result != null) {
          updateError(fieldName, result);
          return result;
        }
      }
    }

    updateError(fieldName, null);
    return null;
  }

  bool validate() {
    bool allValid = true;

    // Validate all fields
    for (final fieldName in _fields.keys) {
      final value = _values[fieldName];
      final error = validateField(fieldName, value);
      if (error != null) {
        allValid = false;
      }
    }

    // Cross-field validation
    for (final crossValidator in widget.crossFieldValidators) {
      final error = crossValidator.validate(_values);
      if (error != null) {
        for (final fieldName in crossValidator.fields) {
          updateError(fieldName, error);
        }
        allValid = false;
      }
    }

    return allValid;
  }

  void _updateValidity() {
    final wasValid = _isValid;
    _isValid = _errors.isEmpty;

    if (wasValid != _isValid) {
      setState(() {});
    }
  }

  Future<bool> submit() async {
    if (!validate()) {
      return false;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await widget.onSubmit?.call(Map.from(_values));
      return true;
    } catch (e) {
      return false;
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void reset() {
    _values.clear();
    _values.addAll(widget.initialValues);
    _errors.clear();
    _isDirty = false;
    _isValid = false;

    for (final field in _fields.values) {
      field.reset();
    }

    widget.onReset?.call();
    setState(() {});
  }

  void save() {
    widget.onSaved?.call(Map.from(_values));
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder?.call(context, _fields) ??
        Form(
          child: widget.child,
          onWillPop: () async {
            if (_isDirty) {
              return await _showUnsavedChangesDialog();
            }
            return true;
          },
        );
  }

  Future<bool> _showUnsavedChangesDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsaved Changes'),
        content: const Text('You have unsaved changes. Are you sure you want to leave?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Leave'),
          ),
        ],
      ),
    ) ?? false;
  }
}

class chromaFormField<T> extends StatefulWidget {
  final String fieldName;
  final T? initialValue;
  final FormFieldValidator<T>? validator;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?>? onSaved;
  final Widget Function(BuildContext, FormFieldState<T>) builder;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final String? restorationId;
  final VoidCallback? onReset;

  const chromaFormField({
    required this.fieldName,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onSaved,
    required this.builder,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.restorationId,
    this.onReset,
    super.key,
  });

  @override
  State<chromaFormField<T>> createState() => _chromaFormFieldState<T>();
}

class _chromaFormFieldState<T> extends State<chromaFormField<T>> {
  late FormFieldState<T> _fieldState;

  @override
  void initState() {
    super.initState();
    _fieldState = FormFieldState<T>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      onSaved: widget.onSaved,
      builder: widget.builder,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final formState = chromaFormValidationSystem.of<dynamic>(context);
    formState.registerField(widget.fieldName, _fieldState);
  }

  @override
  void dispose() {
    final formState = chromaFormValidationSystem.of<dynamic>(context);
    formState.unregisterField(widget.fieldName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _fieldState);
  }
}

// Validators
abstract class FormFieldValidator<T> {
  final String fieldName;
  final String errorMessage;

  const FormFieldValidator({
    required this.fieldName,
    required this.errorMessage,
  });

  String? validate(T? value, Map<String, dynamic> allValues);
}

class RequiredValidator<T> extends FormFieldValidator<T> {
  const RequiredValidator({
    required super.fieldName,
    super.errorMessage = 'This field is required',
  });

  @override
  String? validate(T? value, Map<String, dynamic> allValues) {
    if (value == null || (value is String && value.toString().trim().isEmpty)) {
      return errorMessage;
    }
    return null;
  }
}

class EmailValidator extends FormFieldValidator<String> {
  const EmailValidator({
    required super.fieldName,
    super.errorMessage = 'Please enter a valid email address',
  });

  @override
  String? validate(String? value, Map<String, dynamic> allValues) {
    if (value == null || value.isEmpty) return null;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }
}

class LengthValidator extends FormFieldValidator<String> {
  final int? minLength;
  final int? maxLength;

  const LengthValidator({
    required super.fieldName,
    this.minLength,
    this.maxLength,
    super.errorMessage = 'Invalid length',
  });

  @override
  String? validate(String? value, Map<String, dynamic> allValues) {
    if (value == null) return null;

    if (minLength != null && value.length < minLength!) {
      return 'Minimum length is $minLength characters';
    }

    if (maxLength != null && value.length > maxLength!) {
      return 'Maximum length is $maxLength characters';
    }

    return null;
  }
}

class RangeValidator extends FormFieldValidator<num> {
  final num? minValue;
  final num? maxValue;

  const RangeValidator({
    required super.fieldName,
    this.minValue,
    this.maxValue,
    super.errorMessage = 'Value out of range',
  });

  @override
  String? validate(num? value, Map<String, dynamic> allValues) {
    if (value == null) return null;

    if (minValue != null && value < minValue!) {
      return 'Value must be at least $minValue';
    }

    if (maxValue != null && value > maxValue!) {
      return 'Value must be at most $maxValue';
    }

    return null;
  }
}

class PatternValidator extends FormFieldValidator<String> {
  final RegExp pattern;

  const PatternValidator({
    required super.fieldName,
    required this.pattern,
    super.errorMessage = 'Invalid format',
  });

  @override
  String? validate(String? value, Map<String, dynamic> allValues) {
    if (value == null || value.isEmpty) return null;

    if (!pattern.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }
}

class CustomValidator<T> extends FormFieldValidator<T> {
  final String? Function(T? value, Map<String, dynamic> allValues) customValidator;

  const CustomValidator({
    required super.fieldName,
    required this.customValidator,
    super.errorMessage = 'Validation failed',
  });

  @override
  String? validate(T? value, Map<String, dynamic> allValues) {
    return customValidator(value, allValues);
  }
}

// Cross-field validators
abstract class CrossFieldValidator<T> {
  final List<String> fields;
  final String errorMessage;

  const CrossFieldValidator({
    required this.fields,
    required this.errorMessage,
  });

  String? validate(Map<String, dynamic> allValues);
}

class PasswordMatchValidator extends CrossFieldValidator<String> {
  final String passwordField;
  final String confirmPasswordField;

  const PasswordMatchValidator({
    required this.passwordField,
    required this.confirmPasswordField,
    super.errorMessage = 'Passwords do not match',
  }) : super(fields: [passwordField, confirmPasswordField]);

  @override
  String? validate(Map<String, dynamic> allValues) {
    final password = allValues[passwordField] as String?;
    final confirmPassword = allValues[confirmPasswordField] as String?;

    if (password == null || confirmPassword == null) return null;

    if (password != confirmPassword) {
      return errorMessage;
    }
    return null;
  }
}

class DateRangeValidator extends CrossFieldValidator<DateTime> {
  final String startDateField;
  final String endDateField;

  const DateRangeValidator({
    required this.startDateField,
    required this.endDateField,
    super.errorMessage = 'End date must be after start date',
  }) : super(fields: [startDateField, endDateField]);

  @override
  String? validate(Map<String, dynamic> allValues) {
    final startDate = allValues[startDateField] as DateTime?;
    final endDate = allValues[endDateField] as DateTime?;

    if (startDate == null || endDate == null) return null;

    if (endDate.isBefore(startDate)) {
      return errorMessage;
    }
    return null;
  }
}

// Async validators
abstract class AsyncFieldValidator<T> {
  final String fieldName;
  final String errorMessage;

  const AsyncFieldValidator({
    required this.fieldName,
    required this.errorMessage,
  });

  Future<String?> validate(T? value, Map<String, dynamic> allValues);
}

class UniqueEmailValidator extends AsyncFieldValidator<String> {
  final Future<bool> Function(String) checkEmailUniqueness;

  const UniqueEmailValidator({
    required super.fieldName,
    required this.checkEmailUniqueness,
    super.errorMessage = 'Email already exists',
  });

  @override
  Future<String?> validate(String? value, Map<String, dynamic> allValues) async {
    if (value == null || value.isEmpty) return null;

    final isUnique = await checkEmailUniqueness(value);
    if (!isUnique) {
      return errorMessage;
    }
    return null;
  }
}

enum ValidationMode {
  onChange,
  onBlur,
  onSubmit,
}

// Validation group
class ValidationGroup {
  final String name;
  final List<String> fieldNames;
  final List<FormFieldValidator> validators;
  final List<CrossFieldValidator> crossFieldValidators;

  const ValidationGroup({
    required this.name,
    required this.fieldNames,
    this.validators = const [],
    this.crossFieldValidators = const [],
  });
}

// Form validation result
class FormValidationResult {
  final bool isValid;
  final Map<String, String> errors;
  final Map<String, dynamic> values;

  const FormValidationResult({
    required this.isValid,
    required this.errors,
    required this.values,
  });
}
