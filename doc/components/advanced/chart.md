# ZephyrChart 图表组件

图表组件是ZephyrUI高级组件中的重要组件，提供了强大的数据可视化功能。支持多种图表类型、自定义样式和交互方式，是构建数据分析、报表展示、数据监控等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种图表类型**: 支持折线图、柱状图、饼图、散点图等多种类型
- **灵活样式**: 支持自定义颜色、样式、动画等视觉效果
- **丰富交互**: 支持点击、悬停、缩放、平移等交互操作
- **响应式设计**: 根据容器尺寸自动调整图表大小
- **数据绑定**: 支持动态数据更新和实时刷新
- **主题适配**: 完整的主题系统支持

### 适用场景
- 数据分析报表
- 业务指标监控
- 用户行为分析
- 财务数据展示
- 科学数据可视化
- 实时数据监控

## 🚀 基础用法

### 基本折线图

```dart
class BasicLineChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本折线图'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrChart(
          type: ZephyrChartType.line,
          data: [
            ZephyrChartData(
              x: '1月',
              y: 100,
              label: '销售额',
            ),
            ZephyrChartData(
              x: '2月',
              y: 150,
              label: '销售额',
            ),
            ZephyrChartData(
              x: '3月',
              y: 120,
              label: '销售额',
            ),
            ZephyrChartData(
              x: '4月',
              y: 180,
              label: '销售额',
            ),
            ZephyrChartData(
              x: '5月',
              y: 200,
              label: '销售额',
            ),
          ],
          options: ZephyrChartOptions(
            title: '月度销售趋势',
            showLegend: true,
            showGrid: true,
          ),
        ),
      ),
    );
  }
}
```

### 基本柱状图

```dart
class BasicBarChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本柱状图'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrChart(
          type: ZephyrChartType.bar,
          data: [
            ZephyrChartData(
              x: '产品A',
              y: 120,
              label: '销量',
            ),
            ZephyrChartData(
              x: '产品B',
              y: 180,
              label: '销量',
            ),
            ZephyrChartData(
              x: '产品C',
              y: 90,
              label: '销量',
            ),
            ZephyrChartData(
              x: '产品D',
              y: 150,
              label: '销量',
            ),
          ],
          options: ZephyrChartOptions(
            title: '产品销量对比',
            showLegend: false,
            showGrid: true,
          ),
        ),
      ),
    );
  }
}
```

### 基本饼图

```dart
class BasicPieChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本饼图'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrChart(
          type: ZephyrChartType.pie,
          data: [
            ZephyrChartData(
              x: '桌面端',
              y: 45,
              label: '访问来源',
            ),
            ZephyrChartData(
              x: '移动端',
              y: 35,
              label: '访问来源',
            ),
            ZephyrChartData(
              x: '平板端',
              y: 20,
              label: '访问来源',
            ),
          ],
          options: ZephyrChartOptions(
            title: '访问来源分布',
            showLegend: true,
            showLabels: true,
          ),
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义颜色图表

```dart
class CustomColorChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义颜色图表'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrChart(
          type: ZephyrChartType.line,
          data: [
            ZephyrChartData(
              x: '1月',
              y: 100,
              color: Colors.blue,
            ),
            ZephyrChartData(
              x: '2月',
              y: 150,
              color: Colors.green,
            ),
            ZephyrChartData(
              x: '3月',
              y: 120,
              color: Colors.orange,
            ),
            ZephyrChartData(
              x: '4月',
              y: 180,
              color: Colors.purple,
            ),
          ],
          options: ZephyrChartOptions(
            title: '多彩折线图',
            showLegend: true,
            colors: [
              Colors.blue,
              Colors.green,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ),
      ),
    );
  }
}
```

### 动画图表

```dart
class AnimatedChartExample extends StatefulWidget {
  @override
  _AnimatedChartExampleState createState() => _AnimatedChartExampleState();
}

class _AnimatedChartExampleState extends State<AnimatedChartExample> {
  List<ZephyrChartData> _data = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    // 模拟数据加载
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      _data = [
        ZephyrChartData(x: '1月', y: 100),
        ZephyrChartData(x: '2月', y: 150),
        ZephyrChartData(x: '3月', y: 120),
        ZephyrChartData(x: '4月', y: 180),
        ZephyrChartData(x: '5月', y: 200),
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画图表'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ZephyrChart(
                type: ZephyrChartType.line,
                data: _data,
                options: ZephyrChartOptions(
                  title: '动态数据图表',
                  showLegend: true,
                  animation: ZephyrChartAnimation(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
      ),
    );
  }
}
```

### 交互式图表

```dart
class InteractiveChartExample extends StatefulWidget {
  @override
  _InteractiveChartExampleState createState() => _InteractiveChartExampleState();
}

class _InteractiveChartExampleState extends State<InteractiveChartExample> {
  ZephyrChartData? _selectedData;
  final List<ZephyrChartData> _data = [
    ZephyrChartData(x: '1月', y: 100),
    ZephyrChartData(x: '2月', y: 150),
    ZephyrChartData(x: '3月', y: 120),
    ZephyrChartData(x: '4月', y: 180),
    ZephyrChartData(x: '5月', y: 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交互式图表'),
      ),
      body: Column(
        children: [
          // 选中的数据点信息
          if (_selectedData != null)
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.blue[50],
              child: Text(
                '选中: ${_selectedData!.x} - ${_selectedData!.y}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          // 图表
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ZephyrChart(
                type: ZephyrChartType.line,
                data: _data,
                options: ZephyrChartOptions(
                  title: '可交互图表',
                  showLegend: true,
                  interactive: true,
                  onPointTap: (data) {
                    setState(() => _selectedData = data);
                  },
                  onPointHover: (data) {
                    print('悬停: ${data.x} - ${data.y}');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🔧 高级用法

### 多系列图表

```dart
class MultiSeriesChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多系列图表'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrChart(
          type: ZephyrChartType.line,
          data: [
            // 系列1 - 销售额
            ZephyrChartData(
              x: '1月',
              y: 100,
              series: '销售额',
              color: Colors.blue,
            ),
            ZephyrChartData(
              x: '2月',
              y: 150,
              series: '销售额',
              color: Colors.blue,
            ),
            ZephyrChartData(
              x: '3月',
              y: 120,
              series: '销售额',
              color: Colors.blue,
            ),
            // 系列2 - 利润
            ZephyrChartData(
              x: '1月',
              y: 30,
              series: '利润',
              color: Colors.green,
            ),
            ZephyrChartData(
              x: '2月',
              y: 45,
              series: '利润',
              color: Colors.green,
            ),
            ZephyrChartData(
              x: '3月',
              y: 36,
              series: '利润',
              color: Colors.green,
            ),
          ],
          options: ZephyrChartOptions(
            title: '销售额与利润对比',
            showLegend: true,
            showGrid: true,
            yAxis: ZephyrChartYAxis(
              title: '金额 (万元)',
            ),
          ),
        ),
      ),
    );
  }
}
```

### 实时数据图表

```dart
class RealtimeChartExample extends StatefulWidget {
  @override
  _RealtimeChartExampleState createState() => _RealtimeChartExampleState();
}

class _RealtimeChartExampleState extends State<RealtimeChartExample> {
  List<ZephyrChartData> _data = [];
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startRealtimeUpdate();
  }

  void _startRealtimeUpdate() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        // 添加新数据点
        final now = DateTime.now();
        _data.add(ZephyrChartData(
          x: '${now.second}s',
          y: 50 + _random.nextDouble() * 50,
        ));
        
        // 保持最多20个数据点
        if (_data.length > 20) {
          _data.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('实时数据图表'),
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: _startRealtimeUpdate,
          ),
          IconButton(
            icon: Icon(Icons.stop),
            onPressed: () => _timer?.cancel(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrChart(
          type: ZephyrChartType.line,
          data: _data,
          options: ZephyrChartOptions(
            title: '实时数据监控',
            showLegend: false,
            animation: ZephyrChartAnimation(
              duration: Duration(milliseconds: 500),
            ),
          ),
        ),
      ),
    );
  }
}
```

### 组合图表

```dart
class CombinationChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('组合图表'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrChart(
          type: ZephyrChartType.combination,
          data: [
            // 柱状图数据
            ZephyrChartData(
              x: '1月',
              y: 100,
              chartType: ZephyrChartType.bar,
              color: Colors.blue,
            ),
            ZephyrChartData(
              x: '2月',
              y: 150,
              chartType: ZephyrChartType.bar,
              color: Colors.blue,
            ),
            ZephyrChartData(
              x: '3月',
              y: 120,
              chartType: ZephyrChartType.bar,
              color: Colors.blue,
            ),
            // 折线图数据
            ZephyrChartData(
              x: '1月',
              y: 80,
              chartType: ZephyrChartType.line,
              color: Colors.red,
            ),
            ZephyrChartData(
              x: '2月',
              y: 130,
              chartType: ZephyrChartType.line,
              color: Colors.red,
            ),
            ZephyrChartData(
              x: '3月',
              y: 110,
              chartType: ZephyrChartType.line,
              color: Colors.red,
            ),
          ],
          options: ZephyrChartOptions(
            title: '销售额与目标对比',
            showLegend: true,
            showGrid: true,
          ),
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrChart()

```dart
const ZephyrChart({
  Key? key,
  required ZephyrChartType type,
  required List<ZephyrChartData> data,
  ZephyrChartOptions? options,
  double? width,
  double? height,
  EdgeInsetsGeometry? padding,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `type`: 图表类型
- `data`: 图表数据
- `options`: 图表选项
- `width`: 图表宽度
- `height`: 图表高度
- `padding`: 内边距
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrChartData()

```dart
const ZephyrChartData({
  required String x,
  required double y,
  String? label,
  String? series,
  Color? color,
  ZephyrChartType? chartType,
  Map<String, dynamic>? metadata,
})
```

**参数说明：**
- `x`: X轴值
- `y`: Y轴值
- `label`: 数据标签
- `series`: 数据系列
- `color`: 数据颜色
- `chartType`: 组合图表中的图表类型
- `metadata`: 元数据

### 枚举类型

#### ZephyrChartType

```dart
enum ZephyrChartType {
  line,     // 折线图
  bar,      // 柱状图
  pie,      // 饼图
  scatter,  // 散点图
  area,     // 面积图
  combination, // 组合图表
}
```

### 选项类

#### ZephyrChartOptions

```dart
class ZephyrChartOptions {
  final String? title;
  final bool showLegend;
  final bool showGrid;
  final bool showLabels;
  final bool interactive;
  final List<Color>? colors;
  final ZephyrChartAnimation? animation;
  final ZephyrChartAxis? xAxis;
  final ZephyrChartAxis? yAxis;
  final void Function(ZephyrChartData)? onPointTap;
  final void Function(ZephyrChartData)? onPointHover;
  final Duration? tooltipDuration;
}
```

#### ZephyrChartAnimation

```dart
class ZephyrChartAnimation {
  final Duration duration;
  final Curve curve;
  final bool enable;
}
```

#### ZephyrChartAxis

```dart
class ZephyrChartAxis {
  final String? title;
  final bool show;
  final double? min;
  final double? max;
  final int? decimals;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrChartTheme(
        defaultColors: [
          Colors.blue,
          Colors.green,
          Colors.orange,
          Colors.purple,
          Colors.red,
        ],
        defaultAnimation: ZephyrChartAnimation(
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        ),
        gridColor: Colors.grey[300],
        axisColor: Colors.grey[600],
        textColor: Colors.black87,
        backgroundColor: Colors.white,
        tooltipBackgroundColor: Colors.black87,
        tooltipTextColor: Colors.white,
        legendPosition: ZephyrChartLegendPosition.bottom,
        padding: EdgeInsets.all(16),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultColors`: 默认颜色列表
- `defaultAnimation`: 默认动画配置
- `gridColor`: 网格线颜色
- `axisColor`: 坐标轴颜色
- `textColor`: 文本颜色
- `backgroundColor`: 背景颜色
- `tooltipBackgroundColor`: 工具提示背景颜色
- `tooltipTextColor`: 工具提示文本颜色
- `legendPosition`: 图例位置
- `padding`: 内边距

## 🏆 最佳实践

### 1. 合理的图表类型选择

```dart
// ✅ 好的做法：根据数据类型选择合适的图表
ZephyrChart(
  type: ZephyrChartType.line, // 适合展示趋势数据
  data: _timeSeriesData,
)

ZephyrChart(
  type: ZephyrChartType.bar, // 适合展示分类数据对比
  data: _categoryData,
)

ZephyrChart(
  type: ZephyrChartType.pie, // 适合展示占比数据
  data: _percentageData,
)

// ❌ 避免的做法：图表类型与数据不匹配
ZephyrChart(
  type: ZephyrChartType.pie, // 饼图不适合展示时间序列数据
  data: _timeSeriesData,
)
```

### 2. 数据可视化的清晰性

```dart
// ✅ 好的做法：保持图表简洁清晰
ZephyrChart(
  data: _data.take(10), // 限制数据点数量
  options: ZephyrChartOptions(
    showLegend: true,
    showGrid: true,
    title: '关键指标趋势', // 清晰的标题
  ),
)

// ✅ 好的做法：使用合适的颜色对比
ZephyrChart(
  data: _data,
  options: ZephyrChartOptions(
    colors: [
      Colors.blue,
      Colors.orange,
      Colors.green, // 使用对比度高的颜色
    ],
  ),
)

// ❌ 避免的做法：图表过于复杂
ZephyrChart(
  data: _largeDataset, // 数据点过多
  options: ZephyrChartOptions(
    showGrid: true,
    showLegend: true,
    showLabels: true, // 信息过多，难以阅读
  ),
)
```

### 3. 性能优化

```dart
// ✅ 好的做法：使用数据采样
List<ZephyrChartData> _sampleData(List<ZephyrChartData> originalData) {
  if (originalData.length <= 100) return originalData;
  
  final step = originalData.length ~/ 100;
  return originalData.asMap().entries.where((entry) {
    return entry.key % step == 0;
  }).map((entry) => entry.value).toList();
}

// ✅ 好的做法：使用动画优化
ZephyrChart(
  data: _data,
  options: ZephyrChartOptions(
    animation: ZephyrChartAnimation(
      duration: Duration(milliseconds: 500), // 适中的动画时长
    ),
  ),
)

// ✅ 好的做法：懒加载数据
class LazyChart extends StatefulWidget {
  @override
  _LazyChartState createState() => _LazyChartState();
}

class _LazyChartState extends State<LazyChart> {
  List<ZephyrChartData> _visibleData = [];
  
  void _loadMoreData() {
    // 只加载可见区域的数据
  }
}

// ❌ 避免的做法：一次性加载大量数据
ZephyrChart(
  data: _hugeDataset, // 影响性能
  options: ZephyrChartOptions(
    animation: ZephyrChartAnimation(
      duration: Duration(seconds: 5), // 动画过长
    ),
  ),
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrChart(
  semanticLabel: '月度销售趋势图表',
  enableAccessibilityFeatures: true,
  data: _data,
)

// ✅ 好的做法：提供键盘导航
Focus(
  child: ZephyrChart(
    data: _data,
    enableAccessibilityFeatures: true,
  ),
)

// ✅ 好的做法：为数据点提供描述
ZephyrChartData(
  x: '1月',
  y: 100,
  label: '1月销售额: 100万元',
)

// ❌ 避免的做法：缺乏无障碍支持
ZephyrChart(
  data: _data,
  // 缺乏语义信息和键盘支持
)
```

### 5. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整图表
class ResponsiveChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ZephyrChart(
      data: _data,
      options: ZephyrChartOptions(
        showLegend: screenWidth > 600,
        showGrid: screenWidth > 400,
      ),
    );
  }
}

// ✅ 好的做法：使用可滚动的图表
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: ZephyrChart(
    width: 800, // 固定宽度，允许横向滚动
    data: _data,
  ),
)

// ❌ 避免的做法：不考虑响应式
ZephyrChart(
  width: 1200, // 在小屏幕上会溢出
  data: _data,
)
```

## 🔄 相关组件

- **ZephyrStatistic**: 统计数据组件
- **ZephyrProgress**: 进度组件
- **ZephyrList**: 列表组件
- **ZephyrTable**: 表格组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本图表类型
- ✅ 支持自定义样式和动画
- ✅ 支持交互式图表
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/advanced/chart/`
**示例路径**: `example/lib/components/chart_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日