import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PerformanceDemoApp());
}

class PerformanceDemoApp extends StatelessWidget {
  const PerformanceDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PerformanceMonitorProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer2<PerformanceMonitorProvider, ThemeProvider>(
        builder: (context, performanceProvider, themeProvider, child) {
          return MaterialApp(
            title: 'ZephyrUI Performance Demo',
            theme: themeProvider.currentTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const PerformanceDemoHome(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class PerformanceDemoHome extends StatefulWidget {
  const PerformanceDemoHome({Key? key}) : super(key: key);

  @override
  State<PerformanceDemoHome> createState() => _PerformanceDemoHomeState();
}

class _PerformanceDemoHomeState extends State<PerformanceDemoHome> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          PerformanceDashboardPage(),
          ComponentGeneratorPage(),
          ThemeCustomizerPage(),
          CodeQualityPage(),
          MonitoringPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.speed),
            label: 'Performance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Generator',
          ),
          BottomNavigationBarItem(
            icon: Icons.palette),
            label: 'Theme',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Quality',
          ),
          BottomNavigationBarItem(
            icon: Icons.monitor_heart),
            label: 'Monitor',
          ),
        ],
      ),
    );
  }
}

/// 性能监控仪表板页面
class PerformanceDashboardPage extends StatelessWidget {
  const PerformanceDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PerformanceMonitorProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Performance Dashboard'),
            actions: [
              IconButton(
                icon: Icon(provider.isMonitoring ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (provider.isMonitoring) {
                    provider.stopMonitoring();
                  } else {
                    provider.startMonitoring();
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  // 刷新性能数据
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPerformanceMetrics(provider),
                const SizedBox(height: 24),
                _buildPerformanceCharts(),
                const SizedBox(height: 24),
                _buildOptimizationSuggestions(provider),
                const SizedBox(height: 24),
                _buildAlertsSection(provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPerformanceMetrics(PerformanceMonitorProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-time Metrics',
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
              itemCount: provider.metrics.length,
              itemBuilder: (context, index) {
                final metric = provider.metrics.entries.elementAt(index);
                return _buildMetricCard(metric.key, metric.value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(PerformanceMetric metric, PerformanceMetricData data) {
    final currentValue = data.dataPoints.isEmpty ? 0 : data.dataPoints.last.value;
    final color = _getMetricColor(metric, currentValue);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getMetricDisplayName(metric),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            '${currentValue.toStringAsFixed(1)} ${data.unit}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Avg: ${data.averageValue?.toStringAsFixed(1) ?? 'N/A'}',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCharts() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Trends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Performance Chart Visualization'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptimizationSuggestions(PerformanceMonitorProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Optimization Suggestions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...provider.suggestions.take(3).map((suggestion) => _buildSuggestionCard(suggestion)),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(OptimizationSuggestion suggestion) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(suggestion.title),
        subtitle: Text('${suggestion.category} - Impact: ${(suggestion.impact * 100).toStringAsFixed(0)}%'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(suggestion.description),
                const SizedBox(height: 8),
                const Text('Steps:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...suggestion.steps.map((step) => Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text('• $step'),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsSection(PerformanceMonitorProvider provider) {
    final activeAlerts = provider.alerts.where((alert) => !alert.resolved).toList();
    
    if (activeAlerts.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Alerts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...activeAlerts.map((alert) => _buildAlertCard(alert)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(PerformanceAlert alert) {
    final color = _getAlertColor(alert.severity);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 4,
          color: color,
        ),
        title: Text(alert.title),
        subtitle: Text(alert.description),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Mark alert as resolved
          },
        ),
      ),
    );
  }

  String _getMetricDisplayName(PerformanceMetric metric) {
    switch (metric) {
      case PerformanceMetric.fps:
        return 'FPS';
      case PerformanceMetric.memory:
        return 'Memory';
      case PerformanceMetric.cpu:
        return 'CPU';
      case PerformanceMetric.gpu:
        return 'GPU';
      case PerformanceMetric.network:
        return 'Network';
      case PerformanceMetric.battery:
        return 'Battery';
      case PerformanceMetric.disk:
        return 'Disk';
      case PerformanceMetric.screen:
        return 'Screen';
    }
  }

  Color _getMetricColor(PerformanceMetric metric, double value) {
    switch (metric) {
      case PerformanceMetric.fps:
        if (value >= 50) return Colors.green;
        if (value >= 30) return Colors.orange;
        return Colors.red;
      case PerformanceMetric.memory:
        if (value <= 200) return Colors.green;
        if (value <= 500) return Colors.orange;
        return Colors.red;
      case PerformanceMetric.cpu:
      case PerformanceMetric.gpu:
        if (value <= 50) return Colors.green;
        if (value <= 80) return Colors.orange;
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Color _getAlertColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.low:
        return Colors.blue;
      case AlertSeverity.medium:
        return Colors.orange;
      case AlertSeverity.high:
        return Colors.red;
      case AlertSeverity.critical:
        return Colors.purple;
    }
  }
}

/// 组件生成器页面
class ComponentGeneratorPage extends StatefulWidget {
  const ComponentGeneratorPage({Key? key}) : super(key: key);

  @override
  State<ComponentGeneratorPage> createState() => _ComponentGeneratorPageState();
}

class _ComponentGeneratorPageState extends State<ComponentGeneratorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'basic';
  bool _generateTest = true;
  bool _generateDoc = true;
  bool _generateExample = true;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Generator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Component Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a component name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Component Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'basic', child: Text('Basic')),
                  DropdownMenuItem(value: 'form', child: Text('Form')),
                  DropdownMenuItem(value: 'display', child: Text('Display')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Generation Options',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                title: const Text('Generate Test File'),
                value: _generateTest,
                onChanged: (value) {
                  setState(() {
                    _generateTest = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Generate Documentation'),
                value: _generateDoc,
                onChanged: (value) {
                  setState(() {
                    _generateDoc = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Generate Example'),
                value: _generateExample,
                onChanged: (value) {
                  setState(() {
                    _generateExample = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _generateComponent,
                  child: const Text('Generate Component'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _generateComponent() {
    if (_formKey.currentState!.validate()) {
      // 这里应该调用实际的组件生成逻辑
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Component ${_nameController.text} generated successfully!'),
        ),
      );
    }
  }
}

/// 主题定制器页面
class ThemeCustomizerPage extends StatelessWidget {
  const ThemeCustomizerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Theme Customizer'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  // 保存主题配置
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Theme Configuration',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildThemeModeSelector(themeProvider),
                const SizedBox(height: 16),
                _buildColorPickers(themeProvider),
                const SizedBox(height: 16),
                _buildThemePreview(),
                const SizedBox(height: 16),
                _buildExportOptions(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeModeSelector(ThemeProvider themeProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme Mode', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<ThemeMode>(
                    title: const Text('Light'),
                    value: ThemeMode.light,
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      themeProvider.setThemeMode(value!);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<ThemeMode>(
                    title: const Text('Dark'),
                    value: ThemeMode.dark,
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      themeProvider.setThemeMode(value!);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<ThemeMode>(
                    title: const Text('System'),
                    value: ThemeMode.system,
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      themeProvider.setThemeMode(value!);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPickers(ThemeProvider themeProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Colors', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildColorPicker('Primary Color', themeProvider.primaryColor, (color) {
              themeProvider.setPrimaryColor(color);
            }),
            const SizedBox(height: 8),
            _buildColorPicker('Secondary Color', themeProvider.secondaryColor, (color) {
              themeProvider.setSecondaryColor(color);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker(String label, Color currentColor, Function(Color) onChanged) {
    return ListTile(
      title: Text(label),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: currentColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
      ),
      onTap: () {
        // 显示颜色选择器
      },
    );
  }

  Widget _buildThemePreview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme Preview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Theme Preview Area'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportOptions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Export Options', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('Export as Dart Code'),
              trailing: const Icon(Icons.code),
              onTap: () {
                // 导出为Dart代码
              },
            ),
            ListTile(
              title: const Text('Export as JSON'),
              trailing: const Icon(Icons.data_object),
              onTap: () {
                // 导出为JSON
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 代码质量页面
class CodeQualityPage extends StatelessWidget {
  const CodeQualityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Quality'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // 刷新代码质量检查
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQualityMetrics(),
            const SizedBox(height: 24),
            _buildIssuesList(),
            const SizedBox(height: 24),
            _buildTestCoverage(),
            const SizedBox(height: 24),
            _buildCodeAnalysis(),
          ],
        ),
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
              'Quality Metrics',
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

  Widget _buildIssuesList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Code Issues',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                final issues = [
                  {'file': 'lib/components/button.dart', 'line': 25, 'message': 'Missing documentation', 'severity': 'warning'},
                  {'file': 'lib/utils/helpers.dart', 'line': 42, 'message': 'Unused variable', 'severity': 'info'},
                  {'file': 'lib/services/api.dart', 'line': 18, 'message': 'Long method', 'severity': 'warning'},
                  {'file': 'lib/models/user.dart', 'line': 35, 'message': 'Complex method', 'severity': 'error'},
                  {'file': 'lib/widgets/card.dart', 'line': 12, 'message': 'Code duplication', 'severity': 'warning'},
                ];
                return _buildIssueCard(issues[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueCard(Map<String, dynamic> issue) {
    final color = _getSeverityColor(issue['severity'] as String);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 4,
          color: color,
        ),
        title: Text(issue['message'] as String),
        subtitle: Text('${issue['file']}:${issue['line']}'),
        trailing: Icon(
          _getSeverityIcon(issue['severity'] as String),
          color: color,
        ),
      ),
    );
  }

  Widget _buildTestCoverage() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Test Coverage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Test Coverage Chart'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Code Analysis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Complexity Analysis'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 16),
            const Text('Maintainability Index'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.85,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'info':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getSeverityIcon(String severity) {
    switch (severity) {
      case 'error':
        return Icons.error;
      case 'warning':
        return Icons.warning;
      case 'info':
        return Icons.info;
      default:
        return Icons.help;
    }
  }
}

/// 监控页面
class MonitoringPage extends StatelessWidget {
  const MonitoringPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-time Monitoring'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // 显示监控设置
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 这里应该添加实时监控内容
            Text('Real-time monitoring content'),
          ],
        ),
      ),
    );
  }
}

/// 主题提供者
class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeData _darkTheme = ThemeData.dark();
  ThemeMode _themeMode = ThemeMode.system;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.orange;

  ThemeData get currentTheme => _currentTheme;
  ThemeData get darkTheme => _darkTheme;
  ThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _updateTheme();
    notifyListeners();
  }

  void setPrimaryColor(Color color) {
    _primaryColor = color;
    _updateTheme();
    notifyListeners();
  }

  void setSecondaryColor(Color color) {
    _secondaryColor = color;
    _updateTheme();
    notifyListeners();
  }

  void _updateTheme() {
    _currentTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        secondary: _secondaryColor,
      ),
    );

    _darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        secondary: _secondaryColor,
        brightness: Brightness.dark,
      ),
    );
  }
}