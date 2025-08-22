# ZephyrUI 性能优化指南

<div align="center">

![性能](https://img.shields.io/badge/性能-优化-green?style=for-the-badge&logo=flutter&logoColor=white)
![60 FPS](https://img.shields.io/badge/60_FPS-目标-success?style=for-the-badge&logo=performance&logoColor=white)
![内存](https://img.shields.io/badge/内存高效-blue?style=for-the-badge&logo=memory&logoColor=white)

**通过优化的 Flutter 应用实现 60 FPS**

</div>

---

## 📖 目录

- [🎯 性能目标](#-性能目标)
- [📊 性能指标](#-性能指标)
- [🔍 性能分析](#-性能分析)
- [⚡ 组件优化](#-组件优化)
- [💾 内存管理](#-内存管理)
- [🎨 渲染优化](#-渲染优化)
- [📱 列表性能](#-列表性能)
- [🌐 网络优化](#-网络优化)
- [🔄 状态管理](#-状态管理)
- [🧪 性能测试](#-性能测试)
- [🚀 高级技术](#-高级技术)

---

## 🎯 性能目标

### 目标指标

```dart
class ZephyrPerformanceTargets {
  static const Duration frameTime = Duration(milliseconds: 16); // 60 FPS
  static const Duration buildTime = Duration(milliseconds: 2);
  static const Duration layoutTime = Duration(milliseconds: 4);
  static const Duration paintTime = Duration(milliseconds: 8);
  static const int maxMemoryUsage = 100; // MB
  static const double jankThreshold = 0.1; // 10% 卡顿帧
}
```

### 性能金字塔

```
┌─────────────────────────────────────────────────────────────┐
│                        性能金字塔                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🚀 **应用层**: 业务逻辑和用户体验                          │
│  🎨 **渲染层**: 组件构建和布局                              │
│  ⚡ **框架层**: Flutter 框架优化                            │
│  💾 **系统层**: 内存和资源管理                              │
│  🔧 **硬件层**: 设备性能和 GPU 加速                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 📊 性能指标

### 关键指标

```dart
class ZephyrPerformanceMetrics {
  // 帧率指标
  static const double targetFPS = 60.0;
  static const double minAcceptableFPS = 30.0;
  
  // 内存指标
  static const int memoryWarningThreshold = 50; // MB
  static const int memoryCriticalThreshold = 100; // MB
  
  // 启动时间
  static const Duration coldStartTarget = Duration(seconds: 3);
  static const Duration hotStartTarget = Duration(milliseconds: 500);
  
  // 响应时间
  static const Duration touchResponseTarget = Duration(milliseconds: 100);
  static const Duration animationResponseTarget = Duration(milliseconds: 16);
}
```

### 性能监控

```dart
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  
  factory PerformanceMonitor() => _instance;
  
  PerformanceMonitor._internal();
  
  final Map<String, Stopwatch> _timers = {};
  
  void startTimer(String name) {
    _timers[name] = Stopwatch()..start();
  }
  
  void stopTimer(String name) {
    final timer = _timers[name];
    if (timer != null) {
      timer.stop();
      final duration = timer.elapsedMilliseconds;
      if (duration > ZephyrPerformanceTargets.buildTime.inMilliseconds) {
        print('⚠️ 性能警告: $name 耗时 ${duration}ms');
      }
      _timers.remove(name);
    }
  }
}
```

---

## 🔍 性能分析

### Flutter DevTools

#### ✅ 最佳实践

```dart
// 使用性能覆盖层
void main() {
  runApp(
    MaterialApp(
      home: PerformanceOverlay(
        enabled: true,
        child: MyApp(),
      ),
    ),
  );
}

// 使用调试标志
void main() {
  runApp(
    MaterialApp(
      showPerformanceOverlay: true,
      showSemanticsDebugger: false,
      debugShowMaterialGrid: false,
      home: MyApp(),
    ),
  );
}
```

### 性能分析工具

```dart
class PerformanceProfiler {
  static void profileWidget(String name, Widget Function() builder) {
    final stopwatch = Stopwatch()..start();
    final widget = builder();
    stopwatch.stop();
    
    print('📊 组件分析: $name 构建耗时 ${stopwatch.elapsedMilliseconds}ms');
    
    return widget;
  }
  
  static void measureMemoryUsage() {
    final memory = ProcessInfo.currentRss / (1024 * 1024); // MB
    print('💾 内存使用: ${memory.toStringAsFixed(2)} MB');
    
    if (memory > ZephyrPerformanceMetrics.memoryWarningThreshold) {
      print('⚠️ 内存警告: 内存使用过高');
    }
  }
}
```

---

## ⚡ 组件优化

### const 构造函数

#### ✅ 最佳实践

```dart
// 使用 const 构造函数
class OptimizedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  
  const OptimizedCard({
    required this.title,
    required this.subtitle,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 避免不必要的重建

#### ✅ 最佳实践

```dart
// 使用 const 子组件
class OptimizedList extends StatelessWidget {
  final List<String> items;
  
  const OptimizedList({required this.items, super.key});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return const ListTileItem(); // 如果可能，使用 const
      },
    );
  }
}

// 使用 shouldRebuild 优化
class OptimizedListItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  
  const OptimizedListItem({
    required this.title,
    this.isSelected = false,
    super.key,
  });
  
  @override
  State<OptimizedListItem> createState() => _OptimizedListItemState();
}

class _OptimizedListItemState extends State<OptimizedListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      selected: widget.isSelected,
      onTap: () => setState(() {}),
    );
  }
  
  @override
  bool shouldUpdateWidget(OptimizedListItem oldWidget) {
    return oldWidget.title != widget.title || 
           oldWidget.isSelected != widget.isSelected;
  }
}
```

### 组件缓存

```dart
class ComponentCache {
  static final Map<String, Widget> _cache = {};
  
  static Widget getOrCreate(String key, Widget Function() builder) {
    return _cache.putIfAbsent(key, builder);
  }
  
  static void clear() {
    _cache.clear();
  }
}

// 使用缓存
class CachedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentCache.getOrCreate('expensive_widget', () {
      return ExpensiveWidget();
    });
  }
}
```

---

## 💾 内存管理

### 图片优化

#### ✅ 最佳实践

```dart
// 使用缓存图片
class OptimizedImage extends StatelessWidget {
  final String imageUrl;
  
  const OptimizedImage({required this.imageUrl, super.key});
  
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
      memCacheWidth: 800, // 限制缓存尺寸
      memCacheHeight: 600,
    );
  }
}

// 压缩图片
Future<Uint8List> compressImage(Uint8List imageBytes) async {
  final image = img.decodeImage(imageBytes)!;
  final compressed = img.encodeJpg(image, quality: 85);
  return compressed;
}
```

### 内存泄漏预防

#### ✅ 最佳实践

```dart
// 正确释放资源
class OptimizedController extends StatefulWidget {
  @override
  State<OptimizedController> createState() => _OptimizedControllerState();
}

class _OptimizedControllerState extends State<OptimizedController> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  StreamSubscription? _subscription;
  
  @override
  void initState() {
    super.initState();
    _subscription = someStream.listen((data) {
      // 处理流数据
    });
  }
  
  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _subscription?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
    );
  }
}
```

---

## 🎨 渲染优化

### 减少重绘

#### ✅ 最佳实践

```dart
// 使用 RepaintBoundary
class OptimizedAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value,
            child: child,
          );
        },
        child: const FlutterLogo(size: 100),
      ),
    );
  }
}

// 使用 const 组件减少重绘
class OptimizedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('静态内容'),
      ),
    );
  }
}
```

### 布局优化

#### ✅ 最佳实践

```dart
// 避免深层嵌套
class OptimizedLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildContent(),
        _buildFooter(),
      ],
    );
  }
  
  Widget _buildHeader() => const HeaderWidget();
  Widget _buildContent() => const ContentWidget();
  Widget _buildFooter() => const FooterWidget();
}

// 使用 Flex 和 Expanded
class OptimizedFlexLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(color: Colors.red),
        ),
        Expanded(
          flex: 1,
          child: Container(color: Colors.blue),
        ),
      ],
    );
  }
}
```

---

## 📱 列表性能

### ListView 优化

#### ✅ 最佳实践

```dart
// 使用 ListView.builder
class OptimizedListView extends StatelessWidget {
  final List<String> items;
  
  const OptimizedListView({required this.items, super.key});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          key: ValueKey(items[index]), // 重要：使用唯一键
          title: Text(items[index]),
        );
      },
      cacheExtent: 500, // 预缓存范围
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
    );
  }
}

// 使用 itemExtent 提高性能
class FixedHeightListView extends StatelessWidget {
  final List<String> items;
  
  const FixedHeightListView({required this.items, super.key});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemExtent: 56, // 固定高度
      itemBuilder: (context, index) {
        return ListTile(title: Text(items[index]));
      },
    );
  }
}
```

### 分页加载

```dart
class PaginatedListView extends StatefulWidget {
  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final List<String> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(_scrollListener);
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  void _scrollListener() {
    if (_scrollController.position.pixels == 
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }
  
  Future<void> _loadMoreItems() async {
    if (!_isLoading && _hasMore) {
      setState(() => _isLoading = true);
      
      // 模拟网络请求
      await Future.delayed(const Duration(seconds: 1));
      
      final newItems = List.generate(20, (index) => '项目 ${_items.length + index}');
      setState(() {
        _items.addAll(newItems);
        _isLoading = false;
        _hasMore = _items.length < 100; // 限制总数
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListTile(title: Text(_items[index]));
      },
    );
  }
}
```

---

## 🌐 网络优化

### 请求优化

#### ✅ 最佳实践

```dart
// 使用缓存
class CachedNetworkService {
  static final Map<String, CachedResponse> _cache = {};
  
  static Future<CachedResponse> get(String url) async {
    if (_cache.containsKey(url)) {
      final cached = _cache[url]!;
      if (cached.isValid) {
        return cached;
      }
    }
    
    final response = await http.get(Uri.parse(url));
    final cachedResponse = CachedResponse(
      data: response.body,
      timestamp: DateTime.now(),
    );
    
    _cache[url] = cachedResponse;
    return cachedResponse;
  }
}

// 批量请求
class BatchRequestService {
  static Future<List<Response>> batchRequests(List<String> urls) async {
    final futures = urls.map((url) => http.get(Uri.parse(url)));
    return await Future.wait(futures);
  }
}
```

### 数据压缩

```dart
class DataCompressionService {
  static Uint8List compressData(String data) {
    final bytes = utf8.encode(data);
    return gzip.encode(bytes);
  }
  
  static String decompressData(Uint8List compressedData) {
    final decompressed = gzip.decode(compressedData);
    return utf8.decode(decompressed);
  }
}
```

---

## 🔄 状态管理优化

### 状态选择器

#### ✅ 最佳实践

```dart
// 使用 Provider 和选择器
class OptimizedCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(
      builder: (context, model, child) {
        return Text(
          '计数: ${model.count}',
          // 只有当 count 改变时才重建
        );
      },
    );
  }
}

// 使用 Selector
class OptimizedUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<UserModel, String>(
      selector: (context, model) => model.name,
      builder: (context, name, child) {
        return Text('用户名: $name');
        // 只有当 name 改变时才重建
      },
    );
  }
}
```

---

## 🧪 性能测试

### 基准测试

```dart
class PerformanceBenchmark {
  static Future<void> runBuildBenchmark() async {
    final stopwatch = Stopwatch()..start();
    
    // 构建复杂组件
    final widget = ComplexWidget();
    await tester.pumpWidget(widget);
    
    stopwatch.stop();
    print('📊 构建基准: ${stopwatch.elapsedMilliseconds}ms');
  }
  
  static Future<void> runMemoryBenchmark() async {
    final initialMemory = ProcessInfo.currentRss;
    
    // 执行内存密集型操作
    await performMemoryIntensiveTask();
    
    final finalMemory = ProcessInfo.currentRss;
    final memoryIncrease = finalMemory - initialMemory;
    
    print('💾 内存基准: 增加 ${memoryIncrease / (1024 * 1024)} MB');
  }
}
```

---

## 🚀 高级技术

### 预计算和缓存

```dart
class PrecomputedLayoutCache {
  static final Map<String, Size> _sizeCache = {};
  
  static Size calculateSize(String key, Widget Function() builder) {
    return _sizeCache.putIfAbsent(key, () {
      final renderObject = builder().createRenderObject(context);
      return Size(renderObject.size.width, renderObject.size.height);
    });
  }
}
```

### 渲染优化

```dart
class CustomRenderObjectWidget extends LeafRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderObject();
  }
}

class CustomRenderObject extends RenderBox {
  @override
  void performLayout() {
    size = constraints.biggest;
  }
  
  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final paint = Paint()..color = Colors.blue;
    
    canvas.drawRect(offset & size, paint);
  }
}
```

---

## 📝 性能检查清单

### 组件优化
- [ ] 使用 const 构造函数
- [ ] 避免不必要的重建
- [ ] 使用合适的键
- [ ] 实现shouldRebuild
- [ ] 使用RepaintBoundary

### 内存管理
- [ ] 正确释放控制器
- [ ] 使用图片缓存
- [ ] 避免内存泄漏
- [ ] 监控内存使用
- [ ] 压缩大图片

### 渲染优化
- [ ] 减少重绘区域
- [ ] 优化布局层次
- [ ] 使用固定尺寸
- [ ] 预计算布局
- [ ] 避免透明叠加

### 列表性能
- [ ] 使用ListView.builder
- [ ] 设置itemExtent
- [ ] 实现分页加载
- [ ] 使用缓存
- [ ] 优化列表项

---

## 🔄 相关资源

- [Flutter 性能文档](https://docs.flutter.dev/performance)
- [Flutter DevTools](https://docs.flutter.dev/tools/devtools)
- [性能最佳实践](https://flutter.dev/docs/perf/best-practices)
- [内存优化指南](https://flutter.dev/docs/perf/rendering-performance)

---

<div align="center">

**使用 ZephyrUI 性能优化指南构建高性能应用**

[![性能](https://img.shields.io/badge/性能-优化-green)](https://docs.flutter.dev/performance)
[![60 FPS](https://img.shields.io/badge/60_FPS-目标-success)](https://docs.flutter.dev/perf/rendering-performance)

</div>