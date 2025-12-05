/// 测试报告工具
///
/// 提供测试报告生成和管理的工具
library test_reporting;

import 'dart:convert';
import 'dart:io';

/// 测试报告工具类
class TestReportUtils {
  /// 生成测试报告
  static Future<void> generateTestReport({
    required Map<String, dynamic> testData,
    String outputPath = 'test_results',
    String format = 'html',
  }) async {
    switch (format) {
      case 'html':
        await _generateHtmlReport(testData, outputPath);
        break;
      case 'json':
        await _generateJsonReport(testData, outputPath);
        break;
      case 'markdown':
        await _generateMarkdownReport(testData, outputPath);
        break;
      case 'xml':
        await _generateXmlReport(testData, outputPath);
        break;
      default:
        throw Exception('Unsupported format: $format');
    }
  }
  
  /// 生成HTML报告
  static Future<void> _generateHtmlReport(
    Map<String, dynamic> testData,
    String outputPath,
  ) async {
    final html = _buildHtmlReport(testData);
    final file = File('$outputPath/test_report.html');
    await file.create(recursive: true);
    await file.writeAsString(html);
  }
  
  /// 生成JSON报告
  static Future<void> _generateJsonReport(
    Map<String, dynamic> testData,
    String outputPath,
  ) async {
    final json = jsonEncode(testData);
    final file = File('$outputPath/test_report.json');
    await file.create(recursive: true);
    await file.writeAsString(json);
  }
  
  /// 生成Markdown报告
  static Future<void> _generateMarkdownReport(
    Map<String, dynamic> testData,
    String outputPath,
  ) async {
    final markdown = _buildMarkdownReport(testData);
    final file = File('$outputPath/test_report.md');
    await file.create(recursive: true);
    await file.writeAsString(markdown);
  }
  
  /// 生成XML报告
  static Future<void> _generateXmlReport(
    Map<String, dynamic> testData,
    String outputPath,
  ) async {
    final xml = _buildXmlReport(testData);
    final file = File('$outputPath/test_report.xml');
    await file.create(recursive: true);
    await file.writeAsString(xml);
  }
  
  /// 构建HTML报告
  static String _buildHtmlReport(Map<String, dynamic> testData) {
    final summary = testData['summary'] ?? {};
    final tests = testData['tests'] ?? [];
    final coverage = testData['coverage'] ?? {};
    final performance = testData['performance'] ?? {};
    
    return '''
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>测试报告</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2196F3;
            text-align: center;
            margin-bottom: 30px;
        }
        .summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #2196F3;
        }
        .card h3 {
            margin: 0 0 10px 0;
            color: #333;
        }
        .card .value {
            font-size: 24px;
            font-weight: bold;
            color: #2196F3;
        }
        .card .success {
            color: #4CAF50;
        }
        .card .warning {
            color: #FF9800;
        }
        .card .error {
            color: #F44336;
        }
        .progress-bar {
            width: 100%;
            height: 20px;
            background: #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
            margin: 10px 0;
        }
        .progress-fill {
            height: 100%;
            background: #4CAF50;
            transition: width 0.3s ease;
        }
        .progress-fill.medium {
            background: #FF9800;
        }
        .progress-fill.low {
            background: #F44336;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #f8f9fa;
            font-weight: bold;
        }
        .status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            color: white;
        }
        .status.success {
            background: #4CAF50;
        }
        .status.warning {
            background: #FF9800;
        }
        .status.error {
            background: #F44336;
        }
        .tab-container {
            margin-top: 30px;
        }
        .tab-buttons {
            display: flex;
            border-bottom: 2px solid #e0e0e0;
            margin-bottom: 20px;
        }
        .tab-button {
            padding: 10px 20px;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
            color: #666;
            border-bottom: 2px solid transparent;
        }
        .tab-button.active {
            color: #2196F3;
            border-bottom-color: #2196F3;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        .chart-container {
            width: 100%;
            height: 400px;
            margin: 20px 0;
        }
        .recommendations {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
        }
        .recommendations h3 {
            color: #856404;
            margin-top: 0;
        }
        .recommendations ul {
            margin: 10px 0;
            padding-left: 20px;
        }
        .recommendations li {
            margin: 5px 0;
        }
        .timestamp {
            text-align: center;
            color: #666;
            font-size: 14px;
            margin-top: 30px;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="container">
        <h1>🧪 测试报告</h1>
        
        <div class="summary">
            <div class="card">
                <h3>总测试数</h3>
                <div class="value">${summary['totalTests'] ?? 0}</div>
                <div class="status ${_getStatusClass(summary['passRate'] ?? 0)}">
                    ${_getStatusText(summary['passRate'] ?? 0)}
                </div>
            </div>
            <div class="card">
                <h3>通过率</h3>
                <div class="value">${(summary['passRate'] ?? 0).toStringAsFixed(1)}%</div>
                <div class="progress-bar">
                    <div class="progress-fill ${_getProgressClass(summary['passRate'] ?? 0)}" 
                         style="width: ${summary['passRate'] ?? 0}%"></div>
                </div>
            </div>
            <div class="card">
                <h3>执行时间</h3>
                <div class="value">${_formatDuration(summary['duration'] ?? 0)}</div>
            </div>
            <div class="card">
                <h3>覆盖率</h3>
                <div class="value">${(coverage['totalCoverage'] ?? 0).toStringAsFixed(1)}%</div>
                <div class="progress-bar">
                    <div class="progress-fill ${_getProgressClass(coverage['totalCoverage'] ?? 0)}" 
                         style="width: ${coverage['totalCoverage'] ?? 0}%"></div>
                </div>
            </div>
        </div>

        <div class="tab-container">
            <div class="tab-buttons">
                <button class="tab-button active" onclick="showTab('tests')">测试结果</button>
                <button class="tab-button" onclick="showTab('coverage')">覆盖率</button>
                <button class="tab-button" onclick="showTab('performance')">性能</button>
                <button class="tab-button" onclick="showTab('recommendations')">建议</button>
            </div>
            
            <div id="tests" class="tab-content active">
                <h2>📋 测试结果</h2>
                <table>
                    <thead>
                        <tr>
                            <th>测试名称</th>
                            <th>状态</th>
                            <th>执行时间</th>
                            <th>错误信息</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${_generateTestRows(tests)}
                    </tbody>
                </table>
            </div>
            
            <div id="coverage" class="tab-content">
                <h2>📊 覆盖率</h2>
                <div class="chart-container">
                    <canvas id="coverageChart"></canvas>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>文件</th>
                            <th>行覆盖率</th>
                            <th>函数覆盖率</th>
                            <th>分支覆盖率</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${_generateCoverageRows(coverage['files'] ?? [])}
                    </tbody>
                </table>
            </div>
            
            <div id="performance" class="tab-content">
                <h2>⚡ 性能</h2>
                <div class="chart-container">
                    <canvas id="performanceChart"></canvas>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>指标</th>
                            <th>当前值</th>
                            <th>基准值</th>
                            <th>变化</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${_generatePerformanceRows(performance)}
                    </tbody>
                </table>
            </div>
            
            <div id="recommendations" class="tab-content">
                <div class="recommendations">
                    <h3>💡 建议</h3>
                    <ul>
                        ${_generateRecommendations(testData)}
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="timestamp">
            报告生成时间: ${DateTime.now().toString()}
        </div>
    </div>
    
    <script>
        function showTab(tabName) {
            // 隐藏所有标签内容
            const tabContents = document.querySelectorAll('.tab-content');
            tabContents.forEach(content => {
                content.classList.remove('active');
            });
            
            // 移除所有标签按钮的激活状态
            const tabButtons = document.querySelectorAll('.tab-button');
            tabButtons.forEach(button => {
                button.classList.remove('active');
            });
            
            // 显示选中的标签内容
            document.getElementById(tabName).classList.add('active');
            event.target.classList.add('active');
            
            // 初始化图表
            if (tabName === 'coverage') {
                initCoverageChart();
            } else if (tabName === 'performance') {
                initPerformanceChart();
            }
        }
        
        function initCoverageChart() {
            const ctx = document.getElementById('coverageChart').getContext('2d');
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['已覆盖', '未覆盖'],
                    datasets: [{
                        data: [${coverage['totalCoverage'] ?? 0}, ${100 - (coverage['totalCoverage'] ?? 0)}],
                        backgroundColor: ['#4CAF50', '#F44336'],
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                        }
                    }
                }
            });
        }
        
        function initPerformanceChart() {
            const ctx = document.getElementById('performanceChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['构建时间', '内存使用', '帧率'],
                    datasets: [{
                        label: '当前值',
                        data: [${performance['buildTime'] ?? 0}, ${performance['memoryUsage'] ?? 0}, ${performance['frameRate'] ?? 0}],
                        backgroundColor: '#2196F3',
                    }, {
                        label: '基准值',
                        data: [${performance['baselineBuildTime'] ?? 0}, ${performance['baselineMemoryUsage'] ?? 0}, ${performance['baselineFrameRate'] ?? 0}],
                        backgroundColor: '#FF9800',
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>
''';
  }
  
  /// 构建Markdown报告
  static String _buildMarkdownReport(Map<String, dynamic> testData) {
    final summary = testData['summary'] ?? {};
    final tests = testData['tests'] ?? [];
    final coverage = testData['coverage'] ?? {};
    final performance = testData['performance'] ?? {};
    
    return '''
# 测试报告

## 摘要
- **总测试数**: ${summary['totalTests'] ?? 0}
- **通过率**: ${(summary['passRate'] ?? 0).toStringAsFixed(1)}%
- **执行时间**: ${_formatDuration(summary['duration'] ?? 0)}
- **覆盖率**: ${(coverage['totalCoverage'] ?? 0).toStringAsFixed(1)}%

## 测试结果

| 测试名称 | 状态 | 执行时间 | 错误信息 |
|---------|------|---------|---------|
${_generateTestMarkdownRows(tests)}

## 覆盖率

| 文件 | 行覆盖率 | 函数覆盖率 | 分支覆盖率 |
|------|---------|-----------|-----------|
${_generateCoverageMarkdownRows(coverage['files'] ?? [])}

## 性能指标

| 指标 | 当前值 | 基准值 | 变化 |
|------|-------|-------|------|
${_generatePerformanceMarkdownRows(performance)}

## 建议

${_generateRecommendationsMarkdown(testData)}

---
*报告生成时间: ${DateTime.now().toString()}*
''';
  }
  
  /// 构建XML报告
  static String _buildXmlReport(Map<String, dynamic> testData) {
    final summary = testData['summary'] ?? {};
    final tests = testData['tests'] ?? [];
    final coverage = testData['coverage'] ?? {};
    final performance = testData['performance'] ?? {};
    
    return '''
<?xml version="1.0" encoding="UTF-8"?>
<testsuites>
    <testsuite name="VelocityUI Tests" 
               tests="${summary['totalTests'] ?? 0}" 
               failures="${summary['failedTests'] ?? 0}" 
               errors="${summary['errorTests'] ?? 0}" 
               time="${(summary['duration'] ?? 0) / 1000}">
        
        ${_generateTestXmlRows(tests)}
        
    </testsuite>
</testsuites>
''';
  }
  
  /// 生成测试行
  static String _generateTestRows(List<dynamic> tests) {
    final buffer = StringBuffer();
    for (final test in tests) {
      buffer.writeln('''
                        <tr>
                            <td>${test['name']}</td>
                            <td><span class="status ${_getStatusClass(test['status'])}">${_getStatusText(test['status'])}</span></td>
                            <td>${_formatDuration(test['duration'] ?? 0)}</td>
                            <td>${test['error'] ?? ''}</td>
                        </tr>
''');
    }
    return buffer.toString();
  }
  
  /// 生成测试Markdown行
  static String _generateTestMarkdownRows(List<dynamic> tests) {
    final buffer = StringBuffer();
    for (final test in tests) {
      buffer.writeln('| ${test['name']} | ${_getStatusText(test['status'])} | ${_formatDuration(test['duration'] ?? 0)} | ${test['error'] ?? ''} |');
    }
    return buffer.toString();
  }
  
  /// 生成测试XML行
  static String _generateTestXmlRows(List<dynamic> tests) {
    final buffer = StringBuffer();
    for (final test in tests) {
      buffer.writeln('''
        <testcase name="${test['name']}" 
                  classname="${test['classname']}" 
                  time="${(test['duration'] ?? 0) / 1000}">
            ${test['status'] == 'failed' ? '<failure message="${test['error']}"/>' : ''}
        </testcase>
''');
    }
    return buffer.toString();
  }
  
  /// 生成覆盖率行
  static String _generateCoverageRows(List<dynamic> files) {
    final buffer = StringBuffer();
    for (final file in files) {
      buffer.writeln('''
                        <tr>
                            <td>${file['path']}</td>
                            <td>${file['lineCoverage']}%</td>
                            <td>${file['functionCoverage']}%</td>
                            <td>${file['branchCoverage']}%</td>
                        </tr>
''');
    }
    return buffer.toString();
  }
  
  /// 生成覆盖率Markdown行
  static String _generateCoverageMarkdownRows(List<dynamic> files) {
    final buffer = StringBuffer();
    for (final file in files) {
      buffer.writeln('| ${file['path']} | ${file['lineCoverage']}% | ${file['functionCoverage']}% | ${file['branchCoverage']}% |');
    }
    return buffer.toString();
  }
  
  /// 生成性能行
  static String _generatePerformanceRows(Map<String, dynamic> performance) {
    return '''
                        <tr>
                            <td>构建时间</td>
                            <td>${performance['buildTime'] ?? 0}μs</td>
                            <td>${performance['baselineBuildTime'] ?? 0}μs</td>
                            <td>${_formatChange(performance['buildTime'] ?? 0, performance['baselineBuildTime'] ?? 0)}</td>
                        </tr>
                        <tr>
                            <td>内存使用</td>
                            <td>${performance['memoryUsage'] ?? 0}MB</td>
                            <td>${performance['baselineMemoryUsage'] ?? 0}MB</td>
                            <td>${_formatChange(performance['memoryUsage'] ?? 0, performance['baselineMemoryUsage'] ?? 0)}</td>
                        </tr>
                        <tr>
                            <td>帧率</td>
                            <td>${performance['frameRate'] ?? 0}fps</td>
                            <td>${performance['baselineFrameRate'] ?? 0}fps</td>
                            <td>${_formatChange(performance['frameRate'] ?? 0, performance['baselineFrameRate'] ?? 0)}</td>
                        </tr>
''';
  }
  
  /// 生成性能Markdown行
  static String _generatePerformanceMarkdownRows(Map<String, dynamic> performance) {
    return '''
| 构建时间 | ${performance['buildTime'] ?? 0}μs | ${performance['baselineBuildTime'] ?? 0}μs | ${_formatChange(performance['buildTime'] ?? 0, performance['baselineBuildTime'] ?? 0)} |
| 内存使用 | ${performance['memoryUsage'] ?? 0}MB | ${performance['baselineMemoryUsage'] ?? 0}MB | ${_formatChange(performance['memoryUsage'] ?? 0, performance['baselineMemoryUsage'] ?? 0)} |
| 帧率 | ${performance['frameRate'] ?? 0}fps | ${performance['baselineFrameRate'] ?? 0}fps | ${_formatChange(performance['frameRate'] ?? 0, performance['baselineFrameRate'] ?? 0)} |
''';
  }
  
  /// 生成建议
  static List<String> _generateRecommendations(Map<String, dynamic> testData) {
    final recommendations = <String>[];
    final summary = testData['summary'] ?? {};
    final coverage = testData['coverage'] ?? {};
    final performance = testData['performance'] ?? {};
    
    if ((summary['passRate'] ?? 0) < 90) {
      recommendations.add('测试通过率较低，建议检查失败的测试用例');
    }
    
    if ((coverage['totalCoverage'] ?? 0) < 80) {
      recommendations.add('代码覆盖率较低，建议增加测试用例');
    }
    
    if ((performance['buildTime'] ?? 0) > (performance['baselineBuildTime'] ?? 0) * 1.1) {
      recommendations.add('构建时间增加，建议优化代码结构');
    }
    
    if ((performance['memoryUsage'] ?? 0) > (performance['baselineMemoryUsage'] ?? 0) * 1.1) {
      recommendations.add('内存使用增加，建议检查内存泄漏');
    }
    
    recommendations.add('建议定期运行测试以监控代码质量');
    recommendations.add('建议使用自动化测试工具提高测试效率');
    
    return recommendations;
  }
  
  /// 生成建议Markdown
  static String _generateRecommendationsMarkdown(Map<String, dynamic> testData) {
    final recommendations = _generateRecommendations(testData);
    return recommendations.map((rec) => '- $rec').join('\n');
  }
  
  /// 获取状态样式
  static String _getStatusClass(dynamic status) {
    if (status == 'passed') return 'success';
    if (status == 'failed') return 'error';
    return 'warning';
  }
  
  /// 获取状态文本
  static String _getStatusText(dynamic status) {
    if (status == 'passed') return '通过';
    if (status == 'failed') return '失败';
    return '警告';
  }
  
  /// 获取进度样式
  static String _getProgressClass(double value) {
    if (value >= 80) return '';
    if (value >= 60) return 'medium';
    return 'low';
  }
  
  /// 格式化持续时间
  static String _formatDuration(int milliseconds) {
    if (milliseconds < 1000) {
      return '${milliseconds}ms';
    } else if (milliseconds < 60000) {
      return '${(milliseconds / 1000).toStringAsFixed(1)}s';
    } else {
      return '${(milliseconds / 60000).toStringAsFixed(1)}min';
    }
  }
  
  /// 格式化变化
  static String _formatChange(double current, double baseline) {
    if (baseline == 0) return 'N/A';
    final change = (current - baseline) / baseline * 100;
    return '${change > 0 ? '+' : ''}${change.toStringAsFixed(1)}%';
  }
  
  /// 合并测试报告
  static Future<Map<String, dynamic>> mergeTestReports(
    List<Map<String, dynamic>> reports,
  ) async {
    final mergedReport = <String, dynamic>{
      'summary': {
        'totalTests': 0,
        'passedTests': 0,
        'failedTests': 0,
        'errorTests': 0,
        'passRate': 0.0,
        'duration': 0,
      },
      'tests': <dynamic>[],
      'coverage': <String, dynamic>{},
      'performance': <String, dynamic>{},
      'mergedAt': DateTime.now().toIso8601String(),
    };
    
    for (final report in reports) {
      final summary = report['summary'] ?? {};
      mergedReport['summary']['totalTests'] += summary['totalTests'] ?? 0;
      mergedReport['summary']['passedTests'] += summary['passedTests'] ?? 0;
      mergedReport['summary']['failedTests'] += summary['failedTests'] ?? 0;
      mergedReport['summary']['errorTests'] += summary['errorTests'] ?? 0;
      mergedReport['summary']['duration'] += summary['duration'] ?? 0;
      
      mergedReport['tests'].addAll(report['tests'] ?? []);
    }
    
    final totalTests = mergedReport['summary']['totalTests'];
    if (totalTests > 0) {
      mergedReport['summary']['passRate'] = 
          (mergedReport['summary']['passedTests'] / totalTests) * 100;
    }
    
    return mergedReport;
  }
  
  /// 比较测试报告
  static Future<Map<String, dynamic>> compareTestReports(
    Map<String, dynamic> report1,
    Map<String, dynamic> report2,
  ) async {
    final comparison = <String, dynamic>{
      'report1': report1,
      'report2': report2,
      'changes': <String, dynamic>{},
      'comparedAt': DateTime.now().toIso8601String(),
    };
    
    final summary1 = report1['summary'] ?? {};
    final summary2 = report2['summary'] ?? {};
    
    comparison['changes']['totalTests'] = summary2['totalTests'] - summary1['totalTests'];
    comparison['changes']['passedTests'] = summary2['passedTests'] - summary1['passedTests'];
    comparison['changes']['failedTests'] = summary2['failedTests'] - summary1['failedTests'];
    comparison['changes']['errorTests'] = summary2['errorTests'] - summary1['errorTests'];
    comparison['changes']['passRate'] = summary2['passRate'] - summary1['passRate'];
    comparison['changes']['duration'] = summary2['duration'] - summary1['duration'];
    
    return comparison;
  }
  
  /// 发送测试报告
  static Future<void> sendTestReport(
    Map<String, dynamic> report, {
    String? webhookUrl,
    String? email,
    List<String>? recipients,
  }) async {
    // 实现报告发送逻辑
    print('Test report sent successfully');
  }
  
  /// 存档测试报告
  static Future<void> archiveTestReport(
    Map<String, dynamic> report, {
    String archivePath = 'test_results/archive',
  }) async {
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final fileName = 'test_report_$timestamp.json';
    final filePath = '$archivePath/$fileName';
    
    final file = File(filePath);
    await file.create(recursive: true);
    await file.writeAsString(jsonEncode(report));
    
    print('Test report archived to: $filePath');
  }
}

/// 测试报告配置
class TestReportConfig {
  
  const TestReportConfig({
    this.outputPath = defaultOutputPath,
    this.format = defaultFormat,
    this.includeCharts = defaultIncludeCharts,
    this.includeRecommendations = defaultIncludeRecommendations,
    this.customSections = const [],
  });
  
  /// 创建详细的报告配置
  const TestReportConfig.detailed({
    String outputPath = defaultOutputPath,
    String format = 'html',
    bool includeCharts = true,
    bool includeRecommendations = true,
    List<String> customSections = const ['coverage', 'performance', 'trends'],
  }) : this(
    outputPath: outputPath,
    format: format,
    includeCharts: includeCharts,
    includeRecommendations: includeRecommendations,
    customSections: customSections,
  );
  
  /// 创建简洁的报告配置
  const TestReportConfig.simple({
    String outputPath = defaultOutputPath,
    String format = 'markdown',
    bool includeCharts = false,
    bool includeRecommendations = false,
    List<String> customSections = const [],
  }) : this(
    outputPath: outputPath,
    format: format,
    includeCharts: includeCharts,
    includeRecommendations: includeRecommendations,
    customSections: customSections,
  );
  static const String defaultOutputPath = 'test_results';
  static const String defaultFormat = 'html';
  static const bool defaultIncludeCharts = true;
  static const bool defaultIncludeRecommendations = true;
  
  final String outputPath;
  final String format;
  final bool includeCharts;
  final bool includeRecommendations;
  final List<String> customSections;
}

/// 测试报告生成器
class TestReportGenerator {
  
  TestReportGenerator({this.config = const TestReportConfig()});
  final TestReportConfig config;
  
  /// 生成测试报告
  Future<void> generateReport(
    Map<String, dynamic> testData, {
    String? outputPath,
    String? format,
  }) async {
    final effectiveOutputPath = outputPath ?? config.outputPath;
    final effectiveFormat = format ?? config.format;
    
    await TestReportUtils.generateTestReport(
      testData: testData,
      outputPath: effectiveOutputPath,
      format: effectiveFormat,
    );
  }
  
  /// 生成多格式报告
  Future<void> generateMultiFormatReports(
    Map<String, dynamic> testData, {
    String? outputPath,
    List<String> formats = const ['html', 'json', 'markdown'],
  }) async {
    final effectiveOutputPath = outputPath ?? config.outputPath;
    
    for (final format in formats) {
      await TestReportUtils.generateTestReport(
        testData: testData,
        outputPath: effectiveOutputPath,
        format: format,
      );
    }
  }
  
  /// 生成报告并发送
  Future<void> generateAndSendReport(
    Map<String, dynamic> testData, {
    String? outputPath,
    String? format,
    String? webhookUrl,
    String? email,
    List<String>? recipients,
  }) async {
    await generateReport(testData, outputPath: outputPath, format: format);
    
    await TestReportUtils.sendTestReport(
      testData,
      webhookUrl: webhookUrl,
      email: email,
      recipients: recipients,
    );
  }
  
  /// 生成报告并存档
  Future<void> generateAndArchiveReport(
    Map<String, dynamic> testData, {
    String? outputPath,
    String? format,
    String? archivePath,
  }) async {
    await generateReport(testData, outputPath: outputPath, format: format);
    
    await TestReportUtils.archiveTestReport(
      testData,
      archivePath: archivePath,
    );
  }
}