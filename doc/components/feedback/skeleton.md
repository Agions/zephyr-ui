# ZephyrSkeleton 骨架屏组件

骨架屏组件是ZephyrUI反馈系统中的重要组件，用于在内容加载时显示占位符。支持多种骨架屏类型、自定义样式和动画效果，是提升用户体验的重要工具。

## 🎯 组件概述

### 特性
- **多种骨架屏类型**: 支持文本、图片、列表、卡片等多种类型
- **灵活样式**: 支持自定义颜色、大小、形状等样式
- **丰富动画**: 支持闪烁、脉冲、波浪等多种动画效果
- **组合使用**: 支持多个骨架屏组件组合使用
- **主题适配**: 完整的主题系统支持

### 适用场景
- 内容加载占位
- 数据异步加载
- 图片预加载
- 列表加载
- 卡片加载
- 页面切换

## 🚀 基础用法

### 基本骨架屏组件

```dart
class BasicSkeletonExample extends StatefulWidget {
  @override
  _BasicSkeletonExampleState createState() => _BasicSkeletonExampleState();
}

class _BasicSkeletonExampleState extends State<BasicSkeletonExample> {
  bool _isLoading = true;
  List<String> _data = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // 模拟数据加载
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      _data = [
        '项目1',
        '项目2',
        '项目3',
        '项目4',
        '项目5',
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本骨架屏组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _isLoading
            ? _buildSkeleton()
            : _buildContent(),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Column(
      children: [
        // 标题骨架
        ZephyrSkeleton(
          type: ZephyrSkeletonType.text,
          width: 120,
          height: 24,
        ),
        SizedBox(height: 16),
        
        // 内容骨架
        for (int i = 0; i < 5; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: ZephyrSkeleton(
              type: ZephyrSkeletonType.text,
              height: 16,
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Text(
          '数据列表',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        
        ..._data.map((item) => Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(item),
        )).toList(),
      ],
    );
  }
}
```

### 图片骨架屏组件

```dart
class ImageSkeletonExample extends StatefulWidget {
  @override
  _ImageSkeletonExampleState createState() => _ImageSkeletonExampleState();
}

class _ImageSkeletonExampleState extends State<ImageSkeletonExample> {
  bool _isLoading = true;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    // 模拟图片加载
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      _imageUrl = 'https://example.com/image.jpg';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片骨架屏组件'),
      ),
      body: Center(
        child: _isLoading
            ? ZephyrSkeleton(
                type: ZephyrSkeletonType.image,
                width: 200,
                height: 200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              )
            : Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.image,
                  size: 64,
                  color: Colors.grey[600],
                ),
              ),
      ),
    );
  }
}
```

### 列表骨架屏组件

```dart
class ListSkeletonExample extends StatefulWidget {
  @override
  _ListSkeletonExampleState createState() => _ListSkeletonExampleState();
}

class _ListSkeletonExampleState extends State<ListSkeletonExample> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    // 模拟数据加载
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      _items = [
        {'title': '项目1', 'subtitle': '描述1'},
        {'title': '项目2', 'subtitle': '描述2'},
        {'title': '项目3', 'subtitle': '描述3'},
        {'title': '项目4', 'subtitle': '描述4'},
        {'title': '项目5', 'subtitle': '描述5'},
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('列表骨架屏组件'),
      ),
      body: _isLoading
          ? _buildListSkeleton()
          : _buildListContent(),
    );
  }

  Widget _buildListSkeleton() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 头像骨架
                Row(
                  children: [
                    ZephyrSkeleton(
                      type: ZephyrSkeletonType.circle,
                      size: 40,
                    ),
                    SizedBox(width: 12),
                    // 标题骨架
                    ZephyrSkeleton(
                      type: ZephyrSkeletonType.text,
                      width: 100,
                      height: 16,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // 副标题骨架
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.text,
                  height: 14,
                ),
                SizedBox(height: 8),
                // 内容骨架
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.text,
                  height: 14,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListContent() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    SizedBox(width: 12),
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  item['subtitle'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

## 🎨 样式定制

### 自定义颜色骨架屏组件

```dart
class CustomColorSkeletonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义颜色骨架屏组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 蓝色骨架屏
            ZephyrSkeleton(
              type: ZephyrSkeletonType.text,
              width: 200,
              height: 20,
              baseColor: Colors.blue[100],
              highlightColor: Colors.blue[300],
            ),
            SizedBox(height: 16),
            
            // 绿色骨架屏
            ZephyrSkeleton(
              type: ZephyrSkeletonType.text,
              width: 150,
              height: 20,
              baseColor: Colors.green[100],
              highlightColor: Colors.green[300],
            ),
            SizedBox(height: 16),
            
            // 紫色骨架屏
            ZephyrSkeleton(
              type: ZephyrSkeletonType.text,
              width: 180,
              height: 20,
              baseColor: Colors.purple[100],
              highlightColor: Colors.purple[300],
            ),
            SizedBox(height: 16),
            
            // 橙色骨架屏
            ZephyrSkeleton(
              type: ZephyrSkeletonType.image,
              width: 100,
              height: 100,
              baseColor: Colors.orange[100],
              highlightColor: Colors.orange[300],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 自定义形状骨架屏组件

```dart
class CustomShapeSkeletonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义形状骨架屏组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 圆形骨架屏
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.circle,
                  size: 60,
                ),
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.circle,
                  size: 80,
                ),
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.circle,
                  size: 100,
                ),
              ],
            ),
            SizedBox(height: 32),
            
            // 圆角矩形骨架屏
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.rectangle,
                  width: 80,
                  height: 60,
                  borderRadius: BorderRadius.circular(8),
                ),
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.rectangle,
                  width: 100,
                  height: 80,
                  borderRadius: BorderRadius.circular(12),
                ),
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.rectangle,
                  width: 120,
                  height: 100,
                  borderRadius: BorderRadius.circular(16),
                ),
              ],
            ),
            SizedBox(height: 32),
            
            // 混合形状骨架屏
            Row(
              children: [
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.circle,
                  size: 50,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      ZephyrSkeleton(
                        type: ZephyrSkeletonType.text,
                        height: 16,
                      ),
                      SizedBox(height: 8),
                      ZephyrSkeleton(
                        type: ZephyrSkeletonType.text,
                        height: 14,
                        width: double.infinity,
                      ),
                    ],
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

### 卡片骨架屏组件

```dart
class CardSkeletonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片骨架屏组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 基本卡片骨架屏
            ZephyrSkeletonCard(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZephyrSkeleton(
                      type: ZephyrSkeletonType.text,
                      width: 120,
                      height: 24,
                    ),
                    SizedBox(height: 16),
                    ZephyrSkeleton(
                      type: ZephyrSkeletonType.text,
                      height: 16,
                    ),
                    SizedBox(height: 8),
                    ZephyrSkeleton(
                      type: ZephyrSkeletonType.text,
                      height: 16,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // 图片卡片骨架屏
            ZephyrSkeletonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZephyrSkeleton(
                    type: ZephyrSkeletonType.image,
                    width: double.infinity,
                    height: 150,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ZephyrSkeleton(
                          type: ZephyrSkeletonType.text,
                          width: 100,
                          height: 20,
                        ),
                        SizedBox(height: 8),
                        ZephyrSkeleton(
                          type: ZephyrSkeletonType.text,
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 带动画的骨架屏组件

```dart
class AnimatedSkeletonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带动画的骨架屏组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 闪烁动画
            ZephyrSkeleton(
              type: ZephyrSkeletonType.text,
              width: 200,
              height: 20,
              animationType: SkeletonAnimationType.pulse,
            ),
            SizedBox(height: 16),
            
            // 波浪动画
            ZephyrSkeleton(
              type: ZephyrSkeletonType.text,
              width: 180,
              height: 20,
              animationType: SkeletonAnimationType.wave,
            ),
            SizedBox(height: 16),
            
            // 渐变动画
            ZephyrSkeleton(
              type: ZephyrSkeletonType.image,
              width: 100,
              height: 100,
              animationType: SkeletonAnimationType.gradient,
            ),
            SizedBox(height: 16),
            
            // 混合动画
            Row(
              children: [
                ZephyrSkeleton(
                  type: ZephyrSkeletonType.circle,
                  size: 40,
                  animationType: SkeletonAnimationType.pulse,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ZephyrSkeleton(
                    type: ZephyrSkeletonType.text,
                    height: 16,
                    animationType: SkeletonAnimationType.wave,
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

### 表格骨架屏组件

```dart
class TableSkeletonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表格骨架屏组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 表头骨架屏
            ZephyrSkeleton(
              type: ZephyrSkeletonType.text,
              width: 100,
              height: 20,
            ),
            SizedBox(height: 16),
            
            // 表格行骨架屏
            for (int i = 0; i < 5; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: ZephyrSkeleton(
                        type: ZephyrSkeletonType.text,
                        height: 16,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ZephyrSkeleton(
                        type: ZephyrSkeletonType.text,
                        height: 16,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ZephyrSkeleton(
                        type: ZephyrSkeletonType.text,
                        height: 16,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
```

### 页面骨架屏组件

```dart
class PageSkeletonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面骨架屏组件'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 页面标题骨架屏
            ZephyrSkeleton(
              type: ZephyrSkeletonType.text,
              width: 150,
              height: 32,
            ),
            SizedBox(height: 24),
            
            // 统计卡片骨架屏
            Row(
              children: [
                Expanded(
                  child: ZephyrSkeletonCard(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ZephyrSkeleton(
                            type: ZephyrSkeletonType.text,
                            width: 60,
                            height: 16,
                          ),
                          SizedBox(height: 8),
                          ZephyrSkeleton(
                            type: ZephyrSkeletonType.text,
                            width: 40,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ZephyrSkeletonCard(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ZephyrSkeleton(
                            type: ZephyrSkeletonType.text,
                            width: 60,
                            height: 16,
                          ),
                          SizedBox(height: 8),
                          ZephyrSkeleton(
                            type: ZephyrSkeletonType.text,
                            width: 40,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // 列表骨架屏
            for (int i = 0; i < 3; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: ZephyrSkeletonCard(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ZephyrSkeleton(
                              type: ZephyrSkeletonType.circle,
                              size: 40,
                            ),
                            SizedBox(width: 12),
                            ZephyrSkeleton(
                              type: ZephyrSkeletonType.text,
                              width: 100,
                              height: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        ZephyrSkeleton(
                          type: ZephyrSkeletonType.text,
                          height: 14,
                        ),
                        SizedBox(height: 8),
                        ZephyrSkeleton(
                          type: ZephyrSkeletonType.text,
                          height: 14,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
```

### 动态骨架屏组件

```dart
class DynamicSkeletonExample extends StatefulWidget {
  @override
  _DynamicSkeletonExampleState createState() => _DynamicSkeletonExampleState();
}

class _DynamicSkeletonExampleState extends State<DynamicSkeletonExample> {
  bool _isLoading = true;
  int _itemCount = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    setState(() => _isLoading = true);
    
    // 模拟动态加载
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _itemCount = (Random().nextInt(5) + 3);
      });
    });
    
    // 2秒后完成加载
    Future.delayed(Duration(seconds: 2), () {
      _timer?.cancel();
      setState(() => _isLoading = false);
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
        title: Text('动态骨架屏组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 控制按钮
            ElevatedButton(
              onPressed: _startLoading,
              child: Text('重新加载'),
            ),
            SizedBox(height: 24),
            
            // 动态骨架屏
            if (_isLoading)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _itemCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: ZephyrSkeletonCard(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ZephyrSkeleton(
                                  type: ZephyrSkeletonType.circle,
                                  size: 32,
                                ),
                                SizedBox(width: 12),
                                ZephyrSkeleton(
                                  type: ZephyrSkeletonType.text,
                                  width: 80 + Random().nextInt(40),
                                  height: 16,
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            ZephyrSkeleton(
                              type: ZephyrSkeletonType.text,
                              height: 14,
                              width: double.infinity,
                            ),
                            SizedBox(height: 8),
                            if (Random().nextBool())
                              ZephyrSkeleton(
                                type: ZephyrSkeletonType.text,
                                height: 14,
                                width: double.infinity * 0.8,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            else
              Center(
                child: Text('加载完成！共 $_itemCount 个项目'),
              ),
          ],
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrSkeleton()

```dart
const ZephyrSkeleton({
  Key? key,
  required ZephyrSkeletonType type,
  double? width,
  double? height,
  double? size,
  Color? baseColor,
  Color? highlightColor,
  BorderRadius? borderRadius,
  BoxShape? shape,
  SkeletonAnimationType? animationType,
  Duration? animationDuration,
  Curve? animationCurve,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `type`: 骨架屏类型
- `width`: 宽度
- `height`: 高度
- `size`: 尺寸 (圆形骨架屏)
- `baseColor`: 基础颜色
- `highlightColor`: 高亮颜色
- `borderRadius`: 边框圆角
- `shape`: 形状
- `animationType`: 动画类型
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrSkeletonCard()

```dart
const ZephyrSkeletonCard({
  Key? key,
  double? width,
  double? height,
  Widget? child,
  Color? baseColor,
  Color? highlightColor,
  BorderRadius? borderRadius,
  double? elevation,
  SkeletonAnimationType? animationType,
  Duration? animationDuration,
  Curve? animationCurve,
})
```

### 枚举类型

#### ZephyrSkeletonType

```dart
enum ZephyrSkeletonType {
  text,       // 文本骨架屏
  image,      // 图片骨架屏
  rectangle,  // 矩形骨架屏
  circle,     // 圆形骨架屏
}
```

#### SkeletonAnimationType

```dart
enum SkeletonAnimationType {
  pulse,    // 脉冲动画
  wave,     // 波浪动画
  gradient, // 渐变动画
  none,     // 无动画
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrSkeletonTheme(
        defaultBaseColor: Colors.grey[300],
        defaultHighlightColor: Colors.grey[100],
        defaultBorderRadius: BorderRadius.circular(4),
        defaultAnimationType: SkeletonAnimationType.pulse,
        animationDuration: Duration(milliseconds: 1000),
        animationCurve: Curves.easeInOut,
        cardElevation: 2,
        cardBorderRadius: BorderRadius.circular(8),
        textHeight: 16,
        imageSize: Size(100, 100),
        circleSize: 40,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultBaseColor`: 默认基础颜色
- `defaultHighlightColor`: 默认高亮颜色
- `defaultBorderRadius`: 默认边框圆角
- `defaultAnimationType`: 默认动画类型
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `cardElevation`: 卡片阴影高度
- `cardBorderRadius`: 卡片边框圆角
- `textHeight`: 文本高度
- `imageSize`: 图片尺寸
- `circleSize`: 圆形尺寸

## 🏆 最佳实践

### 1. 合理的骨架屏类型选择

```dart
// ✅ 好的做法：根据内容类型选择合适的骨架屏
// 文本内容
ZephyrSkeleton(
  type: ZephyrSkeletonType.text,
  height: 16,
)

// 图片内容
ZephyrSkeleton(
  type: ZephyrSkeletonType.image,
  width: 200,
  height: 150,
)

// 用户头像
ZephyrSkeleton(
  type: ZephyrSkeletonType.circle,
  size: 40,
)

// ✅ 好的做法：使用卡片骨架屏
ZephyrSkeletonCard(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        ZephyrSkeleton(type: ZephyrSkeletonType.text, height: 20),
        SizedBox(height: 8),
        ZephyrSkeleton(type: ZephyrSkeletonType.text, height: 16),
      ],
    ),
  ),
)

// ❌ 避免的做法：骨架屏类型不匹配
ZephyrSkeleton(
  type: ZephyrSkeletonType.circle,
  width: 200, // 圆形骨架屏不需要宽度
  height: 150,
)
```

### 2. 尺寸匹配

```dart
// ✅ 好的做法：骨架屏尺寸与实际内容匹配
// 标题骨架屏
ZephyrSkeleton(
  type: ZephyrSkeletonType.text,
  width: 120, // 与实际标题宽度匹配
  height: 24, // 与实际标题高度匹配
)

// 内容骨架屏
ZephyrSkeleton(
  type: ZephyrSkeletonType.text,
  height: 16, // 与实际内容高度匹配
)

// ✅ 好的做法：使用相对尺寸
ZephyrSkeleton(
  type: ZephyrSkeletonType.text,
  width: double.infinity * 0.8, // 相对宽度
  height: 16,
)

// ❌ 避免的做法：尺寸不匹配
ZephyrSkeleton(
  type: ZephyrSkeletonType.text,
  width: 50,  // 过小
  height: 8,   // 过小
)
```

### 3. 动画效果

```dart
// ✅ 好的做法：使用合适的动画效果
// 页面加载使用脉冲动画
ZephyrSkeleton(
  type: ZephyrSkeletonType.text,
  animationType: SkeletonAnimationType.pulse,
)

// 列表加载使用波浪动画
ZephyrSkeleton(
  type: ZephyrSkeletonType.text,
  animationType: SkeletonAnimationType.wave,
)

// ✅ 好的做法：避免过度动画
ZephyrSkeleton(
  type: ZephyrSkeletonType.text,
  animationType: SkeletonAnimationType.none, // 静态骨架屏
)

// ❌ 避免的做法：过于复杂的动画
ZephyrSkeleton(
  type: ZephyrSkeletonType.text,
  animationType: SkeletonAnimationType.gradient, // 可能过于复杂
  animationDuration: Duration(seconds: 2), // 过长
)
```

### 4. 用户体验优化

```dart
// ✅ 好的做法：及时显示真实内容
bool _isLoading = true;
List<String> _data = [];

Future<void> _loadData() async {
  setState(() => _isLoading = true);
  final data = await _fetchData();
  setState(() {
    _data = data;
    _isLoading = false;
  });
}

// ✅ 好的做法：提供占位符布局
Widget _buildContent() {
  if (_isLoading) {
    return _buildSkeleton();
  }
  if (_data.isEmpty) {
    return _buildEmptyState();
  }
  return _buildRealContent();
}

// ✅ 好的做法：组合使用骨架屏
Column(
  children: [
    ZephyrSkeleton(type: ZephyrSkeletonType.text, width: 100, height: 20),
    SizedBox(height: 8),
    ZephyrSkeleton(type: ZephyrSkeletonType.text, height: 16),
    SizedBox(height: 8),
    ZephyrSkeleton(type: ZephyrSkeletonType.text, height: 16),
  ],
)

// ❌ 避免的做法：骨架屏显示时间过长
Timer(Duration(seconds: 10), () {
  setState(() => _isLoading = false); // 用户等待时间过长
});
```

## 🔄 相关组件

- **ZephyrLoading**: 加载组件
- **ZephyrProgress**: 进度组件
- **ZephyrPlaceholder**: 占位符组件
- **ZephyrShimmer**: 闪烁效果组件
- **ZephyrSpinner**: 旋转器组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种骨架屏类型
- ✅ 支持自定义样式和动画
- ✅ 支持卡片骨架屏
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/feedback/skeleton/`
**示例路径**: `example/lib/components/skeleton_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日