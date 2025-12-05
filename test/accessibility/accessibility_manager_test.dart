import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:velocity_ui/src/core/accessibility/accessibility_manager.dart';
import 'package:velocity_ui/src/core/accessibility/accessibility_types.dart';
import 'package:velocity_ui/src/core/accessibility/accessibility_checker.dart';
import 'package:velocity_ui/src/core/accessibility/accessibility_utils.dart';

// Mock classes
class MockAccessibilityChecker extends Mock implements VelocityAccessibilityChecker {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('VelocityAccessibilityManager', () {
    late VelocityAccessibilityManager manager;
    late MockAccessibilityChecker mockChecker;
    late VelocityAccessibilityManagerConfig defaultConfig;

    setUp(() {
      mockChecker = MockAccessibilityChecker();
      defaultConfig = VelocityAccessibilityManagerConfig(
        defaultConfig: VelocityAccessibilityConfig(),
      );
      
      // Mock the checker methods
      when(() => mockChecker.checkComponent(any(), componentName: any(named: 'componentName')))
          .thenAnswer((_) async => VelocityAccessibilityTestResult(
                testedAt: DateTime.now(),
                component: 'TestComponent',
                passedChecks: [VelocityAccessibilityCheck.semanticLabel],
                violations: [],
                score: 1.0,
                complianceStatus: VelocityAccessibilityComplianceStatus.fullyCompliant,
              ));
      
      when(() => mockChecker.checkApp(any()))
          .thenAnswer((_) async => []);
      
      when(() => mockChecker.generateReport())
          .thenAnswer((_) async => {});
      
      when(() => mockChecker.getRecommendations(any()))
          .thenReturn([]);
      
      manager = VelocityAccessibilityManager.instance;
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
        final customConfig = VelocityAccessibilityConfig(
          enabled: false,
          textScaleFactor: 1.5,
          highContrast: true,
        );
        
        final config = VelocityAccessibilityManagerConfig(
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
        final newConfig = VelocityAccessibilityConfig(
          enabled: false,
          textScaleFactor: 2.0,
        );
        
        var configUpdated = false;
        VelocityAccessibilityConfig? receivedConfig;
        
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
        manager.enableFeature(VelocityAccessibilityFeature.screenReader);
        
        expect(manager.isFeatureEnabled(VelocityAccessibilityFeature.screenReader), isTrue);
      });

      test('should disable feature', () {
        manager.enableFeature(VelocityAccessibilityFeature.screenReader);
        manager.disableFeature(VelocityAccessibilityFeature.screenReader);
        
        expect(manager.isFeatureEnabled(VelocityAccessibilityFeature.screenReader), isFalse);
      });

      test('should check feature enabled state', () {
        expect(manager.isFeatureEnabled(VelocityAccessibilityFeature.screenReader), isFalse);
        
        manager.enableFeature(VelocityAccessibilityFeature.screenReader);
        expect(manager.isFeatureEnabled(VelocityAccessibilityFeature.screenReader), isTrue);
        
        manager.disableFeature(VelocityAccessibilityFeature.screenReader);
        expect(manager.isFeatureEnabled(VelocityAccessibilityFeature.screenReader), isFalse);
      });

      test('should reset to defaults', () {
        final originalConfig = manager.currentConfig;
        
        manager.updateConfig(VelocityAccessibilityConfig(
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
        expect(result.complianceStatus, equals(VelocityAccessibilityComplianceStatus.fullyCompliant));
      });

      test('should check app accessibility', () async {
        final context = MockBuildContext();
        final results = await manager.checkApp(context);
        
        expect(results, isA<List<VelocityAccessibilityTestResult>>());
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
        VelocityAccessibilityConfig? receivedConfig;
        
        manager.addConfigListener((config) {
          listenerCalled = true;
          receivedConfig = config;
        });
        
        final newConfig = VelocityAccessibilityConfig(
          enabled: false,
        );
        
        manager.updateConfig(newConfig);
        
        expect(listenerCalled, isTrue);
        expect(receivedConfig, equals(newConfig));
      });

      test('should remove config listener', () {
        var listenerCalled = false;
        
        void listener(VelocityAccessibilityConfig config) {
          listenerCalled = true;
        }
        
        manager.addConfigListener(listener);
        manager.removeConfigListener(listener);
        
        manager.updateConfig(VelocityAccessibilityConfig(
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
        expect(manager.currentConfig.enabledFeatures, contains(VelocityAccessibilityFeature.screenReader));
        expect(manager.currentConfig.enabledFeatures, contains(VelocityAccessibilityFeature.keyboardNavigation));
        expect(manager.currentConfig.disabledChecks, contains(VelocityAccessibilityCheck.semanticLabel));
        expect(manager.currentConfig.keyboardNavigationMode, equals(VelocityKeyboardNavigationMode.fullKeyboard));
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
        final accessibilityConfig = VelocityAccessibilityConfig(
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
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.screenReader));
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.keyboardNavigation));
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.highContrast));
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.textScaling));
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.colorBlind));
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.reduceMotion));
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.largeText));
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.voiceControl));
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.switchControl));
        expect(VelocityAccessibilityFeature.values, contains(VelocityAccessibilityFeature.fontAdjustment));
      });

      test('should have all required checks', () {
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.semanticLabel));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.focusManagement));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.keyboardNavigation));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.colorContrast));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.textReadability));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.interactiveElementSize));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.animationAccessibility));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.formLabels));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.errorMessage));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.stateChangeNotification));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.orientationAwareness));
        expect(VelocityAccessibilityCheck.values, contains(VelocityAccessibilityCheck.touchTargetSize));
      });

      test('should have all required compliance statuses', () {
        expect(VelocityAccessibilityComplianceStatus.values, contains(VelocityAccessibilityComplianceStatus.fullyCompliant));
        expect(VelocityAccessibilityComplianceStatus.values, contains(VelocityAccessibilityComplianceStatus.partiallyCompliant));
        expect(VelocityAccessibilityComplianceStatus.values, contains(VelocityAccessibilityComplianceStatus.nonCompliant));
        expect(VelocityAccessibilityComplianceStatus.values, contains(VelocityAccessibilityComplianceStatus.needsImprovement));
      });

      test('should have all required severity levels', () {
        expect(VelocityAccessibilitySeverity.values, contains(VelocityAccessibilitySeverity.minor));
        expect(VelocityAccessibilitySeverity.values, contains(VelocityAccessibilitySeverity.moderate));
        expect(VelocityAccessibilitySeverity.values, contains(VelocityAccessibilitySeverity.serious));
        expect(VelocityAccessibilitySeverity.values, contains(VelocityAccessibilitySeverity.blocker));
      });

      test('should have all required keyboard navigation modes', () {
        expect(VelocityKeyboardNavigationMode.values, contains(VelocityKeyboardNavigationMode.auto));
        expect(VelocityKeyboardNavigationMode.values, contains(VelocityKeyboardNavigationMode.tabOnly));
        expect(VelocityKeyboardNavigationMode.values, contains(VelocityKeyboardNavigationMode.directional));
        expect(VelocityKeyboardNavigationMode.values, contains(VelocityKeyboardNavigationMode.fullKeyboard));
      });
    });

    group('WCAG Standards', () {
      test('should have all required WCAG guidelines', () {
        expect(VelocityWCAGGuideline.values, contains(VelocityWCAGGuideline.perceivable));
        expect(VelocityWCAGGuideline.values, contains(VelocityWCAGGuideline.operable));
        expect(VelocityWCAGGuideline.values, contains(VelocityWCAGGuideline.understandable));
        expect(VelocityWCAGGuideline.values, contains(VelocityWCAGGuideline.robust));
      });

      test('should have all required WCAG levels', () {
        expect(VelocityWCAGLevel.values, contains(VelocityWCAGLevel.a));
        expect(VelocityWCAGLevel.values, contains(VelocityWCAGLevel.aa));
        expect(VelocityWCAGLevel.values, contains(VelocityWCAGLevel.aaa));
      });

      test('should have perceivable standards', () {
        expect(VelocityWCAGStandards.perceivableStandards, isNotEmpty);
        expect(VelocityWCAGStandards.perceivableStandards.length, greaterThan(0));
      });

      test('should have operable standards', () {
        expect(VelocityWCAGStandards.operableStandards, isNotEmpty);
        expect(VelocityWCAGStandards.operableStandards.length, greaterThan(0));
      });

      test('should have understandable standards', () {
        expect(VelocityWCAGStandards.understandableStandards, isNotEmpty);
        expect(VelocityWCAGStandards.understandableStandards.length, greaterThan(0));
      });

      test('should have robust standards', () {
        expect(VelocityWCAGStandards.robustStandards, isNotEmpty);
        expect(VelocityWCAGStandards.robustStandards.length, greaterThan(0));
      });

      test('should find standard by ID', () {
        final standard = VelocityWCAGStandards.findById('1.4.3');
        expect(standard, isNotNull);
        expect(standard!.id, equals('1.4.3'));
        expect(standard.level, equals(VelocityWCAGLevel.aa));
        expect(standard.guideline, equals(VelocityWCAGGuideline.perceivable));
      });

      test('should return null for non-existent standard ID', () {
        final standard = VelocityWCAGStandards.findById('non.existent');
        expect(standard, isNull);
      });
    });

    group('Semantic Data', () {
      test('should create semantic data with default values', () {
        final semanticData = VelocitySemanticData();
        
        expect(semanticData.label, isNull);
        expect(semanticData.hint, isNull);
        expect(semanticData.value, isNull);
        expect(semanticData.checked, isNull);
        expect(semanticData.selected, isNull);
        expect(semanticData.disabled, isNull);
      });

      test('should create semantic data with custom values', () {
        final semanticData = VelocitySemanticData(
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
        final semanticData = VelocitySemanticData(
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
        final violation = VelocityAccessibilityViolation(
          check: VelocityAccessibilityCheck.semanticLabel,
          severity: VelocityAccessibilitySeverity.serious,
          message: 'Missing semantic label',
        );
        
        expect(violation.check, equals(VelocityAccessibilityCheck.semanticLabel));
        expect(violation.severity, equals(VelocityAccessibilitySeverity.serious));
        expect(violation.message, equals('Missing semantic label'));
      });

      test('should create violation with all fields', () {
        final criterion = VelocityWCAGStandards.findById('1.3.1')!;
        final violation = VelocityAccessibilityViolation(
          check: VelocityAccessibilityCheck.semanticLabel,
          criterion: criterion,
          severity: VelocityAccessibilitySeverity.serious,
          message: 'Missing semantic label',
          fixSuggestion: 'Add semantic label to the element',
          affectedElement: 'Button',
          location: {'x': 100, 'y': 200},
        );
        
        expect(violation.check, equals(VelocityAccessibilityCheck.semanticLabel));
        expect(violation.criterion, equals(criterion));
        expect(violation.severity, equals(VelocityAccessibilitySeverity.serious));
        expect(violation.message, equals('Missing semantic label'));
        expect(violation.fixSuggestion, equals('Add semantic label to the element'));
        expect(violation.affectedElement, equals('Button'));
        expect(violation.location, equals({'x': 100, 'y': 200}));
      });

      test('should convert violation to JSON', () {
        final violation = VelocityAccessibilityViolation(
          check: VelocityAccessibilityCheck.semanticLabel,
          severity: VelocityAccessibilitySeverity.serious,
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
        final result = VelocityAccessibilityTestResult(
          testedAt: DateTime.now(),
          component: 'TestComponent',
          passedChecks: [VelocityAccessibilityCheck.semanticLabel],
          violations: [],
          score: 1.0,
          complianceStatus: VelocityAccessibilityComplianceStatus.fullyCompliant,
        );
        
        expect(result.component, equals('TestComponent'));
        expect(result.passedChecks, contains(VelocityAccessibilityCheck.semanticLabel));
        expect(result.violations, isEmpty);
        expect(result.score, equals(1.0));
        expect(result.complianceStatus, equals(VelocityAccessibilityComplianceStatus.fullyCompliant));
      });

      test('should convert test result to JSON', () {
        final result = VelocityAccessibilityTestResult(
          testedAt: DateTime(2023, 1, 1),
          component: 'TestComponent',
          passedChecks: [VelocityAccessibilityCheck.semanticLabel],
          violations: [],
          score: 1.0,
          complianceStatus: VelocityAccessibilityComplianceStatus.fullyCompliant,
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