# ZephyrDataGrid 数据网格组件

数据网格组件是ZephyrUI展示系统中的高级组件，提供了强大的数据网格展示和管理功能。支持多种网格模式、数据操作、自定义样式等高级功能，是构建复杂数据管理系统、数据分析工具、报表生成等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种网格模式**: 支持基本网格、编辑网格、分组网格等多种模式
- **丰富数据操作**: 支持排序、筛选、搜索、分页等数据操作
- **灵活布局**: 支持固定列、可调整列宽、响应式布局等
- **编辑功能**: 支持行内编辑、批量编辑、数据验证等
- **性能优化**: 支持虚拟化、延迟加载、分页加载等
- **主题适配**: 完整的主题系统支持

### 适用场景
- 数据管理系统
- 报表生成工具
- 数据分析平台
- CRM系统
- ERP系统
- 项目管理系统

## 🚀 基础用法

### 基本数据网格

```dart
class BasicDataGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本数据网格'),
      ),
      body: ZephyrDataGrid(
        columns: [
          ZephyrDataGridColumn(
            title: 'ID',
            field: 'id',
            width: 60,
          ),
          ZephyrDataGridColumn(
            title: '姓名',
            field: 'name',
            width: 120,
          ),
          ZephyrDataGridColumn(
            title: '部门',
            field: 'department',
            width: 120,
          ),
          ZephyrDataGridColumn(
            title: '职位',
            field: 'position',
            width: 120,
          ),
          ZephyrDataGridColumn(
            title: '入职日期',
            field: 'joinDate',
            width: 120,
          ),
          ZephyrDataGridColumn(
            title: '状态',
            field: 'status',
            width: 80,
          ),
        ],
        data: [
          {
            'id': 1,
            'name': '张三',
            'department': '技术部',
            'position': '前端工程师',
            'joinDate': '2023-01-15',
            'status': '在职',
          },
          {
            'id': 2,
            'name': '李四',
            'department': '市场部',
            'position': '市场经理',
            'joinDate': '2022-05-20',
            'status': '在职',
          },
          {
            'id': 3,
            'name': '王五',
            'department': '技术部',
            'position': '后端工程师',
            'joinDate': '2023-03-10',
            'status': '休假',
          },
          {
            'id': 4,
            'name': '赵六',
            'department': '人事部',
            'position': 'HR专员',
            'joinDate': '2022-08-01',
            'status': '在职',
          },
        ],
      ),
    );
  }
}
```

### 带排序的数据网格

```dart
class SortableDataGridExample extends StatefulWidget {
  @override
  _SortableDataGridExampleState createState() => _SortableDataGridExampleState();
}

class _SortableDataGridExampleState extends State<SortableDataGridExample> {
  List<Map<String, dynamic>> _data = [
    {'id': 1, 'name': '产品A', 'price': 100, 'sales': 1500, 'rating': 4.5},
    {'id': 2, 'name': '产品B', 'price': 200, 'sales': 1200, 'rating': 4.2},
    {'id': 3, 'name': '产品C', 'price': 150, 'sales': 1800, 'rating': 4.8},
    {'id': 4, 'name': '产品D', 'price': 300, 'sales': 800, 'rating': 3.9},
    {'id': 5, 'name': '产品E', 'price': 250, 'sales': 1000, 'rating': 4.1},
  ];
  
  String? _sortField;
  bool _sortAscending = true;

  void _handleSort(String field) {
    setState(() {
      if (_sortField == field) {
        _sortAscending = !_sortAscending;
      } else {
        _sortField = field;
        _sortAscending = true;
      }
      
      _data.sort((a, b) {
        final aValue = a[field];
        final bValue = b[field];
        final comparison = aValue.compareTo(bValue);
        return _sortAscending ? comparison : -comparison;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带排序的数据网格'),
      ),
      body: ZephyrDataGrid(
        columns: [
          ZephyrDataGridColumn(
            title: '产品名称',
            field: 'name',
            width: 150,
            sortable: true,
            sortDirection: _sortField == 'name' 
                ? (_sortAscending ? SortDirection.ascending : SortDirection.descending)
                : SortDirection.none,
            onSort: () => _handleSort('name'),
          ),
          ZephyrDataGridColumn(
            title: '价格',
            field: 'price',
            width: 100,
            sortable: true,
            sortDirection: _sortField == 'price' 
                ? (_sortAscending ? SortDirection.ascending : SortDirection.descending)
                : SortDirection.none,
            onSort: () => _handleSort('price'),
            cellBuilder: (data) {
              return Text('¥${data['price']}');
            },
          ),
          ZephyrDataGridColumn(
            title: '销量',
            field: 'sales',
            width: 100,
            sortable: true,
            sortDirection: _sortField == 'sales' 
                ? (_sortAscending ? SortDirection.ascending : SortDirection.descending)
                : SortDirection.none,
            onSort: () => _handleSort('sales'),
          ),
          ZephyrDataGridColumn(
            title: '评分',
            field: 'rating',
            width: 100,
            sortable: true,
            sortDirection: _sortField == 'rating' 
                ? (_sortAscending ? SortDirection.ascending : SortDirection.descending)
                : SortDirection.none,
            onSort: () => _handleSort('rating'),
            cellBuilder: (data) {
              return Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text(data['rating'].toString()),
                ],
              );
            },
          ),
        ],
        data: _data,
      ),
    );
  }
}
```

### 带筛选的数据网格

```dart
class FilterableDataGridExample extends StatefulWidget {
  @override
  _FilterableDataGridExampleState createState() => _FilterableDataGridExampleState();
}

class _FilterableDataGridExampleState extends State<FilterableDataGridExample> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allData = [];
  List<Map<String, dynamic>> _filteredData = [];
  String? _selectedDepartment;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _searchController.addListener(_filterData);
  }

  void _initializeData() {
    _allData = [
      {'id': 1, 'name': '张三', 'department': '技术部', 'position': '前端工程师', 'salary': 12000},
      {'id': 2, 'name': '李四', 'department': '市场部', 'position': '市场经理', 'salary': 15000},
      {'id': 3, 'name': '王五', 'department': '技术部', 'position': '后端工程师', 'salary': 13000},
      {'id': 4, 'name': '赵六', 'department': '人事部', 'position': 'HR专员', 'salary': 8000},
      {'id': 5, 'name': '钱七', 'department': '财务部', 'position': '会计', 'salary': 9000},
      {'id': 6, 'name': '孙八', 'department': '技术部', 'position': '架构师', 'salary': 20000},
    ];
    _filteredData = List.from(_allData);
  }

  void _filterData() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = _allData.where((item) {
        final matchesSearch = item['name'].toLowerCase().contains(query) ||
            item['position'].toLowerCase().contains(query);
        final matchesDepartment = _selectedDepartment == null || item['department'] == _selectedDepartment;
        return matchesSearch && matchesDepartment;
      }).toList();
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
        title: Text('带筛选的数据网格'),
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
                    labelText: '搜索姓名或职位',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // 部门筛选
                Row(
                  children: [
                    Text('部门筛选：'),
                    SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _selectedDepartment,
                      hint: Text('全部部门'),
                      items: [
                        null,
                        '技术部',
                        '市场部',
                        '人事部',
                        '财务部',
                      ].map((department) {
                        return DropdownMenuItem(
                          value: department,
                          child: Text(department ?? '全部'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDepartment = value;
                          _filterData();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 数据网格
          Expanded(
            child: ZephyrDataGrid(
              columns: [
                ZephyrDataGridColumn(
                  title: '姓名',
                  field: 'name',
                  width: 120,
                ),
                ZephyrDataGridColumn(
                  title: '部门',
                  field: 'department',
                  width: 120,
                ),
                ZephyrDataGridColumn(
                  title: '职位',
                  field: 'position',
                  width: 150,
                ),
                ZephyrDataGridColumn(
                  title: '薪资',
                  field: 'salary',
                  width: 120,
                  cellBuilder: (data) {
                    return Text('¥${data['salary']}');
                  },
                ),
              ],
              data: _filteredData,
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🎨 样式定制

### 斑马纹数据网格

```dart
class StripedDataGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('斑马纹数据网格'),
      ),
      body: ZephyrDataGrid(
        columns: [
          ZephyrDataGridColumn(
            title: '产品',
            field: 'product',
            width: 150,
          ),
          ZephyrDataGridColumn(
            title: '类别',
            field: 'category',
            width: 120,
          ),
          ZephyrDataGridColumn(
            title: '价格',
            field: 'price',
            width: 100,
            cellBuilder: (data) {
              return Text('¥${data['price']}');
            },
          ),
          ZephyrDataGridColumn(
            title: '库存',
            field: 'stock',
            width: 80,
          ),
          ZephyrDataGridColumn(
            title: '状态',
            field: 'status',
            width: 100,
            cellBuilder: (data) {
              final status = data['status'];
              Color color;
              switch (status) {
                case '在售':
                  color = Colors.green;
                  break;
                case '缺货':
                  color = Colors.red;
                  break;
                default:
                  color = Colors.grey;
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
        data: [
          {'product': 'iPhone 14', 'category': '手机', 'price': 5999, 'stock': 100, 'status': '在售'},
          {'product': 'Samsung S23', 'category': '手机', 'price': 4999, 'stock': 0, 'status': '缺货'},
          {'product': 'MacBook Pro', 'category': '笔记本', 'price': 12999, 'stock': 50, 'status': '在售'},
          {'product': 'iPad Air', 'category': '平板', 'price': 4599, 'stock': 80, 'status': '在售'},
        ],
        style: ZephyrDataGridStyle(
          stripedRows: true,
          stripeColor: Colors.grey[50],
          headerStyle: ZephyrDataGridHeaderStyle(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          cellStyle: ZephyrDataGridCellStyle(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: TextStyle(fontSize: 14),
          ),
          borderStyle: DataGridBorderStyle(
            all: BorderSide(color: Colors.grey[300]!),
            horizontalInside: BorderSide(color: Colors.grey[200]!),
          ),
        ),
      ),
    );
  }
}
```

### 紧凑型数据网格

```dart
class CompactDataGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紧凑型数据网格'),
      ),
      body: ZephyrDataGrid(
        columns: [
          ZephyrDataGridColumn(
            title: 'ID',
            field: 'id',
            width: 50,
          ),
          ZephyrDataGridColumn(
            title: '用户名',
            field: 'username',
            width: 100,
          ),
          ZephyrDataGridColumn(
            title: '邮箱',
            field: 'email',
            width: 150,
          ),
          ZephyrDataGridColumn(
            title: '注册时间',
            field: 'registerTime',
            width: 120,
          ),
          ZephyrDataGridColumn(
            title: '状态',
            field: 'status',
            width: 80,
          ),
        ],
        data: List.generate(20, (index) => {
          return {
            'id': index + 1,
            'username': 'user${index + 1}',
            'email': 'user${index + 1}@example.com',
            'registerTime': '2023-01-${index + 1}',
            'status': index % 2 == 0 ? '活跃' : '离线',
          };
        }),
        style: ZephyrDataGridStyle(
          compact: true,
          headerStyle: ZephyrDataGridHeaderStyle(
            backgroundColor: Colors.grey[100],
            textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          ),
          cellStyle: ZephyrDataGridCellStyle(
            textStyle: TextStyle(fontSize: 12),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          rowHeight: 32,
        ),
      ),
    );
  }
}
```

### 圆角数据网格

```dart
class RoundedDataGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆角数据网格'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ZephyrDataGrid(
          columns: [
            ZephyrDataGridColumn(
              title: '项目名称',
              field: 'project',
              width: 150,
            ),
            ZephyrDataGridColumn(
              title: '进度',
              field: 'progress',
              width: 120,
              cellBuilder: (data) {
                final progress = double.parse(data['progress'].replaceAll('%', ''));
                return LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                );
              },
            ),
            ZephyrDataGridColumn(
              title: '状态',
              field: 'status',
              width: 100,
            ),
            ZephyrDataGridColumn(
              title: '负责人',
              field: 'owner',
              width: 120,
            ),
          ],
          data: [
            {'project': '网站重构', 'progress': '75%', 'status': '进行中', 'owner': '张三'},
            {'project': '移动应用', 'progress': '90%', 'status': '即将完成', 'owner': '李四'},
            {'project': '数据库优化', 'progress': '45%', 'status': '进行中', 'owner': '王五'},
            {'project': 'UI设计', 'progress': '100%', 'status': '已完成', 'owner': '赵六'},
          ],
          style: ZephyrDataGridStyle(
            borderRadius: BorderRadius.circular(12),
            headerStyle: ZephyrDataGridHeaderStyle(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            cellStyle: ZephyrDataGridCellStyle(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              textStyle: TextStyle(fontSize: 14),
            ),
            borderStyle: DataGridBorderStyle(
              all: BorderSide(color: Colors.purple[200]!),
            ),
            elevation: 4,
          ),
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 可编辑数据网格

```dart
class EditableDataGridExample extends StatefulWidget {
  @override
  _EditableDataGridExampleState createState() => _EditableDataGridExampleState();
}

class _EditableDataGridExampleState extends State<EditableDataGridExample> {
  List<Map<String, dynamic>> _data = [
    {'id': 1, 'name': '张三', 'age': 25, 'email': 'zhangsan@example.com'},
    {'id': 2, 'name': '李四', 'age': 30, 'email': 'lisi@example.com'},
    {'id': 3, 'name': '王五', 'age': 28, 'email': 'wangwu@example.com'},
  ];
  
  Map<int, Map<String, TextEditingController>> _controllers = {};
  Set<int> _editingRows = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < _data.length; i++) {
      _controllers[i] = {
        'name': TextEditingController(text: _data[i]['name']),
        'age': TextEditingController(text: _data[i]['age'].toString()),
        'email': TextEditingController(text: _data[i]['email']),
      };
    }
  }

  void _toggleEdit(int index) {
    setState(() {
      if (_editingRows.contains(index)) {
        // 保存编辑
        _data[index]['name'] = _controllers[index]!['name']!.text;
        _data[index]['age'] = int.parse(_controllers[index]!['age']!.text);
        _data[index]['email'] = _controllers[index]!['email']!.text;
        _editingRows.remove(index);
      } else {
        _editingRows.add(index);
      }
    });
  }

  @override
  void dispose() {
    for (var controllers in _controllers.values) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可编辑数据网格'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewRow,
          ),
        ],
      ),
      body: ZephyrDataGrid(
        columns: [
          ZephyrDataGridColumn(
            title: '姓名',
            field: 'name',
            width: 120,
            editable: true,
            cellBuilder: (data) {
              final index = _data.indexOf(data);
              final isEditing = _editingRows.contains(index);
              return isEditing
                  ? TextField(
                      controller: _controllers[index]!['name'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                    )
                  : Text(data['name']);
            },
          ),
          ZephyrDataGridColumn(
            title: '年龄',
            field: 'age',
            width: 80,
            editable: true,
            cellBuilder: (data) {
              final index = _data.indexOf(data);
              final isEditing = _editingRows.contains(index);
              return isEditing
                  ? TextField(
                      controller: _controllers[index]!['age'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      keyboardType: TextInputType.number,
                    )
                  : Text(data['age'].toString());
            },
          ),
          ZephyrDataGridColumn(
            title: '邮箱',
            field: 'email',
            width: 200,
            editable: true,
            cellBuilder: (data) {
              final index = _data.indexOf(data);
              final isEditing = _editingRows.contains(index);
              return isEditing
                  ? TextField(
                      controller: _controllers[index]!['email'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                    )
                  : Text(data['email']);
            },
          ),
          ZephyrDataGridColumn(
            title: '操作',
            field: 'actions',
            width: 100,
            cellBuilder: (data) {
              final index = _data.indexOf(data);
              final isEditing = _editingRows.contains(index);
              return Row(
                children: [
                  IconButton(
                    icon: Icon(isEditing ? Icons.save : Icons.edit),
                    onPressed: () => _toggleEdit(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteRow(index),
                  ),
                ],
              );
            },
          ),
        ],
        data: _data,
      ),
    );
  }

  void _addNewRow() {
    setState(() {
      final newId = _data.isEmpty ? 1 : _data.last['id'] + 1;
      _data.add({
        'id': newId,
        'name': '新用户',
        'age': 25,
        'email': 'newuser@example.com',
      });
      _controllers[_data.length - 1] = {
        'name': TextEditingController(text: '新用户'),
        'age': TextEditingController(text: '25'),
        'email': TextEditingController(text: 'newuser@example.com'),
      };
      _editingRows.add(_data.length - 1);
    });
  }

  void _deleteRow(int index) {
    setState(() {
      _data.removeAt(index);
      _controllers.remove(index);
      _editingRows.remove(index);
      // 重新索引控制器
      final newControllers = <int, Map<String, TextEditingController>>{};
      _controllers.forEach((key, value) {
        if (key > index) {
          newControllers[key - 1] = value;
        } else if (key < index) {
          newControllers[key] = value;
        }
      });
      _controllers = newControllers;
    });
  }
}
```

### 分页数据网格

```dart
class PagedDataGridExample extends StatefulWidget {
  @override
  _PagedDataGridExampleState createState() => _PagedDataGridExampleState();
}

class _PagedDataGridExampleState extends State<PagedDataGridExample> {
  List<Map<String, dynamic>> _allData = [];
  List<Map<String, dynamic>> _currentPageData = [];
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateMockData();
    _loadPageData(1);
  }

  void _generateMockData() {
    _allData = List.generate(100, (index) {
      return {
        'id': index + 1,
        'name': '用户${index + 1}',
        'email': 'user${index + 1}@example.com',
        'department': ['技术部', '市场部', '人事部', '财务部'][index % 4],
        'salary': 5000 + (index * 100),
        'joinDate': DateTime(2020, 1, 1).add(Duration(days: index * 7)),
      };
    });
  }

  Future<void> _loadPageData(int page) async {
    setState(() {
      _isLoading = true;
      _currentPage = page;
    });

    // 模拟网络请求延迟
    await Future.delayed(Duration(milliseconds: 500));

    final startIndex = (page - 1) * _pageSize;
    final endIndex = math.min(startIndex + _pageSize, _allData.length);
    
    setState(() {
      _currentPageData = _allData.sublist(startIndex, endIndex);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分页数据网格'),
      ),
      body: Column(
        children: [
          // 数据统计
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '总记录数: ${_allData.length}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '当前页: $_currentPage',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          
          // 数据网格
          Expanded(
            child: ZephyrDataGrid(
              columns: [
                ZephyrDataGridColumn(
                  title: 'ID',
                  field: 'id',
                  width: 60,
                ),
                ZephyrDataGridColumn(
                  title: '姓名',
                  field: 'name',
                  width: 120,
                ),
                ZephyrDataGridColumn(
                  title: '邮箱',
                  field: 'email',
                  width: 200,
                ),
                ZephyrDataGridColumn(
                  title: '部门',
                  field: 'department',
                  width: 120,
                ),
                ZephyrDataGridColumn(
                  title: '薪资',
                  field: 'salary',
                  width: 120,
                  cellBuilder: (data) {
                    return Text('¥${data['salary']}');
                  },
                ),
                ZephyrDataGridColumn(
                  title: '入职日期',
                  field: 'joinDate',
                  width: 120,
                  cellBuilder: (data) {
                    final date = data['joinDate'] as DateTime;
                    return Text('${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}');
                  },
                ),
              ],
              data: _currentPageData,
              loading: _isLoading,
            ),
          ),
          
          // 分页控件
          Container(
            padding: EdgeInsets.all(16),
            child: ZephyrPagination(
              currentPage: _currentPage,
              totalItems: _allData.length,
              itemsPerPage: _pageSize,
              onPageChanged: _isLoading ? null : _loadPageData,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 树形数据网格

```dart
class TreeDataGridExample extends StatefulWidget {
  @override
  _TreeDataGridExampleState createState() => _TreeDataGridExampleState();
}

class _TreeDataGridExampleState extends State<TreeDataGridExample> {
  List<Map<String, dynamic>> _data = [];
  Set<int> _expandedRows = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _data = [
      {
        'id': 1,
        'name': '技术部',
        'type': 'department',
        'employees': 25,
        'budget': '¥500,000',
        'level': 0,
        'children': [
          {
            'id': 2,
            'name': '前端组',
            'type': 'team',
            'employees': 8,
            'budget': '¥150,000',
            'level': 1,
            'children': [
              {
                'id': 3,
                'name': '张三',
                'type': 'person',
                'employees': 1,
                'budget': '¥20,000',
                'level': 2,
              },
              {
                'id': 4,
                'name': '李四',
                'type': 'person',
                'employees': 1,
                'budget': '¥18,000',
                'level': 2,
              },
            ],
          },
          {
            'id': 5,
            'name': '后端组',
            'type': 'team',
            'employees': 12,
            'budget': '¥250,000',
            'level': 1,
            'children': [
              {
                'id': 6,
                'name': '王五',
                'type': 'person',
                'employees': 1,
                'budget': '¥25,000',
                'level': 2,
              },
            ],
          },
        ],
      },
    ];
  }

  List<Map<String, dynamic>> _flattenData(List<Map<String, dynamic>> data, [int parentLevel = -1]) {
    List<Map<String, dynamic>> result = [];
    
    for (var item in data) {
      final itemWithLevel = Map<String, dynamic>.from(item);
      itemWithLevel['level'] = parentLevel + 1;
      itemWithLevel['isExpanded'] = _expandedRows.contains(item['id']);
      result.add(itemWithLevel);
      
      if (item['children'] != null && _expandedRows.contains(item['id'])) {
        result.addAll(_flattenData(item['children'], itemWithLevel['level']));
      }
    }
    
    return result;
  }

  void _toggleExpand(int id) {
    setState(() {
      if (_expandedRows.contains(id)) {
        _expandedRows.remove(id);
      } else {
        _expandedRows.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final flattenedData = _flattenData(_data);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('树形数据网格'),
      ),
      body: ZephyrDataGrid(
        columns: [
          ZephyrDataGridColumn(
            title: '名称',
            field: 'name',
            width: 200,
            cellBuilder: (data) {
              final level = data['level'];
              final hasChildren = data['children'] != null;
              final isExpanded = data['isExpanded'];
              
              return Row(
                children: [
                  SizedBox(width: level * 20.0),
                  if (hasChildren)
                    IconButton(
                      icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () => _toggleExpand(data['id']),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    )
                  else
                    SizedBox(width: 24),
                  Icon(
                    data['type'] == 'department' ? Icons.business :
                    data['type'] == 'team' ? Icons.group :
                    Icons.person,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text(data['name'])),
                ],
              );
            },
          ),
          ZephyrDataGridColumn(
            title: '类型',
            field: 'type',
            width: 100,
            cellBuilder: (data) {
              final type = data['type'];
              String displayType;
              switch (type) {
                case 'department':
                  displayType = '部门';
                  break;
                case 'team':
                  displayType = '团队';
                  break;
                case 'person':
                  displayType = '人员';
                  break;
                default:
                  displayType = type;
              }
              return Text(displayType);
            },
          ),
          ZephyrDataGridColumn(
            title: '人数',
            field: 'employees',
            width: 80,
          ),
          ZephyrDataGridColumn(
            title: '预算',
            field: 'budget',
            width: 120,
          ),
        ],
        data: flattenedData,
      ),
    );
  }
}
```

### 选择数据网格

```dart
class SelectionDataGridExample extends StatefulWidget {
  @override
  _SelectionDataGridExampleState createState() => _SelectionDataGridExampleState();
}

class _SelectionDataGridExampleState extends State<SelectionDataGridExample> {
  List<Map<String, dynamic>> _data = [
    {'id': 1, 'name': '张三', 'department': '技术部', 'position': '前端工程师'},
    {'id': 2, 'name': '李四', 'department': '市场部', 'position': '市场经理'},
    {'id': 3, 'name': '王五', 'department': '技术部', 'position': '后端工程师'},
    {'id': 4, 'name': '赵六', 'department': '人事部', 'position': 'HR专员'},
    {'id': 5, 'name': '钱七', 'department': '财务部', 'position': '会计'},
  ];
  
  Set<int> _selectedRows = {};
  bool _isSelectionMode = false;

  void _toggleSelection(int id) {
    setState(() {
      if (_selectedRows.contains(id)) {
        _selectedRows.remove(id);
        if (_selectedRows.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedRows.add(id);
        _isSelectionMode = true;
      }
    });
  }

  void _selectAll() {
    setState(() {
      _selectedRows = Set.from(_data.map((item) => item['id']));
      _isSelectionMode = true;
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedRows.clear();
      _isSelectionMode = false;
    });
  }

  void _deleteSelected() {
    setState(() {
      _data.removeWhere((item) => _selectedRows.contains(item['id']));
      _selectedRows.clear();
      _isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode ? '已选择 ${_selectedRows.length} 项' : '选择数据网格'),
        actions: _isSelectionMode
            ? [
                IconButton(
                  icon: Icon(Icons.select_all),
                  onPressed: _selectedRows.length < _data.length ? _selectAll : null,
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
      body: ZephyrDataGrid(
        columns: [
          ZephyrDataGridColumn(
            title: '选择',
            field: 'select',
            width: 60,
            cellBuilder: (data) {
              final id = data['id'];
              return Checkbox(
                value: _selectedRows.contains(id),
                onChanged: (value) {
                  _toggleSelection(id);
                },
              );
            },
          ),
          ZephyrDataGridColumn(
            title: '姓名',
            field: 'name',
            width: 120,
          ),
          ZephyrDataGridColumn(
            title: '部门',
            field: 'department',
            width: 120,
          ),
          ZephyrDataGridColumn(
            title: '职位',
            field: 'position',
            width: 150,
          ),
        ],
        data: _data,
        style: ZephyrDataGridStyle(
          selectedRowStyle: ZephyrDataGridRowStyle(
            backgroundColor: Colors.blue[50],
          ),
        ),
        onRowTap: (data) {
          if (_isSelectionMode) {
            _toggleSelection(data['id']);
          }
        },
        selectedRows: _selectedRows,
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrDataGrid()

```dart
const ZephyrDataGrid({
  Key? key,
  required List<ZephyrDataGridColumn> columns,
  required List<Map<String, dynamic>> data,
  ZephyrDataGridStyle? style,
  bool showHeader = true,
  bool showFooter = false,
  Widget Function()? footerBuilder,
  bool loading = false,
  Widget Function()? loadingBuilder,
  Widget Function()? placeholderBuilder,
  Widget Function()? errorBuilder,
  bool stripedRows = false,
  Color? stripeColor,
  double? rowHeight,
  double? headerHeight,
  double? footerHeight,
  bool horizontalScroll = false,
  bool verticalScroll = true,
  EdgeInsetsGeometry? padding,
  Set<int>? selectedRows,
  ValueChanged<Map<String, dynamic>>? onRowTap,
  ValueChanged<Map<String, dynamic>>? onRowDoubleTap,
  ValueChanged<Map<String, dynamic>>? onRowLongPress,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `columns`: 列定义
- `data`: 数据
- `style`: 数据网格样式
- `showHeader`: 是否显示表头
- `showFooter`: 是否显示表尾
- `footerBuilder`: 表尾构建器
- `loading`: 是否加载中
- `loadingBuilder`: 加载状态构建器
- `placeholderBuilder`: 空数据占位符构建器
- `errorBuilder`: 错误状态构建器
- `stripedRows`: 是否显示斑马纹
- `stripeColor`: 斑马纹颜色
- `rowHeight`: 行高
- `headerHeight`: 表头高度
- `footerHeight`: 表尾高度
- `horizontalScroll`: 是否水平滚动
- `verticalScroll`: 是否垂直滚动
- `padding`: 内边距
- `selectedRows`: 选中的行
- `onRowTap`: 行点击回调
- `onRowDoubleTap`: 行双击回调
- `onRowLongPress`: 行长按回调
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrDataGridColumn()

```dart
const ZephyrDataGridColumn({
  Key? key,
  required String title,
  required String field,
  double? width,
  double? minWidth,
  double? maxWidth,
  bool sortable = false,
  SortDirection sortDirection = SortDirection.none,
  ValueChanged<String>? onSort,
  bool editable = false,
  Widget Function(Map<String, dynamic>)? cellBuilder,
  Widget Function(bool)? headerBuilder,
  TextAlign textAlign = TextAlign.left,
  bool fixed = false,
  bool resizable = false,
  bool hideable = false,
  String? tooltip,
  String? semanticLabel,
})
```

### 枚举类型

#### SortDirection

```dart
enum SortDirection {
  none,       // 无排序
  ascending,  // 升序
  descending, // 降序
}
```

### 样式类

#### ZephyrDataGridStyle

```dart
class ZephyrDataGridStyle {
  final ZephyrDataGridHeaderStyle? headerStyle;
  final ZephyrDataGridCellStyle? cellStyle;
  final ZephyrDataGridFooterStyle? footerStyle;
  final ZephyrDataGridRowStyle? rowStyle;
  final ZephyrDataGridRowStyle? selectedRowStyle;
  final ZephyrDataGridRowStyle? hoverRowStyle;
  final DataGridBorderStyle? borderStyle;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? elevation;
  final bool stripedRows;
  final Color? stripeColor;
  final bool compact;
  final double? rowHeight;
  final EdgeInsetsGeometry? padding;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrDataGridTheme(
        defaultHeaderStyle: ZephyrDataGridHeaderStyle(
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black87,
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 48,
          showSortIcon: true,
        ),
        defaultCellStyle: ZephyrDataGridCellStyle(
          backgroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 14),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textAlign: TextAlign.left,
          hoverColor: Colors.grey[50],
          selectedColor: Colors.blue[50],
        ),
        defaultFooterStyle: ZephyrDataGridFooterStyle(
          backgroundColor: Colors.grey[50],
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 48,
        ),
        defaultBorderStyle: DataGridBorderStyle(
          all: BorderSide(color: Colors.grey[300]!),
          horizontalInside: BorderSide(color: Colors.grey[200]!),
          verticalInside: BorderSide(color: Colors.grey[200]!),
        ),
        defaultRowStyle: ZephyrDataGridRowStyle(
          height: 48,
        ),
        defaultSelectedRowStyle: ZephyrDataGridRowStyle(
          backgroundColor: Colors.blue[50],
        ),
        defaultHoverRowStyle: ZephyrDataGridRowStyle(
          backgroundColor: Colors.grey[50],
        ),
        defaultBorderRadius: BorderRadius.circular(8),
        defaultElevation: 1,
        defaultRowHeight: 48,
        defaultHeaderHeight: 48,
        defaultFooterHeight: 48,
        stripeColor: Colors.grey[50],
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

- `defaultHeaderStyle`: 默认表头样式
- `defaultCellStyle`: 默认单元格样式
- `defaultFooterStyle`: 默认表尾样式
- `defaultRowStyle`: 默认行样式
- `defaultSelectedRowStyle`: 默认选中行样式
- `defaultHoverRowStyle`: 默认悬停行样式
- `defaultBorderStyle`: 默认边框样式
- `defaultBorderRadius`: 默认边框圆角
- `defaultElevation`: 默认阴影高度
- `defaultRowHeight`: 默认行高
- `defaultHeaderHeight`: 默认表头高度
- `defaultFooterHeight`: 默认表尾高度
- `stripeColor`: 斑马纹颜色
- `padding`: 内边距
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的列宽设置

```dart
// ✅ 好的做法：根据内容设置合适的列宽
ZephyrDataGrid(
  columns: [
    ZephyrDataGridColumn(
      title: 'ID',
      field: 'id',
      width: 60, // 固定宽度适合短内容
    ),
    ZephyrDataGridColumn(
      title: '产品名称',
      field: 'productName',
      width: 150, // 适中宽度适合中等长度内容
    ),
    ZephyrDataGridColumn(
      title: '描述',
      field: 'description',
      minWidth: 200, // 最小宽度确保可读性
    ),
  ],
  data: _data,
)

// ✅ 好的做法：使用可调整列宽
ZephyrDataGrid(
  columns: [
    ZephyrDataGridColumn(
      title: '名称',
      field: 'name',
      resizable: true, // 允许用户调整列宽
      minWidth: 100,
      maxWidth: 300,
    ),
  ],
  data: _data,
)

// ❌ 避免的做法：列宽过小导致内容溢出
ZephyrDataGrid(
  columns: [
    ZephyrDataGridColumn(
      title: '产品描述',
      field: 'description',
      width: 50, // 宽度过小，内容会被截断
    ),
  ],
  data: _data,
)
```

### 2. 性能优化

```dart
// ✅ 好的做法：使用分页处理大数据量
class PagedDataGrid extends StatefulWidget {
  @override
  _PagedDataGridState createState() => _PagedDataGridState();
}

class _PagedDataGridState extends State<PagedDataGrid> {
  int _currentPage = 1;
  final int _pageSize = 50;
  List<Map<String, dynamic>> _currentPageData = [];

  Future<void> _loadPageData(int page) async {
    final data = await _fetchDataFromAPI(page, _pageSize);
    setState(() => _currentPageData = data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ZephyrDataGrid(
            columns: _buildColumns(),
            data: _currentPageData,
          ),
        ),
        ZephyrPagination(
          currentPage: _currentPage,
          totalItems: 1000,
          itemsPerPage: _pageSize,
          onPageChanged: _loadPageData,
        ),
      ],
    );
  }
}

// ✅ 好的做法：使用懒加载
ZephyrDataGrid(
  data: _data,
  lazyLoading: true,
  onLoadMore: () async {
    final moreData = await _loadMoreData();
    setState(() => _data.addAll(moreData));
  },
)

// ❌ 避免的做法：一次性加载大量数据
ZephyrDataGrid(
  data: _largeDataSet, // 可能导致性能问题
  columns: _columns,
)
```

### 3. 用户体验优化

```dart
// ✅ 好的做法：提供排序和筛选功能
ZephyrDataGrid(
  columns: [
    ZephyrDataGridColumn(
      title: '姓名',
      field: 'name',
      sortable: true, // 允许排序
    ),
    ZephyrDataGridColumn(
      title: '状态',
      field: 'status',
      filterable: true, // 允许筛选
    ),
  ],
  data: _data,
)

// ✅ 好的做法：显示加载状态
ZephyrDataGrid(
  data: _isLoading ? [] : _data,
  loading: _isLoading,
  loadingBuilder: () {
    return Center(child: CircularProgressIndicator());
  },
)

// ✅ 好的做法：响应式设计
ZephyrDataGrid(
  columns: _buildResponsiveColumns(),
  horizontalScroll: true, // 允许水平滚动
  data: _data,
)

// ❌ 避免的做法：缺乏交互功能
ZephyrDataGrid(
  columns: [
    ZephyrDataGridColumn(
      title: '数据',
      field: 'data',
      // 缺乏排序和筛选功能
    ),
  ],
  data: _data,
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrDataGrid(
  semanticLabel: '用户数据表格',
  columns: [
    ZephyrDataGridColumn(
      title: '姓名',
      field: 'name',
      semanticLabel: '用户姓名列',
    ),
    ZephyrDataGridColumn(
      title: '邮箱',
      field: 'email',
      semanticLabel: '用户邮箱列',
    ),
  ],
  data: _data,
  enableAccessibilityFeatures: true,
)

// ✅ 好的做法：为操作按钮提供描述
ZephyrDataGridColumn(
  title: '操作',
  field: 'actions',
  cellBuilder: (data) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => _editUser(data),
      tooltip: '编辑用户 ${data['name']}',
    );
  },
)

// ❌ 避免的做法：缺乏语义信息
ZephyrDataGrid(
  columns: [
    ZephyrDataGridColumn(
      title: '数据',
      field: 'data',
      // 缺乏语义信息
    ),
  ],
  data: _data,
)
```

## 🔄 相关组件

- **ZephyrTable**: 表格组件
- **ZephyrList**: 列表组件
- **ZephyrPagination**: 分页组件
- **ZephyrCard**: 卡片组件
- **ZephyrContainer`: 容器组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本数据网格功能
- ✅ 支持排序和筛选
- ✅ 支持编辑和选择
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/data_grid/`
**示例路径**: `example/lib/components/data_grid_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日