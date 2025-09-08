import 'package:flutter/material.dart';
import 'package:chroma_ui/chroma_ui.dart';

/// 图表组件 Storybook 故事
class ChartComponentsStorybook {
  /// 获取所有图表组件的故事
  static List<StorybookStory> getStories() {
    return [
      _lineChartStory(),
      _barChartStory(),
      _pieChartStory(),
      _areaChartStory(),
      _scatterChartStory(),
      _radarChartStory(),
      _heatmapChartStory(),
      _gaugeChartStory(),
      _funnelChartStory(),
      _combinationChartStory(),
    ];
  }

  /// 折线图组件故事
  static StorybookStory _lineChartStory() {
    return StorybookStory(
      name: 'chromaLineChart',
      category: '图表组件',
      description: '折线图组件，支持多条数据系列和交互功能',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础折线图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaLineChart(
              data: [
                LineChartData(
                  name: '销售额',
                  data: [
                    ChartDataPoint(x: 1, y: 30),
                    ChartDataPoint(x: 2, y: 45),
                    ChartDataPoint(x: 3, y: 35),
                    ChartDataPoint(x: 4, y: 50),
                    ChartDataPoint(x: 5, y: 40),
                    ChartDataPoint(x: 6, y: 60),
                    ChartDataPoint(x: 7, y: 55),
                  ],
                  color: Colors.blue,
                ),
              ],
              xAxis: ChartAxis(
                title: '月份',
                min: 1,
                max: 7,
              ),
              yAxis: ChartAxis(
                title: '销售额（万元）',
                min: 0,
                max: 70,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('多条数据系列', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaLineChart(
              data: [
                LineChartData(
                  name: '产品A',
                  data: [
                    ChartDataPoint(x: 1, y: 30),
                    ChartDataPoint(x: 2, y: 45),
                    ChartDataPoint(x: 3, y: 35),
                    ChartDataPoint(x: 4, y: 50),
                    ChartDataPoint(x: 5, y: 40),
                    ChartDataPoint(x: 6, y: 60),
                    ChartDataPoint(x: 7, y: 55),
                  ],
                  color: Colors.blue,
                ),
                LineChartData(
                  name: '产品B',
                  data: [
                    ChartDataPoint(x: 1, y: 20),
                    ChartDataPoint(x: 2, y: 35),
                    ChartDataPoint(x: 3, y: 45),
                    ChartDataPoint(x: 4, y: 30),
                    ChartDataPoint(x: 5, y: 55),
                    ChartDataPoint(x: 6, y: 45),
                    ChartDataPoint(x: 7, y: 65),
                  ],
                  color: Colors.green,
                ),
                LineChartData(
                  name: '产品C',
                  data: [
                    ChartDataPoint(x: 1, y: 25),
                    ChartDataPoint(x: 2, y: 30),
                    ChartDataPoint(x: 3, y: 40),
                    ChartDataPoint(x: 4, y: 45),
                    ChartDataPoint(x: 5, y: 35),
                    ChartDataPoint(x: 6, y: 50),
                    ChartDataPoint(x: 7, y: 45),
                  ],
                  color: Colors.orange,
                ),
              ],
              xAxis: ChartAxis(
                title: '月份',
                min: 1,
                max: 7,
              ),
              yAxis: ChartAxis(
                title: '销售额（万元）',
                min: 0,
                max: 70,
              ),
              showLegend: true,
            ),
          ),
          const SizedBox(height: 24),
          const Text('平滑曲线和标记点', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaLineChart(
              data: [
                LineChartData(
                  name: '用户增长',
                  data: [
                    ChartDataPoint(x: 1, y: 100),
                    ChartDataPoint(x: 2, y: 150),
                    ChartDataPoint(x: 3, y: 200),
                    ChartDataPoint(x: 4, y: 280),
                    ChartDataPoint(x: 5, y: 350),
                    ChartDataPoint(x: 6, y: 420),
                    ChartDataPoint(x: 7, y: 500),
                  ],
                  color: Colors.purple,
                  smooth: true,
                  showPoints: true,
                ),
              ],
              xAxis: ChartAxis(
                title: '月份',
                min: 1,
                max: 7,
              ),
              yAxis: ChartAxis(
                title: '用户数',
                min: 0,
                max: 600,
              ),
              showGrid: true,
            ),
          ),
        ],
      ),
      controls: [
        StorybookBooleanControl(
          label: '显示网格',
          defaultValue: true,
          description: '是否显示网格线',
        ),
        StorybookBooleanControl(
          label: '显示图例',
          defaultValue: true,
          description: '是否显示图例',
        ),
        StorybookBooleanControl(
          label: '平滑曲线',
          defaultValue: false,
          description: '是否使用平滑曲线',
        ),
        StorybookBooleanControl(
          label: '显示标记点',
          defaultValue: false,
          description: '是否显示数据点标记',
        ),
        StorybookBooleanControl(
          label: '启用动画',
          defaultValue: true,
          description: '是否启用动画效果',
        ),
      ],
      codeExample: '''
// 基础折线图
chromaLineChart(
  data: [
    LineChartData(
      name: '销售额',
      data: [
        ChartDataPoint(x: 1, y: 30),
        ChartDataPoint(x: 2, y: 45),
        ChartDataPoint(x: 3, y: 35),
        ChartDataPoint(x: 4, y: 50),
        ChartDataPoint(x: 5, y: 40),
        ChartDataPoint(x: 6, y: 60),
        ChartDataPoint(x: 7, y: 55),
      ],
      color: Colors.blue,
    ),
  ],
  xAxis: ChartAxis(
    title: '月份',
    min: 1,
    max: 7,
  ),
  yAxis: ChartAxis(
    title: '销售额（万元）',
    min: 0,
    max: 70,
  ),
)

// 多条数据系列
chromaLineChart(
  data: [
    LineChartData(
      name: '产品A',
      data: data1,
      color: Colors.blue,
    ),
    LineChartData(
      name: '产品B',
      data: data2,
      color: Colors.green,
    ),
  ],
  showLegend: true,
  showGrid: true,
)

// 平滑曲线
chromaLineChart(
  data: [
    LineChartData(
      name: '用户增长',
      data: data,
      color: Colors.purple,
      smooth: true,
      showPoints: true,
    ),
  ],
)
''',
    );
  }

  /// 柱状图组件故事
  static StorybookStory _barChartStory() {
    return StorybookStory(
      name: 'chromaBarChart',
      category: '图表组件',
      description: '柱状图组件，支持垂直和水平布局',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('垂直柱状图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaBarChart(
              data: [
                BarChartData(
                  name: 'Q1',
                  value: 45,
                  color: Colors.blue,
                ),
                BarChartData(
                  name: 'Q2',
                  value: 65,
                  color: Colors.green,
                ),
                BarChartData(
                  name: 'Q3',
                  value: 55,
                  color: Colors.orange,
                ),
                BarChartData(
                  name: 'Q4',
                  value: 75,
                  color: Colors.purple,
                ),
              ],
              xAxis: ChartAxis(
                title: '季度',
              ),
              yAxis: ChartAxis(
                title: '销售额（万元）',
                min: 0,
                max: 100,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('水平柱状图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaBarChart(
              orientation: BarChartOrientation.horizontal,
              data: [
                BarChartData(
                  name: '产品A',
                  value: 45,
                  color: Colors.blue,
                ),
                BarChartData(
                  name: '产品B',
                  value: 65,
                  color: Colors.green,
                ),
                BarChartData(
                  name: '产品C',
                  value: 55,
                  color: Colors.orange,
                ),
                BarChartData(
                  name: '产品D',
                  value: 75,
                  color: Colors.purple,
                ),
              ],
              xAxis: ChartAxis(
                title: '销售额（万元）',
                min: 0,
                max: 100,
              ),
              yAxis: ChartAxis(
                title: '产品',
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('分组柱状图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaBarChart(
              type: BarChartType.grouped,
              data: [
                BarChartData(
                  name: 'Q1-2023',
                  value: 45,
                  group: '2023',
                  color: Colors.blue,
                ),
                BarChartData(
                  name: 'Q2-2023',
                  value: 65,
                  group: '2023',
                  color: Colors.blue,
                ),
                BarChartData(
                  name: 'Q1-2024',
                  value: 55,
                  group: '2024',
                  color: Colors.green,
                ),
                BarChartData(
                  name: 'Q2-2024',
                  value: 75,
                  group: '2024',
                  color: Colors.green,
                ),
              ],
              xAxis: ChartAxis(
                title: '季度',
              ),
              yAxis: ChartAxis(
                title: '销售额（万元）',
                min: 0,
                max: 100,
              ),
              showLegend: true,
            ),
          ),
          const SizedBox(height: 24),
          const Text('堆叠柱状图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaBarChart(
              type: BarChartType.stacked,
              data: [
                BarChartData(
                  name: '产品A',
                  value: 30,
                  color: Colors.blue,
                ),
                BarChartData(
                  name: '产品B',
                  value: 25,
                  color: Colors.green,
                ),
                BarChartData(
                  name: '产品C',
                  value: 20,
                  color: Colors.orange,
                ),
                BarChartData(
                  name: '产品A',
                  value: 35,
                  color: Colors.blue,
                ),
                BarChartData(
                  name: '产品B',
                  value: 30,
                  color: Colors.green,
                ),
                BarChartData(
                  name: '产品C',
                  value: 25,
                  color: Colors.orange,
                ),
              ],
              xAxis: ChartAxis(
                title: '季度',
                categories: ['Q1', 'Q2'],
              ),
              yAxis: ChartAxis(
                title: '销售额（万元）',
                min: 0,
                max: 100,
              ),
              showLegend: true,
            ),
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '方向',
          defaultValue: 'vertical',
          options: ['vertical', 'horizontal'],
          description: '柱状图的方向',
        ),
        StorybookSelectControl(
          label: '类型',
          defaultValue: 'basic',
          options: ['basic', 'grouped', 'stacked'],
          description: '柱状图的类型',
        ),
        StorybookBooleanControl(
          label: '显示网格',
          defaultValue: true,
          description: '是否显示网格线',
        ),
        StorybookBooleanControl(
          label: '显示图例',
          defaultValue: true,
          description: '是否显示图例',
        ),
        StorybookBooleanControl(
          label: '显示数值',
          defaultValue: false,
          description: '是否显示数值标签',
        ),
      ],
      codeExample: '''
// 垂直柱状图
chromaBarChart(
  data: [
    BarChartData(
      name: 'Q1',
      value: 45,
      color: Colors.blue,
    ),
    BarChartData(
      name: 'Q2',
      value: 65,
      color: Colors.green,
    ),
    BarChartData(
      name: 'Q3',
      value: 55,
      color: Colors.orange,
    ),
    BarChartData(
      name: 'Q4',
      value: 75,
      color: Colors.purple,
    ),
  ],
  xAxis: ChartAxis(
    title: '季度',
  ),
  yAxis: ChartAxis(
    title: '销售额（万元）',
    min: 0,
    max: 100,
  ),
)

// 水平柱状图
chromaBarChart(
  orientation: BarChartOrientation.horizontal,
  data: [
    BarChartData(
      name: '产品A',
      value: 45,
      color: Colors.blue,
    ),
    BarChartData(
      name: '产品B',
      value: 65,
      color: Colors.green,
    ),
  ],
  xAxis: ChartAxis(
    title: '销售额（万元）',
    min: 0,
    max: 100,
  ),
  yAxis: ChartAxis(
    title: '产品',
  ),
)

// 分组柱状图
chromaBarChart(
  type: BarChartType.grouped,
  data: [
    BarChartData(
      name: 'Q1-2023',
      value: 45,
      group: '2023',
      color: Colors.blue,
    ),
    BarChartData(
      name: 'Q1-2024',
      value: 55,
      group: '2024',
      color: Colors.green,
    ),
  ],
  showLegend: true,
)

// 堆叠柱状图
chromaBarChart(
  type: BarChartType.stacked,
  data: [
    BarChartData(
      name: '产品A',
      value: 30,
      color: Colors.blue,
    ),
    BarChartData(
      name: '产品B',
      value: 25,
      color: Colors.green,
    ),
  ],
  showLegend: true,
)
''',
    );
  }

  /// 饼图组件故事
  static StorybookStory _pieChartStory() {
    return StorybookStory(
      name: 'chromaPieChart',
      category: '图表组件',
      description: '饼图组件，支持多种展示模式和交互',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础饼图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaPieChart(
              data: [
                PieChartData(
                  name: '移动端',
                  value: 45,
                  color: Colors.blue,
                ),
                PieChartData(
                  name: '桌面端',
                  value: 30,
                  color: Colors.green,
                ),
                PieChartData(
                  name: '平板端',
                  value: 15,
                  color: Colors.orange,
                ),
                PieChartData(
                  name: '其他',
                  value: 10,
                  color: Colors.grey,
                ),
              ],
              showLegend: true,
              showLabels: true,
            ),
          ),
          const SizedBox(height: 24),
          const Text('环形图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaPieChart(
              type: PieChartType.donut,
              data: [
                PieChartData(
                  name: '完成',
                  value: 65,
                  color: Colors.green,
                ),
                PieChartData(
                  name: '进行中',
                  value: 25,
                  color: Colors.orange,
                ),
                PieChartData(
                  name: '待开始',
                  value: 10,
                  color: Colors.grey,
                ),
              ],
              showLegend: true,
              showLabels: true,
              centerText: '65%',
            ),
          ),
          const SizedBox(height: 24),
          const Text('3D饼图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaPieChart(
              type: PieChartType.threeD,
              data: [
                PieChartData(
                  name: '产品A',
                  value: 35,
                  color: Colors.blue,
                ),
                PieChartData(
                  name: '产品B',
                  value: 25,
                  color: Colors.green,
                ),
                PieChartData(
                  name: '产品C',
                  value: 20,
                  color: Colors.orange,
                ),
                PieChartData(
                  name: '产品D',
                  value: 20,
                  color: Colors.purple,
                ),
              ],
              showLegend: true,
              showLabels: true,
            ),
          ),
          const SizedBox(height: 24),
          const Text('分离饼图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaPieChart(
              type: PieChartType.exploded,
              data: [
                PieChartData(
                  name: '重点客户',
                  value: 40,
                  color: Colors.blue,
                  exploded: true,
                ),
                PieChartData(
                  name: '普通客户',
                  value: 35,
                  color: Colors.green,
                ),
                PieChartData(
                  name: '潜在客户',
                  value: 25,
                  color: Colors.orange,
                ),
              ],
              showLegend: true,
              showLabels: true,
            ),
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '类型',
          defaultValue: 'basic',
          options: ['basic', 'donut', 'threeD', 'exploded'],
          description: '饼图的类型',
        ),
        StorybookBooleanControl(
          label: '显示图例',
          defaultValue: true,
          description: '是否显示图例',
        ),
        StorybookBooleanControl(
          label: '显示标签',
          defaultValue: true,
          description: '是否显示标签',
        ),
        StorybookBooleanControl(
          label: '显示百分比',
          defaultValue: true,
          description: '是否显示百分比',
        ),
        StorybookBooleanControl(
          label: '启用动画',
          defaultValue: true,
          description: '是否启用动画效果',
        ),
      ],
      codeExample: '''
// 基础饼图
chromaPieChart(
  data: [
    PieChartData(
      name: '移动端',
      value: 45,
      color: Colors.blue,
    ),
    PieChartData(
      name: '桌面端',
      value: 30,
      color: Colors.green,
    ),
    PieChartData(
      name: '平板端',
      value: 15,
      color: Colors.orange,
    ),
    PieChartData(
      name: '其他',
      value: 10,
      color: Colors.grey,
    ),
  ],
  showLegend: true,
  showLabels: true,
)

// 环形图
chromaPieChart(
  type: PieChartType.donut,
  data: [
    PieChartData(
      name: '完成',
      value: 65,
      color: Colors.green,
    ),
    PieChartData(
      name: '进行中',
      value: 25,
      color: Colors.orange,
    ),
    PieChartData(
      name: '待开始',
      value: 10,
      color: Colors.grey,
    ),
  ],
  showLegend: true,
  centerText: '65%',
)

// 3D饼图
chromaPieChart(
  type: PieChartType.threeD,
  data: data,
  showLegend: true,
  showLabels: true,
)

// 分离饼图
chromaPieChart(
  type: PieChartType.exploded,
  data: [
    PieChartData(
      name: '重点客户',
      value: 40,
      color: Colors.blue,
      exploded: true,
    ),
    PieChartData(
      name: '普通客户',
      value: 35,
      color: Colors.green,
    ),
  ],
  showLegend: true,
)
''',
    );
  }

  /// 面积图组件故事
  static StorybookStory _areaChartStory() {
    return StorybookStory(
      name: 'chromaAreaChart',
      category: '图表组件',
      description: '面积图组件，支持渐变填充和堆叠模式',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础面积图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaAreaChart(
              data: [
                AreaChartData(
                  name: '访问量',
                  data: [
                    ChartDataPoint(x: 1, y: 30),
                    ChartDataPoint(x: 2, y: 45),
                    ChartDataPoint(x: 3, y: 35),
                    ChartDataPoint(x: 4, y: 50),
                    ChartDataPoint(x: 5, y: 40),
                    ChartDataPoint(x: 6, y: 60),
                    ChartDataPoint(x: 7, y: 55),
                  ],
                  color: Colors.blue,
                  gradient: LinearGradient(
                    colors: [Colors.blue.withOpacity(0.8), Colors.blue.withOpacity(0.1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ],
              xAxis: ChartAxis(
                title: '日期',
                min: 1,
                max: 7,
              ),
              yAxis: ChartAxis(
                title: '访问量',
                min: 0,
                max: 70,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('堆叠面积图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaAreaChart(
              type: AreaChartType.stacked,
              data: [
                AreaChartData(
                  name: '产品A',
                  data: [
                    ChartDataPoint(x: 1, y: 20),
                    ChartDataPoint(x: 2, y: 25),
                    ChartDataPoint(x: 3, y: 30),
                    ChartDataPoint(x: 4, y: 35),
                    ChartDataPoint(x: 5, y: 40),
                    ChartDataPoint(x: 6, y: 45),
                    ChartDataPoint(x: 7, y: 50),
                  ],
                  color: Colors.blue,
                ),
                AreaChartData(
                  name: '产品B',
                  data: [
                    ChartDataPoint(x: 1, y: 15),
                    ChartDataPoint(x: 2, y: 20),
                    ChartDataPoint(x: 3, y: 15),
                    ChartDataPoint(x: 4, y: 25),
                    ChartDataPoint(x: 5, y: 20),
                    ChartDataPoint(x: 6, y: 30),
                    ChartDataPoint(x: 7, y: 25),
                  ],
                  color: Colors.green,
                ),
                AreaChartData(
                  name: '产品C',
                  data: [
                    ChartDataPoint(x: 1, y: 10),
                    ChartDataPoint(x: 2, y: 15),
                    ChartDataPoint(x: 3, y: 10),
                    ChartDataPoint(x: 4, y: 15),
                    ChartDataPoint(x: 5, y: 10),
                    ChartDataPoint(x: 6, y: 15),
                    ChartDataPoint(x: 7, y: 10),
                  ],
                  color: Colors.orange,
                ),
              ],
              xAxis: ChartAxis(
                title: '月份',
                min: 1,
                max: 7,
              ),
              yAxis: ChartAxis(
                title: '销售额（万元）',
                min: 0,
                max: 100,
              ),
              showLegend: true,
            ),
          ),
          const SizedBox(height: 24),
          const Text('百分比面积图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaAreaChart(
              type: AreaChartType.percentage,
              data: [
                AreaChartData(
                  name: '移动端',
                  data: [
                    ChartDataPoint(x: 1, y: 40),
                    ChartDataPoint(x: 2, y: 45),
                    ChartDataPoint(x: 3, y: 50),
                    ChartDataPoint(x: 4, y: 55),
                    ChartDataPoint(x: 5, y: 60),
                    ChartDataPoint(x: 6, y: 65),
                    ChartDataPoint(x: 7, y: 70),
                  ],
                  color: Colors.blue,
                ),
                AreaChartData(
                  name: '桌面端',
                  data: [
                    ChartDataPoint(x: 1, y: 35),
                    ChartDataPoint(x: 2, y: 30),
                    ChartDataPoint(x: 3, y: 25),
                    ChartDataPoint(x: 4, y: 20),
                    ChartDataPoint(x: 5, y: 15),
                    ChartDataPoint(x: 6, y: 10),
                    ChartDataPoint(x: 7, y: 5),
                  ],
                  color: Colors.green,
                ),
              ],
              xAxis: ChartAxis(
                title: '月份',
                min: 1,
                max: 7,
              ),
              yAxis: ChartAxis(
                title: '百分比',
                min: 0,
                max: 100,
              ),
              showLegend: true,
            ),
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '类型',
          defaultValue: 'basic',
          options: ['basic', 'stacked', 'percentage'],
          description: '面积图的类型',
        ),
        StorybookBooleanControl(
          label: '显示网格',
          defaultValue: true,
          description: '是否显示网格线',
        ),
        StorybookBooleanControl(
          label: '显示图例',
          defaultValue: true,
          description: '是否显示图例',
        ),
        StorybookBooleanControl(
          label: '平滑曲线',
          defaultValue: false,
          description: '是否使用平滑曲线',
        ),
        StorybookBooleanControl(
          label: '启用动画',
          defaultValue: true,
          description: '是否启用动画效果',
        ),
      ],
      codeExample: '''
// 基础面积图
chromaAreaChart(
  data: [
    AreaChartData(
      name: '访问量',
      data: [
        ChartDataPoint(x: 1, y: 30),
        ChartDataPoint(x: 2, y: 45),
        ChartDataPoint(x: 3, y: 35),
        ChartDataPoint(x: 4, y: 50),
        ChartDataPoint(x: 5, y: 40),
        ChartDataPoint(x: 6, y: 60),
        ChartDataPoint(x: 7, y: 55),
      ],
      color: Colors.blue,
      gradient: LinearGradient(
        colors: [Colors.blue.withOpacity(0.8), Colors.blue.withOpacity(0.1)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  ],
  xAxis: ChartAxis(
    title: '日期',
    min: 1,
    max: 7,
  ),
  yAxis: ChartAxis(
    title: '访问量',
    min: 0,
    max: 70,
  ),
)

// 堆叠面积图
chromaAreaChart(
  type: AreaChartType.stacked,
  data: [
    AreaChartData(
      name: '产品A',
      data: data1,
      color: Colors.blue,
    ),
    AreaChartData(
      name: '产品B',
      data: data2,
      color: Colors.green,
    ),
  ],
  showLegend: true,
)

// 百分比面积图
chromaAreaChart(
  type: AreaChartType.percentage,
  data: [
    AreaChartData(
      name: '移动端',
      data: mobileData,
      color: Colors.blue,
    ),
    AreaChartData(
      name: '桌面端',
      data: desktopData,
      color: Colors.green,
    ),
  ],
  showLegend: true,
)
''',
    );
  }

  /// 散点图组件故事
  static StorybookStory _scatterChartStory() {
    return StorybookStory(
      name: 'chromaScatterChart',
      category: '图表组件',
      description: '散点图组件，支持气泡图和交互功能',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础散点图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaScatterChart(
              data: [
                ScatterChartData(
                  name: '数据系列1',
                  data: [
                    ChartDataPoint(x: 10, y: 20),
                    ChartDataPoint(x: 15, y: 25),
                    ChartDataPoint(x: 20, y: 30),
                    ChartDataPoint(x: 25, y: 35),
                    ChartDataPoint(x: 30, y: 40),
                    ChartDataPoint(x: 35, y: 45),
                    ChartDataPoint(x: 40, y: 50),
                  ],
                  color: Colors.blue,
                ),
              ],
              xAxis: ChartAxis(
                title: 'X轴',
                min: 0,
                max: 50,
              ),
              yAxis: ChartAxis(
                title: 'Y轴',
                min: 0,
                max: 60,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('气泡图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaScatterChart(
              type: ScatterChartType.bubble,
              data: [
                ScatterChartData(
                  name: '公司A',
                  data: [
                    ChartDataPoint(x: 100, y: 200, size: 30),
                    ChartDataPoint(x: 150, y: 250, size: 45),
                    ChartDataPoint(x: 200, y: 300, size: 60),
                  ],
                  color: Colors.blue,
                ),
                ScatterChartData(
                  name: '公司B',
                  data: [
                    ChartDataPoint(x: 120, y: 180, size: 25),
                    ChartDataPoint(x: 180, y: 220, size: 35),
                    ChartDataPoint(x: 220, y: 280, size: 50),
                  ],
                  color: Colors.green,
                ),
              ],
              xAxis: ChartAxis(
                title: '收入（万元）',
                min: 0,
                max: 300,
              ),
              yAxis: ChartAxis(
                title: '利润（万元）',
                min: 0,
                max: 400,
              ),
              showLegend: true,
            ),
          ),
          const SizedBox(height: 24),
          const Text('带趋势线的散点图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaScatterChart(
              data: [
                ScatterChartData(
                  name: '数据点',
                  data: [
                    ChartDataPoint(x: 10, y: 15),
                    ChartDataPoint(x: 20, y: 25),
                    ChartDataPoint(x: 30, y: 35),
                    ChartDataPoint(x: 40, y: 45),
                    ChartDataPoint(x: 50, y: 55),
                    ChartDataPoint(x: 60, y: 65),
                    ChartDataPoint(x: 70, y: 75),
                  ],
                  color: Colors.blue,
                ),
              ],
              xAxis: ChartAxis(
                title: 'X轴',
                min: 0,
                max: 80,
              ),
              yAxis: ChartAxis(
                title: 'Y轴',
                min: 0,
                max: 80,
              ),
              showTrendLine: true,
              trendLineColor: Colors.red,
            ),
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '类型',
          defaultValue: 'basic',
          options: ['basic', 'bubble'],
          description: '散点图的类型',
        ),
        StorybookBooleanControl(
          label: '显示网格',
          defaultValue: true,
          description: '是否显示网格线',
        ),
        StorybookBooleanControl(
          label: '显示图例',
          defaultValue: true,
          description: '是否显示图例',
        ),
        StorybookBooleanControl(
          label: '显示趋势线',
          defaultValue: false,
          description: '是否显示趋势线',
        ),
        StorybookBooleanControl(
          label: '启用缩放',
          defaultValue: false,
          description: '是否启用缩放功能',
        ),
      ],
      codeExample: '''
// 基础散点图
chromaScatterChart(
  data: [
    ScatterChartData(
      name: '数据系列1',
      data: [
        ChartDataPoint(x: 10, y: 20),
        ChartDataPoint(x: 15, y: 25),
        ChartDataPoint(x: 20, y: 30),
        ChartDataPoint(x: 25, y: 35),
        ChartDataPoint(x: 30, y: 40),
        ChartDataPoint(x: 35, y: 45),
        ChartDataPoint(x: 40, y: 50),
      ],
      color: Colors.blue,
    ),
  ],
  xAxis: ChartAxis(
    title: 'X轴',
    min: 0,
    max: 50,
  ),
  yAxis: ChartAxis(
    title: 'Y轴',
    min: 0,
    max: 60,
  ),
)

// 气泡图
chromaScatterChart(
  type: ScatterChartType.bubble,
  data: [
    ScatterChartData(
      name: '公司A',
      data: [
        ChartDataPoint(x: 100, y: 200, size: 30),
        ChartDataPoint(x: 150, y: 250, size: 45),
        ChartDataPoint(x: 200, y: 300, size: 60),
      ],
      color: Colors.blue,
    ),
  ],
  showLegend: true,
)

// 带趋势线的散点图
chromaScatterChart(
  data: [
    ScatterChartData(
      name: '数据点',
      data: data,
      color: Colors.blue,
    ),
  ],
  showTrendLine: true,
  trendLineColor: Colors.red,
)
''',
    );
  }

  /// 雷达图组件故事
  static StorybookStory _radarChartStory() {
    return StorybookStory(
      name: 'chromaRadarChart',
      category: '图表组件',
      description: '雷达图组件，用于多维度数据对比',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础雷达图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaRadarChart(
              data: [
                RadarChartData(
                  name: '产品A',
                  values: [80, 90, 70, 85, 75, 90],
                  color: Colors.blue,
                ),
              ],
              categories: ['功能', '性能', '易用性', '稳定性', '安全性', '兼容性'],
              maxValue: 100,
              showGrid: true,
              showLabels: true,
            ),
          ),
          const SizedBox(height: 24),
          const Text('多系列雷达图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaRadarChart(
              data: [
                RadarChartData(
                  name: '产品A',
                  values: [80, 90, 70, 85, 75, 90],
                  color: Colors.blue,
                ),
                RadarChartData(
                  name: '产品B',
                  values: [70, 85, 90, 75, 85, 80],
                  color: Colors.green,
                ),
                RadarChartData(
                  name: '产品C',
                  values: [90, 75, 85, 90, 80, 75],
                  color: Colors.orange,
                ),
              ],
              categories: ['功能', '性能', '易用性', '稳定性', '安全性', '兼容性'],
              maxValue: 100,
              showGrid: true,
              showLabels: true,
              showLegend: true,
              fillAreas: true,
            ),
          ),
          const SizedBox(height: 24),
          const Text('填充雷达图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaRadarChart(
              data: [
                RadarChartData(
                  name: '当前能力',
                  values: [80, 90, 70, 85, 75, 90],
                  color: Colors.blue,
                  fill: true,
                ),
                RadarChartData(
                  name: '目标能力',
                  values: [90, 95, 85, 90, 85, 95],
                  color: Colors.green,
                  fill: true,
                  opacity: 0.3,
                ),
              ],
              categories: ['功能', '性能', '易用性', '稳定性', '安全性', '兼容性'],
              maxValue: 100,
              showGrid: true,
              showLabels: true,
              showLegend: true,
            ),
          ),
        ],
      ),
      controls: [
        StorybookBooleanControl(
          label: '显示网格',
          defaultValue: true,
          description: '是否显示网格线',
        ),
        StorybookBooleanControl(
          label: '显示标签',
          defaultValue: true,
          description: '是否显示标签',
        ),
        StorybookBooleanControl(
          label: '显示图例',
          defaultValue: true,
          description: '是否显示图例',
        ),
        StorybookBooleanControl(
          label: '填充区域',
          defaultValue: false,
          description: '是否填充区域',
        ),
        StorybookBooleanControl(
          label: '启用动画',
          defaultValue: true,
          description: '是否启用动画效果',
        ),
      ],
      codeExample: '''
// 基础雷达图
chromaRadarChart(
  data: [
    RadarChartData(
      name: '产品A',
      values: [80, 90, 70, 85, 75, 90],
      color: Colors.blue,
    ),
  ],
  categories: ['功能', '性能', '易用性', '稳定性', '安全性', '兼容性'],
  maxValue: 100,
  showGrid: true,
  showLabels: true,
)

// 多系列雷达图
chromaRadarChart(
  data: [
    RadarChartData(
      name: '产品A',
      values: [80, 90, 70, 85, 75, 90],
      color: Colors.blue,
    ),
    RadarChartData(
      name: '产品B',
      values: [70, 85, 90, 75, 85, 80],
      color: Colors.green,
    ),
  ],
  categories: ['功能', '性能', '易用性', '稳定性', '安全性', '兼容性'],
  maxValue: 100,
  showGrid: true,
  showLabels: true,
  showLegend: true,
  fillAreas: true,
)

// 填充雷达图
chromaRadarChart(
  data: [
    RadarChartData(
      name: '当前能力',
      values: [80, 90, 70, 85, 75, 90],
      color: Colors.blue,
      fill: true,
    ),
    RadarChartData(
      name: '目标能力',
      values: [90, 95, 85, 90, 85, 95],
      color: Colors.green,
      fill: true,
      opacity: 0.3,
    ),
  ],
  showGrid: true,
  showLabels: true,
  showLegend: true,
)
''',
    );
  }

  /// 热力图组件故事
  static StorybookStory _heatmapChartStory() {
    return StorybookStory(
      name: 'chromaHeatmapChart',
      category: '图表组件',
      description: '热力图组件，用于展示数据密度和分布',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础热力图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaHeatmapChart(
              data: [
                HeatmapDataPoint(x: 0, y: 0, value: 10),
                HeatmapDataPoint(x: 1, y: 0, value: 20),
                HeatmapDataPoint(x: 2, y: 0, value: 30),
                HeatmapDataPoint(x: 3, y: 0, value: 25),
                HeatmapDataPoint(x: 4, y: 0, value: 15),
                HeatmapDataPoint(x: 0, y: 1, value: 25),
                HeatmapDataPoint(x: 1, y: 1, value: 35),
                HeatmapDataPoint(x: 2, y: 1, value: 45),
                HeatmapDataPoint(x: 3, y: 1, value: 40),
                HeatmapDataPoint(x: 4, y: 1, value: 30),
                HeatmapDataPoint(x: 0, y: 2, value: 40),
                HeatmapDataPoint(x: 1, y: 2, value: 50),
                HeatmapDataPoint(x: 2, y: 2, value: 60),
                HeatmapDataPoint(x: 3, y: 2, value: 55),
                HeatmapDataPoint(x: 4, y: 2, value: 45),
              ],
              xAxis: ChartAxis(
                title: '星期',
                categories: ['周一', '周二', '周三', '周四', '周五'],
              ),
              yAxis: ChartAxis(
                title: '时间',
                categories: ['上午', '中午', '下午'],
              ),
              colorScale: HeatmapColorScale(
                minColor: Colors.blue,
                maxColor: Colors.red,
                minValue: 0,
                maxValue: 100,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('带图例的热力图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaHeatmapChart(
              data: [
                HeatmapDataPoint(x: 0, y: 0, value: 10),
                HeatmapDataPoint(x: 1, y: 0, value: 20),
                HeatmapDataPoint(x: 2, y: 0, value: 30),
                HeatmapDataPoint(x: 3, y: 0, value: 25),
                HeatmapDataPoint(x: 4, y: 0, value: 15),
                HeatmapDataPoint(x: 0, y: 1, value: 25),
                HeatmapDataPoint(x: 1, y: 1, value: 35),
                HeatmapDataPoint(x: 2, y: 1, value: 45),
                HeatmapDataPoint(x: 3, y: 1, value: 40),
                HeatmapDataPoint(x: 4, y: 1, value: 30),
                HeatmapDataPoint(x: 0, y: 2, value: 40),
                HeatmapDataPoint(x: 1, y: 2, value: 50),
                HeatmapDataPoint(x: 2, y: 2, value: 60),
                HeatmapDataPoint(x: 3, y: 2, value: 55),
                HeatmapDataPoint(x: 4, y: 2, value: 45),
              ],
              xAxis: ChartAxis(
                title: '星期',
                categories: ['周一', '周二', '周三', '周四', '周五'],
              ),
              yAxis: ChartAxis(
                title: '时间',
                categories: ['上午', '中午', '下午'],
              ),
              colorScale: HeatmapColorScale(
                minColor: Colors.blue,
                maxColor: Colors.red,
                minValue: 0,
                maxValue: 100,
              ),
              showLegend: true,
              showLabels: true,
            ),
          ),
        ],
      ),
      controls: [
        StorybookBooleanControl(
          label: '显示图例',
          defaultValue: true,
          description: '是否显示图例',
        ),
        StorybookBooleanControl(
          label: '显示标签',
          defaultValue: true,
          description: '是否显示标签',
        ),
        StorybookBooleanControl(
          label: '显示数值',
          defaultValue: false,
          description: '是否显示数值',
        ),
        StorybookBooleanControl(
          label: '圆角矩形',
          defaultValue: false,
          description: '是否使用圆角矩形',
        ),
      ],
      codeExample: '''
// 基础热力图
chromaHeatmapChart(
  data: [
    HeatmapDataPoint(x: 0, y: 0, value: 10),
    HeatmapDataPoint(x: 1, y: 0, value: 20),
    HeatmapDataPoint(x: 2, y: 0, value: 30),
    HeatmapDataPoint(x: 3, y: 0, value: 25),
    HeatmapDataPoint(x: 4, y: 0, value: 15),
    HeatmapDataPoint(x: 0, y: 1, value: 25),
    HeatmapDataPoint(x: 1, y: 1, value: 35),
    HeatmapDataPoint(x: 2, y: 1, value: 45),
    HeatmapDataPoint(x: 3, y: 1, value: 40),
    HeatmapDataPoint(x: 4, y: 1, value: 30),
  ],
  xAxis: ChartAxis(
    title: '星期',
    categories: ['周一', '周二', '周三', '周四', '周五'],
  ),
  yAxis: ChartAxis(
    title: '时间',
    categories: ['上午', '中午', '下午'],
  ),
  colorScale: HeatmapColorScale(
    minColor: Colors.blue,
    maxColor: Colors.red,
    minValue: 0,
    maxValue: 100,
  ),
)

// 带图例的热力图
chromaHeatmapChart(
  data: data,
  xAxis: ChartAxis(
    title: '星期',
    categories: ['周一', '周二', '周三', '周四', '周五'],
  ),
  yAxis: ChartAxis(
    title: '时间',
    categories: ['上午', '中午', '下午'],
  ),
  colorScale: HeatmapColorScale(
    minColor: Colors.blue,
    maxColor: Colors.red,
    minValue: 0,
    maxValue: 100,
  ),
  showLegend: true,
  showLabels: true,
)
''',
    );
  }

  /// 仪表图组件故事
  static StorybookStory _gaugeChartStory() {
    return StorybookStory(
      name: 'chromaGaugeChart',
      category: '图表组件',
      description: '仪表图组件，用于显示指标和进度',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础仪表图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: chromaGaugeChart(
              value: 65,
              minValue: 0,
              maxValue: 100,
              title: '完成率',
              unit: '%',
            ),
          ),
          const SizedBox(height: 24),
          const Text('多色段仪表图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: chromaGaugeChart(
              value: 75,
              minValue: 0,
              maxValue: 100,
              title: '性能评分',
              unit: '分',
              segments: [
                GaugeSegment(
                  minValue: 0,
                  maxValue: 60,
                  color: Colors.red,
                ),
                GaugeSegment(
                  minValue: 60,
                  maxValue: 80,
                  color: Colors.orange,
                ),
                GaugeSegment(
                  minValue: 80,
                  maxValue: 100,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('半圆仪表图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: chromaGaugeChart(
              value: 45,
              minValue: 0,
              maxValue: 100,
              title: 'CPU使用率',
              unit: '%',
              type: GaugeType.halfCircle,
            ),
          ),
          const SizedBox(height: 24),
          const Text('垂直仪表图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: chromaGaugeChart(
              value: 80,
              minValue: 0,
              maxValue: 100,
              title: '内存使用率',
              unit: '%',
              type: GaugeType.vertical,
            ),
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '类型',
          defaultValue: 'fullCircle',
          options: ['fullCircle', 'halfCircle', 'vertical'],
          description: '仪表图的类型',
        ),
        StorybookNumberControl(
          label: '当前值',
          defaultValue: 65,
          description: '仪表图的当前值',
        ),
        StorybookNumberControl(
          label: '最小值',
          defaultValue: 0,
          description: '仪表图的最小值',
        ),
        StorybookNumberControl(
          label: '最大值',
          defaultValue: 100,
          description: '仪表图的最大值',
        ),
        StorybookBooleanControl(
          label: '显示数值',
          defaultValue: true,
          description: '是否显示数值',
        ),
      ],
      codeExample: '''
// 基础仪表图
chromaGaugeChart(
  value: 65,
  minValue: 0,
  maxValue: 100,
  title: '完成率',
  unit: '%',
)

// 多色段仪表图
chromaGaugeChart(
  value: 75,
  minValue: 0,
  maxValue: 100,
  title: '性能评分',
  unit: '分',
  segments: [
    GaugeSegment(
      minValue: 0,
      maxValue: 60,
      color: Colors.red,
    ),
    GaugeSegment(
      minValue: 60,
      maxValue: 80,
      color: Colors.orange,
    ),
    GaugeSegment(
      minValue: 80,
      maxValue: 100,
      color: Colors.green,
    ),
  ],
)

// 半圆仪表图
chromaGaugeChart(
  value: 45,
  minValue: 0,
  maxValue: 100,
  title: 'CPU使用率',
  unit: '%',
  type: GaugeType.halfCircle,
)

// 垂直仪表图
chromaGaugeChart(
  value: 80,
  minValue: 0,
  maxValue: 100,
  title: '内存使用率',
  unit: '%',
  type: GaugeType.vertical,
)
''',
    );
  }

  /// 漏斗图组件故事
  static StorybookStory _funnelChartStory() {
    return StorybookStory(
      name: 'chromaFunnelChart',
      category: '图表组件',
      description: '漏斗图组件，用于展示流程转化率',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础漏斗图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaFunnelChart(
              data: [
                FunnelChartData(
                  name: '访问',
                  value: 1000,
                  color: Colors.blue,
                ),
                FunnelChartData(
                  name: '注册',
                  value: 500,
                  color: Colors.green,
                ),
                FunnelChartData(
                  name: '购买',
                  value: 200,
                  color: Colors.orange,
                ),
                FunnelChartData(
                  name: '复购',
                  value: 50,
                  color: Colors.red,
                ),
              ],
              showLabels: true,
              showValues: true,
              showPercentages: true,
            ),
          ),
          const SizedBox(height: 24),
          const Text('对比漏斗图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaFunnelChart(
              type: FunnelChartType.comparison,
              data: [
                FunnelChartData(
                  name: '访问',
                  value: 1000,
                  color: Colors.blue,
                  previousValue: 800,
                ),
                FunnelChartData(
                  name: '注册',
                  value: 500,
                  color: Colors.green,
                  previousValue: 400,
                ),
                FunnelChartData(
                  name: '购买',
                  value: 200,
                  color: Colors.orange,
                  previousValue: 150,
                ),
                FunnelChartData(
                  name: '复购',
                  value: 50,
                  color: Colors.red,
                  previousValue: 30,
                ),
              ],
              showLabels: true,
              showValues: true,
              showPercentages: true,
            ),
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '类型',
          defaultValue: 'basic',
          options: ['basic', 'comparison'],
          description: '漏斗图的类型',
        ),
        StorybookBooleanControl(
          label: '显示标签',
          defaultValue: true,
          description: '是否显示标签',
        ),
        StorybookBooleanControl(
          label: '显示数值',
          defaultValue: true,
          description: '是否显示数值',
        ),
        StorybookBooleanControl(
          label: '显示百分比',
          defaultValue: true,
          description: '是否显示百分比',
        ),
        StorybookBooleanControl(
          label: '启用动画',
          defaultValue: true,
          description: '是否启用动画效果',
        ),
      ],
      codeExample: '''
// 基础漏斗图
chromaFunnelChart(
  data: [
    FunnelChartData(
      name: '访问',
      value: 1000,
      color: Colors.blue,
    ),
    FunnelChartData(
      name: '注册',
      value: 500,
      color: Colors.green,
    ),
    FunnelChartData(
      name: '购买',
      value: 200,
      color: Colors.orange,
    ),
    FunnelChartData(
      name: '复购',
      value: 50,
      color: Colors.red,
    ),
  ],
  showLabels: true,
  showValues: true,
  showPercentages: true,
)

// 对比漏斗图
chromaFunnelChart(
  type: FunnelChartType.comparison,
  data: [
    FunnelChartData(
      name: '访问',
      value: 1000,
      color: Colors.blue,
      previousValue: 800,
    ),
    FunnelChartData(
      name: '注册',
      value: 500,
      color: Colors.green,
      previousValue: 400,
    ),
    FunnelChartData(
      name: '购买',
      value: 200,
      color: Colors.orange,
      previousValue: 150,
    ),
  ],
  showLabels: true,
  showValues: true,
  showPercentages: true,
)
''',
    );
  }

  /// 组合图表组件故事
  static StorybookStory _combinationChartStory() {
    return StorybookStory(
      name: 'chromaCombinationChart',
      category: '图表组件',
      description: '组合图表组件，支持多种图表类型组合',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('柱状图+折线图组合', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaCombinationChart(
              primaryData: [
                BarChartData(
                  name: '销售额',
                  value: 45,
                  color: Colors.blue,
                ),
                BarChartData(
                  name: '销售额',
                  value: 65,
                  color: Colors.blue,
                ),
                BarChartData(
                  name: '销售额',
                  value: 55,
                  color: Colors.blue,
                ),
                BarChartData(
                  name: '销售额',
                  value: 75,
                  color: Colors.blue,
                ),
              ],
              secondaryData: [
                LineChartData(
                  name: '利润率',
                  data: [
                    ChartDataPoint(x: 0, y: 15),
                    ChartDataPoint(x: 1, y: 20),
                    ChartDataPoint(x: 2, y: 18),
                    ChartDataPoint(x: 3, y: 25),
                  ],
                  color: Colors.red,
                ),
              ],
              xAxis: ChartAxis(
                title: '季度',
                categories: ['Q1', 'Q2', 'Q3', 'Q4'],
              ),
              yAxis: ChartAxis(
                title: '销售额（万元）',
                min: 0,
                max: 100,
              ),
              secondaryYAxis: ChartAxis(
                title: '利润率（%）',
                min: 0,
                max: 30,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('面积图+散点图组合', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaCombinationChart(
              primaryData: [
                AreaChartData(
                  name: '趋势',
                  data: [
                    ChartDataPoint(x: 0, y: 30),
                    ChartDataPoint(x: 1, y: 45),
                    ChartDataPoint(x: 2, y: 35),
                    ChartDataPoint(x: 3, y: 50),
                    ChartDataPoint(x: 4, y: 40),
                  ],
                  color: Colors.blue.withOpacity(0.3),
                ),
              ],
              secondaryData: [
                ScatterChartData(
                  name: '异常点',
                  data: [
                    ChartDataPoint(x: 1, y: 60),
                    ChartDataPoint(x: 3, y: 20),
                  ],
                  color: Colors.red,
                ),
              ],
              xAxis: ChartAxis(
                title: '时间',
                min: 0,
                max: 4,
              ),
              yAxis: ChartAxis(
                title: '数值',
                min: 0,
                max: 70,
              ),
            ),
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '主图表类型',
          defaultValue: 'bar',
          options: ['bar', 'line', 'area'],
          description: '主图表的类型',
        ),
        StorybookSelectControl(
          label: '副图表类型',
          defaultValue: 'line',
          options: ['line', 'scatter', 'area'],
          description: '副图表的类型',
        ),
        StorybookBooleanControl(
          label: '显示图例',
          defaultValue: true,
          description: '是否显示图例',
        ),
        StorybookBooleanControl(
          label: '显示网格',
          defaultValue: true,
          description: '是否显示网格线',
        ),
        StorybookBooleanControl(
          label: '启用动画',
          defaultValue: true,
          description: '是否启用动画效果',
        ),
      ],
      codeExample: '''
// 柱状图+折线图组合
chromaCombinationChart(
  primaryData: [
    BarChartData(
      name: '销售额',
      value: 45,
      color: Colors.blue,
    ),
    BarChartData(
      name: '销售额',
      value: 65,
      color: Colors.blue,
    ),
    BarChartData(
      name: '销售额',
      value: 55,
      color: Colors.blue,
    ),
    BarChartData(
      name: '销售额',
      value: 75,
      color: Colors.blue,
    ),
  ],
  secondaryData: [
    LineChartData(
      name: '利润率',
      data: [
        ChartDataPoint(x: 0, y: 15),
        ChartDataPoint(x: 1, y: 20),
        ChartDataPoint(x: 2, y: 18),
        ChartDataPoint(x: 3, y: 25),
      ],
      color: Colors.red,
    ),
  ],
  xAxis: ChartAxis(
    title: '季度',
    categories: ['Q1', 'Q2', 'Q3', 'Q4'],
  ),
  yAxis: ChartAxis(
    title: '销售额（万元）',
    min: 0,
    max: 100,
  ),
  secondaryYAxis: ChartAxis(
    title: '利润率（%）',
    min: 0,
    max: 30,
  ),
)

// 面积图+散点图组合
chromaCombinationChart(
  primaryData: [
    AreaChartData(
      name: '趋势',
      data: [
        ChartDataPoint(x: 0, y: 30),
        ChartDataPoint(x: 1, y: 45),
        ChartDataPoint(x: 2, y: 35),
        ChartDataPoint(x: 3, y: 50),
        ChartDataPoint(x: 4, y: 40),
      ],
      color: Colors.blue.withOpacity(0.3),
    ),
  ],
  secondaryData: [
    ScatterChartData(
      name: '异常点',
      data: [
        ChartDataPoint(x: 1, y: 60),
        ChartDataPoint(x: 3, y: 20),
      ],
      color: Colors.red,
    ),
  ],
  xAxis: ChartAxis(
    title: '时间',
    min: 0,
    max: 4,
  ),
  yAxis: ChartAxis(
    title: '数值',
    min: 0,
    max: 70,
  ),
)
''',
    );
  }
}
