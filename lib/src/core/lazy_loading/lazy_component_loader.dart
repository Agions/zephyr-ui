/// ZephyrUI 懒加载组件系统
///
/// 提供组件的懒加载、代码分割和动态导入功能。
library lazy_component_loader;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as developer;

/// 组件加载状态
enum ComponentLoadState {
  notLoaded,
  loading,
  loaded,
  error,
}

/// 组件加载优先级
enum ComponentPriority {
  low, // 低优先级，可延迟加载
  medium, // 中等优先级，需要时加载
  high, // 高优先级，尽快加载
  critical, // 关键优先级，立即加载
}

/// 组件元数据
class ComponentMetadata {
  ComponentMetadata({
    required this.name,
    required this.path,
    this.estimatedSizeKB = 0,
    this.priority = ComponentPriority.medium,
    this.dependencies = const [],
    this.lastUsed,
    this.loadCount = 0,
  });
  final String name;
  final String path;
  final int estimatedSizeKB;
  final ComponentPriority priority;
  final List<String> dependencies;
  final DateTime? lastUsed;
  final int loadCount;

  ComponentMetadata copyWith({
    String? name,
    String? path,
    int? estimatedSizeKB,
    ComponentPriority? priority,
    List<String>? dependencies,
    DateTime? lastUsed,
    int? loadCount,
  }) {
    return ComponentMetadata(
      name: name ?? this.name,
      path: path ?? this.path,
      estimatedSizeKB: estimatedSizeKB ?? this.estimatedSizeKB,
      priority: priority ?? this.priority,
      dependencies: dependencies ?? this.dependencies,
      lastUsed: lastUsed ?? this.lastUsed,
      loadCount: loadCount ?? this.loadCount,
    );
  }
}

/// 懒加载组件管理器
class ZephyrLazyComponentLoader {
  /// 内部构造函数
  ZephyrLazyComponentLoader._internal();

  /// 单例实例
  static final ZephyrLazyComponentLoader _instance =
      ZephyrLazyComponentLoader._internal();

  /// 获取单例实例
  static ZephyrLazyComponentLoader get instance => _instance;

  /// 组件注册表
  final Map<String, ComponentMetadata> _componentRegistry = {};

  /// 已加载组件缓存
  final Map<String, Widget> _loadedComponents = {};

  /// 加载状态跟踪
  final Map<String, ComponentLoadState> _loadStates = {};

  /// 加载控制器
  final Map<String, Completer<Widget>> _loadControllers = {};

  /// 预加载队列
  final List<String> _preloadQueue = [];

  /// 内存使用监控
  final Map<String, int> _componentMemoryUsage = {};

  /// 配置选项
  int _maxCacheSize = 50;
  Duration _cacheTimeout = const Duration(minutes: 30);
  bool _enablePreloading = true;
  int _maxPreloadSizeKB = 1024; // 1MB

  /// 注册组件
  void registerComponent({
    required String name,
    required String path,
    int estimatedSizeKB = 0,
    ComponentPriority priority = ComponentPriority.medium,
    List<String> dependencies = const [],
  }) {
    _componentRegistry[name] = ComponentMetadata(
      name: name,
      path: path,
      estimatedSizeKB: estimatedSizeKB,
      priority: priority,
      dependencies: dependencies,
    );

    _loadStates[name] = ComponentLoadState.notLoaded;

    if (kDebugMode) {
      developer.log('📦 Component registered: $name (${estimatedSizeKB}KB)');
    }
  }

  /// 预加载高优先级组件
  Future<void> preloadComponents() async {
    if (!_enablePreloading) return;

    final highPriorityComponents = _componentRegistry.values
        .where((meta) =>
            meta.priority == ComponentPriority.critical ||
            meta.priority == ComponentPriority.high)
        .toList();

    // 按优先级排序
    highPriorityComponents
        .sort((a, b) => b.priority.index.compareTo(a.priority.index));

    var totalSize = 0;
    for (final component in highPriorityComponents) {
      if (totalSize + component.estimatedSizeKB <= _maxPreloadSizeKB) {
        await loadComponent(component.name);
        totalSize += component.estimatedSizeKB;
      } else {
        break;
      }
    }

    if (kDebugMode) {
      developer.log(
          '🔥 Preloaded ${highPriorityComponents.length} components (${totalSize}KB)');
    }
  }

  /// 加载组件
  Future<Widget> loadComponent(String name) async {
    // 检查是否已加载
    if (_loadedComponents.containsKey(name)) {
      final component = _loadedComponents[name]!;
      _updateComponentUsage(name);
      return component;
    }

    // 检查是否正在加载
    if (_loadControllers.containsKey(name)) {
      return _loadControllers[name]!.future;
    }

    // 验证组件是否存在
    if (!_componentRegistry.containsKey(name)) {
      throw Exception('Component $name is not registered');
    }

    final metadata = _componentRegistry[name]!;
    final completer = Completer<Widget>();
    _loadControllers[name] = completer;
    _loadStates[name] = ComponentLoadState.loading;

    try {
      // 加载依赖
      for (final dependency in metadata.dependencies) {
        await loadComponent(dependency);
      }

      // 模拟异步加载（实际项目中这里会动态导入组件）
      final component = await _loadComponentAsync(metadata);

      _loadedComponents[name] = component;
      _loadStates[name] = ComponentLoadState.loaded;
      _updateComponentUsage(name);

      completer.complete(component);

      // 清理加载控制器
      _loadControllers.remove(name);

      if (kDebugMode) {
        developer.log('✅ Component loaded: $name');
      }
    } catch (e, stackTrace) {
      _loadStates[name] = ComponentLoadState.error;
      completer.completeError(e, stackTrace);
      _loadControllers.remove(name);

      if (kDebugMode) {
        developer.log('❌ Failed to load component $name: $e');
      }
    }

    return completer.future;
  }

  /// 异步加载组件（模拟实现）
  Future<Widget> _loadComponentAsync(ComponentMetadata metadata) async {
    // 模拟网络/磁盘加载延迟
    await Future.delayed(
        Duration(milliseconds: metadata.estimatedSizeKB ~/ 10));

    // 实际项目中这里会使用动态导入：
    // final library = await deferredLibrary.loadLibrary();
    // final component = library.createComponent();

    // 返回一个占位组件，实际项目中会返回真实组件
    return Container(
      key: Key('lazy_component_${metadata.name}'),
      child: Center(
        child: Text('Loaded: ${metadata.name}'),
      ),
    );
  }

  /// 更新组件使用信息
  void _updateComponentUsage(String name) {
    final metadata = _componentRegistry[name];
    if (metadata != null) {
      _componentRegistry[name] = metadata.copyWith(
        lastUsed: DateTime.now(),
        loadCount: metadata.loadCount + 1,
      );
    }
  }

  /// 获取组件状态
  ComponentLoadState getComponentState(String name) {
    return _loadStates[name] ?? ComponentLoadState.notLoaded;
  }

  /// 检查组件是否已加载
  bool isComponentLoaded(String name) {
    return _loadedComponents.containsKey(name);
  }

  /// 获取已加载组件
  Widget? getLoadedComponent(String name) {
    return _loadedComponents[name];
  }

  /// 卸载组件
  void unloadComponent(String name) {
    _loadedComponents.remove(name);
    _loadStates[name] = ComponentLoadState.notLoaded;

    if (kDebugMode) {
      developer.log('🗑️ Component unloaded: $name');
    }
  }

  /// 清理缓存
  void clearCache() {
    _loadedComponents.clear();
    _loadStates.clear();
    _loadControllers.clear();
    _preloadQueue.clear();

    // 重置所有组件状态
    for (final name in _componentRegistry.keys) {
      _loadStates[name] = ComponentLoadState.notLoaded;
    }

    if (kDebugMode) {
      developer.log('🧹 Component cache cleared');
    }
  }

  /// 优化缓存
  void optimizeCache() {
    final now = DateTime.now();
    final componentsToRemove = <String>[];

    for (final entry in _loadedComponents.entries) {
      final metadata = _componentRegistry[entry.key];
      if (metadata != null && metadata.lastUsed != null) {
        final age = now.difference(metadata.lastUsed!);
        if (age > _cacheTimeout) {
          componentsToRemove.add(entry.key);
        }
      }
    }

    for (final name in componentsToRemove) {
      unloadComponent(name);
    }

    // 如果缓存仍然过大，移除最少使用的组件
    if (_loadedComponents.length > _maxCacheSize) {
      final sortedComponents = _componentRegistry.values
          .where((meta) => _loadedComponents.containsKey(meta.name))
          .toList()
        ..sort((a, b) => a.loadCount.compareTo(b.loadCount));

      final toRemove = sortedComponents
          .take(_loadedComponents.length - _maxCacheSize)
          .map((meta) => meta.name);

      for (final name in toRemove) {
        unloadComponent(name);
      }
    }

    if (kDebugMode && componentsToRemove.isNotEmpty) {
      developer.log(
          '🗑️ Optimized cache: removed ${componentsToRemove.length} components');
    }
  }

  /// 获取统计信息
  Map<String, dynamic> getStats() {
    final totalSize = _loadedComponents.keys.fold<int>(
      0,
      (sum, name) => sum + (_componentRegistry[name]?.estimatedSizeKB ?? 0),
    );

    return {
      'registeredComponents': _componentRegistry.length,
      'loadedComponents': _loadedComponents.length,
      'loadingComponents': _loadControllers.length,
      'totalSizeKB': totalSize,
      'cacheHitRate': _calculateCacheHitRate(),
      'loadStates': Map.fromEntries(
        _loadStates.entries.map((e) => MapEntry(e.key, e.value.toString())),
      ),
    };
  }

  /// 计算缓存命中率
  double _calculateCacheHitRate() {
    // 简化的缓存命中率计算
    final totalRequests = _componentRegistry.values.fold<int>(
      0,
      (sum, meta) => sum + meta.loadCount,
    );

    if (totalRequests == 0) return 0.0;

    final cacheHits = _loadedComponents.values.fold<int>(
      0,
      (sum, _) => sum + 1,
    );

    return cacheHits / totalRequests;
  }

  /// 配置选项
  void configure({
    int? maxCacheSize,
    Duration? cacheTimeout,
    bool? enablePreloading,
    int? maxPreloadSizeKB,
  }) {
    if (maxCacheSize != null) _maxCacheSize = maxCacheSize;
    if (cacheTimeout != null) _cacheTimeout = cacheTimeout;
    if (enablePreloading != null) _enablePreloading = enablePreloading;
    if (maxPreloadSizeKB != null) _maxPreloadSizeKB = maxPreloadSizeKB;

    if (kDebugMode) {
      developer.log(
          '⚙️ Lazy loader configured: maxCacheSize=$_maxCacheSize, enablePreloading=$_enablePreloading');
    }
  }
}

/// 懒加载组件包装器
class ZephyrLazyComponent extends StatefulWidget {
  const ZephyrLazyComponent({
    required this.componentName,
    super.key,
    this.placeholder,
    this.errorWidget,
    this.onLoad,
    this.onError,
  });
  final String componentName;
  final Widget? placeholder;
  final Widget? errorWidget;
  final VoidCallback? onLoad;
  final VoidCallback? onError;

  @override
  State<ZephyrLazyComponent> createState() => _ZephyrLazyComponentState();
}

class _ZephyrLazyComponentState extends State<ZephyrLazyComponent> {
  final ZephyrLazyComponentLoader _loader = ZephyrLazyComponentLoader.instance;
  Widget? _component;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadComponent();
  }

  @override
  void didUpdateWidget(ZephyrLazyComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.componentName != widget.componentName) {
      _loadComponent();
    }
  }

  Future<void> _loadComponent() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final component = await _loader.loadComponent(widget.componentName);
      if (mounted) {
        setState(() {
          _component = component;
          _isLoading = false;
        });
        widget.onLoad?.call();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
        widget.onError?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_component != null) {
      return _component!;
    }

    if (_error != null) {
      return widget.errorWidget ?? _buildErrorWidget();
    }

    if (_isLoading) {
      return widget.placeholder ?? _buildLoadingWidget();
    }

    return widget.placeholder ?? const SizedBox();
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text('Loading component...'),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(height: 8),
          Text('Failed to load component: ${widget.componentName}'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _loadComponent,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

/// 预加载组件包装器
class ZephyrPreloader extends StatefulWidget {
  const ZephyrPreloader({
    required this.componentNames,
    required this.child,
    super.key,
    this.onComplete,
    this.onError,
  });
  final List<String> componentNames;
  final Widget child;
  final VoidCallback? onComplete;
  final VoidCallback? onError;

  @override
  State<ZephyrPreloader> createState() => _ZephyrPreloaderState();
}

class _ZephyrPreloaderState extends State<ZephyrPreloader> {
  final ZephyrLazyComponentLoader _loader = ZephyrLazyComponentLoader.instance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _preloadComponents();
  }

  Future<void> _preloadComponents() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      for (final componentName in widget.componentNames) {
        await _loader.loadComponent(componentName);
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        widget.onComplete?.call();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        widget.onError?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// 懒加载扩展
extension ZephyrLazyLoadingExtensions on BuildContext {
  /// 创建懒加载组件
  Widget lazyLoad({
    required String componentName,
    Widget? placeholder,
    Widget? errorWidget,
    VoidCallback? onLoad,
    VoidCallback? onError,
  }) {
    return ZephyrLazyComponent(
      componentName: componentName,
      placeholder: placeholder,
      errorWidget: errorWidget,
      onLoad: onLoad,
      onError: onError,
    );
  }

  /// 创建预加载器
  Widget preload({
    required List<String> componentNames,
    required Widget child,
    VoidCallback? onComplete,
    VoidCallback? onError,
  }) {
    return ZephyrPreloader(
      componentNames: componentNames,
      onComplete: onComplete,
      onError: onError,
      child: child,
    );
  }
}
