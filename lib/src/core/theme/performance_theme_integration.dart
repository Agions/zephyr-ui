/// ZephyrUI 主题性能优化实现
///
/// 集成所有性能优化功能的主题系统。
library performance_theme_integration;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import 'optimized_theme_data.dart';
import 'optimized_theme_config.dart';
import '../../utils/performance/enhanced_performance_utils.dart';
import '../build/build_optimizer.dart';
import '../../utils/performance/performance_monitor.dart';

/// 性能优化主题提供者
class ZephyrPerformanceTheme extends StatefulWidget {
  final Widget child;
  final ZephyrThemeData? theme;
  final bool enablePerformanceMonitoring;
  final PerformanceLevel monitoringLevel;
  final bool enableMemoryOptimization;
  final bool enableHotReloadOptimization;

  const ZephyrPerformanceTheme({
    Key? key,
    required this.child,
    this.theme,
    this.enablePerformanceMonitoring = true,
    this.monitoringLevel = PerformanceLevel.medium,
    this.enableMemoryOptimization = true,
    this.enableHotReloadOptimization = true,
  }) : super(key: key);

  @override
  State<ZephyrPerformanceTheme> createState() => _ZephyrPerformanceThemeState();

  /// 获取当前主题数据
  static ZephyrThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedPerformanceTheme>();
    return theme?.data ?? ZephyrOptimizedThemeData.light();
  }

  /// 获取性能监控器
  static ZephyrEnhancedPerformanceMonitor getPerformanceMonitor(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedPerformanceTheme>();
    return theme?.performanceMonitor ?? ZephyrEnhancedPerformanceMonitor.instance;
  }
}

class _ZephyrPerformanceThemeState extends State<ZephyrPerformanceTheme> with TickerProviderStateMixin {
  late ZephyrThemeData _currentTheme;
  late ZephyrEnhancedPerformanceMonitor _performanceMonitor;
  late ZephyrBuildOptimizer _buildOptimizer;
  
  // 主题切换动画控制器
  late AnimationController _themeAnimationController;
  late Animation<double> _themeAnimation;

  @override
  void initState() {
    super.initState();
    
    // 初始化主题
    _currentTheme = widget.theme ?? ZephyrOptimizedThemeData.light();
    
    // 初始化性能监控器
    _performanceMonitor = ZephyrEnhancedPerformanceMonitor.instance;
    _buildOptimizer = ZephyrBuildOptimizer.instance;
    
    // 初始化动画控制器
    _themeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _themeAnimation = CurvedAnimation(
      parent: _themeAnimationController,
      curve: Curves.easeInOut,
    );
    
    // 启动性能优化
    _initializePerformanceOptimizations();
  }

  @override
  void didUpdateWidget(ZephyrPerformanceTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.theme != widget.theme) {
      _switchTheme(widget.theme ?? ZephyrOptimizedThemeData.light());
    }
  }

  @override
  void dispose() {
    _themeAnimationController.dispose();
    _performanceMonitor.dispose();
    super.dispose();
  }

  /// 初始化性能优化
  void _initializePerformanceOptimizations() {
    // 配置构建优化器
    _buildOptimizer.configure(
      optimizationLevel: BuildOptimizationLevel.maximum,
      buildMode: BuildMode.debug,
      enableIncrementalBuild: true,
      enableBuildCache: true,
      enableHotReload: widget.enableHotReloadOptimization,
    );
    
    // 启动性能监控
    if (widget.enablePerformanceMonitoring) {
      _performanceMonitor.startMonitoring(level: widget.monitoringLevel);
    }
    
    // 预热主题缓存
    ZephyrOptimizedThemeConfig.instance.warmUpCache();
    
    if (kDebugMode) {
      print('🚀 ZephyrUI Performance Theme initialized with optimizations');
      print('   • Performance Monitoring: ${widget.enablePerformanceMonitoring}');
      print('   • Memory Optimization: ${widget.enableMemoryOptimization}');
      print('   • Hot Reload Optimization: ${widget.enableHotReloadOptimization}');
      print('   • Monitoring Level: ${widget.monitoringLevel}');
    }
  }

  /// 切换主题（带性能优化）
  void _switchTheme(ZephyrThemeData newTheme) {
    if (widget.enablePerformanceMonitoring) {
      _performanceMonitor.measureExecutionTime('theme_switch', () {
        setState(() {
          _currentTheme = newTheme;
        });
      });
    } else {
      setState(() {
        _currentTheme = newTheme;
      });
    }
    
    // 主题切换动画
    _themeAnimationController.reset();
    _themeAnimationController.forward();
    
    if (kDebugMode) {
      print('🎨 Theme switched to ${newTheme.brightness == Brightness.light ? 'light' : 'dark'} mode');
    }
  }

  /// 获取性能报告
  EnhancedPerformanceReport getPerformanceReport() {
    return _performanceMonitor.getPerformanceReport();
  }

  /// 获取构建统计
  Map<String, dynamic> getBuildStats() {
    return _buildOptimizer.getBuildPerformanceReport();
  }

  /// 获取主题缓存统计
  Map<String, dynamic> getThemeCacheStats() {
    return ZephyrOptimizedThemeConfig.instance.getCacheStats();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedPerformanceTheme(
      data: _currentTheme,
      performanceMonitor: _performanceMonitor,
      buildOptimizer: _buildOptimizer,
      themeAnimation: _themeAnimation,
      child: AnimatedBuilder(
        animation: _themeAnimation,
        builder: (context, child) {
          return ZephyrPerformanceOverlay(
            enabled: widget.enablePerformanceMonitoring && kDebugMode,
            level: widget.monitoringLevel,
            child: child!,
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// 继承的主题Widget
class _InheritedPerformanceTheme extends InheritedWidget {
  final ZephyrThemeData data;
  final ZephyrEnhancedPerformanceMonitor performanceMonitor;
  final ZephyrBuildOptimizer buildOptimizer;
  final Animation<double> themeAnimation;

  const _InheritedPerformanceTheme({
    required this.data,
    required this.performanceMonitor,
    required this.buildOptimizer,
    required this.themeAnimation,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_InheritedPerformanceTheme oldWidget) {
    return oldWidget.data != data;
  }
}

/// 性能优化的主题切换器
class ZephyrPerformanceThemeSwitcher extends StatefulWidget {
  final Widget child;
  final Duration animationDuration;
  final Curve animationCurve;

  const ZephyrPerformanceThemeSwitcher({
    Key? key,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : super(key: key);

  @override
  State<ZephyrPerformanceThemeSwitcher> createState() => _ZephyrPerformanceThemeSwitcherState();

  /// 切换主题
  static void switchTheme(BuildContext context, Brightness brightness) {
    final state = context.findAncestorStateOfType<_ZephyrPerformanceThemeSwitcherState>();
    state?.switchTheme(brightness);
  }
}

class _ZephyrPerformanceThemeSwitcherState extends State<ZephyrPerformanceThemeSwitcher>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  ZephyrThemeData? _currentTheme;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 切换主题
  void switchTheme(Brightness brightness) {
    final performanceMonitor = ZephyrEnhancedPerformanceMonitor.instance;
    
    performanceMonitor.measureExecutionTime('theme_switch', () {
      setState(() {
        _currentTheme = brightness == Brightness.light
            ? ZephyrOptimizedThemeData.light()
            : ZephyrOptimizedThemeData.dark();
      });
    });
    
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = _currentTheme ?? ZephyrPerformanceTheme.of(context);
    
    return AnimatedTheme(
      data: ThemeData(
        brightness: effectiveTheme.brightness,
        primaryColor: effectiveTheme.primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: effectiveTheme.primaryColor,
          brightness: effectiveTheme.brightness,
        ),
      ),
      child: widget.child,
    );
  }
}

/// 性能优化的主题扩展
extension ZephyrThemeExtensions on BuildContext {
  /// 获取性能优化的主题数据
  ZephyrThemeData get optimizedTheme => ZephyrPerformanceTheme.of(this);
  
  /// 获取性能监控器
  ZephyrEnhancedPerformanceMonitor get performanceMonitor => 
      ZephyrPerformanceTheme.getPerformanceMonitor(this);
  
  /// 快速切换主题
  void switchTheme(Brightness brightness) {
    ZephyrPerformanceThemeSwitcher.switchTheme(this, brightness);
  }
  
  /// 记录自定义性能指标
  void recordPerformanceMetric(String name, double value) {
    performanceMonitor.measureExecutionTime(name, () => value);
  }
  
  /// 获取当前性能报告
  EnhancedPerformanceReport getPerformanceReport() {
    return performanceMonitor.getPerformanceReport();
  }
}

/// 性能主题预览组件
class ZephyrPerformanceThemePreview extends StatefulWidget {
  final Widget child;
  final bool showControls;
  final bool showStats;

  const ZephyrPerformanceThemePreview({
    Key? key,
    required this.child,
    this.showControls = true,
    this.showStats = true,
  }) : super(key: key);

  @override
  State<ZephyrPerformanceThemePreview> createState() => _ZephyrPerformanceThemePreviewState();
}

class _ZephyrPerformanceThemePreviewState extends State<ZephyrPerformanceThemePreview> {
  late ZephyrEnhancedPerformanceMonitor _monitor;
  Timer? _statsTimer;
  EnhancedPerformanceReport? _lastReport;

  @override
  void initState() {
    super.initState();
    _monitor = ZephyrEnhancedPerformanceMonitor.instance;
    
    if (widget.showStats) {
      _statsTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (mounted) {
          setState(() {
            _lastReport = _monitor.getPerformanceReport();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _statsTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.showControls) _buildControls(),
        if (widget.showStats && _lastReport != null) _buildStats(),
      ],
    );
  }

  Widget _buildControls() {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Text(
              '🎨',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.light_mode, color: Colors.white, size: 16),
              onPressed: () => context.switchTheme(Brightness.light),
              tooltip: 'Light Theme',
            ),
            IconButton(
              icon: const Icon(Icons.dark_mode, color: Colors.white, size: 16),
              onPressed: () => context.switchTheme(Brightness.dark),
              tooltip: 'Dark Theme',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    if (_lastReport == null) return const SizedBox();
    
    final report = _lastReport!;
    final avgFps = report.frameTimeStats.average > 0 ? 1000 / report.frameTimeStats.average : 0;
    final memoryMB = report.memoryStats.average / 1024 / 1024;
    
    return Positioned(
      bottom: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 Performance Stats',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'FPS: ${avgFps.toStringAsFixed(1)}',
              style: TextStyle(
                color: avgFps > 55 ? Colors.green : (avgFps > 30 ? Colors.yellow : Colors.red),
                fontSize: 10,
              ),
            ),
            Text(
              'Memory: ${memoryMB.toStringAsFixed(1)}MB',
              style: TextStyle(
                color: memoryMB < 100 ? Colors.green : (memoryMB < 200 ? Colors.yellow : Colors.red),
                fontSize: 10,
              ),
            ),
            Text(
              'Widgets: ${report.widgetBuildStats.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}