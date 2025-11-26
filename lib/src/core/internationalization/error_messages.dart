/// ZephyrUI 错误消息国际化
///
/// 提供多语言错误消息和本地化支持

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// TODO: 重新导入错误处理相关的文件
// import 'package:zephyr_ui/src/core/error_handling/error_types.dart';

// 临时定义错误类型，直到错误处理模块被重新实现
enum ZephyrErrorCodes {
  unknownError,
  internalError,
  invalidArgument,
  operationFailed,
  networkError,
  timeoutError,
  connectionError,
  serverError,
  validationError,
  requiredFieldMissing,
  invalidFormat,
  valueOutOfRange,
  accessibilityError,
  missingSemantics,
  insufficientContrast,
  missingFocusIndicator,
  invalidKeyboardNavigation,
  componentNotFound,
  componentInitializationFailed,
  componentRenderingFailed,
  invalidComponentState,
  themeNotFound,
  themeInitializationFailed,
  invalidThemeData,
}

enum ZephyrErrorLevel {
  debug,
  info,
  warning,
  error,
  critical,
  fatal,
}

class ZephyrError {
  ZephyrError({
    required this.code,
    required this.message,
    required this.level,
    this.details,
    DateTime? timestamp,
    this.isRecoverable = false,
    this.recoverySuggestion,
  }) : timestamp = timestamp ?? DateTime.now();
  final String code;
  final String message;
  final String? details;
  final ZephyrErrorLevel level;
  final DateTime timestamp;
  final bool isRecoverable;
  final String? recoverySuggestion;
}

/// 错误消息本地化委托
class ZephyrErrorMessagesLocalizations {
  static const LocalizationsDelegate<ZephyrErrorMessagesLocalizations>
      delegate = _ZephyrErrorMessagesLocalizationsDelegate();

  static ZephyrErrorMessagesLocalizations? of(BuildContext context) {
    return Localizations.of<ZephyrErrorMessagesLocalizations>(
      context,
      ZephyrErrorMessagesLocalizations,
    );
  }

  /// 通用错误消息
  String get unknownError => '发生未知错误';
  String get internalError => '内部错误';
  String get invalidArgument => '无效参数';
  String get operationFailed => '操作失败';
  String get networkError => '网络错误';
  String get timeoutError => '请求超时';
  String get connectionError => '连接错误';
  String get serverError => '服务器错误';
  String get validationError => '验证错误';
  String get requiredFieldMissing => '缺少必填字段';
  String get invalidFormat => '格式无效';
  String get valueOutOfRange => '值超出范围';
  String get accessibilityError => '无障碍错误';
  String get missingSemantics => '缺少语义化标签';
  String get insufficientContrast => '颜色对比度不足';
  String get missingFocusIndicator => '缺少焦点指示器';
  String get invalidKeyboardNavigation => '无效的键盘导航';

  /// 组件错误消息
  String get componentNotFound => '组件未找到';
  String get componentInitializationFailed => '组件初始化失败';
  String get componentRenderingFailed => '组件渲染失败';
  String get invalidComponentState => '无效的组件状态';

  /// 主题错误消息
  String get themeNotFound => '主题未找到';
  String get themeInitializationFailed => '主题初始化失败';
  String get invalidThemeData => '无效的主题数据';

  /// 错误级别消息
  String get debugLevel => '调试';
  String get infoLevel => '信息';
  String get warningLevel => '警告';
  String get errorLevel => '错误';
  String get criticalLevel => '严重';
  String get fatalLevel => '致命';

  /// 错误恢复消息
  String get retry => '重试';
  String get recover => '恢复';
  String get cancel => '取消';
  String get ok => '确定';
  String get close => '关闭';
  String get back => '返回';
  String get refresh => '刷新';
  String get tryAgain => '重试';
  String get contactSupport => '联系支持';

  /// 错误详情消息
  String get errorDetails => '错误详情';
  String get stackTrace => '堆栈跟踪';
  String get errorCode => '错误代码';
  String get timestamp => '时间戳';
  String get severity => '严重程度';
  String get recoverySuggestion => '恢复建议';

  /// 无障碍错误消息
  String get accessibilityViolation => '无障碍违规';
  String get wcagGuideline => 'WCAG指导原则';
  String get accessibilityLevel => '无障碍级别';
  String get fixSuggestion => '修复建议';

  /// 格式化错误消息
  String formatErrorMessage(String message, [Map<String, dynamic>? params]) {
    var formattedMessage = message;

    if (params != null) {
      params.forEach((key, value) {
        formattedMessage =
            formattedMessage.replaceAll('{$key}', value.toString());
      });
    }

    return formattedMessage;
  }

  /// 获取本地化的错误消息
  String getLocalizedMessage(ZephyrError error) {
    switch (error.code) {
      case 'unknownError':
        return unknownError;
      case 'internalError':
        return internalError;
      case 'invalidArgument':
        return invalidArgument;
      case 'operationFailed':
        return operationFailed;
      case 'networkError':
        return networkError;
      case 'timeoutError':
        return timeoutError;
      case 'connectionError':
        return connectionError;
      case 'serverError':
        return serverError;
      case 'validationError':
        return validationError;
      case 'requiredFieldMissing':
        return requiredFieldMissing;
      case 'invalidFormat':
        return invalidFormat;
      case 'valueOutOfRange':
        return valueOutOfRange;
      case 'accessibilityError':
        return accessibilityError;
      case 'missingSemantics':
        return missingSemantics;
      case 'insufficientContrast':
        return insufficientContrast;
      case 'missingFocusIndicator':
        return missingFocusIndicator;
      case 'invalidKeyboardNavigation':
        return invalidKeyboardNavigation;
      case 'componentNotFound':
        return componentNotFound;
      case 'componentInitializationFailed':
        return componentInitializationFailed;
      case 'componentRenderingFailed':
        return componentRenderingFailed;
      case 'invalidComponentState':
        return invalidComponentState;
      case 'themeNotFound':
        return themeNotFound;
      case 'themeInitializationFailed':
        return themeInitializationFailed;
      case 'invalidThemeData':
        return invalidThemeData;
      default:
        return formatErrorMessage(error.message);
    }
  }

  /// 获取错误级别本地化消息
  String getErrorLevelMessage(ZephyrErrorLevel level) {
    switch (level) {
      case ZephyrErrorLevel.debug:
        return debugLevel;
      case ZephyrErrorLevel.info:
        return infoLevel;
      case ZephyrErrorLevel.warning:
        return warningLevel;
      case ZephyrErrorLevel.error:
        return errorLevel;
      case ZephyrErrorLevel.critical:
        return criticalLevel;
      case ZephyrErrorLevel.fatal:
        return fatalLevel;
    }
  }

  /// 获取无障碍违规本地化消息
  String getAccessibilityViolationMessage(dynamic violation) {
    return accessibilityViolation;
  }

  /// 获取WCAG指导原则本地化消息
  String getWCAGGuidelineMessage(dynamic guideline) {
    return wcagGuideline;
  }

  /// 获取WCAG级别本地化消息
  String getWCAGLevelMessage(dynamic level) {
    return accessibilityLevel;
  }

  /// 获取无障碍严重程度本地化消息
  String getAccessibilitySeverityMessage(dynamic severity) {
    return '轻微';
  }

  /// 获取合规状态本地化消息
  String getComplianceStatusMessage(dynamic status) {
    return '完全合规';
  }

  /// 格式化时间戳
  String formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
  }

  /// 格式化错误代码
  String formatErrorCode(String code) {
    return code.replaceAll('_', ' ').toUpperCase();
  }

  /// 获取错误文档链接
  String getErrorDocumentationLink(String errorCode) {
    return 'https://docs.zephyr-ui.com/errors/$errorCode';
  }

  /// 获取无障碍文档链接
  String getAccessibilityDocumentationLink(String checkName) {
    return 'https://docs.zephyr-ui.com/accessibility/$checkName';
  }
}

/// 中文错误消息本地化
class ZephyrErrorMessagesLocalizationsZh
    extends ZephyrErrorMessagesLocalizations {
  @override
  String get unknownError => '发生未知错误';
  @override
  String get internalError => '内部错误';
  @override
  String get invalidArgument => '无效参数';
  @override
  String get operationFailed => '操作失败';
  @override
  String get networkError => '网络错误';
  @override
  String get timeoutError => '请求超时';
  @override
  String get connectionError => '连接错误';
  @override
  String get serverError => '服务器错误';
  @override
  String get validationError => '验证错误';
  @override
  String get requiredFieldMissing => '缺少必填字段';
  @override
  String get invalidFormat => '格式无效';
  @override
  String get valueOutOfRange => '值超出范围';
  @override
  String get accessibilityError => '无障碍错误';
  @override
  String get missingSemantics => '缺少语义化标签';
  @override
  String get insufficientContrast => '颜色对比度不足';
  @override
  String get missingFocusIndicator => '缺少焦点指示器';
  @override
  String get invalidKeyboardNavigation => '无效的键盘导航';

  @override
  String get componentNotFound => '组件未找到';
  @override
  String get componentInitializationFailed => '组件初始化失败';
  @override
  String get componentRenderingFailed => '组件渲染失败';
  @override
  String get invalidComponentState => '无效的组件状态';

  @override
  String get themeNotFound => '主题未找到';
  @override
  String get themeInitializationFailed => '主题初始化失败';
  @override
  String get invalidThemeData => '无效的主题数据';

  @override
  String get debugLevel => '调试';
  @override
  String get infoLevel => '信息';
  @override
  String get warningLevel => '警告';
  @override
  String get errorLevel => '错误';
  @override
  String get criticalLevel => '严重';
  @override
  String get fatalLevel => '致命';

  @override
  String get retry => '重试';
  @override
  String get recover => '恢复';
  @override
  String get cancel => '取消';
  @override
  String get ok => '确定';
  @override
  String get close => '关闭';
  @override
  String get back => '返回';
  @override
  String get refresh => '刷新';
  @override
  String get tryAgain => '重试';
  @override
  String get contactSupport => '联系支持';

  @override
  String get errorDetails => '错误详情';
  @override
  String get stackTrace => '堆栈跟踪';
  @override
  String get errorCode => '错误代码';
  @override
  String get timestamp => '时间戳';
  @override
  String get severity => '严重程度';
  @override
  String get recoverySuggestion => '恢复建议';

  @override
  String get accessibilityViolation => '无障碍违规';
  @override
  String get wcagGuideline => 'WCAG指导原则';
  @override
  String get accessibilityLevel => '无障碍级别';
  @override
  String get fixSuggestion => '修复建议';
}

/// 英文错误消息本地化
class ZephyrErrorMessagesLocalizationsEn
    extends ZephyrErrorMessagesLocalizations {
  @override
  String get unknownError => 'An unknown error occurred';
  @override
  String get internalError => 'Internal error';
  @override
  String get invalidArgument => 'Invalid argument';
  @override
  String get operationFailed => 'Operation failed';
  @override
  String get networkError => 'Network error';
  @override
  String get timeoutError => 'Request timeout';
  @override
  String get connectionError => 'Connection error';
  @override
  String get serverError => 'Server error';
  @override
  String get validationError => 'Validation error';
  @override
  String get requiredFieldMissing => 'Required field missing';
  @override
  String get invalidFormat => 'Invalid format';
  @override
  String get valueOutOfRange => 'Value out of range';
  @override
  String get accessibilityError => 'Accessibility error';
  @override
  String get missingSemantics => 'Missing semantic label';
  @override
  String get insufficientContrast => 'Insufficient color contrast';
  @override
  String get missingFocusIndicator => 'Missing focus indicator';
  @override
  String get invalidKeyboardNavigation => 'Invalid keyboard navigation';

  @override
  String get componentNotFound => 'Component not found';
  @override
  String get componentInitializationFailed => 'Component initialization failed';
  @override
  String get componentRenderingFailed => 'Component rendering failed';
  @override
  String get invalidComponentState => 'Invalid component state';

  @override
  String get themeNotFound => 'Theme not found';
  @override
  String get themeInitializationFailed => 'Theme initialization failed';
  @override
  String get invalidThemeData => 'Invalid theme data';

  @override
  String get debugLevel => 'Debug';
  @override
  String get infoLevel => 'Info';
  @override
  String get warningLevel => 'Warning';
  @override
  String get errorLevel => 'Error';
  @override
  String get criticalLevel => 'Critical';
  @override
  String get fatalLevel => 'Fatal';

  @override
  String get retry => 'Retry';
  @override
  String get recover => 'Recover';
  @override
  String get cancel => 'Cancel';
  @override
  String get ok => 'OK';
  @override
  String get close => 'Close';
  @override
  String get back => 'Back';
  @override
  String get refresh => 'Refresh';
  @override
  String get tryAgain => 'Try Again';
  @override
  String get contactSupport => 'Contact Support';

  @override
  String get errorDetails => 'Error Details';
  @override
  String get stackTrace => 'Stack Trace';
  @override
  String get errorCode => 'Error Code';
  @override
  String get timestamp => 'Timestamp';
  @override
  String get severity => 'Severity';
  @override
  String get recoverySuggestion => 'Recovery Suggestion';

  @override
  String get accessibilityViolation => 'Accessibility Violation';
  @override
  String get wcagGuideline => 'WCAG Guideline';
  @override
  String get accessibilityLevel => 'Accessibility Level';
  @override
  String get fixSuggestion => 'Fix Suggestion';
}

/// 本地化委托
class _ZephyrErrorMessagesLocalizationsDelegate
    extends LocalizationsDelegate<ZephyrErrorMessagesLocalizations> {
  const _ZephyrErrorMessagesLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<ZephyrErrorMessagesLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'zh':
        return ZephyrErrorMessagesLocalizationsZh();
      case 'en':
      default:
        return ZephyrErrorMessagesLocalizationsEn();
    }
  }

  @override
  bool shouldReload(
      LocalizationsDelegate<ZephyrErrorMessagesLocalizations> old) {
    return false;
  }
}

/// 错误消息格式化器
class ZephyrErrorMessageFormatter {
  /// 格式化错误消息
  static String formatError(
    ZephyrError error,
    BuildContext context, {
    bool includeDetails = false,
    bool includeTimestamp = false,
    bool includeErrorCode = false,
  }) {
    final localizations = ZephyrErrorMessagesLocalizations.of(context)!;
    final buffer = StringBuffer();

    // 基本错误消息
    buffer.write(localizations.getLocalizedMessage(error));

    // 添加错误代码
    if (includeErrorCode) {
      buffer.write(' (${localizations.formatErrorCode(error.code)})');
    }

    // 添加时间戳
    if (includeTimestamp) {
      buffer.write(
          '\n${localizations.timestamp}: ${localizations.formatTimestamp(error.timestamp)}');
    }

    // 添加错误级别
    buffer.write(
        '\n${localizations.severity}: ${localizations.getErrorLevelMessage(error.level)}');

    // 添加错误详情
    if (includeDetails && error.details != null) {
      buffer.write('\n\n${localizations.errorDetails}:\n${error.details}');
    }

    // 添加恢复建议
    if (error.recoverySuggestion != null) {
      buffer.write(
          '\n\n${localizations.recoverySuggestion}:\n${error.recoverySuggestion}');
    }

    return buffer.toString();
  }

  /// 格式化无障碍违规消息
  static String formatAccessibilityViolation(
    dynamic violation,
    BuildContext context, {
    bool includeFixSuggestion = true,
    bool includeWCAGInfo = true,
  }) {
    final localizations = ZephyrErrorMessagesLocalizations.of(context)!;
    final buffer = StringBuffer();

    // 基本违规消息
    buffer.write(
        '${localizations.getAccessibilityViolationMessage(violation)}: ${violation.message}');

    // 添加严重程度
    buffer.write(
        '\n${localizations.accessibilityLevel}: ${localizations.getAccessibilitySeverityMessage(violation.severity)}');

    // 添加WCAG信息
    if (includeWCAGInfo && violation.criterion != null) {
      buffer.write(
          '\n${localizations.wcagGuideline}: ${violation.criterion!.id} - ${violation.criterion!.description}');
      buffer.write(
          ' (${localizations.getWCAGLevelMessage(violation.criterion!.level)})');
    }

    // 添加修复建议
    if (includeFixSuggestion && violation.fixSuggestion != null) {
      buffer.write(
          '\n\n${localizations.fixSuggestion}:\n${violation.fixSuggestion}');
    }

    return buffer.toString();
  }

  /// 格式化错误报告
  static String formatErrorReport(
    List<ZephyrError> errors,
    BuildContext context, {
    bool includeDetails = false,
    bool groupByLevel = true,
  }) {
    final localizations = ZephyrErrorMessagesLocalizations.of(context)!;
    final buffer = StringBuffer();

    // 报告标题
    buffer.write('=== ${localizations.errorDetails} ===\n');
    buffer.write('Total Errors: ${errors.length}\n\n');

    // 按级别分组
    if (groupByLevel) {
      final groupedErrors = <ZephyrErrorLevel, List<ZephyrError>>{};

      for (final error in errors) {
        groupedErrors.putIfAbsent(error.level, () => []).add(error);
      }

      for (final level in ZephyrErrorLevel.values) {
        final levelErrors = groupedErrors[level];
        if (levelErrors != null && levelErrors.isNotEmpty) {
          buffer.write(
              '${localizations.getErrorLevelMessage(level)} (${levelErrors.length}):\n');
          for (final error in levelErrors) {
            buffer.write(
                '  - ${formatError(error, context, includeDetails: false)}\n');
          }
          buffer.write('\n');
        }
      }
    } else {
      // 简单列表
      for (final error in errors) {
        buffer.write(
            '${formatError(error, context, includeDetails: includeDetails)}\n\n');
      }
    }

    return buffer.toString();
  }
}
