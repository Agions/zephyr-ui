# ZephyrPagination 分页组件

分页组件是ZephyrUI导航系统的重要组件，提供了高效的数据分页导航功能。支持多种分页模式、自定义样式和交互方式，是构建数据列表、表格展示、搜索结果等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种分页模式**: 支持数字、箭头、跳转等多种分页模式
- **灵活布局**: 支持水平和垂直布局，自定义位置和样式
- **丰富交互**: 支持点击、键盘导航、批量操作等交互
- **响应式设计**: 根据屏幕尺寸自动调整分页控件
- **性能优化**: 支持虚拟化和延迟加载
- **主题适配**: 完整的主题系统支持

### 适用场景
- 数据表格分页
- 搜索结果分页
- 图片列表分页
- 文章列表分页
- 商品列表分页
- 用户列表分页

## 🚀 基础用法

### 基本分页

```dart
class BasicPaginationExample extends StatefulWidget {
  @override
  _BasicPaginationExampleState createState() => _BasicPaginationExampleState();
}

class _BasicPaginationExampleState extends State<BasicPaginationExample> {
  int _currentPage = 1;
  final int _totalItems = 100;
  final int _itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本分页'),
      ),
      body: Column(
        children: [
          // 数据展示区域
          Expanded(
            child: _buildDataList(),
          ),
          // 分页控件
          ZephyrPagination(
            currentPage: _currentPage,
            totalItems: _totalItems,
            itemsPerPage: _itemsPerPage,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDataList() {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = math.min(startIndex + _itemsPerPage, _totalItems);
    
    return ListView.builder(
      itemCount: endIndex - startIndex,
      itemBuilder: (context, index) {
        final actualIndex = startIndex + index;
        return ListTile(
          title: Text('数据项 ${actualIndex + 1}'),
          subtitle: Text('这是第 ${actualIndex + 1} 条数据'),
        );
      },
    );
  }
}
```

### 数字分页

```dart
class NumberPaginationExample extends StatefulWidget {
  @override
  _NumberPaginationExampleState createState() => _NumberPaginationExampleState();
}

class _NumberPaginationExampleState extends State<NumberPaginationExample> {
  int _currentPage = 1;
  final int _totalPages = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数字分页'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                '当前页: $_currentPage / $_totalPages',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          // 数字分页
          ZephyrPagination(
            currentPage: _currentPage,
            totalPages: _totalPages,
            type: ZephyrPaginationType.number,
            showFirstLast: true,
            showPrevNext: true,
            maxVisiblePages: 7,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
          ),
        ],
      ),
    );
  }
}
```

### 简约分页

```dart
class SimplePaginationExample extends StatefulWidget {
  @override
  _SimplePaginationExampleState createState() => _SimplePaginationExampleState();
}

class _SimplePaginationExampleState extends State<SimplePaginationExample> {
  int _currentPage = 1;
  final int _totalItems = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简约分页'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
              itemCount: 9, // 每页显示9个
              itemBuilder: (context, index) {
                return Card(
                  child: Center(
                    child: Text('项目 ${(_currentPage - 1) * 9 + index + 1}'),
                  ),
                );
              },
            ),
          ),
          // 简约分页
          ZephyrPagination(
            currentPage: _currentPage,
            totalItems: _totalItems,
            itemsPerPage: 9,
            type: ZephyrPaginationType.simple,
            showPageInfo: true,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
          ),
        ],
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义分页样式

```dart
class CustomPaginationExample extends StatefulWidget {
  @override
  _CustomPaginationExampleState createState() => _CustomPaginationExampleState();
}

class _CustomPaginationExampleState extends State<CustomPaginationExample> {
  int _currentPage = 1;
  final int _totalPages = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义分页样式'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '第 $_currentPage 页内容',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          // 自定义样式分页
          ZephyrPagination(
            currentPage: _currentPage,
            totalPages: _totalPages,
            type: ZephyrPaginationType.number,
            style: ZephyrPaginationStyle(
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              selectedButtonStyle: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              disabledButtonStyle: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.grey[600],
              ),
              pageInfoStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              spacing: 8,
            ),
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
          ),
        ],
      ),
    );
  }
}
```

### 紧凑型分页

```dart
class CompactPaginationExample extends StatefulWidget {
  @override
  _CompactPaginationExampleState createState() => _CompactPaginationExampleState();
}

class _CompactPaginationExampleState extends State<CompactPaginationExample> {
  int _currentPage = 1;
  final int _totalItems = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紧凑型分页'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20, // 每页20条
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  title: Text('列表项 ${(_currentPage - 1) * 20 + index + 1}'),
                  trailing: Icon(Icons.chevron_right),
                );
              },
            ),
          ),
          // 紧凑型分页
          ZephyrPagination(
            currentPage: _currentPage,
            totalItems: _totalItems,
            itemsPerPage: 20,
            type: ZephyrPaginationType.compact,
            showPageInfo: true,
            showPageSizeSelector: true,
            pageSizeOptions: [10, 20, 50, 100],
            onPageSizeChanged: (pageSize) {
              // 处理每页条数变化
              print('每页条数: $pageSize');
            },
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
          ),
        ],
      ),
    );
  }
}
```

## 🔧 高级用法

### 带跳转的分页

```dart
class JumpPaginationExample extends StatefulWidget {
  @override
  _JumpPaginationExampleState createState() => _JumpPaginationExampleState();
}

class _JumpPaginationExampleState extends State<JumpPaginationExample> {
  int _currentPage = 1;
  final int _totalPages = 100;
  final TextEditingController _jumpController = TextEditingController();

  @override
  void dispose() {
    _jumpController.dispose();
    super.dispose();
  }

  void _handleJump() {
    final page = int.tryParse(_jumpController.text);
    if (page != null && page >= 1 && page <= _totalPages) {
      setState(() => _currentPage = page);
      _jumpController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请输入有效的页码 (1-$_totalPages)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带跳转的分页'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                '第 $_currentPage 页',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // 带跳转的分页
          ZephyrPagination(
            currentPage: _currentPage,
            totalPages: _totalPages,
            type: ZephyrPaginationType.number,
            showJumpInput: true,
            jumpInputDecoration: InputDecoration(
              labelText: '跳转到',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            jumpButtonText: '跳转',
            maxVisiblePages: 5,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
            onJumpSubmitted: (page) {
              _handleJump();
            },
          ),
        ],
      ),
    );
  }
}
```

### 带加载状态的分页

```dart
class LoadingPaginationExample extends StatefulWidget {
  @override
  _LoadingPaginationExampleState createState() => _LoadingPaginationExampleState();
}

class _LoadingPaginationExampleState extends State<LoadingPaginationExample> {
  int _currentPage = 1;
  bool _isLoading = false;
  final int _totalPages = 10;

  Future<void> _handlePageChange(int page) async {
    setState(() {
      _isLoading = true;
      _currentPage = page;
    });

    // 模拟数据加载
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带加载状态的分页'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('加载第 $_currentPage 页数据...'),
                      ],
                    ),
                  )
                : Center(
                    child: Container(
                      padding: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '第 $_currentPage 页数据已加载',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
          // 带加载状态的分页
          ZephyrPagination(
            currentPage: _currentPage,
            totalPages: _totalPages,
            type: ZephyrPaginationType.number,
            loading: _isLoading,
            disabled: _isLoading,
            showFirstLast: true,
            showPrevNext: true,
            maxVisiblePages: 7,
            onPageChanged: _isLoading ? null : _handlePageChange,
          ),
        ],
      ),
    );
  }
}
```

### 带统计信息的分页

```dart
class StatsPaginationExample extends StatefulWidget {
  @override
  _StatsPaginationExampleState createState() => _StatsPaginationExampleState();
}

class _StatsPaginationExampleState extends State<StatsPaginationExample> {
  int _currentPage = 1;
  final int _totalItems = 1000;
  final int _itemsPerPage = 20;

  @override
  Widget build(BuildContext context) {
    final startIndex = (_currentPage - 1) * _itemsPerPage + 1;
    final endIndex = math.min(_currentPage * _itemsPerPage, _totalItems);
    final totalPages = (_totalItems / _itemsPerPage).ceil();

    return Scaffold(
      appBar: AppBar(
        title: Text('带统计信息的分页'),
      ),
      body: Column(
        children: [
          // 统计信息
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '显示 $startIndex - $endIndex 条，共 $_totalItems 条',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '第 $_currentPage / $totalPages 页',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          // 数据区域
          Expanded(
            child: ListView.builder(
              itemCount: _itemsPerPage,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('数据项 $startIndex'),
                  subtitle: Text('这是第 $startIndex 条数据的详细信息'),
                );
              },
            ),
          ),
          // 带统计信息的分页
          ZephyrPagination(
            currentPage: _currentPage,
            totalItems: _totalItems,
            itemsPerPage: _itemsPerPage,
            type: ZephyrPaginationType.advanced,
            showPageInfo: true,
            showTotalItems: true,
            showPageSizeSelector: true,
            pageSizeOptions: [10, 20, 50, 100],
            pageInfoFormat: '第 {current} / {total} 页',
            totalItemsFormat: '共 {total} 条',
            onPageSizeChanged: (pageSize) {
              print('每页条数变更为: $pageSize');
            },
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
          ),
        ],
      ),
    );
  }
}
```

### 响应式分页

```dart
class ResponsivePaginationExample extends StatefulWidget {
  @override
  _ResponsivePaginationExampleState createState() => _ResponsivePaginationExampleState();
}

class _ResponsivePaginationExampleState extends State<ResponsivePaginationExample> {
  int _currentPage = 1;
  final int _totalPages = 15;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // 根据屏幕宽度调整分页样式
    ZephyrPaginationType paginationType;
    int maxVisiblePages;
    
    if (screenWidth < 600) {
      paginationType = ZephyrPaginationType.simple;
      maxVisiblePages = 3;
    } else if (screenWidth < 900) {
      paginationType = ZephyrPaginationType.compact;
      maxVisiblePages = 5;
    } else {
      paginationType = ZephyrPaginationType.number;
      maxVisiblePages = 7;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('响应式分页'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '屏幕宽度: ${screenWidth.round()}px',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '分页类型: ${paginationType.toString().split('.').last}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '第 $_currentPage 页',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // 响应式分页
          ZephyrPagination(
            currentPage: _currentPage,
            totalPages: _totalPages,
            type: paginationType,
            maxVisiblePages: maxVisiblePages,
            showFirstLast: screenWidth > 600,
            showPrevNext: true,
            showPageInfo: true,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
          ),
        ],
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrPagination()

```dart
const ZephyrPagination({
  Key? key,
  required int currentPage,
  int? totalItems,
  int? totalPages,
  int itemsPerPage = 10,
  ZephyrPaginationType type = ZephyrPaginationType.number,
  ValueChanged<int>? onPageChanged,
  ValueChanged<int>? onPageSizeChanged,
  ValueChanged<int>? onJumpSubmitted,
  ZephyrPaginationStyle? style,
  bool showFirstLast = false,
  bool showPrevNext = true,
  bool showPageInfo = false,
  bool showTotalItems = false,
  bool showPageSizeSelector = false,
  bool showJumpInput = false,
  List<int> pageSizeOptions = const [10, 20, 50, 100],
  int maxVisiblePages = 7,
  String? pageInfoFormat,
  String? totalItemsFormat,
  InputDecoration? jumpInputDecoration,
  String? jumpButtonText,
  bool loading = false,
  bool disabled = false,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `currentPage`: 当前页码
- `totalItems`: 总条目数
- `totalPages`: 总页数
- `itemsPerPage`: 每页条目数
- `type`: 分页类型
- `onPageChanged`: 页码变化回调
- `onPageSizeChanged`: 每页条数变化回调
- `onJumpSubmitted`: 跳转提交回调
- `style`: 分页样式
- `showFirstLast`: 是否显示首页/末页按钮
- `showPrevNext`: 是否显示上一页/下一页按钮
- `showPageInfo`: 是否显示页码信息
- `showTotalItems`: 是否显示总条目数
- `showPageSizeSelector`: 是否显示每页条数选择器
- `showJumpInput`: 是否显示跳转输入框
- `pageSizeOptions`: 每页条数选项
- `maxVisiblePages`: 最大可见页码数
- `pageInfoFormat`: 页码信息格式
- `totalItemsFormat`: 总条目数格式
- `jumpInputDecoration`: 跳转输入框装饰
- `jumpButtonText`: 跳转按钮文本
- `loading`: 是否正在加载
- `disabled`: 是否禁用
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 枚举类型

#### ZephyrPaginationType

```dart
enum ZephyrPaginationType {
  number,    // 数字分页
  simple,    // 简约分页
  compact,   // 紧凑分页
  advanced,  // 高级分页
}
```

### 样式类

#### ZephyrPaginationStyle

```dart
class ZephyrPaginationStyle {
  final ButtonStyle? buttonStyle;
  final ButtonStyle? selectedButtonStyle;
  final ButtonStyle? disabledButtonStyle;
  final TextStyle? pageInfoStyle;
  final TextStyle? totalItemsStyle;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BoxDecoration? decoration;
  final double? borderRadius;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrPaginationTheme(
        defaultType: ZephyrPaginationType.number,
        defaultItemsPerPage: 10,
        defaultPageSizeOptions: [10, 20, 50, 100],
        defaultMaxVisiblePages: 7,
        defaultButtonStyle: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        defaultSelectedButtonStyle: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
        defaultDisabledButtonStyle: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          foregroundColor: Colors.grey[600],
        ),
        defaultPageInfoStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
        spacing: 8,
        padding: EdgeInsets.all(16),
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeInOut,
        hoverColor: Colors.grey.withOpacity(0.1),
        focusColor: Colors.blue.withOpacity(0.1),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultType`: 默认分页类型
- `defaultItemsPerPage`: 默认每页条数
- `defaultPageSizeOptions`: 默认每页条数选项
- `defaultMaxVisiblePages`: 默认最大可见页码数
- `defaultButtonStyle`: 默认按钮样式
- `defaultSelectedButtonStyle`: 默认选中按钮样式
- `defaultDisabledButtonStyle`: 默认禁用按钮样式
- `defaultPageInfoStyle`: 默认页码信息样式
- `spacing`: 间距
- `padding`: 内边距
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 选择合适的分页类型

```dart
// ✅ 好的做法：桌面端使用数字分页
ZephyrPagination(
  type: ZephyrPaginationType.number,
  currentPage: _currentPage,
  totalPages: _totalPages,
  onPageChanged: _handlePageChange,
)

// ✅ 好的做法：移动端使用简约分页
ZephyrPagination(
  type: ZephyrPaginationType.simple,
  currentPage: _currentPage,
  totalPages: _totalPages,
  onPageChanged: _handlePageChange,
)

// ❌ 避免的做法：移动端使用复杂的数字分页
ZephyrPagination(
  type: ZephyrPaginationType.number, // 移动端屏幕空间有限
  maxVisiblePages: 10, // 显示过多页码
  currentPage: _currentPage,
  totalPages: _totalPages,
  onPageChanged: _handlePageChange,
)
```

### 2. 合理的每页条数

```dart
// ✅ 好的做法：根据内容类型设置合适的每页条数
ZephyrPagination(
  itemsPerPage: 10, // 适合表格数据
  currentPage: _currentPage,
  totalItems: _totalItems,
  onPageChanged: _handlePageChange,
)

// ✅ 好的做法：图片列表使用较多条数
ZephyrPagination(
  itemsPerPage: 20, // 适合图片网格
  currentPage: _currentPage,
  totalItems: _totalItems,
  onPageChanged: _handlePageChange,
)

// ❌ 避免的做法：每页条数过多
ZephyrPagination(
  itemsPerPage: 100, // 加载时间过长，用户体验差
  currentPage: _currentPage,
  totalItems: _totalItems,
  onPageChanged: _handlePageChange,
)
```

### 3. 性能优化

```dart
// ✅ 好的做法：使用状态管理避免不必要的重建
class OptimizedPagination extends StatefulWidget {
  @override
  _OptimizedPaginationState createState() => _OptimizedPaginationState();
}

class _OptimizedPaginationState extends State<OptimizedPagination> {
  int _currentPage = 1;
  List<dynamic> _cachedData = {};
  final Map<int, List<dynamic>> _pageCache = {};

  Future<List<dynamic>> _loadPageData(int page) async {
    if (_pageCache.containsKey(page)) {
      return _pageCache[page]!;
    }
    
    final data = await _fetchDataFromAPI(page);
    _pageCache[page] = data;
    return data;
  }

  void _handlePageChange(int page) {
    setState(() => _currentPage = page);
  }
}

// ✅ 好的做法：提供加载状态
ZephyrPagination(
  loading: _isLoading,
  disabled: _isLoading,
  currentPage: _currentPage,
  totalPages: _totalPages,
  onPageChanged: _isLoading ? null : _handlePageChange,
)

// ❌ 避免的做法：没有加载状态
ZephyrPagination(
  currentPage: _currentPage,
  totalPages: _totalPages,
  onPageChanged: _handlePageChange, // 用户不知道正在加载
)
```

### 4. 用户体验

```dart
// ✅ 好的做法：显示分页统计信息
ZephyrPagination(
  showPageInfo: true,
  showTotalItems: true,
  pageInfoFormat: '第 {current} / {total} 页',
  totalItemsFormat: '共 {total} 条',
  currentPage: _currentPage,
  totalItems: _totalItems,
  onPageChanged: _handlePageChange,
)

// ✅ 好的做法：提供快速跳转
ZephyrPagination(
  showJumpInput: true,
  jumpButtonText: '跳转',
  currentPage: _currentPage,
  totalPages: _totalPages,
  onPageChanged: _handlePageChange,
)

// ❌ 避免的做法：缺乏导航便利性
ZephyrPagination(
  type: ZephyrPaginationType.simple, // 功能过于简单
  showPageInfo: false, // 不显示页码信息
  currentPage: _currentPage,
  totalPages: _totalPages,
  onPageChanged: _handlePageChange,
)
```

## 🔄 相关组件

- **ZephyrTable**: 表格组件
- **ZephyrList**: 列表组件
- **ZephyrDataGrid**: 数据网格组件
- **ZephyrStepper**: 步骤条组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种分页类型
- ✅ 支持自定义样式
- ✅ 支持响应式设计
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/navigation/pagination/`
**示例路径**: `example/lib/components/pagination_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日