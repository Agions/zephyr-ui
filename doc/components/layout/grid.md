# ZephyrGrid 网格布局组件

网格布局组件是ZephyrUI布局系统的核心组件，提供了强大的网格布局能力。支持多种网格模式、响应式布局和自定义样式，是构建复杂网格布局的理想选择。

## 🎯 组件概述

### 特性
- **多种网格模式**: 支持固定列数、自适应列数、响应式网格
- **灵活布局**: 支持网格项跨度、间距、对齐等设置
- **响应式设计**: 根据屏幕尺寸自动调整网格布局
- **丰富样式**: 支持网格项装饰、间距、分割线等样式
- **动画支持**: 内置网格项动画和过渡效果
- **主题适配**: 完整的主题系统支持

### 适用场景
- 图片网格展示
- 卡片网格布局
- 数据表格展示
- 仪表板布局
- 产品列表展示
- 图片画廊

## 🚀 基础用法

### 基本网格

```dart
ZephyrGrid(
  crossAxisCount: 3,
  children: [
    ZephyrContainer(
      height: 100,
      color: Colors.blue,
      child: Center(child: Text('项目 1')),
    ),
    ZephyrContainer(
      height: 100,
      color: Colors.green,
      child: Center(child: Text('项目 2')),
    ),
    ZephyrContainer(
      height: 100,
      color: Colors.red,
      child: Center(child: Text('项目 3')),
    ),
    ZephyrContainer(
      height: 100,
      color: Colors.orange,
      child: Center(child: Text('项目 4')),
    ),
  ],
)
```

### 带间距的网格

```dart
ZephyrGrid(
  crossAxisCount: 2,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  children: [
    ZephyrContainer(
      height: 120,
      color: Colors.blue,
      child: Center(child: Text('项目 1')),
    ),
    ZephyrContainer(
      height: 120,
      color: Colors.green,
      child: Center(child: Text('项目 2')),
    ),
    ZephyrContainer(
      height: 120,
      color: Colors.red,
      child: Center(child: Text('项目 3')),
    ),
    ZephyrContainer(
      height: 120,
      color: Colors.orange,
      child: Center(child: Text('项目 4')),
    ),
  ],
)
```

### 自适应网格

```dart
ZephyrGrid.builder(
  maxCrossAxisExtent: 200,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  itemCount: 10,
  itemBuilder: (context, index) {
    return ZephyrContainer(
      height: 150,
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(
        child: Text(
          '项目 ${index + 1}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  },
)
```

### 网格项跨度

```dart
ZephyrGrid(
  crossAxisCount: 4,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  children: [
    ZephyrGridItem(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: ZephyrContainer(
        color: Colors.blue,
        child: Center(child: Text('大项目')),
      ),
    ),
    ZephyrGridItem(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: ZephyrContainer(
        color: Colors.green,
        child: Center(child: Text('小项目 1')),
      ),
    ),
    ZephyrGridItem(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: ZephyrContainer(
        color: Colors.red,
        child: Center(child: Text('小项目 2')),
      ),
    ),
    ZephyrGridItem(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: ZephyrContainer(
        color: Colors.orange,
        child: Center(child: Text('横项目')),
      ),
    ),
  ],
)
```

## 🎨 样式定制

### 网格装饰

```dart
ZephyrGrid(
  crossAxisCount: 3,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  decoration: BoxDecoration(
    color: Colors.grey[100],
    borderRadius: BorderRadius.circular(12),
  ),
  padding: EdgeInsets.all(16),
  children: List.generate(6, (index) {
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
      padding: EdgeInsets.all(16),
      child: Center(child: Text('项目 ${index + 1}')),
    );
  }),
)
```

### 网格对齐

```dart
Column(
  children: [
    Text('左对齐'),
    SizedBox(height: 8),
    ZephyrGrid(
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      alignment: AlignmentDirectional.topStart,
      children: _buildGridItems(6),
    ),
    
    SizedBox(height: 24),
    
    Text('居中对齐'),
    SizedBox(height: 8),
    ZephyrGrid(
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      alignment: AlignmentDirectional.center,
      children: _buildGridItems(6),
    ),
    
    SizedBox(height: 24),
    
    Text('右对齐'),
    SizedBox(height: 8),
    ZephyrGrid(
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      alignment: AlignmentDirectional.topEnd,
      children: _buildGridItems(6),
    ),
  ],
)

List<Widget> _buildGridItems(int count) {
  return List.generate(count, (index) {
    return ZephyrContainer(
      height: 80,
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(
        child: Text(
          '项目 ${index + 1}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  });
}
```

### 网格分割线

```dart
ZephyrGrid(
  crossAxisCount: 3,
  crossAxisSpacing: 0,
  mainAxisSpacing: 0,
  showDividers: true,
  dividerColor: Colors.grey[300],
  dividerThickness: 1,
  children: List.generate(9, (index) {
    return ZephyrContainer(
      height: 100,
      color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.7),
      child: Center(
        child: Text(
          '项目 ${index + 1}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }),
)
```

## 🔧 高级用法

### 响应式网格

```dart
class ResponsiveGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    int crossAxisCount;
    double childAspectRatio;
    double crossAxisSpacing;
    double mainAxisSpacing;
    
    if (screenWidth < 600) {
      // 手机
      crossAxisCount = 2;
      childAspectRatio = 1.0;
      crossAxisSpacing = 8;
      mainAxisSpacing = 8;
    } else if (screenWidth < 900) {
      // 平板
      crossAxisCount = 3;
      childAspectRatio = 1.2;
      crossAxisSpacing = 12;
      mainAxisSpacing = 12;
    } else {
      // 桌面
      crossAxisCount = 4;
      childAspectRatio = 1.3;
      crossAxisSpacing = 16;
      mainAxisSpacing = 16;
    }
    
    return ZephyrGrid.builder(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      itemCount: 12,
      itemBuilder: (context, index) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.grid_view,
                size: 32,
                color: Colors.primaries[index % Colors.primaries.length],
              ),
              SizedBox(height: 8),
              Text(
                '项目 ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                '${screenWidth < 600 ? "手机" : screenWidth < 900 ? "平板" : "桌面"}视图',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

### 可拖拽网格

```dart
class DraggableGrid extends StatefulWidget {
  @override
  _DraggableGridState createState() => _DraggableGridState();
}

class _DraggableGridState extends State<DraggableGrid> {
  List<String> _items = List.generate(9, (index) => '项目 ${index + 1}');
  int? _draggedIndex;

  @override
  Widget build(BuildContext context) {
    return ZephyrGrid(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(_items.length, (index) {
        final isDragged = _draggedIndex == index;
        
        return LongPressDraggable<String>(
          data: _items[index],
          onDragStarted: () => setState(() => _draggedIndex = index),
          onDragEnd: (details) => setState(() => _draggedIndex = null),
          feedback: Material(
            color: Colors.transparent,
            child: ZephyrContainer(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _items[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          childWhenDragging: ZephyrContainer(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: DragTarget<String>(
            onWillAccept: (data) => data != _items[index],
            onAccept: (data) {
              setState(() {
                final draggedIndex = _items.indexOf(data);
                _items.removeAt(draggedIndex);
                _items.insert(index, data);
              });
            },
            builder: (context, candidateData, rejectedData) {
              return ZephyrContainer(
                height: 100,
                decoration: BoxDecoration(
                  color: isDragged ? Colors.blue[100] : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: candidateData.isNotEmpty ? Colors.blue : Colors.grey[300]!,
                    width: candidateData.isNotEmpty ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    _items[index],
                    style: TextStyle(
                      color: isDragged ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
```

### 瀑布流网格

```dart
class MasonryGrid extends StatelessWidget {
  final List<String> _items = List.generate(12, (index) => '项目 ${index + 1}');
  
  @override
  Widget build(BuildContext context) {
    return ZephyrGrid.builder(
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final heights = [100, 150, 200, 120, 180, 140];
        final height = heights[index % heights.length];
        
        return ZephyrContainer(
          height: height.toDouble(),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.7),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _items[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '这是项目 ${index + 1} 的描述文本',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

### 带标题的网格

```dart
class TitledGrid extends StatelessWidget {
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
          // 网格标题
          ZephyrContainer(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '网格标题',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addItem(),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () => _refreshGrid(),
                ),
              ],
            ),
          ),
          // 网格内容
          Expanded(
            child: ZephyrGrid.builder(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              padding: EdgeInsets.all(16),
              itemCount: 9,
              itemBuilder: (context, index) {
                return ZephyrContainer(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.grid_view,
                        size: 32,
                        color: Colors.primaries[index % Colors.primaries.length],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '项目 ${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  void _addItem() {
    // 添加新项目的逻辑
  }
  
  void _refreshGrid() {
    // 刷新网格的逻辑
  }
}
```

### 带分页的网格

```dart
class PaginatedGrid extends StatefulWidget {
  @override
  _PaginatedGridState createState() => _PaginatedGridState();
}

class _PaginatedGridState extends State<PaginatedGrid> {
  final int _itemsPerPage = 6;
  int _currentPage = 1;
  final List<String> _allItems = List.generate(30, (index) => '项目 ${index + 1}');
  
  List<String> get _currentItems {
    final start = (_currentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;
    return _allItems.sublist(start, end.clamp(0, _allItems.length));
  }
  
  int get _totalPages => (_allItems.length / _itemsPerPage).ceil();

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
        children: [
          // 网格内容
          Expanded(
            child: ZephyrGrid.builder(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              padding: EdgeInsets.all(16),
              itemCount: _currentItems.length,
              itemBuilder: (context, index) {
                return ZephyrContainer(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.grid_view,
                        size: 32,
                        color: Colors.primaries[index % Colors.primaries.length],
                      ),
                      SizedBox(height: 8),
                      Text(
                        _currentItems[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // 分页控制
          ZephyrContainer(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: _currentPage > 1
                      ? () => setState(() => _currentPage--)
                      : null,
                ),
                SizedBox(width: 16),
                Text(
                  '第 $_currentPage 页，共 $_totalPages 页',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: _currentPage < _totalPages
                      ? () => setState(() => _currentPage++)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrGrid()

```dart
const ZephyrGrid({
  Key? key,
  required List<Widget> children,
  int crossAxisCount = 2,
  double mainAxisSpacing = 0,
  double crossAxisSpacing = 0,
  double childAspectRatio = 1.0,
  EdgeInsetsGeometry? padding,
  Decoration? decoration,
  AlignmentGeometry alignment = AlignmentDirectional.topStart,
  bool showDividers = false,
  Color? dividerColor,
  double dividerThickness = 1,
  double? maxCrossAxisExtent,
  bool shrinkWrap = false,
  ScrollPhysics? physics,
  bool addAutomaticKeepAlives = true,
  bool addRepaintBoundaries = true,
  bool addSemanticIndexes = true,
  Duration? animationDuration,
  Curve? animationCurve,
})
```

**参数说明：**
- `children`: 网格子组件列表
- `crossAxisCount`: 横轴子组件数量
- `mainAxisSpacing`: 主轴间距
- `crossAxisSpacing`: 横轴间距
- `childAspectRatio`: 子组件宽高比
- `padding`: 内边距
- `decoration`: 网格装饰
- `alignment`: 对齐方式
- `showDividers`: 是否显示分割线
- `dividerColor`: 分割线颜色
- `dividerThickness`: 分割线厚度
- `maxCrossAxisExtent`: 最大横轴范围
- `shrinkWrap`: 是否收缩包装
- `physics`: 滚动物理效果
- `addAutomaticKeepAlives`: 是否添加自动保持活跃
- `addRepaintBoundaries`: 是否添加重绘边界
- `addSemanticIndexes`: 是否添加语义索引
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线

#### ZephyrGrid.builder()

```dart
ZephyrGrid.builder({
  Key? key,
  required IndexedWidgetBuilder itemBuilder,
  required int itemCount,
  int crossAxisCount = 2,
  double mainAxisSpacing = 0,
  double crossAxisSpacing = 0,
  double childAspectRatio = 1.0,
  EdgeInsetsGeometry? padding,
  Decoration? decoration,
  AlignmentGeometry alignment = AlignmentDirectional.topStart,
  bool showDividers = false,
  Color? dividerColor,
  double dividerThickness = 1,
  double? maxCrossAxisExtent,
  bool shrinkWrap = false,
  ScrollPhysics? physics,
  bool addAutomaticKeepAlives = true,
  bool addRepaintBoundaries = true,
  bool addSemanticIndexes = true,
  Duration? animationDuration,
  Curve? animationCurve,
})
```

#### ZephyrGridItem()

```dart
const ZephyrGridItem({
  Key? key,
  required Widget child,
  int crossAxisCellCount = 1,
  int mainAxisCellCount = 1,
  EdgeInsetsGeometry? margin,
  Decoration? decoration,
})
```

### 静态方法

#### ZephyrGrid.responsive()

```dart
static Widget responsive({
  Key? key,
  required List<Widget> children,
  int mobileCrossAxisCount = 2,
  int tabletCrossAxisCount = 3,
  int desktopCrossAxisCount = 4,
  double mobileMainAxisSpacing = 8,
  double tabletMainAxisSpacing = 12,
  double desktopMainAxisSpacing = 16,
  double mobileCrossAxisSpacing = 8,
  double tabletCrossAxisSpacing = 12,
  double desktopCrossAxisSpacing = 16,
})
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrGridTheme(
        defaultCrossAxisCount: 3,
        defaultMainAxisSpacing: 16,
        defaultCrossAxisSpacing: 16,
        defaultChildAspectRatio: 1.0,
        defaultPadding: EdgeInsets.all(16),
        defaultDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        defaultItemDecoration: BoxDecoration(
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
        dividerColor: Colors.grey[300],
        dividerThickness: 1,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultCrossAxisCount`: 默认横轴子组件数量
- `defaultMainAxisSpacing`: 默认主轴间距
- `defaultCrossAxisSpacing`: 默认横轴间距
- `defaultChildAspectRatio`: 默认子组件宽高比
- `defaultPadding`: 默认内边距
- `defaultDecoration`: 默认网格装饰
- `defaultItemDecoration`: 默认网格项装饰
- `dividerColor`: 分割线颜色
- `dividerThickness`: 分割线厚度
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线

## 🏆 最佳实践

### 1. 合理的网格列数

```dart
// ✅ 好的做法：根据屏幕尺寸设置合适的列数
class ResponsiveColumnGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : (screenWidth < 900 ? 3 : 4);
    
    return ZephyrGrid(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: _buildItems(),
    );
  }
}

// ❌ 避免的做法：固定列数不考虑响应式
ZephyrGrid(
  crossAxisCount: 4, // 在手机上可能太拥挤
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  children: _buildItems(),
)
```

### 2. 性能优化

```dart
// ✅ 好的做法：使用builder模式减少内存使用
ZephyrGrid.builder(
  crossAxisCount: 3,
  itemCount: 1000,
  itemBuilder: (context, index) {
    return ZephyrContainer(
      height: 100,
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(child: Text('项目 ${index + 1}')),
    );
  },
)

// ❌ 避免的做法：为大量项目使用children参数
ZephyrGrid(
  crossAxisCount: 3,
  children: List.generate(1000, (index) {
    return ZephyrContainer(
      height: 100,
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(child: Text('项目 ${index + 1}')),
    );
  }),
)
```

### 3. 合理的间距设置

```dart
// ✅ 好的做法：根据使用场景设置合适的间距
ZephyrGrid(
  crossAxisCount: 3,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  children: _buildCards(),
)

// ✅ 好的做法：为密集网格设置较小的间距
ZephyrGrid(
  crossAxisCount: 4,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  children: _buildIcons(),
)

// ❌ 避免的做法：间距设置不合理
ZephyrGrid(
  crossAxisCount: 3,
  crossAxisSpacing: 0, // 没有间距，看起来拥挤
  mainAxisSpacing: 0,
  children: _buildCards(),
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：为网格项添加语义标签
ZephyrGrid.builder(
  crossAxisCount: 3,
  itemCount: 6,
  itemBuilder: (context, index) {
    return ZephyrGridItem(
      child: ZephyrContainer(
        semanticLabel: '项目 ${index + 1}',
        child: Center(child: Text('项目 ${index + 1}')),
      ),
    );
  },
)

// ✅ 好的做法：为交互式网格项添加描述
ZephyrGrid.builder(
  crossAxisCount: 3,
  itemCount: 6,
  itemBuilder: (context, index) {
    return ZephyrGridItem(
      child: GestureDetector(
        onTap: () => _handleItemTap(index),
        child: ZephyrContainer(
          semanticLabel: '可点击的项目 ${index + 1}',
          child: Center(child: Text('项目 ${index + 1}')),
        ),
      ),
    );
  },
)
```

## 🔄 相关组件

- **ZephyrContainer**: 容器组件
- **ZephyrAccordion**: 手风琴组件
- **ZephyrList**: 列表组件
- **ZephyrStack**: 堆叠布局组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基础网格布局
- ✅ 支持响应式网格
- ✅ 支持网格项跨度
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/layout/grid/`
**示例路径**: `example/lib/components/grid_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日