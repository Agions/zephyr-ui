import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/feedback/tour/tour.dart';
import 'package:zephyr_ui/src/components/feedback/tour/tour_theme.dart';

void main() {
  group('ZephyrTour', () {
    late List<ZephyrTourStep> sampleSteps;
    late GlobalKey targetKey;

    setUp(() {
      targetKey = GlobalKey();
      sampleSteps = [
        ZephyrTourStep(
          id: 'step1',
          title: 'Welcome',
          content: 'Welcome to our app!',
          order: 0,
        ),
        ZephyrTourStep(
          id: 'step2',
          title: 'Features',
          content: 'Check out our features',
          order: 1,
          targetKey: targetKey,
        ),
        ZephyrTourStep(
          id: 'step3',
          title: 'Complete',
          content: 'Tour completed!',
          order: 2,
        ),
      ];
    });

    testWidgets('should create tour with steps', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(key: targetKey, child: Text('Target')),
                ZephyrTour(
                  steps: sampleSteps,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrTour), findsOneWidget);
    });

    testWidgets('should auto start tour when enabled', (WidgetTester tester) async {
      bool tourStarted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(key: targetKey, child: Text('Target')),
                ZephyrTour(
                  steps: sampleSteps,
                  autoStart: true,
                  onTourStart: () {
                    tourStarted = true;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(tourStarted, isTrue);
    });

    testWidgets('should show tour overlay when active', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(key: targetKey, child: Text('Target')),
                ZephyrTour(
                  steps: sampleSteps,
                  autoStart: true,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should show overlay with tour content
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Welcome to our app!'), findsOneWidget);
    });

    testWidgets('should navigate between steps', (WidgetTester tester) async {
      int stepChangeCount = 0;
      String? currentStepId;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(key: targetKey, child: Text('Target')),
                ZephyrTour(
                  steps: sampleSteps,
                  autoStart: true,
                  onStepChange: (step) {
                    stepChangeCount++;
                    currentStepId = step.id;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Click next button
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(stepChangeCount, equals(2)); // Initial + first change
      expect(currentStepId, equals('step2'));
      expect(find.text('Features'), findsOneWidget);
    });

    testWidgets('should complete tour', (WidgetTester tester) async {
      bool tourCompleted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(key: targetKey, child: Text('Target')),
                ZephyrTour(
                  steps: sampleSteps,
                  autoStart: true,
                  onTourComplete: () {
                    tourCompleted = true;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Navigate to last step
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      // Complete tour
      await tester.tap(find.text('Complete'));
      await tester.pumpAndSettle();

      expect(tourCompleted, isTrue);
    });

    testWidgets('should skip tour', (WidgetTester tester) async {
      bool tourSkipped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(key: targetKey, child: Text('Target')),
                ZephyrTour(
                  steps: sampleSteps,
                  autoStart: true,
                  onTourSkip: () {
                    tourSkipped = true;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Skip tour
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(tourSkipped, isTrue);
    });

    testWidgets('should show progress indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(key: targetKey, child: Text('Target')),
                ZephyrTour(
                  steps: sampleSteps,
                  autoStart: true,
                  showProgress: true,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('should show step numbers', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(key: targetKey, child: Text('Target')),
                ZephyrTour(
                  steps: sampleSteps,
                  autoStart: true,
                  showStepNumbers: true,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('1 / 3'), findsOneWidget);
    });

    testWidgets('should respect allowSkip setting', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(key: targetKey, child: Text('Target')),
                ZephyrTour(
                  steps: sampleSteps,
                  autoStart: true,
                  allowSkip: false,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Skip'), findsNothing);
    });
  });

  group('ZephyrTourStep', () {
    test('should create step with required parameters', () {
      final step = ZephyrTourStep(
        id: 'test',
        title: 'Test Step',
        content: 'Test Content',
      );

      expect(step.id, equals('test'));
      expect(step.title, equals('Test Step'));
      expect(step.content, equals('Test Content'));
      expect(step.order, equals(0));
      expect(step.isOptional, isFalse);
    });

    test('should copy step with modifications', () {
      final step = ZephyrTourStep(
        id: 'test',
        title: 'Test Step',
        content: 'Test Content',
      );

      final modifiedStep = step.copyWith(
        title: 'Modified Title',
        content: 'Modified Content',
      );

      expect(modifiedStep.id, equals('test'));
      expect(modifiedStep.title, equals('Modified Title'));
      expect(modifiedStep.content, equals('Modified Content'));
    });

    test('should handle optional parameters', () {
      final step = ZephyrTourStep(
        id: 'test',
        title: 'Test Step',
        content: 'Test Content',
        isOptional: true,
        order: 5,
        nextStepId: 'next',
        previousStepId: 'previous',
        metadata: {'key': 'value'},
      );

      expect(step.isOptional, isTrue);
      expect(step.order, equals(5));
      expect(step.nextStepId, equals('next'));
      expect(step.previousStepId, equals('previous'));
      expect(step.metadata, equals({'key': 'value'}));
    });
  });

  group('ZephyrTourController', () {
    late List<ZephyrTourStep> sampleSteps;
    late ZephyrTourController controller;

    setUp(() {
      sampleSteps = [
        ZephyrTourStep(id: '1', title: 'Step 1', content: 'Content 1'),
        ZephyrTourStep(id: '2', title: 'Step 2', content: 'Content 2'),
        ZephyrTourStep(id: '3', title: 'Step 3', content: 'Content 3'),
      ];
      controller = ZephyrTourController(sampleSteps);
    });

    test('should start tour', () {
      controller.startTour();
      expect(controller.isTourActive, isTrue);
      expect(controller.currentStepIndex, equals(0));
    });

    test('should navigate next step', () {
      controller.startTour();
      controller.nextStep();
      expect(controller.currentStepIndex, equals(1));
    });

    test('should navigate previous step', () {
      controller.startTour();
      controller.nextStep();
      controller.previousStep();
      expect(controller.currentStepIndex, equals(0));
    });

    test('should not go beyond bounds', () {
      controller.startTour();
      controller.previousStep(); // Should stay at 0
      expect(controller.currentStepIndex, equals(0));

      controller.currentStepIndex = 2;
      controller.nextStep(); // Should stay at 2
      expect(controller.currentStepIndex, equals(2));
    });

    test('should go to specific step', () {
      controller.startTour();
      controller.goToStep(2);
      expect(controller.currentStepIndex, equals(2));
    });

    test('should get current step', () {
      controller.startTour();
      final currentStep = controller.currentStep;
      expect(currentStep, isNotNull);
      expect(currentStep!.id, equals('1'));
    });

    test('should return null for invalid current step', () {
      controller.currentStepIndex = 10;
      final currentStep = controller.currentStep;
      expect(currentStep, isNull);
    });
  });

  group('ZephyrTourTheme', () {
    test('should create light theme', () {
      final theme = ZephyrTourTheme.light();
      expect(theme.headerColor, equals(const Color(0xFF2196F3)));
      expect(theme.backgroundColor, equals(Colors.white));
    });

    test('should create dark theme', () {
      final theme = ZephyrTourTheme.dark();
      expect(theme.headerColor, equals(const Color(0xFF1976D2)));
      expect(theme.backgroundColor, equals(const Color(0xFF1E1E1E)));
    });

    test('should copy theme with modifications', () {
      final theme = ZephyrTourTheme.light();
      final modifiedTheme = theme.copyWith(
        headerColor: Colors.red,
        backgroundColor: Colors.green,
      );

      expect(modifiedTheme.headerColor, equals(Colors.red));
      expect(modifiedTheme.backgroundColor, equals(Colors.green));
      expect(modifiedTheme.elevation, equals(theme.elevation));
    });

    test('should have default button text', () {
      final theme = ZephyrTourTheme.light();
      expect(theme.nextButtonText, equals('Next'));
      expect(theme.previousButtonText, equals('Previous'));
      expect(theme.skipButtonText, equals('Skip'));
      expect(theme.completeButtonText, equals('Complete'));
    });
  });

  group('ZephyrTourPersistence', () {
    test('should have none mode', () {
      expect(ZephyrTourPersistence.none, isNotNull);
    });

    test('should have sharedPreferences mode', () {
      expect(ZephyrTourPersistence.sharedPreferences, isNotNull);
    });

    test('should have memory mode', () {
      expect(ZephyrTourPersistence.memory, isNotNull);
    });
  });
}