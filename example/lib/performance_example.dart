/// ZephyrUI 性能优化示例
///
/// 展示如何使用 ZephyrUI 的性能优化功能
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const PerformanceExampleApp());
}

class PerformanceExampleApp extends StatelessWidget {
  const PerformanceExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrPerformanceTheme(
      enablePerformanceMonitoring: true,
      monitoringLevel: PerformanceLevel.high,
      enableMemoryOptimization: true,
      enableHotReloadOptimization: true,
      child: MaterialApp(
        title: 'ZephyrUI Performance Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const PerformanceExampleHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class PerformanceExampleHome extends StatefulWidget {
  const PerformanceExampleHome({Key? key}) : super(key: key);

  @override
  State<PerformanceExampleHome> createState() => _PerformanceExampleHomeState();
}

class _PerformanceExampleHomeState extends State<PerformanceExampleHome> {
  final ZephyrEnhancedPerformanceMonitor _performanceMonitor =
      ZephyrEnhancedPerformanceMonitor.instance;
  final ZephyrMemoryOptimizer _memoryOptimizer = ZephyrMemoryOptimizer.instance;
  final ZephyrBuildOptimizer _buildOptimizer = ZephyrBuildOptimizer.instance;
  final ZephyrLazyComponentLoader _lazyLoader =
      ZephyrLazyComponentLoader.instance;

  bool _showPerformanceOverlay = true;
  bool _showMemoryMonitor = true;
  bool _enableLazyLoading = true;
  bool _enableMemoryOptimization = true;
  bool _enableBuildOptimization = true;

  @override
  void initState() {
    super.initState();
    _initializeOptimizations();
  }

  void _initializeOptimizations() {
    // 启动性能监控
    _performanceMonitor.startMonitoring(level: PerformanceLevel.high);

    // 启动内存优化
    _memoryOptimizer.startMonitoring(
      strategy: MemoryOptimizationStrategy.balanced,
      memoryThresholdMB: 150.0,
    );

    // 启动构建优化
    _buildOptimizer.startMonitoring();

    // 注册懒加载组件
    _registerLazyComponents();

    // 预加载关键组件
    _preloadCriticalComponents();

    if (kDebugMode) {
      debugPrint('🚀 Performance optimizations initialized');
    }
  }

  void _registerLazyComponents() {
    _lazyLoader.registerComponent(
      name: 'complex_chart',
      path: 'lib/components/charts/complex_chart.dart',
      estimatedSizeKB: 150,
      priority: ComponentPriority.medium,
    );

    _lazyLoader.registerComponent(
      name: 'data_table',
      path: 'lib/components/tables/data_table.dart',
      estimatedSizeKB: 80,
      priority: ComponentPriority.high,
    );

    _lazyLoader.registerComponent(
      name: 'image_gallery',
      path: 'lib/components/gallery/image_gallery.dart',
      estimatedSizeKB: 200,
      priority: ComponentPriority.low,
    );
  }

  void _preloadCriticalComponents() {
    _lazyLoader.preloadComponents();
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrPerformanceOverlay(
      enabled: _showPerformanceOverlay,
      level: PerformanceLevel.high,
      child: ZephyrMemoryMonitor(
        enabled: _showMemoryMonitor,
        strategy: MemoryOptimizationStrategy.balanced,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ZephyrUI Performance Example'),
            actions: [
              IconButton(
                icon: const Icon(Icons.dashboard),
                onPressed: () => context.showPerformanceDashboard(),
              ),
              IconButton(
                icon: Icon(_showPerformanceOverlay
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _showPerformanceOverlay = !_showPerformanceOverlay;
                  });
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOptimizationControls(),
                const SizedBox(height: 24),
                _buildPerformanceMetrics(),
                const SizedBox(height: 24),
                _buildThemeOptimizationDemo(),
                const SizedBox(height: 24),
                _buildLazyLoadingDemo(),
                const SizedBox(height: 24),
                _buildMemoryOptimizationDemo(),
                const SizedBox(height: 24),
                _buildBuildOptimizationDemo(),
                const SizedBox(height: 24),
                _buildComplexComponentDemo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptimizationControls() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Optimization Controls',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: Text('Performance Overlay'),
                  selected: _showPerformanceOverlay,
                  onSelected: (value) {
                    setState(() {
                      _showPerformanceOverlay = value;
                    });
                  },
                ),
                FilterChip(
                  label: Text('Memory Monitor'),
                  selected: _showMemoryMonitor,
                  onSelected: (value) {
                    setState(() {
                      _showMemoryMonitor = value;
                    });
                  },
                ),
                FilterChip(
                  label: Text('Lazy Loading'),
                  selected: _enableLazyLoading,
                  onSelected: (value) {
                    setState(() {
                      _enableLazyLoading = value;
                    });
                  },
                ),
                FilterChip(
                  label: Text('Memory Optimization'),
                  selected: _enableMemoryOptimization,
                  onSelected: (value) {
                    setState(() {
                      _enableMemoryOptimization = value;
                      if (value) {
                        _memoryOptimizer.startMonitoring();
                      } else {
                        _memoryOptimizer.stopMonitoring();
                      }
                    });
                  },
                ),
                FilterChip(
                  label: Text('Build Optimization'),
                  selected: _enableBuildOptimization,
                  onSelected: (value) {
                    setState(() {
                      _enableBuildOptimization = value;
                      if (value) {
                        _buildOptimizer.startMonitoring();
                      } else {
                        _buildOptimizer.stopMonitoring();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            StreamBuilder<PerformanceReport>(
              stream: Stream.periodic(Duration(seconds: 2), (_) {
                return _performanceMonitor.getPerformanceReport();
              }),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final report = snapshot.data!;
                final avgFps = report.frameTimeStats.average > 0
                    ? 1000 / report.frameTimeStats.average
                    : 0;
                final memoryMB = report.memoryStats.average / 1024 / 1024;

                return Column(
                  children: [
                    _buildMetricRow('Average FPS', avgFps.toStringAsFixed(1)),
                    _buildMetricRow('Frame Time',
                        '${report.frameTimeStats.average.toStringAsFixed(2)}ms'),
                    _buildMetricRow(
                        'Memory Usage', '${memoryMB.toStringAsFixed(1)}MB'),
                    _buildMetricRow(
                        'Widget Count', '${report.widgetBuildStats.length}'),
                    _buildMetricRow('Active Alerts', '${report.alerts.length}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOptimizationDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme Optimization Demo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => context.switchTheme(Brightness.light),
                  child: Text('Light Theme'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => context.switchTheme(Brightness.dark),
                  child: Text('Dark Theme'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final stats = context.getThemeCacheStats();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Theme Cache: ${stats['cacheSize']} items, Hit Rate: ${stats['hitRate']}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text('Cache Stats'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Theme: ${Theme.of(context).brightness == Brightness.light ? 'Light' : 'Dark'}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLazyLoadingDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lazy Loading Demo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            if (_enableLazyLoading)
              Column(
                children: [
                  context.lazyLoad(
                    componentName: 'data_table',
                    placeholder: Center(child: CircularProgressIndicator()),
                    errorWidget:
                        Center(child: Text('Failed to load component')),
                  ),
                  SizedBox(height: 16),
                  context.lazyLoad(
                    componentName: 'complex_chart',
                    placeholder: Center(child: CircularProgressIndicator()),
                    errorWidget:
                        Center(child: Text('Failed to load component')),
                  ),
                ],
              )
            else
              Center(child: Text('Lazy loading disabled')),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryOptimizationDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Memory Optimization Demo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.addToMemoryCache('test_data', {'key': 'value'},
                        sizeKB: 10);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Data added to memory cache')),
                    );
                  },
                  child: Text('Add to Cache'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    context.clearMemoryCache();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Memory cache cleared')),
                    );
                  },
                  child: Text('Clear Cache'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final stats = context.getMemoryStats();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Memory: ${stats.currentUsageMB.toStringAsFixed(1)}MB'),
                      ),
                    );
                  },
                  child: Text('Memory Stats'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuildOptimizationDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Build Optimization Demo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final report = context.getBuildPerformanceReport();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Build time: ${report['latestBuild']?['timeMs'] ?? 0}ms'),
                      ),
                    );
                  },
                  child: Text('Build Stats'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    context.cleanBuildCache();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Build cache cleaned')),
                    );
                  },
                  child: Text('Clean Cache'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplexComponentDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complex Component Demo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                    subtitle: const Text(
                        'This is a complex list item with multiple widgets'),
                    trailing: const Icon(Icons.chevron_right),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _performanceMonitor.stopMonitoring();
    _memoryOptimizer.stopMonitoring();
    _buildOptimizer.stopMonitoring();
    super.dispose();
  }
}
