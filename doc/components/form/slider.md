# ZephyrSlider 滑块组件

滑块组件是一个直观的数值选择控件，支持单选和范围选择模式。提供了流畅的拖拽体验和实时的数值反馈，支持自定义样式和步长设置。

## 🎯 组件概述

### 特性
- **多种模式**: 支持单值和范围选择模式
- **实时反馈**: 拖拽时实时显示数值变化
- **灵活配置**: 支持自定义最小值、最大值、步长等
- **丰富样式**: 支持自定义颜色、大小、标签等样式
- **状态管理**: 完整的启用、禁用状态支持
- **主题适配**: 完整的主题系统支持

### 适用场景
- 数值选择器
- 范围选择器
- 音量控制
- 亮度调节
- 价格筛选
- 进度设置

## 🚀 基础用法

### 基本滑块

```dart
ZephyrSlider(
  value: _volume,
  min: 0,
  max: 100,
  onChanged: (value) => setState(() => _volume = value),
)
```

### 带标签的滑块

```dart
ZephyrSlider(
  value: _brightness,
  min: 0,
  max: 100,
  label: '亮度',
  onChanged: (value) => setState(() => _brightness = value),
)
```

### 带步长的滑块

```dart
ZephyrSlider(
  value: _temperature,
  min: 16,
  max: 30,
  step: 1,
  label: '温度',
  onChanged: (value) => setState(() => _temperature = value),
)
```

### 范围滑块

```dart
ZephyrRangeSlider(
  values: RangeValues(_minPrice, _maxPrice),
  min: 0,
  max: 10000,
  step: 100,
  label: '价格范围',
  onChanged: (values) => setState(() {
    _minPrice = values.start;
    _maxPrice = values.end;
  }),
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    ZephyrSlider(
      value: _value1,
      min: 0,
      max: 100,
      activeColor: Colors.blue,
      onChanged: (value) => setState(() => _value1 = value),
    ),
    SizedBox(height: 32),
    ZephyrSlider(
      value: _value2,
      min: 0,
      max: 100,
      thumbColor: Colors.red,
      onChanged: (value) => setState(() => _value2 = value),
    ),
    SizedBox(height: 32),
    ZephyrSlider(
      value: _value3,
      min: 0,
      max: 100,
      showValue: true,
      onChanged: (value) => setState(() => _value3 = value),
    ),
  ],
)
```

### 垂直滑块

```dart
Row(
  children: [
    ZephyrSlider.vertical(
      value: _verticalValue,
      min: 0,
      max: 100,
      height: 200,
      onChanged: (value) => setState(() => _verticalValue = value),
    ),
    SizedBox(width: 32),
    Text('垂直滑块'),
  ],
)
```

### 带刻度的滑块

```dart
ZephyrSlider(
  value: _age,
  min: 18,
  max: 65,
  step: 1,
  divisions: 47, // 65 - 18 = 47
  label: '年龄',
  showValue: true,
  onChanged: (value) => setState(() => _age = value),
)
```

## 🔧 高级用法

### 音量控制滑块

```dart
class VolumeSlider extends StatefulWidget {
  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _volume = 50;
  bool _isMuted = false;

  IconData get _volumeIcon {
    if (_isMuted || _volume == 0) {
      return Icons.volume_off;
    } else if (_volume < 30) {
      return Icons.volume_mute;
    } else if (_volume < 70) {
      return Icons.volume_down;
    } else {
      return Icons.volume_up;
    }
  }

  String get _volumeText {
    if (_isMuted) {
      return '静音';
    }
    return '${_volume.round()}%';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(_volumeIcon),
            SizedBox(width: 8),
            Text(
              '音量',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Text(
              _volumeText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        ZephyrSlider(
          value: _isMuted ? 0 : _volume,
          min: 0,
          max: 100,
          activeColor: Colors.blue,
          showValue: false,
          onChanged: (value) {
            setState(() {
              _volume = value;
              _isMuted = false;
            });
          },
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.volume_mute),
              onPressed: () {
                setState(() => _isMuted = !_isMuted);
              },
              tooltip: '静音',
            ),
            IconButton(
              icon: Icon(Icons.volume_down),
              onPressed: () {
                setState(() {
                  _volume = (_volume - 10).clamp(0, 100);
                  _isMuted = false;
                });
              },
              tooltip: '降低音量',
            ),
            IconButton(
              icon: Icon(Icons.volume_up),
              onPressed: () {
                setState(() {
                  _volume = (_volume + 10).clamp(0, 100);
                  _isMuted = false;
                });
              },
              tooltip: '增加音量',
            ),
          ],
        ),
      ],
    );
  }
}
```

### 价格范围选择器

```dart
class PriceRangeSlider extends StatefulWidget {
  final ValueChanged<RangeValues> onChanged;

  const PriceRangeSlider({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues _priceRange = RangeValues(0, 5000);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '价格范围',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '¥${_priceRange.start.round()} - ¥${_priceRange.end.round()}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        ZephyrRangeSlider(
          values: _priceRange,
          min: 0,
          max: 10000,
          step: 100,
          activeColor: Colors.green,
          onChanged: (values) {
            setState(() {
              _priceRange = values;
            });
            widget.onChanged(values);
          },
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('¥0'),
            Text('¥10,000'),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _priceRange = RangeValues(0, 10000);
                    widget.onChanged(_priceRange);
                  });
                },
                child: Text('重置'),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // 应用价格范围筛选
                },
                child: Text('应用'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
```

### 多滑块控制面板

```dart
class MultiSliderPanel extends StatefulWidget {
  @override
  _MultiSliderPanelState createState() => _MultiSliderPanelState();
}

class _MultiSliderPanelState extends State<MultiSliderPanel> {
  double _brightness = 50;
  double _contrast = 50;
  double _saturation = 50;
  double _temperature = 50;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '图像调整',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            _buildSliderControl(
              label: '亮度',
              value: _brightness,
              min: -100,
              max: 100,
              color: Colors.yellow,
              onChanged: (value) => setState(() => _brightness = value),
            ),
            SizedBox(height: 24),
            _buildSliderControl(
              label: '对比度',
              value: _contrast,
              min: -100,
              max: 100,
              color: Colors.grey,
              onChanged: (value) => setState(() => _contrast = value),
            ),
            SizedBox(height: 24),
            _buildSliderControl(
              label: '饱和度',
              value: _saturation,
              min: -100,
              max: 100,
              color: Colors.purple,
              onChanged: (value) => setState(() => _saturation = value),
            ),
            SizedBox(height: 24),
            _buildSliderControl(
              label: '色温',
              value: _temperature,
              min: -100,
              max: 100,
              color: Colors.orange,
              onChanged: (value) => setState(() => _temperature = value),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetValues,
                    child: Text('重置'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applySettings,
                    child: Text('应用'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderControl({
    required String label,
    required double value,
    required double min,
    required double max,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${value.round()}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        ZephyrSlider(
          value: value,
          min: min,
          max: max,
          step: 1,
          activeColor: color,
          showValue: false,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _resetValues() {
    setState(() {
      _brightness = 0;
      _contrast = 0;
      _saturation = 0;
      _temperature = 0;
    });
  }

  void _applySettings() {
    // 应用图像调整设置
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('设置已应用')),
    );
  }
}
```

### 离散值滑块

```dart
class DiscreteSlider extends StatefulWidget {
  final List<String> options;
  final int initialIndex;
  final ValueChanged<int> onChanged;

  const DiscreteSlider({
    Key? key,
    required this.options,
    required this.initialIndex,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DiscreteSliderState createState() => _DiscreteSliderState();
}

class _DiscreteSliderState extends State<DiscreteSlider> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.options[_currentIndex],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8),
        ZephyrSlider(
          value: _currentIndex.toDouble(),
          min: 0,
          max: widget.options.length - 1.0,
          step: 1,
          divisions: widget.options.length - 1,
          activeColor: Colors.blue,
          showValue: false,
          onChanged: (value) {
            setState(() {
              _currentIndex = value.round();
            });
            widget.onChanged(_currentIndex);
          },
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.options.map((option) {
            return Text(
              option,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrSlider()

```dart
const ZephyrSlider({
  Key? key,
  required double value,
  required double min,
  required double max,
  double? step,
  int? divisions,
  String? label,
  bool showValue = true,
  ValueChanged<double>? onChanged,
  ValueChanged<double>? onChangeStart,
  ValueChanged<double>? onChangeEnd,
  bool enabled = true,
  Color? activeColor,
  Color? inactiveColor,
  Color? thumbColor,
  double? thumbSize,
  double? height,
  bool vertical = false,
  double? width,
  double? heightConstraint,
  TextStyle? labelStyle,
  TextStyle? valueStyle,
  String? semanticLabel,
})
```

**参数说明：**
- `value`: 当前值
- `min`: 最小值
- `max`: 最大值
- `step`: 步长
- `divisions`: 分割数
- `label`: 标签
- `showValue`: 是否显示数值
- `onChanged`: 变化回调
- `onChangeStart`: 开始拖拽回调
- `onChangeEnd`: 结束拖拽回调
- `enabled`: 是否启用
- `activeColor`: 激活时的颜色
- `inactiveColor`: 非激活时的颜色
- `thumbColor`: 滑块颜色
- `thumbSize`: 滑块大小
- `height`: 滑块高度
- `vertical`: 是否垂直
- `width`: 宽度（垂直模式）
- `heightConstraint`: 高度约束（垂直模式）
- `labelStyle`: 标签样式
- `valueStyle`: 数值样式
- `semanticLabel`: 语义标签

#### ZephyrRangeSlider()

```dart
const ZephyrRangeSlider({
  Key? key,
  required RangeValues values,
  required double min,
  required double max,
  double? step,
  int? divisions,
  String? label,
  bool showValues = true,
  ValueChanged<RangeValues>? onChanged,
  ValueChanged<RangeValues>? onChangeStart,
  ValueChanged<RangeValues>? onChangeEnd,
  bool enabled = true,
  Color? activeColor,
  Color? inactiveColor,
  Color? thumbColor,
  double? thumbSize,
  double? height,
  TextStyle? labelStyle,
  TextStyle? valueStyle,
  String? semanticLabel,
})
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrSliderTheme(
        activeColor: Colors.blue,
        inactiveColor: Colors.grey[300],
        thumbColor: Colors.blue,
        disabledColor: Colors.grey[200],
        disabledActiveColor: Colors.grey[400],
        thumbSize: 20,
        height: 4,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        valueStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `activeColor`: 激活时的颜色
- `inactiveColor`: 非激活时的颜色
- `thumbColor`: 滑块颜色
- `disabledColor`: 禁用时的颜色
- `disabledActiveColor`: 禁用且激活时的颜色
- `thumbSize`: 滑块大小
- `height`: 滑块高度
- `labelStyle`: 标签样式
- `valueStyle`: 数值样式

## 🏆 最佳实践

### 1. 合理的数值范围

```dart
// ✅ 好的做法：根据使用场景设置合理的范围
ZephyrSlider(
  value: _volume,
  min: 0,
  max: 100,
  label: '音量',
  onChanged: (value) => setState(() => _volume = value),
)

ZephyrSlider(
  value: _brightness,
  min: 0,
  max: 255,
  label: '亮度',
  onChanged: (value) => setState(() => _brightness = value),
)

// ❌ 避免的做法：范围设置不合理
ZephyrSlider(
  value: _age,
  min: 0,
  max: 1000,  // 对于年龄来说过大
  label: '年龄',
  onChanged: (value) => setState(() => _age = value),
)
```

### 2. 合适的步长设置

```dart
// ✅ 好的做法：根据精度需求设置步长
ZephyrSlider(
  value: _temperature,
  min: 16,
  max: 30,
  step: 0.5,  // 温度可以精确到0.5度
  label: '温度',
  onChanged: (value) => setState(() => _temperature = value),
)

ZephyrSlider(
  value: _age,
  min: 18,
  max: 65,
  step: 1,  // 年龄通常是整数
  label: '年龄',
  onChanged: (value) => setState(() => _age = value),
)

// ❌ 避免的做法：步长设置不当
ZephyrSlider(
  value: _price,
  min: 0,
  max: 1000,
  step: 0.01,  // 对于价格来说精度过高
  label: '价格',
  onChanged: (value) => setState(() => _price = value),
)
```

### 3. 实时反馈

```dart
// ✅ 好的做法：提供实时数值反馈
ZephyrSlider(
  value: _brightness,
  min: 0,
  max: 100,
  showValue: true,
  label: '亮度',
  onChanged: (value) {
    setState(() {
      _brightness = value;
      _updateScreenBrightness(value);  // 实时更新屏幕亮度
    });
  },
)

// ✅ 好的做法：使用onChangeEnd进行最终确认
ZephyrSlider(
  value: _volume,
  min: 0,
  max: 100,
  label: '音量',
  onChangeEnd: (value) {
    _saveVolumeSetting(value);  // 拖拽结束时保存设置
  },
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrSlider(
  value: _brightness,
  min: 0,
  max: 100,
  label: '亮度',
  semanticLabel: '屏幕亮度调节滑块',
  onChanged: (value) => setState(() => _brightness = value),
)

// ✅ 好的做法：提供键盘操作支持
Focus(
  child: ZephyrSlider(
    value: _volume,
    min: 0,
    max: 100,
    label: '音量',
    onChanged: (value) => setState(() => _volume = value),
  ),
)
```

## 🔄 相关组件

- **ZephyrInputField**: 数值输入框
- **ZephyrSelect**: 选择器组件
- **ZephyrProgress**: 进度条
- **ZephyrFormBuilder**: 表单构建器

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持单值和范围滑块
- ✅ 实时数值反馈
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/form/slider/`
**示例路径**: `example/lib/components/slider_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月19日