/// ZephyrUI 性能优化演示应用
///
/// 展示所有性能优化功能的示例应用。
library performance_demo_app;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
// These imports are now available through the main zephyr_ui package
// import 'package:zephyr_ui/src/core/theme/performance_theme_integration.dart';
// import 'package:zephyr_ui/src/utils/performance/enhanced_performance_utils.dart';
// import 'package:zephyr_ui/src/utils/build/build_optimization.dart';

void main() {
  // Initialize basic performance monitoring
  ZephyrPerformanceUtils.startMonitoring();
  
  runApp(const PerformanceDemoApp());
}

class PerformanceDemoApp extends StatelessWidget {
  const PerformanceDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrUI Performance Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PerformanceDemoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PerformanceDemoHomePage extends StatefulWidget {
  const PerformanceDemoHomePage({Key? key}) : super(key: key);

  @override
  State<PerformanceDemoHomePage> createState() => _PerformanceDemoHomePageState();
}

class _PerformanceDemoHomePageState extends State<PerformanceDemoHomePage> {
  int _counter = 0;
  bool _isDarkMode = false;
  final ScrollController _scrollController = ScrollController();
  final List<String> _items = List.generate(100, (index) => 'Item $index');

  @override
  void initState() {
    super.initState();
    // Start basic performance monitoring
    ZephyrPerformanceUtils.startMonitoring();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    ZephyrPerformanceUtils.stopMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Performance Demo'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
              // Simple theme switching
              final brightness = _isDarkMode ? Brightness.dark : Brightness.light;
              // Note: You might want to implement theme switching in your app
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
          ),
        ],
      ),
      body: ZephyrPerformanceThemePreview(
        showControls: true,
        showStats: true,
        child: Column(
          children: [
            _buildPerformanceStats(),
            const SizedBox(height: 20),
            _buildDemoControls(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildPerformanceDemoList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceStats() {
    final report = context.getPerformanceReport();
    final avgFps = report.frameTimeStats.average > 0 ? 1000 / report.frameTimeStats.average : 0;
    final memoryMB = report.memoryStats.average / 1024 / 1024;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🚀 Performance Statistics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('FPS', avgFps.toStringAsFixed(1), 
                  avgFps > 55 ? Colors.green : (avgFps > 30 ? Colors.yellow : Colors.red)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard('Memory', '${memoryMB.toStringAsFixed(1)}MB',
                  memoryMB < 100 ? Colors.green : (memoryMB < 200 ? Colors.yellow : Colors.red)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard('Widgets', '${report.widgetBuildStats.length}', Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Monitoring Level: ${report.monitoringLevel.toString().split('.').last}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: Text('Counter: $_counter'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _items.addAll(List.generate(10, (index) => 'New Item ${_items.length + index}'));
                });
              },
              child: const Text('Add Items'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceDemoList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return PerformanceDemoListItem(
          title: _items[index],
          index: index,
          onTap: () {
            context.recordPerformanceMetric('item_tap', index.toDouble());
          },
        );
      },
    );
  }
}

/// 性能优化的列表项组件
class PerformanceDemoListItem extends ZephyrOptimizedWidget {
  final String title;
  final int index;
  final VoidCallback onTap;

  const PerformanceDemoListItem({
    Key? key,
    required this.title,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget buildOptimized(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text('Index: $index'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

/// 性能优化设置页面
class PerformanceSettingsPage extends StatefulWidget {
  const PerformanceSettingsPage({Key? key}) : super(key: key);

  @override
  State<PerformanceSettingsPage> createState() => _PerformanceSettingsPageState();
}

class _PerformanceSettingsPageState extends State<PerformanceSettingsPage> {
  PerformanceLevel _monitoringLevel = PerformanceLevel.medium;
  bool _enableMemoryOptimization = true;
  bool _enableHotReloadOptimization = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Performance Monitoring',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildMonitoringLevelSelector(),
          const SizedBox(height: 16),
          _buildOptimizationToggle(
            'Memory Optimization',
            _enableMemoryOptimization,
            (value) => setState(() => _enableMemoryOptimization = value),
          ),
          const SizedBox(height: 8),
          _buildOptimizationToggle(
            'Hot Reload Optimization',
            _enableHotReloadOptimization,
            (value) => setState(() => _enableHotReloadOptimization = value),
          ),
          const SizedBox(height: 24),
          const Text(
            'Build Statistics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildBuildStats(),
          const SizedBox(height: 24),
          const Text(
            'Theme Cache Statistics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildThemeCacheStats(),
        ],
      ),
    );
  }

  Widget _buildMonitoringLevelSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Monitoring Level'),
        const SizedBox(height: 8),
        DropdownButton<PerformanceLevel>(
          value: _monitoringLevel,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _monitoringLevel = value;
              });
            }
          },
          items: PerformanceLevel.values.map((level) {
            return DropdownMenuItem(
              value: level,
              child: Text(level.toString().split('.').last),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOptimizationToggle(
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildBuildStats() {
    final stats = ZephyrBuildOptimizer.instance.getBuildStats();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Environment: ${stats['environment']}'),
          Text('Platform: ${stats['platform']}'),
          const SizedBox(height: 8),
          const Text('Recommendations:'),
          ...List<String>.from(stats['recommendations']).map((rec) => 
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text('• $rec'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCacheStats() {
    final stats = ZephyrOptimizedThemeConfig.instance.getCacheStats();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cache Size: ${stats['prebuiltThemesCount']}'),
          Text('Builder Cache: ${stats['builderCacheCount']}'),
          const SizedBox(height: 8),
          const Text('Cached Themes:'),
          ...List<String>.from(stats['cachedThemes'] ?? []).map((theme) => 
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text('• $theme'),
            ),
          ),
        ],
      ),
    );
  }
}