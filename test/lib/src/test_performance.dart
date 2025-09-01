/// 测试性能工具
///
/// 提供性能测试相关的工具和方法
library test_performance;

import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math' as math;
import 'dart:convert' as json;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

/// 性能测试工具类
class PerformanceTestUtils {
  /// 测量组件构建时间
  static Future<Duration> measureBuildTime(
    WidgetTester tester,
    Widget widget, {
    int warmUpCount = 5,
    int measureCount = 10,
  }) async {
    // 预热
    for (int i = 0; i < warmUpCount; i++) {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    }
    
    // 测量
    final stopwatch = Stopwatch()..start();
    for (int i = 0; i < measureCount; i++) {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    }
    stopwatch.stop();
    
    return Duration(microseconds: stopwatch.elapsedMicroseconds ~/ measureCount);
  }
  
  /// 测量组件布局时间
  static Future<Duration> measureLayoutTime(
    WidgetTester tester,
    Widget widget, {
    int warmUpCount = 5,
    int measureCount = 10,
  }) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    
    // 预热
    for (int i = 0; i < warmUpCount; i++) {
      await tester.binding.reassembleApplication();
      await tester.pumpAndSettle();
    }
    
    // 测量
    final stopwatch = Stopwatch()..start();
    for (int i = 0; i < measureCount; i++) {
      await tester.binding.reassembleApplication();
      await tester.pumpAndSettle();
    }
    stopwatch.stop();
    
    return Duration(microseconds: stopwatch.elapsedMicroseconds ~/ measureCount);
  }
  
  /// 测量组件绘制时间
  static Future<Duration> measurePaintTime(
    WidgetTester tester,
    Widget widget, {
    int warmUpCount = 5,
    int measureCount = 10,
  }) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    
    // 预热
    for (int i = 0; i < warmUpCount; i++) {
      await tester.binding.reassembleApplication();
      await tester.pumpAndSettle();
    }
    
    // 测量
    final stopwatch = Stopwatch()..start();
    for (int i = 0; i < measureCount; i++) {
      await tester.binding.reassembleApplication();
      await tester.pumpAndSettle();
    }
    stopwatch.stop();
    
    return Duration(microseconds: stopwatch.elapsedMicroseconds ~/ measureCount);
  }
  
  /// 测量内存使用
  static Future<Map<String, dynamic>> measureMemoryUsage(
    WidgetTester tester,
    Widget widget, {
    int warmUpCount = 5,
  }) async {
    // 预热
    for (int i = 0; i < warmUpCount; i++) {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    }
    
    // 强制垃圾回收
    await tester.binding.reassembleApplication();
    
    // 测量内存
    final memoryBefore = developer.Service.getInfo().memory!;
    
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    
    final memoryAfter = developer.Service.getInfo().memory!;
    
    return {
      'memoryBefore': memoryBefore,
      'memoryAfter': memoryAfter,
      'memoryDifference': memoryAfter - memoryBefore,
    };
  }
  
  /// 测量帧率
  static Future<double> measureFrameRate(
    WidgetTester tester,
    Widget widget, {
    Duration duration = const Duration(seconds: 5),
  }) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    
    final frameCount = <int>[];
    final subscription = tester.binding.addTimingsCallback((timings) {
      frameCount.add(timings.length);
    });
    
    await Future.delayed(duration);
    
    subscription.cancel();
    
    return frameCount.fold<int>(0, (sum, count) => sum + count) / frameCount.length;
  }
  
  /// 测量组件重建次数
  static Future<int> measureRebuildCount(
    WidgetTester tester,
    Widget widget, {
    Duration duration = const Duration(seconds: 2),
  }) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    
    int rebuildCount = 0;
    final subscription = tester.binding.addPostFrameCallback((_) {
      rebuildCount++;
    });
    
    await Future.delayed(duration);
    
    subscription.cancel();
    
    return rebuildCount;
  }
  
  /// 性能基准测试
  static Future<void> runPerformanceBenchmark(
    WidgetTester tester,
    String testName,
    Widget Function() widgetBuilder, {
    Duration? timeout,
    int warmUpCount = 5,
    int measureCount = 10,
    Map<String, dynamic>? expectedResults,
  }) async {
    final widget = widgetBuilder();
    
    // 测量构建时间
    final buildTime = await measureBuildTime(
      tester,
      widget,
      warmUpCount: warmUpCount,
      measureCount: measureCount,
    );
    
    // 测量内存使用
    final memoryUsage = await measureMemoryUsage(
      tester,
      widget,
      warmUpCount: warmUpCount,
    );
    
    // 测量帧率
    final frameRate = await measureFrameRate(tester, widget);
    
    // 记录结果
    final results = {
      'testName': testName,
      'buildTime': buildTime.inMicroseconds,
      'memoryUsage': memoryUsage,
      'frameRate': frameRate,
      'timestamp': DateTime.now().toIso8601String(),
    };
    
    // 验证结果
    if (expectedResults != null) {
      if (expectedResults.containsKey('maxBuildTime')) {
        expect(buildTime.inMicroseconds,
          lessThanOrEqualTo(expectedResults['maxBuildTime']),
          reason: 'Build time exceeds threshold');
      }
      
      if (expectedResults.containsKey('maxMemoryUsage')) {
        expect(memoryUsage['memoryDifference'],
          lessThanOrEqualTo(expectedResults['maxMemoryUsage']),
          reason: 'Memory usage exceeds threshold');
      }
      
      if (expectedResults.containsKey('minFrameRate')) {
        expect(frameRate,
          greaterThanOrEqualTo(expectedResults['minFrameRate']),
          reason: 'Frame rate below threshold');
      }
    }
    
    // 输出结果
    print('Performance Test Results: $testName');
    print('  Build Time: ${buildTime.inMicroseconds}μs');
    print('  Memory Usage: ${memoryUsage['memoryDifference']} bytes');
    print('  Frame Rate: ${frameRate.toStringAsFixed(2)} fps');
    
    return results;
  }
  
  /// 性能回归测试
  static Future<void> runPerformanceRegressionTest(
    WidgetTester tester,
    String testName,
    Widget Function() widgetBuilder, {
    Map<String, dynamic>? baseline,
    double tolerance = 0.1,
  }) async {
    final currentResults = await runPerformanceBenchmark(
      tester,
      testName,
      widgetBuilder,
    );
    
    if (baseline != null) {
      // 验证构建时间回归
      if (baseline.containsKey('buildTime')) {
        final baselineBuildTime = baseline['buildTime'];
        final currentBuildTime = currentResults['buildTime'];
        final regression = (currentBuildTime - baselineBuildTime) / baselineBuildTime;
        
        expect(regression.abs(),
          lessThanOrEqualTo(tolerance),
          reason: 'Build time regression detected: ${regression * 100}%');
      }
      
      // 验证内存使用回归
      if (baseline.containsKey('memoryUsage')) {
        final baselineMemory = baseline['memoryUsage'];
        final currentMemory = currentResults['memoryUsage']['memoryDifference'];
        final regression = (currentMemory - baselineMemory) / baselineMemory;
        
        expect(regression.abs(),
          lessThanOrEqualTo(tolerance),
          reason: 'Memory usage regression detected: ${regression * 100}%');
      }
      
      // 验证帧率回归
      if (baseline.containsKey('frameRate')) {
        final baselineFrameRate = baseline['frameRate'];
        final currentFrameRate = currentResults['frameRate'];
        final regression = (baselineFrameRate - currentFrameRate) / baselineFrameRate;
        
        expect(regression.abs(),
          lessThanOrEqualTo(tolerance),
          reason: 'Frame rate regression detected: ${regression * 100}%');
      }
    }
  }
  
  /// 性能测试套件
  static Future<void> runPerformanceTestSuite(
    WidgetTester tester,
    Map<String, Widget Function()> tests, {
    Map<String, Map<String, dynamic>>? expectedResults,
    Map<String, Map<String, dynamic>>? baselines,
    double tolerance = 0.1,
  }) async {
    final results = <String, dynamic>{};
    
    for (final testName in tests.keys) {
      print('Running performance test: $testName');
      
      final widgetBuilder = tests[testName]!;
      final expectedResult = expectedResults?[testName];
      final baseline = baselines?[testName];
      
      if (baseline != null) {
        await runPerformanceRegressionTest(
          tester,
          testName,
          widgetBuilder,
          baseline: baseline,
          tolerance: tolerance,
        );
      } else {
        final result = await runPerformanceBenchmark(
          tester,
          testName,
          widgetBuilder,
          expectedResults: expectedResult,
        );
        results[testName] = result;
      }
    }
    
    return results;
  }
}

/// 性能基准测试基类
abstract class PerformanceBenchmarkBase extends BenchmarkBase {
  PerformanceBenchmarkBase(String name) : super(name);
  
  @override
  Future<void> run() async {
    await runTest();
  }
  
  Future<void> runTest();
}

/// 组件构建性能基准测试
class WidgetBuildBenchmark extends PerformanceBenchmarkBase {
  final Widget Function() widgetBuilder;
  final WidgetTester tester;
  
  WidgetBuildBenchmark(
    String name,
    this.widgetBuilder,
    this.tester,
  ) : super(name);
  
  @override
  Future<void> runTest() async {
    await PerformanceTestUtils.measureBuildTime(
      tester,
      widgetBuilder(),
    );
  }
}

/// 组件布局性能基准测试
class WidgetLayoutBenchmark extends PerformanceBenchmarkBase {
  final Widget Function() widgetBuilder;
  final WidgetTester tester;
  
  WidgetLayoutBenchmark(
    String name,
    this.widgetBuilder,
    this.tester,
  ) : super(name);
  
  @override
  Future<void> runTest() async {
    await PerformanceTestUtils.measureLayoutTime(
      tester,
      widgetBuilder(),
    );
  }
}

/// 组件绘制性能基准测试
class WidgetPaintBenchmark extends PerformanceBenchmarkBase {
  final Widget Function() widgetBuilder;
  final WidgetTester tester;
  
  WidgetPaintBenchmark(
    String name,
    this.widgetBuilder,
    this.tester,
  ) : super(name);
  
  @override
  Future<void> runTest() async {
    await PerformanceTestUtils.measurePaintTime(
      tester,
      widgetBuilder(),
    );
  }
}

/// 内存使用基准测试
class MemoryUsageBenchmark extends PerformanceBenchmarkBase {
  final Widget Function() widgetBuilder;
  final WidgetTester tester;
  
  MemoryUsageBenchmark(
    String name,
    this.widgetBuilder,
    this.tester,
  ) : super(name);
  
  @override
  Future<void> runTest() async {
    await PerformanceTestUtils.measureMemoryUsage(
      tester,
      widgetBuilder(),
    );
  }
}

/// 帧率基准测试
class FrameRateBenchmark extends PerformanceBenchmarkBase {
  final Widget Function() widgetBuilder;
  final WidgetTester tester;
  
  FrameRateBenchmark(
    String name,
    this.widgetBuilder,
    this.tester,
  ) : super(name);
  
  @override
  Future<void> runTest() async {
    await PerformanceTestUtils.measureFrameRate(
      tester,
      widgetBuilder(),
    );
  }
}

/// 性能测试配置
class PerformanceTestConfig {
  static const Duration defaultTimeout = Duration(minutes: 5);
  static const int defaultWarmUpCount = 5;
  static const int defaultMeasureCount = 10;
  static const Duration defaultMeasureDuration = Duration(seconds: 5);
  static const double defaultTolerance = 0.1;
  
  final Duration timeout;
  final int warmUpCount;
  final int measureCount;
  final Duration measureDuration;
  final double tolerance;
  
  const PerformanceTestConfig({
    this.timeout = defaultTimeout,
    this.warmUpCount = defaultWarmUpCount,
    this.measureCount = defaultMeasureCount,
    this.measureDuration = defaultMeasureDuration,
    this.tolerance = defaultTolerance,
  });
  
  /// 创建严格的性能测试配置
  const PerformanceTestConfig.strict({
    Duration timeout = defaultTimeout,
    int warmUpCount = 10,
    int measureCount = 20,
    Duration measureDuration = const Duration(seconds: 10),
    double tolerance = 0.05,
  }) : this(
    timeout: timeout,
    warmUpCount: warmUpCount,
    measureCount: measureCount,
    measureDuration: measureDuration,
    tolerance: tolerance,
  );
  
  /// 创建宽松的性能测试配置
  const PerformanceTestConfig.relaxed({
    Duration timeout = defaultTimeout,
    int warmUpCount = 3,
    int measureCount = 5,
    Duration measureDuration = const Duration(seconds: 3),
    double tolerance = 0.2,
  }) : this(
    timeout: timeout,
    warmUpCount: warmUpCount,
    measureCount: measureCount,
    measureDuration: measureDuration,
    tolerance: tolerance,
  );
}

/// 性能测试结果
class PerformanceTestResult {
  final String testName;
  final Duration buildTime;
  final Map<String, dynamic> memoryUsage;
  final double frameRate;
  final int rebuildCount;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;
  
  PerformanceTestResult({
    required this.testName,
    required this.buildTime,
    required this.memoryUsage,
    required this.frameRate,
    required this.rebuildCount,
    required this.timestamp,
    this.metadata,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'testName': testName,
      'buildTime': buildTime.inMicroseconds,
      'memoryUsage': memoryUsage,
      'frameRate': frameRate,
      'rebuildCount': rebuildCount,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }
  
  @override
  String toString() {
    return 'PerformanceTestResult('
        'testName: $testName, '
        'buildTime: ${buildTime.inMicroseconds}μs, '
        'memoryUsage: ${memoryUsage['memoryDifference']} bytes, '
        'frameRate: ${frameRate.toStringAsFixed(2)} fps, '
        'rebuildCount: $rebuildCount, '
        'timestamp: $timestamp'
        ')';
  }
}

/// 性能测试报告生成器
class PerformanceTestReportGenerator {
  static Future<void> generateReport(
    List<PerformanceTestResult> results, {
    String outputPath = 'test_results/performance_report.json',
    Map<String, dynamic>? baseline,
    double tolerance = 0.1,
  }) async {
    final report = {
      'generatedAt': DateTime.now().toIso8601String(),
      'results': results.map((r) => r.toJson()).toList(),
      'summary': _generateSummary(results),
      'regressions': baseline != null
          ? _detectRegressions(results, baseline, tolerance)
          : [],
    };
    
    final file = File(outputPath);
    await file.create(recursive: true);
    await file.writeAsString(jsonEncode(report));
    
    print('Performance test report generated: $outputPath');
  }
  
  static Map<String, dynamic> _generateSummary(List<PerformanceTestResult> results) {
    if (results.isEmpty) return {};
    
    final buildTimes = results.map((r) => r.buildTime.inMicroseconds).toList();
    final memoryUsages = results.map((r) => r.memoryUsage['memoryDifference'] as int).toList();
    final frameRates = results.map((r) => r.frameRate).toList();
    final rebuildCounts = results.map((r) => r.rebuildCount).toList();
    
    return {
      'totalTests': results.length,
      'averageBuildTime': buildTimes.reduce((a, b) => a + b) / buildTimes.length,
      'maxBuildTime': buildTimes.reduce(math.max),
      'minBuildTime': buildTimes.reduce(math.min),
      'averageMemoryUsage': memoryUsages.reduce((a, b) => a + b) / memoryUsages.length,
      'maxMemoryUsage': memoryUsages.reduce(math.max),
      'minMemoryUsage': memoryUsages.reduce(math.min),
      'averageFrameRate': frameRates.reduce((a, b) => a + b) / frameRates.length,
      'maxFrameRate': frameRates.reduce(math.max),
      'minFrameRate': frameRates.reduce(math.min),
      'averageRebuildCount': rebuildCounts.reduce((a, b) => a + b) / rebuildCounts.length,
      'maxRebuildCount': rebuildCounts.reduce(math.max),
      'minRebuildCount': rebuildCounts.reduce(math.min),
    };
  }
  
  static List<Map<String, dynamic>> _detectRegressions(
    List<PerformanceTestResult> results,
    Map<String, dynamic> baseline,
    double tolerance,
  ) {
    final regressions = <Map<String, dynamic>>[];
    
    for (final result in results) {
      final baselineData = baseline[result.testName];
      if (baselineData == null) continue;
      
      final buildTimeRegression = (result.buildTime.inMicroseconds - baselineData['buildTime']) / baselineData['buildTime'];
      final memoryRegression = (result.memoryUsage['memoryDifference'] - baselineData['memoryUsage']) / baselineData['memoryUsage'];
      final frameRateRegression = (baselineData['frameRate'] - result.frameRate) / baselineData['frameRate'];
      
      if (buildTimeRegression.abs() > tolerance ||
          memoryRegression.abs() > tolerance ||
          frameRateRegression.abs() > tolerance) {
        regressions.add({
          'testName': result.testName,
          'buildTimeRegression': buildTimeRegression,
          'memoryRegression': memoryRegression,
          'frameRateRegression': frameRateRegression,
          'severity': _calculateSeverity(buildTimeRegression, memoryRegression, frameRateRegression),
        });
      }
    }
    
    return regressions;
  }
  
  static String _calculateSeverity(
    double buildTimeRegression,
    double memoryRegression,
    double frameRateRegression,
  ) {
    final maxRegression = math.max(
      buildTimeRegression.abs(),
      math.max(memoryRegression.abs(), frameRateRegression.abs()),
    );
    
    if (maxRegression > 0.5) return 'critical';
    if (maxRegression > 0.3) return 'high';
    if (maxRegression > 0.2) return 'medium';
    return 'low';
  }
}

/// 性能测试工具类
class PerformanceTestTools {
  /// 开始性能分析
  static void startProfiling() {
    developer.Timeline.startSync('Performance Test');
  }
  
  /// 结束性能分析
  static void stopProfiling() {
    developer.Timeline.finishSync();
  }
  
  /// 添加性能标记
  static void addMarker(String name) {
    developer.Timeline.instantSync(name);
  }
  
  /// 开始性能事件
  static void startEvent(String name) {
    developer.Timeline.startSync(name);
  }
  
  /// 结束性能事件
  static void endEvent() {
    developer.Timeline.finishSync();
  }
  
  /// 强制垃圾回收
  static Future<void> forceGC() async {
    // 强制垃圾回收
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  /// 获取内存信息
  static Future<Map<String, dynamic>> getMemoryInfo() async {
    final memory = developer.Service.getInfo().memory!;
    return {
      'heapCapacity': memory.heapCapacity,
      'heapUsed': memory.heapUsed,
      'external': memory.external,
    };
  }
  
  /// 验证性能阈值
  static void expectPerformanceThreshold(
    String metric,
    dynamic value,
    dynamic threshold, {
    String? reason,
  }) {
    if (threshold is Duration && value is Duration) {
      expect(value.inMicroseconds,
        lessThanOrEqualTo(threshold.inMicroseconds),
        reason: reason ?? '$metric exceeds threshold');
    } else if (threshold is double && value is double) {
      expect(value,
        greaterThanOrEqualTo(threshold),
        reason: reason ?? '$metric below threshold');
    } else if (threshold is int && value is int) {
      expect(value,
        lessThanOrEqualTo(threshold),
        reason: reason ?? '$metric exceeds threshold');
    } else {
      throw ArgumentError('Unsupported threshold type: ${threshold.runtimeType}');
    }
  }
  
  /// 验证性能回归
  static void expectNoPerformanceRegression(
    String metric,
    dynamic currentValue,
    dynamic baselineValue, {
    double tolerance = 0.1,
    String? reason,
  }) {
    if (currentValue is Duration && baselineValue is Duration) {
      final regression = (currentValue.inMicroseconds - baselineValue.inMicroseconds) / baselineValue.inMicroseconds;
      expect(regression.abs(),
        lessThanOrEqualTo(tolerance),
        reason: reason ?? '$metric regression detected: ${regression * 100}%');
    } else if (currentValue is double && baselineValue is double) {
      final regression = (baselineValue - currentValue) / baselineValue;
      expect(regression.abs(),
        lessThanOrEqualTo(tolerance),
        reason: reason ?? '$metric regression detected: ${regression * 100}%');
    } else if (currentValue is int && baselineValue is int) {
      final regression = (currentValue - baselineValue) / baselineValue;
      expect(regression.abs(),
        lessThanOrEqualTo(tolerance),
        reason: reason ?? '$metric regression detected: ${regression * 100}%');
    } else {
      throw ArgumentError('Unsupported value type: ${currentValue.runtimeType}');
    }
  }
}