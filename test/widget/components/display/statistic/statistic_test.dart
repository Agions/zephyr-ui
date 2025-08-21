import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrStatistic', () {
    testWidgets('renders statistic with basic content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrStatistic(
              title: '总收入',
              value: '¥125,430',
            ),
          ),
        ),
      );

      expect(find.text('总收入'), findsOneWidget);
      expect(find.text('¥125,430'), findsOneWidget);
    });

    testWidgets('renders with description and trend', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrStatistic(
              title: '总收入',
              value: '¥125,430',
              description: '较上月增长',
              trendValue: '12.5%',
              trend: ZephyrStatisticTrend.up,
            ),
          ),
        ),
      );

      expect(find.text('总收入'), findsOneWidget);
      expect(find.text('¥125,430'), findsOneWidget);
      expect(find.text('较上月增长'), findsOneWidget);
      expect(find.text('12.5%'), findsOneWidget);
    });

    testWidgets('supports different types', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ZephyrStatistic(
                  title: 'Primary',
                  value: '100',
                  type: ZephyrStatisticType.primary,
                ),
                ZephyrStatistic(
                  title: 'Success',
                  value: '200',
                  type: ZephyrStatisticType.success,
                ),
                ZephyrStatistic(
                  title: 'Warning',
                  value: '300',
                  type: ZephyrStatisticType.warning,
                ),
                ZephyrStatistic(
                  title: 'Error',
                  value: '400',
                  type: ZephyrStatisticType.error,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Success'), findsOneWidget);
      expect(find.text('Warning'), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('handles tap callback', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ZephyrStatistic(
                title: 'Test',
                value: '100',
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        ),
      );

      // Wait for animation to complete
      await tester.pumpAndSettle();

      final gesture = await tester.startGesture(tester.getCenter(find.byType(ZephyrStatistic)));
      await gesture.up();
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('shows loading overlay', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrStatistic(
              title: 'Test',
              value: '100',
              loading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides icon when showIcon is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrStatistic(
              title: 'Test',
              value: '100',
              showIcon: false,
            ),
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('hides trend when showTrend is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZephyrStatistic(
              title: 'Test',
              value: '100',
              trendValue: '12.5%',
              trend: ZephyrStatisticTrend.up,
              showTrend: false,
            ),
          ),
        ),
      );

      expect(find.text('12.5%'), findsNothing);
    });

    testWidgets('applies custom theme', (WidgetTester tester) async {
      final customTheme = ZephyrStatisticTheme.custom(
        primaryColor: Colors.red,
        titleStyle: const TextStyle(fontSize: 20),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrStatistic(
              title: 'Test',
              value: '100',
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });
  });

  group('ZephyrStatisticGroup', () {
    testWidgets('renders multiple statistics in grid', (WidgetTester tester) async {
      final statistics = [
        const ZephyrStatistic(
          title: 'Stat 1',
          value: '100',
        ),
        const ZephyrStatistic(
          title: 'Stat 2',
          value: '200',
        ),
        const ZephyrStatistic(
          title: 'Stat 3',
          value: '300',
        ),
        const ZephyrStatistic(
          title: 'Stat 4',
          value: '400',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrStatisticGroup(
              statistics: statistics,
            ),
          ),
        ),
      );

      expect(find.text('Stat 1'), findsOneWidget);
      expect(find.text('Stat 2'), findsOneWidget);
      expect(find.text('Stat 3'), findsOneWidget);
      expect(find.text('Stat 4'), findsOneWidget);
    });
  });

  group('ZephyrStatisticTheme', () {
    test('creates light theme', () {
      final theme = ZephyrStatisticTheme.light();
      expect(theme.backgroundColor, equals(Colors.white));
      expect(theme.primaryColor, equals(const Color(0xFF3B82F6)));
    });

    test('creates dark theme', () {
      final theme = ZephyrStatisticTheme.dark();
      expect(theme.backgroundColor, equals(const Color(0xFF1F2937)));
      expect(theme.primaryColor, equals(const Color(0xFF60A5FA)));
    });

    test('creates custom theme', () {
      final theme = ZephyrStatisticTheme.custom(
        primaryColor: Colors.red,
        titleStyle: const TextStyle(fontSize: 20),
      );
      expect(theme.primaryColor, equals(Colors.red));
      expect(theme.titleStyle.fontSize, equals(20));
    });

    test('copies theme with modifications', () {
      final theme = ZephyrStatisticTheme.light();
      final modified = theme.copyWith(primaryColor: Colors.blue);
      expect(modified.primaryColor, equals(Colors.blue));
      expect(modified.backgroundColor, equals(theme.backgroundColor));
    });

    test('merges themes', () {
      final theme1 = ZephyrStatisticTheme.light();
      final theme2 = ZephyrStatisticTheme.custom(primaryColor: Colors.red);
      final merged = theme1.merge(theme2);
      expect(merged.primaryColor, equals(Colors.red));
      expect(merged.backgroundColor, equals(theme1.backgroundColor));
    });

    test('compares themes for equality', () {
      final theme1 = ZephyrStatisticTheme.light();
      final theme2 = ZephyrStatisticTheme.light();
      expect(theme1, equals(theme2));
    });

    test('computes hash code', () {
      final theme = ZephyrStatisticTheme.light();
      expect(theme.hashCode, isA<int>());
    });
  });

  group('ZephyrStatisticData', () {
    test('creates data with required parameters', () {
      const data = ZephyrStatisticData(
        title: 'Test Statistic',
        value: '100',
      );
      expect(data.title, equals('Test Statistic'));
      expect(data.value, equals('100'));
      expect(data.description, isNull);
      expect(data.trendValue, isNull);
      expect(data.trend, isNull);
    });

    test('creates data with all parameters', () {
      const data = ZephyrStatisticData(
        title: 'Test Statistic',
        value: '100',
        description: 'Test Description',
        trendValue: '12.5%',
        trend: ZephyrStatisticTrend.up,
        icon: Icon(Icons.trending_up),
      );
      expect(data.title, equals('Test Statistic'));
      expect(data.value, equals('100'));
      expect(data.description, equals('Test Description'));
      expect(data.trendValue, equals('12.5%'));
      expect(data.trend, equals(ZephyrStatisticTrend.up));
      expect(data.icon, isNotNull);
    });
  });
}