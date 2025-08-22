# ZephyrFormBuilder 表单构建器组件

表单构建器是一个功能强大的表单管理工具，支持声明式表单定义、自动验证、数据绑定等功能。提供了简洁的表单开发体验，大大简化了复杂表单的实现。

## 🎯 组件概述

### 特性
- **声明式定义**: 支持通过配置定义表单结构
- **自动验证**: 内置丰富的验证规则和自定义验证支持
- **数据绑定**: 自动处理表单数据与模型的绑定
- **状态管理**: 完整的表单状态跟踪和管理
- **灵活布局**: 支持多种布局方式和自定义样式
- **主题适配**: 完整的主题系统支持

### 适用场景
- 用户注册表单
- 用户资料编辑
- 设置配置表单
- 数据录入表单
- 搜索筛选表单
- 复杂业务表单

## 🚀 基础用法

### 基本表单构建器

```dart
ZephyrFormBuilder(
  fields: [
    ZephyrFormField(
      name: 'username',
      label: '用户名',
      type: ZephyrFormFieldType.text,
      validator: ZephyrValidator.required('请输入用户名'),
    ),
    ZephyrFormField(
      name: 'email',
      label: '邮箱',
      type: ZephyrFormFieldType.email,
      validator: ZephyrValidator.email('请输入有效的邮箱地址'),
    ),
    ZephyrFormField(
      name: 'password',
      label: '密码',
      type: ZephyrFormFieldType.password,
      validator: ZephyrValidator.minLength(6, '密码至少6个字符'),
    ),
  ],
  onSubmit: (values) {
    print('表单提交: $values');
  },
)
```

### 带初始值的表单

```dart
ZephyrFormBuilder(
  initialValue: {
    'username': 'admin',
    'email': 'admin@example.com',
    'role': 'user',
  },
  fields: [
    ZephyrFormField(
      name: 'username',
      label: '用户名',
      type: ZephyrFormFieldType.text,
      validator: ZephyrValidator.required(),
    ),
    ZephyrFormField(
      name: 'email',
      label: '邮箱',
      type: ZephyrFormFieldType.email,
      validator: ZephyrValidator.email(),
    ),
    ZephyrFormField(
      name: 'role',
      label: '角色',
      type: ZephyrFormFieldType.select,
      options: [
        ZephyrSelectOption(value: 'admin', label: '管理员'),
        ZephyrSelectOption(value: 'user', label: '普通用户'),
      ],
    ),
  ],
  onSubmit: (values) {
    print('表单提交: $values');
  },
)
```

### 分步表单

```dart
ZephyrFormBuilder(
  type: ZephyrFormType.stepper,
  steps: [
    ZephyrFormStep(
      title: '基本信息',
      fields: [
        ZephyrFormField(
          name: 'name',
          label: '姓名',
          type: ZephyrFormFieldType.text,
          validator: ZephyrValidator.required(),
        ),
        ZephyrFormField(
          name: 'email',
          label: '邮箱',
          type: ZephyrFormFieldType.email,
          validator: ZephyrValidator.email(),
        ),
      ],
    ),
    ZephyrFormStep(
      title: '详细信息',
      fields: [
        ZephyrFormField(
          name: 'phone',
          label: '电话',
          type: ZephyrFormFieldType.phone,
          validator: ZephyrValidator.required(),
        ),
        ZephyrFormField(
          name: 'address',
          label: '地址',
          type: ZephyrFormFieldType.textArea,
        ),
      ],
    ),
  ],
  onSubmit: (values) {
    print('分步表单提交: $values');
  },
)
```

## 🎨 样式定制

### 表单布局

```dart
ZephyrFormBuilder(
  layout: ZephyrFormLayout.column,
  fieldSpacing: 16,
  contentPadding: EdgeInsets.all(24),
  fields: [
    ZephyrFormField(
      name: 'name',
      label: '姓名',
      type: ZephyrFormFieldType.text,
    ),
    ZephyrFormField(
      name: 'email',
      label: '邮箱',
      type: ZephyrFormFieldType.email,
    ),
  ],
  onSubmit: (values) => print('表单提交: $values'),
)
```

### 自定义字段样式

```dart
ZephyrFormBuilder(
  fields: [
    ZephyrFormField(
      name: 'username',
      label: '用户名',
      type: ZephyrFormFieldType.text,
      decoration: ZephyrFieldDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.blue[50],
      ),
    ),
    ZephyrFormField(
      name: 'password',
      label: '密码',
      type: ZephyrFormFieldType.password,
      decoration: ZephyrFieldDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ),
  ],
  onSubmit: (values) => print('表单提交: $values'),
)
```

## 🔧 高级用法

### 用户注册表单

```dart
class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<ZephyrFormBuilderState>();
  bool _isLoading = false;

  Future<void> _handleSubmit(Map<String, dynamic> values) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _registerUser(values);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('注册成功')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('注册失败: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('用户注册')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrFormBuilder(
          key: _formKey,
          type: ZephyrFormType.stepper,
          steps: [
            ZephyrFormStep(
              title: '账户信息',
              fields: [
                ZephyrFormField(
                  name: 'username',
                  label: '用户名',
                  type: ZephyrFormFieldType.text,
                  validator: ZephyrValidator.compose([
                    ZephyrValidator.required('请输入用户名'),
                    ZephyrValidator.minLength(3, '用户名至少3个字符'),
                    ZephyrValidator.maxLength(20, '用户名最多20个字符'),
                    ZephyrValidator.pattern(
                      r'^[a-zA-Z0-9_]+$',
                      '用户名只能包含字母、数字和下划线',
                    ),
                  ]),
                ),
                ZephyrFormField(
                  name: 'email',
                  label: '邮箱',
                  type: ZephyrFormFieldType.email,
                  validator: ZephyrValidator.compose([
                    ZephyrValidator.required('请输入邮箱'),
                    ZephyrValidator.email('请输入有效的邮箱地址'),
                  ]),
                ),
                ZephyrFormField(
                  name: 'password',
                  label: '密码',
                  type: ZephyrFormFieldType.password,
                  validator: ZephyrValidator.compose([
                    ZephyrValidator.required('请输入密码'),
                    ZephyrValidator.minLength(6, '密码至少6个字符'),
                    ZephyrValidator.maxLength(20, '密码最多20个字符'),
                  ]),
                ),
                ZephyrFormField(
                  name: 'confirmPassword',
                  label: '确认密码',
                  type: ZephyrFormFieldType.password,
                  validator: (value, allValues) {
                    if (value != allValues['password']) {
                      return '两次输入的密码不一致';
                    }
                    return null;
                  },
                ),
              ],
            ),
            ZephyrFormStep(
              title: '个人信息',
              fields: [
                ZephyrFormField(
                  name: 'fullName',
                  label: '姓名',
                  type: ZephyrFormFieldType.text,
                  validator: ZephyrValidator.required('请输入姓名'),
                ),
                ZephyrFormField(
                  name: 'phone',
                  label: '手机号',
                  type: ZephyrFormFieldType.phone,
                  validator: ZephyrValidator.compose([
                    ZephyrValidator.required('请输入手机号'),
                    ZephyrValidator.phone('请输入有效的手机号'),
                  ]),
                ),
                ZephyrFormField(
                  name: 'birthday',
                  label: '生日',
                  type: ZephyrFormFieldType.date,
                  validator: ZephyrValidator.required('请选择生日'),
                ),
                ZephyrFormField(
                  name: 'gender',
                  label: '性别',
                  type: ZephyrFormFieldType.radio,
                  options: [
                    ZephyrSelectOption(value: 'male', label: '男'),
                    ZephyrSelectOption(value: 'female', label: '女'),
                    ZephyrSelectOption(value: 'other', label: '其他'),
                  ],
                  validator: ZephyrValidator.required('请选择性别'),
                ),
              ],
            ),
            ZephyrFormStep(
              title: '服务条款',
              fields: [
                ZephyrFormField(
                  name: 'terms',
                  label: '我同意用户协议和隐私政策',
                  type: ZephyrFormFieldType.checkbox,
                  validator: ZephyrValidator.isTrue('请同意用户协议'),
                ),
                ZephyrFormField(
                  name: 'newsletter',
                  label: '订阅产品更新邮件',
                  type: ZephyrFormFieldType.checkbox,
                  defaultValue: true,
                ),
              ],
            ),
          ],
          onSubmit: _handleSubmit,
          submitButton: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : null,
        ),
      ),
    );
  }

  Future<void> _registerUser(Map<String, dynamic> values) async {
    // 模拟注册API调用
    await Future.delayed(Duration(seconds: 2));
    print('注册用户: $values');
  }
}
```

### 动态表单

```dart
class DynamicForm extends StatefulWidget {
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  List<ZephyrFormField> _fields = [];
  Map<String, dynamic> _values = {};

  @override
  void initState() {
    super.initState();
    _loadFormFields();
  }

  void _loadFormFields() {
    // 模拟从API加载表单配置
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _fields = [
          ZephyrFormField(
            name: 'name',
            label: '姓名',
            type: ZephyrFormFieldType.text,
            validator: ZephyrValidator.required(),
          ),
          ZephyrFormField(
            name: 'email',
            label: '邮箱',
            type: ZephyrFormFieldType.email,
            validator: ZephyrValidator.email(),
          ),
          ZephyrFormField(
            name: 'category',
            label: '分类',
            type: ZephyrFormFieldType.select,
            options: [
              ZephyrSelectOption(value: 'personal', label: '个人'),
              ZephyrSelectOption(value: 'business', label: '企业'),
            ],
            validator: ZephyrValidator.required(),
          ),
          ZephyrFormField(
            name: 'businessName',
            label: '企业名称',
            type: ZephyrFormFieldType.text,
            visible: (values) => values['category'] == 'business',
            validator: (value, allValues) {
              if (allValues['category'] == 'business' && (value == null || value.isEmpty)) {
                return '请输入企业名称';
              }
              return null;
            },
          ),
          ZephyrFormField(
            name: 'businessLicense',
            label: '营业执照',
            type: ZephyrFormFieldType.file,
            visible: (values) => values['category'] == 'business',
            validator: (value, allValues) {
              if (allValues['category'] == 'business' && value == null) {
                return '请上传营业执照';
              }
              return null;
            },
          ),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('动态表单')),
      body: _fields.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ZephyrFormBuilder(
                fields: _fields,
                initialValue: _values,
                onChanged: (name, value, allValues) {
                  setState(() {
                    _values = allValues;
                  });
                },
                onSubmit: (values) {
                  print('动态表单提交: $values');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('表单提交成功')),
                  );
                },
              ),
            ),
    );
  }
}
```

### 表单数据预览

```dart
class FormWithPreview extends StatefulWidget {
  @override
  _FormWithPreviewState createState() => _FormWithPreviewState();
}

class _FormWithPreviewState extends State<FormWithPreview> {
  final _formKey = GlobalKey<ZephyrFormBuilderState>();
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ZephyrFormBuilder(
            key: _formKey,
            fields: [
              ZephyrFormField(
                name: 'title',
                label: '标题',
                type: ZephyrFormFieldType.text,
                validator: ZephyrValidator.required(),
              ),
              ZephyrFormField(
                name: 'content',
                label: '内容',
                type: ZephyrFormFieldType.textArea,
                validator: ZephyrValidator.required(),
              ),
              ZephyrFormField(
                name: 'category',
                label: '分类',
                type: ZephyrFormFieldType.select,
                options: [
                  ZephyrSelectOption(value: 'news', label: '新闻'),
                  ZephyrSelectOption(value: 'tech', label: '技术'),
                  ZephyrSelectOption(value: 'life', label: '生活'),
                ],
                validator: ZephyrValidator.required(),
              ),
              ZephyrFormField(
                name: 'tags',
                label: '标签',
                type: ZephyrFormFieldType.tags,
                defaultValue: [],
              ),
              ZephyrFormField(
                name: 'publishDate',
                label: '发布日期',
                type: ZephyrFormFieldType.date,
                defaultValue: DateTime.now(),
              ),
              ZephyrFormField(
                name: 'isPublished',
                label: '立即发布',
                type: ZephyrFormFieldType.switch,
                defaultValue: false,
              ),
            ],
            onChanged: (name, value, allValues) {
              setState(() {
                _formData = allValues;
              });
            },
            onSubmit: (values) {
              print('表单提交: $values');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('发布成功')),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(top: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '数据预览',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  _formatFormData(_formData),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatFormData(Map<String, dynamic> data) {
    if (data.isEmpty) return '暂无数据';
    
    return data.entries.map((entry) {
      final value = entry.value;
      String formattedValue;
      
      if (value == null) {
        formattedValue = 'null';
      } else if (value is DateTime) {
        formattedValue = DateFormat('yyyy-MM-dd').format(value);
      } else if (value is List) {
        formattedValue = '[${value.join(', ')}]';
      } else {
        formattedValue = value.toString();
      }
      
      return '${entry.key}: $formattedValue';
    }).join('\n');
  }
}
```

### 表单验证规则管理

```dart
class FormValidationRules {
  static List<ZephyrValidator> get usernameValidators => [
    ZephyrValidator.required('请输入用户名'),
    ZephyrValidator.minLength(3, '用户名至少3个字符'),
    ZephyrValidator.maxLength(20, '用户名最多20个字符'),
    ZephyrValidator.pattern(
      r'^[a-zA-Z0-9_]+$',
      '用户名只能包含字母、数字和下划线',
    ),
  ];

  static List<ZephyrValidator> get passwordValidators => [
    ZephyrValidator.required('请输入密码'),
    ZephyrValidator.minLength(8, '密码至少8个字符'),
    ZephyrValidator.maxLength(32, '密码最多32个字符'),
    ZephyrValidator.pattern(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]',
      '密码必须包含大小写字母、数字和特殊字符',
    ),
  ];

  static List<ZephyrValidator> get emailValidators => [
    ZephyrValidator.required('请输入邮箱'),
    ZephyrValidator.email('请输入有效的邮箱地址'),
  ];

  static List<ZephyrValidator> get phoneValidators => [
    ZephyrValidator.required('请输入手机号'),
    ZephyrValidator.phone('请输入有效的手机号'),
  ];

  static ZephyrValidator passwordConfirmValidator(String passwordField) {
    return (value, allValues) {
      if (value != allValues[passwordField]) {
        return '两次输入的密码不一致';
      }
      return null;
    };
  }
}

// 使用示例
ZephyrFormBuilder(
  fields: [
    ZephyrFormField(
      name: 'username',
      label: '用户名',
      type: ZephyrFormFieldType.text,
      validator: ZephyrValidator.compose(FormValidationRules.usernameValidators),
    ),
    ZephyrFormField(
      name: 'password',
      label: '密码',
      type: ZephyrFormFieldType.password,
      validator: ZephyrValidator.compose(FormValidationRules.passwordValidators),
    ),
    ZephyrFormField(
      name: 'confirmPassword',
      label: '确认密码',
      type: ZephyrFormFieldType.password,
      validator: FormValidationRules.passwordConfirmValidator('password'),
    ),
  ],
  onSubmit: (values) => print('表单提交: $values'),
)
```

## 🎛️ API 参考

### 构造函数

#### ZephyrFormBuilder()

```dart
const ZephyrFormBuilder({
  Key? key,
  List<ZephyrFormField> fields = const [],
  Map<String, dynamic>? initialValue,
  ZephyrFormType type = ZephyrFormType.basic,
  List<ZephyrFormStep>? steps,
  ZephyrFormLayout layout = ZephyrFormLayout.column,
  double fieldSpacing = 16,
  EdgeInsetsGeometry? contentPadding,
  Widget? submitButton,
  String? submitText,
  VoidCallback? onCancel,
  String? cancelText,
  ValueChanged<Map<String, dynamic>>? onSubmit,
  ValueChanged<String, dynamic, Map<String, dynamic>>? onChanged,
  ZephyrFormBuilderTheme? theme,
  bool autoValidate = false,
  bool canPop = true,
  String? semanticLabel,
})
```

**参数说明：**
- `fields`: 表单字段列表
- `initialValue`: 初始值
- `type`: 表单类型
- `steps`: 分步表单的步骤
- `layout`: 布局方式
- `fieldSpacing`: 字段间距
- `contentPadding`: 内容内边距
- `submitButton`: 自定义提交按钮
- `submitText`: 提交按钮文本
- `onCancel`: 取消回调
- `cancelText`: 取消按钮文本
- `onSubmit`: 提交回调
- `onChanged`: 字段变化回调
- `theme`: 主题配置
- `autoValidate`: 是否自动验证
- `canPop`: 是否可以返回
- `semanticLabel`: 语义标签

### ZephyrFormField

```dart
const ZephyrFormField({
  required String name,
  required String label,
  required ZephyrFormFieldType type,
  String? helperText,
  String? placeholder,
  FormFieldValidator? validator,
  dynamic defaultValue,
  List<ZephyrSelectOption>? options,
  ZephyrFieldDecoration? decoration,
  bool Function(Map<String, dynamic>)? visible,
  bool enabled = true,
  bool readOnly = false,
  Map<String, dynamic>? extraParams,
})
```

### 枚举类型

#### ZephyrFormType

```dart
enum ZephyrFormType {
  basic,    // 基本表单
  stepper,  // 分步表单
  wizard,   // 向导表单
}
```

#### ZephyrFormLayout

```dart
enum ZephyrFormLayout {
  column,   // 垂直布局
  row,      // 水平布局
  grid,     // 网格布局
}
```

#### ZephyrFormFieldType

```dart
enum ZephyrFormFieldType {
  text,        // 文本输入
  email,       // 邮箱输入
  password,    // 密码输入
  number,      // 数字输入
  phone,       // 电话输入
  textArea,    // 多行文本
  select,      // 下拉选择
  radio,       // 单选框
  checkbox,    // 复选框
  switch,      // 开关
  date,        // 日期选择
  time,        // 时间选择
  file,        // 文件上传
  tags,        // 标签输入
  rating,      // 评分
  slider,      // 滑块
  custom,      // 自定义字段
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrFormBuilderTheme(
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
        helperTextStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
        errorTextStyle: TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
        fieldSpacing: 16,
        contentPadding: EdgeInsets.all(24),
        submitButtonStyle: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
        ),
        cancelButtonStyle: OutlinedButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
        ),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `labelStyle`: 标签样式
- `helperTextStyle`: 帮助文本样式
- `errorTextStyle`: 错误文本样式
- `fieldSpacing`: 字段间距
- `contentPadding`: 内容内边距
- `submitButtonStyle`: 提交按钮样式
- `cancelButtonStyle`: 取消按钮样式

## 🏆 最佳实践

### 1. 合理的表单设计

```dart
// ✅ 好的做法：分组相关字段
ZephyrFormBuilder(
  fields: [
    // 基本信息
    ZephyrFormField(name: 'name', label: '姓名', type: ZephyrFormFieldType.text),
    ZephyrFormField(name: 'email', label: '邮箱', type: ZephyrFormFieldType.email),
    
    // 联系信息
    ZephyrFormField(name: 'phone', label: '电话', type: ZephyrFormFieldType.phone),
    ZephyrFormField(name: 'address', label: '地址', type: ZephyrFormFieldType.textArea),
  ],
)

// ✅ 好的做法：使用分步表单简化复杂表单
ZephyrFormBuilder(
  type: ZephyrFormType.stepper,
  steps: [
    ZephyrFormStep(title: '第一步', fields: [...]),
    ZephyrFormStep(title: '第二步', fields: [...]),
  ],
)

// ❌ 避免的做法：单个表单包含过多字段
ZephyrFormBuilder(
  fields: [
    // 过多的字段会让用户感到压力
    ZephyrFormField(name: 'field1', ...),
    ZephyrFormField(name: 'field2', ...),
    // ... 更多字段
  ],
)
```

### 2. 智能的字段验证

```dart
// ✅ 好的做法：提供清晰的验证反馈
ZephyrFormField(
  name: 'email',
  label: '邮箱',
  type: ZephyrFormFieldType.email,
  validator: ZephyrValidator.compose([
    ZephyrValidator.required('请输入邮箱'),
    ZephyrValidator.email('请输入有效的邮箱地址'),
  ]),
)

// ✅ 好的做法：使用条件验证
ZephyrFormField(
  name: 'businessName',
  label: '企业名称',
  type: ZephyrFormFieldType.text,
  validator: (value, allValues) {
    if (allValues['userType'] == 'business' && (value == null || value.isEmpty)) {
      return '请输入企业名称';
    }
    return null;
  },
)

// ❌ 避免的做法：验证信息不明确
ZephyrFormField(
  name: 'email',
  validator: (value) => value!.isEmpty ? '错误' : null,  // 信息不明确
)
```

### 3. 动态表单处理

```dart
// ✅ 好的做法：根据条件显示字段
ZephyrFormField(
  name: 'businessName',
  label: '企业名称',
  type: ZephyrFormFieldType.text,
  visible: (values) => values['userType'] == 'business',
)

// ✅ 好的做法：动态加载选项
ZephyrFormField(
  name: 'city',
  label: '城市',
  type: ZephyrFormFieldType.select,
  options: (values) => _getCitiesForProvince(values['province']),
)

// ❌ 避免的做法：静态处理动态需求
ZephyrFormField(
  name: 'city',
  label: '城市',
  type: ZephyrFormFieldType.select,
  options: _allCities,  // 包含所有城市的列表，不高效
)
```

### 4. 性能优化

```dart
// ✅ 好的做法：使用const构造函数
const fields = [
  ZephyrFormField(name: 'name', label: '姓名', type: ZephyrFormFieldType.text),
  ZephyrFormField(name: 'email', label: '邮箱', type: ZephyrFormFieldType.email),
];

ZephyrFormBuilder(
  fields: fields,
  onSubmit: (values) => print('表单提交: $values'),
)

// ✅ 好的做法：避免不必要的重建
class OptimizedForm extends StatefulWidget {
  @override
  _OptimizedFormState createState() => _OptimizedFormState();
}

class _OptimizedFormState extends State<OptimizedForm> {
  final _formKey = GlobalKey<ZephyrFormBuilderState>();
  
  @override
  Widget build(BuildContext context) {
    return ZephyrFormBuilder(
      key: _formKey,
      fields: _buildFields(),
      onSubmit: _handleSubmit,
    );
  }
  
  List<ZephyrFormField> _buildFields() {
    return [
      ZephyrFormField(name: 'name', label: '姓名', type: ZephyrFormFieldType.text),
      // 只在需要时重建字段
    ];
  }
}
```

### 5. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrFormBuilder(
  semanticLabel: '用户注册表单',
  fields: [
    ZephyrFormField(
      name: 'username',
      label: '用户名',
      type: ZephyrFormFieldType.text,
      semanticLabel: '用户名输入框',
    ),
  ],
)

// ✅ 好的做法：提供键盘导航支持
Focus(
  child: ZephyrFormBuilder(
    fields: [...],
    onSubmit: (values) => print('表单提交: $values'),
  ),
)
```

## 🔄 相关组件

- **ZephyrFormField**: 表单字段组件
- **ZephyrValidator**: 验证器组件
- **ZephyrFormStep**: 表单步骤组件
- **ZephyrInputField**: 输入框组件
- **ZephyrSelect**: 选择器组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本表单构建
- ✅ 分步表单支持
- ✅ 动态表单支持
- ✅ 完整的验证系统

---

**组件路径**: `lib/src/components/form/form_builder/`
**示例路径**: `example/lib/components/form_builder_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日