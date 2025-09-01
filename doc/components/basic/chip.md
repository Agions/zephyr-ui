# ZephyrChip 标签组件

标签组件是一个多功能的 UI 元素，用于展示分类、标签、选项等内容。支持多种变体和交互模式，包括标准、可选择、过滤、输入和操作标签。

## 🎯 组件概述

### 特性
- **多种变体**: 支持标准、可选择、过滤、输入、操作五种模式
- **丰富的交互**: 支持点击、选择、删除等交互行为
- **灵活的样式**: 支持头像、删除图标、自定义主题等
- **标签组**: 支持单选和多选的标签组
- **状态管理**: 完整的选中、禁用等状态支持
- **主题适配**: 完整的主题系统支持

### 适用场景
- 分类标签
- 筛选选项
- 技能标签
- 输入标签
- 操作按钮
- 状态指示

## 🚀 基础用法

### 标准标签

```dart
ZephyrChip(
  label: 'Flutter',
  onPressed: () => print('标签被点击'),
)
```

### 可选择标签

```dart
ZephyrChip.choice(
  label: '前端开发',
  selected: true,
  onSelected: (selected) => print('选择状态: $selected'),
)
```

### 过滤标签

```dart
ZephyrChip.filter(
  label: '已完成',
  selected: false,
  onSelected: (selected) => print('过滤: $selected'),
)
```

### 输入标签

```dart
ZephyrChip.input(
  label: '标签名',
  deleteIcon: Icon(Icons.close),
  onDeleted: () => print('标签被删除'),
)
```

### 操作标签

```dart
ZephyrChip.action(
  label: '添加',
  onPressed: () => print('添加操作'),
)
```

## 🎨 样式定制

### 基础样式

```dart
Row(
  children: [
    ZephyrChip(
      label: '默认',
      onPressed: () {},
    ),
    SizedBox(width: 8),
    ZephyrChip(
      label: '自定义',
      onPressed: () {},
      avatar: Icon(Icons.star),
    ),
    SizedBox(width: 8),
    ZephyrChip(
      label: '删除',
      onPressed: () {},
      deleteIcon: Icon(Icons.close),
      onDeleted: () => print('删除'),
    ),
  ],
)
```

### 可选择标签变体

```dart
Row(
  children: [
    ZephyrChip.choice(
      label: '未选中',
      selected: false,
      onSelected: (selected) {},
    ),
    SizedBox(width: 8),
    ZephyrChip.choice(
      label: '已选中',
      selected: true,
      onSelected: (selected) {},
    ),
    SizedBox(width: 8),
    ZephyrChip.choice(
      label: '禁用',
      selected: false,
      enabled: false,
      onSelected: (selected) {},
    ),
  ],
)
```

### 过滤标签变体

```dart
Row(
  children: [
    ZephyrChip.filter(
      label: '全部',
      selected: true,
      onSelected: (selected) {},
    ),
    SizedBox(width: 8),
    ZephyrChip.filter(
      label: '进行中',
      selected: false,
      onSelected: (selected) {},
    ),
    SizedBox(width: 8),
    ZephyrChip.filter(
      label: '已完成',
      selected: false,
      onSelected: (selected) {},
    ),
  ],
)
```

### 带头像的标签

```dart
Row(
  children: [
    ZephyrChip(
      label: '张三',
      avatar: ZephyrAvatar.text(
        text: '张',
        size: ZephyrAvatarSize.small,
      ),
      onPressed: () {},
    ),
    SizedBox(width: 8),
    ZephyrChip(
      label: '李四',
      avatar: ZephyrAvatar.icon(
        icon: Icons.person,
        size: ZephyrAvatarSize.small,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      onPressed: () {},
    ),
    SizedBox(width: 8),
    ZephyrChip(
      label: '王五',
      avatar: ZephyrAvatar.image(
        image: AssetImage('assets/images/user1.jpg'),
        size: ZephyrAvatarSize.small,
      ),
      onPressed: () {},
    ),
  ],
)
```

### 颜色变体

```dart
Row(
  children: [
    ZephyrChip(
      label: '默认',
      onPressed: () {},
    ),
    SizedBox(width: 8),
    ZephyrChip(
      label: '成功',
      onPressed: () {},
      theme: ZephyrChipTheme(
        backgroundColor: Colors.green[100],
        selectedBackgroundColor: Colors.green,
        textColor: Colors.green[800],
        selectedTextColor: Colors.white,
      ),
    ),
    SizedBox(width: 8),
    ZephyrChip(
      label: '警告',
      onPressed: () {},
      theme: ZephyrChipTheme(
        backgroundColor: Colors.orange[100],
        selectedBackgroundColor: Colors.orange,
        textColor: Colors.orange[800],
        selectedTextColor: Colors.white,
      ),
    ),
    SizedBox(width: 8),
    ZephyrChip(
      label: '错误',
      onPressed: () {},
      theme: ZephyrChipTheme(
        backgroundColor: Colors.red[100],
        selectedBackgroundColor: Colors.red,
        textColor: Colors.red[800],
        selectedTextColor: Colors.white,
      ),
    ),
  ],
)
```

## 🔧 高级用法

### 标签组

```dart
class ChipGroupDemo extends StatefulWidget {
  @override
  _ChipGroupDemoState createState() => _ChipGroupDemoState();
}

class _ChipGroupDemoState extends State<ChipGroupDemo> {
  List<int> selectedChips = [];
  bool multiSelect = false;

  final List<ZephyrChipData> chips = [
    ZephyrChipData(label: 'Flutter', avatar: Icon(Icons.code)),
    ZephyrChipData(label: 'Dart', avatar: Icon(Icons.language)),
    ZephyrChipData(label: 'React', avatar: Icon(Icons.web)),
    ZephyrChipData(label: 'Vue', avatar: Icon(Icons.widgets)),
    ZephyrChipData(label: 'Angular', avatar: Icon(Icons.polymer)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('多选模式'),
            Switch(
              value: multiSelect,
              onChanged: (value) {
                setState(() {
                  multiSelect = value;
                  if (!multiSelect && selectedChips.isNotEmpty) {
                    selectedChips = [selectedChips.last];
                  }
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        ZephyrChipGroup(
          chips: chips,
          selectedChips: selectedChips,
          multiSelect: multiSelect,
          onSelectionChanged: (selection) {
            setState(() {
              selectedChips = selection;
            });
            print('选中了: $selection');
          },
        ),
        SizedBox(height: 16),
        Text(
          '选中了: ${selectedChips.map((i) => chips[i].label).join(', ')}',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
```

### 技能标签

```dart
class SkillChips extends StatelessWidget {
  final List<String> skills;
  final VoidCallback? onSkillTap;

  const SkillChips({
    Key? key,
    required this.skills,
    this.onSkillTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills.map((skill) {
        return ZephyrChip(
          label: skill,
          avatar: Icon(Icons.code, size: 16),
          onPressed: () {
            onSkillTap?.call();
            print('点击技能: $skill');
          },
        );
      }).toList(),
    );
  }
}

// 使用示例
SkillChips(
  skills: ['Flutter', 'Dart', 'Firebase', 'REST API'],
  onSkillTap: () => _showSkillDetails(),
)
```

### 过滤器标签

```dart
class FilterChips extends StatefulWidget {
  final List<String> filters;
  final ValueChanged<List<String>> onFilterChanged;

  const FilterChips({
    Key? key,
    required this.filters,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  _FilterChipsState createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  List<bool> selectedFilters = [];

  @override
  void initState() {
    super.initState();
    selectedFilters = List.filled(widget.filters.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.filters.asMap().entries.map((entry) {
        final index = entry.key;
        final filter = entry.value;

        return ZephyrChip.filter(
          label: filter,
          selected: selectedFilters[index],
          onSelected: (selected) {
            setState(() {
              selectedFilters[index] = selected;
            });

            final selectedList = <String>[];
            for (int i = 0; i < selectedFilters.length; i++) {
              if (selectedFilters[i]) {
                selectedList.add(widget.filters[i]);
              }
            }
            widget.onFilterChanged(selectedList);
          },
        );
      }).toList(),
    );
  }
}

// 使用示例
FilterChips(
  filters: ['进行中', '已完成', '已取消', '已延期'],
  onFilterChanged: (selected) {
    print('应用过滤器: $selected');
    _applyFilters(selected);
  },
)
```

### 输入标签

```dart
class InputChips extends StatefulWidget {
  final List<String> initialTags;
  final ValueChanged<List<String>> onTagsChanged;

  const InputChips({
    Key? key,
    required this.initialTags,
    required this.onTagsChanged,
  }) : super(key: key);

  @override
  _InputChipsState createState() => _InputChipsState();
}

class _InputChipsState extends State<InputChips> {
  late List<String> tags;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    tags = List.from(widget.initialTags);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTag() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        tags.add(_controller.text.trim());
        _controller.clear();
      });
      widget.onTagsChanged(tags);
    }
  }

  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
    widget.onTagsChanged(tags);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            return ZephyrChip.input(
              label: tag,
              deleteIcon: Icon(Icons.close, size: 16),
              onDeleted: () => _removeTag(tag),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: '添加标签',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addTag(),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: _addTag,
              child: Text('添加'),
            ),
          ],
        ),
      ],
    );
  }
}

// 使用示例
InputChips(
  initialTags: ['Flutter', 'Dart'],
  onTagsChanged: (tags) {
    print('标签更新: $tags');
  },
)
```

### 状态标签

```dart
class StatusChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;

  const StatusChip({
    Key? key,
    required this.label,
    this.isActive = true,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrChip(
      label: label,
      avatar: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: isActive
              ? (activeColor ?? Colors.green)
              : (inactiveColor ?? Colors.grey),
          shape: BoxShape.circle,
        ),
      ),
      theme: ZephyrChipTheme(
        backgroundColor: isActive
            ? (activeColor?.withOpacity(0.1) ?? Colors.green[100])
            : (inactiveColor?.withOpacity(0.1) ?? Colors.grey[100]),
        textColor: isActive
            ? (activeColor ?? Colors.green)
            : (inactiveColor ?? Colors.grey),
      ),
    );
  }
}

// 使用示例
Row(
  children: [
    StatusChip(label: '在线', isActive: true),
    SizedBox(width: 8),
    StatusChip(label: '离线', isActive: false),
    SizedBox(width: 8),
    StatusChip(label: '忙碌', isActive: true, activeColor: Colors.orange),
    SizedBox(width: 8),
    StatusChip(label: '离开', isActive: false, inactiveColor: Colors.red),
  ],
)
```

### 动态标签

```dart
class DynamicChips extends StatefulWidget {
  final Stream<List<String>> dataStream;
  final ValueChanged<String> onChipTap;

  const DynamicChips({
    Key? key,
    required this.dataStream,
    required this.onChipTap,
  }) : super(key: key);

  @override
  _DynamicChipsState createState() => _DynamicChipsState();
}

class _DynamicChipsState extends State<DynamicChips> {
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    widget.dataStream.listen((items) {
      setState(() {
        _items = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: widget.dataStream,
      builder: (context, snapshot) {
        final items = snapshot.data ?? _items;

        if (items.isEmpty) {
          return Center(
            child: Text('暂无数据'),
          );
        }

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            return ZephyrChip(
              label: item,
              onPressed: () => widget.onChipTap(item),
            );
          }).toList(),
        );
      },
    );
  }
}

// 使用示例
DynamicChips(
  dataStream: _tagStream,
  onChipTap: (tag) {
    print('点击标签: $tag');
  },
)
```

## 🎛️ API 参考

### 构造函数

#### ZephyrChip()

```dart
const ZephyrChip({
  Key? key,
  required String label,
  Widget? avatar,
  Widget? deleteIcon,
  VoidCallback? onPressed,
  VoidCallback? onDeleted,
  bool selected = false,
  bool enabled = true,
  ZephyrChipVariant variant = ZephyrChipVariant.standard,
  ZephyrChipTheme? theme,
})
```

**参数说明：**
- `label`: 标签文本（必填）
- `avatar`: 头像组件
- `deleteIcon`: 删除图标
- `onPressed`: 点击回调
- `onDeleted`: 删除回调
- `selected`: 是否选中
- `enabled`: 是否启用
- `variant`: 标签变体
- `theme`: 自定义主题

#### 命名构造函数

##### ZephyrChip.choice()

```dart
const ZephyrChip.choice({
  Key? key,
  required String label,
  Widget? avatar,
  bool selected = false,
  bool enabled = true,
  ValueChanged<bool>? onSelected,
  ZephyrChipTheme? theme,
})
```

##### ZephyrChip.filter()

```dart
const ZephyrChip.filter({
  Key? key,
  required String label,
  Widget? avatar,
  bool selected = false,
  bool enabled = true,
  ValueChanged<bool>? onSelected,
  ZephyrChipTheme? theme,
})
```

##### ZephyrChip.input()

```dart
const ZephyrChip.input({
  Key? key,
  required String label,
  Widget? avatar,
  Widget? deleteIcon,
  bool enabled = true,
  VoidCallback? onDeleted,
  ZephyrChipTheme? theme,
})
```

##### ZephyrChip.action()

```dart
const ZephyrChip.action({
  Key? key,
  required String label,
  Widget? avatar,
  bool enabled = true,
  VoidCallback? onPressed,
  ZephyrChipTheme? theme,
})
```

### ZephyrChipGroup

```dart
const ZephyrChipGroup({
  Key? key,
  required List<ZephyrChipData> chips,
  List<int> selectedChips = const [],
  bool multiSelect = false,
  ValueChanged<List<int>>? onSelectionChanged,
  double spacing = 8.0,
  double runSpacing = 8.0,
  ZephyrChipTheme? theme,
})
```

**参数说明：**
- `chips`: 标签数据列表
- `selectedChips`: 选中的标签索引
- `multiSelect`: 是否支持多选
- `onSelectionChanged`: 选择变更回调
- `spacing`: 水平间距
- `runSpacing`: 垂直间距
- `theme`: 自定义主题

### ZephyrChipData

```dart
const ZephyrChipData({
  required String label,
  Widget? avatar,
  bool enabled = true,
})
```

**参数说明：**
- `label`: 标签文本
- `avatar`: 头像组件
- `enabled`: 是否启用

### 枚举类型

#### ZephyrChipVariant

```dart
enum ZephyrChipVariant {
  standard,  // 标准标签
  choice,    // 可选择标签
  filter,    // 过滤标签
  input,     // 输入标签
  action,    // 操作标签
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrChipTheme(
        backgroundColor: Colors.grey[200],
        selectedBackgroundColor: Colors.blue,
        textColor: Colors.black,
        selectedTextColor: Colors.white,
        borderColor: Colors.grey[300],
        selectedBorderColor: Colors.blue,
        disabledBackgroundColor: Colors.grey[100],
        disabledTextColor: Colors.grey[400],
        disabledBorderColor: Colors.grey[200],
        deleteIconColor: Colors.grey[600],
        height: 32.0,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        borderRadius: BorderRadius.circular(16),
        borderWidth: 1.0,
        textStyle: TextStyle(fontSize: 14),
        iconSize: 18.0,
        spacing: 4.0,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `backgroundColor`: 默认背景颜色
- `selectedBackgroundColor`: 选中背景颜色
- `textColor`: 默认文本颜色
- `selectedTextColor`: 选中文本颜色
- `borderColor`: 默认边框颜色
- `selectedBorderColor`: 选中边框颜色
- `disabledBackgroundColor`: 禁用背景颜色
- `disabledTextColor`: 禁用文本颜色
- `disabledBorderColor`: 禁用边框颜色
- `deleteIconColor`: 删除图标颜色
- `height`: 标签高度
- `padding`: 内边距
- `borderRadius`: 边框圆角
- `borderWidth`: 边框宽度
- `textStyle`: 文本样式
- `iconSize`: 图标大小
- `spacing`: 间距

## 🏆 最佳实践

### 1. 选择合适的标签变体

```dart
// ✅ 好的做法：根据用途选择合适的变体
// 分类标签使用标准标签
ZephyrChip(
  label: '技术',
  onPressed: () => _showCategory('技术'),
)

// 选择选项使用可选择标签
ZephyrChip.choice(
  label: '前端开发',
  selected: isSelected,
  onSelected: (selected) => _updateSelection(selected),
)

// 过滤器使用过滤标签
ZephyrChip.filter(
  label: '已完成',
  selected: isFiltered,
  onSelected: (selected) => _applyFilter(selected),
)

// ❌ 避免的做法：在不合适的场景使用错误的变体
ZephyrChip.input(
  label: '分类',  // 应该使用标准标签
  onPressed: () => _showCategory(),
)
```

### 2. 标签文本长度

```dart
// ✅ 好的做法：保持标签文本简洁
ZephyrChip(
  label: 'Flutter',
  onPressed: () {},
)

// ✅ 对于较长的文本，考虑省略或换行
ZephyrChip(
  label: '非常长的标签文本',
  onPressed: () {},
)

// ❌ 避免的做法：标签文本过长
ZephyrChip(
  label: '这是一个非常非常长的标签文本，可能会影响布局',  // 过长
  onPressed: () {},
)
```

### 3. 合理的颜色使用

```dart
// ✅ 好的做法：基于语义选择颜色
ZephyrChip(
  label: '成功',
  theme: ZephyrChipTheme(
    backgroundColor: Colors.green[100],
    selectedBackgroundColor: Colors.green,
    textColor: Colors.green[800],
    selectedTextColor: Colors.white,
  ),
)

// ✅ 确保对比度足够
ZephyrChip(
  label: '重要',
  theme: ZephyrChipTheme(
    backgroundColor: Colors.blue[100],
    selectedBackgroundColor: Colors.blue,
    textColor: Colors.blue[900],
    selectedTextColor: Colors.white,
  ),
)

// ❌ 避免的做法：对比度不足
ZephyrChip(
  label: '标签',
  theme: ZephyrChipTheme(
    backgroundColor: Colors.grey[200],
    textColor: Colors.grey[300],  // 对比度不够
  ),
)
```

### 4. 性能优化

```dart
// ✅ 好的做法：在列表中使用标签组
ListView.builder(
  itemCount: categories.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('项目 $index'),
      trailing: ZephyrChip(
        label: categories[index],
        onPressed: () => _filterByCategory(categories[index]),
      ),
    );
  },
)

// ✅ 使用 const 构造函数
const chipTheme = ZephyrChipTheme(
  backgroundColor: Colors.blue[100],
  selectedBackgroundColor: Colors.blue,
);

ZephyrChip(
  label: '标签',
  theme: chipTheme,
)

// ❌ 避免的做法：在大量标签中使用复杂的头像
ListView.builder(
  itemCount: 100,
  itemBuilder: (context, index) {
    return ZephyrChip(
      label: '标签 $index',
      avatar: ZephyrAvatar.text(  // 影响性能
        text: '$index',
        size: ZephyrAvatarSize.small,
      ),
    );
  },
)
```

### 5. 无障碍设计

```dart
// ✅ 好的做法：添加语义信息
Semantics(
  label: '选择标签：前端开发',
  button: true,
  child: ZephyrChip.choice(
    label: '前端开发',
    selected: isSelected,
    onSelected: (selected) => _updateSelection(selected),
  ),
)

// ✅ 为标签组添加描述
Semantics(
  label: '技能标签选择器，当前选择了Flutter和Dart',
  child: ZephyrChipGroup(
    chips: skillChips,
    selectedChips: selectedSkills,
    onSelectionChanged: _updateSkills,
  ),
)

// ❌ 避免的做法：忽略无障碍功能
ZephyrChip(
  label: '操作',  // 缺少语义信息
  onPressed: () => _handleAction(),
)
```

## 🔄 相关组件

- **ZephyrAvatar**: 常作为标签的头像
- **ZephyrBadge**: 可在标签上添加徽章
- **ZephyrList**: 用于创建标签列表
- **ZephyrButton**: 类似标签的按钮功能
- **ZephyrText**: 标签中的文本内容

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持 5 种标签变体
- ✅ 标签组支持
- ✅ 完整的样式定制
- ✅ 主题系统支持
- ✅ 完整的示例应用
- ✅ 中文本地化支持

---

**组件路径**: `lib/src/components/basic/chip/`
**示例路径**: `example/lib/components/chip_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日
