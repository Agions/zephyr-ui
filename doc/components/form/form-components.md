# ZephyrUI 表单组件使用手册

## 概述

ZephyrUI 表单组件提供了完整的表单解决方案，包括各种输入控件、验证功能和表单构建器，帮助开发者快速构建功能完善的表单界面。

## 组件列表

### 1. ZInputField 组件

#### 简介
ZInputField 是一个功能丰富的输入框组件，支持多种输入类型和验证功能。

#### 基本用法
```dart
import 'package:zephyr_ui/zephyr_ui.dart';

// 基本输入框
ZInputField(
  label: '用户名',
  placeholder: '请输入用户名',
  onChanged: (value) {},
),

// 带验证的输入框
ZInputField(
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
),

// 密码输入框
ZInputField(
  label: '密码',
  placeholder: '请输入密码',
  obscureText: true,
  suffixIcon: Icon(Icons.visibility),
),
```

#### 属性说明
- `label`: 输入框标签
- `placeholder`: 占位符文本
- `value`: 输入值
- `onChanged`: 值变化回调
- `validator`: 验证函数
- `obscureText`: 是否隐藏文本
- `enabled`: 是否启用
- `readOnly`: 是否只读
- `errorText`: 错误文本
- `helperText`: 帮助文本
- `prefixIcon`: 前缀图标
- `suffixIcon`: 后缀图标
- `keyboardType`: 键盘类型
- `textInputAction`: 键盘动作

### 2. ZTextArea 组件

#### 简介
ZTextArea 是一个多行文本输入组件，适用于长文本输入场景。

#### 基本用法
```dart
// 基本文本域
ZTextArea(
  label: '描述',
  placeholder: '请输入详细描述...',
  minLines: 3,
  maxLines: 5,
  onChanged: (value) {},
),

// 带字符计数的文本域
ZTextArea(
  label: '个人简介',
  placeholder: '请输入个人简介...',
  maxLength: 200,
  showCharacterCount: true,
  onChanged: (value) {},
),
```

#### 属性说明
- `minLines`: 最小行数
- `maxLines`: 最大行数
- `maxLength`: 最大字符数
- `showCharacterCount`: 是否显示字符计数
- `expands`: 是否自动扩展

### 3. ZSelect 组件

#### 简介
ZSelect 是一个选择器组件，支持下拉选择、多选等功能。

#### 基本用法
```dart
// 基本选择器
ZSelect<String>(
  label: '性别',
  placeholder: '请选择性别',
  items: ['男', '女', '其他'],
  onChanged: (value) {},
),

// 带图标的选项
ZSelect<String>(
  label: '国家',
  placeholder: '请选择国家',
  items: [
    ZSelectItem(
      value: 'CN',
      label: '中国',
      icon: Icon(Icons.flag),
    ),
    ZSelectItem(
      value: 'US',
      label: '美国',
      icon: Icon(Icons.flag),
    ),
  ],
  onChanged: (value) {},
),

// 多选选择器
ZSelect<String>(
  label: '兴趣爱好',
  placeholder: '请选择兴趣爱好',
  items: ['读书', '运动', '音乐', '旅行'],
  multiple: true,
  onChanged: (values) {},
),
```

#### 属性说明
- `items`: 选项列表
- `value`: 选中值
- `onChanged`: 选择回调
- `multiple`: 是否多选
- `disabled`: 是否禁用
- `clearable`: 是否可清除
- `searchable`: 是否可搜索

### 4. ZCheckbox 组件

#### 简介
ZCheckbox 是一个复选框组件，支持单选和多选。

#### 基本用法
```dart
// 基本复选框
ZCheckbox(
  value: true,
  onChanged: (value) {},
  label: '我同意服务条款',
),

// 禁用状态
ZCheckbox(
  value: false,
  onChanged: null,
  label: '禁用状态',
  disabled: true,
),

// 复选框组
Column(
  children: [
    ZCheckbox(
      value: selectedOptions.contains('选项1'),
      onChanged: (value) {
        setState(() {
          if (value!) {
            selectedOptions.add('选项1');
          } else {
            selectedOptions.remove('选项1');
          }
        });
      },
      label: '选项1',
    ),
    ZCheckbox(
      value: selectedOptions.contains('选项2'),
      onChanged: (value) {
        setState(() {
          if (value!) {
            selectedOptions.add('选项2');
          } else {
            selectedOptions.remove('选项2');
          }
        });
      },
      label: '选项2',
    ),
  ],
),
```

### 5. ZRadio 组件

#### 简介
ZRadio 是一个单选按钮组件，用于在多个选项中选择一个。

#### 基本用法
```dart
String selectedOption = '选项1';

// 单选按钮组
Column(
  children: [
    ZRadio(
      value: '选项1',
      groupValue: selectedOption,
      onChanged: (value) {
        setState(() {
          selectedOption = value!;
        });
      },
      label: '选项1',
    ),
    ZRadio(
      value: '选项2',
      groupValue: selectedOption,
      onChanged: (value) {
        setState(() {
          selectedOption = value!;
        });
      },
      label: '选项2',
    ),
  ],
),
```

### 6. ZSwitch 组件

#### 简介
ZSwitch 是一个开关组件，用于二选一的状态切换。

#### 基本用法
```dart
// 基本开关
ZSwitch(
  value: true,
  onChanged: (value) {},
  label: '启用通知',
),

// 带描述的开关
ZSwitch(
  value: false,
  onChanged: (value) {},
  label: '自动更新',
  description: '启用后将自动检查更新',
),
```

### 7. ZSlider 组件

#### 简介
ZSlider 是一个滑块组件，用于选择范围内的数值。

#### 基本用法
```dart
// 基本滑块
ZSlider(
  value: 50,
  onChanged: (value) {},
  min: 0,
  max: 100,
),

// 带刻度的滑块
ZSlider(
  value: 25,
  onChanged: (value) {},
  min: 0,
  max: 100,
  divisions: 4,
  label: '音量',
),

// 范围滑块
ZSlider(
  values: RangeValues(20, 80),
  onChanged: (values) {},
  min: 0,
  max: 100,
),
```

### 8. ZDatePicker 组件

#### 简介
ZDatePicker 是一个日期选择器组件，支持多种日期选择模式。

#### 基本用法
```dart
// 日期选择器
ZDatePicker(
  label: '出生日期',
  placeholder: '请选择日期',
  onChanged: (date) {},
),

// 日期范围选择器
ZDatePicker(
  label: '日期范围',
  placeholder: '请选择日期范围',
  mode: ZDatePickerMode.range,
  onChanged: (range) {},
),

// 时间选择器
ZDatePicker(
  label: '时间',
  placeholder: '请选择时间',
  mode: ZDatePickerMode.time,
  onChanged: (time) {},
),
```

### 9. ZTimePicker 组件

#### 简介
ZTimePicker 是一个时间选择器组件，支持12小时和24小时制。

#### 基本用法
```dart
// 24小时制时间选择器
ZTimePicker(
  label: '开始时间',
  placeholder: '请选择时间',
  mode: ZephyrTimePickerMode.hour24,
  onChanged: (time) {},
),

// 12小时制时间选择器
ZTimePicker(
  label: '结束时间',
  placeholder: '请选择时间',
  mode: ZephyrTimePickerMode.hour12,
  onChanged: (time) {},
),

// 带间隔的时间选择器
ZTimePicker(
  label: '预约时间',
  placeholder: '请选择时间',
  minuteInterval: 15,
  onChanged: (time) {},
),
```

### 10. ZRating 组件

#### 简介
ZRating 是一个评分组件，用于用户评分和反馈。

#### 基本用法
```dart
// 基本评分
ZRating(
  value: 4,
  onChanged: (value) {},
),

// 只读评分
ZRating(
  value: 4.5,
  readOnly: true,
),

// 自定义评分
ZRating(
  value: 3,
  maxRating: 10,
  itemSize: 20,
  itemCount: 5,
  onChanged: (value) {},
),
```

### 11. ZFormBuilder 组件

#### 简介
ZFormBuilder 是一个表单构建器组件，提供了声明式的表单构建方式。

#### 基本用法
```dart
ZFormBuilder(
  onChanged: () {
    // 表单值变化时的处理
  },
  child: Column(
    children: [
      ZInputField(
        name: 'username',
        label: '用户名',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '请输入用户名';
          }
          return null;
        },
      ),
      ZInputField(
        name: 'email',
        label: '邮箱',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '请输入邮箱';
          }
          return null;
        },
      ),
      ZButton(
        text: '提交',
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // 提交表单
          }
        },
      ),
    ],
  ),
),
```

## 表单验证

### 内置验证规则
```dart
// 必填验证
validator: (value) => value?.isEmpty ?? true ? '此字段为必填项' : null,

// 邮箱验证
validator: (value) {
  if (value == null || value.isEmpty) return '请输入邮箱';
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return '请输入有效的邮箱地址';
  }
  return null;
},

// 密码验证
validator: (value) {
  if (value == null || value.isEmpty) return '请输入密码';
  if (value.length < 6) return '密码长度不能少于6位';
  return null;
},

// 手机号验证
validator: (value) {
  if (value == null || value.isEmpty) return '请输入手机号';
  if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
    return '请输入有效的手机号';
  }
  return null;
},
```

### 自定义验证规则
```dart
validator: (value) {
  // 自定义验证逻辑
  if (value == null || value.isEmpty) {
    return '此字段为必填项';
  }
  
  // 添加业务验证规则
  if (value.length < 3) {
    return '长度不能少于3个字符';
  }
  
  if (value.length > 50) {
    return '长度不能超过50个字符';
  }
  
  return null;
},
```

## 最佳实践

### 1. 表单布局
- 使用合适的间距和对齐
- 将相关的字段分组
- 提供清晰的标签和说明

### 2. 用户体验
- 提供即时验证反馈
- 使用合适的键盘类型
- 支持自动完成和纠错

### 3. 性能优化
- 使用 `const` 构造函数
- 避免不必要的重建
- 使用 `Key` 优化表单状态

### 4. 可访问性
- 为所有输入字段提供标签
- 使用语义化的HTML结构
- 支持键盘导航

## 常见问题

### Q: 如何处理表单的初始值？
A: 使用 `initialValue` 参数设置初始值。

### Q: 如何实现动态表单？
A: 使用 `FormBuilder` 和动态生成字段的方式。

### Q: 如何处理复杂的验证逻辑？
A: 使用自定义验证函数或创建验证器类。

## 相关资源

- [API 参考文档](../api/form-components.md)
- [表单验证指南](../guides/form-validation.md)
- [最佳实践](../guides/best-practices.md)
- [示例代码](../../example/lib/components/form_components_demo.dart)