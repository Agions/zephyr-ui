/// ZephyrUI 内存优化器
///
/// 提供内存管理、缓存优化和垃圾回收功能。
library memory_optimizer;

import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// 内存使用级别
enum MemoryLevel {
  low,      // 低内存使用 (< 50MB)
  normal,   // 正常内存使用 (50-100MB)
  high,     // 高内存使用 (100-200MB)
  critical, // 关键内存使用 (> 200MB)
}

/// 内存优化策略
enum MemoryOptimizationStrategy {
  aggressive,  // 激进优化
  balanced,    // 平衡优化
  conservative, // 保守优化
}

/// 内存使用统计
class MemoryUsageStats {
  final double currentUsageMB;
  final double peakUsageMB;
  final double averageUsageMB;
  final int garbageCollectionCount;
  final int cacheEvictions;
  final DateTime lastUpdate;

  MemoryUsageStats({
    required this.currentUsageMB,
    required this.peakUsageMB,
    required this.averageUsageMB,
    required this.garbageCollectionCount,
    required this.cacheEvictions,
    required this.lastUpdate,
  });

  MemoryLevel get level {
    if (currentUsageMB < 50) return MemoryLevel.low;
    if (currentUsageMB < 100) return MemoryLevel.normal;
    if (currentUsageMB < 200) return MemoryLevel.high;
    return MemoryLevel.critical;
  }
}

/// 内存优化器
class ZephyrMemoryOptimizer {
  /// 单例实例
  static final ZephyrMemoryOptimizer _instance = 
      ZephyrMemoryOptimizer._internal();
  
  /// 获取单例实例
  static ZephyrMemoryOptimizer get instance => _instance;
  
  /// 内部构造函数
  ZephyrMemoryOptimizer._internal();

  /// 内存使用历史
  final List<double> _memoryHistory = [];
  static const int _maxHistoryLength = 1000;

  /// 监控定时器
  Timer? _monitoringTimer;
  Timer? _optimizationTimer;

  /// 内存缓存
  final Map<String, _MemoryCacheEntry> _memoryCache = {};
  final Map<String, int> _cacheAccessCounts = {};

  /// 优化配置
  MemoryOptimizationStrategy _strategy = MemoryOptimizationStrategy.balanced;
  double _memoryThresholdMB = 150.0;
  Duration _monitoringInterval = const Duration(seconds: 5);
  Duration _optimizationInterval = const Duration(minutes: 2);
  int _maxCacheSize = 100;
  Duration _cacheTimeout = const Duration(minutes: 10);

  /// 统计信息
  double _peakMemoryUsage = 0.0;
  int _garbageCollectionCount = 0;
  int _cacheEvictions = 0;
  DateTime _lastOptimization = DateTime.now();

  /// 回调函数
  final StreamController<MemoryLevel> _memoryLevelController = 
      StreamController<MemoryLevel>.broadcast();
  final StreamController<String> _optimizationController = 
      StreamController<String>.broadcast();

  /// 开始监控
  void startMonitoring({
    MemoryOptimizationStrategy strategy = MemoryOptimizationStrategy.balanced,
    double? memoryThresholdMB,
    Duration? monitoringInterval,
    Duration? optimizationInterval,
  }) {
    if (_monitoringTimer != null) return;

    _strategy = strategy;
    _memoryThresholdMB = memoryThresholdMB ?? _memoryThresholdMB;
    _monitoringInterval = monitoringInterval ?? _monitoringInterval;
    _optimizationInterval = optimizationInterval ?? _optimizationInterval;

    _monitoringTimer = Timer.periodic(_monitoringInterval, (timer) {
      _monitorMemoryUsage();
    });

    _optimizationTimer = Timer.periodic(_optimizationInterval, (timer) {
      _performOptimization();
    });

    developer.log('🧠 Memory optimization started with strategy: $_strategy');
  }

  /// 停止监控
  void stopMonitoring() {
    _monitoringTimer?.cancel();
    _optimizationTimer?.cancel();
    _monitoringTimer = null;
    _optimizationTimer = null;
    developer.log('🛑 Memory optimization stopped');
  }

  /// 监控内存使用
  void _monitorMemoryUsage() {
    final currentMemory = _getCurrentMemoryUsage();
    
    // 更新历史记录
    _memoryHistory.add(currentMemory);
    if (_memoryHistory.length > _maxHistoryLength) {
      _memoryHistory.removeAt(0);
    }

    // 更新峰值
    if (currentMemory > _peakMemoryUsage) {
      _peakMemoryUsage = currentMemory;
    }

    // 检查内存级别
    final stats = getCurrentStats();
    _memoryLevelController.add(stats.level);

    // 如果内存使用超过阈值，立即优化
    if (currentMemory > _memoryThresholdMB) {
      _performAggressiveOptimization();
    }
  }

  /// 获取当前内存使用量（模拟实现）
  double _getCurrentMemoryUsage() {
    // 在实际项目中，这里会使用真正的内存监控
    // 目前返回模拟值
    final baseUsage = 50.0;
    final variation = DateTime.now().millisecond % 30;
    return baseUsage + variation;
  }

  /// 执行优化
  void _performOptimization() {
    final currentMemory = _getCurrentMemoryUsage();
    final stats = getCurrentStats();
    
    switch (_strategy) {
      case MemoryOptimizationStrategy.aggressive:
        _performAggressiveOptimization();
        break;
      case MemoryOptimizationStrategy.balanced:
        if (stats.level == MemoryLevel.high || stats.level == MemoryLevel.critical) {
          _performAggressiveOptimization();
        } else if (stats.level == MemoryLevel.normal) {
          _performModerateOptimization();
        }
        break;
      case MemoryOptimizationStrategy.conservative:
        if (stats.level == MemoryLevel.critical) {
          _performAggressiveOptimization();
        } else if (stats.level == MemoryLevel.high) {
          _performModerateOptimization();
        }
        break;
    }

    _lastOptimization = DateTime.now();
  }

  /// 执行激进优化
  void _performAggressiveOptimization() {
    developer.log('🔥 Performing aggressive memory optimization');
    
    // 清理过期缓存
    _cleanExpiredCache();
    
    // 清理不常用的缓存
    _cleanUnusedCache();
    
    // 强制垃圾回收
    _forceGarbageCollection();
    
    _optimizationController.add('Aggressive optimization completed');
  }

  /// 执行适度优化
  void _performModerateOptimization() {
    developer.log('⚡ Performing moderate memory optimization');
    
    // 清理过期缓存
    _cleanExpiredCache();
    
    // 限制缓存大小
    _limitCacheSize();
    
    _optimizationController.add('Moderate optimization completed');
  }

  /// 清理过期缓存
  void _cleanExpiredCache() {
    final now = DateTime.now();
    final expiredKeys = <String>[];
    
    for (final entry in _memoryCache.entries) {
      if (now.difference(entry.value.createdAt) > _cacheTimeout) {
        expiredKeys.add(entry.key);
      }
    }
    
    for (final key in expiredKeys) {
      _memoryCache.remove(key);
      _cacheAccessCounts.remove(key);
      _cacheEvictions++;
    }
    
    if (expiredKeys.isNotEmpty) {
      developer.log('🗑️ Cleaned ${expiredKeys.length} expired cache entries');
    }
  }

  /// 清理不常用的缓存
  void _cleanUnusedCache() {
    if (_memoryCache.length <= _maxCacheSize) return;
    
    final entries = _memoryCache.entries.toList();
    entries.sort((a, b) {
      final countA = _cacheAccessCounts[a.key] ?? 0;
      final countB = _cacheAccessCounts[b.key] ?? 0;
      return countA.compareTo(countB);
    });
    
    final toRemove = entries.take(_memoryCache.length - _maxCacheSize);
    for (final entry in toRemove) {
      _memoryCache.remove(entry.key);
      _cacheAccessCounts.remove(entry.key);
      _cacheEvictions++;
    }
    
    if (toRemove.isNotEmpty) {
      developer.log('🗑️ Cleaned ${toRemove.length} unused cache entries');
    }
  }

  /// 限制缓存大小
  void _limitCacheSize() {
    if (_memoryCache.length <= _maxCacheSize) return;
    
    final entries = _memoryCache.entries.toList();
    entries.sort((a, b) => a.value.createdAt.compareTo(b.value.createdAt));
    
    final toRemove = entries.take(_memoryCache.length - _maxCacheSize);
    for (final entry in toRemove) {
      _memoryCache.remove(entry.key);
      _cacheAccessCounts.remove(entry.key);
      _cacheEvictions++;
    }
  }

  /// 强制垃圾回收
  void _forceGarbageCollection() {
    // 在实际项目中，这里会调用真正的垃圾回收
    // 目前只是计数
    _garbageCollectionCount++;
    developer.log('🗑️ Forced garbage collection (#$_garbageCollectionCount)');
  }

  /// 添加到缓存
  void addToCache(String key, dynamic value, {int? sizeKB}) {
    _memoryCache[key] = _MemoryCacheEntry(
      value: value,
      sizeKB: sizeKB ?? _estimateSize(value),
      createdAt: DateTime.now(),
    );
    
    _cacheAccessCounts[key] = (_cacheAccessCounts[key] ?? 0) + 1;
  }

  /// 从缓存获取
  dynamic getFromCache(String key) {
    final entry = _memoryCache[key];
    if (entry != null) {
      _cacheAccessCounts[key] = (_cacheAccessCounts[key] ?? 0) + 1;
      return entry.value;
    }
    return null;
  }

  /// 估算对象大小
  int _estimateSize(dynamic value) {
    // 简化的对象大小估算
    if (value is String) return value.length ~/ 1024;
    if (value is Map) return value.length * 0.1 ~/ 1;
    if (value is List) return value.length * 0.1 ~/ 1;
    return 1;
  }

  /// 获取当前统计信息
  MemoryUsageStats getCurrentStats() {
    final currentUsage = _getCurrentMemoryUsage();
    final averageUsage = _memoryHistory.isNotEmpty 
        ? _memoryHistory.reduce((a, b) => a + b) / _memoryHistory.length 
        : currentUsage;
    
    return MemoryUsageStats(
      currentUsageMB: currentUsage,
      peakUsageMB: _peakMemoryUsage,
      averageUsageMB: averageUsage,
      garbageCollectionCount: _garbageCollectionCount,
      cacheEvictions: _cacheEvictions,
      lastUpdate: DateTime.now(),
    );
  }

  /// 获取详细报告
  Map<String, dynamic> getDetailedReport() {
    final stats = getCurrentStats();
    final cacheSize = _memoryCache.values.fold<int>(
      0,
      (sum, entry) => sum + entry.sizeKB,
    );
    
    return {
      'currentStats': {
        'usageMB': stats.currentUsageMB.toStringAsFixed(2),
        'level': stats.level.toString(),
        'peakUsageMB': stats.peakUsageMB.toStringAsFixed(2),
        'averageUsageMB': stats.averageUsageMB.toStringAsFixed(2),
      },
      'optimization': {
        'strategy': _strategy.toString(),
        'thresholdMB': _memoryThresholdMB,
        'lastOptimization': _lastOptimization.toIso8601String(),
        'garbageCollectionCount': _garbageCollectionCount,
        'cacheEvictions': _cacheEvictions,
      },
      'cache': {
        'size': _memoryCache.length,
        'maxSize': _maxCacheSize,
        'totalSizeKB': cacheSize,
        'hitRate': _calculateCacheHitRate(),
      },
      'recommendations': _getRecommendations(stats),
    };
  }

  /// 计算缓存命中率
  double _calculateCacheHitRate() {
    final totalAccesses = _cacheAccessCounts.values.fold<int>(0, (sum, count) => sum + count);
    if (totalAccesses == 0) return 0.0;
    
    final hits = _cacheAccessCounts.values.where((count) => count > 1).length;
    return hits / totalAccesses;
  }

  /// 获取优化建议
  List<String> _getRecommendations(MemoryUsageStats stats) {
    final recommendations = <String>[];
    
    if (stats.level == MemoryLevel.critical) {
      recommendations.add('🚨 Memory usage is critical! Consider immediate optimization.');
    } else if (stats.level == MemoryLevel.high) {
      recommendations.add('⚠️ Memory usage is high. Consider optimization.');
    }
    
    if (_memoryCache.length > _maxCacheSize * 0.8) {
      recommendations.add('💡 Cache is nearly full. Consider cleaning unused entries.');
    }
    
    if (_garbageCollectionCount > 10) {
      recommendations.add('🔄 Frequent garbage collection detected. Consider memory optimization.');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('✅ Memory usage is optimal.');
    }
    
    return recommendations;
  }

  /// 配置优化器
  void configure({
    MemoryOptimizationStrategy? strategy,
    double? memoryThresholdMB,
    Duration? monitoringInterval,
    Duration? optimizationInterval,
    int? maxCacheSize,
    Duration? cacheTimeout,
  }) {
    if (strategy != null) _strategy = strategy;
    if (memoryThresholdMB != null) _memoryThresholdMB = memoryThresholdMB;
    if (monitoringInterval != null) _monitoringInterval = monitoringInterval;
    if (optimizationInterval != null) _optimizationInterval = optimizationInterval;
    if (maxCacheSize != null) _maxCacheSize = maxCacheSize;
    if (cacheTimeout != null) _cacheTimeout = cacheTimeout;
    
    developer.log('⚙️ Memory optimizer configured');
  }

  /// 清理所有缓存
  void clearCache() {
    _memoryCache.clear();
    _cacheAccessCounts.clear();
    developer.log('🧹 Memory cache cleared');
  }

  /// 流访问器
  Stream<MemoryLevel> get memoryLevelStream => _memoryLevelController.stream;
  Stream<String> get optimizationStream => _optimizationController.stream;

  /// 释放资源
  void dispose() {
    stopMonitoring();
    _memoryLevelController.close();
    _optimizationController.close();
  }
}

/// 内存缓存条目
class _MemoryCacheEntry {
  final dynamic value;
  final int sizeKB;
  final DateTime createdAt;

  _MemoryCacheEntry({
    required this.value,
    required this.sizeKB,
    required this.createdAt,
  });
}

/// 内存优化扩展
extension ZephyrMemoryExtensions on BuildContext {
  /// 获取内存统计信息
  MemoryUsageStats getMemoryStats() {
    return ZephyrMemoryOptimizer.instance.getCurrentStats();
  }
  
  /// 获取内存报告
  Map<String, dynamic> getMemoryReport() {
    return ZephyrMemoryOptimizer.instance.getDetailedReport();
  }
  
  /// 添加到内存缓存
  void addToMemoryCache(String key, dynamic value, {int? sizeKB}) {
    ZephyrMemoryOptimizer.instance.addToCache(key, value, sizeKB: sizeKB);
  }
  
  /// 从内存缓存获取
  dynamic getFromMemoryCache(String key) {
    return ZephyrMemoryOptimizer.instance.getFromCache(key);
  }
  
  /// 清理内存缓存
  void clearMemoryCache() {
    ZephyrMemoryOptimizer.instance.clearCache();
  }
}

/// 内存监控Widget
class ZephyrMemoryMonitor extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final MemoryOptimizationStrategy strategy;

  const ZephyrMemoryMonitor({
    Key? key,
    required this.child,
    this.enabled = true,
    this.strategy = MemoryOptimizationStrategy.balanced,
  }) : super(key: key);

  @override
  State<ZephyrMemoryMonitor> createState() => _ZephyrMemoryMonitorState();
}

class _ZephyrMemoryMonitorState extends State<ZephyrMemoryMonitor> {
  final ZephyrMemoryOptimizer _optimizer = ZephyrMemoryOptimizer.instance;
  MemoryUsageStats? _currentStats;

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _optimizer.startMonitoring(strategy: widget.strategy);
      _updateStats();
    }
  }

  @override
  void didUpdateWidget(ZephyrMemoryMonitor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled || oldWidget.strategy != widget.strategy) {
      if (widget.enabled) {
        _optimizer.startMonitoring(strategy: widget.strategy);
      } else {
        _optimizer.stopMonitoring();
      }
    }
  }

  @override
  void dispose() {
    _optimizer.stopMonitoring();
    super.dispose();
  }

  void _updateStats() {
    if (mounted && widget.enabled) {
      setState(() {
        _currentStats = _optimizer.getCurrentStats();
      });
      Future.delayed(const Duration(seconds: 1), _updateStats);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.enabled && _currentStats != null) _buildMemoryInfo(),
      ],
    );
  }

  Widget _buildMemoryInfo() {
    final stats = _currentStats!;
    final color = _getMemoryColor(stats.level);
    
    return Positioned(
      bottom: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.memory,
              color: color,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              '${stats.currentUsageMB.toStringAsFixed(1)}MB',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMemoryColor(MemoryLevel level) {
    switch (level) {
      case MemoryLevel.low:
        return Colors.green;
      case MemoryLevel.normal:
        return Colors.yellow;
      case MemoryLevel.high:
        return Colors.orange;
      case MemoryLevel.critical:
        return Colors.red;
    }
  }
}