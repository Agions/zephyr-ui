# ZephyrList 列表组件

列表组件是ZephyrUI展示系统中的基础组件，提供了灵活的数据列表展示功能。支持多种列表模式、自定义样式和交互方式，是构建联系人列表、消息列表、产品列表等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种列表模式**: 支持基本列表、分组列表、可滑动列表等多种模式
- **灵活布局**: 支持水平、垂直、网格等布局方式
- **丰富交互**: 支持点击、长按、滑动、拖拽等交互
- **自定义样式**: 支持自定义列表项样式、分割线、装饰等
- **性能优化**: 支持懒加载和虚拟化
- **主题适配**: 完整的主题系统支持

### 适用场景
- 联系人列表
- 消息列表
- 产品列表
- 设置选项列表
- 文件列表
- 搜索结果列表

## 🚀 基础用法

### 基本列表

```dart
class BasicListExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本列表'),
      ),
      body: ZephyrList(
        items: [
          ZephyrListItem(
            title: '张三',
            subtitle: '软件工程师',
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar1.jpg'),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showUserDetails('张三'),
          ),
          ZephyrListItem(
            title: '李四',
            subtitle: '产品经理',
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar2.jpg'),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showUserDetails('李四'),
          ),
          ZephyrListItem(
            title: '王五',
            subtitle: 'UI设计师',
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar3.jpg'),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showUserDetails('王五'),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('查看 $name 的详情')),
    );
  }
}
```

### 分组列表

```dart
class GroupedListExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分组列表'),
      ),
      body: ZephyrList(
        groupBy: (item) => item['department'],
        groupBuilder: (department) {
          return ZephyrListGroupHeader(
            title: department,
            trailing: Text('${_getDepartmentCount(department)} 人'),
            backgroundColor: Colors.grey[100],
          );
        },
        items: [
          {
            'name': '张三',
            'department': '技术部',
            'position': '前端工程师',
          },
          {
            'name': '李四',
            'department': '技术部',
            'position': '后端工程师',
          },
          {
            'name': '王五',
            'department': '市场部',
            'position': '市场经理',
          },
          {
            'name': '赵六',
            'department': '市场部',
            'position': '销售专员',
          },
          {
            'name': '钱七',
            'department': '人事部',
            'position': 'HR专员',
          },
        ].map((user) => ZephyrListItem(
          title: user['name'],
          subtitle: user['position'],
          leading: CircleAvatar(
            child: Text(user['name'][0]),
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () => _showUserDetails(user['name']),
        )).toList(),
      ),
    );
  }

  int _getDepartmentCount(String department) {
    return users.where((user) => user['department'] == department).length;
  }

  void _showUserDetails(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('查看 $name 的详情')),
    );
  }
}
```

### 可滑动列表

```dart
class SwipeableListExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可滑动列表'),
      ),
      body: ZephyrList(
        items: [
          ZephyrListItem(
            title: '重要邮件',
            subtitle: '来自: boss@company.com',
            leading: Icon(Icons.email, color: Colors.blue),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _openEmail('重要邮件'),
            swipeActions: [
              ZephyrSwipeAction(
                icon: Icon(Icons.archive),
                backgroundColor: Colors.grey,
                label: '归档',
                onPressed: () => _archiveEmail('重要邮件'),
              ),
              ZephyrSwipeAction(
                icon: Icon(Icons.delete),
                backgroundColor: Colors.red,
                label: '删除',
                onPressed: () => _deleteEmail('重要邮件'),
              ),
            ],
          ),
          ZephyrListItem(
            title: '会议通知',
            subtitle: '时间: 今天下午3点',
            leading: Icon(Icons.calendar, color: Colors.green),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _openEvent('会议通知'),
            swipeActions: [
              ZephyrSwipeAction(
                icon: Icon(Icons.check),
                backgroundColor: Colors.green,
                label: '确认',
                onPressed: () => _confirmEvent('会议通知'),
              ),
              ZephyrSwipeAction(
                icon: Icon(Icons.close),
                backgroundColor: Colors.orange,
                label: '拒绝',
                onPressed: () => _declineEvent('会议通知'),
              ),
            ],
          ),
          ZephyrListItem(
            title: '系统更新',
            subtitle: '新版本可用',
            leading: Icon(Icons.system_update, color: Colors.purple),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _openUpdate('系统更新'),
            swipeActions: [
              ZephyrSwipeAction(
                icon: Icon(Icons.download),
                backgroundColor: Colors.blue,
                label: '下载',
                onPressed: () => _downloadUpdate('系统更新'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _archiveEmail(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已归档: $title')),
    );
  }

  void _deleteEmail(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已删除: $title')),
    );
  }

  void _confirmEvent(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已确认: $title')),
    );
  }

  void _declineEvent(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已拒绝: $title')),
    );
  }

  void _downloadUpdate(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('开始下载: $title')),
    );
  }
}
```

### 带选择的列表

```dart
class SelectionListExample extends StatefulWidget {
  @override
  _SelectionListExampleState createState() => _SelectionListExampleState();
}

class _SelectionListExampleState extends State<SelectionListExample> {
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
      _selectedIndices = Set.from(List.generate(10, (index) => index));
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedIndices.clear();
      _isSelectionMode = false;
    });
  }

  void _deleteSelected() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已删除 ${_selectedIndices.length} 个项目')),
    );
    _clearSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode ? '已选择 ${_selectedIndices.length} 项' : '选择列表'),
        actions: _isSelectionMode
            ? [
                IconButton(
                  icon: Icon(Icons.select_all),
                  onPressed: _selectedIndices.length < 10 ? _selectAll : null,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: _deleteSelected,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: _clearSelection,
                ),
              ]
            : null,
      ),
      body: ZephyrList(
        selectionMode: _isSelectionMode ? ZephyrSelectionMode.multiple : ZephyrSelectionMode.none,
        selectedIndices: _selectedIndices,
        onSelectionChanged: (indices) {
          setState(() => _selectedIndices = indices);
        },
        items: List.generate(10, (index) {
          return ZephyrListItem(
            title: '项目 ${index + 1}',
            subtitle: '这是第 ${index + 1} 个项目的描述',
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            trailing: _selectedIndices.contains(index)
                ? Icon(Icons.check_circle, color: Colors.blue)
                : Icon(Icons.chevron_right),
            onTap: () => _toggleSelection(index),
            onLongPress: () => _toggleSelection(index),
          );
        }),
      ),
    );
  }
}
```

## 🎨 样式定制

### 卡片式列表

```dart
class CardListExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片式列表'),
      ),
      body: ZephyrList(
        style: ZephyrListStyle(
          itemStyle: ZephyrListItemStyle(
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.all(16),
          ),
          dividerStyle: ZephyrListDividerStyle(
            showDividers: false,
          ),
        ),
        items: [
          ZephyrListItem(
            title: '产品特性',
            subtitle: '了解我们产品的核心功能',
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.star, color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _showFeatures(),
          ),
          ZephyrListItem(
            title: '用户指南',
            subtitle: '学习如何使用我们的产品',
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.book, color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _showGuide(),
          ),
          ZephyrListItem(
            title: '技术支持',
            subtitle: '获取专业的技术帮助',
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.support, color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _showSupport(),
          ),
        ],
      ),
    );
  }

  void _showFeatures() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('查看产品特性')),
    );
  }

  void _showGuide() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('查看用户指南')),
    );
  }

  void _showSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('查看技术支持')),
    );
  }
}
```

### 紧凑型列表

```dart
class CompactListExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紧凑型列表'),
      ),
      body: ZephyrList(
        style: ZephyrListStyle(
          compact: true,
          itemStyle: ZephyrListItemStyle(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            titleStyle: TextStyle(fontSize: 14),
            subtitleStyle: TextStyle(fontSize: 12),
          ),
          dividerStyle: ZephyrListDividerStyle(
            showDividers: true,
            color: Colors.grey[200],
            thickness: 1,
          ),
        ),
        items: List.generate(20, (index) {
          return ZephyrListItem(
            title: '设置选项 ${index + 1}',
            subtitle: '这是第 ${index + 1} 个设置选项的描述',
            trailing: Switch(
              value: index % 2 == 0,
              onChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('选项 ${index + 1} ${value ? "开启" : "关闭"}')),
                );
              },
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('点击了选项 ${index + 1}')),
              );
            },
          );
        }),
      ),
    );
  }
}
```

### 自定义分割线列表

```dart
class CustomDividerListExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义分割线列表'),
      ),
      body: ZephyrList(
        style: ZephyrListStyle(
          dividerStyle: ZephyrListDividerStyle(
            showDividers: true,
            color: Colors.blue[200],
            thickness: 2,
            indent: 16,
            endIndent: 16,
            dividerBuilder: (context) {
              return Container(
                height: 2,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ),
                ),
              );
            },
          ),
        ),
        items: [
          ZephyrListItem(
            title: '个人信息',
            subtitle: '管理您的个人资料',
            leading: Icon(Icons.person),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _navigateTo('profile'),
          ),
          ZephyrListItem(
            title: '账户设置',
            subtitle: '管理账户和安全设置',
            leading: Icon(Icons.account_circle),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _navigateTo('account'),
          ),
          ZephyrListItem(
            title: '隐私设置',
            subtitle: '控制您的隐私选项',
            leading: Icon(Icons.lock),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _navigateTo('privacy'),
          ),
          ZephyrListItem(
            title: '通知设置',
            subtitle: '管理通知偏好',
            leading: Icon(Icons.notifications),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _navigateTo('notifications'),
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

## 🔧 高级用法

### 拖拽排序列表

```dart
class ReorderableListExample extends StatefulWidget {
  @override
  _ReorderableListExampleState createState() => _ReorderableListExampleState();
}

class _ReorderableListExampleState extends State<ReorderableListExample> {
  List<String> _items = [
    '项目 1',
    '项目 2',
    '项目 3',
    '项目 4',
    '项目 5',
  ];

  void _reorderItems(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('拖拽排序列表'),
      ),
      body: ZephyrList(
        reorderable: true,
        onReorder: _reorderItems,
        items: _items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return ZephyrListItem(
            key: ValueKey(item),
            title: item,
            subtitle: '长按并拖拽来重新排序',
            leading: Container(
              width: 24,
              height: 24,
              child: Icon(Icons.drag_handle),
            ),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('点击了: $item')),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
```

### 搜索过滤列表

```dart
class SearchableListExample extends StatefulWidget {
  @override
  _SearchableListExampleState createState() => _SearchableListExampleState();
}

class _SearchableListExampleState extends State<SearchableListExample> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _allItems = [];
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _initializeItems();
    _searchController.addListener(_filterItems);
  }

  void _initializeItems() {
    _allItems = [
      '苹果 iPhone 14',
      '三星 Galaxy S23',
      '小米 13',
      '华为 Mate 50',
      'OPPO Find X6',
      'vivo X90',
      '荣耀 Magic5',
      '一加 11',
      '魅族 20',
      'realme GT Neo5',
    ];
    _filteredItems = List.from(_allItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredItems = List.from(_allItems);
      } else {
        _filteredItems = _allItems.where((item) {
          return item.toLowerCase().contains(query);
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
        title: Text('搜索过滤列表'),
      ),
      body: Column(
        children: [
          // 搜索框
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '搜索手机型号',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
          
          // 搜索结果统计
          if (_searchController.text.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '找到 ${_filteredItems.length} 个结果',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          
          // 列表
          Expanded(
            child: ZephyrList(
              items: _filteredItems.map((item) {
                return ZephyrListItem(
                  title: item,
                  subtitle: _searchController.text.isNotEmpty
                      ? _buildHighlightedText(item, _searchController.text)
                      : null,
                  leading: Icon(Icons.smartphone),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('选择了: $item')),
                    );
                  },
                );
              }).toList(),
              placeholderBuilder: () {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        '未找到匹配的结果',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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

  Widget _buildHighlightedText(String text, String query) {
    final queryLower = query.toLowerCase();
    final textLower = text.toLowerCase();
    final index = textLower.indexOf(queryLower);
    
    if (index == -1) {
      return Text(text);
    }
    
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, index),
            style: TextStyle(color: Colors.grey[600]),
          ),
          TextSpan(
            text: text.substring(index, index + query.length),
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: text.substring(index + query.length),
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
```

### 无限滚动列表

```dart
class InfiniteScrollListExample extends StatefulWidget {
  @override
  _InfiniteScrollListExampleState createState() => _InfiniteScrollListExampleState();
}

class _InfiniteScrollListExampleState extends State<InfiniteScrollListExample> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    // 模拟网络请求
    await Future.delayed(Duration(seconds: 1));
    
    final newItems = List.generate(10, (index) {
      final itemIndex = (_page - 1) * 10 + index;
      return {
        'id': itemIndex + 1,
        'title': '动态项目 ${itemIndex + 1}',
        'subtitle': '这是第 ${itemIndex + 1} 个动态加载的项目',
        'timestamp': DateTime.now().subtract(Duration(minutes: itemIndex)),
      };
    });

    setState(() {
      _items.addAll(newItems);
      _page++;
      _isLoading = false;
      _hasMore = _page <= 10; // 限制最多10页
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
        title: Text('无限滚动列表'),
      ),
      body: ZephyrList(
        controller: _scrollController,
        items: _items.map((item) {
          return ZephyrListItem(
            title: item['title'],
            subtitle: item['subtitle'],
            trailing: Text(
              _formatTimestamp(item['timestamp']),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            leading: CircleAvatar(
              child: Text('#${item['id']}'),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('点击了: ${item['title']}')),
              );
            },
          );
        }).toList(),
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
        placeholderBuilder: _items.isEmpty
            ? () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      '暂无数据',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return '刚刚';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} 分钟前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} 小时前';
    } else {
      return '${difference.inDays} 天前';
    }
  }
}
```

### 嵌套列表

```dart
class NestedListExample extends StatefulWidget {
  @override
  _NestedListExampleState createState() => _NestedListExampleState();
}

class _NestedListExampleState extends State<NestedListExample> {
  Set<int> _expandedItems = {};

  void _toggleExpand(int index) {
    setState(() {
      if (_expandedItems.contains(index)) {
        _expandedItems.remove(index);
      } else {
        _expandedItems.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('嵌套列表'),
      ),
      body: ZephyrList(
        items: [
          ZephyrListItem(
            title: '用户管理',
            subtitle: '管理系统用户和权限',
            leading: Icon(Icons.people),
            trailing: Icon(_expandedItems.contains(0) ? Icons.expand_less : Icons.expand_more),
            onTap: () => _toggleExpand(0),
            children: _expandedItems.contains(0) ? [
              ZephyrListItem(
                title: '用户列表',
                subtitle: '查看所有用户',
                leading: Icon(Icons.list),
                trailing: Icon(Icons.chevron_right),
                onTap: () => _showUserList(),
                indent: 32,
              ),
              ZephyrListItem(
                title: '添加用户',
                subtitle: '创建新用户账户',
                leading: Icon(Icons.person_add),
                trailing: Icon(Icons.chevron_right),
                onTap: () => _showAddUser(),
                indent: 32,
              ),
              ZephyrListItem(
                title: '角色管理',
                subtitle: '管理用户角色和权限',
                leading: Icon(Icons.admin_panel_settings),
                trailing: Icon(Icons.chevron_right),
                onTap: () => _showRoleManagement(),
                indent: 32,
              ),
            ] : null,
          ),
          ZephyrListItem(
            title: '内容管理',
            subtitle: '管理系统内容',
            leading: Icon(Icons.article),
            trailing: Icon(_expandedItems.contains(1) ? Icons.expand_less : Icons.expand_more),
            onTap: () => _toggleExpand(1),
            children: _expandedItems.contains(1) ? [
              ZephyrListItem(
                title: '文章列表',
                subtitle: '管理所有文章',
                leading: Icon(Icons.list),
                trailing: Icon(Icons.chevron_right),
                onTap: () => _showArticleList(),
                indent: 32,
              ),
              ZephyrListItem(
                title: '分类管理',
                subtitle: '管理文章分类',
                leading: Icon(Icons.category),
                trailing: Icon(Icons.chevron_right),
                onTap: () => _showCategoryManagement(),
                indent: 32,
              ),
            ] : null,
          ),
          ZephyrListItem(
            title: '系统设置',
            subtitle: '配置系统参数',
            leading: Icon(Icons.settings),
            trailing: Icon(_expandedItems.contains(2) ? Icons.expand_less : Icons.expand_more),
            onTap: () => _toggleExpand(2),
            children: _expandedItems.contains(2) ? [
              ZephyrListItem(
                title: '基本设置',
                subtitle: '系统基本参数配置',
                leading: Icon(Icons.tune),
                trailing: Icon(Icons.chevron_right),
                onTap: () => _showBasicSettings(),
                indent: 32,
              ),
              ZephyrListItem(
                title: '安全设置',
                subtitle: '系统安全配置',
                leading: Icon(Icons.security),
                trailing: Icon(Icons.chevron_right),
                onTap: () => _showSecuritySettings(),
                indent: 32,
              ),
            ] : null,
          ),
        ],
      ),
    );
  }

  void _showUserList() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('显示用户列表')),
    );
  }

  void _showAddUser() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('显示添加用户')),
    );
  }

  void _showRoleManagement() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('显示角色管理')),
    );
  }

  void _showArticleList() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('显示文章列表')),
    );
  }

  void _showCategoryManagement() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('显示分类管理')),
    );
  }

  void _showBasicSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('显示基本设置')),
    );
  }

  void _showSecuritySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('显示安全设置')),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrList()

```dart
const ZephyrList({
  Key? key,
  required List<ZephyrListItem> items,
  ZephyrListStyle? style,
  ZephyrSelectionMode selectionMode = ZephyrSelectionMode.none,
  Set<int>? selectedIndices,
  ValueChanged<Set<int>>? onSelectionChanged,
  bool reorderable = false,
  ValueChanged<int, int>? onReorder,
  ScrollController? controller,
  Widget Function()? placeholderBuilder,
  Widget Function()? loadingBuilder,
  Widget Function()? errorBuilder,
  EdgeInsetsGeometry? padding,
  bool shrinkWrap = false,
  bool primary = true,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `items`: 列表项
- `style`: 列表样式
- `selectionMode`: 选择模式
- `selectedIndices`: 已选择的索引
- `onSelectionChanged`: 选择变化回调
- `reorderable`: 是否可拖拽排序
- `onReorder`: 拖拽排序回调
- `controller`: 滚动控制器
- `placeholderBuilder`: 空数据占位符构建器
- `loadingBuilder`: 加载状态构建器
- `errorBuilder`: 错误状态构建器
- `padding`: 内边距
- `shrinkWrap`: 是否收缩包裹
- `primary`: 是否为主滚动视图
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrListItem()

```dart
const ZephyrListItem({
  Key? key,
  required String title,
  String? subtitle,
  Widget? leading,
  Widget? trailing,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  List<ZephyrSwipeAction>? swipeActions,
  List<Widget>? children,
  double? indent,
  bool enabled = true,
  bool selected = false,
  String? tooltip,
  String? semanticLabel,
})
```

### 枚举类型

#### ZephyrSelectionMode

```dart
enum ZephyrSelectionMode {
  none,     // 无选择模式
  single,   // 单选模式
  multiple, // 多选模式
}
```

### 样式类

#### ZephyrListStyle

```dart
class ZephyrListStyle {
  final ZephyrListItemStyle? itemStyle;
  final ZephyrListDividerStyle? dividerStyle;
  final EdgeInsetsGeometry? padding;
  final bool compact;
  final Color? backgroundColor;
  final double? itemSpacing;
}
```

#### ZephyrListItemStyle

```dart
class ZephyrListItemStyle {
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? disabledColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double? elevation;
  final double? height;
  final BoxBorder? border;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrListTheme(
        defaultItemStyle: ZephyrListItemStyle(
          backgroundColor: Colors.white,
          selectedColor: Colors.blue[50],
          disabledColor: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          subtitleStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          elevation: 0,
          height: 72,
        ),
        defaultDividerStyle: ZephyrListDividerStyle(
          showDividers: true,
          color: Colors.grey[200],
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        defaultPadding: EdgeInsets.all(16),
        compactItemStyle: ZephyrListItemStyle(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          titleStyle: TextStyle(fontSize: 14),
          subtitleStyle: TextStyle(fontSize: 12),
          height: 56,
        ),
        selectedItemStyle: ZephyrListItemStyle(
          backgroundColor: Colors.blue[50],
          titleStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        disabledItemStyle: ZephyrListItemStyle(
          backgroundColor: Colors.grey[100],
          titleStyle: TextStyle(
            color: Colors.grey[400],
          ),
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

- `defaultItemStyle`: 默认列表项样式
- `defaultDividerStyle`: 默认分割线样式
- `defaultPadding`: 默认内边距
- `compactItemStyle`: 紧凑型列表项样式
- `selectedItemStyle`: 选中项样式
- `disabledItemStyle`: 禁用项样式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的列表项高度

```dart
// ✅ 好的做法：根据内容类型设置合适的高度
ZephyrList(
  items: [
    ZephyrListItem(
      title: '简单项目',
      // 使用默认高度，适合简单内容
    ),
    ZephyrListItem(
      title: '复杂项目',
      subtitle: '这个项目有副标题和图标',
      leading: Icon(Icons.star),
      trailing: Icon(Icons.chevron_right),
      // 自动调整高度以适应内容
    ),
  ],
)

// ✅ 好的做法：紧凑列表使用较小高度
ZephyrList(
  style: ZephyrListStyle(compact: true),
  items: _buildCompactItems(),
)

// ❌ 避免的做法：固定高度限制内容
ZephyrList(
  items: [
    ZephyrListItem(
      title: '很长的标题内容',
      subtitle: '这个副标题也很长，可能会被截断',
      // 高度固定可能导致内容溢出
    ),
  ],
)
```

### 2. 性能优化

```dart
// ✅ 好的做法：使用懒加载处理大数据量
class OptimizedList extends StatefulWidget {
  @override
  _OptimizedListState createState() => _OptimizedListState();
}

class _OptimizedListState extends State<OptimizedList> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadMoreItems() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    final newItems = await _fetchItems();
    setState(() {
      _items.addAll(newItems);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrList(
      controller: _scrollController,
      items: _items.map((item) => ZephyrListItem(
        title: item['title'],
        subtitle: item['subtitle'],
      )).toList(),
      loadingBuilder: _isLoading ? () => _buildLoadingIndicator() : null,
    );
  }
}

// ✅ 好的做法：避免不必要的重建
ZephyrListItem(
  key: ValueKey(item['id']), // 使用唯一key优化性能
  title: item['title'],
  subtitle: item['subtitle'],
)

// ❌ 避免的做法：一次性加载大量数据
ZephyrList(
  items: _largeDataSet, // 可能导致性能问题
)
```

### 3. 用户体验优化

```dart
// ✅ 好的做法：提供视觉反馈
ZephyrListItem(
  title: '可点击项目',
  onTap: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('项目被点击')),
    );
  },
  // 提供悬停和点击效果
)

// ✅ 好的做法：支持长按操作
ZephyrListItem(
  title: '长按操作',
  onLongPress: () {
    _showContextMenu();
  },
)

// ✅ 好的做法：为空状态提供提示
ZephyrList(
  items: _emptyList,
  placeholderBuilder: () => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
        SizedBox(height: 16),
        Text('暂无数据'),
      ],
    ),
  ),
)

// ❌ 避免的做法：缺乏用户反馈
ZephyrListItem(
  title: '无反馈项目',
  onTap: () {
    // 没有任何用户反馈
  },
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrList(
  semanticLabel: '用户列表',
  items: [
    ZephyrListItem(
      title: '张三',
      semanticLabel: '用户张三',
      onTap: () => _viewUser('张三'),
    ),
  ],
  enableAccessibilityFeatures: true,
)

// ✅ 好的做法：为操作提供描述
ZephyrListItem(
  title: '删除项目',
  trailing: IconButton(
    icon: Icon(Icons.delete),
    onPressed: () => _deleteItem(),
    tooltip: '删除此项目',
  ),
)

// ✅ 好的做法：确保足够的点击区域
ZephyrListItem(
  title: '可点击项目',
  onTap: () => _handleTap(),
  // 确保有足够的内边距
)

// ❌ 避免的做法：缺乏语义信息
ZephyrList(
  items: [
    ZephyrListItem(
      title: '项目',
      // 缺乏语义信息
    ),
  ],
)
```

## 🔄 相关组件

- **ZephyrTable**: 表格组件
- **ZephyrGrid**: 网格组件
- **ZephyrCard**: 卡片组件
- **ZephyrExpansionTile**: 展开瓦片组件
- **ZephyrContainer**: 容器组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本列表功能
- ✅ 支持分组和嵌套
- ✅ 支持选择和拖拽排序
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/list/`
**示例路径**: `example/lib/components/list_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日