# ZephyrInputField 输入框组件

输入框组件是一个功能强大的表单控件，支持多种输入模式、验证、装饰和状态管理。提供了丰富的文本输入体验，包括基本输入、密码输入、多行输入等模式。

## 🎯 组件概述

### 特性
- **多种输入模式**: 支持文本、密码、数字、邮箱等多种输入类型
- **完整的验证系统**: 内置验证规则和自定义验证支持
- **丰富的装饰选项**: 支持前缀、后缀、标签、提示文本等
- **状态管理**: 完整的错误、禁用、只读状态支持
- **主题适配**: 完整的主题系统支持
- **无障碍支持**: 完整的语义化和键盘导航

### 适用场景
- 用户登录表单
- 用户注册表单
- 搜索输入框
- 数据录入表单
- 设置页面输入
- 评论和消息输入

## 🚀 基础用法

### 基本文本输入

```dart
ZephyrInputField(
  label: '用户名',
  placeholder: '请输入用户名',
  onChanged: (value) => print('输入: $value'),
)
```

### 密码输入

```dart
ZephyrInputField(
  label: '密码',
  placeholder: '请输入密码',
  obscureText: true,
  suffixIcon: IconButton(
    icon: Icon(Icons.visibility),
    onPressed: () => _togglePasswordVisibility(),
  ),
)
```

### 带验证的输入

```dart
ZephyrInputField(
  label: '邮箱',
  placeholder: '请输入邮箱地址',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱地址';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  },
)
```

### 数字输入

```dart
ZephyrInputField(
  label: '年龄',
  placeholder: '请输入年龄',
  keyboardType: TextInputType.number,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    ZephyrInputField(
      label: '默认样式',
      placeholder: '默认输入框',
    ),
    SizedBox(height: 16),
    ZephyrInputField(
      label: '自定义颜色',
      placeholder: '自定义边框颜色',
      borderColor: Colors.blue,
      focusedBorderColor: Colors.blue,
    ),
    SizedBox(height: 16),
    ZephyrInputField(
      label: '圆角边框',
      placeholder: '圆角输入框',
      borderRadius: BorderRadius.circular(12),
    ),
    SizedBox(height: 16),
    ZephyrInputField(
      label: '填充背景',
      placeholder: '填充背景色',
      filled: true,
      fillColor: Colors.grey[100],
    ),
  ],
)
```

### 前缀和后缀

```dart
Column(
  children: [
    ZephyrInputField(
      label: '手机号',
      placeholder: '请输入手机号',
      prefixIcon: Icon(Icons.phone),
      keyboardType: TextInputType.phone,
    ),
    SizedBox(height: 16),
    ZephyrInputField(
      label: '网站',
      placeholder: '请输入网址',
      prefixText: 'https://',
      suffixIcon: Icon(Icons.link),
    ),
    SizedBox(height: 16),
    ZephyrInputField(
      label: '搜索',
      placeholder: '搜索内容...',
      prefixIcon: Icon(Icons.search),
      suffixIcon: Icon(Icons.clear),
      onSuffixPressed: () => _clearSearch(),
    ),
  ],
)
```

### 多行文本输入

```dart
ZephyrInputField(
  label: '个人简介',
  placeholder: '请介绍一下自己...',
  maxLines: 4,
  maxLength: 200,
  counter: true,
  onChanged: (value) => _updateBio(value),
)
```

### 只读和禁用状态

```dart
Column(
  children: [
    ZephyrInputField(
      label: '只读字段',
      value: '这是只读内容',
      readOnly: true,
    ),
    SizedBox(height: 16),
    ZephyrInputField(
      label: '禁用字段',
      placeholder: '禁用的输入框',
      enabled: false,
    ),
  ],
)
```

## 🔧 高级用法

### 带验证的表单

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _login(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登录成功')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登录失败: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ZephyrInputField(
            label: '用户名',
            placeholder: '请输入用户名',
            controller: _usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入用户名';
              }
              if (value.length < 3) {
                return '用户名至少3个字符';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ZephyrInputField(
            label: '密码',
            placeholder: '请输入密码',
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入密码';
              }
              if (value.length < 6) {
                return '密码至少6个字符';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              child: _isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text('登录'),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 实时搜索输入

```dart
class SearchInput extends StatefulWidget {
  final ValueChanged<String> onSearch;

  const SearchInput({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final _controller = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      widget.onSearch(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrInputField(
      placeholder: '搜索...',
      controller: _controller,
      prefixIcon: Icon(Icons.search),
      suffixIcon: _controller.text.isNotEmpty
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                widget.onSearch('');
              },
            )
          : null,
      onChanged: (value) {
        // 实时更新，防抖处理在监听器中
      },
    );
  }
}
```

### 格式化输入

```dart
class FormattedInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 金额输入
        ZephyrInputField(
          label: '金额',
          placeholder: '0.00',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          prefixText: '¥',
        ),
        SizedBox(height: 16),
        // 电话号码输入
        ZephyrInputField(
          label: '电话号码',
          placeholder: '138-0000-0000',
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
            LengthLimitingTextInputFormatter(13),
          ],
        ),
        SizedBox(height: 16),
        // 日期输入
        ZephyrInputField(
          label: '日期',
          placeholder: 'YYYY-MM-DD',
          keyboardType: TextInputType.datetime,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
            _DateInputFormatter(),
          ],
        ),
      ],
    );
  }
}

// 自定义日期格式化器
class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    
    if (text.length > 10) {
      text = text.substring(0, 10);
    }
    
    if (text.length == 4 && !text.contains('-')) {
      text = '$text-';
    } else if (text.length == 7 && text.split('-').length == 2) {
      text = '$text-';
    }
    
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
```

### 自动完成输入

```dart
class AutoCompleteInput extends StatefulWidget {
  final List<String> suggestions;
  final ValueChanged<String> onSelected;

  const AutoCompleteInput({
    Key? key,
    required this.suggestions,
    required this.onSelected,
  }) : super(key: key);

  @override
  _AutoCompleteInputState createState() => _AutoCompleteInputState();
}

class _AutoCompleteInputState extends State<AutoCompleteInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  List<String> _filteredSuggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _controller.text.toLowerCase();
    setState(() {
      _filteredSuggestions = widget.suggestions
          .where((suggestion) => suggestion.toLowerCase().contains(text))
          .toList();
      _showSuggestions = text.isNotEmpty;
    });
  }

  void _onFocusChanged() {
    setState(() {
      _showSuggestions = _focusNode.hasFocus && _controller.text.isNotEmpty;
    });
  }

  void _selectSuggestion(String suggestion) {
    _controller.text = suggestion;
    _controller.selection = TextSelection.collapsed(offset: suggestion.length);
    setState(() {
      _showSuggestions = false;
    });
    widget.onSelected(suggestion);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrInputField(
          placeholder: '输入搜索内容...',
          controller: _controller,
          focusNode: _focusNode,
        ),
        if (_showSuggestions && _filteredSuggestions.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredSuggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _filteredSuggestions[index];
                return ListTile(
                  title: Text(suggestion),
                  onTap: () => _selectSuggestion(suggestion),
                );
              },
            ),
          ),
      ],
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrInputField()

```dart
const ZephyrInputField({
  Key? key,
  String? label,
  String? placeholder,
  String? helperText,
  String? errorText,
  String? value,
  TextEditingController? controller,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  bool obscureText = false,
  bool readOnly = false,
  bool enabled = true,
  bool filled = false,
  Color? fillColor,
  int? maxLines = 1,
  int? minLines,
  int? maxLength,
  bool counter = false,
  Widget? prefixIcon,
  String? prefixText,
  Widget? suffixIcon,
  String? suffixText,
  VoidCallback? onSuffixPressed,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmitted,
  FormFieldValidator<String>? validator,
  List<TextInputFormatter>? inputFormatters,
  FocusNode? focusNode,
  bool autofocus = false,
  EdgeInsetsGeometry? contentPadding,
  BorderRadius? borderRadius,
  Color? borderColor,
  Color? focusedBorderColor,
  Color? errorBorderColor,
  Color? disabledBorderColor,
  double? borderWidth,
  TextStyle? textStyle,
  TextStyle? labelStyle,
  TextStyle? placeholderStyle,
  TextStyle? helperTextStyle,
  TextStyle? errorTextStyle,
  String? semanticLabel,
})
```

**参数说明：**
- `label`: 输入框标签
- `placeholder`: 占位符文本
- `helperText`: 帮助文本
- `errorText`: 错误文本
- `value`: 输入框值
- `controller`: 文本控制器
- `keyboardType`: 键盘类型
- `textInputAction`: 键盘操作类型
- `obscureText`: 是否隐藏文本（密码输入）
- `readOnly`: 是否只读
- `enabled`: 是否启用
- `filled`: 是否填充背景
- `fillColor`: 填充颜色
- `maxLines`: 最大行数
- `minLines`: 最小行数
- `maxLength`: 最大字符数
- `counter`: 是否显示字符计数器
- `prefixIcon`: 前缀图标
- `prefixText`: 前缀文本
- `suffixIcon`: 后缀图标
- `suffixText`: 后缀文本
- `onSuffixPressed`: 后缀按钮点击回调
- `onChanged`: 文本变化回调
- `onSubmitted`: 提交回调
- `validator`: 验证器
- `inputFormatters`: 输入格式化器
- `focusNode`: 焦点节点
- `autofocus`: 是否自动聚焦
- `contentPadding`: 内容内边距
- `borderRadius`: 边框圆角
- `borderColor`: 边框颜色
- `focusedBorderColor`: 聚焦时边框颜色
- `errorBorderColor`: 错误时边框颜色
- `disabledBorderColor`: 禁用时边框颜色
- `borderWidth`: 边框宽度
- `textStyle`: 文本样式
- `labelStyle`: 标签样式
- `placeholderStyle`: 占位符样式
- `helperTextStyle`: 帮助文本样式
- `errorTextStyle`: 错误文本样式
- `semanticLabel`: 语义标签

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrInputFieldTheme(
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

## 🏆 最佳实践

### 1. 合理的输入类型

```dart
// ✅ 好的做法：根据输入内容选择合适的键盘类型
ZephyrInputField(
  label: '邮箱',
  keyboardType: TextInputType.emailAddress,
)

ZephyrInputField(
  label: '电话号码',
  keyboardType: TextInputType.phone,
)

ZephyrInputField(
  label: '数字',
  keyboardType: TextInputType.number,
)

// ❌ 避免的做法：使用不合适的键盘类型
ZephyrInputField(
  label: '邮箱',
  keyboardType: TextInputType.text,  // 应该使用邮箱键盘
)
```

### 2. 适当的验证

```dart
// ✅ 好的做法：提供清晰的验证反馈
ZephyrInputField(
  label: '密码',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    if (value.length < 6) {
      return '密码至少6个字符';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return '密码需要包含大写字母';
    }
    return null;
  },
)

// ❌ 避免的做法：验证信息不清晰
ZephyrInputField(
  label: '密码',
  validator: (value) {
    if (value!.length < 6) return '错误';  // 信息不明确
  },
)
```

### 3. 性能优化

```dart
// ✅ 好的做法：使用控制器管理输入状态
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();  // 释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrInputField(
      controller: _controller,
      label: '用户名',
    );
  }
}

// ✅ 好的做法：防抖处理实时搜索
class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _controller = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      _performSearch(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrInputField(
      controller: _controller,
      label: '搜索',
      onChanged: (value) => _onSearchChanged(),
    );
  }
}
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrInputField(
  label: '用户名',
  semanticLabel: '请输入您的用户名',
  autofocus: true,
)

// ✅ 好的做法：提供键盘操作支持
ZephyrInputField(
  label: '搜索',
  textInputAction: TextInputAction.search,
  onSubmitted: (value) => _performSearch(value),
)

// ✅ 好的做法：为密码字段提供显示/隐藏选项
ZephyrInputField(
  label: '密码',
  obscureText: _obscureText,
  suffixIcon: IconButton(
    icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
    onPressed: () => setState(() => _obscureText = !_obscureText),
    tooltip: _obscureText ? '显示密码' : '隐藏密码',
  ),
)
```

### 5. 响应式设计

```dart
// ✅ 好的做法：根据屏幕大小调整输入框样式
ZephyrInputField(
  label: '用户名',
  contentPadding: _getResponsivePadding(context),
)

EdgeInsetsGeometry _getResponsivePadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) {
    return EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  } else {
    return EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  }
}
```

## 🔄 相关组件

- **ZephyrTextArea**: 多行文本输入
- **ZephyrFormBuilder**: 表单构建器
- **ZephyrSelect**: 选择器组件
- **ZephyrDatePicker**: 日期选择器
- **ZephyrButton**: 表单提交按钮

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种输入类型和验证
- ✅ 完整的主题系统支持
- ✅ 丰富的装饰选项
- ✅ 无障碍支持

---

**组件路径**: `lib/src/components/form/input/`
**示例路径**: `example/lib/components/input_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月19日