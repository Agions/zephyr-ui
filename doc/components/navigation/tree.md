# ZephyrTree 树形组件

树形组件是ZephyrUI导航系统的重要组件，提供了层级数据的展示和交互功能。支持展开/折叠、选择、搜索等多种操作，是构建文件系统、组织架构、分类导航等场景的理想选择。

## 🎯 组件概述

### 特性
- **层级展示**: 支持多级树形结构展示
- **展开折叠**: 支持节点的展开和折叠操作
- **选择功能**: 支持单选和多选模式
- **搜索过滤**: 支持节点搜索和高亮显示
- **自定义样式**: 支持自定义图标、颜色、连线等样式
- **丰富交互**: 支持点击、悬停、拖拽等交互
- **主题适配**: 完整的主题系统支持

### 适用场景
- 文件系统导航
- 组织架构展示
- 分类目录导航
- 设置页面分组
- 知识库结构
- 项目文件管理

## 🚀 基础用法

### 基本树形结构

```dart
class BasicTreeExample extends StatefulWidget {
  @override
  _BasicTreeExampleState createState() => _BasicTreeExampleState();
}

class _BasicTreeExampleState extends State<BasicTreeExample> {
  List<ZephyrTreeNode<String>> _nodes = [];

  @override
  void initState() {
    super.initState();
    _buildTreeNodes();
  }

  void _buildTreeNodes() {
    setState(() {
      _nodes = [
        ZephyrTreeNode<String>(
          id: '1',
          label: '文档',
          icon: Icons.folder,
          children: [
            ZephyrTreeNode<String>(
              id: '1-1',
              label: '工作文档',
              icon: Icons.folder,
              children: [
                ZephyrTreeNode<String>(
                  id: '1-1-1',
                  label: '项目报告.docx',
                  icon: Icons.description,
                ),
                ZephyrTreeNode<String>(
                  id: '1-1-2',
                  label: '会议记录.docx',
                  icon: Icons.description,
                ),
              ],
            ),
            ZephyrTreeNode<String>(
              id: '1-2',
              label: '个人文档',
              icon: Icons.folder,
              children: [
                ZephyrTreeNode<String>(
                  id: '1-2-1',
                  label: '简历.pdf',
                  icon: Icons.picture_as_pdf,
                ),
              ],
            ),
          ],
        ),
        ZephyrTreeNode<String>(
          id: '2',
          label: '图片',
          icon: Icons.image,
          children: [
            ZephyrTreeNode<String>(
              id: '2-1',
              label: '照片',
              icon: Icons.photo,
            ),
            ZephyrTreeNode<String>(
              id: '2-2',
              label: '截图',
              icon: Icons.screenshot,
            ),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本树形结构'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTree<String>(
          nodes: _nodes,
          onNodeTap: (node) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('点击了: ${node.label}')),
            );
          },
          onNodeExpand: (node) {
            print('展开: ${node.label}');
          },
          onNodeCollapse: (node) {
            print('折叠: ${node.label}');
          },
        ),
      ),
    );
  }
}
```

### 带选择的树形结构

```dart
class SelectionTreeExample extends StatefulWidget {
  @override
  _SelectionTreeExampleState createState() => _SelectionTreeExampleState();
}

class _SelectionTreeExampleState extends State<SelectionTreeExample> {
  List<ZephyrTreeNode<String>> _nodes = [];
  List<ZephyrTreeNode<String>> _selectedNodes = [];

  @override
  void initState() {
    super.initState();
    _buildTreeNodes();
  }

  void _buildTreeNodes() {
    setState(() {
      _nodes = [
        ZephyrTreeNode<String>(
          id: '1',
          label: '部门',
          icon: Icons.business,
          children: [
            ZephyrTreeNode<String>(
              id: '1-1',
              label: '技术部',
              icon: Icons.code,
              children: [
                ZephyrTreeNode<String>(
                  id: '1-1-1',
                  label: '前端组',
                  icon: Icons.web,
                ),
                ZephyrTreeNode<String>(
                  id: '1-1-2',
                  label: '后端组',
                  icon: Icons.storage,
                ),
              ],
            ),
            ZephyrTreeNode<String>(
              id: '1-2',
              label: '产品部',
              icon: Icons.lightbulb,
            ),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带选择的树形结构'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ZephyrTree<String>(
                nodes: _nodes,
                allowMultipleSelection: true,
                onNodeSelect: (node) {
                  setState(() {
                    if (_selectedNodes.contains(node)) {
                      _selectedNodes.remove(node);
                    } else {
                      _selectedNodes.add(node);
                    }
                  });
                },
                initialSelectedNodes: ['1-1-1'],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '已选择的节点:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ..._selectedNodes.map((node) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text('• ${node.label}'),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### 可搜索的树形结构

```dart
class SearchableTreeExample extends StatefulWidget {
  @override
  _SearchableTreeExampleState createState() => _SearchableTreeExampleState();
}

class _SearchableTreeExampleState extends State<SearchableTreeExample> {
  List<ZephyrTreeNode<String>> _nodes = [];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _buildTreeNodes();
  }

  void _buildTreeNodes() {
    setState(() {
      _nodes = [
        ZephyrTreeNode<String>(
          id: '1',
          label: '项目文件',
          icon: Icons.folder,
          children: [
            ZephyrTreeNode<String>(
              id: '1-1',
              label: '源代码',
              icon: Icons.code,
              children: [
                ZephyrTreeNode<String>(
                  id: '1-1-1',
                  label: 'main.dart',
                  icon: Icons.dart,
                ),
                ZephyrTreeNode<String>(
                  id: '1-1-2',
                  label: 'app.dart',
                  icon: Icons.dart,
                ),
              ],
            ),
            ZephyrTreeNode<String>(
              id: '1-2',
              label: '资源文件',
              icon: Icons.image,
              children: [
                ZephyrTreeNode<String>(
                  id: '1-2-1',
                  label: 'logo.png',
                  icon: Icons.image,
                ),
                ZephyrTreeNode<String>(
                  id: '1-2-2',
                  label: 'background.jpg',
                  icon: Icons.image,
                ),
              ],
            ),
          ],
        ),
        ZephyrTreeNode<String>(
          id: '2',
          label: '文档',
          icon: Icons.description,
          children: [
            ZephyrTreeNode<String>(
              id: '2-1',
              label: 'README.md',
              icon: Icons.markdown,
            ),
            ZephyrTreeNode<String>(
              id: '2-2',
              label: 'API文档',
              icon: Icons.api,
            ),
          ],
        ),
      ];
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
        title: Text('可搜索的树形结构'),
      ),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '搜索节点',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          // 树形结构
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ZephyrTree<String>(
                nodes: _nodes,
                searchQuery: _searchQuery,
                highlightSearchResults: true,
                onNodeTap: (node) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('点击了: ${node.label}')),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义样式树形结构

```dart
class CustomStyleTreeExample extends StatefulWidget {
  @override
  _CustomStyleTreeExampleState createState() => _CustomStyleTreeExampleState();
}

class _CustomStyleTreeExampleState extends State<CustomStyleTreeExample> {
  List<ZephyrTreeNode<String>> _nodes = [];

  @override
  void initState() {
    super.initState();
    _buildTreeNodes();
  }

  void _buildTreeNodes() {
    setState(() {
      _nodes = [
        ZephyrTreeNode<String>(
          id: '1',
          label: '自定义样式',
          icon: Icons.style,
          children: [
            ZephyrTreeNode<String>(
              id: '1-1',
              label: '颜色主题',
              icon: Icons.palette,
            ),
            ZephyrTreeNode<String>(
              id: '1-2',
              label: '字体设置',
              icon: Icons.font_download,
            ),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义样式树形结构'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTree<String>(
          nodes: _nodes,
          theme: ZephyrTreeTheme(
            selectedColor: Colors.blue.withOpacity(0.1),
            hoverColor: Colors.grey.withOpacity(0.1),
            lineColor: Colors.grey[300],
            textColor: Colors.black87,
            selectedTextColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 14),
            selectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          expandIcon: Icons.add_circle_outline,
          collapseIcon: Icons.remove_circle_outline,
          leafIcon: Icons.circle,
          showLines: true,
          showIcons: true,
          onNodeTap: (node) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('点击了: ${node.label}')),
            );
          },
        ),
      ),
    );
  }
}
```

### 带连线的树形结构

```dart
class LinedTreeExample extends StatefulWidget {
  @override
  _LinedTreeExampleState createState() => _LinedTreeExampleState();
}

class _LinedTreeExampleState extends State<LinedTreeExample> {
  List<ZephyrTreeNode<String>> _nodes = [];

  @override
  void initState() {
    super.initState();
    _buildTreeNodes();
  }

  void _buildTreeNodes() {
    setState(() {
      _nodes = [
        ZephyrTreeNode<String>(
          id: '1',
          label: '根节点',
          icon: Icons.account_tree,
          children: [
            ZephyrTreeNode<String>(
              id: '1-1',
              label: '子节点 1',
              icon: Icons.subdirectory_arrow_right,
              children: [
                ZephyrTreeNode<String>(
                  id: '1-1-1',
                  label: '叶子节点 1',
                  icon: Icons.circle,
                ),
                ZephyrTreeNode<String>(
                  id: '1-1-2',
                  label: '叶子节点 2',
                  icon: Icons.circle,
                ),
              ],
            ),
            ZephyrTreeNode<String>(
              id: '1-2',
              label: '子节点 2',
              icon: Icons.subdirectory_arrow_right,
            ),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带连线的树形结构'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTree<String>(
          nodes: _nodes,
          showLines: true,
          lineColor: Colors.blue[300],
          indentation: 32,
          nodeHeight: 40,
          iconSize: 20,
          onNodeTap: (node) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('点击了: ${node.label}')),
            );
          },
        ),
      ),
    );
  }
}
```

### 卡片式树形结构

```dart
class CardTreeExample extends StatefulWidget {
  @override
  _CardTreeExampleState createState() => _CardTreeExampleState();
}

class _CardTreeExampleState extends State<CardTreeExample> {
  List<ZephyrTreeNode<String>> _nodes = [];

  @override
  void initState() {
    super.initState();
    _buildTreeNodes();
  }

  void _buildTreeNodes() {
    setState(() {
      _nodes = [
        ZephyrTreeNode<String>(
          id: '1',
          label: '组织架构',
          icon: Icons.business,
          children: [
            ZephyrTreeNode<String>(
              id: '1-1',
              label: '技术部',
              icon: Icons.code,
              children: [
                ZephyrTreeNode<String>(
                  id: '1-1-1',
                  label: '前端团队',
                  icon: Icons.web,
                  customWidget: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.web, size: 16, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('前端团队 (5人)'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片式树形结构'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTree<String>(
          nodes: _nodes,
          showLines: false,
          indentation: 16,
          onNodeTap: (node) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('点击了: ${node.label}')),
            );
          },
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 文件管理器树形结构

```dart
class FileManagerTreeExample extends StatefulWidget {
  @override
  _FileManagerTreeExampleState createState() => _FileManagerTreeExampleState();
}

class _FileManagerTreeExampleState extends State<FileManagerTreeExample> {
  List<ZephyrTreeNode<FileInfo>> _nodes = [];
  List<ZephyrTreeNode<FileInfo>> _selectedNodes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFileSystem();
  }

  Future<void> _loadFileSystem() async {
    setState(() => _isLoading = true);
    
    // 模拟加载文件系统
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      _nodes = [
        ZephyrTreeNode<FileInfo>(
          id: 'root',
          label: '我的电脑',
          icon: Icons.computer,
          data: FileInfo(name: '我的电脑', type: 'computer', size: '0'),
          children: [
            ZephyrTreeNode<FileInfo>(
              id: 'c-drive',
              label: 'C盘',
              icon: Icons.storage,
              data: FileInfo(name: 'C盘', type: 'drive', size: '100GB'),
              children: [
                ZephyrTreeNode<FileInfo>(
                  id: 'program-files',
                  label: 'Program Files',
                  icon: Icons.folder,
                  data: FileInfo(name: 'Program Files', type: 'folder', size: '50GB'),
                  children: [
                    ZephyrTreeNode<FileInfo>(
                      id: 'app1',
                      label: '应用程序1',
                      icon: Icons.android,
                      data: FileInfo(name: '应用程序1', type: 'file', size: '2GB'),
                    ),
                  ],
                ),
                ZephyrTreeNode<FileInfo>(
                  id: 'users',
                  label: '用户',
                  icon: Icons.folder,
                  data: FileInfo(name: '用户', type: 'folder', size: '30GB'),
                  children: [
                    ZephyrTreeNode<FileInfo>(
                      id: 'documents',
                      label: '文档',
                      icon: Icons.folder,
                      data: FileInfo(name: '文档', type: 'folder', size: '10GB'),
                      children: [
                        ZephyrTreeNode<FileInfo>(
                          id: 'resume',
                          label: '简历.pdf',
                          icon: Icons.picture_as_pdf,
                          data: FileInfo(name: '简历.pdf', type: 'file', size: '2MB'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件管理器'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadFileSystem,
          ),
        ],
      ),
      body: Column(
        children: [
          // 工具栏
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.create_new_folder),
                  label: Text('新建文件夹'),
                  onPressed: _createFolder,
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: Icon(Icons.upload_file),
                  label: Text('上传文件'),
                  onPressed: _uploadFile,
                ),
                SizedBox(width: 16),
                Text(
                  '已选择 ${_selectedNodes.length} 项',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // 树形结构
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(16),
                    child: ZephyrTree<FileInfo>(
                      nodes: _nodes,
                      allowMultipleSelection: true,
                      showLines: true,
                      indentation: 24,
                      nodeHeight: 32,
                      onNodeSelect: (node) {
                        setState(() {
                          if (_selectedNodes.contains(node)) {
                            _selectedNodes.remove(node);
                          } else {
                            _selectedNodes.add(node);
                          }
                        });
                      },
                      onNodeExpand: (node) {
                        print('展开: ${node.label}');
                      },
                      onNodeCollapse: (node) {
                        print('折叠: ${node.label}');
                      },
                      onNodeTap: (node) {
                        if (node.data?.type == 'file') {
                          _openFile(node);
                        }
                      },
                    ),
                  ),
          ),
          // 状态栏
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('总文件数: ${_countFiles(_nodes)}'),
                Text('总大小: ${_calculateTotalSize(_nodes)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _countFiles(List<ZephyrTreeNode<FileInfo>> nodes) {
    int count = 0;
    for (final node in nodes) {
      if (node.data?.type == 'file') {
        count++;
      }
      if (node.children.isNotEmpty) {
        count += _countFiles(node.children);
      }
    }
    return count;
  }

  String _calculateTotalSize(List<ZephyrTreeNode<FileInfo>> nodes) {
    // 简化的计算逻辑
    return '计算中...';
  }

  void _createFolder() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('创建文件夹功能待实现')),
    );
  }

  void _uploadFile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('上传文件功能待实现')),
    );
  }

  void _openFile(ZephyrTreeNode<FileInfo> node) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('打开文件: ${node.label}')),
    );
  }
}

class FileInfo {
  final String name;
  final String type;
  final String size;

  FileInfo({
    required this.name,
    required this.type,
    required this.size,
  });
}
```

### 组织架构树形结构

```dart
class OrganizationTreeExample extends StatefulWidget {
  @override
  _OrganizationTreeExampleState createState() => _OrganizationTreeExampleState();
}

class _OrganizationTreeExampleState extends State<OrganizationTreeExample> {
  List<ZephyrTreeNode<Employee>> _nodes = [];
  ZephyrTreeNode<Employee>? _selectedNode;

  @override
  void initState() {
    super.initState();
    _buildOrganizationTree();
  }

  void _buildOrganizationTree() {
    setState(() {
      _nodes = [
        ZephyrTreeNode<Employee>(
          id: 'ceo',
          label: 'CEO',
          icon: Icons.person,
          data: Employee(name: '张三', position: 'CEO', department: '管理层', email: 'ceo@company.com'),
          children: [
            ZephyrTreeNode<Employee>(
              id: 'cto',
              label: 'CTO',
              icon: Icons.engineering,
              data: Employee(name: '李四', position: 'CTO', department: '技术部', email: 'cto@company.com'),
              children: [
                ZephyrTreeNode<Employee>(
                  id: 'frontend-lead',
                  label: '前端负责人',
                  icon: Icons.code,
                  data: Employee(name: '王五', position: '前端负责人', department: '技术部', email: 'frontend@company.com'),
                  children: [
                    ZephyrTreeNode<Employee>(
                      id: 'frontend-dev1',
                      label: '前端开发1',
                      icon: Icons.person_outline,
                      data: Employee(name: '赵六', position: '前端开发', department: '技术部', email: 'dev1@company.com'),
                    ),
                    ZephyrTreeNode<Employee>(
                      id: 'frontend-dev2',
                      label: '前端开发2',
                      icon: Icons.person_outline,
                      data: Employee(name: '钱七', position: '前端开发', department: '技术部', email: 'dev2@company.com'),
                    ),
                  ],
                ),
                ZephyrTreeNode<Employee>(
                  id: 'backend-lead',
                  label: '后端负责人',
                  icon: Icons.storage,
                  data: Employee(name: '孙八', position: '后端负责人', department: '技术部', email: 'backend@company.com'),
                ),
              ],
            ),
            ZephyrTreeNode<Employee>(
              id: 'cfo',
              label: 'CFO',
              icon: Icons.account_balance,
              data: Employee(name: '周九', position: 'CFO', department: '财务部', email: 'cfo@company.com'),
              children: [
                ZephyrTreeNode<Employee>(
                  id: 'accountant',
                  label: '会计',
                  icon: Icons.calculate,
                  data: Employee(name: '吴十', position: '会计', department: '财务部', email: 'accountant@company.com'),
                ),
              ],
            ),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('组织架构'),
        actions: [
          IconButton(
            icon: Icon(Icons.org_chart),
            onPressed: _showOrganizationChart,
          ),
        ],
      ),
      body: Row(
        children: [
          // 树形结构
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ZephyrTree<Employee>(
                nodes: _nodes,
                showLines: true,
                indentation: 32,
                nodeHeight: 40,
                onNodeSelect: (node) {
                  setState(() => _selectedNode = node);
                },
                initialSelectedNodes: ['ceo'],
              ),
            ),
          ),
          // 详细信息
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.grey[300]!)),
              ),
              child: _selectedNode != null
                  ? _buildEmployeeDetails(_selectedNode!)
                  : Center(child: Text('请选择员工')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeDetails(ZephyrTreeNode<Employee> node) {
    final employee = node.data!;
    
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '员工信息',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 48),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee.name,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            employee.position,
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  _buildInfoRow('部门', employee.department),
                  _buildInfoRow('邮箱', employee.email),
                  _buildInfoRow('下属人数', '${node.children.length}人'),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          if (node.children.isNotEmpty) ...[
            Text(
              '下属团队',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...node.children.map((child) {
              return Card(
                child: ListTile(
                  leading: Icon(child.icon),
                  title: Text(child.label),
                  subtitle: Text(child.data?.position ?? ''),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    setState(() => _selectedNode = child);
                  },
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 16),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showOrganizationChart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('组织架构图功能待实现')),
    );
  }
}

class Employee {
  final String name;
  final String position;
  final String department;
  final String email;

  Employee({
    required this.name,
    required this.position,
    required this.department,
    required this.email,
  });
}
```

### 拖拽排序树形结构

```dart
class DragDropTreeExample extends StatefulWidget {
  @override
  _DragDropTreeExampleState createState() => _DragDropTreeExampleState();
}

class _DragDropTreeExampleState extends State<DragDropTreeExample> {
  List<ZephyrTreeNode<TaskItem>> _nodes = [];
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _buildTaskTree();
  }

  void _buildTaskTree() {
    setState(() {
      _nodes = [
        ZephyrTreeNode<TaskItem>(
          id: 'project1',
          label: '项目开发',
          icon: Icons.work,
          data: TaskItem(name: '项目开发', priority: '高', status: '进行中'),
          children: [
            ZephyrTreeNode<TaskItem>(
              id: 'task1',
              label: '需求分析',
              icon: Icons.assignment,
              data: TaskItem(name: '需求分析', priority: '高', status: '已完成'),
            ),
            ZephyrTreeNode<TaskItem>(
              id: 'task2',
              label: 'UI设计',
              icon: Icons.palette,
              data: TaskItem(name: 'UI设计', priority: '中', status: '进行中'),
            ),
            ZephyrTreeNode<TaskItem>(
              id: 'task3',
              label: '开发实现',
              icon: Icons.code,
              data: TaskItem(name: '开发实现', priority: '高', status: '待开始'),
            ),
          ],
        ),
        ZephyrTreeNode<TaskItem>(
          id: 'project2',
          label: '市场推广',
          icon: Icons.campaign,
          data: TaskItem(name: '市场推广', priority: '中', status: '待开始'),
          children: [
            ZephyrTreeNode<TaskItem>(
              id: 'task4',
              label: '市场调研',
              icon: Icons.search,
              data: TaskItem(name: '市场调研', priority: '中', status: '待开始'),
            ),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('拖拽排序任务'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveTaskOrder,
          ),
        ],
      ),
      body: Column(
        children: [
          // 说明
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Text(
              '拖拽节点可以调整任务优先级顺序',
              style: TextStyle(fontSize: 14),
            ),
          ),
          // 树形结构
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: DragTarget<ZephyrTreeNode<TaskItem>>(
                onWillAccept: (data) => true,
                onAccept: (data) {
                  setState(() => _isDragging = false);
                },
                builder: (context, candidateData, rejectedData) {
                  return ZephyrTree<TaskItem>(
                    nodes: _nodes,
                    showLines: true,
                    indentation: 24,
                    nodeHeight: 40,
                    onNodeExpand: (node) {
                      print('展开: ${node.label}');
                    },
                    onNodeCollapse: (node) {
                      print('折叠: ${node.label}');
                    },
                    onNodeTap: (node) {
                      _showTaskDetails(node);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTaskDetails(ZephyrTreeNode<TaskItem> node) {
    final task = node.data!;
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('优先级', task.priority),
              _buildInfoRow('状态', task.status),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('关闭'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  void _saveTaskOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('任务顺序已保存')),
    );
  }
}

class TaskItem {
  final String name;
  final String priority;
  final String status;

  TaskItem({
    required this.name,
    required this.priority,
    required this.status,
  });
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrTreeNode<T>()

```dart
const ZephyrTreeNode<T>({
  required String id,
  required String label,
  T? data,
  IconData? icon,
  IconData? expandedIcon,
  IconData? collapsedIcon,
  List<ZephyrTreeNode<T>> children = const [],
  bool isExpanded = false,
  bool isSelected = false,
  bool isDisabled = false,
  Widget? customWidget,
  Map<String, dynamic>? metadata,
})
```

**参数说明：**
- `id`: 节点唯一标识符
- `label`: 节点显示标签
- `data`: 节点关联的数据
- `icon`: 节点图标
- `expandedIcon`: 展开时的图标
- `collapsedIcon`: 折叠时的图标
- `children`: 子节点列表
- `isExpanded`: 是否展开
- `isSelected`: 是否选中
- `isDisabled`: 是否禁用
- `customWidget`: 自定义组件
- `metadata`: 元数据

#### ZephyrTree<T>()

```dart
const ZephyrTree<T>({
  Key? key,
  required List<ZephyrTreeNode<T>> nodes,
  void Function(ZephyrTreeNode<T> node)? onNodeTap,
  void Function(ZephyrTreeNode<T> node)? onNodeExpand,
  void Function(ZephyrTreeNode<T> node)? onNodeCollapse,
  void Function(ZephyrTreeNode<T> node)? onNodeSelect,
  ZephyrTreeTheme? theme,
  double indentation = 24,
  double nodeHeight = 32,
  double iconSize = 16,
  IconData expandIcon = Icons.keyboard_arrow_right,
  IconData collapseIcon = Icons.keyboard_arrow_down,
  IconData? leafIcon,
  bool showLines = true,
  bool showIcons = true,
  bool allowMultipleSelection = false,
  bool allowExpandCollapse = true,
  List<String> initialExpandedNodes = const [],
  List<String> initialSelectedNodes = const [],
  List<String> disabledNodes = const [],
  String? searchQuery,
  bool highlightSearchResults = true,
  Duration animationDuration = const Duration(milliseconds: 200),
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
  ScrollController? scrollController,
  ScrollPhysics? physics,
  bool shrinkWrap = false,
  EdgeInsetsGeometry? padding,
})
```

**参数说明：**
- `nodes`: 根节点列表
- `onNodeTap`: 节点点击回调
- `onNodeExpand`: 节点展开回调
- `onNodeCollapse`: 节点折叠回调
- `onNodeSelect`: 节点选择回调
- `theme`: 主题配置
- `indentation`: 子节点缩进
- `nodeHeight`: 节点高度
- `iconSize`: 图标大小
- `expandIcon`: 展开图标
- `collapseIcon`: 折叠图标
- `leafIcon`: 叶子节点图标
- `showLines`: 是否显示连接线
- `showIcons`: 是否显示图标
- `allowMultipleSelection`: 是否允许多选
- `allowExpandCollapse`: 是否允许展开折叠
- `initialExpandedNodes`: 初始展开节点ID
- `initialSelectedNodes`: 初始选中节点ID
- `disabledNodes`: 禁用节点ID
- `searchQuery`: 搜索查询
- `highlightSearchResults`: 是否高亮搜索结果
- `animationDuration`: 动画持续时间
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能
- `scrollController`: 滚动控制器
- `physics`: 滚动物理
- `shrinkWrap`: 是否收缩包装
- `padding`: 内边距

### 主题配置

#### ZephyrTreeTheme()

```dart
ZephyrTreeTheme({
  Color? selectedColor,
  Color? hoverColor,
  Color? disabledColor,
  Color? lineColor,
  Color? textColor,
  Color? selectedTextColor,
  Color? disabledTextColor,
  Color? expandCollapseColor,
  double? lineHeight,
  double? iconSize,
  TextStyle? labelStyle,
  TextStyle? selectedLabelStyle,
  TextStyle? disabledLabelStyle,
  Duration? animationDuration,
})
```

**主题属性：**
- `selectedColor`: 选中时的颜色
- `hoverColor`: 悬停时的颜色
- `disabledColor`: 禁用时的颜色
- `lineColor`: 连接线颜色
- `textColor`: 文本颜色
- `selectedTextColor`: 选中时的文本颜色
- `disabledTextColor`: 禁用时的文本颜色
- `expandCollapseColor`: 展开/折叠图标颜色
- `lineHeight`: 连接线高度
- `iconSize`: 图标大小
- `labelStyle`: 标签样式
- `selectedLabelStyle`: 选中时的标签样式
- `disabledLabelStyle`: 禁用时的标签样式
- `animationDuration`: 动画持续时间

### 工厂构造函数

```dart
// 浅色主题
ZephyrTreeTheme.light()

// 深色主题
ZephyrTreeTheme.dark()

// 复制并修改
ZephyrTreeTheme copyWith({...})
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrTreeTheme(
        selectedColor: Colors.blue.withOpacity(0.1),
        hoverColor: Colors.grey.withOpacity(0.1),
        disabledColor: Colors.grey[200],
        lineColor: Colors.grey[300],
        textColor: Colors.black87,
        selectedTextColor: Colors.blue,
        disabledTextColor: Colors.grey[400],
        expandCollapseColor: Colors.grey[600],
        lineHeight: 1,
        iconSize: 16,
        labelStyle: TextStyle(fontSize: 14),
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        disabledLabelStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[400],
        ),
        animationDuration: Duration(milliseconds: 200),
      ),
    ],
  ),
  home: MyApp(),
)
```

## 🏆 最佳实践

### 1. 合理的节点深度

```dart
// ✅ 好的做法：控制节点深度
ZephyrTreeNode<String>(
  id: '1',
  label: '根节点',
  children: [
    ZephyrTreeNode<String>(
      id: '1-1',
      label: '二级节点',
      children: [
        ZephyrTreeNode<String>(
          id: '1-1-1',
          label: '三级节点',
          // 不建议继续嵌套过深
        ),
      ],
    ),
  ],
)

// ❌ 避免的做法：节点嵌套过深
ZephyrTreeNode<String>(
  id: '1',
  label: '根节点',
  children: [
    // 5层以上的嵌套会影响用户体验
  ],
)
```

### 2. 高效的数据管理

```dart
// ✅ 好的做法：使用数据模型
class FileNode {
  final String id;
  final String name;
  final String type;
  final int size;
  final DateTime modified;
  
  FileNode({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.modified,
  });
}

// 使用数据模型构建树节点
ZephyrTreeNode<FileNode>(
  id: file.id,
  label: file.name,
  data: file,
  icon: _getFileIcon(file.type),
)

// ✅ 好的做法：懒加载子节点
Future<List<ZephyrTreeNode<T>>> _loadChildren(String parentId) async {
  // 异步加载子节点
  final children = await api.fetchChildren(parentId);
  return children.map((child) => _buildNode(child)).toList();
}

// ❌ 避免的做法：一次性加载所有数据
List<ZephyrTreeNode<T>> _buildAllNodes() {
  // 一次性加载大量数据会影响性能
  return _allData.map((item) => _buildNode(item)).toList();
}
```

### 3. 良好的用户体验

```dart
// ✅ 好的做法：提供搜索功能
class SearchableTree extends StatelessWidget {
  final String searchQuery;
  
  @override
  Widget build(BuildContext context) {
    return ZephyrTree<String>(
      nodes: _nodes,
      searchQuery: searchQuery,
      highlightSearchResults: true,
    );
  }
}

// ✅ 好的做法：提供加载状态
class LoadingTree extends StatefulWidget {
  @override
  _LoadingTreeState createState() => _LoadingTreeState();
}

class _LoadingTreeState extends State<LoadingTree> {
  bool _isLoading = false;
  
  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await _fetchData();
    setState(() => _isLoading = false);
  }
  
  @override
  Widget build(BuildContext context) {
    return _isLoading 
        ? Center(child: CircularProgressIndicator())
        : ZephyrTree<String>(nodes: _nodes);
  }
}

// ✅ 好的做法：提供操作反馈
ZephyrTree<String>(
  nodes: _nodes,
  onNodeTap: (node) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('选择了: ${node.label}')),
    );
  },
)

// ❌ 避免的做法：缺乏用户反馈
ZephyrTree<String>(
  nodes: _nodes,
  onNodeTap: (node) {
    // 用户不知道操作是否成功
  },
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrTree<String>(
  semanticLabel: '文件系统导航',
  enableAccessibilityFeatures: true,
  nodes: _nodes,
)

// ✅ 好的做法：为节点提供语义信息
ZephyrTreeNode<String>(
  id: 'folder',
  label: '文档',
  semanticLabel: '文档文件夹，包含3个子项目',
)

// ✅ 好的做法：支持键盘导航
Focus(
  child: ZephyrTree<String>(
    nodes: _nodes,
    enableAccessibilityFeatures: true,
  ),
)

// ❌ 避免的做法：缺乏无障碍支持
ZephyrTree<String>(
  nodes: _nodes,
  // 缺乏语义信息和键盘支持
)
```

### 5. 性能优化

```dart
// ✅ 好的做法：使用const构造函数
const staticNodes = [
  ZephyrTreeNode<String>(
    id: '1',
    label: '静态节点',
  ),
];

// ✅ 好的做法：控制渲染的节点数量
ZephyrTree<String>(
  nodes: _visibleNodes, // 只渲染可见的节点
  shrinkWrap: true,
)

// ✅ 好的做法：使用缓存
class CachedTree extends StatefulWidget {
  @override
  _CachedTreeState createState() => _CachedTreeState();
}

class _CachedTreeState extends State<CachedTree> {
  final Map<String, List<ZephyrTreeNode<String>>> _cache = {};
  
  List<ZephyrTreeNode<String>> _getChildren(String parentId) {
    if (_cache.containsKey(parentId)) {
      return _cache[parentId]!;
    }
    
    final children = _fetchChildren(parentId);
    _cache[parentId] = children;
    return children;
  }
}

// ❌ 避免的做法：频繁重建整个树
class BadPerformanceTree extends StatefulWidget {
  @override
  _BadPerformanceTreeState createState() => _BadPerformanceTreeState();
}

class _BadPerformanceTreeState extends State<BadPerformanceTree> {
  // 每次状态变化都重建整个树
  @override
  Widget build(BuildContext context) {
    return ZephyrTree<String>(
      nodes: _buildAllNodes(), // 重复构建所有节点
    );
  }
}
```

## 🔄 相关组件

- **ZephyrList**: 列表组件
- **ZephyrTable**: 表格组件
- **ZephyrBreadcrumb**: 面包屑导航组件
- **ZephyrNavigationRail**: 导航栏组件
- **ZephyrSideMenu**: 侧边菜单组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本树形结构功能
- ✅ 支持展开折叠和选择
- ✅ 支持搜索和过滤
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/navigation/tree/`
**示例路径**: `example/lib/components/tree_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日