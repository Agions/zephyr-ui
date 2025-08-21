# ZephyrBreadcrumb 面包屑导航组件

面包屑导航组件是ZephyrUI导航系统的重要组件，提供了清晰的路径导航功能。支持多种显示模式、自定义样式和交互方式，是构建文件系统、分类导航、层级导航等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种显示模式**: 支持图标、文本、下拉菜单等多种模式
- **灵活布局**: 支持水平、垂直、响应式布局
- **丰富交互**: 支持点击、悬停、键盘导航等交互
- **自定义样式**: 支持自定义分隔符、颜色、字体等样式
- **响应式设计**: 根据屏幕尺寸自动调整显示方式
- **主题适配**: 完整的主题系统支持

### 适用场景
- 文件系统导航
- 网站层级导航
- 分类导航
- 产品分类导航
- 用户中心导航
- 管理后台导航

## 🚀 基础用法

### 基本面包屑

```dart
class BasicBreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本面包屑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrBreadcrumb(
              items: [
                ZephyrBreadcrumbItem(
                  label: '首页',
                  onTap: () => _navigateTo('home'),
                ),
                ZephyrBreadcrumbItem(
                  label: '产品',
                  onTap: () => _navigateTo('products'),
                ),
                ZephyrBreadcrumbItem(
                  label: '电子产品',
                  onTap: () => _navigateTo('electronics'),
                ),
                ZephyrBreadcrumbItem(
                  label: '手机',
                  isActive: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('当前页面：手机'),
          ],
        ),
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

### 带图标的面包屑

```dart
class IconBreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带图标的面包屑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrBreadcrumb(
              items: [
                ZephyrBreadcrumbItem(
                  icon: Icon(Icons.home),
                  label: '首页',
                  onTap: () => _navigateTo('home'),
                ),
                ZephyrBreadcrumbItem(
                  icon: Icon(Icons.folder),
                  label: '文档',
                  onTap: () => _navigateTo('documents'),
                ),
                ZephyrBreadcrumbItem(
                  icon: Icon(Icons.insert_drive_file),
                  label: '项目',
                  onTap: () => _navigateTo('projects'),
                ),
                ZephyrBreadcrumbItem(
                  icon: Icon(Icons.description),
                  label: '报告.pdf',
                  isActive: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('当前文件：报告.pdf'),
          ],
        ),
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

### 可折叠的面包屑

```dart
class CollapsibleBreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可折叠的面包屑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrBreadcrumb(
              maxItems: 3,
              collapsedItem: ZephyrBreadcrumbItem(
                label: '...',
                onTap: () => _showAllPaths(),
              ),
              items: [
                ZephyrBreadcrumbItem(
                  label: '首页',
                  onTap: () => _navigateTo('home'),
                ),
                ZephyrBreadcrumbItem(
                  label: '部门',
                  onTap: () => _navigateTo('departments'),
                ),
                ZephyrBreadcrumbItem(
                  label: '技术部',
                  onTap: () => _navigateTo('tech'),
                ),
                ZephyrBreadcrumbItem(
                  label: '前端组',
                  onTap: () => _navigateTo('frontend'),
                ),
                ZephyrBreadcrumbItem(
                  label: '项目',
                  onTap: () => _navigateTo('projects'),
                ),
                ZephyrBreadcrumbItem(
                  label: 'ZephyrUI',
                  isActive: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('当前项目：ZephyrUI'),
          ],
        ),
      ),
    );
  }

  void _navigateTo(String route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('导航到: $route')),
    );
  }

  void _showAllPaths() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('显示完整路径')),
    );
  }
}
```

## 🎨 样式定制

### 自定义分隔符

```dart
class CustomSeparatorBreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义分隔符'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 箭头分隔符
            ZephyrBreadcrumb(
              separator: Icon(Icons.chevron_right, size: 16),
              items: [
                ZephyrBreadcrumbItem(label: '首页', onTap: () {}),
                ZephyrBreadcrumbItem(label: '产品', onTap: () {}),
                ZephyrBreadcrumbItem(label: '手机', isActive: true),
              ],
            ),
            SizedBox(height: 16),
            // 斜杠分隔符
            ZephyrBreadcrumb(
              separator: Text('/'),
              items: [
                ZephyrBreadcrumbItem(label: '首页', onTap: () {}),
                ZephyrBreadcrumbItem(label: '产品', onTap: () {}),
                ZephyrBreadcrumbItem(label: '手机', isActive: true),
              ],
            ),
            SizedBox(height: 16),
            // 自定义分隔符
            ZephyrBreadcrumb(
              separator: Container(
                width: 2,
                height: 16,
                color: Colors.grey[400],
              ),
              items: [
                ZephyrBreadcrumbItem(label: '首页', onTap: () {}),
                ZephyrBreadcrumbItem(label: '产品', onTap: () {}),
                ZephyrBreadcrumbItem(label: '手机', isActive: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 彩色面包屑

```dart
class ColoredBreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('彩色面包屑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrBreadcrumb(
              itemStyle: ZephyrBreadcrumbItemStyle(
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[600],
                hoverColor: Colors.blue.withOpacity(0.1),
                textStyle: TextStyle(fontSize: 14),
                activeTextStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              separatorStyle: ZephyrBreadcrumbSeparatorStyle(
                color: Colors.grey[400],
              ),
              items: [
                ZephyrBreadcrumbItem(
                  label: '首页',
                  onTap: () => _navigateTo('home'),
                ),
                ZephyrBreadcrumbItem(
                  label: '产品',
                  onTap: () => _navigateTo('products'),
                ),
                ZephyrBreadcrumbItem(
                  label: '电子产品',
                  onTap: () => _navigateTo('electronics'),
                ),
                ZephyrBreadcrumbItem(
                  label: '手机',
                  isActive: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('当前分类：手机'),
          ],
        ),
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

### 带背景的面包屑

```dart
class BackgroundBreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带背景的面包屑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrBreadcrumb(
              itemStyle: ZephyrBreadcrumbItemStyle(
                backgroundColor: Colors.grey[100],
                activeBackgroundColor: Colors.blue[50],
                borderRadius: BorderRadius.circular(4),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              items: [
                ZephyrBreadcrumbItem(
                  label: '首页',
                  onTap: () => _navigateTo('home'),
                ),
                ZephyrBreadcrumbItem(
                  label: '设置',
                  onTap: () => _navigateTo('settings'),
                ),
                ZephyrBreadcrumbItem(
                  label: '隐私设置',
                  isActive: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('当前设置：隐私设置'),
          ],
        ),
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

### 下拉菜单面包屑

```dart
class DropdownBreadcrumbExample extends StatefulWidget {
  @override
  _DropdownBreadcrumbExampleState createState() => _DropdownBreadcrumbExampleState();
}

class _DropdownBreadcrumbExampleState extends State<DropdownBreadcrumbExample> {
  String _selectedCategory = '电子产品';
  String _selectedSubcategory = '手机';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下拉菜单面包屑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrBreadcrumb(
              items: [
                ZephyrBreadcrumbItem(
                  label: '首页',
                  onTap: () => _navigateTo('home'),
                ),
                ZephyrBreadcrumbItem(
                  label: _selectedCategory,
                  isDropdown: true,
                  dropdownItems: [
                    DropdownMenuItem(
                      value: '电子产品',
                      child: Text('电子产品'),
                    ),
                    DropdownMenuItem(
                      value: '服装',
                      child: Text('服装'),
                    ),
                    DropdownMenuItem(
                      value: '食品',
                      child: Text('食品'),
                    ),
                  ],
                  onDropdownChanged: (value) {
                    setState(() => _selectedCategory = value!);
                  },
                ),
                ZephyrBreadcrumbItem(
                  label: _selectedSubcategory,
                  isDropdown: true,
                  dropdownItems: _getSubcategoryItems(_selectedCategory),
                  onDropdownChanged: (value) {
                    setState(() => _selectedSubcategory = value!);
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('当前选择：$_selectedCategory > $_selectedSubcategory'),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getSubcategoryItems(String category) {
    switch (category) {
      case '电子产品':
        return [
          DropdownMenuItem(value: '手机', child: Text('手机')),
          DropdownMenuItem(value: '电脑', child: Text('电脑')),
          DropdownMenuItem(value: '平板', child: Text('平板')),
        ];
      case '服装':
        return [
          DropdownMenuItem(value: '男装', child: Text('男装')),
          DropdownMenuItem(value: '女装', child: Text('女装')),
          DropdownMenuItem(value: '童装', child: Text('童装')),
        ];
      case '食品':
        return [
          DropdownMenuItem(value: '水果', child: Text('水果')),
          DropdownMenuItem(value: '蔬菜', child: Text('蔬菜')),
          DropdownMenuItem(value: '肉类', child: Text('肉类')),
        ];
      default:
        return [];
    }
  }

  void _navigateTo(String route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('导航到: $route')),
    );
  }
}
```

### 响应式面包屑

```dart
class ResponsiveBreadcrumbExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('响应式面包屑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '屏幕宽度: ${screenWidth.round()}px',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ZephyrBreadcrumb(
              maxItems: screenWidth < 600 ? 3 : 5,
              collapsedItem: ZephyrBreadcrumbItem(
                label: '...',
                onTap: () => _showFullBreadcrumb(),
              ),
              responsive: true,
              items: [
                ZephyrBreadcrumbItem(
                  label: '首页',
                  onTap: () => _navigateTo('home'),
                ),
                ZephyrBreadcrumbItem(
                  label: '公司',
                  onTap: () => _navigateTo('company'),
                ),
                ZephyrBreadcrumbItem(
                  label: '部门',
                  onTap: () => _navigateTo('departments'),
                ),
                ZephyrBreadcrumbItem(
                  label: '技术部',
                  onTap: () => _navigateTo('tech'),
                ),
                ZephyrBreadcrumbItem(
                  label: '前端组',
                  onTap: () => _navigateTo('frontend'),
                ),
                ZephyrBreadcrumbItem(
                  label: '项目',
                  onTap: () => _navigateTo('projects'),
                ),
                ZephyrBreadcrumbItem(
                  label: 'ZephyrUI',
                  isActive: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('当前项目：ZephyrUI'),
          ],
        ),
      ),
    );
  }

  void _navigateTo(String route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('导航到: $route')),
    );
  }

  void _showFullBreadcrumb() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('显示完整面包屑')),
    );
  }
}
```

### 带搜索的面包屑

```dart
class SearchBreadcrumbExample extends StatefulWidget {
  @override
  _SearchBreadcrumbExampleState createState() => _SearchBreadcrumbExampleState();
}

class _SearchBreadcrumbExampleState extends State<SearchBreadcrumbExample> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带搜索的面包屑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 搜索框
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '搜索路径',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
            SizedBox(height: 16),
            // 带搜索的面包屑
            ZephyrBreadcrumb(
              searchQuery: _searchQuery,
              searchMode: ZephyrBreadcrumbSearchMode.filter,
              items: [
                ZephyrBreadcrumbItem(
                  label: '首页',
                  onTap: () => _navigateTo('home'),
                ),
                ZephyrBreadcrumbItem(
                  label: '文档',
                  onTap: () => _navigateTo('documents'),
                ),
                ZephyrBreadcrumbItem(
                  label: '项目',
                  onTap: () => _navigateTo('projects'),
                ),
                ZephyrBreadcrumbItem(
                  label: 'ZephyrUI',
                  isActive: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            Text('当前项目：ZephyrUI'),
          ],
        ),
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

### 带历史记录的面包屑

```dart
class HistoryBreadcrumbExample extends StatefulWidget {
  @override
  _HistoryBreadcrumbExampleState createState() => _HistoryBreadcrumbExampleState();
}

class _HistoryBreadcrumbExampleState extends State<HistoryBreadcrumbExample> {
  List<String> _navigationHistory = ['首页'];
  int _currentIndex = 0;

  void _navigateTo(String path) {
    setState(() {
      // 如果不是当前路径，添加到历史记录
      if (_currentIndex < _navigationHistory.length - 1) {
        _navigationHistory = _navigationHistory.sublist(0, _currentIndex + 1);
      }
      _navigationHistory.add(path);
      _currentIndex = _navigationHistory.length - 1;
    });
  }

  void _navigateBack() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  void _navigateForward() {
    if (_currentIndex < _navigationHistory.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带历史记录的面包屑'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _currentIndex > 0 ? _navigateBack : null,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _currentIndex < _navigationHistory.length - 1 ? _navigateForward : null,
                ),
                SizedBox(width: 16),
                Text('导航历史'),
              ],
            ),
            SizedBox(height: 16),
            ZephyrBreadcrumb(
              items: _navigationHistory.asMap().entries.map((entry) {
                final index = entry.key;
                final path = entry.value;
                return ZephyrBreadcrumbItem(
                  label: path,
                  isActive: index == _currentIndex,
                  onTap: () {
                    setState(() => _currentIndex = index);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 24),
            Text('当前位置：${_navigationHistory[_currentIndex]}'),
            SizedBox(height: 16),
            Text('历史记录：${_navigationHistory.join(' > ')}'),
          ],
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrBreadcrumb()

```dart
const ZephyrBreadcrumb({
  Key? key,
  required List<ZephyrBreadcrumbItem> items,
  Widget? separator,
  ZephyrBreadcrumbItemStyle? itemStyle,
  ZephyrBreadcrumbSeparatorStyle? separatorStyle,
  int? maxItems,
  ZephyrBreadcrumbItem? collapsedItem,
  bool responsive = false,
  String? searchQuery,
  ZephyrBreadcrumbSearchMode searchMode = ZephyrBreadcrumbSearchMode.none,
  CrossAxisAlignment alignment = CrossAxisAlignment.start,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  EdgeInsetsGeometry? padding,
  double? spacing,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `items`: 面包屑项目列表
- `separator`: 分隔符组件
- `itemStyle`: 项目样式
- `separatorStyle`: 分隔符样式
- `maxItems`: 最大显示项目数
- `collapsedItem`: 折叠项目
- `responsive`: 是否响应式
- `searchQuery`: 搜索查询
- `searchMode`: 搜索模式
- `alignment`: 对齐方式
- `mainAxisAlignment`: 主轴对齐方式
- `padding`: 内边距
- `spacing`: 间距
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrBreadcrumbItem()

```dart
const ZephyrBreadcrumbItem({
  Key? key,
  required String label,
  Widget? icon,
  VoidCallback? onTap,
  bool isActive = false,
  bool isDropdown = false,
  List<DropdownMenuItem<Object>>? dropdownItems,
  ValueChanged<Object?>? onDropdownChanged,
  String? tooltip,
  String? semanticLabel,
})
```

### 枚举类型

#### ZephyrBreadcrumbSearchMode

```dart
enum ZephyrBreadcrumbSearchMode {
  none,   // 无搜索
  filter, // 过滤模式
  highlight, // 高亮模式
}
```

### 样式类

#### ZephyrBreadcrumbItemStyle

```dart
class ZephyrBreadcrumbItemStyle {
  final Color? color;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? hoverColor;
  final Color? backgroundColor;
  final Color? activeBackgroundColor;
  final TextStyle? textStyle;
  final TextStyle? activeTextStyle;
  final TextStyle? inactiveTextStyle;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final Cursor? cursor;
}
```

#### ZephyrBreadcrumbSeparatorStyle

```dart
class ZephyrBreadcrumbSeparatorStyle {
  final Color? color;
  final double? size;
  final EdgeInsetsGeometry? padding;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrBreadcrumbTheme(
        defaultSeparator: Icon(Icons.chevron_right, size: 16),
        defaultItemStyle: ZephyrBreadcrumbItemStyle(
          color: Colors.blue,
          activeColor: Colors.black87,
          inactiveColor: Colors.grey[600],
          hoverColor: Colors.blue.withOpacity(0.1),
          textStyle: TextStyle(fontSize: 14),
          activeTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          inactiveTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          borderRadius: BorderRadius.circular(4),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          iconSize: 16,
          cursor: SystemMouseCursors.click,
        ),
        defaultSeparatorStyle: ZephyrBreadcrumbSeparatorStyle(
          color: Colors.grey[400],
          size: 16,
          padding: EdgeInsets.symmetric(horizontal: 4),
        ),
        defaultMaxItems: 5,
        defaultCollapsedItem: ZephyrBreadcrumbItem(
          label: '...',
        ),
        spacing: 4,
        padding: EdgeInsets.all(8),
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeInOut,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultSeparator`: 默认分隔符
- `defaultItemStyle`: 默认项目样式
- `defaultSeparatorStyle`: 默认分隔符样式
- `defaultMaxItems`: 默认最大显示项目数
- `defaultCollapsedItem`: 默认折叠项目
- `spacing`: 间距
- `padding`: 内边距
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线

## 🏆 最佳实践

### 1. 合理的面包屑长度

```dart
// ✅ 好的做法：控制面包屑长度
ZephyrBreadcrumb(
  maxItems: 5,
  collapsedItem: ZephyrBreadcrumbItem(
    label: '...',
    onTap: () => _showFullBreadcrumb(),
  ),
  items: _buildBreadcrumbItems(),
)

// ✅ 好的做法：使用下拉菜单
ZephyrBreadcrumb(
  items: [
    ZephyrBreadcrumbItem(
      label: '首页',
      onTap: () {},
    ),
    ZephyrBreadcrumbItem(
      label: '分类',
      isDropdown: true,
      dropdownItems: _buildCategoryItems(),
      onDropdownChanged: (value) {},
    ),
    ZephyrBreadcrumbItem(
      label: '当前页面',
      isActive: true,
    ),
  ],
)

// ❌ 避免的做法：过长的面包屑
ZephyrBreadcrumb(
  items: [
    // 10个以上的项目，占用过多空间
  ],
)
```

### 2. 清晰的导航路径

```dart
// ✅ 好的做法：使用有意义的标签
ZephyrBreadcrumb(
  items: [
    ZephyrBreadcrumbItem(
      label: '首页',
      onTap: () {},
    ),
    ZephyrBreadcrumbItem(
      label: '产品管理',
      onTap: () {},
    ),
    ZephyrBreadcrumbItem(
      label: '添加产品',
      isActive: true,
    ),
  ],
)

// ✅ 好的做法：使用图标增强识别
ZephyrBreadcrumb(
  items: [
    ZephyrBreadcrumbItem(
      icon: Icon(Icons.home),
      label: '首页',
      onTap: () {},
    ),
    ZephyrBreadcrumbItem(
      icon: Icon(Icons.folder),
      label: '文档',
      onTap: () {},
    ),
  ],
)

// ❌ 避免的做法：使用模糊的标签
ZephyrBreadcrumb(
  items: [
    ZephyrBreadcrumbItem(
      label: '页面1',
      onTap: () {},
    ),
    ZephyrBreadcrumbItem(
      label: '页面2',
      isActive: true,
    ),
  ],
)
```

### 3. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整
class ResponsiveBreadcrumb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ZephyrBreadcrumb(
      maxItems: screenWidth < 600 ? 3 : 5,
      responsive: true,
      items: _buildBreadcrumbItems(),
    );
  }
}

// ✅ 好的做法：使用可滚动的面包屑
ZephyrBreadcrumb(
  items: _buildBreadcrumbItems(),
  scrollable: true,
)

// ❌ 避免的做法：不考虑响应式
ZephyrBreadcrumb(
  maxItems: 10, // 在小屏幕上会溢出
  items: _buildBreadcrumbItems(),
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrBreadcrumb(
  semanticLabel: '页面导航路径',
  enableAccessibilityFeatures: true,
  items: [
    ZephyrBreadcrumbItem(
      label: '首页',
      semanticLabel: '返回首页',
      onTap: () {},
    ),
    ZephyrBreadcrumbItem(
      label: '设置',
      semanticLabel: '打开设置页面',
      onTap: () {},
    ),
  ],
)

// ✅ 好的做法：提供工具提示
ZephyrBreadcrumb(
  items: [
    ZephyrBreadcrumbItem(
      label: '首页',
      tooltip: '返回首页',
      onTap: () {},
    ),
  ],
)

// ❌ 避免的做法：缺乏无障碍支持
ZephyrBreadcrumb(
  items: [
    ZephyrBreadcrumbItem(
      label: '首页',
      onTap: () {},
      // 缺乏语义信息
    ),
  ],
)
```

## 🔄 相关组件

- **ZephyrNavigationRail**: 导航栏组件
- **ZephyrSideMenu**: 侧边菜单组件
- **ZephyrTabs**: 选项卡组件
- **ZephyrBottomNavigationBar**: 底部导航栏组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本面包屑功能
- ✅ 支持下拉菜单和折叠
- ✅ 支持响应式设计
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/navigation/breadcrumb/`
**示例路径**: `example/lib/components/breadcrumb_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日