# ZephyrTextArea 文本域组件

文本域组件是一个多行文本输入控件，专为大量文本输入而设计。支持自动调整高度、字符计数、占位符文本等功能，并提供丰富的样式定制选项。

## 🎯 组件概述

### 特性
- **多行输入**: 支持多行文本输入和自动换行
- **自动调整高度**: 可根据内容自动调整文本域高度
- **字符计数**: 支持最大字符数限制和实时计数显示
- **丰富样式**: 支持边框、背景色、圆角等样式定制
- **状态管理**: 完整的错误、禁用、只读状态支持
- **主题适配**: 完整的主题系统支持

### 适用场景
- 评论和反馈输入
- 商品描述编辑
- 文章内容编辑
- 用户签名设置
- 邮件正文输入
- 详细信息录入

## 🚀 基础用法

### 基本文本域

```dart
ZephyrTextArea(
  label: '个人简介',
  placeholder: '请介绍一下自己...',
  onChanged: (value) => print('输入内容: $value'),
)
```

### 带字符限制的文本域

```dart
ZephyrTextArea(
  label: '商品描述',
  placeholder: '请详细描述商品特点和优势...',
  maxLength: 500,
  counter: true,
  onChanged: (value) => _updateDescription(value),
)
```

### 自动调整高度的文本域

```dart
ZephyrTextArea(
  label: '评论内容',
  placeholder: '请输入您的评论...',
  autoHeight: true,
  minLines: 3,
  maxLines: 8,
  onChanged: (value) => _updateComment(value),
)
```

### 固定高度的文本域

```dart
ZephyrTextArea(
  label: '文章内容',
  placeholder: '请输入文章内容...',
  minLines: 10,
  maxLines: 10,
  expands: false,
  onChanged: (value) => _updateContent(value),
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    ZephyrTextArea(
      label: '默认样式',
      placeholder: '默认文本域',
    ),
    SizedBox(height: 16),
    ZephyrTextArea(
      label: '自定义边框',
      placeholder: '自定义边框颜色',
      borderColor: Colors.blue,
      focusedBorderColor: Colors.blue,
    ),
    SizedBox(height: 16),
    ZephyrTextArea(
      label: '圆角边框',
      placeholder: '圆角文本域',
      borderRadius: BorderRadius.circular(12),
    ),
    SizedBox(height: 16),
    ZephyrTextArea(
      label: '填充背景',
      placeholder: '填充背景色',
      filled: true,
      fillColor: Colors.grey[100],
    ),
  ],
)
```

### 只读和禁用状态

```dart
Column(
  children: [
    ZephyrTextArea(
      label: '只读文本域',
      value: '这是只读的文本内容，无法编辑。',
      readOnly: true,
    ),
    SizedBox(height: 16),
    ZephyrTextArea(
      label: '禁用文本域',
      placeholder: '禁用的文本域',
      enabled: false,
    ),
  ],
)
```

### 带图标的文本域

```dart
ZephyrTextArea(
  label: '反馈内容',
  placeholder: '请描述您遇到的问题...',
  prefixIcon: Icon(Icons.feedback),
  suffixIcon: Icon(Icons.help_outline),
  helperText: '请尽可能详细地描述问题，以便我们更好地为您服务。',
)
```

## 🔧 高级用法

### 评论输入组件

```dart
class CommentInput extends StatefulWidget {
  final ValueChanged<String> onCommentChanged;
  final VoidCallback onSubmit;

  const CommentInput({
    Key? key,
    required this.onCommentChanged,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final _controller = TextEditingController();
  int _remainingChars = 500;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateCharCount);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateCharCount);
    _controller.dispose();
    super.dispose();
  }

  void _updateCharCount() {
    setState(() {
      _remainingChars = 500 - _controller.text.length;
    });
    widget.onCommentChanged(_controller.text);
  }

  void _submitComment() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSubmit();
      _controller.clear();
      _updateCharCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrTextArea(
          controller: _controller,
          label: '发表评论',
          placeholder: '写下您的评论...',
          maxLength: 500,
          counter: true,
          autoHeight: true,
          minLines: 3,
          maxLines: 6,
          helperText: '请文明发言，友善交流',
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '还可以输入 $_remainingChars 个字符',
              style: TextStyle(
                fontSize: 12,
                color: _remainingChars < 50 ? Colors.red : Colors.grey[600],
              ),
            ),
            ElevatedButton(
              onPressed: _controller.text.trim().isEmpty ? null : _submitComment,
              child: Text('发表评论'),
            ),
          ],
        ),
      ],
    );
  }
}
```

### 富文本编辑器基础

```dart
class RichTextEditor extends StatefulWidget {
  final ValueChanged<String> onTextChanged;

  const RichTextEditor({
    Key? key,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  _RichTextEditorState createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  final _controller = TextEditingController();
  bool _isBold = false;
  bool _isItalic = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateText);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateText);
    _controller.dispose();
    super.dispose();
  }

  void _updateText() {
    widget.onTextChanged(_controller.text);
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
    });
  }

  void _toggleItalic() {
    setState(() {
      _isItalic = !_isItalic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 工具栏
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            color: Colors.grey[50],
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.format_bold),
                onPressed: _toggleBold,
                color: _isBold ? Colors.blue : Colors.grey[600],
                tooltip: '粗体',
              ),
              IconButton(
                icon: Icon(Icons.format_italic),
                onPressed: _toggleItalic,
                color: _isItalic ? Colors.blue : Colors.grey[600],
                tooltip: '斜体',
              ),
              SizedBox(width: 16),
              Icon(Icons.format_size, color: Colors.grey[600]),
              SizedBox(width: 8),
              Text('字体大小'),
            ],
          ),
        ),
        // 文本域
        ZephyrTextArea(
          controller: _controller,
          placeholder: '开始编辑...',
          minLines: 8,
          maxLines: 12,
          expands: false,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
        ),
      ],
    );
  }
}
```

### 带验证的文本域

```dart
class ValidatedTextArea extends StatefulWidget {
  final String label;
  final String? placeholder;
  final int? maxLength;
  final bool required;
  final ValueChanged<String> onChanged;

  const ValidatedTextArea({
    Key? key,
    required this.label,
    this.placeholder,
    this.maxLength,
    this.required = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ValidatedTextAreaState createState() => _ValidatedTextAreaState();
}

class _ValidatedTextAreaState extends State<ValidatedTextArea> {
  final _controller = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_validateInput);
  }

  @override
  void dispose() {
    _controller.removeListener(_validateInput);
    _controller.dispose();
    super.dispose();
  }

  void _validateInput() {
    final text = _controller.text;
    
    setState(() {
      if (widget.required && text.trim().isEmpty) {
        _errorText = '此字段为必填项';
      } else if (widget.maxLength != null && text.length > widget.maxLength!) {
        _errorText = '最多输入 ${widget.maxLength} 个字符';
      } else {
        _errorText = null;
      }
    });
    
    widget.onChanged(text);
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrTextArea(
      controller: _controller,
      label: widget.label,
      placeholder: widget.placeholder,
      maxLength: widget.maxLength,
      counter: widget.maxLength != null,
      errorText: _errorText,
      minLines: 4,
      maxLines: 8,
    );
  }
}
```

### 自动保存的文本域

```dart
class AutoSaveTextArea extends StatefulWidget {
  final String? initialValue;
  final Duration saveDelay;
  final Future<String> Function(String) onSave;

  const AutoSaveTextArea({
    Key? key,
    this.initialValue,
    this.saveDelay = const Duration(seconds: 2),
    required this.onSave,
  }) : super(key: key);

  @override
  _AutoSaveTextAreaState createState() => _AutoSaveTextAreaState();
}

class _AutoSaveTextAreaState extends State<AutoSaveTextArea> {
  final _controller = TextEditingController();
  Timer? _saveTimer;
  bool _isSaving = false;
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _saveTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasUnsavedChanges = true;
    });

    // 取消之前的保存计时器
    _saveTimer?.cancel();

    // 设置新的保存计时器
    _saveTimer = Timer(widget.saveDelay, _saveContent);
  }

  Future<void> _saveContent() async {
    if (!_hasUnsavedChanges) return;

    setState(() {
      _isSaving = true;
    });

    try {
      await widget.onSave(_controller.text);
      setState(() {
        _hasUnsavedChanges = false;
        _isSaving = false;
      });
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '编辑内容',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (_isSaving)
              Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('正在保存...'),
                ],
              )
            else if (_hasUnsavedChanges)
              Row(
                children: [
                  Icon(Icons.edit, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '未保存的更改',
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '已保存',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
          ],
        ),
        SizedBox(height: 8),
        ZephyrTextArea(
          controller: _controller,
          placeholder: '开始编辑...',
          minLines: 8,
          maxLines: 12,
          helperText: '内容会自动保存',
        ),
      ],
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrTextArea()

```dart
const ZephyrTextArea({
  Key? key,
  String? label,
  String? placeholder,
  String? helperText,
  String? errorText,
  String? value,
  TextEditingController? controller,
  int? minLines = 3,
  int? maxLines = 5,
  int? maxLength,
  bool counter = false,
  bool autoHeight = false,
  bool expands = false,
  bool readOnly = false,
  bool enabled = true,
  bool filled = false,
  Color? fillColor,
  Widget? prefixIcon,
  Widget? suffixIcon,
  ValueChanged<String>? onChanged,
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
- `label`: 文本域标签
- `placeholder`: 占位符文本
- `helperText`: 帮助文本
- `errorText`: 错误文本
- `value`: 文本域值
- `controller`: 文本控制器
- `minLines`: 最小行数
- `maxLines`: 最大行数
- `maxLength`: 最大字符数
- `counter`: 是否显示字符计数器
- `autoHeight`: 是否自动调整高度
- `expands`: 是否填充父容器
- `readOnly`: 是否只读
- `enabled`: 是否启用
- `filled`: 是否填充背景
- `fillColor`: 填充颜色
- `prefixIcon`: 前缀图标
- `suffixIcon`: 后缀图标
- `onChanged`: 文本变化回调
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
      ZephyrTextAreaTheme(
        fillColor: Colors.grey[50],
        borderColor: Colors.grey[300],
        focusedBorderColor: Colors.blue,
        errorBorderColor: Colors.red,
        disabledBorderColor: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        borderWidth: 1,
        contentPadding: EdgeInsets.all(16),
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
          height: 1.5,
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

### 1. 合理的行数设置

```dart
// ✅ 好的做法：根据内容类型设置合适的行数
ZephyrTextArea(
  label: '评论',
  placeholder: '写下您的评论...',
  minLines: 3,
  maxLines: 6,
)

ZephyrTextArea(
  label: '文章内容',
  placeholder: '请输入文章内容...',
  minLines: 10,
  maxLines: 20,
)

// ❌ 避免的做法：行数设置不合理
ZephyrTextArea(
  label: '评论',
  minLines: 1,  // 对于评论来说太少
  maxLines: 2,
)
```

### 2. 字符限制和计数

```dart
// ✅ 好的做法：为长文本设置合理的字符限制
ZephyrTextArea(
  label: '商品描述',
  placeholder: '请描述商品特点...',
  maxLength: 1000,
  counter: true,
  helperText: '详细描述有助于用户了解商品',
)

// ✅ 好的做法：为短文本设置较严格的限制
ZephyrTextArea(
  label: '个人签名',
  placeholder: '一句话介绍自己...',
  maxLength: 50,
  counter: true,
)

// ❌ 避免的做法：字符限制过严或过松
ZephyrTextArea(
  label: '详细描述',
  maxLength: 100,  // 对于详细描述来说太少
  counter: true,
)
```

### 3. 自动高度的使用

```dart
// ✅ 好的做法：对于可变长度内容使用自动高度
ZephyrTextArea(
  label: '评论内容',
  placeholder: '写下您的评论...',
  autoHeight: true,
  minLines: 3,
  maxLines: 8,
)

// ✅ 好的做法：对于固定格式内容使用固定高度
ZephyrTextArea(
  label: '固定格式输入',
  placeholder: '请按格式输入...',
  minLines: 5,
  maxLines: 5,
  autoHeight: false,
)

// ❌ 避免的做法：在需要固定高度的地方使用自动高度
ZephyrTextArea(
  label: '地址输入',
  autoHeight: true,  // 地址通常需要固定格式
  maxLines: 10,     // 可能过长
)
```

### 4. 性能优化

```dart
// ✅ 好的做法：使用控制器管理状态
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
    return ZephyrTextArea(
      controller: _controller,
      label: '内容',
    );
  }
}

// ✅ 好的做法：防抖处理自动保存
class AutoSaveWidget extends StatefulWidget {
  @override
  _AutoSaveWidgetState createState() => _AutoSaveWidgetState();
}

class _AutoSaveWidgetState extends State<AutoSaveWidget> {
  final _controller = TextEditingController();
  Timer? _saveTimer;

  @override
  void dispose() {
    _controller.dispose();
    _saveTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    _saveTimer?.cancel();
    _saveTimer = Timer(Duration(seconds: 2), _saveContent);
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrTextArea(
      controller: _controller,
      label: '内容',
      onChanged: (value) => _onTextChanged(),
    );
  }
}
```

### 5. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrTextArea(
  label: '用户反馈',
  placeholder: '请描述您遇到的问题...',
  semanticLabel: '用户反馈输入框',
  helperText: '您的反馈对我们很重要',
)

// ✅ 好的做法：提供清晰的错误提示
ZephyrTextArea(
  label: '详细描述',
  placeholder: '请详细描述...',
  maxLength: 500,
  counter: true,
  errorText: _errorText,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入详细描述';
    }
    if (value.length < 10) {
      return '描述至少需要10个字符';
    }
    return null;
  },
)
```

## 🔄 相关组件

- **ZephyrInputField**: 单行文本输入
- **ZephyrFormBuilder**: 表单构建器
- **ZephyrRichEditor**: 富文本编辑器
- **ZephyrButton**: 表单提交按钮

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多行文本输入
- ✅ 自动高度调整
- ✅ 字符计数功能
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/form/text_area/`
**示例路径**: `example/lib/components/text_area_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月19日