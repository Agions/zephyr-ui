import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 性能监控和开发工具链使用示例
/// 
/// 这个文件展示了如何使用 ZephyrUI 的性能监控系统和开发工具链
class UsageExamples {
  
  /// 1. 基础性能监控示例
  static Widget basicPerformanceMonitoringExample() {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('基础性能监控')),
        body: const BasicPerformanceDemo(),
      ),
    );
  }
}

/// 基础性能监控演示
class BasicPerformanceDemo extends StatefulWidget {
  const BasicPerformanceDemo({Key? key}) : super(key: key);

  @override
  State<BasicPerformanceDemo> createState() => _BasicPerformanceDemoState();
}

class _BasicPerformanceDemoState extends State<BasicPerformanceDemo> {
  final PerformanceMonitor _monitor = PerformanceMonitor();
  bool _isMonitoring = false;
  PerformanceMetrics? _currentMetrics;
  
  @override
  void initState() {
    super.initState();
    _setupPerformanceMonitoring();
  }
  
  @override
  void dispose() {
    _monitor.dispose();
    super.dispose();
  }
  
  void _setupPerformanceMonitoring() {
    // 设置性能告警阈值
    _monitor.setAlertThresholds(PerformanceAlertThresholds(
      fpsThreshold: 30.0,
      memoryThreshold: 0.8,
      cpuThreshold: 0.8,
      gpuThreshold: 0.8,
    ));
    
    // 监听性能数据流
    _monitor.metricsStream.listen((metrics) {
      setState(() {
        _currentMetrics = metrics;
      });
    });
  }
  
  void _toggleMonitoring() {
    if (_isMonitoring) {
      _monitor.stopMonitoring();
    } else {
      _monitor.startMonitoring(
        interval: const Duration(seconds: 1),
        enableFPS: true,
        enableMemory: true,
        enableCPU: true,
        enableGPU: true,
      );
    }
    setState(() {
      _isMonitoring = !_isMonitoring;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('性能监控演示'),
          actions: [
            IconButton(
              icon: Icon(_isMonitoring ? Icons.pause : Icons.play_arrow),
              onPressed: _toggleMonitoring,
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                final report = await _monitor.generatePerformanceReport();
                _showPerformanceReport(context, report);
              },
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildMetricsCard(),
                const SizedBox(height: 16),
                _buildPerformanceActions(),
                const SizedBox(height: 16),
                _buildRealtimeChart(),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildMetricsCard() {
    if (_currentMetrics == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('点击开始按钮开始监控')),
        ),
      );
    }
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '实时性能指标',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildMetricItem('FPS', '${_currentMetrics!.fps.toStringAsFixed(1)}')),
                Expanded(child: _buildMetricItem('内存', '${_currentMetrics!.memory.usedMB.toStringAsFixed(1)}MB')),
                Expanded(child: _buildMetricItem('CPU', '${_currentMetrics!.cpu.usage.toStringAsFixed(1)}%')),
                Expanded(child: _buildMetricItem('GPU', '${_currentMetrics!.gpu.usage.toStringAsFixed(1)}%')),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMetricItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
  
  Widget _buildPerformanceActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '性能操作',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _runBenchmark,
                  child: const Text('运行基准测试'),
                ),
                ElevatedButton(
                  onPressed: _getOptimizationSuggestions,
                  child: const Text('获取优化建议'),
                ),
                ElevatedButton(
                  onPressed: _generateReport,
                  child: const Text('生成报告'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRealtimeChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '性能趋势图',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('实时性能图表'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _runBenchmark() async {
    final result = await _monitor.runBenchmark(
      benchmarkName: 'list_rendering_test',
      testFunction: () async {
        // 模拟列表渲染测试
        final items = List.generate(1000, (index) => 'Item $index');
        await Future.delayed(const Duration(milliseconds: 10));
      },
      warmupIterations: 3,
      measurementIterations: 10,
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('基准测试完成: 平均耗时 ${result.averageDuration.inMilliseconds}ms'),
        ),
      );
    }
  }
  
  void _getOptimizationSuggestions() async {
    final suggestions = await _monitor.getOptimizationSuggestions();
    
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('优化建议'),
          content: SizedBox(
            width: 400,
            height: 300,
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return Card(
                  child: ListTile(
                    title: Text(suggestion.title),
                    subtitle: Text(suggestion.category),
                    trailing: Text('${(suggestion.impact * 100).toStringAsFixed(0)}%'),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('关闭'),
            ),
          ],
        ),
      );
    }
  }
  
  void _generateReport() async {
    final report = await _monitor.generatePerformanceReport();
    _showPerformanceReport(context, report);
  }
  
  void _showPerformanceReport(BuildContext context, PerformanceReport report) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('性能报告'),
        content: SizedBox(
          width: 400,
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('总体评分: ${(report.analysis.overallScore * 100).toStringAsFixed(1)}%'),
                const SizedBox(height: 8),
                Text('发现问题: ${report.analysis.issues.length} 个'),
                const SizedBox(height: 8),
                Text('监控时长: ${report.duration.inMinutes} 分钟'),
                const SizedBox(height: 16),
                const Text('分类评分:'),
                ...report.analysis.categoryScores.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, top: 4),
                    child: Text('${entry.key}: ${(entry.value * 100).toStringAsFixed(1)}%'),
                  );
                }),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}

/// 2. 组件生成器使用示例
class ComponentGeneratorExample extends StatelessWidget {
  const ComponentGeneratorExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('组件生成器示例')),
        body: const ComponentGeneratorDemo(),
      ),
    );
  }
}

class ComponentGeneratorDemo extends StatelessWidget {
  const ComponentGeneratorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '组件生成器使用示例',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildCommandLineExample(),
          const SizedBox(height: 24),
          _buildGeneratedComponentExample(),
        ],
      ),
    );
  }
  
  Widget _buildCommandLineExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '命令行使用',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '''# 生成基础组件
dart tools/scripts/dev_tools_cli.dart generate \\
  --type basic \\
  --name MyButton \\
  --output lib/src/components

# 生成表单组件
dart tools/scripts/dev_tools_cli.dart generate \\
  --type form \\
  --name MyFormField \\
  --with-test \\
  --with-doc \\
  --with-example

# 生成主题
dart tools/scripts/dev_tools_cli.dart theme \\
  --name custom_theme \\
  --base light \\
  --primary-color "#FF6B6B"''',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGeneratedComponentExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '生成的组件示例',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '''// 自动生成的组件代码
class MyButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  
  const MyButton({
    Key? key,
    this.title,
    this.onTap,
    this.backgroundColor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            title ?? 'Button',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}''',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 3. 主题定制示例
class ThemeCustomizerExample extends StatelessWidget {
  const ThemeCustomizerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('主题定制示例')),
        body: const ThemeCustomizerDemo(),
      ),
    );
  }
}

class ThemeCustomizerDemo extends StatelessWidget {
  const ThemeCustomizerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '主题定制示例',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildThemeColors(),
          const SizedBox(height: 24),
          _buildThemeComponents(),
        ],
      ),
    );
  }
  
  Widget _buildThemeColors() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '主题颜色',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildColorItem('Primary', Colors.blue),
                _buildColorItem('Secondary', Colors.orange),
                _buildColorItem('Background', Colors.grey[100]!),
                _buildColorItem('Surface', Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildColorItem(String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
  
  Widget _buildThemeComponents() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '主题组件',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Elevated Button'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Text Button'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Outlined Button'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Text Field',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 4. 代码质量检查示例
class CodeQualityExample extends StatelessWidget {
  const CodeQualityExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('代码质量检查示例')),
        body: const CodeQualityDemo(),
      ),
    );
  }
}

class CodeQualityDemo extends StatelessWidget {
  const CodeQualityDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '代码质量检查',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildQualityMetrics(),
          const SizedBox(height: 24),
          _buildCommandLineCommands(),
        ],
      ),
    );
  }
  
  Widget _buildQualityMetrics() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '质量指标',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final metrics = [
                  {'name': 'Code Coverage', 'value': '85%', 'color': Colors.green},
                  {'name': 'Code Smells', 'value': '12', 'color': Colors.orange},
                  {'name': 'Technical Debt', 'value': '5%', 'color': Colors.green},
                  {'name': 'Maintainability', 'value': 'A', 'color': Colors.green},
                ];
                return _buildQualityMetricCard(metrics[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQualityMetricCard(Map<String, dynamic> metric) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: metric['color'] as Color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metric['name'] as String,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            metric['value'] as String,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: metric['color'] as Color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCommandLineCommands() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '命令行工具',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '''# 代码质量检查
dart tools/scripts/dev_tools_cli.dart lint \\
  --path lib \\
  --strict \\
  --fix

# 运行测试
dart tools/scripts/dev_tools_cli.dart test \\
  --coverage coverage/lcov.info \\
  --reporter expanded

# 性能监控
dart tools/scripts/dev_tools_cli.dart monitor \\
  --duration 60 \\
  --output performance_report.json \\
  --format json''',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 主函数 - 运行不同的示例
void main() {
  // 选择要运行的示例
  runApp(UsageExamples.basicPerformanceMonitoringExample());
  
  // 或者运行其他示例：
  // runApp(const ComponentGeneratorExample());
  // runApp(const ThemeCustomizerExample());
  // runApp(const CodeQualityExample());
}