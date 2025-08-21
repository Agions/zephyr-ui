# ZephyrCardGrid 卡片网格组件

卡片网格组件是ZephyrUI展示系统中的常用组件，提供了灵活的卡片布局展示功能。支持多种网格模式、自定义卡片样式和交互方式，是构建产品展示、图片画廊、内容聚合等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种网格模式**: 支持固定网格、响应式网格、瀑布流网格等多种模式
- **灵活布局**: 支持自定义列数、间距、卡片大小等
- **丰富交互**: 支持点击、悬停、滑动、拖拽等交互
- **自定义样式**: 支持自定义卡片样式、网格装饰等
- **性能优化**: 支持懒加载和虚拟化
- **主题适配**: 完整的主题系统支持

### 适用场景
- 产品展示
- 图片画廊
- 内容聚合
- 功能模块展示
- 数据卡片展示
- 仪表板组件

## 🚀 基础用法

### 基本卡片网格

```dart
class BasicCardGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本卡片网格'),
      ),
      body: ZephyrCardGrid(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: EdgeInsets.all(16),
        cards: [
          ZephyrCard(
            title: '产品管理',
            subtitle: '管理产品信息',
            leading: Icon(Icons.inventory_2, color: Colors.blue),
            onTap: () => _navigateTo('products'),
          ),
          ZephyrCard(
            title: '用户管理',
            subtitle: '管理系统用户',
            leading: Icon(Icons.people, color: Colors.green),
            onTap: () => _navigateTo('users'),
          ),
          ZephyrCard(
            title: '订单管理',
            subtitle: '查看和处理订单',
            leading: Icon(Icons.shopping_cart, color: Colors.orange),
            onTap: () => _navigateTo('orders'),
          ),
          ZephyrCard(
            title: '数据分析',
            subtitle: '查看业务数据',
            leading: Icon(Icons.analytics, color: Colors.purple),
            onTap: () => _navigateTo('analytics'),
          ),
        ],
      ),
    );
  }

  void _navigateTo(String route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('导航到: $route')),
    );
  }
}
```

### 响应式卡片网格

```dart
class ResponsiveCardGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('响应式卡片网格'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 根据屏幕宽度计算列数
          int crossAxisCount;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 2;
          } else {
            crossAxisCount = 1;
          }

          return ZephyrCardGrid(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            padding: EdgeInsets.all(16),
            cards: List.generate(8, (index) {
              return ZephyrCard(
                title: '功能模块 ${index + 1}',
                subtitle: '这是第 ${index + 1} 个功能模块的描述',
                leading: Icon(Icons.apps, color: Colors.blue),
                onTap: () => _showModuleDetails(index + 1),
              );
            }),
          );
        },
      ),
    );
  }

  void _showModuleDetails(int moduleNumber) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('查看功能模块 $moduleNumber 的详情')),
    );
  }
}
```

### 瀑布流卡片网格

```dart
class MasonryCardGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('瀑布流卡片网格'),
      ),
      body: ZephyrCardGrid(
        type: ZephyrCardGridType.masonry,
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: EdgeInsets.all(16),
        cards: [
          ZephyrCard(
            title: '短标题',
            subtitle: '这是一个简短的描述',
            content: Container(
              height: 100,
              color: Colors.blue[50],
              child: Center(child: Text('短内容')),
            ),
          ),
          ZephyrCard(
            title: '这是一个很长的标题，用来测试长文本的显示效果',
            subtitle: '这个描述也比较长，用来测试多行文本的显示效果。这个描述比较长，用来测试多行文本的显示效果。',
            content: Container(
              height: 200,
              color: Colors.green[50],
              child: Center(child: Text('中等长度内容')),
            ),
          ),
          ZephyrCard(
            title: '中等标题',
            subtitle: '中等长度的描述',
            content: Container(
              height: 300,
              color: Colors.orange[50],
              child: Center(child: Text('长内容')),
            ),
          ),
          ZephyrCard(
            title: '产品特性',
            subtitle: '了解我们产品的核心功能',
            content: Column(
              children: [
                Text('特性1: 高性能'),
                Text('特性2: 易使用'),
                Text('特性3: 可扩展'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义卡片样式

```dart
class CustomCardStyleGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义卡片样式'),
      ),
      body: ZephyrCardGrid(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: EdgeInsets.all(16),
        style: ZephyrCardGridStyle(
          cardStyle: ZephyrCardStyle(
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            elevation: 4,
            padding: EdgeInsets.all(16),
            titleStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            subtitleStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        cards: [
          ZephyrCard(
            title: '蓝色主题',
            subtitle: '使用蓝色装饰',
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.star, color: Colors.white),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue[200]!),
            ),
          ),
          ZephyrCard(
            title: '绿色主题',
            subtitle: '使用绿色装饰',
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.eco, color: Colors.white),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green[200]!),
            ),
          ),
          ZephyrCard(
            title: '橙色主题',
            subtitle: '使用橙色装饰',
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.wb_sunny, color: Colors.white),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange[200]!),
            ),
          ),
          ZephyrCard(
            title: '紫色主题',
            subtitle: '使用紫色装饰',
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.palette, color: Colors.white),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple[200]!),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 圆角卡片网格

```dart
class RoundedCardGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆角卡片网格'),
      ),
      body: ZephyrCardGrid(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: EdgeInsets.all(16),
        style: ZephyrCardGridStyle(
          cardStyle: ZephyrCardStyle(
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            elevation: 6,
            padding: EdgeInsets.all(20),
            titleStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        cards: [
          ZephyrCard(
            title: '设计理念',
            subtitle: '简约而不简单',
            content: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(Icons.design_services, size: 48, color: Colors.blue),
              ),
            ),
          ),
          ZephyrCard(
            title: '用户体验',
            subtitle: '以用户为中心',
            content: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(Icons.sentiment_satisfied, size: 48, color: Colors.green),
              ),
            ),
          ),
          ZephyrCard(
            title: '性能优化',
            subtitle: '快速响应',
            content: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(Icons.speed, size: 48, color: Colors.orange),
              ),
            ),
          ),
          ZephyrCard(
            title: '安全可靠',
            subtitle: '数据保护',
            content: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(Icons.security, size: 48, color: Colors.purple),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 阴影卡片网格

```dart
class ShadowCardGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('阴影卡片网格'),
      ),
      body: ZephyrCardGrid(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        padding: EdgeInsets.all(20),
        cards: [
          ZephyrCard(
            title: '轻度阴影',
            subtitle: 'elevation: 2',
            elevation: 2,
            content: Container(
              height: 100,
              color: Colors.grey[100],
              child: Center(child: Text('内容区域')),
            ),
          ),
          ZephyrCard(
            title: '中度阴影',
            subtitle: 'elevation: 4',
            elevation: 4,
            content: Container(
              height: 100,
              color: Colors.grey[100],
              child: Center(child: Text('内容区域')),
            ),
          ),
          ZephyrCard(
            title: '重度阴影',
            subtitle: 'elevation: 8',
            elevation: 8,
            content: Container(
              height: 100,
              color: Colors.grey[100],
              child: Center(child: Text('内容区域')),
            ),
          ),
          ZephyrCard(
            title: '极重阴影',
            subtitle: 'elevation: 12',
            elevation: 12,
            content: Container(
              height: 100,
              color: Colors.grey[100],
              child: Center(child: Text('内容区域')),
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🔧 高级用法

### 可拖拽卡片网格

```dart
class DraggableCardGridExample extends StatefulWidget {
  @override
  _DraggableCardGridExampleState createState() => _DraggableCardGridExampleState();
}

class _DraggableCardGridExampleState extends State<DraggableCardGridExample> {
  List<ZephyrCard> _cards = [];
  final int _itemCount = 6;

  @override
  void initState() {
    super.initState();
    _initializeCards();
  }

  void _initializeCards() {
    _cards = List.generate(_itemCount, (index) {
      return ZephyrCard(
        key: ValueKey('card_$index'),
        title: '卡片 ${index + 1}',
        subtitle: '可以拖拽重新排序',
        leading: CircleAvatar(
          child: Text('${index + 1}'),
        ),
        onTap: () => _showCardDetails(index + 1),
      );
    });
  }

  void _showCardDetails(int cardNumber) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了卡片 $cardNumber')),
    );
  }

  void _reorderCards(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final card = _cards.removeAt(oldIndex);
      _cards.insert(newIndex, card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可拖拽卡片网格'),
      ),
      body: ZephyrCardGrid(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: EdgeInsets.all(16),
        reorderable: true,
        onReorder: _reorderCards,
        cards: _cards,
      ),
    );
  }
}
```

### 带选择功能的卡片网格

```dart
class SelectableCardGridExample extends StatefulWidget {
  @override
  _SelectableCardGridExampleState createState() => _SelectableCardGridExampleState();
}

class _SelectableCardGridExampleState extends State<SelectableCardGridExample> {
  Set<int> _selectedIndices = {};
  bool _isSelectionMode = false;

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
        if (_selectedIndices.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedIndices.add(index);
        _isSelectionMode = true;
      }
    });
  }

  void _selectAll() {
    setState(() {
      _selectedIndices = Set.from(List.generate(8, (index) => index));
      _isSelectionMode = true;
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedIndices.clear();
      _isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode ? '已选择 ${_selectedIndices.length} 项' : '可选择卡片网格'),
        actions: _isSelectionMode
            ? [
                IconButton(
                  icon: Icon(Icons.select_all),
                  onPressed: _selectedIndices.length < 8 ? _selectAll : null,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('删除了 ${_selectedIndices.length} 个项目')),
                    );
                    _clearSelection();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: _clearSelection,
                ),
              ]
            : null,
      ),
      body: ZephyrCardGrid(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: EdgeInsets.all(16),
        selectable: true,
        selectedIndices: _selectedIndices,
        onSelectionChanged: (indices) {
          setState(() => _selectedIndices = indices);
        },
        cards: List.generate(8, (index) {
          final isSelected = _selectedIndices.contains(index);
          return ZephyrCard(
            title: '功能 ${index + 1}',
            subtitle: isSelected ? '已选中' : '点击选择',
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSelected ? Icons.check : Icons.radio_button_unchecked,
                color: Colors.white,
              ),
            ),
            selected: isSelected,
            onTap: () => _toggleSelection(index),
            decoration: isSelected
                ? BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
          );
        }),
      ),
    );
  }
}
```

### 懒加载卡片网格

```dart
class LazyLoadingCardGridExample extends StatefulWidget {
  @override
  _LazyLoadingCardGridExampleState createState() => _LazyLoadingCardGridExampleState();
}

class _LazyLoadingCardGridExampleState extends State<LazyLoadingCardGridExample> {
  List<ZephyrCard> _cards = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final int _pageSize = 6;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMoreCards();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreCards();
    }
  }

  Future<void> _loadMoreCards() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    // 模拟网络请求
    await Future.delayed(Duration(seconds: 1));
    
    final newCards = List.generate(_pageSize, (index) {
      final cardIndex = (_page - 1) * _pageSize + index;
      return ZephyrCard(
        key: ValueKey('card_$cardIndex'),
        title: '动态卡片 ${cardIndex + 1}',
        subtitle: '这是第 ${cardIndex + 1} 个动态加载的卡片',
        leading: CircleAvatar(
          child: Text('${cardIndex + 1}'),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('点击了动态卡片 ${cardIndex + 1}')),
          );
        },
      );
    });

    setState(() {
      _cards.addAll(newCards);
      _page++;
      _isLoading = false;
      _hasMore = _page <= 5; // 限制最多5页
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('懒加载卡片网格'),
      ),
      body: ZephyrCardGrid(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: EdgeInsets.all(16),
        cards: _cards,
        loadingBuilder: _isLoading
            ? () => Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('加载更多...'),
                    ],
                  ),
                ),
              )
            : null,
        placeholderBuilder: _cards.isEmpty
            ? () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      '暂无卡片',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
```

### 带动画的卡片网格

```dart
class AnimatedCardGridExample extends StatefulWidget {
  @override
  _AnimatedCardGridExampleState createState() => _AnimatedCardGridExampleState();
}

class _AnimatedCardGridExampleState extends State<AnimatedCardGridExample> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带动画的卡片网格'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() => _isExpanded = !_isExpanded);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(_isExpanded ? 8 : 16),
          child: ZephyrCardGrid(
            crossAxisCount: _isExpanded ? 3 : 2,
            mainAxisSpacing: _isExpanded ? 8 : 16,
            crossAxisSpacing: _isExpanded ? 8 : 16,
            cards: [
              ZephyrCard(
                title: '动画卡片 1',
                subtitle: _isExpanded ? '展开状态' : '收起状态',
                elevation: _isExpanded ? 8 : 4,
                animate: true,
                duration: Duration(milliseconds: 500),
              ),
              ZephyrCard(
                title: '动画卡片 2',
                subtitle: _isExpanded ? '展开状态' : '收起状态',
                elevation: _isExpanded ? 8 : 4,
                animate: true,
                duration: Duration(milliseconds: 500),
              ),
              ZephyrCard(
                title: '动画卡片 3',
                subtitle: _isExpanded ? '展开状态' : '收起状态',
                elevation: _isExpanded ? 8 : 4,
                animate: true,
                duration: Duration(milliseconds: 500),
              ),
              ZephyrCard(
                title: '动画卡片 4',
                subtitle: _isExpanded ? '展开状态' : '收起状态',
                elevation: _isExpanded ? 8 : 4,
                animate: true,
                duration: Duration(milliseconds: 500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 带过滤功能的卡片网格

```dart
class FilterableCardGridExample extends StatefulWidget {
  @override
  _FilterableCardGridExampleState createState() => _FilterableCardGridExampleState();
}

class _FilterableCardGridExampleState extends State<FilterableCardGridExample> {
  final TextEditingController _searchController = TextEditingController();
  List<ZephyrCard> _allCards = [];
  List<ZephyrCard> _filteredCards = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _initializeCards();
    _searchController.addListener(_filterCards);
  }

  void _initializeCards() {
    _allCards = [
      ZephyrCard(
        title: '用户管理',
        subtitle: '管理系统用户信息',
        category: '管理',
        leading: Icon(Icons.people, color: Colors.blue),
      ),
      ZephyrCard(
        title: '产品管理',
        subtitle: '管理产品信息',
        category: '管理',
        leading: Icon(Icons.inventory_2, color: Colors.green),
      ),
      ZephyrCard(
        title: '订单管理',
        subtitle: '管理订单信息',
        category: '管理',
        leading: Icon(Icons.shopping_cart, color: Colors.orange),
      ),
      ZephyrCard(
        title: '数据分析',
        subtitle: '查看数据分析',
        category: '分析',
        leading: Icon(Icons.analytics, color: Colors.purple),
      ),
      ZephyrCard(
        title: '报表生成',
        subtitle: '生成业务报表',
        category: '分析',
        leading: Icon(Icons.description, color: Colors.teal),
      ),
      ZephyrCard(
        title: '系统设置',
        subtitle: '配置系统参数',
        category: '设置',
        leading: Icon(Icons.settings, color: Colors.red),
      ),
    ];
    _filteredCards = List.from(_allCards);
  }

  void _filterCards() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty && _selectedCategory == null) {
        _filteredCards = List.from(_allCards);
      } else {
        _filteredCards = _allCards.where((card) {
          final matchesSearch = query.isEmpty ||
              card.title!.toLowerCase().contains(query) ||
              card.subtitle!.toLowerCase().contains(query);
          final matchesCategory = _selectedCategory == null ||
              card.category == _selectedCategory;
          return matchesSearch && matchesCategory;
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带过滤功能的卡片网格'),
      ),
      body: Column(
        children: [
          // 搜索和筛选区域
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              children: [
                // 搜索框
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: '搜索卡片',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // 分类筛选
                Row(
                  children: [
                    Text('分类筛选：'),
                    SizedBox(width: 16),
                    FilterChip(
                      label: Text('全部'),
                      selected: _selectedCategory == null,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? null : _selectedCategory;
                          _filterCards();
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    FilterChip(
                      label: Text('管理'),
                      selected: _selectedCategory == '管理',
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? '管理' : null;
                          _filterCards();
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    FilterChip(
                      label: Text('分析'),
                      selected: _selectedCategory == '分析',
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? '分析' : null;
                          _filterCards();
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    FilterChip(
                      label: Text('设置'),
                      selected: _selectedCategory == '设置',
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? '设置' : null;
                          _filterCards();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 卡片网格
          Expanded(
            child: ZephyrCardGrid(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              padding: EdgeInsets.all(16),
              cards: _filteredCards,
              placeholderBuilder: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      '未找到匹配的卡片',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
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

#### ZephyrCardGrid()

```dart
const ZephyrCardGrid({
  Key? key,
  required List<ZephyrCard> cards,
  int crossAxisCount = 2,
  double mainAxisSpacing = 16,
  double crossAxisSpacing = 16,
  EdgeInsetsGeometry? padding,
  ZephyrCardGridType type = ZephyrCardGridType.regular,
  ZephyrCardGridStyle? style,
  bool reorderable = false,
  ValueChanged<int, int>? onReorder,
  bool selectable = false,
  Set<int>? selectedIndices,
  ValueChanged<Set<int>>? onSelectionChanged,
  Widget Function()? loadingBuilder,
  Widget Function()? placeholderBuilder,
  Widget Function()? errorBuilder,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `cards`: 卡片列表
- `crossAxisCount`: 交叉轴数量
- `mainAxisSpacing`: 主轴间距
- `crossAxisSpacing`: 交叉轴间距
- `padding`: 内边距
- `type`: 网格类型
- `style`: 网格样式
- `reorderable`: 是否可拖拽排序
- `onReorder`: 拖拽排序回调
- `selectable`: 是否可选择
- `selectedIndices`: 已选择的索引
- `onSelectionChanged`: 选择变化回调
- `loadingBuilder`: 加载状态构建器
- `placeholderBuilder`: 空数据占位符构建器
- `errorBuilder`: 错误状态构建器
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 枚举类型

#### ZephyrCardGridType

```dart
enum ZephyrCardGridType {
  regular,  // 常规网格
  masonry,  // 瀑布流网格
  staggered, // 交错网格
}
```

### 样式类

#### ZephyrCardGridStyle

```dart
class ZephyrCardGridStyle {
  final ZephyrCardStyle? cardStyle;
  final EdgeInsetsGeometry? padding;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final Color? backgroundColor;
  final Decoration? decoration;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrCardGridTheme(
        defaultCardStyle: ZephyrCardStyle(
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
          elevation: 2,
          padding: EdgeInsets.all(16),
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          subtitleStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        defaultPadding: EdgeInsets.all(16),
        defaultMainAxisSpacing: 16,
        defaultCrossAxisSpacing: 16,
        defaultBackgroundColor: Colors.grey[50],
        selectedCardStyle: ZephyrCardStyle(
          backgroundColor: Colors.blue[50],
          border: Border.all(color: Colors.blue, width: 2),
        ),
        hoverCardStyle: ZephyrCardStyle(
          elevation: 4,
        ),
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

- `defaultCardStyle`: 默认卡片样式
- `defaultPadding`: 默认内边距
- `defaultMainAxisSpacing`: 默认主轴间距
- `defaultCrossAxisSpacing`: 默认交叉轴间距
- `defaultBackgroundColor`: 默认背景颜色
- `selectedCardStyle`: 选中卡片样式
- `hoverCardStyle`: 悬停卡片样式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的网格布局

```dart
// ✅ 好的做法：根据屏幕尺寸调整列数
class ResponsiveCardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        if (constraints.maxWidth > 1200) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return ZephyrCardGrid(
          crossAxisCount: crossAxisCount,
          cards: _buildCards(),
        );
      },
    );
  }
}

// ✅ 好的做法：使用合适的间距
ZephyrCardGrid(
  crossAxisCount: 2,
  mainAxisSpacing: 16, // 适中的间距
  crossAxisSpacing: 16,
  cards: _buildCards(),
)

// ❌ 避免的做法：固定布局不考虑响应式
ZephyrCardGrid(
  crossAxisCount: 4, // 在小屏幕上可能显示不全
  cards: _buildCards(),
)
```

### 2. 性能优化

```dart
// ✅ 好的做法：使用懒加载处理大量卡片
class LazyCardGrid extends StatefulWidget {
  @override
  _LazyCardGridState createState() => _LazyCardGridState();
}

class _LazyCardGridState extends State<LazyCardGrid> {
  List<ZephyrCard> _cards = [];
  bool _isLoading = false;

  Future<void> _loadMoreCards() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    final newCards = await _fetchCards();
    setState(() {
      _cards.addAll(newCards);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrCardGrid(
      cards: _cards,
      loadingBuilder: _isLoading ? () => _buildLoadingIndicator() : null,
    );
  }
}

// ✅ 好的做法：避免不必要的重建
ZephyrCard(
  key: ValueKey(item['id']), // 使用唯一key优化性能
  title: item['title'],
)

// ❌ 避免的做法：一次性加载大量卡片
ZephyrCardGrid(
  cards: _largeCardList, // 可能导致性能问题
)
```

### 3. 用户体验优化

```dart
// ✅ 好的做法：提供视觉反馈
ZephyrCard(
  title: '可点击卡片',
  onTap: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('卡片被点击')),
    );
  },
  // 提供悬停效果
)

// ✅ 好的做法：支持选择操作
ZephyrCardGrid(
  selectable: true,
  selectedIndices: _selectedIndices,
  onSelectionChanged: _handleSelection,
)

// ✅ 好的做法：为空状态提供提示
ZephyrCardGrid(
  cards: _emptyList,
  placeholderBuilder: () => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
        SizedBox(height: 16),
        Text('暂无卡片'),
      ],
    ),
  ),
)

// ❌ 避免的做法：缺乏用户反馈
ZephyrCard(
  title: '无反馈卡片',
  onTap: () {
    // 没有任何用户反馈
  },
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrCardGrid(
  semanticLabel: '功能模块卡片网格',
  cards: [
    ZephyrCard(
      title: '用户管理',
      semanticLabel: '用户管理功能模块',
      onTap: () => _navigateTo('users'),
    ),
  ],
  enableAccessibilityFeatures: true,
)

// ✅ 好的做法：为操作提供描述
ZephyrCard(
  title: '删除卡片',
  trailing: IconButton(
    icon: Icon(Icons.delete),
    onPressed: () => _deleteCard(),
    tooltip: '删除此卡片',
  ),
)

// ✅ 好的做法：确保足够的点击区域
ZephyrCard(
  padding: EdgeInsets.all(16), // 足够的点击区域
  onTap: _handleTap,
)

// ❌ 避免的做法：缺乏语义信息
ZephyrCardGrid(
  cards: [
    ZephyrCard(
      title: '功能',
      onTap: _handleTap,
      // 缺乏语义信息
    ),
  ],
)
```

## 🔄 相关组件

- **ZephyrCard**: 卡片组件
- **ZephyrGrid**: 网格组件
- **ZephyrList**: 列表组件
- **ZephyrContainer**: 容器组件
- **ZephyrDataGrid**: 数据网格组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种网格模式
- ✅ 支持拖拽和选择
- ✅ 支持懒加载和过滤
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/card_grid/`
**示例路径**: `example/lib/components/card_grid_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日