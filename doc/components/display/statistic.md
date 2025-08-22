# ZephyrStatistic 统计数据组件

统计数据组件是ZephyrUI展示系统中的核心组件，提供了直观的数据统计展示功能。支持多种统计卡片样式、图表集成和动画效果，是构建数据仪表板、分析报告、监控面板等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种统计模式**: 支持基本统计、趋势统计、对比统计等多种模式
- **灵活布局**: 支持水平、垂直、网格等布局方式
- **丰富可视化**: 支持图标、图表、进度条等多种可视化元素
- **动画效果**: 内置平滑的数字增长动画效果
- **响应式设计**: 根据屏幕尺寸自动调整布局
- **主题适配**: 完整的主题系统支持

### 适用场景
- 数据仪表板
- 分析报告
- 监控面板
- 业务统计
- KPI展示
- 实时数据监控

## 🚀 基础用法

### 基本统计卡片

```dart
class BasicStatisticExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本统计卡片'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 单行统计卡片
            Row(
              children: [
                Expanded(
                  child: ZephyrStatistic(
                    title: '总用户数',
                    value: '12,345',
                    unit: '人',
                    icon: Icon(Icons.people, color: Colors.blue),
                    valueStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ZephyrStatistic(
                    title: '活跃用户',
                    value: '8,765',
                    unit: '人',
                    icon: Icon(Icons.person, color: Colors.green),
                    valueStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // 带趋势的统计卡片
            Row(
              children: [
                Expanded(
                  child: ZephyrStatistic(
                    title: '销售额',
                    value: '¥234,567',
                    trend: StatisticTrend.up,
                    trendValue: '+12.5%',
                    icon: Icon(Icons.trending_up, color: Colors.orange),
                    valueStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ZephyrStatistic(
                    title: '转化率',
                    value: '3.45',
                    unit: '%',
                    trend: StatisticTrend.down,
                    trendValue: '-2.1%',
                    icon: Icon(Icons.trending_down, color: Colors.red),
                    valueStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 图表集成统计

```dart
class ChartStatisticExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图表集成统计'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 带迷你图表的统计卡片
            ZephyrStatistic(
              title: '月度收入',
              value: '¥456,789',
              trend: StatisticTrend.up,
              trendValue: '+8.3%',
              icon: Icon(Icons.attach_money, color: Colors.green),
              valueStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              chart: _buildMiniLineChart(),
            ),
            SizedBox(height: 16),
            // 带进度条的统计卡片
            ZephyrStatistic(
              title: '目标完成度',
              value: '78',
              unit: '%',
              icon: Icon(Icons.flag, color: Colors.blue),
              valueStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              progress: 0.78,
              progressColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniLineChart() {
    return Container(
      height: 60,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(1, 4),
                FlSpot(2, 2),
                FlSpot(3, 5),
                FlSpot(4, 4),
                FlSpot(5, 6),
              ],
              isCurved: true,
              color: Colors.green.withOpacity(0.8),
              barWidth: 2,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.green.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 对比统计卡片

```dart
class ComparisonStatisticExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('对比统计卡片'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrStatistic(
          title: '本月vs上月',
          value: '¥123,456',
          previousValue: '¥98,765',
          comparison: StatisticComparison.increase,
          comparisonValue: '+25.0%',
          icon: Icon(Icons.compare_arrows, color: Colors.purple),
          valueStyle: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
          previousValueStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 彩色统计卡片

```dart
class ColoredStatisticExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('彩色统计卡片'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            // 蓝色卡片
            ZephyrStatistic(
              title: '总访问量',
              value: '456,789',
              unit: '次',
              trend: StatisticTrend.up,
              trendValue: '+15.3%',
              icon: Icon(Icons.visibility, color: Colors.white),
              valueStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              titleStyle: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
            ),
            // 绿色卡片
            ZephyrStatistic(
              title: '新用户',
              value: '1,234',
              unit: '人',
              trend: StatisticTrend.up,
              trendValue: '+8.7%',
              icon: Icon(Icons.person_add, color: Colors.white),
              valueStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              titleStyle: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[400]!, Colors.green[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
            ),
            // 橙色卡片
            ZephyrStatistic(
              title: '转化率',
              value: '4.56',
              unit: '%',
              trend: StatisticTrend.down,
              trendValue: '-2.1%',
              icon: Icon(Icons.show_chart, color: Colors.white),
              valueStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              titleStyle: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[400]!, Colors.orange[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
            ),
            // 紫色卡片
            ZephyrStatistic(
              title: '客单价',
              value: '¥234',
              trend: StatisticTrend.up,
              trendValue: '+5.2%',
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              valueStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              titleStyle: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[400]!, Colors.purple[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 圆形进度统计

```dart
class CircularProgressStatisticExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆形进度统计'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
          children: [
            // 基础圆形进度
            ZephyrStatistic(
              title: 'CPU使用率',
              value: '45',
              unit: '%',
              icon: Icon(Icons.memory),
              valueStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              circularProgress: 0.45,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey[200],
              strokeWidth: 8,
            ),
            // 带趋势的圆形进度
            ZephyrStatistic(
              title: '内存使用率',
              value: '67',
              unit: '%',
              trend: StatisticTrend.up,
              trendValue: '+3.2%',
              icon: Icon(Icons.storage),
              valueStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              circularProgress: 0.67,
              progressColor: Colors.orange,
              backgroundColor: Colors.grey[200],
              strokeWidth: 8,
            ),
            // 多段圆形进度
            ZephyrStatistic(
              title: '存储空间',
              value: '78',
              unit: '%',
              icon: Icon(Icons.sd_storage),
              valueStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              circularProgress: 0.78,
              progressColor: Colors.green,
              backgroundColor: Colors.grey[200],
              strokeWidth: 8,
              secondaryProgress: 0.15,
              secondaryProgressColor: Colors.orange,
            ),
            // 带动画的圆形进度
            ZephyrStatistic(
              title: '网络带宽',
              value: '82',
              unit: '%',
              trend: StatisticTrend.down,
              trendValue: '-1.5%',
              icon: Icon(Icons.network_check),
              valueStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              circularProgress: 0.82,
              progressColor: Colors.red,
              backgroundColor: Colors.grey[200],
              strokeWidth: 8,
              animate: true,
            ),
          ],
        ),
      ),
    );
  }
}
```

### 迷你统计卡片

```dart
class MiniStatisticExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('迷你统计卡片'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 横向迷你统计卡片
            Row(
              children: [
                Expanded(
                  child: ZephyrStatistic(
                    title: '今日UV',
                    value: '2,345',
                    compact: true,
                    icon: Icon(Icons.visibility, size: 16),
                    valueStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    titleStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ZephyrStatistic(
                    title: '今日PV',
                    value: '12,345',
                    compact: true,
                    icon: Icon(Icons.pageview, size: 16),
                    valueStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    titleStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ZephyrStatistic(
                    title: '跳出率',
                    value: '45.6',
                    unit: '%',
                    compact: true,
                    icon: Icon(Icons.exit_to_app, size: 16),
                    valueStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    titleStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ZephyrStatistic(
                    title: '平均时长',
                    value: '3:45',
                    compact: true,
                    icon: Icon(Icons.timer, size: 16),
                    valueStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    titleStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // 带趋势的迷你统计
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ZephyrStatistic(
                  title: '收入',
                  value: '¥23.4K',
                  trend: StatisticTrend.up,
                  trendValue: '+12%',
                  compact: true,
                  icon: Icon(Icons.trending_up, size: 16, color: Colors.green),
                  valueStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                ZephyrStatistic(
                  title: '支出',
                  value: '¥18.2K',
                  trend: StatisticTrend.down,
                  trendValue: '-5%',
                  compact: true,
                  icon: Icon(Icons.trending_down, size: 16, color: Colors.red),
                  valueStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                ZephyrStatistic(
                  title: '利润',
                  value: '¥5.2K',
                  trend: StatisticTrend.up,
                  trendValue: '+28%',
                  compact: true,
                  icon: Icon(Icons.trending_up, size: 16, color: Colors.blue),
                  valueStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 实时数据统计

```dart
class RealTimeStatisticExample extends StatefulWidget {
  @override
  _RealTimeStatisticExampleState createState() => _RealTimeStatisticExampleState();
}

class _RealTimeStatisticExampleState extends State<RealTimeStatisticExample> {
  int _userCount = 1234;
  int _orderCount = 56;
  double _revenue = 12345.67;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startRealTimeUpdates();
  }

  void _startRealTimeUpdates() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _userCount += Random().nextInt(10) - 5;
        _orderCount += Random().nextInt(3) - 1;
        _revenue += Random().nextInt(100) - 50;
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
        title: Text('实时数据统计'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 实时用户数
            ZephyrStatistic(
              title: '在线用户',
              value: _userCount.toString(),
              unit: '人',
              icon: Icon(Icons.people, color: Colors.blue),
              valueStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              animate: true,
              duration: Duration(milliseconds: 500),
            ),
            SizedBox(height: 16),
            // 实时订单数
            ZephyrStatistic(
              title: '今日订单',
              value: _orderCount.toString(),
              unit: '单',
              icon: Icon(Icons.shopping_cart, color: Colors.green),
              valueStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              animate: true,
              duration: Duration(milliseconds: 500),
            ),
            SizedBox(height: 16),
            // 实时收入
            ZephyrStatistic(
              title: '今日收入',
              value: _revenue.toStringAsFixed(2),
              unit: '元',
              icon: Icon(Icons.attach_money, color: Colors.orange),
              valueStyle: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              animate: true,
              duration: Duration(milliseconds: 500),
            ),
            SizedBox(height: 16),
            // 实时状态指示
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '实时更新中...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 分组统计卡片

```dart
class GroupedStatisticExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分组统计卡片'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 用户统计组
            ZephyrStatisticGroup(
              title: '用户统计',
              icon: Icon(Icons.group),
              children: [
                ZephyrStatistic(
                  title: '总用户',
                  value: '12,345',
                  unit: '人',
                  compact: true,
                ),
                ZephyrStatistic(
                  title: '新增用户',
                  value: '234',
                  unit: '人',
                  trend: StatisticTrend.up,
                  trendValue: '+12%',
                  compact: true,
                ),
                ZephyrStatistic(
                  title: '活跃用户',
                  value: '8,765',
                  unit: '人',
                  trend: StatisticTrend.up,
                  trendValue: '+5%',
                  compact: true,
                ),
              ],
            ),
            SizedBox(height: 16),
            // 销售统计组
            ZephyrStatisticGroup(
              title: '销售统计',
              icon: Icons.trending_up,
              children: [
                ZephyrStatistic(
                  title: '总销售额',
                  value: '¥234,567',
                  compact: true,
                ),
                ZephyrStatistic(
                  title: '订单数',
                  value: '1,234',
                  unit: '单',
                  trend: StatisticTrend.up,
                  trendValue: '+8%',
                  compact: true,
                ),
                ZephyrStatistic(
                  title: '客单价',
                  value: '¥190',
                  trend: StatisticTrend.down,
                  trendValue: '-3%',
                  compact: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 自定义统计卡片

```dart
class CustomStatisticExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义统计卡片'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrStatistic(
          title: '项目进度',
          value: '75',
          unit: '%',
          icon: Icon(Icons.assignment),
          valueStyle: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          titleStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
          customContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              LinearProgressIndicator(
                value: 0.75,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '开始时间: 2024-01-01',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '预计完成: 2024-03-31',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: Text('进行中'),
                    backgroundColor: Colors.deepPurple[50],
                    labelStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Chip(
                    label: Text('按时进度'),
                    backgroundColor: Colors.green[50],
                    labelStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(24),
        ),
      ),
    );
  }
}
```

### 动画统计卡片

```dart
class AnimatedStatisticExample extends StatefulWidget {
  @override
  _AnimatedStatisticExampleState createState() => _AnimatedStatisticExampleState();
}

class _AnimatedStatisticExampleState extends State<AnimatedStatisticExample> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画统计卡片'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            setState(() => _isExpanded = !_isExpanded);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: _isExpanded ? 12 : 8,
                  offset: Offset(0, _isExpanded ? 6 : 4),
                ),
              ],
            ),
            child: ZephyrStatistic(
              title: '月度目标',
              value: '85',
              unit: '%',
              icon: Icon(Icons.flag, color: Colors.blue),
              valueStyle: TextStyle(
                fontSize: _isExpanded ? 48 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              animate: true,
              duration: Duration(milliseconds: 1000),
              customContent: _isExpanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: 0.85,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('已完成: 85%'),
                            Text('剩余: 15%'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          '继续保持，目标即将达成！',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  : null,
              padding: EdgeInsets.all(_isExpanded ? 32 : 24),
            ),
          ),
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrStatistic()

```dart
const ZephyrStatistic({
  Key? key,
  required String title,
  required String value,
  String? unit,
  String? previousValue,
  Widget? icon,
  Widget? chart,
  double? progress,
  Color? progressColor,
  double? circularProgress,
  Color? circularProgressColor,
  Color? backgroundColor,
  double? secondaryProgress,
  Color? secondaryProgressColor,
  StatisticTrend? trend,
  String? trendValue,
  StatisticComparison? comparison,
  String? comparisonValue,
  TextStyle? valueStyle,
  TextStyle? titleStyle,
  TextStyle? subtitleStyle,
  TextStyle? trendStyle,
  TextStyle? previousValueStyle,
  Widget? customContent,
  BoxDecoration? decoration,
  EdgeInsetsGeometry? padding,
  bool compact = false,
  bool animate = false,
  Duration? duration,
  String? tooltip,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `title`: 标题
- `value`: 数值
- `unit`: 单位
- `previousValue`: 对比值
- `icon`: 图标
- `chart`: 图表
- `progress`: 线性进度值
- `progressColor`: 进度颜色
- `circularProgress`: 圆形进度值
- `circularProgressColor`: 圆形进度颜色
- `backgroundColor`: 背景颜色
- `secondaryProgress`: 次要进度值
- `secondaryProgressColor`: 次要进度颜色
- `trend`: 趋势
- `trendValue`: 趋势值
- `comparison`: 对比类型
- `comparisonValue`: 对比值
- `valueStyle`: 数值样式
- `titleStyle`: 标题样式
- `subtitleStyle`: 副标题样式
- `trendStyle`: 趋势样式
- `previousValueStyle`: 对比值样式
- `customContent`: 自定义内容
- `decoration`: 装饰
- `padding`: 内边距
- `compact`: 是否紧凑模式
- `animate`: 是否启用动画
- `duration`: 动画持续时间
- `tooltip`: 工具提示
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 枚举类型

#### StatisticTrend

```dart
enum StatisticTrend {
  up,    // 上升趋势
  down,  // 下降趋势
  flat,  // 平稳趋势
}
```

#### StatisticComparison

```dart
enum StatisticComparison {
  increase, // 增长
  decrease, // 减少
  equal,    // 相等
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrStatisticTheme(
        defaultValueStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        defaultTitleStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
        ),
        defaultSubtitleStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
        defaultTrendStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        defaultPreviousValueStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          decoration: TextDecoration.lineThrough,
        ),
        defaultProgressColor: Colors.blue,
        defaultCircularProgressColor: Colors.blue,
        defaultBackgroundColor: Colors.grey[200],
        defaultSecondaryProgressColor: Colors.orange,
        defaultDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        defaultPadding: EdgeInsets.all(16),
        compactValueStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        compactTitleStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
        upTrendColor: Colors.green,
        downTrendColor: Colors.red,
        flatTrendColor: Colors.grey,
        animationDuration: Duration(milliseconds: 1000),
        animationCurve: Curves.easeOutQuart,
        hoverColor: Colors.grey.withOpacity(0.1),
        focusColor: Colors.blue.withOpacity(0.1),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultValueStyle`: 默认数值样式
- `defaultTitleStyle`: 默认标题样式
- `defaultSubtitleStyle`: 默认副标题样式
- `defaultTrendStyle`: 默认趋势样式
- `defaultPreviousValueStyle`: 默认对比值样式
- `defaultProgressColor`: 默认进度颜色
- `defaultCircularProgressColor`: 默认圆形进度颜色
- `defaultBackgroundColor`: 默认背景颜色
- `defaultSecondaryProgressColor`: 默认次要进度颜色
- `defaultDecoration`: 默认装饰
- `defaultPadding`: 默认内边距
- `compactValueStyle`: 紧凑模式数值样式
- `compactTitleStyle`: 紧凑模式标题样式
- `upTrendColor`: 上升趋势颜色
- `downTrendColor`: 下降趋势颜色
- `flatTrendColor`: 平稳趋势颜色
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的数值展示

```dart
// ✅ 好的做法：使用合适的数值精度
ZephyrStatistic(
  title: '转化率',
  value: '3.45', // 保留两位小数
  unit: '%',
)

// ✅ 好的做法：大数值使用千位分隔符
ZephyrStatistic(
  title: '总用户数',
  value: '1,234,567', // 使用千位分隔符
  unit: '人',
)

// ✅ 好的做法：根据场景选择单位
ZephyrStatistic(
  title: '收入',
  value: '2.34', // 使用K单位
  unit: 'K',
)

// ❌ 避免的做法：数值精度不当
ZephyrStatistic(
  title: '转化率',
  value: '3.456789', // 精度过高，难以阅读
  unit: '%',
)
```

### 2. 清晰的视觉层次

```dart
// ✅ 好的做法：使用颜色和大小区分重要性
ZephyrStatistic(
  title: '重要指标',
  value: '123,456',
  valueStyle: TextStyle(
    fontSize: 32, // 较大的字体
    fontWeight: FontWeight.bold,
    color: Colors.red, // 重要颜色
  ),
)

// ✅ 好的做法：使用图标增强识别
ZephyrStatistic(
  title: '用户数',
  value: '12,345',
  icon: Icon(Icons.people), // 相关图标
)

// ✅ 好的做法：合理使用趋势指示
ZephyrStatistic(
  title: '销售额',
  value: '¥234,567',
  trend: StatisticTrend.up,
  trendValue: '+12.5%',
)

// ❌ 避免的做法：缺乏视觉层次
ZephyrStatistic(
  title: '指标',
  value: '12345',
  // 所有信息看起来一样重要
)
```

### 3. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整
class ResponsiveStatistic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ZephyrStatistic(
      title: '总用户数',
      value: '12,345',
      valueStyle: TextStyle(
        fontSize: screenWidth > 600 ? 24 : 18, // 响应式字体大小
      ),
      compact: screenWidth < 400, // 小屏幕使用紧凑模式
    );
  }
}

// ✅ 好的做法：使用网格布局
GridView.count(
  crossAxisCount: 2,
  children: [
    ZephyrStatistic(title: '指标1', value: '123'),
    ZephyrStatistic(title: '指标2', value: '456'),
  ],
)

// ❌ 避免的做法：固定尺寸
ZephyrStatistic(
  title: '指标',
  value: '123',
  // 在小屏幕上可能显示不全
)
```

### 4. 性能优化

```dart
// ✅ 好的做法：使用动画避免突兀变化
ZephyrStatistic(
  title: '实时数据',
  value: _currentValue.toString(),
  animate: true,
  duration: Duration(milliseconds: 500),
)

// ✅ 好的做法：避免过度装饰
ZephyrStatistic(
  title: '简单指标',
  value: '123',
  // 只使用必要的装饰
)

// ✅ 好的做法：按需加载图表
ZephyrStatistic(
  title: '带图表的指标',
  value: '123',
  chart: _shouldShowChart ? _buildChart() : null,
)

// ❌ 避免的做法：过度使用动画
ZephyrStatistic(
  title: '静态指标',
  value: '123',
  animate: true, // 静态数据不需要动画
)
```

## 🔄 相关组件

- **ZephyrCard**: 卡片组件
- **ZephyrProgress**: 进度条组件
- **ZephyrChart**: 图表组件
- **ZephyrDashboard**: 仪表板组件
- **ZephyrDataGrid**: 数据网格组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种统计模式
- ✅ 支持图表集成
- ✅ 支持动画效果
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/statistic/`
**示例路径**: `example/lib/components/statistic_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日