# ZephyrRating 评分组件

评分组件是一个功能强大的星级评分系统，支持交互式选择、半星评分和自定义样式。提供了直观的评分体验，包括交互式评分和只读评分显示两种模式。

## 🎯 组件概述

### 特性
- **交互式评分**: 支持点击和拖拽进行评分
- **半星支持**: 支持精确到半颗星的评分
- **自定义样式**: 支持自定义图标、颜色、大小等样式
- **多种显示模式**: 支持水平、垂直、带标签等多种显示方式
- **状态管理**: 完整的禁用、只读状态支持
- **无障碍支持**: 完整的语义化和键盘导航支持

### 适用场景
- 商品评分
- 服务评价
- 内容质量评分
- 用户反馈收集
- 技能水平评估
- 满意度调查

## 🚀 基础用法

### 基本评分

```dart
ZephyrRating(
  value: _rating,
  onChanged: (value) => setState(() => _rating = value),
)
```

### 只读评分显示

```dart
ZephyrRatingDisplay(
  value: 4.5,
  showValue: true,
)
```

### 半星评分

```dart
ZephyrRating(
  value: _rating,
  allowHalfRating: true,
  onChanged: (value) => setState(() => _rating = value),
)
```

### 带标签的评分

```dart
ZephyrRating(
  value: _rating,
  showLabels: true,
  tooltipPrefix: '评分',
  onChanged: (value) => setState(() => _rating = value),
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    ZephyrRating(
      value: _rating1,
      size: 32,
      onChanged: (value) => setState(() => _rating1 = value),
    ),
    SizedBox(height: 16),
    ZephyrRating(
      value: _rating2,
      selectedColor: Colors.red,
      unselectedColor: Colors.grey[300],
      onChanged: (value) => setState(() => _rating2 = value),
    ),
    SizedBox(height: 16),
    ZephyrRating(
      value: _rating3,
      customIcons: [
        Icons.favorite,
        Icons.favorite_border,
      ],
      onChanged: (value) => setState(() => _rating3 = value),
    ),
  ],
)
```

### 垂直评分

```dart
ZephyrRating(
  value: _rating,
  direction: Axis.vertical,
  alignment: WrapAlignment.center,
  onChanged: (value) => setState(() => _rating = value),
)
```

### 禁用状态

```dart
ZephyrRating(
  value: 3.5,
  disabled: true,
  showTooltip: false,
)
```

## 🔧 高级用法

### 商品评分组件

```dart
class ProductRating extends StatefulWidget {
  final String productName;
  final ValueChanged<double> onRatingChanged;

  const ProductRating({
    Key? key,
    required this.productName,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  _ProductRatingState createState() => _ProductRatingState();
}

class _ProductRatingState extends State<ProductRating> {
  double _rating = 0;
  bool _isHovering = false;
  double _hoverRating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '为"${widget.productName}"评分',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ZephyrRating(
          value: _isHovering ? _hoverRating : _rating,
          allowHalfRating: true,
          size: 32,
          spacing: 8,
          onHover: (value) {
            setState(() {
              _isHovering = true;
              _hoverRating = value;
            });
          },
          onChanged: (value) {
            setState(() {
              _rating = value;
              _isHovering = false;
            });
            widget.onRatingChanged(value);
            _showRatingFeedback(value);
          },
        ),
        SizedBox(height: 8),
        Text(
          _getRatingText(_rating),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _getRatingText(double rating) {
    if (rating == 0) return '请点击星星进行评分';
    if (rating <= 1) return '很差';
    if (rating <= 2) return '较差';
    if (rating <= 3) return '一般';
    if (rating <= 4) return '很好';
    return '非常好';
  }

  void _showRatingFeedback(double rating) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('感谢您的评分：${rating.toStringAsFixed(1)} 星'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
```

### 技能评分矩阵

```dart
class SkillRatingMatrix extends StatefulWidget {
  final List<Skill> skills;
  final ValueChanged<Map<String, double>> onRatingsChanged;

  const SkillRatingMatrix({
    Key? key,
    required this.skills,
    required this.onRatingsChanged,
  }) : super(key: key);

  @override
  _SkillRatingMatrixState createState() => _SkillRatingMatrixState();
}

class _SkillRatingMatrixState extends State<SkillRatingMatrix> {
  Map<String, double> _ratings = {};

  @override
  void initState() {
    super.initState();
    for (final skill in widget.skills) {
      _ratings[skill.name] = skill.initialRating;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '技能评估',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ...widget.skills.map((skill) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    skill.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ZephyrRating(
                    value: _ratings[skill.name]!,
                    allowHalfRating: true,
                    size: 24,
                    showLabels: true,
                    onChanged: (value) {
                      setState(() {
                        _ratings[skill.name] = value;
                      });
                      widget.onRatingsChanged(_ratings);
                    },
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  '${_ratings[skill.name]!.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}

class Skill {
  final String name;
  final double initialRating;

  Skill({
    required this.name,
    this.initialRating = 0,
  });
}
```

### 评分统计组件

```dart
class RatingStatistics extends StatelessWidget {
  final List<double> ratings;
  final double averageRating;

  const RatingStatistics({
    Key? key,
    required this.ratings,
    required this.averageRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratingCounts = _calculateRatingCounts();
    final totalRatings = ratings.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZephyrRatingDisplay(
                  value: averageRating,
                  allowHalfRating: true,
                  size: 20,
                ),
                SizedBox(height: 4),
                Text(
                  '$totalRatings 个评分',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 24),
        ...ratingCounts.entries.map((entry) {
          final stars = entry.key;
          final count = entry.value;
          final percentage = totalRatings > 0 ? (count / totalRatings) * 100 : 0;

          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    '$stars 星',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 40,
                  child: Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Map<int, int> _calculateRatingCounts() {
    final counts = <int, int>{
      5: 0,
      4: 0,
      3: 0,
      2: 0,
      1: 0,
    };

    for (final rating in ratings) {
      final stars = rating.round();
      if (stars >= 1 && stars <= 5) {
        counts[stars] = (counts[stars] ?? 0) + 1;
      }
    }

    return counts;
  }
}
```

### 多维度评分

```dart
class MultiDimensionRating extends StatefulWidget {
  final List<RatingDimension> dimensions;
  final ValueChanged<Map<String, double>> onRatingsChanged;

  const MultiDimensionRating({
    Key? key,
    required this.dimensions,
    required this.onRatingsChanged,
  }) : super(key: key);

  @override
  _MultiDimensionRatingState createState() => _MultiDimensionRatingState();
}

class _MultiDimensionRatingState extends State<MultiDimensionRating> {
  Map<String, double> _ratings = {};

  @override
  void initState() {
    super.initState();
    for (final dimension in widget.dimensions) {
      _ratings[dimension.id] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '多维度评分',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ...widget.dimensions.map((dimension) {
          return Card(
            margin: EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(dimension.icon, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          dimension.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        '${_ratings[dimension.id]!.toStringAsFixed(1)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    dimension.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 12),
                  ZephyrRating(
                    value: _ratings[dimension.id]!,
                    allowHalfRating: true,
                    onChanged: (value) {
                      setState(() {
                        _ratings[dimension.id] = value;
                      });
                      widget.onRatingsChanged(_ratings);
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 16),
        _buildOverallRating(),
      ],
    );
  }

  Widget _buildOverallRating() {
    final average = _ratings.values.fold(0.0, (sum, rating) => sum + rating) / _ratings.length;
    
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            '综合评分',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          ZephyrRatingDisplay(
            value: average,
            allowHalfRating: true,
            showValue: true,
            valueStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class RatingDimension {
  final String id;
  final String name;
  final String description;
  final IconData icon;

  RatingDimension({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrRating()

```dart
const ZephyrRating({
  Key? key,
  double value = 0,
  double maxValue = 5,
  ValueChanged<double>? onChanged,
  ValueChanged<double>? onHover,
  ZephyrRatingTheme? theme,
  double size = 24,
  double spacing = 4,
  bool allowHalfRating = false,
  bool allowClear = false,
  bool readOnly = false,
  int? itemCount,
  bool disabled = false,
  Axis direction = Axis.horizontal,
  WrapAlignment alignment = WrapAlignment.start,
  bool showLabels = false,
  bool showTooltip = true,
  String? tooltipPrefix,
  List<IconData>? customIcons,
  Color? unselectedColor,
  Color? selectedColor,
  Color? hoverColor,
  Duration animationDuration = const Duration(milliseconds: 200),
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `value`: 当前评分值
- `maxValue`: 最大评分值
- `onChanged`: 评分变化回调
- `onHover`: 悬停回调
- `theme`: 主题配置
- `size`: 评分项大小
- `spacing`: 评分项间距
- `allowHalfRating`: 是否允许半星评分
- `allowClear`: 是否允许点击清除评分
- `readOnly`: 是否只读
- `itemCount`: 评分项数量
- `disabled`: 是否禁用
- `direction`: 布局方向
- `alignment`: 对齐方式
- `showLabels`: 是否显示标签
- `showTooltip`: 是否显示工具提示
- `tooltipPrefix`: 工具提示前缀
- `customIcons`: 自定义图标
- `unselectedColor`: 未选中颜色
- `selectedColor`: 选中颜色
- `hoverColor`: 悬停颜色
- `animationDuration`: 动画持续时间
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrRatingDisplay()

```dart
const ZephyrRatingDisplay({
  Key? key,
  required double value,
  double maxValue = 5,
  ZephyrRatingTheme? theme,
  double size = 16,
  double spacing = 2,
  bool allowHalfRating = false,
  int? itemCount,
  Axis direction = Axis.horizontal,
  bool showValue = false,
  TextStyle? valueStyle,
  List<IconData>? customIcons,
  Color? unselectedColor,
  Color? selectedColor,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

### ZephyrRatingTheme

```dart
ZephyrRatingTheme({
  Color? selectedColor,
  Color? unselectedColor,
  Color? hoverColor,
  Color? disabledColor,
  IconData? selectedIcon,
  IconData? unselectedIcon,
  TextStyle? labelStyle,
  Duration? animationDuration,
})
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrRatingTheme(
        selectedColor: Colors.amber,
        unselectedColor: Colors.grey[300],
        hoverColor: Colors.amber[200],
        disabledColor: Colors.grey[200],
        selectedIcon: Icons.star,
        unselectedIcon: Icons.star_border,
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        animationDuration: Duration(milliseconds: 200),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `selectedColor`: 选中时的颜色
- `unselectedColor`: 未选中时的颜色
- `hoverColor`: 悬停时的颜色
- `disabledColor`: 禁用时的颜色
- `selectedIcon`: 选中时的图标
- `unselectedIcon`: 未选中时的图标
- `labelStyle`: 标签样式
- `animationDuration`: 动画持续时间

## 🏆 最佳实践

### 1. 合理的评分精度

```dart
// ✅ 好的做法：根据场景选择合适的精度
ZephyrRating(
  value: _productRating,
  allowHalfRating: true,  // 商品评分通常需要半星精度
  onChanged: (value) => setState(() => _productRating = value),
)

ZephyrRating(
  value: _serviceRating,
  allowHalfRating: false,  // 服务评分可以使用整星
  onChanged: (value) => setState(() => _serviceRating = value),
)

// ❌ 避免的做法：精度不合适
ZephyrRating(
  value: _simpleRating,
  allowHalfRating: true,  // 简单评分不需要半星精度
  onChanged: (value) => setState(() => _simpleRating = value),
)
```

### 2. 适当的图标大小

```dart
// ✅ 好的做法：根据使用场景选择合适的图标大小
ZephyrRating(
  value: _rating,
  size: 16,  // 列表中的紧凑显示
  onChanged: (value) => setState(() => _rating = value),
)

ZephyrRating(
  value: _rating,
  size: 24,  // 标准显示
  onChanged: (value) => setState(() => _rating = value),
)

ZephyrRating(
  value: _rating,
  size: 32,  // 突出显示
  onChanged: (value) => setState(() => _rating = value),
)
```

### 3. 清晰的反馈

```dart
// ✅ 好的做法：提供评分反馈
ZephyrRating(
  value: _rating,
  showLabels: true,
  tooltipPrefix: '评分',
  onChanged: (value) {
    setState(() => _rating = value);
    _showRatingFeedback(value);
  },
)

// ✅ 好的做法：显示评分统计
RatingStatistics(
  ratings: _allRatings,
  averageRating: _averageRating,
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrRating(
  value: _rating,
  semanticLabel: '商品评分',
  enableAccessibilityFeatures: true,
  onChanged: (value) => setState(() => _rating = value),
)

// ✅ 好的做法：提供键盘操作支持
Focus(
  child: ZephyrRating(
    value: _rating,
    onChanged: (value) => setState(() => _rating = value),
  ),
)
```

### 5. 性能优化

```dart
// ✅ 好的做法：使用只读组件显示静态评分
ZephyrRatingDisplay(
  value: _averageRating,
  showValue: true,
)

// ✅ 好的做法：避免不必要的重建
const ratingTheme = ZephyrRatingTheme(
  selectedColor: Colors.amber,
  unselectedColor: Colors.grey[300],
);

ZephyrRating(
  value: _rating,
  theme: ratingTheme,
  onChanged: (value) => setState(() => _rating = value),
)
```

## 🔄 相关组件

- **ZephyrStar**: 星星图标组件
- **ZephyrProgress**: 进度条组件
- **ZephyrFeedback**: 反馈组件
- **ZephyrFormBuilder**: 表单构建器

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本评分功能
- ✅ 半星评分支持
- ✅ 自定义样式支持
- ✅ 完整的无障碍支持

---

**组件路径**: `lib/src/components/form/rating/`
**示例路径**: `example/lib/components/rating_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日