import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui' as ui;

/// Performance Optimization Features
/// 
/// Features:
/// - Virtual scrolling for large lists
/// - Image caching and optimization
/// - Lazy loading
/// - Memory management
/// - Performance monitoring
/// - Render optimization
/// - Component lifecycle optimization

/// Virtual Scrolling List Widget
class VirtualScrollList<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context)? separatorBuilder;
  final double itemExtent;
  final double? separatorExtent;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final bool isLoading;
  final void Function(int firstIndex, int lastIndex)? onVisibleRangeChanged;
  final int cacheExtent;
  final bool shrinkWrap;

  const VirtualScrollList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.separatorBuilder,
    required this.itemExtent,
    this.separatorExtent,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.padding,
    this.controller,
    this.physics,
    this.emptyWidget,
    this.loadingWidget,
    this.isLoading = false,
    this.onVisibleRangeChanged,
    this.cacheExtent = 100,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  State<VirtualScrollList<T>> createState() => _VirtualScrollListState<T>();
}

class _VirtualScrollListState<T> extends State<VirtualScrollList<T>> {
  late ScrollController _scrollController;
  Timer? _debounceTimer;
  int _firstVisibleIndex = 0;
  int _lastVisibleIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(VirtualScrollList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _scrollController.removeListener(_onScroll);
      _scrollController = widget.controller ?? ScrollController();
      _scrollController.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      final position = _scrollController.position;
      final firstIndex = (position.pixels / widget.itemExtent).floor();
      final lastIndex = ((position.pixels + position.viewportDimension) / widget.itemExtent).ceil();

      if (firstIndex != _firstVisibleIndex || lastIndex != _lastVisibleIndex) {
        _firstVisibleIndex = firstIndex;
        _lastVisibleIndex = lastIndex;
        widget.onVisibleRangeChanged?.call(firstIndex, lastIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return widget.loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

    if (widget.items.isEmpty) {
      return widget.emptyWidget ?? const Center(child: Text('No items'));
    }

    return ListView.builder(
      controller: _scrollController,
      physics: widget.physics,
      padding: widget.padding,
      itemExtent: widget.itemExtent + (widget.separatorExtent ?? 0),
      cacheExtent: widget.cacheExtent * widget.itemExtent,
      shrinkWrap: widget.shrinkWrap,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final itemWidget = widget.itemBuilder(context, item, index);
        
        if (widget.separatorBuilder != null && index < widget.items.length - 1) {
          return Column(
            children: [
              itemWidget,
              widget.separatorBuilder!(context),
            ],
          );
        }
        
        return itemWidget;
      },
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }
}

/// Optimized Image Widget with Caching
class OptimizedImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? placeholderBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final bool enableMemoryCache;
  final bool enableDiskCache;
  final int? maxWidthBytes;
  final bool enableOptimization;

  const OptimizedImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholderBuilder,
    this.errorBuilder,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.fadeOutDuration = const Duration(milliseconds: 300),
    this.enableMemoryCache = true,
    this.enableDiskCache = true,
    this.maxWidthBytes,
    this.enableOptimization = true,
  }) : super(key: key);

  @override
  State<OptimizedImage> createState() => _OptimizedImageState();
}

class _OptimizedImageState extends State<OptimizedImage> {
  final ImageCache _imageCache = PaintingBinding.instance.imageCache;
  ui.Image? _cachedImage;
  bool _isLoading = true;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (widget.enableMemoryCache) {
        // Check memory cache first
        final cachedImage = _imageCache?.putIfAbsent(
          widget.imageUrl,
          () => _loadNetworkImage(),
        );
        
        if (cachedImage != null) {
          if (mounted) {
            setState(() {
              _cachedImage = cachedImage;
              _isLoading = false;
            });
          }
          return;
        }
      }

      final image = await _loadNetworkImage();
      
      if (mounted) {
        setState(() {
          _cachedImage = image;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
          _isLoading = false;
        });
      }
    }
  }

  Future<ui.Image> _loadNetworkImage() async {
    final completer = Completer<ui.Image>();
    final imageStream = NetworkImage(widget.imageUrl).resolve(
      ImageConfiguration(
        size: widget.width != null && widget.height != null 
            ? Size(widget.width!, widget.height!) 
            : null,
      ),
    );

    final listener = ImageStreamListener((info, _) {
      completer.complete(info.image);
    }, onError: (exception, stackTrace) {
      completer.completeError(exception, stackTrace);
    });

    imageStream.addListener(listener);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(context, _error!, StackTrace.current) ??
        const Icon(Icons.broken_image);
    }

    if (_isLoading) {
      return widget.placeholderBuilder?.call(context, const SizedBox(), null) ??
        const Center(child: CircularProgressIndicator());
    }

    if (_cachedImage != null) {
      return RawImage(
        image: _cachedImage,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    }

    return Image.network(
      widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      frameBuilder: widget.placeholderBuilder,
      errorBuilder: widget.errorBuilder,
      fadeInDuration: widget.fadeInDuration,
      fadeOutDuration: widget.fadeOutDuration,
      cacheWidth: widget.maxWidthBytes,
      cacheHeight: widget.maxWidthBytes,
    );
  }

  @override
  void didUpdateWidget(OptimizedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _loadImage();
    }
  }
}

/// Lazy Loading Widget
class LazyLoadWidget extends StatefulWidget {
  final Widget Function() builder;
  final Widget? placeholder;
  final bool enabled;
  final Duration delay;
  final bool keepAlive;

  const LazyLoadWidget({
    Key? key,
    required this.builder,
    this.placeholder,
    this.enabled = true,
    this.delay = Duration.zero,
    this.keepAlive = false,
  }) : super(key: key);

  @override
  State<LazyLoadWidget> createState() => _LazyLoadWidgetState();
}

class _LazyLoadWidgetState extends State<LazyLoadWidget> {
  Widget? _child;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _scheduleBuild();
    }
  }

  void _scheduleBuild() {
    if (widget.delay == Duration.zero) {
      _buildChild();
    } else {
      _timer = Timer(widget.delay, _buildChild);
    }
  }

  void _buildChild() {
    if (!mounted) return;
    
    setState(() {
      _child = widget.builder();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.keepAlive) {
      return KeepAliveWrapper(
        child: _child ?? widget.placeholder ?? const SizedBox(),
      );
    }
    
    return _child ?? widget.placeholder ?? const SizedBox();
  }

  @override
  void didUpdateWidget(LazyLoadWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled || oldWidget.delay != widget.delay) {
      _timer?.cancel();
      if (widget.enabled) {
        _scheduleBuild();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Memory Optimizer Widget
class MemoryOptimizer extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final Duration checkInterval;
  final int maxCacheSize;
  final void Function(MemoryInfo)? onMemoryWarning;

  const MemoryOptimizer({
    Key? key,
    required this.child,
    this.enabled = true,
    this.checkInterval = const Duration(seconds: 30),
    this.maxCacheSize = 50, // MB
    this.onMemoryWarning,
  }) : super(key: key);

  @override
  State<MemoryOptimizer> createState() => _MemoryOptimizerState();
}

class _MemoryOptimizerState extends State<MemoryOptimizer> {
  Timer? _memoryCheckTimer;

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _startMemoryMonitoring();
    }
  }

  void _startMemoryMonitoring() {
    _memoryCheckTimer = Timer.periodic(widget.checkInterval, (timer) {
      _checkMemoryUsage();
    });
  }

  void _checkMemoryUsage() {
    final memoryInfo = _getCurrentMemoryInfo();
    
    if (memoryInfo.usedMB > widget.maxCacheSize) {
      widget.onMemoryWarning?.call(memoryInfo);
      _optimizeMemory();
    }
  }

  MemoryInfo _getCurrentMemoryInfo() {
    // This is a simplified version
    // In a real implementation, you would use platform-specific APIs
    return MemoryInfo(
      usedMB: 30, // Example value
      totalMB: 100, // Example value
      percentage: 0.3, // Example value
    );
  }

  void _optimizeMemory() {
    // Clear image cache
    PaintingBinding.instance.imageCache.clear();
    
    // Clear other caches if needed
    // This would be implementation-specific
    
    if (mounted) {
      setState(() {
        // Force rebuild to reflect memory optimization
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didUpdateWidget(MemoryOptimizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      _memoryCheckTimer?.cancel();
      if (widget.enabled) {
        _startMemoryMonitoring();
      }
    }
  }

  @override
  void dispose() {
    _memoryCheckTimer?.cancel();
    super.dispose();
  }
}

/// Memory Information Class
class MemoryInfo {
  final double usedMB;
  final double totalMB;
  final double percentage;

  MemoryInfo({
    required this.usedMB,
    required this.totalMB,
    required this.percentage,
  });
}

/// Performance Monitor Widget
class PerformanceMonitor extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final Duration reportInterval;
  final void Function(PerformanceReport)? onPerformanceReport;
  final bool showOverlay;

  const PerformanceMonitor({
    Key? key,
    required this.child,
    this.enabled = true,
    this.reportInterval = const Duration(seconds: 5),
    this.onPerformanceReport,
    this.showOverlay = false,
  }) : super(key: key);

  @override
  State<PerformanceMonitor> createState() => _PerformanceMonitorState();
}

class _PerformanceMonitorState extends State<PerformanceMonitor> {
  Timer? _reportTimer;
  final List<FrameTiming> _frameTimings = [];
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _startMonitoring();
    }
  }

  void _startMonitoring() {
    _reportTimer = Timer.periodic(widget.reportInterval, (timer) {
      _generateReport();
    });

    // Listen to frame timing
    WidgetsBinding.instance.addTimingsCallback(_onTimingsReported);
  }

  void _onTimingsReported(List<FrameTiming> timings) {
    _frameTimings.addAll(timings);
    
    // Keep only recent timings
    if (_frameTimings.length > 1000) {
      _frameTimings.removeRange(0, _frameTimings.length - 1000);
    }
  }

  void _generateReport() {
    if (_frameTimings.isEmpty) return;

    final recentTimings = _frameTimings.take(100).toList();
    final avgFrameTime = recentTimings.fold<double>(0, (sum, timing) => sum + timing.duration.inMilliseconds) / recentTimings.length;
    final maxFrameTime = recentTimings.map((t) => t.duration.inMilliseconds).fold<double>(0, (max, time) => math.max(max, time));
    final droppedFrames = recentTimings.where((t) => t.duration.inMilliseconds > 16).length;

    final report = PerformanceReport(
      averageFrameTime: avgFrameTime,
      maxFrameTime: maxFrameTime,
      droppedFrames: droppedFrames,
      totalFrames: recentTimings.length,
      timestamp: DateTime.now(),
    );

    widget.onPerformanceReport?.call(report);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.showOverlay && widget.enabled) _buildPerformanceOverlay(),
      ],
    );
  }

  Widget _buildPerformanceOverlay() {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: StreamBuilder<PerformanceReport>(
          stream: _performanceReportStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            
            final report = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FPS: ${(1000 / report.averageFrameTime).toStringAsFixed(1)}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  'Avg: ${report.averageFrameTime.toStringAsFixed(1)}ms',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  'Dropped: ${report.droppedFrames}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Stream<PerformanceReport> _performanceReportStream() {
    return Stream.periodic(widget.reportInterval, (_) {
      if (_frameTimings.isEmpty) return PerformanceReport.empty;
      
      final recentTimings = _frameTimings.take(100).toList();
      final avgFrameTime = recentTimings.fold<double>(0, (sum, timing) => sum + timing.duration.inMilliseconds) / recentTimings.length;
      final maxFrameTime = recentTimings.map((t) => t.duration.inMilliseconds).fold<double>(0, (max, time) => math.max(max, time));
      final droppedFrames = recentTimings.where((t) => t.duration.inMilliseconds > 16).length;

      return PerformanceReport(
        averageFrameTime: avgFrameTime,
        maxFrameTime: maxFrameTime,
        droppedFrames: droppedFrames,
        totalFrames: recentTimings.length,
        timestamp: DateTime.now(),
      );
    });
  }

  @override
  void didUpdateWidget(PerformanceMonitor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      _reportTimer?.cancel();
      if (widget.enabled) {
        _startMonitoring();
      }
    }
  }

  @override
  void dispose() {
    _reportTimer?.cancel();
    WidgetsBinding.instance.removeTimingsCallback(_onTimingsReported);
    super.dispose();
  }
}

/// Performance Report Class
class PerformanceReport {
  final double averageFrameTime;
  final double maxFrameTime;
  final int droppedFrames;
  final int totalFrames;
  final DateTime timestamp;

  const PerformanceReport({
    required this.averageFrameTime,
    required this.maxFrameTime,
    required this.droppedFrames,
    required this.totalFrames,
    required this.timestamp,
  });

  static const PerformanceReport empty = PerformanceReport(
    averageFrameTime: 0,
    maxFrameTime: 0,
    droppedFrames: 0,
    totalFrames: 0,
    timestamp: null,
  );

  double get fps => 1000 / averageFrameTime;
  double get frameDropRate => droppedFrames / totalFrames * 100;
}

/// Render Optimizer Widget
class RenderOptimizer extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final bool enableRepaintBoundary;
  final bool enableOffscreenBuffer;
  final bool enableCache;
  final Duration? cacheDuration;

  const RenderOptimizer({
    Key? key,
    required this.child,
    this.enabled = true,
    this.enableRepaintBoundary = true,
    this.enableOffscreenBuffer = false,
    this.enableCache = true,
    this.cacheDuration,
  }) : super(key: key);

  @override
  State<RenderOptimizer> createState() => _RenderOptimizerState();
}

class _RenderOptimizerState extends State<RenderOptimizer> {
  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    Widget currentChild = widget.child;

    if (widget.enableRepaintBoundary) {
      currentChild = RepaintBoundary(child: currentChild);
    }

    if (widget.enableOffscreenBuffer) {
      currentChild = Offstage(
        offstage: false,
        child: currentChild,
      );
    }

    if (widget.enableCache) {
      currentChild = _CacheWrapper(
        child: currentChild,
        duration: widget.cacheDuration,
      );
    }

    return currentChild;
  }
}

/// Cache Wrapper Widget
class _CacheWrapper extends StatefulWidget {
  final Widget child;
  final Duration? duration;

  const _CacheWrapper({
    Key? key,
    required this.child,
    this.duration,
  }) : super(key: key);

  @override
  State<_CacheWrapper> createState() => _CacheWrapperState();
}

class _CacheWrapperState extends State<_CacheWrapper> {
  Widget? _cachedChild;

  @override
  Widget build(BuildContext context) {
    if (widget.duration != null) {
      return AnimatedSwitcher(
        duration: widget.duration!,
        child: _cachedChild ?? widget.child,
      );
    }
    
    return _cachedChild ?? widget.child;
  }

  @override
  void didUpdateWidget(_CacheWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      setState(() {
        _cachedChild = widget.child;
      });
    }
  }
}