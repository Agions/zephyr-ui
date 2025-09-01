# ZephyrAccordion 手风琴组件

手风琴组件是ZephyrUI布局系统中的重要组件，提供了可折叠的内容展示方式。支持多种展开模式、动画效果和自定义样式，是构建FAQ、设置页面、内容分类等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种展开模式**: 支持单展开、多展开、全部展开模式
- **流畅动画**: 内置平滑的展开/收起动画效果
- **灵活布局**: 支持自定义头部、内容和装饰样式
- **丰富交互**: 支持点击、悬停、键盘导航等交互
- **状态管理**: 完整的展开状态控制和回调机制
- **主题适配**: 完整的主题系统支持

### 适用场景
- FAQ页面
- 设置页面分组
- 产品详情展开
- 内容分类展示
- 帮助文档
- 折叠式菜单

## 🚀 基础用法

### 基本手风琴

```dart
ZephyrAccordion(
  items: [
    ZephyrAccordionItem(
      title: '什么是Flutter？',
      content: 'Flutter是Google开发的跨平台UI框架，可以使用单一代码库构建移动、Web和桌面应用。',
    ),
    ZephyrAccordionItem(
      title: 'ZephyrUI是什么？',
      content: 'ZephyrUI是一个基于Flutter的UI组件库，提供了丰富的预构建组件和设计系统。',
    ),
    ZephyrAccordionItem(
      title: '如何使用手风琴组件？',
      content: '通过ZephyrAccordion和ZephyrAccordionItem可以轻松创建手风琴效果。',
    ),
  ],
)
```

### 单展开模式

```dart
ZephyrAccordion(
  mode: ZephyrAccordionMode.single,
  items: [
    ZephyrAccordionItem(
      title: '个人设置',
      content: Text('在这里设置个人信息和偏好'),
    ),
    ZephyrAccordionItem(
      title: '账户设置',
      content: Text('在这里管理账户和安全设置'),
    ),
    ZephyrAccordionItem(
      title: '隐私设置',
      content: Text('在这里配置隐私和数据共享选项'),
    ),
  ],
)
```

### 多展开模式

```dart
ZephyrAccordion(
  mode: ZephyrAccordionMode.multiple,
  items: [
    ZephyrAccordionItem(
      title: '基础功能',
      content: Text('包含应用的基础功能介绍'),
    ),
    ZephyrAccordionItem(
      title: '高级功能',
      content: Text('包含应用的高级功能介绍'),
    ),
    ZephyrAccordionItem(
      title: '专业功能',
      content: Text('包含应用的专业功能介绍'),
    ),
  ],
)
```

### 带图标的手风琴

```dart
ZephyrAccordion(
  items: [
    ZephyrAccordionItem(
      title: '用户管理',
      leading: Icon(Icons.person),
      content: Text('管理用户账户和权限'),
    ),
    ZephyrAccordionItem(
      title: '系统设置',
      leading: Icon(Icons.settings),
      content: Text('配置系统参数和选项'),
    ),
    ZephyrAccordionItem(
      title: '数据备份',
      leading: Icon(Icons.backup),
      content: Text('备份和恢复应用数据'),
    ),
  ],
)
```

## 🎨 样式定制

### 头部样式

```dart
ZephyrAccordion(
  headerStyle: ZephyrAccordionHeaderStyle(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    borderRadius: BorderRadius.circular(8),
    padding: EdgeInsets.all(16),
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
  items: [
    ZephyrAccordionItem(
      title: '自定义头部',
      content: Text('这个手风琴使用了自定义的头部样式'),
    ),
    ZephyrAccordionItem(
      title: '统一设计',
      content: Text('所有项目都使用相同的头部样式'),
    ),
  ],
)
```

### 内容样式

```dart
ZephyrAccordion(
  contentStyle: ZephyrAccordionContentStyle(
    backgroundColor: Colors.grey[50],
    padding: EdgeInsets.all(16),
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
    textStyle: TextStyle(
      fontSize: 14,
      color: Colors.grey[700],
    ),
  ),
  items: [
    ZephyrAccordionItem(
      title: '自定义内容',
      content: Text('这个手风琴使用了自定义的内容样式'),
    ),
    ZephyrAccordionItem(
      title: '内容装饰',
      content: Text('内容区域有特殊的背景和边框样式'),
    ),
  ],
)
```

### 分割线样式

```dart
ZephyrAccordion(
  showDividers: true,
  dividerStyle: DividerStyle(
    color: Colors.grey[300],
    thickness: 1,
    indent: 16,
    endIndent: 16,
  ),
  items: [
    ZephyrAccordionItem(
      title: '带分割线',
      content: Text('手风琴项目之间有分割线'),
    ),
    ZephyrAccordionItem(
      title: '视觉分离',
      content: Text('分割线帮助用户区分不同的项目'),
    ),
    ZephyrAccordionItem(
      title: '清晰布局',
      content: Text('分割线让布局更加清晰'),
    ),
  ],
)
```

## 🔧 高级用法

### 自定义头部组件

```dart
class CustomHeaderAccordion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrAccordion(
      items: [
        ZephyrAccordionItem(
          title: '自定义头部',
          headerBuilder: (isExpanded) {
            return ZephyrContainer(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? Colors.blue : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: isExpanded ? Colors.white : Colors.grey[600],
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '自定义头部',
                      style: TextStyle(
                        color: isExpanded ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? Colors.white : Colors.grey[600],
                  ),
                ],
              ),
            );
          },
          content: Text('这个手风琴使用了自定义的头部组件'),
        ),
      ],
    );
  }
}
```

### 带状态的手风琴

```dart
class StatefulAccordion extends StatefulWidget {
  @override
  _StatefulAccordionState createState() => _StatefulAccordionState();
}

class _StatefulAccordionState extends State<StatefulAccordion> {
  Set<int> _expandedItems = {};
  bool _isLoading = false;

  Future<void> _handleExpansion(int index, bool isExpanded) async {
    if (isExpanded) {
      setState(() {
        _expandedItems.remove(index);
      });
    } else {
      setState(() {
        _isLoading = true;
        _expandedItems.add(index);
      });
      
      // 模拟异步加载
      await Future.delayed(Duration(seconds: 1));
      
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrAccordion(
      mode: ZephyrAccordionMode.multiple,
      initiallyExpanded: _expandedItems.toList(),
      onExpansionChanged: _handleExpansion,
      items: [
        ZephyrAccordionItem(
          title: '动态内容',
          content: _isLoading && _expandedItems.contains(0)
              ? Center(child: CircularProgressIndicator())
              : Text('这个内容是动态加载的'),
        ),
        ZephyrAccordionItem(
          title: '状态管理',
          content: Text('手风琴的展开状态被单独管理'),
        ),
        ZephyrAccordionItem(
          title: '异步操作',
          content: Text('支持展开时的异步操作'),
        ),
      ],
    );
  }
}
```

### 嵌套手风琴

```dart
class NestedAccordion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrAccordion(
      items: [
        ZephyrAccordionItem(
          title: '主要分类 1',
          content: ZephyrAccordion(
            items: [
              ZephyrAccordionItem(
                title: '子分类 1.1',
                content: Text('这是子分类 1.1 的内容'),
              ),
              ZephyrAccordionItem(
                title: '子分类 1.2',
                content: Text('这是子分类 1.2 的内容'),
              ),
            ],
          ),
        ),
        ZephyrAccordionItem(
          title: '主要分类 2',
          content: ZephyrAccordion(
            items: [
              ZephyrAccordionItem(
                title: '子分类 2.1',
                content: Text('这是子分类 2.1 的内容'),
              ),
              ZephyrAccordionItem(
                title: '子分类 2.2',
                content: Text('这是子分类 2.2 的内容'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
```

### 可搜索的手风琴

```dart
class SearchableAccordion extends StatefulWidget {
  @override
  _SearchableAccordionState createState() => _SearchableAccordionState();
}

class _SearchableAccordionState extends State<SearchableAccordion> {
  final TextEditingController _searchController = TextEditingController();
  List<ZephyrAccordionItem> _allItems = [];
  List<ZephyrAccordionItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _initializeItems();
    _searchController.addListener(_filterItems);
  }

  void _initializeItems() {
    _allItems = [
      ZephyrAccordionItem(
        title: 'Flutter基础',
        content: Text('Flutter的基础知识和概念'),
      ),
      ZephyrAccordionItem(
        title: 'Dart语言',
        content: Text('Dart编程语言的特性'),
      ),
      ZephyrAccordionItem(
        title: 'Widget系统',
        content: Text('Flutter的Widget系统和状态管理'),
      ),
      ZephyrAccordionItem(
        title: '路由导航',
        content: Text('Flutter的路由和导航系统'),
      ),
      ZephyrAccordionItem(
        title: '网络请求',
        content: Text('Flutter中的网络请求处理'),
      ),
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
          return item.title.toLowerCase().contains(query);
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
    return ZephyrContainer(
      child: Column(
        children: [
          // 搜索框
          ZephyrContainer(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '搜索手风琴项目',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          
          // 手风琴
          Expanded(
            child: ZephyrAccordion(
              items: _filteredItems,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 带进度指示的手风琴

```dart
class ProgressAccordion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrAccordion(
      items: [
        ZephyrAccordionItem(
          title: '完成步骤',
          trailing: Icon(Icons.check_circle, color: Colors.green),
          content: Text('这个步骤已经完成'),
        ),
        ZephyrAccordionItem(
          title: '进行中步骤',
          trailing: CircularProgressIndicator(strokeWidth: 2),
          content: Text('这个步骤正在进行中'),
        ),
        ZephyrAccordionItem(
          title: '待开始步骤',
          trailing: Icon(Icons.radio_button_unchecked, color: Colors.grey),
          content: Text('这个步骤还未开始'),
        ),
        ZephyrAccordionItem(
          title: '错误步骤',
          trailing: Icon(Icons.error, color: Colors.red),
          content: Text('这个步骤出现了错误'),
        ),
      ],
    );
  }
}
```

### 表格式手风琴

```dart
class TableAccordion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrAccordion(
      items: [
        ZephyrAccordionItem(
          title: '用户信息',
          headerBuilder: (isExpanded) {
            return ZephyrContainer(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(child: Text('字段')),
                  Expanded(child: Text('值')),
                  Expanded(child: Text('操作')),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
            );
          },
          content: Column(
            children: [
              _buildTableRow('姓名', '张三', '编辑'),
              _buildTableRow('年龄', '25', '编辑'),
              _buildTableRow('邮箱', 'zhangsan@example.com', '编辑'),
            ],
          ),
        ),
        ZephyrAccordionItem(
          title: '系统设置',
          headerBuilder: (isExpanded) {
            return ZephyrContainer(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(child: Text('设置项')),
                  Expanded(child: Text('当前值')),
                  Expanded(child: Text('状态')),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
            );
          },
          content: Column(
            children: [
              _buildTableRow('通知', '开启', '正常'),
              _buildTableRow('自动更新', '关闭', '正常'),
              _buildTableRow('暗色主题', '开启', '正常'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(String field, String value, String action) {
    return ZephyrContainer(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(field)),
          Expanded(child: Text(value)),
          Expanded(child: Text(action)),
        ],
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrAccordion()

```dart
const ZephyrAccordion({
  Key? key,
  required List<ZephyrAccordionItem> items,
  ZephyrAccordionMode mode = ZephyrAccordionMode.single,
  List<int>? initiallyExpanded,
  ValueChanged<int>? onExpansionChanged,
  Duration? animationDuration,
  Curve? animationCurve,
  ZephyrAccordionHeaderStyle? headerStyle,
  ZephyrAccordionContentStyle? contentStyle,
  bool showDividers = false,
  DividerStyle? dividerStyle,
  EdgeInsetsGeometry? padding,
  bool showTrailingIcon = true,
  Widget? trailingIcon,
  Widget? expandedTrailingIcon,
  bool showLeadingIcon = false,
  double elevation = 0,
  double borderRadius = 8,
  String? semanticLabel,
})
```

**参数说明：**
- `items`: 手风琴项目列表
- `mode`: 展开模式（单展开、多展开）
- `initiallyExpanded`: 初始展开的项目索引
- `onExpansionChanged`: 展开状态变化回调
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `headerStyle`: 头部样式
- `contentStyle`: 内容样式
- `showDividers`: 是否显示分割线
- `dividerStyle`: 分割线样式
- `padding`: 内边距
- `showTrailingIcon`: 是否显示尾部图标
- `trailingIcon`: 收起状态图标
- `expandedTrailingIcon`: 展开状态图标
- `showLeadingIcon`: 是否显示前导图标
- `elevation`: 阴影高度
- `borderRadius`: 边框圆角
- `semanticLabel`: 语义标签

#### ZephyrAccordionItem()

```dart
const ZephyrAccordionItem({
  Key? key,
  required String title,
  required Widget content,
  Widget? leading,
  Widget? trailing,
  bool initiallyExpanded = false,
  ValueChanged<bool>? onExpansionChanged,
  Widget Function(bool isExpanded)? headerBuilder,
  EdgeInsetsGeometry? headerPadding,
  EdgeInsetsGeometry? contentPadding,
  bool enabled = true,
  String? semanticLabel,
})
```

### 枚举类型

#### ZephyrAccordionMode

```dart
enum ZephyrAccordionMode {
  single,    // 单展开模式
  multiple,  // 多展开模式
}
```

### 样式类

#### ZephyrAccordionHeaderStyle

```dart
class ZephyrAccordionHeaderStyle {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? elevation;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
}
```

#### ZephyrAccordionContentStyle

```dart
class ZephyrAccordionContentStyle {
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrAccordionTheme(
        defaultMode: ZephyrAccordionMode.single,
        defaultAnimationDuration: Duration(milliseconds: 300),
        defaultAnimationCurve: Curves.easeInOut,
        defaultHeaderStyle: ZephyrAccordionHeaderStyle(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          borderRadius: BorderRadius.circular(8),
          padding: EdgeInsets.all(16),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          elevation: 1,
        ),
        defaultContentStyle: ZephyrAccordionContentStyle(
          backgroundColor: Colors.grey[50],
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
          padding: EdgeInsets.all(16),
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        defaultDividerStyle: DividerStyle(
          color: Colors.grey[300],
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        expandedIcon: Icon(Icons.expand_less),
        collapsedIcon: Icon(Icons.expand_more),
        disabledColor: Colors.grey[400],
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultMode`: 默认展开模式
- `defaultAnimationDuration`: 默认动画持续时间
- `defaultAnimationCurve`: 默认动画曲线
- `defaultHeaderStyle`: 默认头部样式
- `defaultContentStyle`: 默认内容样式
- `defaultDividerStyle`: 默认分割线样式
- `expandedIcon`: 展开图标
- `collapsedIcon`: 收起图标
- `disabledColor`: 禁用颜色

## 🏆 最佳实践

### 1. 选择合适的展开模式

```dart
// ✅ 好的做法：FAQ使用单展开模式
ZephyrAccordion(
  mode: ZephyrAccordionMode.single,
  items: _buildFAQItems(),
)

// ✅ 好的做法：设置页面使用多展开模式
ZephyrAccordion(
  mode: ZephyrAccordionMode.multiple,
  items: _buildSettingsItems(),
)

// ❌ 避免的做法：FAQ使用多展开模式
ZephyrAccordion(
  mode: ZephyrAccordionMode.multiple, // FAQ通常不需要同时展开多个
  items: _buildFAQItems(),
)
```

### 2. 合理的动画时长

```dart
// ✅ 好的做法：使用适中的动画时长
ZephyrAccordion(
  animationDuration: Duration(milliseconds: 300),
  items: _buildItems(),
)

// ✅ 好的做法：复杂内容使用稍长的动画
ZephyrAccordion(
  animationDuration: Duration(milliseconds: 500),
  items: _buildComplexItems(),
)

// ❌ 避免的做法：动画时长过长
ZephyrAccordion(
  animationDuration: Duration(seconds: 2), // 用户等待时间过长
  items: _buildItems(),
)
```

### 3. 清晰的视觉层次

```dart
// ✅ 好的做法：使用颜色和间距区分层次
ZephyrAccordion(
  headerStyle: ZephyrAccordionHeaderStyle(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    borderRadius: BorderRadius.circular(8),
  ),
  contentStyle: ZephyrAccordionContentStyle(
    backgroundColor: Colors.grey[50],
    padding: EdgeInsets.all(16),
  ),
  items: _buildItems(),
)

// ✅ 好的做法：使用图标增强可识别性
ZephyrAccordion(
  items: [
    ZephyrAccordionItem(
      title: '用户设置',
      leading: Icon(Icons.person),
      content: Text('用户相关设置'),
    ),
    ZephyrAccordionItem(
      title: '系统设置',
      leading: Icon(Icons.settings),
      content: Text('系统相关设置'),
    ),
  ],
)

// ❌ 避免的做法：缺乏视觉层次
ZephyrAccordion(
  items: [
    ZephyrAccordionItem(
      title: '用户设置',
      content: Text('用户相关设置'),
    ),
    ZephyrAccordionItem(
      title: '系统设置',
      content: Text('系统相关设置'),
    ),
  ],
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：为手风琴添加语义标签
ZephyrAccordion(
  semanticLabel: '常见问题解答',
  items: [
    ZephyrAccordionItem(
      title: '什么是Flutter？',
      semanticLabel: 'Flutter介绍',
      content: Text('Flutter的相关介绍'),
    ),
  ],
)

// ✅ 好的做法：为可交互项目添加描述
ZephyrAccordion(
  items: [
    ZephyrAccordionItem(
      title: '展开查看详情',
      onExpansionChanged: (isExpanded) {
        // 处理展开状态变化
      },
      content: Text('这里是详细内容'),
    ),
  ],
)

// ❌ 避免的做法：缺乏语义信息
ZephyrAccordion(
  items: [
    ZephyrAccordionItem(
      title: '点击展开',
      content: Text('内容'),
    ),
  ],
)
```

## 🔄 相关组件

- **ZephyrContainer**: 容器组件
- **ZephyrGrid**: 网格布局组件
- **ZephyrList**: 列表组件
- **ZephyrExpansionPanel**: 展开面板组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持单展开和多展开模式
- ✅ 流畅的展开/收起动画
- ✅ 丰富的自定义样式
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/layout/accordion/`
**示例路径**: `example/lib/components/accordion_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日