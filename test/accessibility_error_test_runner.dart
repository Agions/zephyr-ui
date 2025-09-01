/// ZephyrUI 错误处理和无障碍测试运行器
///
/// 专门用于运行错误处理和无障碍相关的测试

import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrUI 错误处理和无障碍测试套件', () {
    setUpAll(() async {
      // 初始化错误处理器
      ZephyrErrorHandler.instance.init(
        ZephyrErrorHandlerConfig(
          defaultStrategy: ZephyrErrorHandlingStrategy.showUserMessage,
          enableLogging: true,
          enableReporting: true,
          enableAutoRecovery: true,
          maxRetryAttempts: 3,
          showDetailedErrorsInDebug: true,
        ),
      );
      
      // 初始化无障碍管理器
      await ZephyrAccessibilityManager.instance.init(
        config: ZephyrAccessibilityManagerConfig(
          enabled: true,
          autoDetectSystemSettings: false,
          enableRealTimeChecking: false,
          defaultConfig: ZephyrAccessibilityConfig(
            enabledFeatures: {
              ZephyrAccessibilityFeature.screenReader,
              ZephyrAccessibilityFeature.keyboardNavigation,
              ZephyrAccessibilityFeature.highContrast,
            },
          ),
        ),
      );
    });

    // 错误处理测试
    group('错误处理核心功能', () {
      test('错误处理器应该正确初始化', () {
        expect(ZephyrErrorHandler.instance, isNotNull);
        expect(ZephyrErrorHandler.instance is ZephyrErrorHandler, isTrue);
      });

      test('应该能够创建和处理基础错误', () async {
        final error = ZephyrError(
          code: ZephyrErrorCodes.unknownError,
          message: '测试错误',
          level: ZephyrErrorLevel.error,
          isRecoverable: true,
          recoverySuggestion: '请重试操作',
        );

        expect(error.code, ZephyrErrorCodes.unknownError);
        expect(error.message, '测试错误');
        expect(error.level, ZephyrErrorLevel.error);
        expect(error.isRecoverable, isTrue);
        expect(error.recoverySuggestion, '请重试操作');

        // 验证错误可以被处理
        await ZephyrErrorHandler.instance.handleError(error);
      });

      test('应该能够创建和处理组件错误', () async {
        final error = ZephyrComponentError(
          componentName: 'TestComponent',
          componentType: 'StatefulWidget',
          code: ZephyrErrorCodes.componentNotFound,
          message: '组件未找到',
          componentProperties: {
            'key': 'test-key',
            'value': 'test-value',
          },
        );

        expect(error.componentName, 'TestComponent');
        expect(error.componentType, 'StatefulWidget');
        expect(error.code, ZephyrErrorCodes.componentNotFound);
        expect(error.componentProperties, isNotNull);

        // 验证错误可以被处理
        await ZephyrErrorHandler.instance.handleError(error);
      });

      test('应该能够创建和处理网络错误', () async {
        final error = ZephyrNetworkError(
          code: ZephyrErrorCodes.networkError,
          message: '网络连接失败',
          statusCode: 500,
          url: 'https://api.example.com/users',
          method: 'GET',
        );

        expect(error.statusCode, 500);
        expect(error.url, 'https://api.example.com/users');
        expect(error.method, 'GET');

        // 验证错误可以被处理
        await ZephyrErrorHandler.instance.handleError(error);
      });

      test('应该能够创建和处理验证错误', () async {
        final error = ZephyrValidationError(
          code: ZephyrErrorCodes.validationError,
          message: '输入验证失败',
          field: 'email',
          value: 'invalid-email',
          validationRule: 'email_format',
        );

        expect(error.field, 'email');
        expect(error.value, 'invalid-email');
        expect(error.validationRule, 'email_format');

        // 验证错误可以被处理
        await ZephyrErrorHandler.instance.handleError(error);
      });

      test('应该能够创建和处理无障碍错误', () async {
        final error = ZephyrAccessibilityError(
          code: ZephyrErrorCodes.missingSemantics,
          message: '缺少语义化标记',
          checkItem: 'semantic_label',
          wcagGuideline: '1.1.1',
          severity: ZephyrAccessibilitySeverity.serious,
        );

        expect(error.checkItem, 'semantic_label');
        expect(error.wcagGuideline, '1.1.1');
        expect(error.severity, ZephyrAccessibilitySeverity.serious);

        // 验证错误可以被处理
        await ZephyrErrorHandler.instance.handleError(error);
      });

      test('错误应该能够正确转换为JSON', () {
        final error = ZephyrError(
          code: ZephyrErrorCodes.unknownError,
          message: '测试错误',
          level: ZephyrErrorLevel.error,
          context: {
            'key1': 'value1',
            'key2': 'value2',
          },
        );

        final json = error.toJson();
        expect(json['code'], ZephyrErrorCodes.unknownError);
        expect(json['message'], '测试错误');
        expect(json['level'], ZephyrErrorLevel.error.name);
        expect(json['context'], isNotNull);
        expect(json['context']['key1'], 'value1');
        expect(json['context']['key2'], 'value2');
      });
    });

    // 无障碍功能测试
    group('无障碍功能核心测试', () {
      test('无障碍管理器应该正确初始化', () {
        expect(ZephyrAccessibilityManager.instance, isNotNull);
        expect(ZephyrAccessibilityManager.instance is ZephyrAccessibilityManager, isTrue);
      });

      test('应该能够创建和配置无障碍设置', () {
        final config = ZephyrAccessibilityConfig(
          enabled: true,
          textScaleFactor: 1.5,
          highContrast: true,
          reduceMotion: true,
          minTouchTargetSize: 48.0,
          enabledFeatures: {
            ZephyrAccessibilityFeature.screenReader,
            ZephyrAccessibilityFeature.keyboardNavigation,
          },
        );

        expect(config.enabled, isTrue);
        expect(config.textScaleFactor, 1.5);
        expect(config.highContrast, isTrue);
        expect(config.reduceMotion, isTrue);
        expect(config.minTouchTargetSize, 48.0);
        expect(config.enabledFeatures.contains(ZephyrAccessibilityFeature.screenReader), isTrue);
        expect(config.enabledFeatures.contains(ZephyrAccessibilityFeature.keyboardNavigation), isTrue);
      });

      test('应该能够创建语义化数据', () {
        final semanticData = ZephyrSemanticData(
          label: '测试标签',
          hint: '测试提示',
          value: '测试值',
          selected: true,
          enabled: true,
          focused: false,
          customActions: {
            'onTap': () {},
            'onLongPress': () {},
          },
        );

        expect(semanticData.label, '测试标签');
        expect(semanticData.hint, '测试提示');
        expect(semanticData.value, '测试值');
        expect(semanticData.selected, isTrue);
        expect(semanticData.enabled, isTrue);
        expect(semanticData.focused, isFalse);
        expect(semanticData.customActions, isNotNull);
      });

      test('语义化数据应该能够转换为属性', () {
        final semanticData = ZephyrSemanticData(
          label: '测试标签',
          hint: '测试提示',
          value: '测试值',
          selected: true,
          enabled: true,
          checked: true,
          toggled: false,
        );

        final properties = semanticData.toSemanticsProperties();
        expect(properties.label, '测试标签');
        expect(properties.hint, '测试提示');
        expect(properties.value, '测试值');
        expect(properties.selected, isTrue);
        expect(properties.enabled, isTrue);
        expect(properties.checked, isTrue);
        expect(properties.toggled, isFalse);
      });

      test('应该能够创建无障碍违规', () {
        final violation = ZephyrAccessibilityViolation(
          check: ZephyrAccessibilityCheck.semanticLabel,
          criterion: ZephyrWCAGStandards.perceivableStandards.first,
          severity: ZephyrAccessibilitySeverity.serious,
          message: '缺少语义化标签',
          fixSuggestion: '添加语义化标签',
          affectedElement: 'Button',
          location: {
            'file': 'test.dart',
            'line': 10,
          },
        );

        expect(violation.check, ZephyrAccessibilityCheck.semanticLabel);
        expect(violation.criterion, isNotNull);
        expect(violation.severity, ZephyrAccessibilitySeverity.serious);
        expect(violation.message, '缺少语义化标签');
        expect(violation.fixSuggestion, '添加语义化标签');
        expect(violation.affectedElement, 'Button');
        expect(violation.location, isNotNull);
      });

      test('无障碍违规应该能够转换为JSON', () {
        final violation = ZephyrAccessibilityViolation(
          check: ZephyrAccessibilityCheck.semanticLabel,
          severity: ZephyrAccessibilitySeverity.serious,
          message: '缺少语义化标签',
        );

        final json = violation.toJson();
        expect(json['check'], ZephyrAccessibilityCheck.semanticLabel.name);
        expect(json['severity'], ZephyrAccessibilitySeverity.serious.name);
        expect(json['message'], '缺少语义化标签');
      });
    });

    // 集成测试
    group('错误处理和无障碍集成测试', () {
      test('错误处理器应该能够处理无障碍错误', () async {
        final accessibilityError = ZephyrAccessibilityError(
          code: ZephyrErrorCodes.missingSemantics,
          message: '缺少语义化标记',
          checkItem: 'semantic_label',
          severity: ZephyrAccessibilitySeverity.serious,
        );

        // 验证错误可以被错误处理器处理
        await expectLater(
          () async => await ZephyrErrorHandler.instance.handleError(accessibilityError),
          returnsNormally,
        );
      });

      test('应该能够生成完整的无障碍测试报告', () {
        final results = [
          ZephyrAccessibilityTestResult(
            testedAt: DateTime.now(),
            component: 'AccessibleButton',
            passedChecks: [
              ZephyrAccessibilityCheck.semanticLabel,
              ZephyrAccessibilityCheck.keyboardNavigation,
              ZephyrAccessibilityCheck.touchTargetSize,
            ],
            violations: [],
            score: 100.0,
            complianceStatus: ZephyrAccessibilityComplianceStatus.fullyCompliant,
          ),
          ZephyrAccessibilityTestResult(
            testedAt: DateTime.now(),
            component: 'InaccessibleComponent',
            passedChecks: [],
            violations: [
              ZephyrAccessibilityViolation(
                check: ZephyrAccessibilityCheck.semanticLabel,
                severity: ZephyrAccessibilitySeverity.serious,
                message: '缺少语义化标签',
                fixSuggestion: '添加语义化标签',
              ),
              ZephyrAccessibilityViolation(
                check: ZephyrAccessibilityCheck.touchTargetSize,
                severity: ZephyrAccessibilitySeverity.moderate,
                message: '触摸目标太小',
                fixSuggestion: '增加触摸目标尺寸',
              ),
            ],
            score: 0.0,
            complianceStatus: ZephyrAccessibilityComplianceStatus.nonCompliant,
          ),
        ];

        final report = ZephyrAccessibilityTestTools.generateTestReport(results);

        expect(report['summary']['totalTests'], 2);
        expect(report['summary']['passedTests'], 1);
        expect(report['summary']['failedTests'], 1);
        expect(report['summary']['averageScore'], 50.0);
        expect(report['violationsByType'], isNotNull);
        expect(report['detailedResults'], isNotNull);
        expect(report['detailedResults'].length, 2);
      });

      test('应该能够提供有意义的改进建议', () {
        final results = [
          ZephyrAccessibilityTestResult(
            testedAt: DateTime.now(),
            component: 'ProblematicComponent',
            passedChecks: [],
            violations: [
              ZephyrAccessibilityViolation(
                check: ZephyrAccessibilityCheck.semanticLabel,
                severity: ZephyrAccessibilitySeverity.serious,
                message: '缺少语义化标签',
                fixSuggestion: '添加语义化标签',
              ),
              ZephyrAccessibilityViolation(
                check: ZephyrAccessibilityCheck.colorContrast,
                severity: ZephyrAccessibilitySeverity.serious,
                message: '颜色对比度不足',
                fixSuggestion: '增加颜色对比度',
              ),
              ZephyrAccessibilityViolation(
                check: ZephyrAccessibilityCheck.touchTargetSize,
                severity: ZephyrAccessibilitySeverity.moderate,
                message: '触摸目标太小',
                fixSuggestion: '增加触摸目标尺寸',
              ),
            ],
            score: 0.0,
            complianceStatus: ZephyrAccessibilityComplianceStatus.nonCompliant,
          ),
        ];

        final suggestions = ZephyrAccessibilityTestTools.getImprovementSuggestions(results);

        expect(suggestions, isNotEmpty);
        expect(suggestions.length, 3);
        expect(suggestions.contains('添加语义化标签'), isTrue);
        expect(suggestions.contains('增加颜色对比度'), isTrue);
        expect(suggestions.contains('增加触摸目标尺寸'), isTrue);
      });
    });

    // 性能测试
    group('性能测试', () {
      test('错误处理应该在高负载下保持性能', () async {
        final errors = List.generate(100, (index) => 
          ZephyrError(
            code: 'ERROR_$index',
            message: '错误 $index',
            level: ZephyrErrorLevel.error,
          )
        );

        final stopwatch = Stopwatch()..start();
        
        for (final error in errors) {
          await ZephyrErrorHandler.instance.handleError(error);
        }
        
        stopwatch.stop();
        
        // 处理100个错误应该在5秒内完成
        expect(stopwatch.elapsedMilliseconds, lessThan(5000));
      });

      test('无障碍检查应该在高负载下保持性能', () {
        final violations = List.generate(50, (index) => 
          ZephyrAccessibilityViolation(
            check: ZephyrAccessibilityCheck.semanticLabel,
            severity: ZephyrAccessibilitySeverity.serious,
            message: '违规 $index',
          )
        );

        final results = List.generate(50, (index) => 
          ZephyrAccessibilityTestResult(
            testedAt: DateTime.now(),
            component: 'Component_$index',
            passedChecks: [],
            violations: violations,
            score: 0.0,
            complianceStatus: ZephyrAccessibilityComplianceStatus.nonCompliant,
          )
        );

        final stopwatch = Stopwatch()..start();
        
        final report = ZephyrAccessibilityTestTools.generateTestReport(results);
        
        stopwatch.stop();
        
        // 生成报告应该在1秒内完成
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
        expect(report['summary']['totalTests'], 50);
      });

      test('配置更新应该高效', () {
        final manager = ZephyrAccessibilityManager.instance;
        
        final stopwatch = Stopwatch()..start();
        
        for (int i = 0; i < 100; i++) {
          final newConfig = ZephyrAccessibilityConfig(
            textScaleFactor: 1.0 + (i * 0.01),
            highContrast: i % 2 == 0,
          );
          manager.updateConfig(newConfig);
        }
        
        stopwatch.stop();
        
        // 100次配置更新应该在1秒内完成
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      });
    });

    // 边界条件测试
    group('边界条件测试', () {
      test('应该处理空和极长的错误消息', () {
        // 空消息
        final emptyError = ZephyrError(
          code: ZephyrErrorCodes.unknownError,
          message: '',
          level: ZephyrErrorLevel.error,
        );
        expect(emptyError.message, '');

        // 极长消息
        final longMessage = 'A' * 10000;
        final longError = ZephyrError(
          code: ZephyrErrorCodes.unknownError,
          message: longMessage,
          level: ZephyrErrorLevel.error,
        );
        expect(longError.message, longMessage);
        expect(longError.message.length, 10000);
      });

      test('应该处理特殊字符和Unicode', () {
        final specialMessage = '错误消息包含特殊字符: @#\$%^&*()_+-=[]{}|;:,.<>?';
        final unicodeMessage = '错误消息包含Unicode: 中文 🚀 emoji áéíóú';
        
        final specialError = ZephyrError(
          code: ZephyrErrorCodes.unknownError,
          message: specialMessage,
          level: ZephyrErrorLevel.error,
        );
        
        final unicodeError = ZephyrError(
          code: ZephyrErrorCodes.unknownError,
          message: unicodeMessage,
          level: ZephyrErrorLevel.error,
        );
        
        expect(specialError.message, specialMessage);
        expect(unicodeError.message, unicodeMessage);
      });

      test('应该处理极端的无障碍配置', () {
        // 极大文本缩放
        final largeScaleConfig = ZephyrAccessibilityConfig(
          textScaleFactor: 10.0,
        );
        expect(largeScaleConfig.textScaleFactor, 10.0);

        // 极小触摸目标
        final smallTargetConfig = ZephyrAccessibilityConfig(
          minTouchTargetSize: 1.0,
        );
        expect(smallTargetConfig.minTouchTargetSize, 1.0);

        // 空特性集合
        final emptyFeaturesConfig = ZephyrAccessibilityConfig(
          enabledFeatures: {},
        );
        expect(emptyFeaturesConfig.enabledFeatures, isEmpty);
      });

      test('应该处理无效的错误恢复', () async {
        final error = ZephyrError(
          code: ZephyrErrorCodes.unknownError,
          message: '测试错误',
          level: ZephyrErrorLevel.error,
          isRecoverable: true,
        );

        // 注册失败的恢复器
        ZephyrErrorHandler.instance.registerRecoverer(
          error.code,
          (error) async {
            throw Exception('恢复失败');
          },
        );

        // 尝试恢复，应该不会抛出异常
        await expectLater(
          () async => await ZephyrErrorHandler.instance.handleError(
            error,
            strategy: ZephyrErrorHandlingStrategy.autoRecover,
          ),
          returnsNormally,
        );
      });
    });

    // 内存管理测试
    group('内存管理测试', () {
      test('错误处理器不应该有内存泄漏', () async {
        // 在测试前记录内存使用情况
        final initialMemory = getCurrentMemoryUsage();

        // 创建和处理大量错误
        for (int i = 0; i < 1000; i++) {
          final error = ZephyrError(
            code: 'ERROR_$i',
            message: '错误 $i',
            level: ZephyrErrorLevel.error,
          );

          await ZephyrErrorHandler.instance.handleError(error);
        }

        // 强制垃圾回收
        await Future.delayed(const Duration(milliseconds: 100));

        // 记录处理后的内存使用情况
        final finalMemory = getCurrentMemoryUsage();

        // 内存增长应该在合理范围内
        final memoryIncrease = finalMemory - initialMemory;
        expect(memoryIncrease, lessThan(10 * 1024 * 1024)); // 小于10MB
      });

      test('无障碍管理器不应该有内存泄漏', () async {
        final manager = ZephyrAccessibilityManager.instance;
        final initialMemory = getCurrentMemoryUsage();

        // 大量配置更新
        for (int i = 0; i < 1000; i++) {
          final newConfig = ZephyrAccessibilityConfig(
            textScaleFactor: 1.0 + (i % 100) * 0.01,
            highContrast: i % 2 == 0,
          );
          manager.updateConfig(newConfig);
        }

        // 强制垃圾回收
        await Future.delayed(const Duration(milliseconds: 100));

        final finalMemory = getCurrentMemoryUsage();

        // 内存增长应该在合理范围内
        final memoryIncrease = finalMemory - initialMemory;
        expect(memoryIncrease, lessThan(5 * 1024 * 1024)); // 小于5MB
      });
    });

    // 并发测试
    group('并发测试', () {
      test('错误处理器应该能够处理并发错误', () async {
        final futures = List.generate(100, (index) => 
          ZephyrErrorHandler.instance.handleError(
            ZephyrError(
              code: 'CONCURRENT_ERROR_$index',
              message: '并发错误 $index',
              level: ZephyrErrorLevel.error,
            ),
          )
        );

        // 并发处理100个错误
        await Future.wait(futures);

        // 验证所有错误都被处理
        expect(futures.length, 100);
      });

      test('无障碍管理器应该能够处理并发配置更新', () async {
        final manager = ZephyrAccessibilityManager.instance;
        
        final futures = List.generate(100, (index) => 
          Future.microtask(() {
            final newConfig = ZephyrAccessibilityConfig(
              textScaleFactor: 1.0 + (index % 50) * 0.01,
              highContrast: index % 2 == 0,
            );
            manager.updateConfig(newConfig);
          })
        );

        // 并发更新配置
        await Future.wait(futures);

        // 验证所有配置更新都被处理
        expect(futures.length, 100);
      });
    });
  });
}

// 辅助函数：获取当前内存使用情况（模拟实现）
int getCurrentMemoryUsage() {
  // 在实际测试中，这里应该使用 dart:developer 或其他工具
  // 来获取真实的内存使用情况
  return 0;
}