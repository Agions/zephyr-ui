import 'package:flutter/material.dart';
import 'src/chart.dart';
import 'src/chart_types.dart';

/// 图表组件示例页面
class ChartDemo extends StatelessWidget {
  const ChartDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图表组件示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('柱状图'),
            _buildBarChartExample(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('折线图'),
            _buildLineChartExample(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('饼图'),
            _buildPieChartExample(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('面积图'),
            _buildAreaChartExample(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('散点图'),
            _buildScatterChartExample(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('雷达图'),
            _buildRadarChartExample(),
          ],
        ),
      ),
    );
  }

  /// 构建区域标题
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 构建柱状图示例
  Widget _buildBarChartExample() {
    const series = [
      ZephyrChartSeries(
        name: '销售额',
        data: [
          ZephyrChartDataPoint(label: '一月', value: 1000),
          ZephyrChartDataPoint(label: '二月', value: 1500),
          ZephyrChartDataPoint(label: '三月', value: 1200),
          ZephyrChartDataPoint(label: '四月', value: 1800),
          ZephyrChartDataPoint(label: '五月', value: 2000),
        ],
        color: Colors.blue,
      ),
    ];

    return const SizedBox(
      height: 300,
      child: ZephyrChart(
        type: ZephyrChartType.bar,
        series: series,
        config: ZephyrChartConfig(
          title: '月度销售额',
          showLegend: true,
          showGrid: true,
          enableAnimation: true,
        ),
      ),
    );
  }

  /// 构建折线图示例
  Widget _buildLineChartExample() {
    const series = [
      ZephyrChartSeries(
        name: '用户增长',
        data: [
          ZephyrChartDataPoint(label: '1月', value: 100),
          ZephyrChartDataPoint(label: '2月', value: 150),
          ZephyrChartDataPoint(label: '3月', value: 200),
          ZephyrChartDataPoint(label: '4月', value: 280),
          ZephyrChartDataPoint(label: '5月', value: 350),
          ZephyrChartDataPoint(label: '6月', value: 420),
        ],
        color: Colors.green,
      ),
      ZephyrChartSeries(
        name: '活跃用户',
        data: [
          ZephyrChartDataPoint(label: '1月', value: 80),
          ZephyrChartDataPoint(label: '2月', value: 120),
          ZephyrChartDataPoint(label: '3月', value: 160),
          ZephyrChartDataPoint(label: '4月', value: 220),
          ZephyrChartDataPoint(label: '5月', value: 280),
          ZephyrChartDataPoint(label: '6月', value: 340),
        ],
        color: Colors.orange,
      ),
    ];

    return const SizedBox(
      height: 300,
      child: ZephyrChart(
        type: ZephyrChartType.line,
        series: series,
        config: ZephyrChartConfig(
          title: '用户增长趋势',
          subtitle: '2024年上半年',
          showLegend: true,
          showGrid: true,
          enableAnimation: true,
        ),
      ),
    );
  }

  /// 构建饼图示例
  Widget _buildPieChartExample() {
    const series = [
      ZephyrChartSeries(
        name: '市场份额',
        data: [
          ZephyrChartDataPoint(label: '产品A', value: 35),
          ZephyrChartDataPoint(label: '产品B', value: 25),
          ZephyrChartDataPoint(label: '产品C', value: 20),
          ZephyrChartDataPoint(label: '产品D', value: 15),
          ZephyrChartDataPoint(label: '其他', value: 5),
        ],
        color: Colors.blue,
      ),
    ];

    return const SizedBox(
      height: 300,
      child: ZephyrChart(
        type: ZephyrChartType.pie,
        series: series,
        config: ZephyrChartConfig(
          title: '市场份额分布',
          showLegend: true,
          showLabels: true,
          enableAnimation: true,
        ),
      ),
    );
  }

  /// 构建面积图示例
  Widget _buildAreaChartExample() {
    const series = [
      ZephyrChartSeries(
        name: '收入',
        data: [
          ZephyrChartDataPoint(label: 'Q1', value: 10000),
          ZephyrChartDataPoint(label: 'Q2', value: 12000),
          ZephyrChartDataPoint(label: 'Q3', value: 15000),
          ZephyrChartDataPoint(label: 'Q4', value: 18000),
        ],
        color: Colors.purple,
      ),
    ];

    return const SizedBox(
      height: 300,
      child: ZephyrChart(
        type: ZephyrChartType.area,
        series: series,
        config: ZephyrChartConfig(
          title: '季度收入',
          showLegend: true,
          showGrid: true,
          enableAnimation: true,
        ),
      ),
    );
  }

  /// 构建散点图示例
  Widget _buildScatterChartExample() {
    const series = [
      ZephyrChartSeries(
        name: '广告投放 vs 销售额',
        data: [
          ZephyrChartDataPoint(label: 'A', value: 1000, metadata: {'sales': 5000}),
          ZephyrChartDataPoint(label: 'B', value: 1500, metadata: {'sales': 7500}),
          ZephyrChartDataPoint(label: 'C', value: 2000, metadata: {'sales': 9000}),
          ZephyrChartDataPoint(label: 'D', value: 2500, metadata: {'sales': 12000}),
          ZephyrChartDataPoint(label: 'E', value: 3000, metadata: {'sales': 14000}),
        ],
        color: Colors.red,
      ),
    ];

    return const SizedBox(
      height: 300,
      child: ZephyrChart(
        type: ZephyrChartType.scatter,
        series: series,
        config: ZephyrChartConfig(
          title: '广告投放效果',
          subtitle: '广告费用与销售额关系',
          showLegend: true,
          showGrid: true,
          enableAnimation: true,
        ),
      ),
    );
  }

  /// 构建雷达图示例
  Widget _buildRadarChartExample() {
    const series = [
      ZephyrChartSeries(
        name: '产品A',
        data: [
          ZephyrChartDataPoint(label: '性能', value: 8),
          ZephyrChartDataPoint(label: '易用性', value: 7),
          ZephyrChartDataPoint(label: '价格', value: 9),
          ZephyrChartDataPoint(label: '设计', value: 8),
          ZephyrChartDataPoint(label: '功能', value: 6),
        ],
        color: Colors.teal,
      ),
      ZephyrChartSeries(
        name: '产品B',
        data: [
          ZephyrChartDataPoint(label: '性能', value: 7),
          ZephyrChartDataPoint(label: '易用性', value: 9),
          ZephyrChartDataPoint(label: '价格', value: 6),
          ZephyrChartDataPoint(label: '设计', value: 7),
          ZephyrChartDataPoint(label: '功能', value: 8),
        ],
        color: Colors.amber,
      ),
    ];

    return const SizedBox(
      height: 300,
      child: ZephyrChart(
        type: ZephyrChartType.radar,
        series: series,
        config: ZephyrChartConfig(
          title: '产品对比',
          showLegend: true,
          showGrid: true,
          enableAnimation: true,
        ),
      ),
    );
  }
}