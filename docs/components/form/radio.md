# ZephyrRadio 单选框组件

单选框组件是一个基础的选择控件，用于在多个选项中选择一个。提供了简洁的勾选体验，支持标签、禁用状态、自定义样式等功能。

## 🎯 组件概述

### 特性
- **单选功能**: 支持在多个选项中选择一个
- **灵活的布局**: 支持水平和垂直布局
- **自定义样式**: 支持自定义颜色、大小等样式
- **状态管理**: 完整的选中、禁用、只读状态支持
- **主题适配**: 完整的主题系统支持

### 适用场景
- 性别选择
- 支付方式选择
- 配送方式选择
- 通知偏好设置
- 报表类型选择
- 语言选择

## 🚀 基础用法

### 基本单选框

```dart
ZephyrRadio<String>(
  value: 'male',
  groupValue: _gender,
  label: '男',
  onChanged: (value) => setState(() => _gender = value),
)
```

### 单选框组

```dart
ZephyrRadioGroup<String>(
  label: '性别',
  options: [
    ZephyrRadioOption(value: 'male', label: '男'),
    ZephyrRadioOption(value: 'female', label: '女'),
    ZephyrRadioOption(value: 'other', label: '其他'),
  ],
  selectedValue: _gender,
  onChanged: (value) => setState(() => _gender = value),
)
```

### 带描述的单选框

```dart
ZephyrRadio<String>(
  value: 'email',
  groupValue: _notificationMethod,
  label: '邮件通知',
  description: '通过邮件接收重要通知和更新信息',
  onChanged: (value) => setState(() => _notificationMethod = value),
)
```

### 禁用状态的单选框

```dart
ZephyrRadio<String>(
  value: 'disabled',
  groupValue: _selectedValue,
  label: '禁用选项',
  enabled: false,
  onChanged: (value) => setState(() => _selectedValue = value),
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    ZephyrRadio<String>(
      value: 'option1',
      groupValue: _selectedValue,
      label: '默认样式',
      onChanged: (value) => setState(() => _selectedValue = value),
    ),
    SizedBox(height: 16),
    ZephyrRadio<String>(
      value: 'option2',
      groupValue: _selectedValue,
      label: '自定义颜色',
      activeColor: Colors.blue,
      onChanged: (value) => setState(() => _selectedValue = value),
    ),
    SizedBox(height: 16),
    ZephyrRadio<String>(
      value: 'option3',
      groupValue: _selectedValue,
      label: '大尺寸',
      size: 24,
      onChanged: (value) => setState(() => _selectedValue = value),
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
    ZephyrRadioGroup<String>(
      options: [
        ZephyrRadioOption(value: 'option1', label: '选项1'),
        ZephyrRadioOption(value: 'option2', label: '选项2'),
        ZephyrRadioOption(value: 'option3', label: '选项3'),
      ],
      direction: Axis.horizontal,
      spacing: 16,
      onChanged: (values) => print('选择: $values'),
    ),
    SizedBox(height: 24),
    Text('垂直布局'),
    SizedBox(height: 8),
    ZephyrRadioGroup<String>(
      options: [
        ZephyrRadioOption(value: 'option1', label: '选项1'),
        ZephyrRadioOption(value: 'option2', label: '选项2'),
        ZephyrRadioOption(value: 'option3', label: '选项3'),
      ],
      direction: Axis.vertical,
      spacing: 8,
      onChanged: (values) => print('选择: $values'),
    ),
  ],
)
```

## 🔧 高级用法

### 带验证的单选框

```dart
class ValidatedRadio extends StatefulWidget {
  @override
  _ValidatedRadioState createState() => _ValidatedRadioState();
}

class _ValidatedRadioState extends State<ValidatedRadio> {
  String? _selectedGender;
  String? _errorText;

  void _validateSelection(String? value) {
    setState(() {
      _selectedGender = value;
      _errorText = value == null ? '请选择性别' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrRadioGroup<String>(
          label: '性别',
          options: [
            ZephyrRadioOption(value: 'male', label: '男'),
            ZephyrRadioOption(value: 'female', label: '女'),
            ZephyrRadioOption(value: 'other', label: '其他'),
          ],
          selectedValue: _selectedGender,
          onChanged: _validateSelection,
          errorText: _errorText,
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _selectedGender != null ? _submitForm : null,
          child: Text('提交'),
        ),
      ],
    );
  }
}
```

### 动态选项组

```dart
class DynamicRadioGroup extends StatefulWidget {
  @override
  _DynamicRadioGroupState createState() => _DynamicRadioGroupState();
}

class _DynamicRadioGroupState extends State<DynamicRadioGroup> {
  List<PaymentMethod> _paymentMethods = [];
  String? _selectedMethod;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
  }

  void _loadPaymentMethods() {
    setState(() => _isLoading = true);
    
    // 模拟加载支付方式数据
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _paymentMethods = [
          PaymentMethod(
            id: 'alipay',
            name: '支付宝',
            icon: Icons.account_balance_wallet,
            description: '使用支付宝快速支付',
          ),
          PaymentMethod(
            id: 'wechat',
            name: '微信支付',
            icon: Icons.wechat,
            description: '使用微信钱包支付',
          ),
          PaymentMethod(
            id: 'bank',
            name: '银行卡',
            icon: Icons.credit_card,
            description: '使用银行卡支付',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择支付方式',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(),
          )
        else
          ..._paymentMethods.map((method) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: ZephyrRadio<String>(
                value: method.id,
                groupValue: _selectedMethod,
                label: method.name,
                description: method.description,
                prefixIcon: Icon(method.icon),
                onChanged: (value) => setState(() => _selectedMethod = value),
              ),
            );
          }).toList(),
        if (_selectedMethod != null)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: _proceedToPayment,
              child: Text('继续支付'),
            ),
          ),
      ],
    );
  }

  void _proceedToPayment() {
    final selectedMethod = _paymentMethods.firstWhere(
      (method) => method.id == _selectedMethod,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已选择支付方式：${selectedMethod.name}')),
    );
  }
}

class PaymentMethod {
  final String id;
  final String name;
  final IconData icon;
  final String description;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}
```

### 带图标的单选框

```dart
class IconRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final String label;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Color? activeColor;

  const IconRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected 
                ? (activeColor ?? Colors.blue) 
                : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected 
              ? (activeColor ?? Colors.blue).withOpacity(0.1) 
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected 
                      ? (activeColor ?? Colors.blue) 
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeColor ?? Colors.blue,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12),
            Icon(
              icon,
              color: isSelected 
                  ? (activeColor ?? Colors.blue) 
                  : Colors.grey[600],
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected 
                    ? FontWeight.w500 
                    : FontWeight.normal,
                color: isSelected 
                    ? (activeColor ?? Colors.blue) 
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 分组单选框

```dart
class GroupedRadio extends StatefulWidget {
  @override
  _GroupedRadioState createState() => _GroupedRadioState();
}

class _GroupedRadioState extends State<GroupedRadio> {
  String? _selectedCategory;
  String? _selectedSubcategory;

  final Map<String, List<String>> _subcategories = {
    'electronics': ['手机', '电脑', '平板'],
    'clothing': ['男装', '女装', '童装'],
    'food': ['水果', '蔬菜', '肉类'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '商品分类',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ZephyrRadioGroup<String>(
          label: '主分类',
          options: [
            ZephyrRadioOption(value: 'electronics', label: '电子产品'),
            ZephyrRadioOption(value: 'clothing', label: '服装'),
            ZephyrRadioOption(value: 'food', label: '食品'),
          ],
          selectedValue: _selectedCategory,
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
              _selectedSubcategory = null;
            });
          },
        ),
        if (_selectedCategory != null) ...[
          SizedBox(height: 16),
          ZephyrRadioGroup<String>(
            label: '子分类',
            options: _subcategories[_selectedCategory!]!
                .map((sub) => ZephyrRadioOption(value: sub, label: sub))
                .toList(),
            selectedValue: _selectedSubcategory,
            onChanged: (value) => setState(() => _selectedSubcategory = value),
          ),
        ],
        if (_selectedCategory != null && _selectedSubcategory != null)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              '已选择：$_selectedCategory > $_selectedSubcategory',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrRadio()

```dart
const ZephyrRadio<T>({
  Key? key,
  required T value,
  required T? groupValue,
  required String label,
  String? description,
  ValueChanged<T?>? onChanged,
  bool enabled = true,
  bool readOnly = false,
  Color? activeColor,
  Color? focusColor,
  double? size,
  Widget? prefixIcon,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? labelStyle,
  TextStyle? descriptionStyle,
  String? errorText,
  TextStyle? errorTextStyle,
  String? semanticLabel,
})
```

**参数说明：**
- `value`: 当前选项的值
- `groupValue`: 当前选中的值
- `label`: 单选框标签
- `description`: 描述文本
- `onChanged`: 变化回调
- `enabled`: 是否启用
- `readOnly`: 是否只读
- `activeColor`: 选中时的颜色
- `focusColor`: 聚焦时的颜色
- `size`: 单选框大小
- `prefixIcon`: 前缀图标
- `contentPadding`: 内容内边距
- `labelStyle`: 标签样式
- `descriptionStyle`: 描述文本样式
- `errorText`: 错误文本
- `errorTextStyle`: 错误文本样式
- `semanticLabel`: 语义标签

#### ZephyrRadioGroup()

```dart
const ZephyrRadioGroup<T>({
  Key? key,
  String? label,
  required List<ZephyrRadioOption<T>> options,
  T? selectedValue,
  ValueChanged<T?>? onChanged,
  Axis direction = Axis.vertical,
  double spacing = 8,
  bool enabled = true,
  bool readOnly = false,
  Color? activeColor,
  double? size,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? labelStyle,
  String? errorText,
  String? semanticLabel,
})
```

### ZephyrRadioOption

```dart
const ZephyrRadioOption<T>({
  required T value,
  required String label,
  String? description,
  bool enabled = true,
  Widget? prefixIcon,
})
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrRadioTheme(
        activeColor: Colors.blue,
        focusColor: Colors.blue.withOpacity(0.2),
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
- `focusColor`: 聚焦时的颜色
- `disabledColor`: 禁用时的颜色
- `disabledActiveColor`: 禁用且选中时的颜色
- `size`: 单选框大小
- `labelStyle`: 标签样式
- `descriptionStyle`: 描述文本样式
- `errorTextStyle`: 错误文本样式
- `contentPadding`: 内容内边距

## 🏆 最佳实践

### 1. 清晰的标签设计

```dart
// ✅ 好的做法：标签简洁明了
ZephyrRadio<String>(
  value: 'male',
  groupValue: _gender,
  label: '男',
  onChanged: (value) => setState(() => _gender = value),
)

// ✅ 好的做法：为复杂选项添加描述
ZephyrRadio<String>(
  value: 'email',
  groupValue: _notificationMethod,
  label: '邮件通知',
  description: '通过邮件接收重要通知和更新信息',
  onChanged: (value) => setState(() => _notificationMethod = value),
)

// ❌ 避免的做法：标签过于复杂
ZephyrRadio<String>(
  value: 'complex',
  groupValue: _selectedValue,
  label: '这是一个非常长的选项标签，可能影响用户体验',
  onChanged: (value) => setState(() => _selectedValue = value),
)
```

### 2. 合理的默认值

```dart
// ✅ 好的做法：根据业务需求设置默认值
ZephyrRadioGroup<String>(
  options: [
    ZephyrRadioOption(value: 'opt_in', label: '订阅'),
    ZephyrRadioOption(value: 'opt_out', label: '取消订阅'),
  ],
  selectedValue: 'opt_out',  // 默认不订阅，保护用户隐私
  onChanged: (value) => setState(() => _selectedValue = value),
)

ZephyrRadioGroup<String>(
  options: [
    ZephyrRadioOption(value: 'light', label: '浅色主题'),
    ZephyrRadioOption(value: 'dark', label: '深色主题'),
  ],
  selectedValue: 'light',  // 默认浅色主题
  onChanged: (value) => setState(() => _selectedValue = value),
)
```

### 3. 分组管理

```dart
// ✅ 好的做法：相关选项分组显示
Column(
  children: [
    Text('通知设置', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    SizedBox(height: 16),
    ZephyrRadioGroup<String>(
      label: '通知方式',
      options: [
        ZephyrRadioOption(value: 'push', label: '推送通知'),
        ZephyrRadioOption(value: 'email', label: '邮件通知'),
        ZephyrRadioOption(value: 'sms', label: '短信通知'),
      ],
      selectedValue: _notificationMethod,
      onChanged: (value) => setState(() => _notificationMethod = value),
    ),
    SizedBox(height: 24),
    Text('主题设置', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    SizedBox(height: 16),
    ZephyrRadioGroup<String>(
      label: '主题模式',
      options: [
        ZephyrRadioOption(value: 'light', label: '浅色主题'),
        ZephyrRadioOption(value: 'dark', label: '深色主题'),
        ZephyrRadioOption(value: 'auto', label: '跟随系统'),
      ],
      selectedValue: _themeMode,
      onChanged: (value) => setState(() => _themeMode = value),
    ),
  ],
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrRadio<String>(
  value: 'male',
  groupValue: _gender,
  label: '男',
  semanticLabel: '性别选择-男性',
  onChanged: (value) => setState(() => _gender = value),
)

// ✅ 好的做法：提供清晰的选项描述
ZephyrRadio<String>(
  value: 'analytics',
  groupValue: _dataSharing,
  label: '分享使用数据',
  description: '帮助我们改进产品体验，数据将匿名处理',
  onChanged: (value) => setState(() => _dataSharing = value),
)
```

### 5. 性能优化

```dart
// ✅ 好的做法：使用const构造函数
const options = [
  ZephyrRadioOption(value: 'option1', label: '选项1'),
  ZephyrRadioOption(value: 'option2', label: '选项2'),
];

ZephyrRadioGroup<String>(
  options: options,
  selectedValue: _selectedValue,
  onChanged: (value) => setState(() => _selectedValue = value),
)

// ✅ 好的做法：动态加载选项
class DynamicRadioGroup extends StatefulWidget {
  @override
  _DynamicRadioGroupState createState() => _DynamicRadioGroupState();
}

class _DynamicRadioGroupState extends State<DynamicRadioGroup> {
  List<ZephyrRadioOption<String>> _options = [];
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
    return ZephyrRadioGroup<String>(
      options: _options,
      loading: _isLoading,
      onChanged: (value) => setState(() => _selectedValue = value),
    );
  }
}
```

## 🔄 相关组件

- **ZephyrCheckbox**: 复选框
- **ZephyrSwitch**: 开关组件
- **ZephyrSelect**: 选择器组件
- **ZephyrFormBuilder**: 表单构建器

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本单选框功能
- ✅ 支持单选框组
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/form/radio/`
**示例路径**: `example/lib/components/radio_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日