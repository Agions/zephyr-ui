import 'dart:convert';
import 'dart:io';

void main() {
  // 分析内存使用数据
  final memoryData = File('memory_usage_report.json');
  if (!memoryData.existsSync()) {
    print('内存使用报告文件不存在');
    return;
  }
  
  final content = memoryData.readAsStringSync();
  final data = jsonDecode(content) as Map<String, dynamic>;
  
  print('=== 内存使用分析报告 ===');
  print('分析时间: ${DateTime.now().toIso8601String()}');
  print('');
  
  final samples = data['samples'] as int;
  final meanMb = data['mean_mb'] as double;
  final maxMb = data['max_mb'] as double;
  final minMb = data['min_mb'] as double;
  
  print('采样数量: $samples');
  print('平均内存使用: ${meanMb.toStringAsFixed(2)} MB');
  print('最大内存使用: ${maxMb.toStringAsFixed(2)} MB');
  print('最小内存使用: ${minMb.toStringAsFixed(2)} MB');
  print('内存使用范围: ${(maxMb - minMb).toStringAsFixed(2)} MB');
  
  // 内存使用评估
  print('');
  print('=== 内存使用评估 ===');
  if (meanMb < 50) {
    print('✅ 内存使用优秀 (< 50MB)');
  } else if (meanMb < 100) {
    print('⚠️  内存使用良好 (50-100MB)');
  } else if (meanMb < 200) {
    print('❌ 内存使用偏高 (100-200MB)');
  } else {
    print('🚨 内存使用过高 (> 200MB)');
  }
  
  // 内存波动评估
  final memoryRange = maxMb - minMb;
  if (memoryRange < 10) {
    print('✅ 内存使用稳定 (< 10MB波动)');
  } else if (memoryRange < 50) {
    print('⚠️  内存使用中等波动 (10-50MB波动)');
  } else {
    print('❌ 内存使用波动较大 (> 50MB波动)');
  }
  
  // 生成建议
  print('');
  print('=== 优化建议 ===');
  if (meanMb > 100) {
    print('1. 考虑实现内存池管理');
    print('2. 检查是否有内存泄漏');
    print('3. 优化大型数据结构的存储');
    print('4. 考虑使用懒加载策略');
  }
  
  if (memoryRange > 50) {
    print('5. 检查内存分配和释放模式');
    print('6. 考虑实现内存缓存策略');
    print('7. 优化垃圾回收触发时机');
  }
  
  // 生成报告
  final report = {
    'analysis_time': DateTime.now().toIso8601String(),
    'memory_stats': data,
    'assessment': {
      'memory_usage_level': meanMb < 50 ? 'excellent' : 
                          meanMb < 100 ? 'good' : 
                          meanMb < 200 ? 'high' : 'critical',
      'memory_stability': memoryRange < 10 ? 'stable' : 
                         memoryRange < 50 ? 'moderate' : 'volatile',
    },
    'recommendations': _generateRecommendations(meanMb, memoryRange),
  };
  
  // 保存分析报告
  final analysisFile = File('memory_analysis_report.json');
  analysisFile.writeAsStringSync(jsonEncode(report));
  
  print('');
  print('详细分析报告已保存到: memory_analysis_report.json');
}

List<String> _generateRecommendations(double meanMb, double memoryRange) {
  final recommendations = <String>[];
  
  if (meanMb > 100) {
    recommendations.add('实现内存池管理以减少频繁的内存分配');
    recommendations.add('检查大型数据结构，考虑使用更高效的存储方式');
    recommendations.add('实现对象池模式重用对象');
    recommendations.add('考虑使用懒加载策略减少初始内存占用');
  }
  
  if (memoryRange > 50) {
    recommendations.add('监控内存分配和释放模式');
    recommendations.add('实现智能缓存策略');
    recommendations.add('优化垃圾回收触发时机');
    recommendations.add('考虑使用内存监控工具进行深入分析');
  }
  
  if (meanMb < 50 && memoryRange < 10) {
    recommendations.add('当前内存使用表现优秀，继续保持');
    recommendations.add('定期监控内存使用趋势');
  }
  
  return recommendations;
}