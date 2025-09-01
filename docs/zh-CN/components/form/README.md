---
title: 表单组件
description: ZephyrUI 表单组件，包括输入框、选择器、复选框等表单相关组件
---

# 表单组件

表单组件用于数据输入和表单构建，提供了丰富的输入类型、验证和样式选项。

## 📦 组件列表

| 组件 | 描述 | 链接 |
|------|------|------|
| [输入框](./input) | 支持多种输入类型和验证的输入框组件 | [查看文档](./input) |
| [选择器](./select) | 支持下拉和搜索的选择器组件 | [查看文档](./select) |
| [复选框](./checkbox) | 支持多种状态的复选框组件 | [查看文档](./checkbox) |
| [单选框](./radio) | 支持分组选择的单选框组件 | [查看文档](./radio) |
| [开关](./switch) | 支持滑动切换的开关组件 | [查看文档](./switch) |
| [滑块](./slider) | 支持数值选择的滑块组件 | [查看文档](./slider) |
| [评分](./rating) | 支持星级评分的评分组件 | [查看文档](./rating) |
| [日期选择器](./date_picker) | 支持日期和时间选择的日期选择器组件 | [查看文档](./date_picker) |
| [文本域](./text_area) | 支持多行文本输入的文本域组件 | [查看文档](./text_area) |

## 🎯 使用示例

### 基本表单
```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class FormDemo extends StatefulWidget {
  @override
  _FormDemoState createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  bool _agreeToTerms = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表单示例'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 用户名输入
              ZephyrInput(
                label: '用户名',
                placeholder: '请输入用户名',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入用户名';
                  }
                  if (value.length < 3) {
                    return '用户名长度不能少于3位';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              
              SizedBox(height: 16),
              
              // 邮箱输入
              ZephyrInput(
                label: '邮箱',
                placeholder: '请输入邮箱',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入邮箱';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return '请输入有效的邮箱地址';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              
              SizedBox(height: 16),
              
              // 密码输入
              ZephyrInput(
                label: '密码',
                placeholder: '请输入密码',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  if (value.length < 6) {
                    return '密码长度不能少于6位';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              
              SizedBox(height: 16),
              
              // 选择器
              ZephyrSelect<String>(
                label: '性别',
                placeholder: '请选择性别',
                options: [
                  ZephyrSelectOption(
                    value: 'male',
                    label: '男',
                  ),
                  ZephyrSelectOption(
                    value: 'female',
                    label: '女',
                  ),
                  ZephyrSelectOption(
                    value: 'other',
                    label: '其他',
                  ),
                ],
                onChanged: (value) {
                  print('选择的性别: $value');
                },
              ),
              
              SizedBox(height: 16),
              
              // 复选框
              ZephyrCheckbox(
                label: '我同意服务条款',
                value: _agreeToTerms,
                onChanged: (value) {
                  setState(() {
                    _agreeToTerms = value ?? false;
                  });
                },
              ),
              
              SizedBox(height: 24),
              
              // 提交按钮
              ZephyrButton(
                onPressed: _submitForm,
                child: Text('提交'),
                variant: ZephyrVariant.primary,
                fullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // 表单验证通过
      print('表单数据: name=$_name, email=$_email, password=$_password, agree=$_agreeToTerms');
      
      // 显示成功提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('表单提交成功！'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
```

## 🎨 表单验证

### 基础验证
```dart
class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ZephyrInput(
            label: '用户名',
            placeholder: '请输入用户名',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入用户名';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16),
          
          ZephyrInput(
            label: '密码',
            placeholder: '请输入密码',
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入密码';
              }
              return null;
            },
          ),
          
          SizedBox(height: 24),
          
          ZephyrButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // 登录逻辑
              }
            },
            child: Text('登录'),
            variant: ZephyrVariant.primary,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}
```

### 实时验证
```dart
class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String? _emailError;
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ZephyrInput(
            label: '邮箱',
            placeholder: '请输入邮箱',
            keyboardType: TextInputType.emailAddress,
            errorText: _emailError,
            onChanged: (value) {
              setState(() {
                _email = value;
                _emailError = _validateEmail(value);
              });
            },
          ),
          
          SizedBox(height: 16),
          
          // 其他表单字段...
        ],
      ),
    );
  }
  
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  }
}
```

## 🎨 主题定制

表单组件支持完整的主题定制，可以通过 `ZephyrThemeData` 统一配置：

```dart
final theme = ZephyrThemeData(
  // 输入框主题
  inputTheme: ZephyrInputThemeData(
    defaultStyle: ZephyrInputStyle(
      backgroundColor: Colors.grey[100],
      borderColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    focusedStyle: ZephyrInputStyle(
      borderColor: Colors.blue,
      borderWidth: 2,
    ),
    errorStyle: ZephyrInputStyle(
      borderColor: Colors.red,
      errorColor: Colors.red,
    ),
  ),
  
  // 选择器主题
  selectTheme: ZephyrSelectThemeData(
    defaultStyle: ZephyrSelectStyle(
      backgroundColor: Colors.grey[100],
      borderColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  
  // 复选框主题
  checkboxTheme: ZephyrCheckboxThemeData(
    activeColor: Colors.blue,
    checkColor: Colors.white,
  ),
  
  // 单选框主题
  radioTheme: ZephyrRadioThemeData(
    activeColor: Colors.blue,
  ),
  
  // 开关主题
  switchTheme: ZephyrSwitchThemeData(
    activeColor: Colors.blue,
    inactiveColor: Colors.grey,
  ),
);

// 使用主题
ZephyrApp(
  theme: theme,
  home: FormDemo(),
)
```

## 📱 响应式设计

表单组件支持响应式设计，可以根据不同的设备尺寸自动调整样式：

```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    final isMobile = sizingInformation.deviceType == DeviceType.mobile;
    
    return Column(
      children: [
        ZephyrInput(
          placeholder: isMobile ? '姓名' : '请输入您的姓名',
          maxLines: isMobile ? 1 : 2,
          onChanged: (value) {},
        ),
        
        SizedBox(height: isMobile ? 12 : 16),
        
        ZephyrSelect<String>(
          placeholder: isMobile ? '选择' : '请选择您的选项',
          options: [
            ZephyrSelectOption(value: 'option1', label: '选项1'),
            ZephyrSelectOption(value: 'option2', label: '选项2'),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  },
)
```

## 🌐 国际化

表单组件支持国际化，可以根据不同的语言环境显示不同的文本：

```dart
MaterialApp(
  localizationsDelegates: [
    ZephyrLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('zh', 'CN'),
    const Locale('en', 'US'),
  ],
  locale: Locale('zh', 'CN'),
  home: FormDemo(),
)
```

## 🧪 测试

表单组件提供了完整的测试覆盖：

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('表单组件测试', () {
    testWidgets('输入框组件测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrInput(
            placeholder: '请输入内容',
            onChanged: (value) {},
          ),
        ),
      );
      
      expect(find.byType(ZephyrInput), findsOneWidget);
      expect(find.text('请输入内容'), findsOneWidget);
    });

    testWidgets('选择器组件测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrSelect<String>(
            placeholder: '请选择',
            options: [
              ZephyrSelectOption(value: 'option1', label: '选项1'),
              ZephyrSelectOption(value: 'option2', label: '选项2'),
            ],
            onChanged: (value) {},
          ),
        ),
      );
      
      expect(find.byType(ZephyrSelect), findsOneWidget);
      expect(find.text('请选择'), findsOneWidget);
    });

    testWidgets('复选框组件测试', (WidgetTester tester) async {
      bool checked = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrCheckbox(
            label: '同意条款',
            value: checked,
            onChanged: (value) {
              checked = value ?? false;
            },
          ),
        ),
      );
      
      await tester.tap(find.byType(ZephyrCheckbox));
      await tester.pump();
      
      expect(checked, true);
    });
  });
}
```

## 📚 相关资源

- [组件总览](../introduction) - 所有组件的概览
- [基础组件](../basic) - 基础UI组件
- [导航组件](../navigation) - 导航相关的组件
- [展示组件](../display) - 数据展示相关的组件
- [反馈组件](../feedback) - 用户反馈相关的组件
- [表单验证](../../guide/form-validation) - 表单验证指南
- [主题定制](../../guide/theme-system) - 主题定制指南

## 🤝 贡献

我们欢迎所有形式的贡献！请阅读 [贡献指南](../../guide/contributing) 了解如何参与项目开发。

## 📄 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](../../../LICENSE) 文件。