/// VelocityUI 性能优化测试
///
/// 全面测试所有性能优化功能
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  group('VelocityUI Performance Optimization Tests', () {
    late VelocityEnhancedPerformanceMonitor performanceMonitor;
    late VelocityMemoryOptimizer memoryOptimizer;
    late VelocityBuildOptimizer buildOptimizer;
    late VelocityLazyComponentLoader lazyLoader;

    setUp(() {
      performanceMonitor = VelocityEnhancedPerformanceMonitor.instance;
      memoryOptimizer = VelocityMemoryOptimizer.instance;
      buildOptimizer = VelocityBuildOptimizer.instance;
      lazyLoader = VelocityLazyComponentLoader.instance;
    });

    tearDown(() {
      performanceMonitor.stopMonitoring();
      memoryOptimizer.stopMonitoring();
      buildOptimizer.stopMonitoring();
    });

    group('Theme Optimization', () {
      test('Theme data builder creates correct theme', () {
        final theme = VelocityThemeDataBuilder()
            .brightness(Brightness.light)
            .primaryColor(Colors.blue)
            .spacing(16.0)
            .build();

        expect(theme.brightness, Brightness.light);
        expect(theme.primaryColor, Colors.blue);
        expect(theme.spacing, 16.0);
      });

      test('Optimized theme data with caching', () {
        final theme1 = VelocityOptimizedThemeData.light();
        final theme2 = VelocityOptimizedThemeData.light();

        expect(theme1, same(theme2)); // Should be same instance due to caching
      });

      test('Theme config with variants', () {
        final config = VelocityOptimizedThemeConfig.instance;
        
        final enterpriseTheme = config.getThemeConfig(
          brightness: Brightness.light,
          variant: 'enterprise',
        );
        
        expect(enterpriseTheme.brightness, Brightness.light);
      });

      test('Theme cache statistics', () {
        final config = VelocityOptimizedThemeConfig.instance;
        
        // Generate some cache activity
        config.getThemeConfig(brightness: Brightness.light);
        config.getThemeConfig(brightness: Brightness.dark);
        
        final stats = config.getCacheStats();
        expect(stats['cacheSize'], greaterThanOrEqualTo(2));
        expect(stats['totalRequests'], greaterThanOrEqualTo(2));
      });
    });

    group('Memory Optimization', () {
      test('Memory optimizer starts and stops monitoring', () {
        expect(() => memoryOptimizer.startMonitoring(), returnsNormally);
        expect(() => memoryOptimizer.stopMonitoring(), returnsNormally);
      });

      test('Memory cache operations', () {
        memoryOptimizer.addToCache('test_key', 'test_value', sizeKB: 1);
        
        final cachedValue = memoryOptimizer.getFromCache('test_key');
        expect(cachedValue, 'test_value');
      });

      test('Memory usage statistics', () {
        final stats = memoryOptimizer.getCurrentStats();
        
        expect(stats.currentUsageMB, greaterThanOrEqualTo(0));
        expect(stats.garbageCollectionCount, greaterThanOrEqualTo(0));
        expect(stats.cacheEvictions, greaterThanOrEqualTo(0));
      });

      test('Memory optimization strategies', () {
        memoryOptimizer.configure(
          strategy: MemoryOptimizationStrategy.aggressive,
          memoryThresholdMB: 100.0,
        );
        
        final report = memoryOptimizer.getDetailedReport();
        expect(report['optimization']['strategy'], 'MemoryOptimizationStrategy.aggressive');
      });
    });

    group('Build Optimization', () {
      test('Build timer operations', () {
        buildOptimizer.startBuildTimer('test_build');
        
        // Simulate some work
        Future.delayed(const Duration(milliseconds: 100));
        
        final duration = buildOptimizer.stopBuildTimer('test_build');
        expect(duration.inMilliseconds, greaterThanOrEqualTo(0));
      });

      test('Build cache operations', () {
        buildOptimizer.addToBuildCache('test_build_key', 'test_value');
        
        final cachedValue = buildOptimizer.getFromBuildCache('test_build_key');
        expect(cachedValue, 'test_value');
      });

      test('Build statistics recording', () {
        buildOptimizer.recordBuildStats(
          totalTime: const Duration(milliseconds: 1500),
          widgetCount: 50,
          rebuildCount: 20,
          cacheHits: 30,
          cacheMisses: 10,
        );
        
        final stats = buildOptimizer.getLatestBuildStats();
        expect(stats, isNotNull);
        expect(stats!.totalTime.inMilliseconds, 1500);
        expect(stats.widgetCount, 50);
        expect(stats.cacheHitRate, 0.75);
      });

      test('Build performance report', () {
        buildOptimizer.recordBuildStats(
          totalTime: const Duration(milliseconds: 2000),
          widgetCount: 100,
          rebuildCount: 30,
          cacheHits: 40,
          cacheMisses: 10,
        );
        
        final report = buildOptimizer.getBuildPerformanceReport();
        expect(report['latestBuild']['timeMs'], 2000);
        expect(report['performance']['buildCount'], 1);
      });
    });

    group('Lazy Loading', () {
      test('Component registration', () {
        lazyLoader.registerComponent(
          name: 'test_component',
          path: 'lib/test/test_component.dart',
          estimatedSizeKB: 50,
          priority: ComponentPriority.medium,
        );
        
        final state = lazyLoader.getComponentState('test_component');
        expect(state, ComponentLoadState.notLoaded);
      });

      test('Component loading simulation', () async {
        lazyLoader.registerComponent(
          name: 'async_component',
          path: 'lib/test/async_component.dart',
          estimatedSizeKB: 100,
          priority: ComponentPriority.high,
        );
        
        final component = await lazyLoader.loadComponent('async_component');
        expect(component, isNotNull);
        
        final state = lazyLoader.getComponentState('async_component');
        expect(state, ComponentLoadState.loaded);
      });

      test('Lazy loader statistics', () {
        lazyLoader.registerComponent(
          name: 'stats_component',
          path: 'lib/test/stats_component.dart',
          estimatedSizeKB: 75,
          priority: ComponentPriority.low,
        );
        
        final stats = lazyLoader.getStats();
        expect(stats['registeredComponents'], greaterThanOrEqualTo(1));
      });
    });

    group('Performance Monitoring', () {
      test('Performance monitor starts and stops', () {
        expect(() => performanceMonitor.startMonitoring(), returnsNormally);
        expect(() => performanceMonitor.stopMonitoring(), returnsNormally);
      });

      test('Custom metric recording', () {
        performanceMonitor.recordMetric(
          'custom_metric',
          42.0,
          type: PerformanceMetricType.custom,
        );
        
        final report = performanceMonitor.getPerformanceReport();
        expect(report.metrics['custom_metric'], isNotNull);
      });

      test('Performance thresholds', () {
        final budget = PerformanceBudget();
        
        expect(budget.exceedsBudget('frameTime', 20.0), true);
        expect(budget.exceedsBudget('frameTime', 10.0), false);
      });
    });

    group('Integration Tests', () {
      testWidgets('Performance overlay widget test', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: VelocityPerformanceOverlay(
              enabled: true,
              level: PerformanceLevel.medium,
              child: Container(),
            ),
          ),
        );
        
        expect(find.byType(VelocityPerformanceOverlay), findsOneWidget);
      });

      testWidgets('Memory monitor widget test', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: VelocityMemoryMonitor(
              enabled: true,
              strategy: MemoryOptimizationStrategy.balanced,
              child: Container(),
            ),
          ),
        );
        
        expect(find.byType(VelocityMemoryMonitor), findsOneWidget);
      });

      testWidgets('Build timer widget test', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: VelocityBuildTimer(
              name: 'test_widget',
              enabled: true,
              child: Container(),
            ),
          ),
        );
        
        expect(find.byType(VelocityBuildTimer), findsOneWidget);
      });

      testWidgets('Lazy component widget test', (WidgetTester tester) async {
        lazyLoader.registerComponent(
          name: 'lazy_test_component',
          path: 'lib/test/lazy_test_component.dart',
          estimatedSizeKB: 25,
          priority: ComponentPriority.medium,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityLazyComponent(
              componentName: 'lazy_test_component',
              placeholder: const CircularProgressIndicator(),
              errorWidget: const Text('Error'),
            ),
          ),
        );
        
        expect(find.byType(VelocityLazyComponent), findsOneWidget);
      });
    });

    group('Performance Benchmarks', () {
      test('Theme creation benchmark', () {
        final stopwatch = Stopwatch()..start();
        
        for (var i = 0; i < 100; i++) {
          VelocityOptimizedThemeData.light();
        }
        
        stopwatch.stop();
        final avgTime = stopwatch.elapsedMilliseconds / 100;
        
        print('Average theme creation time: ${avgTime.toStringAsFixed(2)}ms');
        expect(avgTime, lessThan(10)); // Should be fast due to caching
      });

      test('Memory operations benchmark', () {
        final stopwatch = Stopwatch()..start();
        
        for (var i = 0; i < 1000; i++) {
          memoryOptimizer.addToCache('key_$i', 'value_$i');
          memoryOptimizer.getFromCache('key_$i');
        }
        
        stopwatch.stop();
        final avgTime = stopwatch.elapsedMilliseconds / 1000;
        
        print('Average memory operation time: ${avgTime.toStringAsFixed(2)}ms');
        expect(avgTime, lessThan(1)); // Should be very fast
      });

      test('Build cache benchmark', () {
        final stopwatch = Stopwatch()..start();
        
        for (var i = 0; i < 500; i++) {
          buildOptimizer.addToBuildCache('build_key_$i', 'build_value_$i');
          buildOptimizer.getFromBuildCache('build_key_$i');
        }
        
        stopwatch.stop();
        final avgTime = stopwatch.elapsedMilliseconds / 500;
        
        print('Average build cache operation time: ${avgTime.toStringAsFixed(2)}ms');
        expect(avgTime, lessThan(1)); // Should be very fast
      });
    });

    group('Error Handling', () {
      test('Invalid component name handling', () async {
        expect(
          () async => await lazyLoader.loadComponent('invalid_component'),
          throwsA(isA<Exception>()),
        );
      });

      test('Memory optimizer configuration validation', () {
        expect(
          () => memoryOptimizer.configure(memoryThresholdMB: -1),
          returnsNormally,
        ); // Should handle invalid values gracefully
      });

      test('Performance monitor with invalid metrics', () {
        expect(
          () => performanceMonitor.recordMetric('test', -1.0),
          returnsNormally,
        ); // Should handle negative values
      });
    });

    group('Resource Cleanup', () {
      test('Memory optimizer cleanup', () {
        memoryOptimizer.addToCache('cleanup_test', 'test_value');
        memoryOptimizer.clearCache();
        
        final value = memoryOptimizer.getFromCache('cleanup_test');
        expect(value, isNull);
      });

      test('Build optimizer cleanup', () {
        buildOptimizer.addToBuildCache('cleanup_build_test', 'test_value');
        buildOptimizer.clearAllData();
        
        final value = buildOptimizer.getFromBuildCache('cleanup_build_test');
        expect(value, isNull);
      });

      test('Lazy loader cleanup', () {
        lazyLoader.registerComponent(
          name: 'cleanup_lazy_test',
          path: 'lib/test/cleanup_test.dart',
        );
        
        lazyLoader.clearCache();
        final state = lazyLoader.getComponentState('cleanup_lazy_test');
        expect(state, ComponentLoadState.notLoaded);
      });
    });
  });
}