
/// 表单验证器接口
abstract class ZephyrFormValidator {
  /// 验证值
  String? validate(dynamic value);
}

/// 必填验证器
class ZephyrRequiredValidator implements ZephyrFormValidator {
  final String? errorMessage;

  const ZephyrRequiredValidator([this.errorMessage]);

  @override
  String? validate(dynamic value) {
    if (value == null || 
        (value is String && value.trim().isEmpty) ||
        (value is List && value.isEmpty) ||
        (value is Map && value.isEmpty)) {
      return errorMessage ?? '此字段为必填项';
    }
    return null;
  }
}

/// 长度验证器
class ZephyrLengthValidator implements ZephyrFormValidator {
  final int? minLength;
  final int? maxLength;
  final String? errorMessage;

  const ZephyrLengthValidator({
    this.minLength,
    this.maxLength,
    this.errorMessage,
  });

  @override
  String? validate(dynamic value) {
    if (value == null) return null;
    
    final length = value is String ? value.length : value.toString().length;
    
    if (minLength != null && length < minLength!) {
      return errorMessage ?? '最小长度为 $minLength 个字符';
    }
    
    if (maxLength != null && length > maxLength!) {
      return errorMessage ?? '最大长度为 $maxLength 个字符';
    }
    
    return null;
  }
}

/// 邮箱验证器
class ZephyrEmailValidator implements ZephyrFormValidator {
  final String? errorMessage;

  const ZephyrEmailValidator([this.errorMessage]);

  @override
  String? validate(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) return null;
    
    final email = value.toString().trim();
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    
    if (!emailRegex.hasMatch(email)) {
      return errorMessage ?? '请输入有效的邮箱地址';
    }
    
    return null;
  }
}

/// 数字验证器
class ZephyrNumberValidator implements ZephyrFormValidator {
  final double? minValue;
  final double? maxValue;
  final String? errorMessage;

  const ZephyrNumberValidator({
    this.minValue,
    this.maxValue,
    this.errorMessage,
  });

  @override
  String? validate(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) return null;
    
    final number = double.tryParse(value.toString());
    if (number == null) {
      return errorMessage ?? '请输入有效的数字';
    }
    
    if (minValue != null && number < minValue!) {
      return errorMessage ?? '最小值为 $minValue';
    }
    
    if (maxValue != null && number > maxValue!) {
      return errorMessage ?? '最大值为 $maxValue';
    }
    
    return null;
  }
}

/// 正则表达式验证器
class ZephyrRegexValidator implements ZephyrFormValidator {
  final RegExp regex;
  final String? errorMessage;

  const ZephyrRegexValidator(this.regex, [this.errorMessage]);

  @override
  String? validate(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) return null;
    
    if (!regex.hasMatch(value.toString())) {
      return errorMessage ?? '格式不正确';
    }
    
    return null;
  }
}

/// 自定义验证器
class ZephyrCustomValidator implements ZephyrFormValidator {
  final String? Function(dynamic value) validator;

  const ZephyrCustomValidator(this.validator);

  @override
  String? validate(dynamic value) {
    return validator(value);
  }
}

/// 组合验证器
class ZephyrCompositeValidator implements ZephyrFormValidator {
  final List<ZephyrFormValidator> validators;

  const ZephyrCompositeValidator(this.validators);

  @override
  String? validate(dynamic value) {
    for (final validator in validators) {
      final result = validator.validate(value);
      if (result != null) return result;
    }
    return null;
  }
}