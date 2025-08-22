# ZephyrTable 表格组件

表格组件是ZephyrUI展示系统中的核心组件，提供了强大的数据展示和管理功能。支持多种表格模式、排序、筛选、分页等高级功能，是构建数据管理、报表展示、数据分析等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种表格模式**: 支持基本表格、复杂表格、数据网格等多种模式
- **灵活布局**: 支持固定列、可滚动列、列宽调整等布局方式
- **丰富交互**: 支持排序、筛选、搜索、编辑等交互功能
- **响应式设计**: 根据屏幕尺寸自动调整表格布局
- **性能优化**: 支持虚拟化和延迟加载
- **主题适配**: 完整的主题系统支持

### 适用场景
- 数据管理系统
- 报表展示
- 数据分析工具
- 用户管理界面
- 产品列表展示
- 财务数据展示

## 🚀 基础用法

### 基本表格

```dart
class BasicTableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本表格'),
      ),
      body: ZephyrTable(
        columns: [
          ZephyrTableColumn(
            title: '姓名',
            field: 'name',
            width: 120,
          ),
          ZephyrTableColumn(
            title: '年龄',
            field: 'age',
            width: 80,
          ),
          ZephyrTableColumn(
            title: '邮箱',
            field: 'email',
            width: 200,
          ),
          ZephyrTableColumn(
            title: '状态',
            field: 'status',
            width: 100,
          ),
        ],
        data: [
          {
            'name': '张三',
            'age': 25,
            'email': 'zhangsan@example.com',
            'status': '活跃',
          },
          {
            'name': '李四',
            'age': 30,
            'email': 'lisi@example.com',
            'status': '离线',
          },
          {
            'name': '王五',
            'age': 28,
            'email': 'wangwu@example.com',
            'status': '忙碌',
          },
        ],
      ),
    );
  }
}
```

### 带排序的表格

```dart
class SortableTableExample extends StatefulWidget {
  @override
  _SortableTableExampleState createState() => _SortableTableExampleState();
}

class _SortableTableExampleState extends State<SortableTableExample> {
  List<Map<String, dynamic>> _data = [
    {'name': '张三', 'age': 25, 'score': 85},
    {'name': '李四', 'age': 30, 'score': 92},
    {'name': '王五', 'age': 28, 'score': 78},
    {'name': '赵六', 'age': 22, 'score': 88},
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
        title: Text('带排序的表格'),
      ),
      body: ZephyrTable(
        columns: [
          ZephyrTableColumn(
            title: '姓名',
            field: 'name',
            sortable: true,
            sortDirection: _sortField == 'name' 
                ? (_sortAscending ? SortDirection.ascending : SortDirection.descending)
                : SortDirection.none,
            onSort: () => _handleSort('name'),
          ),
          ZephyrTableColumn(
            title: '年龄',
            field: 'age',
            sortable: true,
            sortDirection: _sortField == 'age' 
                ? (_sortAscending ? SortDirection.ascending : SortDirection.descending)
                : SortDirection.none,
            onSort: () => _handleSort('age'),
          ),
          ZephyrTableColumn(
            title: '分数',
            field: 'score',
            sortable: true,
            sortDirection: _sortField == 'score' 
                ? (_sortAscending ? SortDirection.ascending : SortDirection.descending)
                : SortDirection.none,
            onSort: () => _handleSort('score'),
          ),
        ],
        data: _data,
      ),
    );
  }
}
```

### 带筛选的表格

```dart
class FilterableTableExample extends StatefulWidget {
  @override
  _FilterableTableExampleState createState() => _FilterableTableExampleState();
}

class _FilterableTableExampleState extends State<FilterableTableExample> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allData = [];
  List<Map<String, dynamic>> _filteredData = [];
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _searchController.addListener(_filterData);
  }

  void _initializeData() {
    _allData = [
      {'name': '张三', 'department': '技术部', 'status': '活跃'},
      {'name': '李四', 'department': '市场部', 'status': '离线'},
      {'name': '王五', 'department': '技术部', 'status': '忙碌'},
      {'name': '赵六', 'department': '人事部', 'status': '活跃'},
      {'name': '钱七', 'department': '财务部', 'status': '离线'},
    ];
    _filteredData = List.from(_allData);
  }

  void _filterData() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = _allData.where((item) {
        final matchesSearch = item['name'].toLowerCase().contains(query) ||
            item['department'].toLowerCase().contains(query);
        final matchesStatus = _selectedStatus == null || item['status'] == _selectedStatus;
        return matchesSearch && matchesStatus;
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
        title: Text('带筛选的表格'),
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
                    labelText: '搜索姓名或部门',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // 状态筛选
                Row(
                  children: [
                    Text('状态筛选：'),
                    SizedBox(width: 16),
                    FilterChip(
                      label: Text('全部'),
                      selected: _selectedStatus == null,
                      onSelected: (selected) {
                        setState(() {
                          _selectedStatus = selected ? null : _selectedStatus;
                          _filterData();
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    FilterChip(
                      label: Text('活跃'),
                      selected: _selectedStatus == '活跃',
                      onSelected: (selected) {
                        setState(() {
                          _selectedStatus = selected ? '活跃' : null;
                          _filterData();
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    FilterChip(
                      label: Text('离线'),
                      selected: _selectedStatus == '离线',
                      onSelected: (selected) {
                        setState(() {
                          _selectedStatus = selected ? '离线' : null;
                          _filterData();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 表格
          Expanded(
            child: ZephyrTable(
              columns: [
                ZephyrTableColumn(
                  title: '姓名',
                  field: 'name',
                  width: 120,
                ),
                ZephyrTableColumn(
                  title: '部门',
                  field: 'department',
                  width: 120,
                ),
                ZephyrTableColumn(
                  title: '状态',
                  field: 'status',
                  width: 100,
                  cellBuilder: (data) {
                    final status = data['status'];
                    Color color;
                    switch (status) {
                      case '活跃':
                        color = Colors.green;
                        break;
                      case '忙碌':
                        color = Colors.orange;
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

### 斑马纹表格

```dart
class StripedTableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('斑马纹表格'),
      ),
      body: ZephyrTable(
        columns: [
          ZephyrTableColumn(
            title: '产品名称',
            field: 'product',
            width: 150,
          ),
          ZephyrTableColumn(
            title: '价格',
            field: 'price',
            width: 100,
          ),
          ZephyrTableColumn(
            title: '库存',
            field: 'stock',
            width: 80,
          ),
          ZephyrTableColumn(
            title: '销量',
            field: 'sales',
            width: 80,
          ),
        ],
        data: [
          {'product': 'iPhone 14', 'price': '¥5999', 'stock': 100, 'sales': 1500},
          {'product': 'Samsung S23', 'price': '¥4999', 'stock': 80, 'sales': 1200},
          {'product': '小米13', 'price': '¥3999', 'stock': 150, 'sales': 800},
          {'product': '华为P60', 'price': '¥4499', 'stock': 60, 'sales': 600},
        ],
        style: ZephyrTableStyle(
          stripedRows: true,
          stripeColor: Colors.grey[50],
          headerStyle: ZephyrTableHeaderStyle(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          cellStyle: ZephyrTableCellStyle(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: TextStyle(fontSize: 14),
          ),
          borderStyle: TableBorderStyle(
            all: BorderSide(color: Colors.grey[300]!),
            horizontalInside: BorderSide(color: Colors.grey[200]!),
          ),
        ),
      ),
    );
  }
}
```

### 紧凑型表格

```dart
class CompactTableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紧凑型表格'),
      ),
      body: ZephyrTable(
        columns: [
          ZephyrTableColumn(
            title: 'ID',
            field: 'id',
            width: 60,
          ),
          ZephyrTableColumn(
            title: '用户名',
            field: 'username',
            width: 100,
          ),
          ZephyrTableColumn(
            title: '邮箱',
            field: 'email',
            width: 150,
          ),
          ZephyrTableColumn(
            title: '注册时间',
            field: 'registerTime',
            width: 120,
          ),
          ZephyrTableColumn(
            title: '最后登录',
            field: 'lastLogin',
            width: 120,
          ),
        ],
        data: List.generate(20, (index) => {
          return {
            'id': '${index + 1}',
            'username': 'user${index + 1}',
            'email': 'user${index + 1}@example.com',
            'registerTime': '2023-01-${index + 1}',
            'lastLogin': '2023-08-${index + 1}',
          };
        }),
        style: ZephyrTableStyle(
          compact: true,
          headerStyle: ZephyrTableHeaderStyle(
            backgroundColor: Colors.grey[100],
            textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          ),
          cellStyle: ZephyrTableCellStyle(
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

### 圆角表格

```dart
class RoundedTableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆角表格'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ZephyrTable(
          columns: [
            ZephyrTableColumn(
              title: '项目',
              field: 'project',
              width: 120,
            ),
            ZephyrTableColumn(
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
            ZephyrTableColumn(
              title: '状态',
              field: 'status',
              width: 100,
            ),
          ],
          data: [
            {'project': '网站重构', 'progress': '75%', 'status': '进行中'},
            {'project': '移动应用', 'progress': '90%', 'status': '即将完成'},
            {'project': '数据库优化', 'progress': '45%', 'status': '进行中'},
            {'project': 'UI设计', 'progress': '100%', 'status': '已完成'},
          ],
          style: ZephyrTableStyle(
            borderRadius: BorderRadius.circular(12),
            headerStyle: ZephyrTableHeaderStyle(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            cellStyle: ZephyrTableCellStyle(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              textStyle: TextStyle(fontSize: 14),
            ),
            borderStyle: TableBorderStyle(
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

### 可编辑表格

```dart
class EditableTableExample extends StatefulWidget {
  @override
  _EditableTableExampleState createState() => _EditableTableExampleState();
}

class _EditableTableExampleState extends State<EditableTableExample> {
  List<Map<String, dynamic>> _data = [
    {'name': '张三', 'age': 25, 'email': 'zhangsan@example.com'},
    {'name': '李四', 'age': 30, 'email': 'lisi@example.com'},
    {'name': '王五', 'age': 28, 'email': 'wangwu@example.com'},
  ];
  
  Map<String, TextEditingController> _controllers = {};
  Set<int> _editingRows = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < _data.length; i++) {
      _controllers['name_$i'] = TextEditingController(text: _data[i]['name']);
      _controllers['age_$i'] = TextEditingController(text: _data[i]['age'].toString());
      _controllers['email_$i'] = TextEditingController(text: _data[i]['email']);
    }
  }

  void _toggleEdit(int index) {
    setState(() {
      if (_editingRows.contains(index)) {
        // 保存编辑
        _data[index]['name'] = _controllers['name_$index']!.text;
        _data[index]['age'] = int.parse(_controllers['age_$index']!.text);
        _data[index]['email'] = _controllers['email_$index']!.text;
        _editingRows.remove(index);
      } else {
        _editingRows.add(index);
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可编辑表格'),
      ),
      body: ZephyrTable(
        columns: [
          ZephyrTableColumn(
            title: '姓名',
            field: 'name',
            width: 120,
            cellBuilder: (data) {
              final index = _data.indexOf(data);
              final isEditing = _editingRows.contains(index);
              return isEditing
                  ? TextField(
                      controller: _controllers['name_$index'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                    )
                  : Text(data['name']);
            },
          ),
          ZephyrTableColumn(
            title: '年龄',
            field: 'age',
            width: 80,
            cellBuilder: (data) {
              final index = _data.indexOf(data);
              final isEditing = _editingRows.contains(index);
              return isEditing
                  ? TextField(
                      controller: _controllers['age_$index'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      keyboardType: TextInputType.number,
                    )
                  : Text(data['age'].toString());
            },
          ),
          ZephyrTableColumn(
            title: '邮箱',
            field: 'email',
            width: 200,
            cellBuilder: (data) {
              final index = _data.indexOf(data);
              final isEditing = _editingRows.contains(index);
              return isEditing
                  ? TextField(
                      controller: _controllers['email_$index'],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                    )
                  : Text(data['email']);
            },
          ),
          ZephyrTableColumn(
            title: '操作',
            field: 'actions',
            width: 100,
            cellBuilder: (data) {
              final index = _data.indexOf(data);
              final isEditing = _editingRows.contains(index);
              return IconButton(
                icon: Icon(isEditing ? Icons.save : Icons.edit),
                onPressed: () => _toggleEdit(index),
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

### 固定列表格

```dart
class FixedColumnTableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('固定列表格'),
      ),
      body: ZephyrTable(
        columns: [
          ZephyrTableColumn(
            title: 'ID',
            field: 'id',
            width: 60,
            fixed: true,
          ),
          ZephyrTableColumn(
            title: '产品名称',
            field: 'productName',
            width: 150,
          ),
          ZephyrTableColumn(
            title: '分类',
            field: 'category',
            width: 100,
          ),
          ZephyrTableColumn(
            title: '价格',
            field: 'price',
            width: 100,
          ),
          ZephyrTableColumn(
            title: '库存',
            field: 'stock',
            width: 80,
          ),
          ZephyrTableColumn(
            title: '销量',
            field: 'sales',
            width: 80,
          ),
          ZephyrTableColumn(
            title: '评分',
            field: 'rating',
            width: 80,
          ),
          ZephyrTableColumn(
            title: '状态',
            field: 'status',
            width: 100,
            fixed: true,
          ),
        ],
        data: List.generate(10, (index) => {
          return {
            'id': '${index + 1}',
            'productName': '产品 ${index + 1}',
            'category': '分类${(index % 3) + 1}',
            'price': '¥${(index + 1) * 100}',
            'stock': (index + 1) * 10,
            'sales': (index + 1) * 50,
            'rating': (4.0 + (index % 5) * 0.2).toStringAsFixed(1),
            'status': index % 2 == 0 ? '在售' : '缺货',
          };
        }),
        style: ZephyrTableStyle(
          headerStyle: ZephyrTableHeaderStyle(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          fixedColumnStyle: ZephyrTableColumnStyle(
            backgroundColor: Colors.grey[100],
            border: Border(
              right: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ),
    );
  }
}
```

### 树形数据表格

```dart
class TreeTableExample extends StatefulWidget {
  @override
  _TreeTableExampleState createState() => _TreeTableExampleState();
}

class _TreeTableExampleState extends State<TreeTableExample> {
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
        title: Text('树形数据表格'),
      ),
      body: ZephyrTable(
        columns: [
          ZephyrTableColumn(
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
          ZephyrTableColumn(
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
          ZephyrTableColumn(
            title: '人数',
            field: 'employees',
            width: 80,
          ),
          ZephyrTableColumn(
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

### 带统计信息的表格

```dart
class SummaryTableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = [
      {'product': '产品A', 'q1': 100, 'q2': 120, 'q3': 140, 'q4': 160},
      {'product': '产品B', 'q1': 80, 'q2': 90, 'q3': 110, 'q4': 130},
      {'product': '产品C', 'q1': 60, 'q2': 70, 'q3': 85, 'q4': 95},
      {'product': '产品D', 'q1': 40, 'q2': 50, 'q3': 60, 'q4': 70},
    ];
    
    // 计算统计信息
    final totals = {
      'q1': data.fold(0, (sum, item) => sum + item['q1'] as int),
      'q2': data.fold(0, (sum, item) => sum + item['q2'] as int),
      'q3': data.fold(0, (sum, item) => sum + item['q3'] as int),
      'q4': data.fold(0, (sum, item) => sum + item['q4'] as int),
    };
    
    final averages = {
      'q1': (totals['q1']! / data.length).round(),
      'q2': (totals['q2']! / data.length).round(),
      'q3': (totals['q3']! / data.length).round(),
      'q4': (totals['q4']! / data.length).round(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('带统计信息的表格'),
      ),
      body: ZephyrTable(
        columns: [
          ZephyrTableColumn(
            title: '产品',
            field: 'product',
            width: 100,
          ),
          ZephyrTableColumn(
            title: 'Q1',
            field: 'q1',
            width: 80,
            cellBuilder: (data) {
              final value = data['q1'];
              return _buildStatCell(value, averages['q1']!);
            },
          ),
          ZephyrTableColumn(
            title: 'Q2',
            field: 'q2',
            width: 80,
            cellBuilder: (data) {
              final value = data['q2'];
              return _buildStatCell(value, averages['q2']!);
            },
          ),
          ZephyrTableColumn(
            title: 'Q3',
            field: 'q3',
            width: 80,
            cellBuilder: (data) {
              final value = data['q3'];
              return _buildStatCell(value, averages['q3']!);
            },
          ),
          ZephyrTableColumn(
            title: 'Q4',
            field: 'q4',
            width: 80,
            cellBuilder: (data) {
              final value = data['q4'];
              return _buildStatCell(value, averages['q4']!);
            },
          ),
          ZephyrTableColumn(
            title: '总计',
            field: 'total',
            width: 80,
            cellBuilder: (data) {
              final total = data['q1'] + data['q2'] + data['q3'] + data['q4'];
              return Text(
                total.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            },
          ),
        ],
        data: data,
        showFooter: true,
        footerBuilder: () {
          return [
            {
              'product': '总计',
              'q1': totals['q1'],
              'q2': totals['q2'],
              'q3': totals['q3'],
              'q4': totals['q4'],
              'total': totals['q1']! + totals['q2']! + totals['q3']! + totals['q4']!,
            },
            {
              'product': '平均',
              'q1': averages['q1'],
              'q2': averages['q2'],
              'q3': averages['q3'],
              'q4': averages['q4'],
              'total': (averages['q1']! + averages['q2']! + averages['q3']! + averages['q4']!),
            },
          ];
        },
        style: ZephyrTableStyle(
          headerStyle: ZephyrTableHeaderStyle(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          footerStyle: ZephyrTableFooterStyle(
            backgroundColor: Colors.grey[100],
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCell(int value, int average) {
    final isAboveAverage = value > average;
    final isBelowAverage = value < average;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAboveAverage ? Colors.green[50] : 
               isBelowAverage ? Colors.red[50] : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value.toString(),
        style: TextStyle(
          color: isAboveAverage ? Colors.green :
                 isBelowAverage ? Colors.red : Colors.black,
          fontWeight: isAboveAverage || isBelowAverage ? FontWeight.bold : null,
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrTable()

```dart
const ZephyrTable({
  Key? key,
  required List<ZephyrTableColumn> columns,
  required List<Map<String, dynamic>> data,
  ZephyrTableStyle? style,
  bool showHeader = true,
  bool showFooter = false,
  List<Map<String, dynamic>> Function()? footerBuilder,
  Widget Function(Map<String, dynamic>)? rowBuilder,
  Widget Function(int)? placeholderBuilder,
  bool stripedRows = false,
  Color? stripeColor,
  double? rowHeight,
  double? headerHeight,
  double? footerHeight,
  bool horizontalScroll = false,
  bool verticalScroll = true,
  EdgeInsetsGeometry? padding,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `columns`: 表格列定义
- `data`: 表格数据
- `style`: 表格样式
- `showHeader`: 是否显示表头
- `showFooter`: 是否显示表尾
- `footerBuilder`: 表尾数据构建器
- `rowBuilder`: 行构建器
- `placeholderBuilder`: 空数据占位符构建器
- `stripedRows`: 是否显示斑马纹
- `stripeColor`: 斑马纹颜色
- `rowHeight`: 行高
- `headerHeight`: 表头高度
- `footerHeight`: 表尾高度
- `horizontalScroll`: 是否水平滚动
- `verticalScroll`: 是否垂直滚动
- `padding`: 内边距
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrTableColumn()

```dart
const ZephyrTableColumn({
  Key? key,
  required String title,
  required String field,
  double? width,
  double? minWidth,
  double? maxWidth,
  bool sortable = false,
  SortDirection sortDirection = SortDirection.none,
  ValueChanged<String>? onSort,
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

#### ZephyrTableStyle

```dart
class ZephyrTableStyle {
  final ZephyrTableHeaderStyle? headerStyle;
  final ZephyrTableCellStyle? cellStyle;
  final ZephyrTableFooterStyle? footerStyle;
  final ZephyrTableColumnStyle? fixedColumnStyle;
  final TableBorderStyle? borderStyle;
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

#### ZephyrTableHeaderStyle

```dart
class ZephyrTableHeaderStyle {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final FontWeight? fontWeight;
  final bool showSortIcon;
}
```

#### ZephyrTableCellStyle

```dart
class ZephyrTableCellStyle {
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;
  final Color? hoverColor;
  final Color? selectedColor;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrTableTheme(
        defaultHeaderStyle: ZephyrTableHeaderStyle(
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
        defaultCellStyle: ZephyrTableCellStyle(
          backgroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 14),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textAlign: TextAlign.left,
          hoverColor: Colors.grey[50],
          selectedColor: Colors.blue[50],
        ),
        defaultFooterStyle: ZephyrTableFooterStyle(
          backgroundColor: Colors.grey[50],
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 48,
        ),
        defaultBorderStyle: TableBorderStyle(
          all: BorderSide(color: Colors.grey[300]!),
          horizontalInside: BorderSide(color: Colors.grey[200]!),
          verticalInside: BorderSide(color: Colors.grey[200]!),
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
ZephyrTable(
  columns: [
    ZephyrTableColumn(
      title: 'ID',
      field: 'id',
      width: 60, // 固定宽度适合短内容
    ),
    ZephyrTableColumn(
      title: '产品名称',
      field: 'productName',
      width: 150, // 适中宽度适合中等长度内容
    ),
    ZephyrTableColumn(
      title: '描述',
      field: 'description',
      minWidth: 200, // 最小宽度确保可读性
    ),
  ],
  data: _data,
)

// ✅ 好的做法：使用可调整列宽
ZephyrTable(
  columns: [
    ZephyrTableColumn(
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
ZephyrTable(
  columns: [
    ZephyrTableColumn(
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
class PaginatedTable extends StatefulWidget {
  @override
  _PaginatedTableState createState() => _PaginatedTableState();
}

class _PaginatedTableState extends State<PaginatedTable> {
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
          child: ZephyrTable(
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
ZephyrTable(
  data: _data,
  lazyLoading: true,
  onLoadMore: () async {
    final moreData = await _loadMoreData();
    setState(() => _data.addAll(moreData));
  },
)

// ❌ 避免的做法：一次性加载大量数据
ZephyrTable(
  data: _largeDataSet, // 可能导致性能问题
  columns: _columns,
)
```

### 3. 用户体验优化

```dart
// ✅ 好的做法：提供排序和筛选功能
ZephyrTable(
  columns: [
    ZephyrTableColumn(
      title: '姓名',
      field: 'name',
      sortable: true, // 允许排序
    ),
    ZephyrTableColumn(
      title: '状态',
      field: 'status',
      filterable: true, // 允许筛选
    ),
  ],
  data: _data,
)

// ✅ 好的做法：显示加载状态
ZephyrTable(
  data: _isLoading ? [] : _data,
  placeholderBuilder: () {
    return _isLoading 
        ? Center(child: CircularProgressIndicator())
        : Center(child: Text('暂无数据'));
  },
)

// ✅ 好的做法：响应式设计
ZephyrTable(
  columns: _buildResponsiveColumns(),
  horizontalScroll: true, // 允许水平滚动
  data: _data,
)

// ❌ 避免的做法：缺乏交互功能
ZephyrTable(
  columns: [
    ZephyrTableColumn(
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
ZephyrTable(
  semanticLabel: '用户数据表格',
  columns: [
    ZephyrTableColumn(
      title: '姓名',
      field: 'name',
      semanticLabel: '用户姓名列',
    ),
    ZephyrTableColumn(
      title: '邮箱',
      field: 'email',
      semanticLabel: '用户邮箱列',
    ),
  ],
  data: _data,
  enableAccessibilityFeatures: true,
)

// ✅ 好的做法：为操作按钮提供描述
ZephyrTableColumn(
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
ZephyrTable(
  columns: [
    ZephyrTableColumn(
      title: '数据',
      field: 'data',
      // 缺乏语义信息
    ),
  ],
  data: _data,
)
```

## 🔄 相关组件

- **ZephyrDataGrid**: 数据网格组件
- **ZephyrList**: 列表组件
- **ZephyrPagination**: 分页组件
- **ZephyrCard**: 卡片组件
- **ZephyrContainer**: 容器组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本表格功能
- ✅ 支持排序和筛选
- ✅ 支持自定义样式
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/table/`
**示例路径**: `example/lib/components/table_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日