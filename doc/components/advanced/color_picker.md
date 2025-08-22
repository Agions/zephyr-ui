# ZephyrColorPicker 颜色选择器组件

颜色选择器组件是ZephyrUI高级组件中的重要组件，提供了强大的颜色选择功能。支持多种颜色选择模式、自定义样式和交互方式，是构建主题定制、颜色选择、设计工具等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种选择模式**: 支持调色板、滑块、输入框等多种选择模式
- **灵活布局**: 支持弹出式、内嵌式、对话框等多种布局方式
- **丰富交互**: 支持点击、拖拽、键盘输入等交互操作
- **格式支持**: 支持HEX、RGB、HSL等多种颜色格式
- **预设颜色**: 支持自定义预设颜色和主题颜色
- **主题适配**: 完整的主题系统支持

### 适用场景
- 主题颜色定制
- 设计工具
- 图片编辑器
- 绘图应用
- 配色方案选择
- 品牌颜色管理

## 🚀 基础用法

### 基本颜色选择器

```dart
class BasicColorPickerExample extends StatefulWidget {
  @override
  _BasicColorPickerExampleState createState() => _BasicColorPickerExampleState();
}

class _BasicColorPickerExampleState extends State<BasicColorPickerExample> {
  Color _selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本颜色选择器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 颜色预览
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '当前颜色',
                  style: TextStyle(
                    color: _selectedColor.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            // 颜色选择器
            ZephyrColorPicker(
              initialColor: _selectedColor,
              onColorChanged: (color) {
                setState(() => _selectedColor = color);
              },
            ),
            SizedBox(height: 16),
            // 颜色值显示
            Text(
              'HEX: #${_selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 弹出式颜色选择器

```dart
class PopupColorPickerExample extends StatefulWidget {
  @override
  _PopupColorPickerExampleState createState() => _PopupColorPickerExampleState();
}

class _PopupColorPickerExampleState extends State<PopupColorPickerExample> {
  Color _selectedColor = Colors.green;

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('选择颜色'),
          content: Container(
            width: 400,
            height: 300,
            child: ZephyrColorPicker(
              initialColor: _selectedColor,
              onColorChanged: (color) {
                setState(() => _selectedColor = color);
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('取消'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('弹出式颜色选择器'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 颜色预览
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
            ),
            SizedBox(height: 24),
            // 选择按钮
            ElevatedButton(
              onPressed: _showColorPicker,
              child: Text('选择颜色'),
            ),
            SizedBox(height: 16),
            // 颜色信息
            Text(
              'RGB: ${_selectedColor.red}, ${_selectedColor.green}, ${_selectedColor.blue}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 内嵌式颜色选择器

```dart
class InlineColorPickerExample extends StatefulWidget {
  @override
  _InlineColorPickerExampleState createState() => _InlineColorPickerExampleState();
}

class _InlineColorPickerExampleState extends State<InlineColorPickerExample> {
  Color _selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('内嵌式颜色选择器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '主题颜色设置',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // 颜色选择器
            ZephyrColorPicker(
              initialColor: _selectedColor,
              pickerType: ZephyrColorPickerType.compact,
              onColorChanged: (color) {
                setState(() => _selectedColor = color);
              },
            ),
            SizedBox(height: 24),
            // 应用预览
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _selectedColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _selectedColor),
              ),
              child: Text(
                '这是应用主题颜色的预览效果',
                style: TextStyle(color: _selectedColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义颜色选择器

```dart
class CustomColorPickerExample extends StatefulWidget {
  @override
  _CustomColorPickerExampleState createState() => _CustomColorPickerExampleState();
}

class _CustomColorPickerExampleState extends State<CustomColorPickerExample> {
  Color _selectedColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义颜色选择器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrColorPicker(
          initialColor: _selectedColor,
          pickerType: ZephyrColorPickerType.wheel,
          onColorChanged: (color) {
            setState(() => _selectedColor = color);
          },
          presetColors: [
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
          ],
          showAlphaSlider: true,
          showColorInput: true,
          colorFormat: ZephyrColorFormat.hex,
          customBuilder: (context, color, onColorChanged) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // 自定义颜色预览
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 16),
                  // 预设颜色
                  Wrap(
                    spacing: 8,
                    children: [
                      Colors.red,
                      Colors.orange,
                      Colors.yellow,
                      Colors.green,
                      Colors.blue,
                      Colors.indigo,
                      Colors.purple,
                    ].map((presetColor) {
                      return GestureDetector(
                        onTap: () => onColorChanged(presetColor),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: presetColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: presetColor == color ? Colors.black : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
```

### 多格式颜色选择器

```dart
class MultiFormatColorPickerExample extends StatefulWidget {
  @override
  _MultiFormatColorPickerExampleState createState() => _MultiFormatColorPickerExampleState();
}

class _MultiFormatColorPickerExampleState extends State<MultiFormatColorPickerExample> {
  Color _selectedColor = Colors.teal;
  ZephyrColorFormat _format = ZephyrColorFormat.hex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多格式颜色选择器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 格式选择
            Row(
              children: [
                Text('颜色格式：'),
                SizedBox(width: 16),
                DropdownButton<ZephyrColorFormat>(
                  value: _format,
                  items: ZephyrColorFormat.values.map((format) {
                    return DropdownMenuItem(
                      value: format,
                      child: Text(format.toString().split('.').last.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (format) {
                    setState(() => _format = format!);
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            // 颜色选择器
            ZephyrColorPicker(
              initialColor: _selectedColor,
              colorFormat: _format,
              onColorChanged: (color) {
                setState(() => _selectedColor = color);
              },
              showColorInput: true,
              showAlphaSlider: true,
            ),
            SizedBox(height: 24),
            // 颜色值显示
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '颜色值',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    _buildColorValueDisplay(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorValueDisplay() {
    switch (_format) {
      case ZephyrColorFormat.hex:
        return Text('HEX: #${_selectedColor.value.toRadixString(16).substring(2).toUpperCase()}');
      case ZephyrColorFormat.rgb:
        return Text('RGB: ${_selectedColor.red}, ${_selectedColor.green}, ${_selectedColor.blue}');
      case ZephyrColorFormat.hsl:
        final hsl = _rgbToHsl(_selectedColor);
        return Text('HSL: ${hsl[0].round()}°, ${hsl[1].round()}%, ${hsl[2].round()}%');
      case ZephyrColorFormat.hsv:
        final hsv = _rgbToHsv(_selectedColor);
        return Text('HSV: ${hsv[0].round()}°, ${hsv[1].round()}%, ${hsv[2].round()}%');
      default:
        return Text('');
    }
  }

  List<double> _rgbToHsl(Color color) {
    // 简化的RGB到HSL转换
    final r = color.red / 255.0;
    final g = color.green / 255.0;
    final b = color.blue / 255.0;
    
    final max = [r, g, b].reduce((a, b) => a > b ? a : b);
    final min = [r, g, b].reduce((a, b) => a < b ? a : b);
    final l = (max + min) / 2;
    
    if (max == min) {
      return [0, 0, l * 100];
    }
    
    final d = max - min;
    final s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
    
    double h;
    switch (max) {
      case r:
        h = ((g - b) / d + (g < b ? 6 : 0)) / 6;
        break;
      case g:
        h = ((b - r) / d + 2) / 6;
        break;
      case b:
        h = ((r - g) / d + 4) / 6;
        break;
      default:
        h = 0;
    }
    
    return [h * 360, s * 100, l * 100];
  }

  List<double> _rgbToHsv(Color color) {
    // 简化的RGB到HSV转换
    final r = color.red / 255.0;
    final g = color.green / 255.0;
    final b = color.blue / 255.0;
    
    final max = [r, g, b].reduce((a, b) => a > b ? a : b);
    final min = [r, g, b].reduce((a, b) => a < b ? a : b);
    final v = max;
    
    if (max == min) {
      return [0, 0, v * 100];
    }
    
    final d = max - min;
    final s = d / max;
    
    double h;
    switch (max) {
      case r:
        h = ((g - b) / d + (g < b ? 6 : 0)) / 6;
        break;
      case g:
        h = ((b - r) / d + 2) / 6;
        break;
      case b:
        h = ((r - g) / d + 4) / 6;
        break;
      default:
        h = 0;
    }
    
    return [h * 360, s * 100, v * 100];
  }
}
```

## 🔧 高级用法

### 主题定制颜色选择器

```dart
class ThemeColorPickerExample extends StatefulWidget {
  @override
  _ThemeColorPickerExampleState createState() => _ThemeColorPickerExampleState();
}

class _ThemeColorPickerExampleState extends State<ThemeColorPickerExample> {
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.orange;
  Color _accentColor = Colors.pink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主题定制'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '主题颜色定制',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            // 主题预览
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _primaryColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        color: _primaryColor,
                      ),
                      SizedBox(width: 8),
                      Text('主色调', style: TextStyle(color: _primaryColor)),
                      Spacer(),
                      Container(
                        width: 24,
                        height: 24,
                        color: _secondaryColor,
                      ),
                      SizedBox(width: 8),
                      Text('辅助色', style: TextStyle(color: _secondaryColor)),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                    ),
                    onPressed: () {},
                    child: Text('示例按钮'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // 颜色选择器
            Expanded(
              child: ListView(
                children: [
                  _buildColorSelector(
                    '主色调',
                    _primaryColor,
                    (color) => setState(() => _primaryColor = color),
                  ),
                  SizedBox(height: 16),
                  _buildColorSelector(
                    '辅助色',
                    _secondaryColor,
                    (color) => setState(() => _secondaryColor = color),
                  ),
                  SizedBox(height: 16),
                  _buildColorSelector(
                    '强调色',
                    _accentColor,
                    (color) => setState(() => _accentColor = color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelector(String label, Color color, ValueChanged<Color> onChanged) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            ZephyrColorPicker(
              initialColor: color,
              pickerType: ZephyrColorPickerType.compact,
              onColorChanged: onChanged,
              presetColors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
                Colors.pink,
                Colors.teal,
                Colors.cyan,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 渐变颜色选择器

```dart
class GradientColorPickerExample extends StatefulWidget {
  @override
  _GradientColorPickerExampleState createState() => _GradientColorPickerExampleState();
}

class _GradientColorPickerExampleState extends State<GradientColorPickerExample> {
  Color _startColor = Colors.blue;
  Color _endColor = Colors.purple;
  List<Color> _gradientColors = [];

  @override
  void initState() {
    super.initState();
    _updateGradient();
  }

  void _updateGradient() {
    setState(() {
      _gradientColors = [_startColor, _endColor];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('渐变颜色选择器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 渐变预览
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '渐变预览',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            // 颜色选择器
            Expanded(
              child: ListView(
                children: [
                  _buildGradientColorSelector(
                    '起始颜色',
                    _startColor,
                    (color) {
                      setState(() => _startColor = color);
                      _updateGradient();
                    },
                  ),
                  SizedBox(height: 16),
                  _buildGradientColorSelector(
                    '结束颜色',
                    _endColor,
                    (color) {
                      setState(() => _endColor = color);
                      _updateGradient();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientColorSelector(String label, Color color, ValueChanged<Color> onChanged) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ZephyrColorPicker(
                    initialColor: color,
                    pickerType: ZephyrColorPickerType.compact,
                    onColorChanged: onChanged,
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

### 品牌颜色管理器

```dart
class BrandColorManagerExample extends StatefulWidget {
  @override
  _BrandColorManagerExampleState createState() => _BrandColorManagerExampleState();
}

class _BrandColorManagerExampleState extends State<BrandColorManagerExample> {
  final Map<String, Color> _brandColors = {
    'primary': Colors.blue,
    'secondary': Colors.orange,
    'accent': Colors.pink,
    'success': Colors.green,
    'warning': Colors.yellow,
    'error': Colors.red,
    'info': Colors.cyan,
  };

  String? _selectedColorKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('品牌颜色管理'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveBrandColors,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 品牌颜色预览
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '品牌颜色方案',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _brandColors.entries.map((entry) {
                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedColorKey = entry.key);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: entry.value,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _selectedColorKey == entry.key
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                color: entry.value.computeLuminance() > 0.5
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // 颜色编辑器
            if (_selectedColorKey != null) ...[
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '编辑 ${_selectedColorKey} 颜色',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        ZephyrColorPicker(
                          initialColor: _brandColors[_selectedColorKey]!,
                          onColorChanged: (color) {
                            setState(() {
                              _brandColors[_selectedColorKey!] = color;
                            });
                          },
                          presetColors: [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green,
                            Colors.blue,
                            Colors.indigo,
                            Colors.purple,
                            Colors.pink,
                            Colors.teal,
                            Colors.cyan,
                            Colors.brown,
                            Colors.grey,
                          ],
                        ),
                        SizedBox(height: 16),
                        // 颜色值显示
                        Text(
                          'HEX: #${_brandColors[_selectedColorKey]!.value.toRadixString(16).substring(2).toUpperCase()}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _saveBrandColors() {
    // 保存品牌颜色到本地存储或发送到服务器
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('品牌颜色方案已保存'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrColorPicker()

```dart
const ZephyrColorPicker({
  Key? key,
  required Color initialColor,
  ValueChanged<Color>? onColorChanged,
  ZephyrColorPickerType pickerType = ZephyrColorPickerType.full,
  List<Color>? presetColors,
  bool showAlphaSlider = false,
  bool showColorInput = false,
  ZephyrColorFormat colorFormat = ZephyrColorFormat.hex,
  Widget Function(BuildContext context, Color color, ValueChanged<Color> onColorChanged)? customBuilder,
  double? width,
  double? height,
  EdgeInsetsGeometry? padding,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `initialColor`: 初始颜色
- `onColorChanged`: 颜色变化回调
- `pickerType`: 选择器类型
- `presetColors`: 预设颜色列表
- `showAlphaSlider`: 是否显示透明度滑块
- `showColorInput`: 是否显示颜色输入框
- `colorFormat`: 颜色格式
- `customBuilder`: 自定义构建器
- `width`: 宽度
- `height`: 高度
- `padding`: 内边距
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 枚举类型

#### ZephyrColorPickerType

```dart
enum ZephyrColorPickerType {
  full,     // 完整选择器
  compact,  // 紧凑选择器
  wheel,    // 色轮选择器
  slider,   // 滑块选择器
}
```

#### ZephyrColorFormat

```dart
enum ZephyrColorFormat {
  hex, // HEX格式 (#RRGGBB)
  rgb, // RGB格式 (R, G, B)
  hsl, // HSL格式 (H, S, L)
  hsv, // HSV格式 (H, S, V)
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrColorPickerTheme(
        defaultPresetColors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
        ],
        pickerType: ZephyrColorPickerType.full,
        showAlphaSlider: false,
        showColorInput: true,
        colorFormat: ZephyrColorFormat.hex,
        dialogBackgroundColor: Colors.white,
        dialogElevation: 8,
        sliderActiveColor: Colors.blue,
        sliderInactiveColor: Colors.grey[300],
        thumbColor: Colors.white,
        thumbBorderColor: Colors.blue,
        inputBackgroundColor: Colors.grey[100],
        inputBorderColor: Colors.grey[300],
        inputTextStyle: TextStyle(fontSize: 14),
        labelStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
        padding: EdgeInsets.all(16),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultPresetColors`: 默认预设颜色
- `pickerType`: 默认选择器类型
- `showAlphaSlider`: 默认是否显示透明度滑块
- `showColorInput`: 默认是否显示颜色输入框
- `colorFormat`: 默认颜色格式
- `dialogBackgroundColor`: 对话框背景颜色
- `dialogElevation`: 对话框阴影高度
- `sliderActiveColor`: 滑块激活颜色
- `sliderInactiveColor`: 滑块非激活颜色
- `thumbColor`: 滑块颜色
- `thumbBorderColor`: 滑块边框颜色
- `inputBackgroundColor`: 输入框背景颜色
- `inputBorderColor`: 输入框边框颜色
- `inputTextStyle`: 输入框文本样式
- `labelStyle`: 标签样式
- `padding`: 内边距

## 🏆 最佳实践

### 1. 合理的颜色选择器类型

```dart
// ✅ 好的做法：根据使用场景选择合适的类型
ZephyrColorPicker(
  pickerType: ZephyrColorPickerType.full, // 适合专业设计工具
  initialColor: _color,
)

ZephyrColorPicker(
  pickerType: ZephyrColorPickerType.compact, // 适合简单颜色选择
  initialColor: _color,
)

ZephyrColorPicker(
  pickerType: ZephyrColorPickerType.wheel, // 适合直观的颜色选择
  initialColor: _color,
)

// ❌ 避免的做法：选择器类型与场景不匹配
ZephyrColorPicker(
  pickerType: ZephyrColorPickerType.full, // 在简单设置中使用完整选择器过于复杂
  initialColor: _color,
)
```

### 2. 预设颜色的合理配置

```dart
// ✅ 好的做法：提供合适的预设颜色
ZephyrColorPicker(
  presetColors: [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
  ],
)

// ✅ 好的做法：根据主题配置预设颜色
ZephyrColorPicker(
  presetColors: [
    Theme.of(context).primaryColor,
    Theme.of(context).secondaryColor,
    Theme.of(context).accentColor,
    Colors.red,
    Colors.green,
    Colors.blue,
  ],
)

// ❌ 避免的做法：预设颜色过多或过少
ZephyrColorPicker(
  presetColors: _tooManyColors, // 用户难以选择
)
```

### 3. 良好的用户体验

```dart
// ✅ 好的做法：提供颜色预览
class ColorPickerWithPreview extends StatefulWidget {
  @override
  _ColorPickerWithPreviewState createState() => _ColorPickerWithPreviewState();
}

class _ColorPickerWithPreviewState extends State<ColorPickerWithPreview> {
  Color _selectedColor = Colors.blue;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 颜色预览
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: _selectedColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: 16),
        // 颜色选择器
        ZephyrColorPicker(
          initialColor: _selectedColor,
          onColorChanged: (color) {
            setState(() => _selectedColor = color);
          },
        ),
      ],
    );
  }
}

// ✅ 好的做法：提供实时反馈
ZephyrColorPicker(
  onColorChanged: (color) {
    setState(() {
      _selectedColor = color;
      _updatePreview(); // 实时更新预览
    });
  },
)

// ❌ 避免的做法：缺乏预览和反馈
ZephyrColorPicker(
  initialColor: _color,
  // 用户看不到选择的效果
)
```

### 4. 性能优化

```dart
// ✅ 好的做法：使用const构造函数
const presetColors = [
  Colors.red,
  Colors.orange,
  Colors.green,
];

ZephyrColorPicker(
  presetColors: presetColors,
)

// ✅ 好的做法：限制颜色精度
Color _quantizeColor(Color color) {
  return Color.fromARGB(
    color.alpha,
    (color.red ~/ 16) * 16,
    (color.green ~/ 16) * 16,
    (color.blue ~/ 16) * 16,
  );
}

// ❌ 避免的做法：频繁重建选择器
class BadPerformanceColorPicker extends StatefulWidget {
  @override
  _BadPerformanceColorPickerState createState() => _BadPerformanceColorPickerState();
}

class _BadPerformanceColorPickerState extends State<BadPerformanceColorPicker> {
  // 每次状态变化都重建整个选择器
  @override
  Widget build(BuildContext context) {
    return ZephyrColorPicker(
      initialColor: _color,
      onColorChanged: (color) {
        setState(() => _color = color);
      },
    );
  }
}
```

### 5. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrColorPicker(
  semanticLabel: '主题颜色选择器',
  enableAccessibilityFeatures: true,
  initialColor: _color,
)

// ✅ 好的做法：提供颜色名称
ZephyrColorPicker(
  presetColors: [
    Colors.red,
    Colors.green,
    Colors.blue,
  ],
  colorNameBuilder: (color) {
    if (color == Colors.red) return '红色';
    if (color == Colors.green) return '绿色';
        if (color == Colors.blue) return '蓝色';
        return '自定义颜色';
      },
)

// ✅ 好的做法：支持键盘导航
Focus(
  child: ZephyrColorPicker(
    enableAccessibilityFeatures: true,
    initialColor: _color,
  ),
)

// ❌ 避免的做法：缺乏无障碍支持
ZephyrColorPicker(
  initialColor: _color,
  // 缺乏语义信息和键盘支持
)
```

## 🔄 相关组件

- **ZephyrSlider**: 滑块组件
- **ZephyrInput**: 输入框组件
- **ZephyrButton**: 按钮组件
- **ZephyrDialog**: 对话框组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种颜色选择器类型
- ✅ 支持多种颜色格式
- ✅ 支持自定义样式和预设颜色
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/advanced/color_picker/`
**示例路径**: `example/lib/components/color_picker_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日