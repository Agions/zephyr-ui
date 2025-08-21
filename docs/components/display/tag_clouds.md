# ZephyrTagClouds 标签云组件

标签云组件是ZephyrUI展示系统中的特色组件，提供了灵活的标签展示和选择功能。支持多种标签云模式、自定义样式和交互方式，是构建标签分类、内容筛选、热门话题等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种标签云模式**: 支持基本标签云、加权标签云、分组标签云等多种模式
- **灵活布局**: 支持水平、垂直、环绕等多种布局方式
- **丰富交互**: 支持点击、选择、筛选、搜索等交互
- **自定义样式**: 支持自定义标签大小、颜色、形状等样式
- **动画效果**: 内置平滑的动画效果
- **主题适配**: 完整的主题系统支持

### 适用场景
- 标签分类
- 内容筛选
- 热门话题
- 技能标签
- 兴趣标签
- 产品标签

## 🚀 基础用法

### 基本标签云

```dart
class BasicTagCloudExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本标签云'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTagCloud(
          tags: [
            ZephyrTag(
              text: 'Flutter',
              onTap: () => _showTagDetails('Flutter'),
            ),
            ZephyrTag(
              text: 'Dart',
              onTap: () => _showTagDetails('Dart'),
            ),
            ZephyrTag(
              text: '移动开发',
              onTap: () => _showTagDetails('移动开发'),
            ),
            ZephyrTag(
              text: 'UI设计',
              onTap: () => _showTagDetails('UI设计'),
            ),
            ZephyrTag(
              text: '前端开发',
              onTap: () => _showTagDetails('前端开发'),
            ),
            ZephyrTag(
              text: '后端开发',
              onTap: () => _showTagDetails('后端开发'),
            ),
            ZephyrTag(
              text: '数据库',
              onTap: () => _showTagDetails('数据库'),
            ),
            ZephyrTag(
              text: 'API开发',
              onTap: () => _showTagDetails('API开发'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTagDetails(String tag) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了标签: $tag')),
    );
  }
}
```

### 加权标签云

```dart
class WeightedTagCloudExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('加权标签云'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTagCloud(
          type: ZephyrTagCloudType.weighted,
          tags: [
            ZephyrTag(
              text: 'JavaScript',
              weight: 100,
              onTap: () => _showTagDetails('JavaScript'),
            ),
            ZephyrTag(
              text: 'Python',
              weight: 85,
              onTap: () => _showTagDetails('Python'),
            ),
            ZephyrTag(
              text: 'Java',
              weight: 75,
              onTap: () => _showTagDetails('Java'),
            ),
            ZephyrTag(
              text: 'C++',
              weight: 60,
              onTap: () => _showTagDetails('C++'),
            ),
            ZephyrTag(
              text: 'Go',
              weight: 45,
              onTap: () => _showTagDetails('Go'),
            ),
            ZephyrTag(
              text: 'Rust',
              weight: 35,
              onTap: () => _showTagDetails('Rust'),
            ),
            ZephyrTag(
              text: 'Swift',
              weight: 25,
              onTap: () => _showTagDetails('Swift'),
            ),
            ZephyrTag(
              text: 'Kotlin',
              weight: 20,
              onTap: () => _showTagDetails('Kotlin'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTagDetails(String tag) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了标签: $tag')),
    );
  }
}
```

### 可选择标签云

```dart
class SelectableTagCloudExample extends StatefulWidget {
  @override
  _SelectableTagCloudExampleState createState() => _SelectableTagCloudExampleState();
}

class _SelectableTagCloudExampleState extends State<SelectableTagCloudExample> {
  Set<String> _selectedTags = {};

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可选择标签云'),
      ),
      body: Column(
        children: [
          // 选中的标签显示
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '已选择 ${_selectedTags.length} 个标签',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _selectedTags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      onDeleted: () {
                        setState(() {
                          _selectedTags.remove(tag);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // 标签云
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ZephyrTagCloud(
                selectable: true,
                selectedTags: _selectedTags,
                onSelectionChanged: (tags) {
                  setState(() => _selectedTags = tags);
                },
                tags: [
                  ZephyrTag(
                    text: '前端开发',
                    onTap: () => _toggleTag('前端开发'),
                  ),
                  ZephyrTag(
                    text: '后端开发',
                    onTap: () => _toggleTag('后端开发'),
                  ),
                  ZephyrTag(
                    text: '移动开发',
                    onTap: () => _toggleTag('移动开发'),
                  ),
                  ZephyrTag(
                    text: 'UI/UX',
                    onTap: () => _toggleTag('UI/UX'),
                  ),
                  ZephyrTag(
                    text: '数据库',
                    onTap: () => _toggleTag('数据库'),
                  ),
                  ZephyrTag(
                    text: 'DevOps',
                    onTap: () => _toggleTag('DevOps'),
                  ),
                  ZephyrTag(
                    text: '测试',
                    onTap: () => _toggleTag('测试'),
                  ),
                  ZephyrTag(
                    text: '部署',
                    onTap: () => _toggleTag('部署'),
                  ),
                ],
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

### 彩色标签云

```dart
class ColoredTagCloudExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('彩色标签云'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTagCloud(
          tags: [
            ZephyrTag(
              text: '技术',
              color: Colors.blue,
              onTap: () => _showTagDetails('技术'),
            ),
            ZephyrTag(
              text: '设计',
              color: Colors.green,
              onTap: () => _showTagDetails('设计'),
            ),
            ZephyrTag(
              text: '产品',
              color: Colors.orange,
              onTap: () => _showTagDetails('产品'),
            ),
            ZephyrTag(
              text: '运营',
              color: Colors.purple,
              onTap: () => _showTagDetails('运营'),
            ),
            ZephyrTag(
              text: '市场',
              color: Colors.red,
              onTap: () => _showTagDetails('市场'),
            ),
            ZephyrTag(
              text: '销售',
              color: Colors.teal,
              onTap: () => _showTagDetails('销售'),
            ),
            ZephyrTag(
              text: '客服',
              color: Colors.indigo,
              onTap: () => _showTagDetails('客服'),
            ),
            ZephyrTag(
              text: '人力资源',
              color: Colors.pink,
              onTap: () => _showTagDetails('人力资源'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTagDetails(String tag) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了标签: $tag')),
    );
  }
}
```

### 圆角标签云

```dart
class RoundedTagCloudExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆角标签云'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTagCloud(
          style: ZephyrTagCloudStyle(
            tagStyle: ZephyrTagStyle(
              borderRadius: BorderRadius.circular(20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
          tags: [
            ZephyrTag(
              text: 'JavaScript',
              onTap: () => _showTagDetails('JavaScript'),
            ),
            ZephyrTag(
              text: 'Python',
              onTap: () => _showTagDetails('Python'),
            ),
            ZephyrTag(
              text: 'Java',
              onTap: () => _showTagDetails('Java'),
            ),
            ZephyrTag(
              text: 'C++',
              onTap: () => _showTagDetails('C++'),
            ),
            ZephyrTag(
              text: 'Go',
              onTap: () => _showTagDetails('Go'),
            ),
            ZephyrTag(
              text: 'Rust',
              onTap: () => _showTagDetails('Rust'),
            ),
            ZephyrTag(
              text: 'Swift',
              onTap: () => _showTagDetails('Swift'),
            ),
            ZephyrTag(
              text: 'Kotlin',
              onTap: () => _showTagDetails('Kotlin'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTagDetails(String tag) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了标签: $tag')),
    );
  }
}
```

### 带图标的标签云

```dart
class IconTagCloudExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带图标的标签云'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTagCloud(
          tags: [
            ZephyrTag(
              text: '代码',
              icon: Icon(Icons.code),
              onTap: () => _showTagDetails('代码'),
            ),
            ZephyrTag(
              text: '设计',
              icon: Icon(Icons.palette),
              onTap: () => _showTagDetails('设计'),
            ),
            ZephyrTag(
              text: '数据',
              icon: Icon(Icons.storage),
              onTap: () => _showTagDetails('数据'),
            ),
            ZephyrTag(
              text: '网络',
              icon: Icon(Icons.wifi),
              onTap: () => _showTagDetails('网络'),
            ),
            ZephyrTag(
              text: '安全',
              icon: Icon(Icons.security),
              onTap: () => _showTagDetails('安全'),
            ),
            ZephyrTag(
              text: '测试',
              icon: Icon(Icons.bug_report),
              onTap: () => _showTagDetails('测试'),
            ),
            ZephyrTag(
              text: '部署',
              icon: Icon(Icons.cloud_upload),
              onTap: () => _showTagDetails('部署'),
            ),
            ZephyrTag(
              text: '监控',
              icon: Icon(Icons.monitor_heart),
              onTap: () => _showTagDetails('监控'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTagDetails(String tag) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了标签: $tag')),
    );
  }
}
```

## 🔧 高级用法

### 可过滤标签云

```dart
class FilterableTagCloudExample extends StatefulWidget {
  @override
  _FilterableTagCloudExampleState createState() => _FilterableTagCloudExampleState();
}

class _FilterableTagCloudExampleState extends State<FilterableTagCloudExample> {
  final TextEditingController _searchController = TextEditingController();
  List<ZephyrTag> _allTags = [];
  List<ZephyrTag> _filteredTags = [];

  @override
  void initState() {
    super.initState();
    _initializeTags();
    _searchController.addListener(_filterTags);
  }

  void _initializeTags() {
    _allTags = [
      ZephyrTag(text: 'Flutter', category: '框架'),
      ZephyrTag(text: 'React', category: '框架'),
      ZephyrTag(text: 'Vue', category: '框架'),
      ZephyrTag(text: 'Angular', category: '框架'),
      ZephyrTag(text: 'JavaScript', category: '语言'),
      ZephyrTag(text: 'TypeScript', category: '语言'),
      ZephyrTag(text: 'Python', category: '语言'),
      ZephyrTag(text: 'Java', category: '语言'),
      ZephyrTag(text: 'CSS', category: '样式'),
      ZephyrTag(text: 'HTML', category: '样式'),
      ZephyrTag(text: 'SCSS', category: '样式'),
      ZephyrTag(text: 'Node.js', category: '运行时'),
      ZephyrTag(text: 'Deno', category: '运行时'),
      ZephyrTag(text: 'Bun', category: '运行时'),
    ];
    _filteredTags = List.from(_allTags);
  }

  void _filterTags() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredTags = List.from(_allTags);
      } else {
        _filteredTags = _allTags.where((tag) {
          return tag.text.toLowerCase().contains(query);
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
        title: Text('可过滤标签云'),
      ),
      body: Column(
        children: [
          // 搜索框
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '搜索标签',
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
          
          // 分类筛选
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: Text('全部'),
                    selected: true,
                    onSelected: (selected) {
                      _filterByCategory(null);
                    },
                  ),
                  SizedBox(width: 8),
                  FilterChip(
                    label: Text('框架'),
                    onSelected: (selected) {
                      _filterByCategory('框架');
                    },
                  ),
                  SizedBox(width: 8),
                  FilterChip(
                    label: Text('语言'),
                    onSelected: (selected) {
                      _filterByCategory('语言');
                    },
                  ),
                  SizedBox(width: 8),
                  FilterChip(
                    label: Text('样式'),
                    onSelected: (selected) {
                      _filterByCategory('样式');
                    },
                  ),
                  SizedBox(width: 8),
                  FilterChip(
                    label: Text('运行时'),
                    onSelected: (selected) {
                      _filterByCategory('运行时');
                    },
                  ),
                ],
              ),
            ),
          ),
          
          // 标签云
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ZephyrTagCloud(
                tags: _filteredTags,
                placeholderBuilder: () => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        '未找到匹配的标签',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _filterByCategory(String? category) {
    setState(() {
      if (category == null) {
        _filteredTags = List.from(_allTags);
      } else {
        _filteredTags = _allTags.where((tag) {
          return tag.category == category;
        }).toList();
      }
    });
  }
}
```

### 分组标签云

```dart
class GroupedTagCloudExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分组标签云'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // 技术栈分组
            _buildTagGroup(
              title: '技术栈',
              tags: [
                ZephyrTag(text: 'Frontend', color: Colors.blue),
                ZephyrTag(text: 'Backend', color: Colors.green),
                ZephyrTag(text: 'Mobile', color: Colors.orange),
                ZephyrTag(text: 'Desktop', color: Colors.purple),
              ],
            ),
            SizedBox(height: 24),
            
            // 编程语言分组
            _buildTagGroup(
              title: '编程语言',
              tags: [
                ZephyrTag(text: 'JavaScript', color: Colors.yellow),
                ZephyrTag(text: 'Python', color: Colors.blue),
                ZephyrTag(text: 'Java', color: Colors.red),
                ZephyrTag(text: 'C++', color: Colors.purple),
                ZephyrTag(text: 'Go', color: Colors.cyan),
              ],
            ),
            SizedBox(height: 24),
            
            // 工具分组
            _buildTagGroup(
              title: '开发工具',
              tags: [
                ZephyrTag(text: 'VS Code', color: Colors.blue),
                ZephyrTag(text: 'Git', color: Colors.orange),
                ZephyrTag(text: 'Docker', color: Colors.blue),
                ZephyrTag(text: 'Webpack', color: Colors.blue),
                ZephyrTag(text: 'npm', color: Colors.red),
              ],
            ),
            SizedBox(height: 24),
            
            // 框架分组
            _buildTagGroup(
              title: '框架',
              tags: [
                ZephyrTag(text: 'React', color: Colors.blue),
                ZephyrTag(text: 'Vue', color: Colors.green),
                ZephyrTag(text: 'Angular', color: Colors.red),
                ZephyrTag(text: 'Flutter', color: Colors.blue),
                ZephyrTag(text: 'Django', color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagGroup({required String title, required List<ZephyrTag> tags}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          ZephyrTagCloud(
            tags: tags,
          ),
        ],
      ),
    );
  }
}
```

### 动态标签云

```dart
class DynamicTagCloudExample extends StatefulWidget {
  @override
  _DynamicTagCloudExampleState createState() => _DynamicTagCloudExampleState();
}

class _DynamicTagCloudExampleState extends State<DynamicTagCloudExample> {
  List<ZephyrTag> _tags = [];
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _initializeTags();
    _startDynamicUpdates();
  }

  void _initializeTags() {
    _tags = [
      ZephyrTag(text: '热门', weight: 100, color: Colors.red),
      ZephyrTag(text: '推荐', weight: 80, color: Colors.orange),
      ZephyrTag(text: '最新', weight: 60, color: Colors.blue),
      ZephyrTag(text: '关注', weight: 40, color: Colors.green),
      ZephyrTag(text: '收藏', weight: 30, color: Colors.purple),
    ];
  }

  void _startDynamicUpdates() {
    _updateTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      _updateTagWeights();
    });
  }

  void _updateTagWeights() {
    setState(() {
      for (var tag in _tags) {
        // 随机调整权重
        final change = (Random().nextDouble() - 0.5) * 20;
        tag.weight = math.max(20, math.min(100, tag.weight + change));
      }
    });
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态标签云'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 说明信息
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.blue[50],
              child: Text(
                '标签权重每3秒自动更新一次',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[800],
                ),
              ),
            ),
            SizedBox(height: 24),
            
            // 动态标签云
            Expanded(
              child: ZephyrTagCloud(
                type: ZephyrTagCloudType.weighted,
                tags: _tags,
                animate: true,
                animationDuration: Duration(milliseconds: 500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 带计数的标签云

```dart
class CountedTagCloudExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带计数的标签云'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrTagCloud(
          tags: [
            ZephyrTag(
              text: 'JavaScript',
              count: 1234,
              onTap: () => _showTagDetails('JavaScript'),
            ),
            ZephyrTag(
              text: 'Python',
              count: 987,
              onTap: () => _showTagDetails('Python'),
            ),
            ZephyrTag(
              text: 'Java',
              count: 856,
              onTap: () => _showTagDetails('Java'),
            ),
            ZephyrTag(
              text: 'C++',
              count: 654,
              onTap: () => _showTagDetails('C++'),
            ),
            ZephyrTag(
              text: 'Go',
              count: 432,
              onTap: () => _showTagDetails('Go'),
            ),
            ZephyrTag(
              text: 'Rust',
              count: 321,
              onTap: () => _showTagDetails('Rust'),
            ),
            ZephyrTag(
              text: 'Swift',
              count: 210,
              onTap: () => _showTagDetails('Swift'),
            ),
            ZephyrTag(
              text: 'Kotlin',
              count: 198,
              onTap: () => _showTagDetails('Kotlin'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTagDetails(String tag) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了标签: $tag')),
    );
  }
}
```

### 响应式标签云

```dart
class ResponsiveTagCloudExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('响应式标签云'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 根据屏幕宽度调整标签云布局
          final screenWidth = constraints.maxWidth;
          ZephyrTagCloudType cloudType;
          int maxTagsPerRow;
          
          if (screenWidth > 1200) {
            cloudType = ZephyrTagCloudType.weighted;
            maxTagsPerRow = 8;
          } else if (screenWidth > 800) {
            cloudType = ZephyrTagCloudType.basic;
            maxTagsPerRow = 6;
          } else if (screenWidth > 600) {
            cloudType = ZephyrTagCloudType.basic;
            maxTagsPerRow = 4;
          } else {
            cloudType = ZephyrTagCloudType.basic;
            maxTagsPerRow = 3;
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // 屏幕信息显示
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.grey[100],
                  child: Text(
                    '屏幕宽度: ${screenWidth.round()}px\n'
                    '标签云类型: ${cloudType.toString().split('.').last}\n'
                    '每行最多标签: $maxTagsPerRow',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(height: 24),
                
                // 响应式标签云
                ZephyrTagCloud(
                  type: cloudType,
                  maxTagsPerRow: maxTagsPerRow,
                  tags: [
                    ZephyrTag(text: '前端开发'),
                    ZephyrTag(text: '后端开发'),
                    ZephyrTag(text: '移动开发'),
                    ZephyrTag(text: 'UI设计'),
                    ZephyrTag(text: '数据库'),
                    ZephyrTag(text: 'DevOps'),
                    ZephyrTag(text: '测试'),
                    ZephyrTag(text: '部署'),
                    ZephyrTag(text: '监控'),
                    ZephyrTag(text: '安全'),
                    ZephyrTag(text: '性能'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrTagCloud()

```dart
const ZephyrTagCloud({
  Key? key,
  required List<ZephyrTag> tags,
  ZephyrTagCloudType type = ZephyrTagCloudType.basic,
  ZephyrTagCloudStyle? style,
  bool selectable = false,
  Set<String>? selectedTags,
  ValueChanged<Set<String>>? onSelectionChanged,
  int? maxTagsPerRow,
  double? spacing,
  double? runSpacing,
  WrapAlignment? alignment,
  WrapCrossAlignment? crossAxisAlignment,
  Widget Function()? placeholderBuilder,
  Widget Function()? loadingBuilder,
  Widget Function()? errorBuilder,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `tags`: 标签列表
- `type`: 标签云类型
- `style`: 标签云样式
- `selectable`: 是否可选择
- `selectedTags`: 已选择的标签
- `onSelectionChanged`: 选择变化回调
- `maxTagsPerRow`: 每行最多标签数
- `spacing`: 标签间距
- `runSpacing`: 行间距
- `alignment`: 对齐方式
- `crossAxisAlignment`: 交叉轴对齐方式
- `placeholderBuilder`: 空数据占位符构建器
- `loadingBuilder`: 加载状态构建器
- `errorBuilder`: 错误状态构建器
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrTag()

```dart
const ZephyrTag({
  Key? key,
  required String text,
  String? category,
  double? weight,
  int? count,
  Color? color,
  Widget? icon,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  bool selected = false,
  bool enabled = true,
  ZephyrTagStyle? style,
  String? tooltip,
  String? semanticLabel,
})
```

### 枚举类型

#### ZephyrTagCloudType

```dart
enum ZephyrTagCloudType {
  basic,    // 基本标签云
  weighted, // 加权标签云
  grouped,  // 分组标签云
  circular, // 环形标签云
}
```

### 样式类

#### ZephyrTagCloudStyle

```dart
class ZephyrTagCloudStyle {
  final ZephyrTagStyle? tagStyle;
  final double? spacing;
  final double? runSpacing;
  final WrapAlignment? alignment;
  final WrapCrossAlignment? crossAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Decoration? decoration;
}
```

#### ZephyrTagStyle

```dart
class ZephyrTagStyle {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? minWidth;
  final double? minHeight;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final double? elevation;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrTagCloudTheme(
        defaultTagStyle: ZephyrTagStyle(
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.grey[800],
          borderColor: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          minWidth: 60,
          minHeight: 32,
        ),
        defaultSpacing: 8,
        defaultRunSpacing: 8,
        defaultAlignment: WrapAlignment.start,
        defaultCrossAxisAlignment: WrapCrossAlignment.center,
        defaultPadding: EdgeInsets.all(16),
        selectedTagStyle: ZephyrTagStyle(
          backgroundColor: Colors.blue[100],
          foregroundColor: Colors.blue[800],
          borderColor: Colors.blue[300],
        ),
        disabledTagStyle: ZephyrTagStyle(
          backgroundColor: Colors.grey[50],
          foregroundColor: Colors.grey[400],
        ),
        weightedTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
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

- `defaultTagStyle`: 默认标签样式
- `defaultSpacing`: 默认间距
- `defaultRunSpacing`: 默认行间距
- `defaultAlignment`: 默认对齐方式
- `defaultCrossAxisAlignment`: 默认交叉轴对齐方式
- `defaultPadding`: 默认内边距
- `selectedTagStyle`: 选中标签样式
- `disabledTagStyle`: 禁用标签样式
- `weightedTextStyle`: 加权文本样式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的标签云布局

```dart
// ✅ 好的做法：根据内容类型选择合适的布局
// 技术标签使用加权布局
ZephyrTagCloud(
  type: ZephyrTagCloudType.weighted,
  tags: _buildTechTags(),
)

// 分类标签使用分组布局
ZephyrTagCloud(
  type: ZephyrTagCloudType.grouped,
  tags: _buildCategoryTags(),
)

// ✅ 好的做法：响应式布局
class ResponsiveTagCloud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        return ZephyrTagCloud(
          maxTagsPerRow: screenWidth > 600 ? 6 : 3,
          tags: _buildTags(),
        );
      },
    );
  }
}

// ❌ 避免的做法：固定布局不考虑响应式
ZephyrTagCloud(
  maxTagsPerRow: 8, // 在小屏幕上可能显示不全
  tags: _buildTags(),
)
```

### 2. 合理的标签数量

```dart
// ✅ 好的做法：控制标签数量
ZephyrTagCloud(
  tags: _buildTopTags(20), // 只显示前20个热门标签
)

// ✅ 好的做法：提供"查看更多"功能
ZephyrTagCloud(
  tags: _buildVisibleTags(),
  trailing: TextButton(
    onPressed: () => _showAllTags(),
    child: Text('查看更多'),
  ),
)

// ✅ 好的做法：使用分页或懒加载
ZephyrTagCloud(
  tags: _getCurrentPageTags(),
  onPageChanged: _loadMoreTags,
)

// ❌ 避免的做法：标签过多导致性能问题
ZephyrTagCloud(
  tags: _buildAllTags(), // 可能包含数百个标签
)
```

### 3. 清晰的视觉层次

```dart
// ✅ 好的做法：使用权重区分重要性
ZephyrTag(
  text: '热门话题',
  weight: 100, // 更大更显眼
  color: Colors.red,
)

// ✅ 好的做法：使用颜色区分类别
ZephyrTag(
  text: '技术',
  color: Colors.blue,
)

// ✅ 好的做法：使用图标增强识别性
ZephyrTag(
  text: '代码',
  icon: Icon(Icons.code),
)

// ❌ 避免的做法：所有标签看起来一样
ZephyrTag(
  text: '标签1',
  // 缺乏视觉区分
)
```

### 4. 用户体验优化

```dart
// ✅ 好的做法：提供搜索和筛选
ZephyrTagCloud(
  tags: _filteredTags,
  searchable: true,
  filterable: true,
)

// ✅ 好的做法：支持选择操作
ZephyrTagCloud(
  selectable: true,
  selectedTags: _selectedTags,
  onSelectionChanged: _handleSelection,
)

// ✅ 好的做法：提供点击反馈
ZephyrTag(
  text: '可点击标签',
  onTap: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了标签')),
    );
  },
)

// ❌ 避免的做法：缺乏用户反馈
ZephyrTag(
  text: '无反馈标签',
  onTap: () {
    // 没有任何用户反馈
  },
)
```

## 🔄 相关组件

- **ZephyrChip**: 芯片组件
- **ZephyrBadge`: 徽章组件
- **ZephyrFilterChip`: 筛选芯片组件
- **ZephyrInputChip`: 输入芯片组件
- **ZephyrChoiceChip`: 选择芯片组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种标签云模式
- ✅ 支持自定义样式和交互
- ✅ 支持选择和过滤
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/tag_clouds/`
**示例路径**: `example/lib/components/tag_clouds_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日