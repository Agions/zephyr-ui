import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zephyr_ui/src/core/accessibility/accessibility_manager.dart';
import 'package:zephyr_ui/src/core/accessibility/accessibility_types.dart';
import 'package:zephyr_ui/src/core/accessibility/accessibility_checker.dart';
import 'package:zephyr_ui/src/core/accessibility/accessibility_utils.dart';

// Mock classes
class MockAccessibilityChecker extends Mock implements ZephyrAccessibilityChecker {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('ZephyrAccessibilityManager', () {
    late ZephyrAccessibilityManager manager;
    late MockAccessibilityChecker mockChecker;
    late ZephyrAccessibilityManagerConfig defaultConfig;

    setUp(() {
      mockChecker = MockAccessibilityChecker();
      defaultConfig = ZephyrAccessibilityManagerConfig(
        defaultConfig: ZephyrAccessibilityConfig(),
      );
      
      // Mock the checker methods
      when(() => mockChecker.checkComponent(any(), componentName: any(named: 'componentName')))
          .thenAnswer((_) async => ZephyrAccessibilityTestResult(
                testedAt: DateTime.now(),
                component: 'TestComponent',
                passedChecks: [ZephyrAccessibilityCheck.semanticLabel],
                violations: [],
                score: 1.0,
                complianceStatus: ZephyrAccessibilityComplianceStatus.fullyCompliant,
              ));
      
      when(() => mockChecker.checkApp(any()))
          .thenAnswer((_) async => []);
      
      when(() => mockChecker.generateReport())
          .thenAnswer((_) async => {});
      
      when(() => mockChecker.getRecommendations(any()))
          .thenReturn([]);
      
      manager = ZephyrAccessibilityManager.instance;
    });

    tearDown(() {
      reset(mockChecker);
    });

    group('Initialization', () {
      test('should initialize with default config', () async {
        await manager.init(config: defaultConfig);
        
        expect(manager.currentConfig, equals(defaultConfig.defaultConfig));
        expect(manager, isNotNull);
      });

      test('should initialize with custom config', () async {
        final customConfig = ZephyrAccessibilityConfig(
          enabled: false,
          textScaleFactor: 1.5,
          highContrast: true,
        );
        
        final config = ZephyrAccessibilityManagerConfig(
          defaultConfig: customConfig,
        );
        
        await manager.init(config: config);
        
        expect(manager.currentConfig.enabled, equals(false));
        expect(manager.currentConfig.textScaleFactor, equals(1.5));
        expect(manager.currentConfig.highContrast, equals(true));
      });
    });

    group('Configuration Management', () {
      setUp(() async {
        await manager.init(config: defaultConfig);
      });

      test('should update configuration', () {
        final newConfig = ZephyrAccessibilityConfig(
          enabled: false,
          textScaleFactor: 2.0,
        );
        
        var configUpdated = false;
        ZephyrAccessibilityConfig? receivedConfig;
        
        manager.addConfigListener((config) {
          configUpdated = true;
          receivedConfig = config;
        });
        
        manager.updateConfig(newConfig);
        
        expect(configUpdated, isTrue);
        expect(receivedConfig, equals(newConfig));
        expect(manager.currentConfig, equals(newConfig));
      });

      test('should enable feature', () {
        manager.enableFeature(ZephyrAccessibilityFeature.screenReader);
        
        expect(manager.isFeatureEnabled(ZephyrAccessibilityFeature.screenReader), isTrue);
      });

      test('should disable feature', () {
        manager.enableFeature(ZephyrAccessibilityFeature.screenReader);
        manager.disableFeature(ZephyrAccessibilityFeature.screenReader);
        
        expect(manager.isFeatureEnabled(ZephyrAccessibilityFeature.screenReader), isFalse);
      });

      test('should check feature enabled state', () {
        expect(manager.isFeatureEnabled(ZephyrAccessibilityFeature.screenReader), isFalse);
        
        manager.enableFeature(ZephyrAccessibilityFeature.screenReader);
        expect(manager.isFeatureEnabled(ZephyrAccessibilityFeature.screenReader), isTrue);
        
        manager.disableFeature(ZephyrAccessibilityFeature.screenReader);
        expect(manager.isFeatureEnabled(ZephyrAccessibilityFeature.screenReader), isFalse);
      });

      test('should reset to defaults', () {
        final originalConfig = manager.currentConfig;
        
        manager.updateConfig(ZephyrAccessibilityConfig(
          enabled: false,
          textScaleFactor: 2.0,
        ));
        
        manager.resetToDefaults();
        
        expect(manager.currentConfig, equals(originalConfig));
      });
    });

    group('Accessibility Checking', () {
      setUp(() async {
        await manager.init(config: defaultConfig);
      });

      test('should check component accessibility', () async {
        final widget = Container();
        final result = await manager.checkComponent(
          widget,
          componentName: 'TestWidget',
        );
        
        expect(result.component, equals('TestWidget'));
        expect(result.passedChecks, isNotEmpty);
        expect(result.violations, isEmpty);
        expect(result.score, equals(1.0));
        expect(result.complianceStatus, equals(ZephyrAccessibilityComplianceStatus.fullyCompliant));
      });

      test('should check app accessibility', () async {
        final context = MockBuildContext();
        final results = await manager.checkApp(context);
        
        expect(results, isA<List<ZephyrAccessibilityTestResult>>());
      });

      test('should generate accessibility report', () async {
        final report = await manager.generateReport();
        
        expect(report, isA<Map<String, dynamic>>());
      });

      test('should get recommendations', () {
        final recommendations = manager.getRecommendations();
        
        expect(recommendations, isA<List<String>>());
      });
    });

    group('Configuration Listeners', () {
      setUp(() async {
        await manager.init(config: defaultConfig);
      });

      test('should notify config listeners', () {
        var listenerCalled = false;
        ZephyrAccessibilityConfig? receivedConfig;
        
        manager.addConfigListener((config) {
          listenerCalled = true;
          receivedConfig = config;
        });
        
        final newConfig = ZephyrAccessibilityConfig(
          enabled: false,
        );
        
        manager.updateConfig(newConfig);
        
        expect(listenerCalled, isTrue);
        expect(receivedConfig, equals(newConfig));
      });

      test('should remove config listener', () {
        var listenerCalled = false;
        
        void listener(ZephyrAccessibilityConfig config) {
          listenerCalled = true;
        }
        
        manager.addConfigListener(listener);
        manager.removeConfigListener(listener);
        
        manager.updateConfig(ZephyrAccessibilityConfig(
          enabled: false,
        ));
        
        expect(listenerCalled, isFalse);
      });
    });

    group('System Settings Listeners', () {
      setUp(() async {
        await manager.init(config: defaultConfig);
      });

      test('should notify system settings listeners', () {
        var listenerCalled = false;
        Map<String, bool>? receivedSettings;
        
        manager.addSystemSettingsListener((settings) {
          listenerCalled = true;
          receivedSettings = settings;
        });
        
        // Simulate system settings change
        final settings = {
          'screenReader': true,
          'highContrast': false,
        };
        
        // This would normally be called by the system
        // For testing, we'll access private method
        // ignore: invalid_use_of_protected_member
        manager._systemSettings.addAll(settings);
        // ignore: invalid_use_of_protected_member
        for (final listener in manager._systemSettingsListeners) {
          listener(settings);
        }
        
        expect(listenerCalled, isTrue);
        expect(receivedSettings, equals(settings));
      });

      test('should remove system settings listener', () {
        var listenerCalled = false;
        
        void listener(Map<String, bool> settings) {
          listenerCalled = true;
        }
        
        manager.addSystemSettingsListener(listener);
        manager.removeSystemSettingsListener(listener);
        
        // Simulate system settings change
        final settings = {'screenReader': true};
        
        // This would normally be called by the system
        // ignore: invalid_use_of_protected_member
        for (final listener in manager._systemSettingsListeners) {
          listener(settings);
        }
        
        expect(listenerCalled, isFalse);
      });
    });

    group('Configuration Export/Import', () {
      setUp(() async {
        await manager.init(config: defaultConfig);
      });

      test('should export configuration', () {
        final exported = manager.exportConfig();
        
        expect(exported, isA<Map<String, dynamic>>());
        expect(exported['enabled'], isA<bool>());
        expect(exported['textScaleFactor'], isA<double>());
        expect(exported['enabledFeatures'], isA<List>());
        expect(exported['disabledChecks'], isA<List>());
      });

      test('should import configuration', () {
        final configData = {
          'enabled': false,
          'textScaleFactor': 2.0,
          'highContrast': true,
          'reduceMotion': true,
          'enabledFeatures': ['screenReader', 'keyboardNavigation'],
          'disabledChecks': ['semanticLabel'],
          'keyboardNavigationMode': 'fullKeyboard',
        };
        
        manager.importConfig(configData);
        
        expect(manager.currentConfig.enabled, equals(false));
        expect(manager.currentConfig.textScaleFactor, equals(2.0));
        expect(manager.currentConfig.highContrast, equals(true));
        expect(manager.currentConfig.reduceMotion, equals(true));
        expect(manager.currentConfig.enabledFeatures, contains(ZephyrAccessibilityFeature.screenReader));
        expect(manager.currentConfig.enabledFeatures, contains(ZephyrAccessibilityFeature.keyboardNavigation));
        expect(manager.currentConfig.disabledChecks, contains(ZephyrAccessibilityCheck.semanticLabel));
        expect(manager.currentConfig.keyboardNavigationMode, equals(ZephyrKeyboardNavigationMode.fullKeyboard));
      });

      test('should handle invalid import data', () {
        final originalConfig = manager.currentConfig;
        final invalidData = {
          'enabled': 'invalid_boolean',
          'textScaleFactor': 'invalid_number',
        };
        
        // Should not throw
        manager.importConfig(invalidData);
        
        // Should keep original config
        expect(manager.currentConfig, equals(originalConfig));
      });
    });

    group('Theme Application', () {
      setUp(() async {
        await manager.init(config: defaultConfig);
      });

      test('should apply accessibility to theme', () {
        final theme = ThemeData.light();
        final accessibilityConfig = ZephyrAccessibilityConfig(
          highContrast: true,
          textScaleFactor: 1.5,
          reduceMotion: true,
          focusColor: Colors.red,
        );
        
        manager.updateConfig(accessibilityConfig);
        
        final modifiedTheme = manager.applyToTheme(theme);
        
        expect(modifiedTheme, isA<ThemeData>());
        expect(modifiedTheme.textTheme, isNotNull);
        expect(modifiedTheme.focusColor, equals(Colors.red));
      });
    });

    group('Widget Creation', () {
      setUp(() async {
        await manager.init(config: defaultConfig);
      });

      test('should create semantic wrapper', () {
        final child = Container();
        final wrapper = manager.createSemanticWrapper(
          child: child,
          label: 'Test Label',
          hint: 'Test Hint',
          isButton: true,
        );
        
        expect(wrapper, isA<Widget>());
        expect(wrapper, isNot(equals(child)));
      });

      test('should create focus indicator', () {
        final child = Container();
        final indicator = manager.createFocusIndicator(
          child: child,
          focusColor: Colors.blue,
          borderWidth: 3.0,
        );
        
        expect(indicator, isA<Widget>());
        expect(indicator, isNot(equals(child)));
      });

      test('should create keyboard navigation handler', () {
        final child = Container();
        final focusNode = FocusNode();
        var enterPressed = false;
        
        final handler = manager.createKeyboardNavigationHandler(
          child: child,
          focusNode: focusNode,
          onEnter: () {
            enterPressed = true;
          },
        );
        
        expect(handler, isA<Widget>());
        expect(handler, isNot(equals(child)));
        
        // Clean up
        focusNode.dispose();
      });
    });

    group('Accessibility Types', () {
      test('should have all required features', () {
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.screenReader));
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.keyboardNavigation));
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.highContrast));
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.textScaling));
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.colorBlind));
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.reduceMotion));
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.largeText));
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.voiceControl));
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.switchControl));
        expect(ZephyrAccessibilityFeature.values, contains(ZephyrAccessibilityFeature.fontAdjustment));
      });

      test('should have all required checks', () {
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.semanticLabel));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.focusManagement));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.keyboardNavigation));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.colorContrast));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.textReadability));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.interactiveElementSize));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.animationAccessibility));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.formLabels));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.errorMessage));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.stateChangeNotification));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.orientationAwareness));
        expect(ZephyrAccessibilityCheck.values, contains(ZephyrAccessibilityCheck.touchTargetSize));
      });

      test('should have all required compliance statuses', () {
        expect(ZephyrAccessibilityComplianceStatus.values, contains(ZephyrAccessibilityComplianceStatus.fullyCompliant));
        expect(ZephyrAccessibilityComplianceStatus.values, contains(ZephyrAccessibilityComplianceStatus.partiallyCompliant));
        expect(ZephyrAccessibilityComplianceStatus.values, contains(ZephyrAccessibilityComplianceStatus.nonCompliant));
        expect(ZephyrAccessibilityComplianceStatus.values, contains(ZephyrAccessibilityComplianceStatus.needsImprovement));
      });

      test('should have all required severity levels', () {
        expect(ZephyrAccessibilitySeverity.values, contains(ZephyrAccessibilitySeverity.minor));
        expect(ZephyrAccessibilitySeverity.values, contains(ZephyrAccessibilitySeverity.moderate));
        expect(ZephyrAccessibilitySeverity.values, contains(ZephyrAccessibilitySeverity.serious));
        expect(ZephyrAccessibilitySeverity.values, contains(ZephyrAccessibilitySeverity.blocker));
      });

      test('should have all required keyboard navigation modes', () {
        expect(ZephyrKeyboardNavigationMode.values, contains(ZephyrKeyboardNavigationMode.auto));
        expect(ZephyrKeyboardNavigationMode.values, contains(ZephyrKeyboardNavigationMode.tabOnly));
        expect(ZephyrKeyboardNavigationMode.values, contains(ZephyrKeyboardNavigationMode.directional));
        expect(ZephyrKeyboardNavigationMode.values, contains(ZephyrKeyboardNavigationMode.fullKeyboard));
      });
    });

    group('WCAG Standards', () {
      test('should have all required WCAG guidelines', () {
        expect(ZephyrWCAGGuideline.values, contains(ZephyrWCAGGuideline.perceivable));
        expect(ZephyrWCAGGuideline.values, contains(ZephyrWCAGGuideline.operable));
        expect(ZephyrWCAGGuideline.values, contains(ZephyrWCAGGuideline.understandable));
        expect(ZephyrWCAGGuideline.values, contains(ZephyrWCAGGuideline.robust));
      });

      test('should have all required WCAG levels', () {
        expect(ZephyrWCAGLevel.values, contains(ZephyrWCAGLevel.a));
        expect(ZephyrWCAGLevel.values, contains(ZephyrWCAGLevel.aa));
        expect(ZephyrWCAGLevel.values, contains(ZephyrWCAGLevel.aaa));
      });

      test('should have perceivable standards', () {
        expect(ZephyrWCAGStandards.perceivableStandards, isNotEmpty);
        expect(ZephyrWCAGStandards.perceivableStandards.length, greaterThan(0));
      });

      test('should have operable standards', () {
        expect(ZephyrWCAGStandards.operableStandards, isNotEmpty);
        expect(ZephyrWCAGStandards.operableStandards.length, greaterThan(0));
      });

      test('should have understandable standards', () {
        expect(ZephyrWCAGStandards.understandableStandards, isNotEmpty);
        expect(ZephyrWCAGStandards.understandableStandards.length, greaterThan(0));
      });

      test('should have robust standards', () {
        expect(ZephyrWCAGStandards.robustStandards, isNotEmpty);
        expect(ZephyrWCAGStandards.robustStandards.length, greaterThan(0));
      });

      test('should find standard by ID', () {
        final standard = ZephyrWCAGStandards.findById('1.4.3');
        expect(standard, isNotNull);
        expect(standard!.id, equals('1.4.3'));
        expect(standard.level, equals(ZephyrWCAGLevel.aa));
        expect(standard.guideline, equals(ZephyrWCAGGuideline.perceivable));
      });

      test('should return null for non-existent standard ID', () {
        final standard = ZephyrWCAGStandards.findById('non.existent');
        expect(standard, isNull);
      });
    });

    group('Semantic Data', () {
      test('should create semantic data with default values', () {
        final semanticData = ZephyrSemanticData();
        
        expect(semanticData.label, isNull);
        expect(semanticData.hint, isNull);
        expect(semanticData.value, isNull);
        expect(semanticData.checked, isNull);
        expect(semanticData.selected, isNull);
        expect(semanticData.disabled, isNull);
      });

      test('should create semantic data with custom values', () {
        final semanticData = ZephyrSemanticData(
          label: 'Test Label',
          hint: 'Test Hint',
          value: 'Test Value',
          checked: true,
          selected: false,
          disabled: false,
        );
        
        expect(semanticData.label, equals('Test Label'));
        expect(semanticData.hint, equals('Test Hint'));
        expect(semanticData.value, equals('Test Value'));
        expect(semanticData.checked, isTrue);
        expect(semanticData.selected, isFalse);
        expect(semanticData.disabled, isFalse);
      });

      test('should convert to semantic properties', () {
        final semanticData = ZephyrSemanticData(
          label: 'Test Label',
          hint: 'Test Hint',
          value: 'Test Value',
          checked: true,
          selected: false,
          disabled: false,
        );
        
        final properties = semanticData.toSemanticsProperties();
        
        expect(properties.label, equals('Test Label'));
        expect(properties.hint, equals('Test Hint'));
        expect(properties.value, equals('Test Value'));
        expect(properties.checked, isTrue);
        expect(properties.selected, isFalse);
        expect(properties.enabled, isTrue);
      });
    });

    group('Accessibility Violation', () {
      test('should create violation with required fields', () {
        final violation = ZephyrAccessibilityViolation(
          check: ZephyrAccessibilityCheck.semanticLabel,
          severity: ZephyrAccessibilitySeverity.serious,
          message: 'Missing semantic label',
        );
        
        expect(violation.check, equals(ZephyrAccessibilityCheck.semanticLabel));
        expect(violation.severity, equals(ZephyrAccessibilitySeverity.serious));
        expect(violation.message, equals('Missing semantic label'));
      });

      test('should create violation with all fields', () {
        final criterion = ZephyrWCAGStandards.findById('1.3.1')!;
        final violation = ZephyrAccessibilityViolation(
          check: ZephyrAccessibilityCheck.semanticLabel,
          criterion: criterion,
          severity: ZephyrAccessibilitySeverity.serious,
          message: 'Missing semantic label',
          fixSuggestion: 'Add semantic label to the element',
          affectedElement: 'Button',
          location: {'x': 100, 'y': 200},
        );
        
        expect(violation.check, equals(ZephyrAccessibilityCheck.semanticLabel));
        expect(violation.criterion, equals(criterion));
        expect(violation.severity, equals(ZephyrAccessibilitySeverity.serious));
        expect(violation.message, equals('Missing semantic label'));
        expect(violation.fixSuggestion, equals('Add semantic label to the element'));
        expect(violation.affectedElement, equals('Button'));
        expect(violation.location, equals({'x': 100, 'y': 200}));
      });

      test('should convert violation to JSON', () {
        final violation = ZephyrAccessibilityViolation(
          check: ZephyrAccessibilityCheck.semanticLabel,
          severity: ZephyrAccessibilitySeverity.serious,
          message: 'Missing semantic label',
        );
        
        final json = violation.toJson();
        
        expect(json, isA<Map<String, dynamic>>());
        expect(json['check'], equals('semanticLabel'));
        expect(json['severity'], equals('serious'));
        expect(json['message'], equals('Missing semantic label'));
      });
    });

    group('Accessibility Test Result', () {
      test('should create test result with required fields', () {
        final result = ZephyrAccessibilityTestResult(
          testedAt: DateTime.now(),
          component: 'TestComponent',
          passedChecks: [ZephyrAccessibilityCheck.semanticLabel],
          violations: [],
          score: 1.0,
          complianceStatus: ZephyrAccessibilityComplianceStatus.fullyCompliant,
        );
        
        expect(result.component, equals('TestComponent'));
        expect(result.passedChecks, contains(ZephyrAccessibilityCheck.semanticLabel));
        expect(result.violations, isEmpty);
        expect(result.score, equals(1.0));
        expect(result.complianceStatus, equals(ZephyrAccessibilityComplianceStatus.fullyCompliant));
      });

      test('should convert test result to JSON', () {
        final result = ZephyrAccessibilityTestResult(
          testedAt: DateTime(2023, 1, 1),
          component: 'TestComponent',
          passedChecks: [ZephyrAccessibilityCheck.semanticLabel],
          violations: [],
          score: 1.0,
          complianceStatus: ZephyrAccessibilityComplianceStatus.fullyCompliant,
        );
        
        final json = result.toJson();
        
        expect(json, isA<Map<String, dynamic>>());
        expect(json['component'], equals('TestComponent'));
        expect(json['passedChecks'], contains('semanticLabel'));
        expect(json['violations'], isEmpty);
        expect(json['score'], equals(1.0));
        expect(json['complianceStatus'], equals('fullyCompliant'));
      });
    });
  });
}