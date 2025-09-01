# ZephyrSelect 选择器组件

选择器组件是一个功能强大的下拉选择控件，支持单选、多选、搜索、分组等多种模式。提供了丰富的选择体验，包括基本选择、带搜索的选择、分组选择等功能。

## 🎯 组件概述

### 特性
- **多种选择模式**: 支持单选、多选两种基本模式
- **搜索功能**: 内置搜索过滤功能
- **分组支持**: 支持选项分组显示
- **自定义渲染**: 支持自定义选项渲染
- **状态管理**: 完整的禁用、只读状态支持
- **主题适配**: 完整的主题系统支持

### 适用场景
- 表单选择输入
- 筛选器组件
- 设置选项选择
- 分类选择
- 标签选择
- 用户角色选择

## 🚀 基础用法

### 基本单选

```dart
ZephyrSelect<String>(
  label: '性别',
  placeholder: '请选择性别',
  options: [
    ZephyrSelectOption(value: 'male', label: '男'),
    ZephyrSelectOption(value: 'female', label: '女'),
    ZephyrSelectOption(value: 'other', label: '其他'),
  ],
  onChanged: (value) => print('选择: $value'),
)
```

### 基本多选

```dart
ZephyrSelect<String>(
  label: '兴趣爱好',
  placeholder: '请选择兴趣爱好',
  options: [
    ZephyrSelectOption(value: 'reading', label: '阅读'),
    ZephyrSelectOption(value: 'sports', label: '运动'),
    ZephyrSelectOption(value: 'music', label: '音乐'),
    ZephyrSelectOption(value: 'travel', label: '旅行'),
  ],
  multiple: true,
  onChanged: (values) => print('选择: $values'),
)
```

### 带搜索的选择器

```dart
ZephyrSelect<String>(
  label: '城市',
  placeholder: '请选择城市',
  options: [
    ZephyrSelectOption(value: 'beijing', label: '北京'),
    ZephyrSelectOption(value: 'shanghai', label: '上海'),
    ZephyrSelectOption(value: 'guangzhou', label: '广州'),
    ZephyrSelectOption(value: 'shenzhen', label: '深圳'),
  ],
  searchable: true,
  searchHint: '搜索城市...',
  onChanged: (value) => print('选择: $value'),
)
```

### 分组选择器

```dart
ZephyrSelect<String>(
  label: '编程语言',
  placeholder: '请选择编程语言',
  options: [
    ZephyrSelectOptionGroup(
      label: '前端语言',
      options: [
        ZephyrSelectOption(value: 'javascript', label: 'JavaScript'),
        ZephyrSelectOption(value: 'typescript', label: 'TypeScript'),
        ZephyrSelectOption(value: 'html', label: 'HTML'),
      ],
    ),
    ZephyrSelectOptionGroup(
      label: '后端语言',
      options: [
        ZephyrSelectOption(value: 'java', label: 'Java'),
        ZephyrSelectOption(value: 'python', label: 'Python'),
        ZephyrSelectOption(value: 'go', label: 'Go'),
      ],
    ),
  ],
  onChanged: (value) => print('选择: $value'),
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    ZephyrSelect<String>(
      label: '默认样式',
      placeholder: '请选择',
      options: _getOptions(),
    ),
    SizedBox(height: 16),
    ZephyrSelect<String>(
      label: '自定义边框',
      placeholder: '自定义边框颜色',
      options: _getOptions(),
      borderColor: Colors.blue,
      focusedBorderColor: Colors.blue,
    ),
    SizedBox(height: 16),
    ZephyrSelect<String>(
      label: '圆角边框',
      placeholder: '圆角选择器',
      options: _getOptions(),
      borderRadius: BorderRadius.circular(12),
    ),
    SizedBox(height: 16),
    ZephyrSelect<String>(
      label: '填充背景',
      placeholder: '填充背景色',
      options: _getOptions(),
      filled: true,
      fillColor: Colors.grey[100],
    ),
  ],
)
```

### 禁用和只读状态

```dart
Column(
  children: [
    ZephyrSelect<String>(
      label: '禁用选择器',
      placeholder: '禁用的选择器',
      options: _getOptions(),
      enabled: false,
    ),
    SizedBox(height: 16),
    ZephyrSelect<String>(
      label: '只读选择器',
      placeholder: '只读的选择器',
      options: _getOptions(),
      value: 'option1',
      readOnly: true,
    ),
  ],
)
```

### 带图标的选项

```dart
ZephyrSelect<String>(
  label: '通知方式',
  placeholder: '请选择通知方式',
  options: [
    ZephyrSelectOption(
      value: 'email',
      label: '邮件通知',
      icon: Icon(Icons.email),
    ),
    ZephyrSelectOption(
      value: 'sms',
      label: '短信通知',
      icon: Icon(Icons.sms),
    ),
    ZephyrSelectOption(
      value: 'push',
      label: '推送通知',
      icon: Icon(Icons.notifications),
    ),
  ],
  onChanged: (value) => print('选择: $value'),
)
```

## 🔧 高级用法

### 动态选项加载

```dart
class DynamicSelect extends StatefulWidget {
  final Future<List<ZephyrSelectOption<String>>> Function(String query) optionsLoader;
  final ValueChanged<String?> onChanged;

  const DynamicSelect({
    Key? key,
    required this.optionsLoader,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DynamicSelectState createState() => _DynamicSelectState();
}

class _DynamicSelectState extends State<DynamicSelect> {
  List<ZephyrSelectOption<String>> _options = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadOptions('');
  }

  Future<void> _loadOptions(String query) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final options = await widget.optionsLoader(query);
      setState(() {
        _options = options;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrSelect<String>(
      label: '动态选择',
      placeholder: '请选择',
      options: _options,
      searchable: true,
      onSearch: (query) => _loadOptions(query),
      isLoading: _isLoading,
      error: _error,
      onChanged: widget.onChanged,
    );
  }
}
```

### 自定义选项渲染

```dart
ZephyrSelect<User>(
  label: '选择用户',
  placeholder: '请选择用户',
  options: [
    ZephyrSelectOption(
      value: User(name: '张三', avatar: 'assets/avatar1.jpg', role: '管理员'),
      builder: (option, isSelected) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(option.value.avatar),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.value.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      option.value.role,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check, color: Colors.blue),
            ],
          ),
        );
      },
    ),
    // 更多选项...
  ],
  onChanged: (user) => print('选择用户: ${user?.name}'),
)
```

### 级联选择器

```dart
class CascadeSelect extends StatefulWidget {
  @override
  _CascadeSelectState createState() => _CascadeSelectState();
}

class _CascadeSelectState extends State<CascadeSelect> {
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedDistrict;

  final Map<String, List<String>> _cities = {
    'beijing': ['朝阳区', '海淀区', '西城区'],
    'shanghai': ['黄浦区', '徐汇区', '长宁区'],
    'guangzhou': ['天河区', '越秀区', '海珠区'],
  };

  final Map<String, List<String>> _districts = {
    '朝阳区': ['三里屯', '国贸', '望京'],
    '海淀区': ['中关村', '五道口', '学院路'],
    '西城区': ['西单', '金融街', '德胜门'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZephyrSelect<String>(
          label: '省份',
          placeholder: '请选择省份',
          options: [
            ZephyrSelectOption(value: 'beijing', label: '北京'),
            ZephyrSelectOption(value: 'shanghai', label: '上海'),
            ZephyrSelectOption(value: 'guangzhou', label: '广州'),
          ],
          value: _selectedProvince,
          onChanged: (value) {
            setState(() {
              _selectedProvince = value;
              _selectedCity = null;
              _selectedDistrict = null;
            });
          },
        ),
        SizedBox(height: 16),
        if (_selectedProvince != null)
          ZephyrSelect<String>(
            label: '城市',
            placeholder: '请选择城市',
            options: _cities[_selectedProvince!]!
                .map((city) => ZephyrSelectOption(value: city, label: city))
                .toList(),
            value: _selectedCity,
            onChanged: (value) {
              setState(() {
                _selectedCity = value;
                _selectedDistrict = null;
              });
            },
          ),
        SizedBox(height: 16),
        if (_selectedCity != null && _districts.containsKey(_selectedCity!))
          ZephyrSelect<String>(
            label: '区县',
            placeholder: '请选择区县',
            options: _districts[_selectedCity!]!
                .map((district) => ZephyrSelectOption(value: district, label: district))
                .toList(),
            value: _selectedDistrict,
            onChanged: (value) {
              setState(() {
                _selectedDistrict = value;
              });
            },
          ),
      ],
    );
  }
}
```

### 带标签的多选选择器

```dart
class TagSelect extends StatefulWidget {
  final ValueChanged<List<String>> onChanged;

  const TagSelect({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TagSelectState createState() => _TagSelectState();
}

class _TagSelectState extends State<TagSelect> {
  List<String> _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrSelect<String>(
          label: '技能标签',
          placeholder: '请选择技能标签',
          options: [
            ZephyrSelectOption(value: 'flutter', label: 'Flutter'),
            ZephyrSelectOption(value: 'dart', label: 'Dart'),
            ZephyrSelectOption(value: 'react', label: 'React'),
            ZephyrSelectOption(value: 'vue', label: 'Vue'),
            ZephyrSelectOption(value: 'angular', label: 'Angular'),
          ],
          multiple: true,
          value: _selectedTags,
          onChanged: (values) {
            setState(() {
              _selectedTags = values ?? [];
            });
            widget.onChanged(_selectedTags);
          },
        ),
        if (_selectedTags.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedTags.map((tag) {
                return InputChip(
                  label: Text(tag),
                  onDeleted: () {
                    setState(() {
                      _selectedTags.remove(tag);
                    });
                    widget.onChanged(_selectedTags);
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrSelect()

```dart
const ZephyrSelect<T>({
  Key? key,
  String? label,
  String? placeholder,
  String? helperText,
  String? errorText,
  List<ZephyrSelectOption<T>> options = const [],
  T? value,
  List<T>? values,
  bool multiple = false,
  bool searchable = false,
  String? searchHint,
  bool enabled = true,
  bool readOnly = false,
  bool clearable = false,
  bool loading = false,
  String? loadingText,
  String? error,
  String? noResultsText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  ValueChanged<T?>? onChanged,
  ValueChanged<List<T>?>? onMultipleChanged,
  ValueChanged<String>? onSearch,
  FormFieldValidator<T?>? validator,
  EdgeInsetsGeometry? contentPadding,
  BorderRadius? borderRadius,
  Color? borderColor,
  Color? focusedBorderColor,
  Color? errorBorderColor,
  Color? disabledBorderColor,
  double? borderWidth,
  double? maxHeight,
  double? itemHeight,
  TextStyle? textStyle,
  TextStyle? labelStyle,
  TextStyle? placeholderStyle,
  TextStyle? helperTextStyle,
  TextStyle? errorTextStyle,
  String? semanticLabel,
})
```

**参数说明：**
- `label`: 选择器标签
- `placeholder`: 占位符文本
- `helperText`: 帮助文本
- `errorText`: 错误文本
- `options`: 选项列表
- `value`: 单选值
- `values`: 多选值列表
- `multiple`: 是否多选
- `searchable`: 是否可搜索
- `searchHint`: 搜索提示文本
- `enabled`: 是否启用
- `readOnly`: 是否只读
- `clearable`: 是否可清除
- `loading`: 是否加载中
- `loadingText`: 加载提示文本
- `error`: 错误信息
- `noResultsText`: 无结果提示文本
- `prefixIcon`: 前缀图标
- `suffixIcon`: 后缀图标
- `onChanged`: 单选变化回调
- `onMultipleChanged`: 多选变化回调
- `onSearch`: 搜索回调
- `validator`: 验证器
- `contentPadding`: 内容内边距
- `borderRadius`: 边框圆角
- `borderColor`: 边框颜色
- `focusedBorderColor`: 聚焦时边框颜色
- `errorBorderColor`: 错误时边框颜色
- `disabledBorderColor`: 禁用时边框颜色
- `borderWidth`: 边框宽度
- `maxHeight`: 下拉框最大高度
- `itemHeight`: 选项项高度
- `textStyle`: 文本样式
- `labelStyle`: 标签样式
- `placeholderStyle`: 占位符样式
- `helperTextStyle`: 帮助文本样式
- `errorTextStyle`: 错误文本样式
- `semanticLabel`: 语义标签

### ZephyrSelectOption

```dart
const ZephyrSelectOption<T>({
  required T value,
  required String label,
  Widget? icon,
  Widget? disabledIcon,
  String? description,
  bool enabled = true,
  Widget Function(ZephyrSelectOption<T> option, bool isSelected)? builder,
})
```

### ZephyrSelectOptionGroup

```dart
const ZephyrSelectOptionGroup<T>({
  required String label,
  required List<ZephyrSelectOption<T>> options,
  bool expanded = false,
})
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrSelectTheme(
        fillColor: Colors.grey[50],
        borderColor: Colors.grey[300],
        focusedBorderColor: Colors.blue,
        errorBorderColor: Colors.red,
        disabledBorderColor: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        borderWidth: 1,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
        placeholderStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey[400],
        ),
        helperTextStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
        errorTextStyle: TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
        textStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        itemHeight: 48,
        maxHeight: 300,
        overlayColor: Colors.black.withOpacity(0.1),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `fillColor`: 填充颜色
- `borderColor`: 默认边框颜色
- `focusedBorderColor`: 聚焦时边框颜色
- `errorBorderColor`: 错误时边框颜色
- `disabledBorderColor`: 禁用时边框颜色
- `borderRadius`: 边框圆角
- `borderWidth`: 边框宽度
- `contentPadding`: 内容内边距
- `labelStyle`: 标签样式
- `placeholderStyle`: 占位符样式
- `helperTextStyle`: 帮助文本样式
- `errorTextStyle`: 错误文本样式
- `textStyle`: 文本样式
- `itemHeight`: 选项项高度
- `maxHeight`: 下拉框最大高度
- `overlayColor`: 遮罩颜色

## 🏆 最佳实践

### 1. 合理的选项设计

```dart
// ✅ 好的做法：选项标签简洁明了
ZephyrSelect<String>(
  options: [
    ZephyrSelectOption(value: 'active', label: '启用'),
    ZephyrSelectOption(value: 'inactive', label: '禁用'),
  ],
)

// ✅ 好的做法：为选项添加描述信息
ZephyrSelect<String>(
  options: [
    ZephyrSelectOption(
      value: 'high',
      label: '高优先级',
      description: '重要且紧急的任务',
    ),
    ZephyrSelectOption(
      value: 'medium',
      label: '中优先级',
      description: '重要但不紧急的任务',
    ),
  ],
)

// ❌ 避免的做法：选项标签过长
ZephyrSelect<String>(
  options: [
    ZephyrSelectOption(
      value: 'option1',
      label: '这是一个非常长的选项标签，可能影响用户体验',
    ),
  ],
)
```

### 2. 搜索功能的使用

```dart
// ✅ 好的做法：为大量选项提供搜索功能
ZephyrSelect<String>(
  options: _getAllCountries(),  // 大量选项
  searchable: true,
  searchHint: '搜索国家或地区...',
)

// ✅ 好的做法：为少量选项不提供搜索
ZephyrSelect<String>(
  options: [
    ZephyrSelectOption(value: 'male', label: '男'),
    ZephyrSelectOption(value: 'female', label: '女'),
  ],
  searchable: false,  // 选项很少，不需要搜索
)

// ❌ 避免的做法：为少量选项提供搜索
ZephyrSelect<String>(
  options: [
    ZephyrSelectOption(value: 'yes', label: '是'),
    ZephyrSelectOption(value: 'no', label: '否'),
  ],
  searchable: true,  // 选项很少，搜索功能多余
)
```

### 3. 性能优化

```dart
// ✅ 好的做法：使用const构造函数
const options = [
  ZephyrSelectOption(value: 'option1', label: '选项1'),
  ZephyrSelectOption(value: 'option2', label: '选项2'),
];

ZephyrSelect<String>(
  options: options,
)

// ✅ 好的做法：懒加载选项
class LazySelect extends StatefulWidget {
  @override
  _LazySelectState createState() => _LazySelectState();
}

class _LazySelectState extends State<LazySelect> {
  List<ZephyrSelectOption<String>> _options = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  Future<void> _loadOptions() async {
    setState(() => _isLoading = true);
    _options = await _fetchOptions();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrSelect<String>(
      options: _options,
      loading: _isLoading,
    );
  }
}
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrSelect<String>(
  label: '选择国家',
  placeholder: '请选择国家',
  semanticLabel: '国家选择器',
)

// ✅ 好的做法：提供清晰的选项描述
ZephyrSelect<String>(
  options: [
    ZephyrSelectOption(
      value: 'dark',
      label: '深色主题',
      description: '适合夜间使用的深色主题',
    ),
    ZephyrSelectOption(
      value: 'light',
      label: '浅色主题',
      description: '适合白天使用的浅色主题',
    ),
  ],
)
```

### 5. 响应式设计

```dart
// ✅ 好的做法：根据屏幕大小调整选择器样式
ZephyrSelect<String>(
  label: '选择项目',
  placeholder: '请选择',
  options: _options,
  maxHeight: _getResponsiveMaxHeight(context),
)

double _getResponsiveMaxHeight(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  if (height < 600) return 200;
  if (height < 800) return 300;
  return 400;
}
```

## 🔄 相关组件

- **ZephyrInputField**: 文本输入框
- **ZephyrCheckbox**: 复选框
- **ZephyrRadio**: 单选框
- **ZephyrFormBuilder**: 表单构建器
- **ZephyrDatePicker**: 日期选择器

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持单选和多选模式
- ✅ 搜索功能支持
- ✅ 分组选项支持
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/form/select/`
**示例路径**: `example/lib/components/select_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月19日