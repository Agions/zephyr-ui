# ZephyrAutoComplete 自动完成组件

自动完成组件是ZephyrUI高级组件中的重要组件，用于提供智能化的输入建议。支持多种数据源、自定义样式和交互方式，是提升用户体验的重要工具。

## 🎯 组件概述

### 特性
- **多种数据源**: 支持本地数据、远程API、静态列表等多种数据源
- **灵活样式**: 支持自定义下拉框样式、选项样式、加载状态等
- **丰富交互**: 支持键盘导航、鼠标选择、触摸操作等交互
- **智能过滤**: 支持模糊匹配、拼音搜索、自定义过滤逻辑
- **异步加载**: 支持异步数据加载和分页
- **主题适配**: 完整的主题系统支持

### 适用场景
- 搜索框建议
- 表单自动补全
- 地址选择
- 用户名/邮箱输入
- 产品搜索
- 标签输入

## 🚀 基础用法

### 基本自动完成组件

```dart
class BasicAutoCompleteExample extends StatefulWidget {
  @override
  _BasicAutoCompleteExampleState createState() => _BasicAutoCompleteExampleState();
}

class _BasicAutoCompleteExampleState extends State<BasicAutoCompleteExample> {
  final TextEditingController _controller = TextEditingController();
  List<String> _suggestions = [];
  bool _isLoading = false;

  final List<String> _allItems = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
    'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon',
    'Mango', 'Nectarine', 'Orange', 'Papaya', 'Quince',
    'Raspberry', 'Strawberry', 'Tangerine', 'Watermelon'
  ];

  Future<void> _onTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    // 模拟异步搜索
    await Future.delayed(Duration(milliseconds: 300));

    final filtered = _allItems
        .where((item) => item.toLowerCase().contains(text.toLowerCase()))
        .toList();

    setState(() {
      _suggestions = filtered;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本自动完成组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrAutoComplete(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '搜索水果',
                border: OutlineInputBorder(),
                suffixIcon: _isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(Icons.search),
              ),
              suggestions: _suggestions,
              isLoading: _isLoading,
              onTextChanged: _onTextChanged,
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _controller.text = suggestion;
                  _suggestions = [];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('选中: $suggestion')),
                );
              },
              suggestionBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.food_bank),
                  title: Text(suggestion),
                  subtitle: Text('水果'),
                );
              },
            ),
            SizedBox(height: 24),
            
            // 显示当前输入
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '当前输入',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(_controller.text.isEmpty ? '无输入' : _controller.text),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 远程数据自动完成组件

```dart
class RemoteAutoCompleteExample extends StatefulWidget {
  @override
  _RemoteAutoCompleteExampleState createState() => _RemoteAutoCompleteExampleState();
}

class _RemoteAutoCompleteExampleState extends State<RemoteAutoCompleteExample> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];
  bool _isLoading = false;
  Timer? _debounceTimer;

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    // 取消之前的请求
    _debounceTimer?.cancel();

    // 防抖处理
    _debounceTimer = Timer(Duration(milliseconds: 500), () async {
      try {
        // 模拟API调用
        await Future.delayed(Duration(milliseconds: 800));
        
        // 模拟用户数据
        final mockUsers = [
          {'id': 1, 'name': '张三', 'email': 'zhangsan@example.com', 'avatar': '👨'},
          {'id': 2, 'name': '李四', 'email': 'lisi@example.com', 'avatar': '👩'},
          {'id': 3, 'name': '王五', 'email': 'wangwu@example.com', 'avatar': '👨'},
          {'id': 4, 'name': '赵六', 'email': 'zhaoliu@example.com', 'avatar': '👩'},
          {'id': 5, 'name': '钱七', 'email': 'qianqi@example.com', 'avatar': '👨'},
        ];

        final filtered = mockUsers
            .where((user) => 
                user['name'].toLowerCase().contains(query.toLowerCase()) ||
                user['email'].toLowerCase().contains(query.toLowerCase()))
            .toList();

        setState(() {
          _suggestions = filtered;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _suggestions = [];
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('远程数据自动完成组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrAutoComplete(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '搜索用户',
                border: OutlineInputBorder(),
                hintText: '输入姓名或邮箱',
              ),
              suggestions: _suggestions,
              isLoading: _isLoading,
              onTextChanged: _searchUsers,
              onSuggestionSelected: (user) {
                setState(() {
                  _controller.text = user['name'];
                  _suggestions = [];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('选中用户: ${user['name']}')),
                );
              },
              suggestionBuilder: (context, user) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user['avatar']),
                  ),
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  trailing: Icon(Icons.person_add),
                );
              },
              noItemsFoundBuilder: (context) {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        '未找到匹配的用户',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
```

### 多选自动完成组件

```dart
class MultiSelectAutoCompleteExample extends StatefulWidget {
  @override
  _MultiSelectAutoCompleteExampleState createState() => _MultiSelectAutoCompleteExampleState();
}

class _MultiSelectAutoCompleteExampleState extends State<MultiSelectAutoCompleteExample> {
  final TextEditingController _controller = TextEditingController();
  List<String> _suggestions = [];
  List<String> _selectedItems = [];
  bool _isLoading = false;

  final List<String> _allItems = [
    'React', 'Vue', 'Angular', 'Svelte', 'Solid',
    'Flutter', 'React Native', 'Ionic', 'Xamarin', 'NativeScript',
    'Node.js', 'Python', 'Java', 'C#', 'Go',
    'Rust', 'TypeScript', 'JavaScript', 'PHP', 'Ruby'
  ];

  Future<void> _onTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(Duration(milliseconds: 200));

    final filtered = _allItems
        .where((item) => 
            item.toLowerCase().contains(text.toLowerCase()) &&
            !_selectedItems.contains(item))
        .toList();

    setState(() {
      _suggestions = filtered;
      _isLoading = false;
    });
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _selectedItems.add(suggestion);
      _controller.clear();
      _suggestions = [];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('添加: $suggestion')),
    );
  }

  void _removeSelectedItem(String item) {
    setState(() {
      _selectedItems.remove(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('移除: $item')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多选自动完成组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrAutoComplete(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '选择技术栈',
                border: OutlineInputBorder(),
                hintText: '输入技术名称',
              ),
              suggestions: _suggestions,
              isLoading: _isLoading,
              onTextChanged: _onTextChanged,
              onSuggestionSelected: _onSuggestionSelected,
              suggestionBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.code),
                  title: Text(suggestion),
                  trailing: Icon(Icons.add),
                );
              },
            ),
            SizedBox(height: 24),
            
            // 已选择的项
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '已选择的技术栈',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedItems.map((item) {
                        return InputChip(
                          label: Text(item),
                          avatar: Icon(Icons.code),
                          onDeleted: () => _removeSelectedItem(item),
                          backgroundColor: Colors.blue[100],
                        );
                      }).toList(),
                    ),
                    if (_selectedItems.isEmpty)
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '暂未选择任何技术',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## 🎨 样式定制

### 自定义样式自动完成组件

```dart
class CustomStyleAutoCompleteExample extends StatefulWidget {
  @override
  _CustomStyleAutoCompleteExampleState createState() => _CustomStyleAutoCompleteExampleState();
}

class _CustomStyleAutoCompleteExampleState extends State<CustomStyleAutoCompleteExample> {
  final TextEditingController _controller = TextEditingController();
  List<String> _suggestions = [];
  bool _isLoading = false;

  final List<String> _allItems = [
    '北京', '上海', '广州', '深圳', '杭州',
    '南京', '武汉', '成都', '西安', '重庆',
    '天津', '苏州', '青岛', '大连', '厦门'
  ];

  Future<void> _onTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(Duration(milliseconds: 300));

    final filtered = _allItems
        .where((item) => item.toLowerCase().contains(text.toLowerCase()))
        .toList();

    setState(() {
      _suggestions = filtered;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义样式自动完成组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrAutoComplete(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '选择城市',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.purple[50],
                prefixIcon: Icon(Icons.location_city, color: Colors.purple),
                suffixIcon: _isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                        ),
                      )
                    : Icon(Icons.search, color: Colors.purple),
                labelStyle: TextStyle(color: Colors.purple[800]),
                hintStyle: TextStyle(color: Colors.purple[400]),
              ),
              suggestions: _suggestions,
              isLoading: _isLoading,
              onTextChanged: _onTextChanged,
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _controller.text = suggestion;
                  _suggestions = [];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('选中城市: $suggestion')),
                );
              },
              suggestionBuilder: (context, suggestion) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    border: Border(
                      bottom: BorderSide(color: Colors.purple[100]!),
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    title: Text(
                      suggestion,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    subtitle: Text(
                      '城市',
                      style: TextStyle(
                        color: Colors.purple[600],
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.purple[400],
                      size: 16,
                    ),
                  ),
                );
              },
              menuStyle: ZephyrAutoCompleteMenuStyle(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.purple[50],
                shadowColor: Colors.purple.withOpacity(0.3),
                maxWidth: 400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 分组自动完成组件

```dart
class GroupedAutoCompleteExample extends StatefulWidget {
  @override
  _GroupedAutoCompleteExampleState createState() => _GroupedAutoCompleteExampleState();
}

class _GroupedAutoCompleteExampleState extends State<GroupedAutoCompleteExample> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];
  bool _isLoading = false;

  final Map<String, List<Map<String, dynamic>>> _groupedItems = {
    '前端框架': [
      {'name': 'React', 'type': 'library'},
      {'name': 'Vue', 'type': 'framework'},
      {'name': 'Angular', 'type': 'framework'},
      {'name': 'Svelte', 'type': 'compiler'},
    ],
    '后端语言': [
      {'name': 'Node.js', 'type': 'runtime'},
      {'name': 'Python', 'type': 'language'},
      {'name': 'Java', 'type': 'language'},
      {'name': 'Go', 'type': 'language'},
    ],
    '移动开发': [
      {'name': 'Flutter', 'type': 'framework'},
      {'name': 'React Native', 'type': 'framework'},
      {'name': 'Swift', 'type': 'language'},
      {'name': 'Kotlin', 'type': 'language'},
    ],
  };

  Future<void> _onTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(Duration(milliseconds: 200));

    final filtered = <Map<String, dynamic>>[];
    _groupedItems.forEach((category, items) {
      final categoryMatches = items
          .where((item) => item['name'].toLowerCase().contains(text.toLowerCase()))
          .map((item) => {...item, 'category': category})
          .toList();
      filtered.addAll(categoryMatches);
    });

    setState(() {
      _suggestions = filtered;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分组自动完成组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrAutoComplete(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '搜索技术',
                border: OutlineInputBorder(),
                hintText: '输入技术名称',
              ),
              suggestions: _suggestions,
              isLoading: _isLoading,
              onTextChanged: _onTextChanged,
              onSuggestionSelected: (item) {
                setState(() {
                  _controller.text = item['name'];
                  _suggestions = [];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('选中: ${item['name']} (${item['category']})')),
                );
              },
              suggestionBuilder: (context, item) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getCategoryColor(item['category']),
                    child: Icon(
                      _getCategoryIcon(item['category']),
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  title: Text(item['name']),
                  subtitle: Text('${item['category']} • ${item['type']}'),
                );
              },
              groupBy: (item) => item['category'],
              groupHeaderBuilder: (context, category) {
                return Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case '前端框架':
        return Colors.blue;
      case '后端语言':
        return Colors.green;
      case '移动开发':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case '前端框架':
        return Icons.web;
      case '后端语言':
        return Icons.code;
      case '移动开发':
        return Icons.phone_android;
      default:
        return Icons.category;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## 🔧 高级用法

### 异步分页自动完成组件

```dart
class AsyncPaginatedAutoCompleteExample extends StatefulWidget {
  @override
  _AsyncPaginatedAutoCompleteExampleState createState() => _AsyncPaginatedAutoCompleteExampleState();
}

class _AsyncPaginatedAutoCompleteExampleState extends State<AsyncPaginatedAutoCompleteExample> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  final int _pageSize = 10;

  Future<void> _loadData(String query, {int page = 1}) async {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
        _hasMore = true;
        _currentPage = 1;
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 模拟API调用
      await Future.delayed(Duration(milliseconds: 800));
      
      // 模拟分页数据
      final allMockData = List.generate(100, (index) => {
        return {
          'id': index + 1,
          'name': '产品 ${index + 1}',
          'category': '类别 ${(index % 5) + 1}',
          'price': ((index + 1) * 10).toString(),
        };
      });

      final filtered = allMockData
          .where((item) => item['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();

      final startIndex = (page - 1) * _pageSize;
      final endIndex = startIndex + _pageSize;
      final pageData = filtered.sublist(
        startIndex,
        endIndex > filtered.length ? filtered.length : endIndex,
      );

      setState(() {
        if (page == 1) {
          _suggestions = pageData;
        } else {
          _suggestions.addAll(pageData);
        }
        _isLoading = false;
        _hasMore = endIndex < filtered.length;
        _currentPage = page;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasMore = false;
      });
    }
  }

  void _onTextChanged(String text) {
    _loadData(text, page: 1);
  }

  void _onSuggestionSelected(Map<String, dynamic> item) {
    setState(() {
      _controller.text = item['name'];
      _suggestions = [];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('选中产品: ${item['name']}')),
    );
  }

  void _loadMore() {
    if (!_isLoading && _hasMore) {
      _loadData(_controller.text, page: _currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('异步分页自动完成组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrAutoComplete(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '搜索产品',
                border: OutlineInputBorder(),
                hintText: '输入产品名称',
              ),
              suggestions: _suggestions,
              isLoading: _isLoading,
              onTextChanged: _onTextChanged,
              onSuggestionSelected: _onSuggestionSelected,
              suggestionBuilder: (context, item) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('#${item['id']}'),
                  ),
                  title: Text(item['name']),
                  subtitle: Text('${item['category']} • ¥${item['price']}'),
                  trailing: Icon(Icons.shopping_cart),
                );
              },
              loadMore: _hasMore ? _loadMore : null,
              loadingMoreBuilder: (context) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('加载更多...'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 自定义过滤逻辑自动完成组件

```dart
class CustomFilterAutoCompleteExample extends StatefulWidget {
  @override
  _CustomFilterAutoCompleteExampleState createState() => _CustomFilterAutoCompleteExampleState();
}

class _CustomFilterAutoCompleteExampleState extends State<CustomFilterAutoCompleteExample> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];
  bool _isLoading = false;

  final List<Map<String, dynamic>> _allItems = [
    {'name': 'iPhone 14', 'brand': 'Apple', 'price': 5999, 'category': '手机'},
    {'name': 'iPhone 13', 'brand': 'Apple', 'price': 4999, 'category': '手机'},
    {'name': 'MacBook Pro', 'brand': 'Apple', 'price': 12999, 'category': '笔记本'},
    {'name': 'iPad Air', 'brand': 'Apple', 'price': 3999, 'category': '平板'},
    {'name': 'Galaxy S23', 'brand': 'Samsung', 'price': 4999, 'category': '手机'},
    {'name': 'Galaxy Tab', 'brand': 'Samsung', 'price': 2999, 'category': '平板'},
    {'name': 'ThinkPad X1', 'brand': 'Lenovo', 'price': 8999, 'category': '笔记本'},
    {'name': 'Xiaomi 13', 'brand': 'Xiaomi', 'price': 3999, 'category': '手机'},
    {'name': 'Huawei P60', 'brand': 'Huawei', 'price': 4499, 'category': '手机'},
    {'name': 'Surface Pro', 'brand': 'Microsoft', 'price': 7999, 'category': '平板'},
  ];

  Future<void> _onTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(Duration(milliseconds: 300));

    // 自定义过滤逻辑
    final filtered = _allItems.where((item) {
      final searchText = text.toLowerCase();
      final name = item['name'].toLowerCase();
      final brand = item['brand'].toLowerCase();
      final category = item['category'].toLowerCase();
      
      // 支持多种搜索方式
      return name.contains(searchText) ||
             brand.contains(searchText) ||
             category.contains(searchText) ||
             name.split(' ').any((word) => word.contains(searchText));
    }).toList();

    // 按相关性和价格排序
    filtered.sort((a, b) {
      final text = text.toLowerCase();
      final aName = a['name'].toLowerCase();
      final bName = b['name'].toLowerCase();
      
      // 完全匹配优先
      if (aName == text && bName != text) return -1;
      if (bName == text && aName != text) return 1;
      
      // 开头匹配优先
      if (aName.startsWith(text) && !bName.startsWith(text)) return -1;
      if (bName.startsWith(text) && !aName.startsWith(text)) return 1;
      
      // 价格从低到高
      return a['price'].compareTo(b['price']);
    });

    setState(() {
      _suggestions = filtered;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义过滤逻辑自动完成组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrAutoComplete(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '搜索电子产品',
                border: OutlineInputBorder(),
                hintText: '可搜索产品名、品牌或类别',
              ),
              suggestions: _suggestions,
              isLoading: _isLoading,
              onTextChanged: _onTextChanged,
              onSuggestionSelected: (item) {
                setState(() {
                  _controller.text = item['name'];
                  _suggestions = [];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('选中: ${item['name']} - ¥${item['price']}')),
                );
              },
              suggestionBuilder: (context, item) {
                final priceColor = item['price'] > 5000 ? Colors.red : Colors.green;
                
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCategoryIcon(item['category']),
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(
                      item['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item['brand']} • ${item['category']}'),
                        Text(
                          '¥${item['price']}',
                          style: TextStyle(
                            color: priceColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case '手机':
        return Icons.smartphone;
      case '笔记本':
        return Icons.laptop;
      case '平板':
        return Icons.tablet;
      default:
        return Icons.devices;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 带验证的自动完成组件

```dart
class ValidatedAutoCompleteExample extends StatefulWidget {
  @override
  _ValidatedAutoCompleteExampleState createState() => _ValidatedAutoCompleteExampleState();
}

class _ValidatedAutoCompleteExampleState extends State<ValidatedAutoCompleteExample> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  List<String> _suggestions = [];
  bool _isLoading = false;
  String? _validationError;

  final List<String> _validOptions = [
    'admin@example.com',
    'user@example.com',
    'test@example.com',
    'demo@example.com',
    'support@example.com',
  ];

  Future<void> _onTextChanged(String text) async {
    // 清除之前的验证错误
    setState(() => _validationError = null);

    if (text.isEmpty) {
      setState(() {
        _suggestions = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(Duration(milliseconds: 300));

    final filtered = _validOptions
        .where((option) => option.toLowerCase().contains(text.toLowerCase()))
        .toList();

    setState(() {
      _suggestions = filtered;
      _isLoading = false;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱地址';
    }
    
    if (!_validOptions.contains(value)) {
      return '请选择有效的邮箱地址';
    }
    
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '邮箱格式不正确';
    }
    
    return null;
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _controller.text = suggestion;
      _suggestions = [];
      _validationError = null;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('表单验证成功: ${_controller.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带验证的自动完成组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ZephyrAutoComplete(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: '邮箱地址',
                  border: OutlineInputBorder(),
                  hintText: '输入或选择邮箱地址',
                  errorText: _validationError,
                  errorStyle: TextStyle(color: Colors.red),
                ),
                suggestions: _suggestions,
                isLoading: _isLoading,
                onTextChanged: _onTextChanged,
                onSuggestionSelected: _onSuggestionSelected,
                validator: _validateEmail,
                suggestionBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.email),
                    title: Text(suggestion),
                    subtitle: Text('系统用户邮箱'),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                  );
                },
                // 实时验证
                onFieldSubmitted: (value) {
                  final error = _validateEmail(value);
                  setState(() => _validationError = error);
                },
              ),
              SizedBox(height: 24),
              
              // 验证状态显示
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '验证状态',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            _validationError == null && _controller.text.isNotEmpty
                                ? Icons.check_circle
                                : Icons.error,
                            color: _validationError == null && _controller.text.isNotEmpty
                                ? Colors.green
                                : Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text(
                            _validationError ?? (_controller.text.isEmpty ? '未输入' : '验证通过'),
                            style: TextStyle(
                              color: _validationError == null && _controller.text.isNotEmpty
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('提交表单'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrAutoComplete()

```dart
const ZephyrAutoComplete({
  Key? key,
  required TextEditingController controller,
  required List<dynamic> suggestions,
  required Future<void> Function(String) onTextChanged,
  required void Function(dynamic) onSuggestionSelected,
  InputDecoration? decoration,
  bool isLoading = false,
  Widget Function(BuildContext, dynamic)? suggestionBuilder,
  Widget Function(BuildContext)? noItemsFoundBuilder,
  Widget Function(BuildContext)? loadingBuilder,
  Widget Function(BuildContext)? loadingMoreBuilder,
  void Function()? loadMore,
  String Function(dynamic)? groupBy,
  Widget Function(BuildContext, String)? groupHeaderBuilder,
  ZephyrAutoCompleteMenuStyle? menuStyle,
  String? Function(String?)? validator,
  void Function(String)? onFieldSubmitted,
  double? menuMaxHeight,
  bool autovalidateMode = false,
  int debounceTime = 300,
  int minChars = 1,
  bool keepSuggestionsOnLoading = false,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `controller`: 文本控制器
- `suggestions`: 建议列表
- `onTextChanged`: 文本变化回调
- `onSuggestionSelected`: 选择建议回调
- `decoration`: 输入框装饰
- `isLoading`: 是否正在加载
- `suggestionBuilder`: 建议项构建器
- `noItemsFoundBuilder`: 无匹配项构建器
- `loadingBuilder`: 加载状态构建器
- `loadingMoreBuilder`: 加载更多构建器
- `loadMore`: 加载更多回调
- `groupBy`: 分组函数
- `groupHeaderBuilder`: 分组标题构建器
- `menuStyle`: 菜单样式
- `validator`: 验证函数
- `onFieldSubmitted`: 字段提交回调
- `menuMaxHeight`: 菜单最大高度
- `autovalidateMode`: 自动验证模式
- `debounceTime`: 防抖时间（毫秒）
- `minChars`: 最小字符数
- `keepSuggestionsOnLoading`: 加载时保持建议
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 样式类

#### ZephyrAutoCompleteMenuStyle

```dart
class ZephyrAutoCompleteMenuStyle {
  final double? elevation;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final TextStyle? groupHeaderStyle;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrAutoCompleteTheme(
        defaultMenuStyle: ZephyrAutoCompleteMenuStyle(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.2),
          maxWidth: 400,
          padding: EdgeInsets.zero,
        ),
        defaultLoadingIndicator: CircularProgressIndicator(),
        debounceTime: Duration(milliseconds: 300),
        minChars: 1,
        keepSuggestionsOnLoading: false,
        loadingTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
        noItemsFoundTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
        groupHeaderStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultMenuStyle`: 默认菜单样式
- `defaultLoadingIndicator`: 默认加载指示器
- `debounceTime`: 防抖时间
- `minChars`: 最小字符数
- `keepSuggestionsOnLoading`: 加载时保持建议
- `loadingTextStyle`: 加载文本样式
- `noItemsFoundTextStyle`: 无匹配项文本样式
- `groupHeaderStyle`: 分组标题样式

## 🏆 最佳实践

### 1. 合理的防抖时间

```dart
// ✅ 好的做法：设置合适的防抖时间
ZephyrAutoComplete(
  debounceTime: 300, // 300ms适合大多数场景
)

// ✅ 好的做法：根据数据源类型调整防抖时间
// 本地数据可以设置较短时间
ZephyrAutoComplete(
  debounceTime: 100, // 本地数据响应快
)

// 远程数据需要设置较长时间
ZephyrAutoComplete(
  debounceTime: 500, // 避免频繁请求
)

// ❌ 避免的做法：防抖时间过长
ZephyrAutoComplete(
  debounceTime: 1000, // 用户感觉响应慢
)
```

### 2. 加载状态处理

```dart
// ✅ 好的做法：显示加载状态
ZephyrAutoComplete(
  isLoading: _isLoading,
  loadingBuilder: (context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      ),
    );
  },
)

// ✅ 好的做法：在输入框中显示加载状态
ZephyrAutoComplete(
  decoration: InputDecoration(
    suffixIcon: _isLoading
        ? CircularProgressIndicator(strokeWidth: 2)
        : Icon(Icons.search),
  ),
)

// ❌ 避免的做法：没有加载状态反馈
ZephyrAutoComplete(
  // 用户不知道是否正在搜索
)
```

### 3. 数据源优化

```dart
// ✅ 好的做法：本地缓存数据
class CachedAutoComplete extends StatefulWidget {
  final Map<String, List<dynamic>> _cache = {};
  
  Future<void> _search(String query) async {
    if (_cache.containsKey(query)) {
      // 使用缓存数据
      setState(() => _suggestions = _cache[query]!);
      return;
    }
    
    // 远程搜索并缓存
    final results = await _fetchFromApi(query);
    _cache[query] = results;
    setState(() => _suggestions = results);
  }
}

// ✅ 好的做法：分页加载大数据集
ZephyrAutoComplete(
  loadMore: _hasMore ? _loadMore : null,
  loadingMoreBuilder: (context) {
    return Center(child: Text('加载更多...'));
  },
)

// ❌ 避免的做法：一次性加载所有数据
Future<void> _search(String query) async {
  final allData = await _fetchAllData(); // 可能很慢
  setState(() => _suggestions = allData);
}
```

### 4. 用户体验优化

```dart
// ✅ 好的做法：提供无匹配项提示
ZephyrAutoComplete(
  noItemsFoundBuilder: (context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 48, color: Colors.grey),
          SizedBox(height: 8),
          Text('未找到匹配的结果'),
        ],
      ),
    );
  },
)

// ✅ 好的做法：支持键盘导航
ZephyrAutoComplete(
  enableKeyboardNavigation: true,
)

// ✅ 好的做法：合理的最小字符数
ZephyrAutoComplete(
  minChars: 2, // 避免过早搜索
)

// ❌ 避免的做法：缺乏用户反馈
ZephyrAutoComplete(
  // 用户不知道发生了什么
)
```

### 5. 性能优化

```dart
// ✅ 好的做法：避免频繁重建
class OptimizedAutoComplete extends StatefulWidget {
  List<dynamic> _filteredSuggestions = [];
  
  void _onTextChanged(String text) {
    if (text.isEmpty) {
      setState(() => _filteredSuggestions = []);
      return;
    }
    
    // 使用计算属性而不是setState
    final filtered = _allItems.where((item) {
      return item.toLowerCase().contains(text.toLowerCase());
    }).toList();
    
    setState(() => _filteredSuggestions = filtered);
  }
}

// ✅ 好的做法：使用ListView.builder
ZephyrAutoComplete(
  suggestionBuilder: (context, item) {
    return ListTile(title: Text(item));
  },
)

// ❌ 避免的做法：在build中进行复杂计算
Widget build(BuildContext context) {
  final filtered = _allItems.where((item) {
    return item.contains(_controller.text); // 每次build都重新计算
  }).toList();
  
  return ZephyrAutoComplete(
    suggestions: filtered,
  );
}
```

## 🔄 相关组件

- **ZephyrSelect**: 选择组件
- **ZephyrInputField**: 输入框组件
- **ZephyrSearchField**: 搜索框组件
- **ZephyrComboBox**: 组合框组件
- **ZephyrTagInput**: 标签输入组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种数据源
- ✅ 支持自定义样式和过滤
- ✅ 支持分组和分页
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/advanced/auto_complete/`
**示例路径**: `example/lib/components/auto_complete_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日