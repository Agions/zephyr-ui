/// 测试覆盖率工具
///
/// 提供测试覆盖率相关的工具和方法
library test_coverage;

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

/// 测试覆盖率工具类
class TestCoverageUtils {
  /// 生成覆盖率报告
  static Future<void> generateCoverageReport({
    String coveragePath = 'coverage/lcov.info',
    String outputPath = 'coverage/html',
    String format = 'lcov',
  }) async {
    // 确保覆盖率文件存在
    final coverageFile = File(coveragePath);
    if (!await coverageFile.exists()) {
      throw Exception('Coverage file not found: $coveragePath');
    }
    
    // 生成HTML报告
    if (format == 'html') {
      await _generateHtmlReport(coveragePath, outputPath);
    }
    
    // 生成JSON报告
    await _generateJsonReport(coveragePath, '$outputPath/coverage.json');
    
    // 生成摘要报告
    await _generateSummaryReport(coveragePath, '$outputPath/summary.md');
  }
  
  /// 生成HTML报告
  static Future<void> _generateHtmlReport(
    String coveragePath,
    String outputPath,
  ) async {
    final process = await Process.run(
      'genhtml',
      [coveragePath, '--output-directory', outputPath],
    );
    
    if (process.exitCode != 0) {
      throw Exception('Failed to generate HTML report: ${process.stderr}');
    }
  }
  
  /// 生成JSON报告
  static Future<void> _generateJsonReport(
    String coveragePath,
    String outputPath,
  ) async {
    final coverageData = await _parseLcovFile(coveragePath);
    final report = {
      'format': 'lcov',
      'version': '2.0',
      'generatedAt': DateTime.now().toIso8601String(),
      'coverage': coverageData,
    };
    
    final file = File(outputPath);
    await file.create(recursive: true);
    await file.writeAsString(jsonEncode(report));
  }
  
  /// 生成摘要报告
  static Future<void> _generateSummaryReport(
    String coveragePath,
    String outputPath,
  ) async {
    final coverageData = await _parseLcovFile(coveragePath);
    final summary = _calculateSummary(coverageData);
    
    final report = '''
# 测试覆盖率报告

## 生成时间
${DateTime.now().toString()}

## 覆盖率统计
- 总体覆盖率: ${summary['totalCoverage']}%
- 行覆盖率: ${summary['lineCoverage']}%
- 函数覆盖率: ${summary['functionCoverage']}%
- 分支覆盖率: ${summary['branchCoverage']}%

## 文件详情
${_generateFileDetails(coverageData)}

## 建议
${_generateRecommendations(summary)}
''';
    
    final file = File(outputPath);
    await file.create(recursive: true);
    await file.writeAsString(report);
  }
  
  /// 解析LCOV文件
  static Future<Map<String, dynamic>> _parseLcovFile(String filePath) async {
    final file = File(filePath);
    final lines = await file.readAsLines();
    
    final coverageData = <String, dynamic>{};
    String? currentFile;
    Map<String, dynamic>? currentFileData;
    
    for (final line in lines) {
      if (line.startsWith('SF:')) {
        // 开始文件记录
        currentFile = line.substring(3);
        currentFileData = {
          'lines': <String, dynamic>{},
          'functions': <String, dynamic>{},
          'branches': <String, dynamic>{},
        };
      } else if (line.startsWith('LF:')) {
        // 行数
        currentFileData!['totalLines'] = int.parse(line.substring(3));
      } else if (line.startsWith('LH:')) {
        // 命中行数
        currentFileData!['hitLines'] = int.parse(line.substring(3));
      } else if (line.startsWith('BRF:')) {
        // 分支数
        currentFileData!['totalBranches'] = int.parse(line.substring(4));
      } else if (line.startsWith('BRH:')) {
        // 命中分支数
        currentFileData!['hitBranches'] = int.parse(line.substring(4));
      } else if (line.startsWith('DA:')) {
        // 行数据
        final parts = line.substring(3).split(',');
        final lineNumber = parts[0];
        final hitCount = int.parse(parts[1]);
        currentFileData!['lines'][lineNumber] = hitCount;
      } else if (line.startsWith('FN:')) {
        // 函数数据
        final parts = line.substring(3).split(',');
        final lineNumber = parts[0];
        final functionName = parts[1];
        currentFileData!['functions'][lineNumber] = {
          'name': functionName,
          'hit': false,
        };
      } else if (line.startsWith('FNDA:')) {
        // 函数命中数据
        final parts = line.substring(5).split(',');
        final hitCount = int.parse(parts[0]);
        final functionName = parts[1];
        for (final funcData in currentFileData!['functions'].values) {
          if (funcData['name'] == functionName) {
            funcData['hit'] = hitCount > 0;
            break;
          }
        }
      } else if (line.startsWith('BRA:')) {
        // 分支数据
        final parts = line.substring(4).split(',');
        final lineNumber = parts[0];
        final blockNumber = parts[1];
        final branchNumber = parts[2];
        final hitCount = int.parse(parts[3]);
        currentFileData!['branches']['$lineNumber.$blockNumber.$branchNumber'] = hitCount > 0;
      } else if (line.startsWith('end_of_record')) {
        // 结束文件记录
        if (currentFile != null && currentFileData != null) {
          coverageData[currentFile] = currentFileData;
        }
      }
    }
    
    return coverageData;
  }
  
  /// 计算覆盖率摘要
  static Map<String, dynamic> _calculateSummary(Map<String, dynamic> coverageData) {
    int totalLines = 0;
    int hitLines = 0;
    int totalFunctions = 0;
    int hitFunctions = 0;
    int totalBranches = 0;
    int hitBranches = 0;
    
    for (final fileData in coverageData.values) {
      totalLines += fileData['totalLines'] ?? 0;
      hitLines += fileData['hitLines'] ?? 0;
      
      for (final funcData in fileData['functions'].values) {
        totalFunctions++;
        if (funcData['hit']) hitFunctions++;
      }
      
      for (final branchHit in fileData['branches'].values) {
        totalBranches++;
        if (branchHit) hitBranches++;
      }
    }
    
    final lineCoverage = totalLines > 0 ? (hitLines / totalLines * 100).round() : 0;
    final functionCoverage = totalFunctions > 0 ? (hitFunctions / totalFunctions * 100).round() : 0;
    final branchCoverage = totalBranches > 0 ? (hitBranches / totalBranches * 100).round() : 0;
    final totalCoverage = ((lineCoverage + functionCoverage + branchCoverage) / 3).round();
    
    return {
      'totalLines': totalLines,
      'hitLines': hitLines,
      'totalFunctions': totalFunctions,
      'hitFunctions': hitFunctions,
      'totalBranches': totalBranches,
      'hitBranches': hitBranches,
      'lineCoverage': lineCoverage,
      'functionCoverage': functionCoverage,
      'branchCoverage': branchCoverage,
      'totalCoverage': totalCoverage,
    };
  }
  
  /// 生成文件详情
  static String _generateFileDetails(Map<String, dynamic> coverageData) {
    final buffer = StringBuffer();
    
    for (final entry in coverageData.entries) {
      final filePath = entry.key;
      final fileData = entry.value;
      
      final totalLines = fileData['totalLines'] ?? 0;
      final hitLines = fileData['hitLines'] ?? 0;
      final lineCoverage = totalLines > 0 ? (hitLines / totalLines * 100).round() : 0;
      
      buffer.writeln('### $filePath');
      buffer.writeln('- 行覆盖率: $lineCoverage%');
      buffer.writeln('- 总行数: $totalLines');
      buffer.writeln('- 命中行数: $hitLines');
      buffer.writeln();
    }
    
    return buffer.toString();
  }
  
  /// 生成建议
  static String _generateRecommendations(Map<String, dynamic> summary) {
    final buffer = StringBuffer();
    
    final totalCoverage = summary['totalCoverage'];
    final lineCoverage = summary['lineCoverage'];
    final functionCoverage = summary['functionCoverage'];
    final branchCoverage = summary['branchCoverage'];
    
    if (totalCoverage < 80) {
      buffer.writeln('1. 总体覆盖率较低，建议增加测试用例');
    }
    
    if (lineCoverage < 80) {
      buffer.writeln('2. 行覆盖率较低，建议增加代码路径的测试');
    }
    
    if (functionCoverage < 80) {
      buffer.writeln('3. 函数覆盖率较低，建议增加函数调用的测试');
    }
    
    if (branchCoverage < 80) {
      buffer.writeln('4. 分支覆盖率较低，建议增加条件分支的测试');
    }
    
    buffer.writeln('5. 建议定期运行覆盖率测试以监控代码质量');
    buffer.writeln('6. 考虑使用覆盖率报告来识别测试盲点');
    
    return buffer.toString();
  }
  
  /// 验证覆盖率阈值
  static void expectCoverageThreshold(
    Map<String, dynamic> summary, {
    double minTotalCoverage = 85.0,
    double minLineCoverage = 80.0,
    double minFunctionCoverage = 80.0,
    double minBranchCoverage = 70.0,
    String? reason,
  }) {
    expect(summary['totalCoverage'],
      greaterThanOrEqualTo(minTotalCoverage),
      reason: reason ?? 'Total coverage below threshold');
    
    expect(summary['lineCoverage'],
      greaterThanOrEqualTo(minLineCoverage),
      reason: reason ?? 'Line coverage below threshold');
    
    expect(summary['functionCoverage'],
      greaterThanOrEqualTo(minFunctionCoverage),
      reason: reason ?? 'Function coverage below threshold');
    
    expect(summary['branchCoverage'],
      greaterThanOrEqualTo(minBranchCoverage),
      reason: reason ?? 'Branch coverage below threshold');
  }
  
  /// 检查覆盖率回归
  static void checkCoverageRegression(
    Map<String, dynamic> currentSummary,
    Map<String, dynamic> baselineSummary, {
    double tolerance = 5.0,
    String? reason,
  }) {
    final totalRegression = baselineSummary['totalCoverage'] - currentSummary['totalCoverage'];
    final lineRegression = baselineSummary['lineCoverage'] - currentSummary['lineCoverage'];
    final functionRegression = baselineSummary['functionCoverage'] - currentSummary['functionCoverage'];
    final branchRegression = baselineSummary['branchCoverage'] - currentSummary['branchCoverage'];
    
    if (totalRegression > tolerance) {
      fail('${reason ?? "Total coverage regression detected"}: ${totalRegression.toStringAsFixed(1)}%');
    }
    
    if (lineRegression > tolerance) {
      fail('${reason ?? "Line coverage regression detected"}: ${lineRegression.toStringAsFixed(1)}%');
    }
    
    if (functionRegression > tolerance) {
      fail('${reason ?? "Function coverage regression detected"}: ${functionRegression.toStringAsFixed(1)}%');
    }
    
    if (branchRegression > tolerance) {
      fail('${reason ?? "Branch coverage regression detected"}: ${branchRegression.toStringAsFixed(1)}%');
    }
  }
  
  /// 获取文件覆盖率
  static Map<String, dynamic> getFileCoverage(
    Map<String, dynamic> coverageData,
    String filePath,
  ) {
    final fileData = coverageData[filePath];
    if (fileData == null) {
      throw Exception('File not found in coverage data: $filePath');
    }
    
    final totalLines = fileData['totalLines'] ?? 0;
    final hitLines = fileData['hitLines'] ?? 0;
    final lineCoverage = totalLines > 0 ? (hitLines / totalLines * 100).round() : 0;
    
    int totalFunctions = 0;
    int hitFunctions = 0;
    for (final funcData in fileData['functions'].values) {
      totalFunctions++;
      if (funcData['hit']) hitFunctions++;
    }
    
    int totalBranches = 0;
    int hitBranches = 0;
    for (final branchHit in fileData['branches'].values) {
      totalBranches++;
      if (branchHit) hitBranches++;
    }
    
    final functionCoverage = totalFunctions > 0 ? (hitFunctions / totalFunctions * 100).round() : 0;
    final branchCoverage = totalBranches > 0 ? (hitBranches / totalBranches * 100).round() : 0;
    
    return {
      'filePath': filePath,
      'totalLines': totalLines,
      'hitLines': hitLines,
      'totalFunctions': totalFunctions,
      'hitFunctions': hitFunctions,
      'totalBranches': totalBranches,
      'hitBranches': hitBranches,
      'lineCoverage': lineCoverage,
      'functionCoverage': functionCoverage,
      'branchCoverage': branchCoverage,
    };
  }
  
  /// 获取未覆盖的行
  static List<int> getUncoveredLines(
    Map<String, dynamic> coverageData,
    String filePath,
  ) {
    final fileData = coverageData[filePath];
    if (fileData == null) {
      throw Exception('File not found in coverage data: $filePath');
    }
    
    final uncoveredLines = <int>[];
    for (final entry in fileData['lines'].entries) {
      final lineNumber = int.parse(entry.key);
      final hitCount = entry.value;
      if (hitCount == 0) {
        uncoveredLines.add(lineNumber);
      }
    }
    
    return uncoveredLines;
  }
  
  /// 获取未测试的函数
  static List<String> getUntestedFunctions(
    Map<String, dynamic> coverageData,
    String filePath,
  ) {
    final fileData = coverageData[filePath];
    if (fileData == null) {
      throw Exception('File not found in coverage data: $filePath');
    }
    
    final untestedFunctions = <String>[];
    for (final funcData in fileData['functions'].values) {
      if (!funcData['hit']) {
        untestedFunctions.add(funcData['name']);
      }
    }
    
    return untestedFunctions;
  }
  
  /// 获取未覆盖的分支
  static List<String> getUncoveredBranches(
    Map<String, dynamic> coverageData,
    String filePath,
  ) {
    final fileData = coverageData[filePath];
    if (fileData == null) {
      throw Exception('File not found in coverage data: $filePath');
    }
    
    final uncoveredBranches = <String>[];
    for (final entry in fileData['branches'].entries) {
      if (!entry.value) {
        uncoveredBranches.add(entry.key);
      }
    }
    
    return uncoveredBranches;
  }
  
  /// 生成覆盖率报告
  static Future<void> generateCoverageReport({
    String coveragePath = 'coverage/lcov.info',
    String outputPath = 'coverage/report',
    String format = 'html',
  }) async {
    await generateCoverageReport(
      coveragePath: coveragePath,
      outputPath: outputPath,
      format: format,
    );
  }
  
  /// 清理覆盖率文件
  static Future<void> cleanCoverageFiles({
    String coveragePath = 'coverage',
  }) async {
    final directory = Directory(coveragePath);
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
}

/// 测试覆盖率配置
class TestCoverageConfig {
  static const double defaultMinTotalCoverage = 85.0;
  static const double defaultMinLineCoverage = 80.0;
  static const double defaultMinFunctionCoverage = 80.0;
  static const double defaultMinBranchCoverage = 70.0;
  static const double defaultTolerance = 5.0;
  
  final double minTotalCoverage;
  final double minLineCoverage;
  final double minFunctionCoverage;
  final double minBranchCoverage;
  final double tolerance;
  
  const TestCoverageConfig({
    this.minTotalCoverage = defaultMinTotalCoverage,
    this.minLineCoverage = defaultMinLineCoverage,
    this.minFunctionCoverage = defaultMinFunctionCoverage,
    this.minBranchCoverage = defaultMinBranchCoverage,
    this.tolerance = defaultTolerance,
  });
  
  /// 创建严格的覆盖率配置
  const TestCoverageConfig.strict({
    double minTotalCoverage = 90.0,
    double minLineCoverage = 85.0,
    double minFunctionCoverage = 85.0,
    double minBranchCoverage = 75.0,
    double tolerance = 3.0,
  }) : this(
    minTotalCoverage: minTotalCoverage,
    minLineCoverage: minLineCoverage,
    minFunctionCoverage: minFunctionCoverage,
    minBranchCoverage: minBranchCoverage,
    tolerance: tolerance,
  );
  
  /// 创建宽松的覆盖率配置
  const TestCoverageConfig.relaxed({
    double minTotalCoverage = 80.0,
    double minLineCoverage = 75.0,
    double minFunctionCoverage = 75.0,
    double minBranchCoverage = 65.0,
    double tolerance = 10.0,
  }) : this(
    minTotalCoverage: minTotalCoverage,
    minLineCoverage: minLineCoverage,
    minFunctionCoverage: minFunctionCoverage,
    minBranchCoverage: minBranchCoverage,
    tolerance: tolerance,
  );
}

/// 测试覆盖率报告生成器
class TestCoverageReportGenerator {
  /// 生成HTML报告
  static Future<void> generateHtmlReport(
    Map<String, dynamic> coverageData,
    String outputPath,
  ) async {
    final summary = TestCoverageUtils._calculateSummary(coverageData);
    
    final html = '''
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>测试覆盖率报告</title>
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
        .file-path {
            font-family: monospace;
            font-size: 14px;
            color: #666;
        }
        .coverage-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            color: white;
        }
        .coverage-badge.high {
            background: #4CAF50;
        }
        .coverage-badge.medium {
            background: #FF9800;
        }
        .coverage-badge.low {
            background: #F44336;
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
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 测试覆盖率报告</h1>
        
        <div class="summary">
            <div class="card">
                <h3>总体覆盖率</h3>
                <div class="value">${summary['totalCoverage']}%</div>
                <div class="progress-bar">
                    <div class="progress-fill ${_getCoverageClass(summary['totalCoverage'])}" 
                         style="width: ${summary['totalCoverage']}%"></div>
                </div>
            </div>
            <div class="card">
                <h3>行覆盖率</h3>
                <div class="value">${summary['lineCoverage']}%</div>
                <div class="progress-bar">
                    <div class="progress-fill ${_getCoverageClass(summary['lineCoverage'])}" 
                         style="width: ${summary['lineCoverage']}%"></div>
                </div>
            </div>
            <div class="card">
                <h3>函数覆盖率</h3>
                <div class="value">${summary['functionCoverage']}%</div>
                <div class="progress-bar">
                    <div class="progress-fill ${_getCoverageClass(summary['functionCoverage'])}" 
                         style="width: ${summary['functionCoverage']}%"></div>
                </div>
            </div>
            <div class="card">
                <h3>分支覆盖率</h3>
                <div class="value">${summary['branchCoverage']}%</div>
                <div class="progress-bar">
                    <div class="progress-fill ${_getCoverageClass(summary['branchCoverage'])}" 
                         style="width: ${summary['branchCoverage']}%"></div>
                </div>
            </div>
        </div>

        <h2>📁 文件详情</h2>
        <table>
            <thead>
                <tr>
                    <th>文件路径</th>
                    <th>行覆盖率</th>
                    <th>函数覆盖率</th>
                    <th>分支覆盖率</th>
                    <th>状态</th>
                </tr>
            </thead>
            <tbody>
                ${_generateFileRows(coverageData)}
            </tbody>
        </table>

        <div class="recommendations">
            <h3>💡 建议</h3>
            <ul>
                ${_generateRecommendations(summary)}
            </ul>
        </div>
    </div>
</body>
</html>
''';
    
    final file = File('$outputPath/index.html');
    await file.create(recursive: true);
    await file.writeAsString(html);
  }
  
  /// 获取覆盖率等级样式
  static String _getCoverageClass(double coverage) {
    if (coverage >= 80) return '';
    if (coverage >= 60) return 'medium';
    return 'low';
  }
  
  /// 生成文件行
  static String _generateFileRows(Map<String, dynamic> coverageData) {
    final buffer = StringBuffer();
    
    for (final entry in coverageData.entries) {
      final filePath = entry.key;
      final fileData = entry.value;
      
      final totalLines = fileData['totalLines'] ?? 0;
      final hitLines = fileData['hitLines'] ?? 0;
      final lineCoverage = totalLines > 0 ? (hitLines / totalLines * 100).round() : 0;
      
      int totalFunctions = 0;
      int hitFunctions = 0;
      for (final funcData in fileData['functions'].values) {
        totalFunctions++;
        if (funcData['hit']) hitFunctions++;
      }
      final functionCoverage = totalFunctions > 0 ? (hitFunctions / totalFunctions * 100).round() : 0;
      
      int totalBranches = 0;
      int hitBranches = 0;
      for (final branchHit in fileData['branches'].values) {
        totalBranches++;
        if (branchHit) hitBranches++;
      }
      final branchCoverage = totalBranches > 0 ? (hitBranches / totalBranches * 100).round() : 0;
      
      final averageCoverage = ((lineCoverage + functionCoverage + branchCoverage) / 3).round();
      final coverageClass = _getCoverageClass(averageCoverage);
      
      buffer.writeln('''
                <tr>
                    <td class="file-path">${path.basename(filePath)}</td>
                    <td>${lineCoverage}%</td>
                    <td>${functionCoverage}%</td>
                    <td>${branchCoverage}%</td>
                    <td><span class="coverage-badge $coverageClass">${_getCoverageLabel(averageCoverage)}</span></td>
                </tr>
''');
    }
    
    return buffer.toString();
  }
  
  /// 获取覆盖率标签
  static String _getCoverageLabel(double coverage) {
    if (coverage >= 80) return '优秀';
    if (coverage >= 60) return '良好';
    if (coverage >= 40) return '一般';
    return '需改进';
  }
  
  /// 生成建议
  static List<String> _generateRecommendations(Map<String, dynamic> summary) {
    final recommendations = <String>[];
    
    final totalCoverage = summary['totalCoverage'];
    final lineCoverage = summary['lineCoverage'];
    final functionCoverage = summary['functionCoverage'];
    final branchCoverage = summary['branchCoverage'];
    
    if (totalCoverage < 80) {
      recommendations.add('总体覆盖率较低，建议增加测试用例');
    }
    
    if (lineCoverage < 80) {
      recommendations.add('行覆盖率较低，建议增加代码路径的测试');
    }
    
    if (functionCoverage < 80) {
      recommendations.add('函数覆盖率较低，建议增加函数调用的测试');
    }
    
    if (branchCoverage < 80) {
      recommendations.add('分支覆盖率较低，建议增加条件分支的测试');
    }
    
    recommendations.add('建议定期运行覆盖率测试以监控代码质量');
    recommendations.add('考虑使用覆盖率报告来识别测试盲点');
    
    return recommendations;
  }
}