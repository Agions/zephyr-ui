# ZephyrContainer 容器组件

容器组件是ZephyrUI布局系统的基础组件，提供了灵活的容器包装能力。支持多种装饰效果、尺寸约束和交互功能，是构建复杂布局的核心组件。

## 🎯 组件概述

### 特性
- **灵活布局**: 支持多种尺寸约束和定位方式
- **丰富装饰**: 支持边框、圆角、阴影、渐变等装饰效果
- **交互能力**: 支持点击、长按、悬停等交互事件
- **动画支持**: 内置动画效果和过渡支持
- **响应式**: 支持响应式设计和媒体查询
- **主题适配**: 完整的主题系统支持

### 适用场景
- 卡片布局容器
- 对话框容器
- 列表项容器
- 布局分组容器
- 装饰性容器
- 交互式容器

## 🚀 基础用法

### 基本容器

```dart
ZephyrContainer(
  child: Text('这是一个基本容器'),
)
```

### 带边框的容器

```dart
ZephyrContainer(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(8),
  ),
  padding: EdgeInsets.all(16),
  child: Text('带边框的容器'),
)
```

### 带阴影的容器

```dart
ZephyrContainer(
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
  padding: EdgeInsets.all(16),
  child: Text('带阴影的容器'),
)
```

### 渐变背景容器

```dart
ZephyrContainer(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue, Colors.purple],
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  padding: EdgeInsets.all(16),
  child: Text(
    '渐变背景容器',
    style: TextStyle(color: Colors.white),
  ),
)
```

## 🎨 样式定制

### 尺寸和约束

```dart
Column(
  children: [
    // 固定尺寸
    ZephyrContainer(
      width: 200,
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Text('固定尺寸', style: TextStyle(color: Colors.white)),
      ),
    ),
    
    SizedBox(height: 16),
    
    // 最小/最大尺寸约束
    ZephyrContainer(
      constraints: BoxConstraints(
        minWidth: 100,
        maxWidth: 300,
        minHeight: 50,
        maxHeight: 150,
      ),
      color: Colors.green,
      child: Center(
        child: Text('约束尺寸', style: TextStyle(color: Colors.white)),
      ),
    ),
    
    SizedBox(height: 16),
    
    // 自适应尺寸
    ZephyrContainer(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      color: Colors.orange,
      child: Text('自适应宽度'),
    ),
  ],
)
```

### 边框和圆角

```dart
Column(
  children: [
    // 统一圆角
    ZephyrContainer(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Text('统一圆角', style: TextStyle(color: Colors.white)),
    ),
    
    SizedBox(height: 16),
    
    // 分别设置圆角
    ZephyrContainer(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Text('分别设置圆角', style: TextStyle(color: Colors.white)),
    ),
    
    SizedBox(height: 16),
    
    // 边框样式
    ZephyrContainer(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 3,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: Text('边框样式'),
    ),
  ],
)
```

### 阴影效果

```dart
Column(
  children: [
    // 轻微阴影
    ZephyrContainer(
      decoration: BoxDecoration(
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
      padding: EdgeInsets.all(16),
      child: Text('轻微阴影'),
    ),
    
    SizedBox(height: 16),
    
    // 中等阴影
    ZephyrContainer(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Text('中等阴影'),
    ),
    
    SizedBox(height: 16),
    
    // 强阴影
    ZephyrContainer(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 32,
            offset: Offset(0, 16),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Text('强阴影'),
    ),
  ],
)
```

## 🔧 高级用法

### 交互式容器

```dart
class InteractiveContainer extends StatefulWidget {
  @override
  _InteractiveContainerState createState() => _InteractiveContainerState();
}

class _InteractiveContainerState extends State<InteractiveContainer> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ZephyrContainer(
      decoration: BoxDecoration(
        color: _isPressed 
            ? Colors.blue[700] 
            : _isHovered 
                ? Colors.blue[600] 
                : Colors.blue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isPressed ? 0.3 : 0.2),
            blurRadius: _isPressed ? 16 : 8,
            offset: Offset(0, _isPressed ? 8 : 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          '交互式容器',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('容器被点击')),
        );
      },
      onHover: (isHovered) {
        setState(() => _isHovered = isHovered);
      },
      onTapDown: (details) {
        setState(() => _isPressed = true);
      },
      onTapUp: (details) {
        setState(() => _isPressed = false);
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
    );
  }
}
```

### 响应式容器

```dart
class ResponsiveContainer extends StatelessWidget {
  final Widget child;

  const ResponsiveContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    return ZephyrContainer(
      margin: EdgeInsets.all(
        isMobile ? 8 : (isTablet ? 16 : 24),
      ),
      padding: EdgeInsets.all(
        isMobile ? 16 : (isTablet ? 24 : 32),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          isMobile ? 8 : (isTablet ? 12 : 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              isMobile ? 0.1 : (isTablet ? 0.15 : 0.2),
            ),
            blurRadius: isMobile ? 4 : (isTablet ? 8 : 16),
            offset: Offset(0, isMobile ? 2 : (isTablet ? 4 : 8)),
          ),
        ],
      ),
      child: child,
    );
  }
}
```

### 可折叠容器

```dart
class CollapsibleContainer extends StatefulWidget {
  final String title;
  final Widget child;

  const CollapsibleContainer({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  _CollapsibleContainerState createState() => _CollapsibleContainerState();
}

class _CollapsibleContainerState extends State<CollapsibleContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrContainer(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          ZephyrContainer(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: _toggle,
                ),
              ],
            ),
          ),
          // 可折叠内容
          SizeTransition(
            sizeFactor: _animation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
```

### 拖拽容器

```dart
class DraggableContainer extends StatefulWidget {
  final Widget child;

  const DraggableContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _DraggableContainerState createState() => _DraggableContainerState();
}

class _DraggableContainerState extends State<DraggableContainer> {
  Offset _position = Offset(0, 0);
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
            onPanStart: (details) {
              setState(() => _isDragging = true);
            },
            onPanUpdate: (details) {
              setState(() {
                _position += details.delta;
              });
            },
            onPanEnd: (details) {
              setState(() => _isDragging = false);
            },
            child: ZephyrContainer(
              decoration: BoxDecoration(
                color: _isDragging ? Colors.blue[100] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isDragging ? 0.3 : 0.2),
                    blurRadius: _isDragging ? 16 : 8,
                    offset: Offset(0, _isDragging ? 8 : 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.drag_handle, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(child: widget.child),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

### 分割容器

```dart
class SplitContainer extends StatefulWidget {
  final Widget leftChild;
  final Widget rightChild;
  final double initialSplitRatio;

  const SplitContainer({
    Key? key,
    required this.leftChild,
    required this.rightChild,
    this.initialSplitRatio = 0.5,
  }) : super(key: key);

  @override
  _SplitContainerState createState() => _SplitContainerState();
}

class _SplitContainerState extends State<SplitContainer> {
  late double _splitRatio;

  @override
  void initState() {
    super.initState();
    _splitRatio = widget.initialSplitRatio;
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrContainer(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 左侧面板
          Expanded(
            flex: (_splitRatio * 100).round(),
            child: widget.leftChild,
          ),
          // 分割线
          GestureDetector(
            onPanUpdate: (details) {
              final box = context.findRenderObject() as RenderBox;
              final localPosition = box.globalToLocal(details.globalPosition);
              final newRatio = localPosition.dx / box.size.width;
              setState(() {
                _splitRatio = newRatio.clamp(0.2, 0.8);
              });
            },
            child: ZephyrContainer(
              width: 4,
              color: Colors.grey[300],
              child: Center(
                child: ZephyrContainer(
                  width: 20,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          // 右侧面板
          Expanded(
            flex: ((1 - _splitRatio) * 100).round(),
            child: widget.rightChild,
          ),
        ],
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrContainer()

```dart
const ZephyrContainer({
  Key? key,
  Widget? child,
  double? width,
  double? height,
  BoxConstraints? constraints,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  Color? color,
  Decoration? decoration,
  Decoration? foregroundDecoration,
  AlignmentGeometry? alignment,
  Matrix4? transform,
  AlignmentGeometry? transformAlignment,
  Clip clipBehavior = Clip.none,
  VoidCallback? onTap,
  VoidCallback? onDoubleTap,
  VoidCallback? onLongPress,
  GestureTapDownCallback? onTapDown,
  GestureTapUpCallback? onTapUp,
  GestureTapCancelCallback? onTapCancel,
  ValueChanged<bool>? onHover,
  ValueChanged<bool>? onHighlight,
  Duration? animationDuration,
  Curve? animationCurve,
  String? semanticLabel,
  bool? excludeFromSemantics,
})
```

**参数说明：**
- `child`: 子组件
- `width`: 宽度
- `height`: 高度
- `constraints`: 尺寸约束
- `margin`: 外边距
- `padding`: 内边距
- `color`: 背景颜色
- `decoration`: 装饰
- `foregroundDecoration`: 前景装饰
- `alignment`: 对齐方式
- `transform`: 变换矩阵
- `transformAlignment`: 变换对齐
- `clipBehavior`: 裁剪行为
- `onTap`: 点击回调
- `onDoubleTap`: 双击回调
- `onLongPress`: 长按回调
- `onTapDown`: 按下回调
- `onTapUp`: 抬起回调
- `onTapCancel`: 取消回调
- `onHover`: 悬停回调
- `onHighlight`: 高亮回调
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `semanticLabel`: 语义标签
- `excludeFromSemantics`: 是否排除在语义之外

### 静态方法

#### ZephyrContainer.card()

```dart
static Widget card({
  Key? key,
  required Widget child,
  EdgeInsetsGeometry? padding,
  BorderRadius? borderRadius,
  Color? color,
  List<BoxShadow>? boxShadow,
  VoidCallback? onTap,
})
```

#### ZephyrContainer.interactive()

```dart
static Widget interactive({
  Key? key,
  required Widget child,
  VoidCallback? onTap,
  Color? normalColor,
  Color? hoverColor,
  Color? pressedColor,
  BorderRadius? borderRadius,
  Duration? animationDuration,
})
```

#### ZephyrContainer.responsive()

```dart
static Widget responsive({
  Key? key,
  required Widget child,
  EdgeInsetsGeometry? mobilePadding,
  EdgeInsetsGeometry? tabletPadding,
  EdgeInsetsGeometry? desktopPadding,
  double? mobileMargin,
  double? tabletMargin,
  double? desktopMargin,
})
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrContainerTheme(
        defaultColor: Colors.white,
        defaultBorderRadius: BorderRadius.circular(8),
        defaultShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        defaultPadding: EdgeInsets.all(16),
        defaultMargin: EdgeInsets.all(8),
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeInOut,
        interactiveHoverColor: Colors.blue[50],
        interactivePressedColor: Colors.blue[100],
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultColor`: 默认背景颜色
- `defaultBorderRadius`: 默认圆角
- `defaultShadow`: 默认阴影
- `defaultPadding`: 默认内边距
- `defaultMargin`: 默认外边距
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `interactiveHoverColor`: 交互悬停颜色
- `interactivePressedColor`: 交互按下颜色

## 🏆 最佳实践

### 1. 合理使用阴影

```dart
// ✅ 好的做法：根据使用场景选择合适的阴影
ZephyrContainer(
  decoration: BoxDecoration(
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
  child: Text('卡片'),
)

// ✅ 好的做法：为浮动元素使用更强的阴影
ZephyrContainer(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
    ],
  ),
  child: Text('浮动卡片'),
)

// ❌ 避免的做法：过度使用阴影
ZephyrContainer(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 32,
        offset: Offset(0, 16),
      ),
    ],
  ),
  child: Text('过度阴影'),
)
```

### 2. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整容器样式
class ResponsiveCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ZephyrContainer(
      margin: EdgeInsets.all(screenWidth < 768 ? 8 : 16),
      padding: EdgeInsets.all(screenWidth < 768 ? 16 : 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          screenWidth < 768 ? 8 : 12,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: screenWidth < 768 ? 4 : 8,
          ),
        ],
      ),
      child: Text('响应式卡片'),
    );
  }
}

// ❌ 避免的做法：固定样式不考虑响应式
ZephyrContainer(
  margin: EdgeInsets.all(16),
  padding: EdgeInsets.all(24),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
      ),
    ],
  ),
  child: Text('固定样式卡片'),
)
```

### 3. 性能优化

```dart
// ✅ 好的做法：避免不必要的重绘
class OptimizedContainer extends StatelessWidget {
  final String title;

  const OptimizedContainer({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrContainer(
      decoration: BoxDecoration(
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
      child: Text(title),
    );
  }
}

// ❌ 避免的做法：在build方法中创建复杂的装饰
class UnoptimizedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrContainer(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.purple,
            Colors.red,
            Colors.green,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Text('复杂装饰容器'),
    );
  }
}
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：为交互式容器添加语义标签
ZephyrContainer(
  onTap: () => _handleTap(),
  semanticLabel: '点击按钮',
  child: Text('点击我'),
)

// ✅ 好的做法：为重要容器添加描述
ZephyrContainer(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('重要信息', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('这是重要信息的详细描述'),
    ],
  ),
  semanticLabel: '重要信息容器',
)

// ❌ 避免的做法：缺乏语义信息
ZephyrContainer(
  onTap: () => _handleTap(),
  child: Text('点击我'),
)
```

## 🔄 相关组件

- **ZephyrCard**: 卡片组件
- **ZephyrGrid**: 网格布局组件
- **ZephyrAccordion**: 手风琴组件
- **ZephyrStack**: 堆叠布局组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基础容器功能
- ✅ 丰富的装饰选项
- ✅ 交互和动画支持
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/layout/container/`
**示例路径**: `example/lib/components/container_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日