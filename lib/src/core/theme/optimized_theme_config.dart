/// ZephyrUI 优化主题配置
///
/// 提供主题配置的优化管理，包括懒加载、缓存和性能监控。
library optimized_theme_config;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:zephyr_ui/zephyr_ui.dart';
import 'optimized_theme_data.dart';

/// 主题配置管理器
class ZephyrOptimizedThemeConfig {
  /// 单例实例
  static final ZephyrOptimizedThemeConfig _instance = 
      ZephyrOptimizedThemeConfig._internal();
  
  /// 获取单例实例
  static ZephyrOptimizedThemeConfig get instance => _instance;
  
  /// 内部构造函数
  ZephyrOptimizedThemeConfig._internal();

  /// 主题缓存
  final Map<String, ZephyrThemeData> _themeCache = {};
  
  /// 主题配置历史
  final List<ThemeConfigHistory> _configHistory = [];
  
  /// 预热状态
  bool _isWarmedUp = false;
  
  /// 缓存统计
  int _cacheHits = 0;
  int _cacheMisses = 0;
  
  /// 获取主题配置
  ZephyrThemeData getThemeConfig({
    Brightness brightness = Brightness.light,
    String? variant,
    Map<String, dynamic>? customColors,
    bool useCache = true,
  }) {
    final cacheKey = _generateCacheKey(brightness, variant, customColors);
    
    if (useCache && _themeCache.containsKey(cacheKey)) {
      _cacheHits++;
      final theme = _themeCache[cacheKey]!;
      if (theme is ZephyrOptimizedThemeData) {
        theme.recordUsage();
      }
      return theme;
    }
    
    _cacheMisses++;
    final theme = _createTheme(brightness, variant, customColors);
    
    if (useCache) {
      _themeCache[cacheKey] = theme;
      _addToHistory(cacheKey, brightness, variant);
    }
    
    return theme;
  }
  
  /// 创建主题
  ZephyrThemeData _createTheme(
    Brightness brightness, 
    String? variant, 
    Map<String, dynamic>? customColors,
  ) {
    switch (variant) {
      case 'enterprise':
        return brightness == Brightness.light
            ? ZephyrThemeConfig.createEnterpriseTheme(brightness: brightness)
            : ZephyrThemeConfig.createEnterpriseTheme(brightness: brightness);
      case 'modern':
        return brightness == Brightness.light
            ? ZephyrThemeConfig.createModernTheme(brightness: brightness)
            : ZephyrThemeConfig.createModernTheme(brightness: brightness);
      case 'nature':
        return brightness == Brightness.light
            ? ZephyrThemeConfig.createNatureTheme(brightness: brightness)
            : ZephyrThemeConfig.createNatureTheme(brightness: brightness);
      default:
        return brightness == Brightness.light
            ? ZephyrOptimizedThemeData.light()
            : ZephyrOptimizedThemeData.dark();
    }
  }
  
  /// 生成缓存键
  String _generateCacheKey(Brightness brightness, String? variant, Map<String, dynamic>? customColors) {
    final parts = [brightness.toString()];
    if (variant != null) parts.add(variant);
    if (customColors != null) parts.add(customColors.hashCode.toString());
    return parts.join('_');
  }
  
  /// 添加到历史记录
  void _addToHistory(String cacheKey, Brightness brightness, String? variant) {
    _configHistory.add(ThemeConfigHistory(
      cacheKey: cacheKey,
      brightness: brightness,
      variant: variant,
      timestamp: DateTime.now(),
    ));
    
    // 保持历史记录在合理范围内
    if (_configHistory.length > 100) {
      _configHistory.removeRange(0, _configHistory.length - 100);
    }
  }
  
  /// 预热缓存
  void warmUpCache() {
    if (_isWarmedUp) return;
    
    // 预热常用主题
    final themes = [
      ZephyrOptimizedThemeData.light(),
      ZephyrOptimizedThemeData.dark(),
      ZephyrThemeConfig.createEnterpriseTheme(),
      ZephyrThemeConfig.createModernTheme(),
      ZephyrThemeConfig.createNatureTheme(),
    ];
    
    for (final theme in themes) {
      final cacheKey = _generateCacheKey(theme.brightness, null, null);
      _themeCache[cacheKey] = theme;
    }
    
    _isWarmedUp = true;
    
    if (foundation.kDebugMode) {
      print('🔥 Theme cache warmed up with ${themes.length} themes');
    }
  }
  
  /// 清除缓存
  void clearCache() {
    _themeCache.clear();
    _configHistory.clear();
    _cacheHits = 0;
    _cacheMisses = 0;
    _isWarmedUp = false;
    
    if (foundation.kDebugMode) {
      print('🧹 Theme cache cleared');
    }
  }
  
  /// 获取缓存统计
  Map<String, dynamic> getCacheStats() {
    final totalRequests = _cacheHits + _cacheMisses;
    final hitRate = totalRequests > 0 ? _cacheHits / totalRequests : 0.0;
    
    return {
      'cacheSize': _themeCache.length,
      'cacheHits': _cacheHits,
      'cacheMisses': _cacheMisses,
      'hitRate': hitRate.toStringAsFixed(2),
      'totalRequests': totalRequests,
      'isWarmedUp': _isWarmedUp,
      'historySize': _configHistory.length,
    };
  }
  
  /// 获取性能报告
  Map<String, dynamic> getPerformanceReport() {
    final stats = getCacheStats();
    final memoryUsage = _estimateMemoryUsage();
    
    return {
      'cache': stats,
      'memory': {
        'estimatedUsageMB': memoryUsage.toStringAsFixed(2),
        'averageThemeSizeKB': _themeCache.isNotEmpty ? (memoryUsage * 1024 / _themeCache.length).toStringAsFixed(2) : '0',
      },
      'recommendations': _getOptimizationRecommendations(),
    };
  }
  
  /// 估算内存使用
  double _estimateMemoryUsage() {
    // 简化的内存估算
    final baseThemeSize = 0.5; // MB per theme
    return _themeCache.length * baseThemeSize;
  }
  
  /// 获取优化建议
  List<String> _getOptimizationRecommendations() {
    final recommendations = <String>[];
    final stats = getCacheStats();
    
    if (stats['cacheSize'] > 20) {
      recommendations.add('⚠️ Theme cache is large (${stats['cacheSize']} items). Consider reducing cache size.');
    }
    
    if (double.parse(stats['hitRate']) < 0.7) {
      recommendations.add('⚠️ Cache hit rate is low (${stats['hitRate']}). Consider optimizing cache strategy.');
    }
    
    if (!stats['isWarmedUp']) {
      recommendations.add('💡 Consider warming up cache during app initialization.');
    }
    
    if (recommendations.isEmpty) {
      recommendations.add('✅ Theme cache is performing well.');
    }
    
    return recommendations;
  }
  
  /// 优化缓存
  void optimizeCache() {
    // 移除不常用的主题
    final keysToRemove = <String>[];
    final now = DateTime.now();
    
    for (final entry in _themeCache.entries) {
      if (entry.value is ZephyrOptimizedThemeData) {
        final theme = entry.value as ZephyrOptimizedThemeData;
        if (theme.shouldEvict(const Duration(hours: 1))) {
          keysToRemove.add(entry.key);
        }
      }
    }
    
    for (final key in keysToRemove) {
      _themeCache.remove(key);
    }
    
    if (foundation.kDebugMode && keysToRemove.isNotEmpty) {
      print('🗑️ Removed ${keysToRemove.length} unused themes from cache');
    }
  }
}

/// 主题配置历史记录
class ThemeConfigHistory {
  final String cacheKey;
  final Brightness brightness;
  final String? variant;
  final DateTime timestamp;
  
  ThemeConfigHistory({
    required this.cacheKey,
    required this.brightness,
    this.variant,
    required this.timestamp,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'cacheKey': cacheKey,
      'brightness': brightness.toString(),
      'variant': variant,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// 主题配置构建器
class ZephyrThemeConfigBuilder {
  Brightness _brightness = Brightness.light;
  String? _variant;
  Map<String, dynamic> _customColors = {};
  bool _useCache = true;
  
  ZephyrThemeConfigBuilder brightness(Brightness value) {
    _brightness = value;
    return this;
  }
  
  ZephyrThemeConfigBuilder variant(String? value) {
    _variant = value;
    return this;
  }
  
  ZephyrThemeConfigBuilder addCustomColor(String name, Color color) {
    _customColors[name] = color;
    return this;
  }
  
  ZephyrThemeConfigBuilder useCache(bool value) {
    _useCache = value;
    return this;
  }
  
  ZephyrThemeData build() {
    return ZephyrOptimizedThemeConfig.instance.getThemeConfig(
      brightness: _brightness,
      variant: _variant,
      customColors: _customColors.isNotEmpty ? _customColors : null,
      useCache: _useCache,
    );
  }
}

/// 主题配置扩展
extension ZephyrThemeConfigExtensions on BuildContext {
  /// 获取优化的主题配置
  ZephyrThemeData getOptimizedThemeConfig({
    String? variant,
    Map<String, dynamic>? customColors,
    bool useCache = true,
  }) {
    final brightness = Theme.of(this).brightness;
    return ZephyrOptimizedThemeConfig.instance.getThemeConfig(
      brightness: brightness,
      variant: variant,
      customColors: customColors,
      useCache: useCache,
    );
  }
  
  /// 获取主题缓存统计
  Map<String, dynamic> getThemeCacheStats() {
    return ZephyrOptimizedThemeConfig.instance.getCacheStats();
  }
  
  /// 清除主题缓存
  void clearThemeCache() {
    ZephyrOptimizedThemeConfig.instance.clearCache();
  }
}