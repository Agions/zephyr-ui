# ZephyrDataVisualization

数据可视化组件，支持多种图表类型和交互。

## 基本用法

```dart
ZephyrDataVisualization(
  type: ZephyrChartType.bar,
  data: [
    DataPoint(x: '一月', y: 100),
    DataPoint(x: '二月', y: 200),
    DataPoint(x: '三月', y: 150),
  ],
  options: ChartOptions(
    title: '月度销售数据',
    showLegend: true,
    showGrid: true,
  ),
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| type | ZephyrChartType | line | 图表类型 |
| data | List<DataPoint> | required | 数据点 |
| options | ChartOptions? | null | 图表选项 |
| width | double? | null | 图表宽度 |
| height | double | 300 | 图表高度 |
| onPointTap | Function(DataPoint)? | null | 点击数据点回调 |
| animation | bool | true | 是否启用动画 |
| animationDuration | Duration | Duration(milliseconds: 500) | 动画时长 |