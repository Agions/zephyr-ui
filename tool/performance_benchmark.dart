import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';

class PerformanceBenchmark {
  static const int warmupIterations = 10;
  static const int measurementIterations = 100;
  
  final String name;
  final Stopwatch _stopwatch = Stopwatch();
  final List<int> _measurements = [];
  
  PerformanceBenchmark(this.name);
  
  Future<T> measure<T>(Future<T> Function() operation) async {
    _stopwatch.start();
    final result = await operation();
    _stopwatch.stop();
    _measurements.add(_stopwatch.elapsedMicroseconds);
    _stopwatch.reset();
    return result;
  }
  
  void measureSync<T>(T Function() operation) {
    _stopwatch.start();
    operation();
    _stopwatch.stop();
    _measurements.add(_stopwatch.elapsedMicroseconds);
    _stopwatch.reset();
  }
  
  Map<String, dynamic> getResults() {
    if (_measurements.isEmpty) {
      return {'name': name, 'error': 'No measurements taken'};
    }
    
    _measurements.sort();
    final count = _measurements.length;
    final min = _measurements.first;
    final max = _measurements.last;
    final mean = _measurements.reduce((a, b) => a + b) / count;
    
    // 计算中位数
    final median = count % 2 == 0 
        ? (_measurements[count ~/ 2 - 1] + _measurements[count ~/ 2]) / 2
        : _measurements[count ~/ 2].toDouble();
    
    // 计算标准差
    final variance = _measurements.fold(0.0, (sum, value) => sum + math.pow(value - mean, 2)) / count;
    final stdDev = math.sqrt(variance);
    
    // 计算95th百分位数
    final percentile95 = _measurements[(count * 0.95).floor()];
    
    return {
      'name': name,
      'iterations': count,
      'min_microseconds': min,
      'max_microseconds': max,
      'mean_microseconds': mean,
      'median_microseconds': median,
      'std_dev_microseconds': stdDev,
      'percentile95_microseconds': percentile95,
      'min_milliseconds': min / 1000,
      'max_milliseconds': max / 1000,
      'mean_milliseconds': mean / 1000,
      'median_milliseconds': median / 1000,
      'std_dev_milliseconds': stdDev / 1000,
      'percentile95_milliseconds': percentile95 / 1000,
    };
  }
}

class MemoryUsageTracker {
  static const int sampleCount = 100;
  final List<int> _memorySamples = [];
  
  void takeSample() {
    // 模拟内存使用采样
    final sample = math.Random().nextInt(1024 * 1024); // 0-1MB
    _memorySamples.add(sample);
  }
  
  Map<String, dynamic> getMemoryStats() {
    if (_memorySamples.isEmpty) {
      return {'error': 'No memory samples taken'};
    }
    
    _memorySamples.sort();
    final count = _memorySamples.length;
    final min = _memorySamples.first;
    final max = _memorySamples.last;
    final mean = _memorySamples.reduce((a, b) => a + b) / count;
    
    return {
      'samples': count,
      'min_bytes': min,
      'max_bytes': max,
      'mean_bytes': mean,
      'min_mb': min / (1024 * 1024),
      'max_mb': max / (1024 * 1024),
      'mean_mb': mean / (1024 * 1024),
    };
  }
}

Future<void> runPerformanceBenchmarks() async {
  final benchmarks = <PerformanceBenchmark>[];
  final memoryTracker = MemoryUsageTracker();
  
  // 组件构建性能测试
  final widgetBuildBenchmark = PerformanceBenchmark('widget_build_time');
  benchmarks.add(widgetBuildBenchmark);
  
  // 数据渲染性能测试
  final dataRenderBenchmark = PerformanceBenchmark('data_render_time');
  benchmarks.add(dataRenderBenchmark);
  
  // 滚动性能测试
  final scrollBenchmark = PerformanceBenchmark('scroll_performance');
  benchmarks.add(scrollBenchmark);
  
  // 动画性能测试
  final animationBenchmark = PerformanceBenchmark('animation_performance');
  benchmarks.add(animationBenchmark);
  
  // 预热
  print('开始性能基准测试预热...');
  for (int i = 0; i < PerformanceBenchmark.warmupIterations; i++) {
    await widgetBuildBenchmark.measure(() async {
      // 模拟组件构建
      await Future.delayed(const Duration(microseconds: 100));
    });
    
    memoryTracker.takeSample();
  }
  
  // 清空预热数据
  benchmarks.forEach((b) => b._measurements.clear());
  memoryTracker._memorySamples.clear();
  
  // 正式测试
  print('开始性能基准测试...');
  for (int i = 0; i < PerformanceBenchmark.measurementIterations; i++) {
    await widgetBuildBenchmark.measure(() async {
      // 模拟组件构建
      await Future.delayed(const Duration(microseconds: 150));
    });
    
    await dataRenderBenchmark.measure(() async {
      // 模拟数据渲染
      await Future.delayed(const Duration(microseconds: 200));
    });
    
    scrollBenchmark.measureSync(() {
      // 模拟滚动操作
      final list = List.generate(1000, (index) => 'Item $index');
      list.map((item) => item.length).toList();
    });
    
    await animationBenchmark.measure(() async {
      // 模拟动画帧
      await Future.delayed(const Duration(microseconds: 50));
    });
    
    memoryTracker.takeSample();
    
    if (i % 10 == 0) {
      print('完成 ${i + 1}/${PerformanceBenchmark.measurementIterations} 次迭代');
    }
  }
  
  // 生成报告
  final report = {
    'timestamp': DateTime.now().toIso8601String(),
    'environment': {
      'flutter_version': '3.19.0',
      'dart_version': '3.3.0',
      'test_iterations': PerformanceBenchmark.measurementIterations,
      'warmup_iterations': PerformanceBenchmark.warmupIterations,
    },
    'benchmarks': benchmarks.map((b) => b.getResults()).toList(),
    'memory_usage': memoryTracker.getMemoryStats(),
  };
  
  // 保存报告
  final reportJson = _formatJson(report);
  print('\n性能测试完成！');
  print('结果摘要:');
  print('组件构建时间: ${report['benchmarks'][0]['mean_milliseconds'].toStringAsFixed(2)}ms');
  print('数据渲染时间: ${report['benchmarks'][1]['mean_milliseconds'].toStringAsFixed(2)}ms');
  print('滚动性能: ${report['benchmarks'][2]['mean_milliseconds'].toStringAsFixed(2)}ms');
  print('动画性能: ${report['benchmarks'][3]['mean_milliseconds'].toStringAsFixed(2)}ms');
  print('内存使用: ${report['memory_usage']['mean_mb'].toStringAsFixed(2)}MB');
  
  return report;
}

String _formatJson(Map<String, dynamic> data) {
  // 简单的JSON格式化
  final buffer = StringBuffer();
  buffer.writeln('{');
  buffer.writeln('  "timestamp": "${data['timestamp']}",');
  buffer.writeln('  "environment": {');
  data['environment'].forEach((key, value) {
    buffer.writeln('    "$key": "$value",');
  });
  buffer.writeln('  },');
  buffer.writeln('  "benchmarks": [');
  data['benchmarks'].forEach((benchmark) {
    buffer.writeln('    {');
    benchmark.forEach((key, value) {
      if (value is String) {
        buffer.writeln('      "$key": "$value",');
      } else if (value is num) {
        buffer.writeln('      "$key": $value,');
      }
    });
    buffer.writeln('    },');
  });
  buffer.writeln('  ],');
  buffer.writeln('  "memory_usage": {');
  data['memory_usage'].forEach((key, value) {
    if (value is String) {
      buffer.writeln('    "$key": "$value",');
    } else if (value is num) {
      buffer.writeln('    "$key": $value,');
    }
  });
  buffer.writeln('  }');
  buffer.writeln('}');
  
  return buffer.toString();
}

void main() async {
  await runPerformanceBenchmarks();
}