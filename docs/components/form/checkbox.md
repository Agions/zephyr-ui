# ZephyrCheckbox 复选框组件

复选框组件是一个基础的选择控件，支持单选和多选模式。提供了简洁的勾选体验，支持标签、禁用状态、自定义样式等功能。

## 🎯 组件概述

### 特性
- **单选和多选**: 支持独立复选框和复选框组
- **灵活的布局**: 支持水平和垂直布局
- **自定义样式**: 支持自定义颜色、大小等样式
- **状态管理**: 完整的选中、禁用、只读状态支持
- **主题适配**: 完整的主题系统支持

### 适用场景
- 表单多选项
- 设置开关
- 权限选择
- 协议同意
- 批量操作
- 筛选条件

## 🚀 基础用法

### 基本复选框

```dart
ZephyrCheckbox(
  label: '我同意用户协议',
  value: _agreed,
  onChanged: (value) => setState(() => _agreed = value),
)
```

### 禁用状态的复选框

```dart
ZephyrCheckbox(
  label: '禁用状态',
  value: true,
  enabled: false,
)
```

### 带描述的复选框

```dart
ZephyrCheckbox(
  label: '接收推送通知',
  description: '我们将向您推送重要通知和更新信息',
  value: _notificationsEnabled,
  onChanged: (value) => setState(() => _notificationsEnabled = value),
)
```

### 复选框组

```dart
ZephyrCheckboxGroup<String>(
  label: '兴趣爱好',
  options: [
    ZephyrCheckboxOption(value: 'reading', label: '阅读'),
    ZephyrCheckboxOption(value: 'sports', label: '运动'),
    ZephyrCheckboxOption(value: 'music', label: '音乐'),
    ZephyrCheckboxOption(value: 'travel', label: '旅行'),
  ],
  selectedValues: _selectedHobbies,
  onChanged: (values) => setState(() => _selectedHobbies = values),
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    ZephyrCheckbox(
      label: '默认样式',
      value: _value1,
      onChanged: (value) => setState(() => _value1 = value),
    ),
    SizedBox(height: 16),
    ZephyrCheckbox(
      label: '自定义颜色',
      value: _value2,
      activeColor: Colors.blue,
      onChanged: (value) => setState(() => _value2 = value),
    ),
    SizedBox(height: 16),
    ZephyrCheckbox(
      label: '大尺寸',
      value: _value3,
      size: 24,
      onChanged: (value) => setState(() => _value3 = value),
    ),
  ],
)
```

### 布局方向

```dart
Column(
  children: [
    Text('水平布局'),
    SizedBox(height: 8),
    ZephyrCheckboxGroup<String>(
      options: [
        ZephyrCheckboxOption(value: 'option1', label: '选项1'),
        ZephyrCheckboxOption(value: 'option2', label: '选项2'),
        ZephyrCheckboxOption(value: 'option3', label: '选项3'),
      ],
      direction: Axis.horizontal,
      spacing: 16,
      onChanged: (values) => print('选择: $values'),
    ),
    SizedBox(height: 24),
    Text('垂直布局'),
    SizedBox(height: 8),
    ZephyrCheckboxGroup<String>(
      options: [
        ZephyrCheckboxOption(value: 'option1', label: '选项1'),
        ZephyrCheckboxOption(value: 'option2', label: '选项2'),
        ZephyrCheckboxOption(value: 'option3', label: '选项3'),
      ],
      direction: Axis.vertical,
      spacing: 8,
      onChanged: (values) => print('选择: $values'),
    ),
  ],
)
```

## 🔧 高级用法

### 带验证的复选框

```dart
class ValidatedCheckbox extends StatefulWidget {
  @override
  _ValidatedCheckboxState createState() => _ValidatedCheckboxState();
}

class _ValidatedCheckboxState extends State<ValidatedCheckbox> {
  bool _agreed = false;
  String? _errorText;

  void _validateAgreement(bool value) {
    setState(() {
      _agreed = value;
      _errorText = value ? null : '请同意用户协议';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrCheckbox(
          label: '我同意用户协议和隐私政策',
          description: '请仔细阅读协议内容，勾选表示同意',
          value: _agreed,
          onChanged: _validateAgreement,
          errorText: _errorText,
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _agreed ? _submitForm : null,
          child: Text('提交'),
        ),
      ],
    );
  }
}
```

### 全选功能

```dart
class SelectAllCheckbox extends StatefulWidget {
  @override
  _SelectAllCheckboxState createState() => _SelectAllCheckboxState();
}

class _SelectAllCheckboxState extends State<SelectAllCheckbox> {
  List<String> _options = ['选项1', '选项2', '选项3', '选项4'];
  List<String> _selectedOptions = [];

  bool get _isAllSelected => _selectedOptions.length == _options.length;
  bool get _isIndeterminate => _selectedOptions.isNotEmpty && !_isAllSelected;

  void _toggleAll(bool? value) {
    setState(() {
      if (value == true) {
        _selectedOptions = List.from(_options);
      } else {
        _selectedOptions = [];
      }
    });
  }

  void _toggleOption(String option, bool? value) {
    setState(() {
      if (value == true) {
        if (!_selectedOptions.contains(option)) {
          _selectedOptions.add(option);
        }
      } else {
        _selectedOptions.remove(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrCheckbox(
          label: '全选',
          value: _isAllSelected,
          tristate: true,
          onChanged: _toggleAll,
        ),
        SizedBox(height: 8),
        ..._options.map((option) {
          return Padding(
            padding: EdgeInsets.only(left: 24, top: 8),
            child: ZephyrCheckbox(
              label: option,
              value: _selectedOptions.contains(option),
              onChanged: (value) => _toggleOption(option, value),
            ),
          );
        }).toList(),
        SizedBox(height: 16),
        Text(
          '已选择 ${_selectedOptions.length} / ${_options.length} 项',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
```

### 动态选项组

```dart
class DynamicCheckboxGroup extends StatefulWidget {
  @override
  _DynamicCheckboxGroupState createState() => _DynamicCheckboxGroupState();
}

class _DynamicCheckboxGroupState extends State<DynamicCheckboxGroup> {
  List<Category> _categories = [];
  Map<String, List<String>> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    // 模拟加载分类数据
    _categories = [
      Category(name: '前端技术', items: ['React', 'Vue', 'Angular']),
      Category(name: '后端技术', items: ['Java', 'Python', 'Go']),
      Category(name: '移动开发', items: ['Flutter', 'React Native', 'Swift']),
    ];
  }

  void _toggleItem(String category, String item, bool? selected) {
    setState(() {
      if (!_selectedItems.containsKey(category)) {
        _selectedItems[category] = [];
      }
      
      if (selected == true) {
        if (!_selectedItems[category]!.contains(item)) {
          _selectedItems[category]!.add(item);
        }
      } else {
        _selectedItems[category]!.remove(item);
      }
    });
  }

  bool _isCategorySelected(String category) {
    return _selectedItems[category]?.isNotEmpty ?? false;
  }

  bool _isCategoryFullySelected(String category) {
    final categoryData = _categories.firstWhere((c) => c.name == category);
    return _selectedItems[category]?.length == categoryData.items.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _categories.map((category) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrCheckbox(
              label: category.name,
              value: _isCategoryFullySelected(category.name),
              tristate: true,
              onChanged: (value) {
                final categoryItems = category.items;
                for (final item in categoryItems) {
                  _toggleItem(category.name, item, value);
                }
              },
            ),
            SizedBox(height: 8),
            ...category.items.map((item) {
              return Padding(
                padding: EdgeInsets.only(left: 24, top: 4),
                child: ZephyrCheckbox(
                  label: item,
                  value: _selectedItems[category.name]?.contains(item) ?? false,
                  onChanged: (value) => _toggleItem(category.name, item, value),
                ),
              );
            }).toList(),
            SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }
}

class Category {
  final String name;
  final List<String> items;

  Category({required this.name, required this.items});
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrCheckbox()

```dart
const ZephyrCheckbox({
  Key? key,
  required String label,
  String? description,
  bool value = false,
  bool tristate = false,
  bool enabled = true,
  bool readOnly = false,
  Color? activeColor,
  Color? checkColor,
  double? size,
  ValueChanged<bool?>? onChanged,
  String? errorText,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? labelStyle,
  TextStyle? descriptionStyle,
  TextStyle? errorTextStyle,
  String? semanticLabel,
})
```

**参数说明：**
- `label`: 复选框标签
- `description`: 描述文本
- `value`: 是否选中
- `tristate`: 是否支持三态（全选、部分选、未选）
- `enabled`: 是否启用
- `readOnly`: 是否只读
- `activeColor**: 选中时的颜色
- `checkColor`: 勾选标记的颜色
- `size`: 复选框大小
- `onChanged`: 变化回调
- `errorText`: 错误文本
- `contentPadding`: 内容内边距
- `labelStyle`: 标签样式
- `descriptionStyle`: 描述文本样式
- `errorTextStyle`: 错误文本样式
- `semanticLabel`: 语义标签

#### ZephyrCheckboxGroup()

```dart
const ZephyrCheckboxGroup<T>({
  Key? key,
  String? label,
  required List<ZephyrCheckboxOption<T>> options,
  List<T> selectedValues = const [],
  ValueChanged<List<T>>? onChanged,
  Axis direction = Axis.vertical,
  double spacing = 8,
  bool enabled = true,
  bool readOnly = false,
  Color? activeColor,
  Color? checkColor,
  double? size,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? labelStyle,
  String? semanticLabel,
})
```

### ZephyrCheckboxOption

```dart
const ZephyrCheckboxOption<T>({
  required T value,
  required String label,
  String? description,
  bool enabled = true,
})
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrCheckboxTheme(
        activeColor: Colors.blue,
        checkColor: Colors.white,
        disabledColor: Colors.grey[300],
        disabledActiveColor: Colors.grey[400],
        size: 18,
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        descriptionStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
        errorTextStyle: TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `activeColor`: 选中时的颜色
- `checkColor`: 勾选标记的颜色
- `disabledColor`: 禁用时的颜色
- `disabledActiveColor`: 禁用且选中时的颜色
- `size`: 复选框大小
- `labelStyle`: 标签样式
- `descriptionStyle`: 描述文本样式
- `errorTextStyle`: 错误文本样式
- `contentPadding`: 内容内边距

## 🏆 最佳实践

### 1. 清晰的标签设计

```dart
// ✅ 好的做法：标签简洁明了
ZephyrCheckbox(
  label: '接收邮件通知',
  value: _emailEnabled,
  onChanged: (value) => setState(() => _emailEnabled = value),
)

// ✅ 好的做法：为复杂选项添加描述
ZephyrCheckbox(
  label: '接收营销邮件',
  description: '包括产品更新、促销活动等营销信息',
  value: _marketingEnabled,
  onChanged: (value) => setState(() => _marketingEnabled = value),
)

// ❌ 避免的做法：标签过于复杂
ZephyrCheckbox(
  label: '接收邮件通知包括营销邮件产品更新促销活动等重要信息',  // 过长
  value: _enabled,
  onChanged: (value) => setState(() => _enabled = value),
)
```

### 2. 合理的默认状态

```dart
// ✅ 好的做法：根据业务需求设置默认状态
ZephyrCheckbox(
  label: '我已阅读并同意用户协议',
  value: false,  // 默认未选中，需要用户主动同意
  onChanged: (value) => _updateAgreement(value),
)

ZephyrCheckbox(
  label: '启用通知',
  value: true,  // 默认启用，用户可以选择关闭
  onChanged: (value) => _updateNotifications(value),
)
```

### 3. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrCheckbox(
  label: '我同意用户协议',
  semanticLabel: '用户协议同意复选框',
  value: _agreed,
  onChanged: (value) => setState(() => _agreed = value),
)

// ✅ 好的做法：为重要选项提供额外说明
ZephyrCheckbox(
  label: '分享使用数据',
  description: '帮助我们改进产品体验，数据将匿名处理',
  value: _analyticsEnabled,
  onChanged: (value) => setState(() => _analyticsEnabled = value),
)
```

## 🔄 相关组件

- **ZephyrRadio**: 单选框
- **ZephyrSwitch**: 开关组件
- **ZephyrSelect**: 选择器组件
- **ZephyrFormBuilder**: 表单构建器

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本复选框功能
- ✅ 支持复选框组
- ✅ 三态支持
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/form/checkbox/`
**示例路径**: `example/lib/components/checkbox_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月19日