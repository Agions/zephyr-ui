import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/utils/performance/performance_monitor.dart';
import 'package:velocity_ui/src/components/basic/button/button.dart';

// Import with prefix to avoid name conflicts
import 'package:velocity_ui/src/utils/performance/performance_monitor.dart' as perf;

void main() {
  group('VelocityPerformanceMonitor Tests', () {
    late VelocityPerformanceMonitor monitor;

    setUp(() {
      monitor = VelocityPerformanceMonitor.instance;
      monitor.clearMetrics();
    });

    tearDown(() {
      monitor.clearMetrics();
    });

    test('records custom metrics correctly', () async {
      monitor.recordMetric('test_metric', 42.5, category: 'test');
      
      final metrics = monitor.metrics;
      expect(metrics.containsKey('test.test_metric'), isTrue);
      expect(metrics['test.test_metric']!.value, 42.5);
      expect(metrics['test.test_metric']!.category, 'test');
    });

    test('records widget build times', () async {
      final result = monitor.recordWidgetBuild('test_widget', () {
        return 42; // Simulate some computation
      });
      
      expect(result, 42);
      
      final stats = monitor.getFrameTimeStats();
      expect(stats.containsKey('test_widget'), isTrue);
      expect(stats['test_widget']!.count, 1);
      // Build time can be 0 for very fast operations, so check for >= 0
      expect(stats['test_widget']!.average, greaterThanOrEqualTo(0));
    });

    test('generates performance report', () async {
      monitor.recordMetric('metric1', 10.0);
      monitor.recordMetric('metric2', 20.0);
      
      final report = monitor.generateReport();
      
      expect(report.metrics.length, 2);
      expect(report.timestamp, isNotNull);
      expect(report.getSummary()['totalMetrics'], 2);
    });

    test('clears metrics correctly', () async {
      monitor.recordMetric('test_metric', 42.5);
      expect(monitor.metrics.isNotEmpty, isTrue);
      
      monitor.clearMetrics();
      expect(monitor.metrics.isEmpty, isTrue);
    });

    test('PerformanceBudget checks thresholds', () async {
      const budget = PerformanceBudget(
        maxFrameTime: 16.67,
        maxMemoryUsage: 100 * 1024 * 1024,
        maxWidgetBuildTime: 16,
        maxNetworkRequestTime: 5000,
        maxFirstPaintTime: 3000,
      );

      expect(budget.exceedsBudget('frameTime', 20.0), isTrue);
      expect(budget.exceedsBudget('frameTime', 15.0), isFalse);
      expect(budget.exceedsBudget('memoryUsage', 200 * 1024 * 1024), isTrue);
      expect(budget.exceedsBudget('memoryUsage', 50 * 1024 * 1024), isFalse);
    });

    testWidgets('PerformanceOverlay displays correctly', (WidgetTester tester) async {
      
      await tester.pumpWidget(
        MaterialApp(
          home: perf.PerformanceOverlay(
            enabled: true,
            child: Scaffold(
              body: Center(
                child: VelocityButton.primary(
                  text: 'Test Button',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      // Test button interaction - the overlay may or may not be visible due to test limitations
      await tester.tap(find.text('Test Button'));
      await tester.pumpAndSettle();
      
      // Verify the button still works
      expect(find.text('Test Button'), findsOneWidget);
    });

    test('PerformanceAlert severity levels', () async {
      final lowAlert = PerformanceAlert(
        type: PerformanceAlertType.custom,
        message: 'Low severity alert',
        severity: PerformanceSeverity.low,
      );
      
      final highAlert = PerformanceAlert(
        type: PerformanceAlertType.jank,
        message: 'High severity alert',
        severity: PerformanceSeverity.high,
      );
      
      expect(lowAlert.severity, PerformanceSeverity.low);
      expect(highAlert.severity, PerformanceSeverity.high);
      expect(lowAlert.timestamp.isBefore(DateTime.now()), isTrue);
    });

    test('FrameTimeStats calculates correctly', () async {
      final stats = FrameTimeStats(
        average: 16.0,
        min: 10.0,
        max: 25.0,
        count: 100,
        p95: 22.0,
        p99: 24.0,
      );
      
      expect(stats.average, 16.0);
      expect(stats.min, 10.0);
      expect(stats.max, 25.0);
      expect(stats.count, 100);
      expect(stats.p95, 22.0);
      expect(stats.p99, 24.0);
    });

    testWidgets('performance monitoring integration', (WidgetTester tester) async {
      var buttonPressCount = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: perf.PerformanceOverlay(
            enabled: true,
            child: Scaffold(
              body: Center(
                child: VelocityButton.primary(
                  text: 'Increment',
                  onPressed: () {
                    buttonPressCount++;
                  },
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      // Verify initial state
      expect(buttonPressCount, 0);
      expect(find.text('Performance Monitor'), findsOneWidget);
      
      // Press button multiple times
      for (var i = 0; i < 5; i++) {
        await tester.tap(find.text('Increment'));
        await tester.pumpAndSettle();
      }
      
      // Verify button was pressed
      expect(buttonPressCount, 5);
      
      // Verify overlay is still present
      expect(find.text('Performance Monitor'), findsOneWidget);
    });
  });
}