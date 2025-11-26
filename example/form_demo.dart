import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 表单组件示例
///
/// 展示所有表单组件的使用方法和功能特性
class FormDemo extends StatefulWidget {
  const FormDemo({Key? key}) : super(key: key);

  @override
  State<FormDemo> createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _agreeToTerms = false;
  String _gender = '';
  String _country = '';
  List<String> _hobbies = [];
  final List<String> _selectedSkills = [];
  double _rating = 0;
  double _price = 0;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  Color _selectedColor = Colors.blue;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('表单提交成功！'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _handleReset() {
    _formKey.currentState?.reset();
    setState(() {
      _agreeToTerms = false;
      _gender = '';
      _country = '';
      _hobbies.clear();
      _selectedSkills.clear();
      _rating = 0;
      _price = 0;
      _selectedDate = null;
      _selectedTime = null;
      _selectedColor = Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 表单组件示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ZephyrForm(
          key: _formKey,
          onSubmitted: (values) {
            debugPrint('表单数据: $values');
            _handleSubmit();
            return {};
          },
          children: [
            // 基本信息部分
            _buildSectionTitle('基本信息'),

            ZephyrFormItem(
              label: '用户名',
              name: 'username',
              required: true,
              helperText: '请输入3-20个字符的用户名',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入用户名';
                }
                if (value.length < 3 || value.length > 20) {
                  return '用户名长度应在3-20个字符之间';
                }
                return null;
              },
              child: ZephyrInput(
                placeholder: '请输入用户名',
                controller: _usernameController,
                prefixIcon: Icons.person,
                maxLength: 20,
              ),
            ),

            ZephyrFormItem(
              label: '邮箱',
              name: 'email',
              required: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入邮箱地址';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return '请输入有效的邮箱地址';
                }
                return null;
              },
              child: ZephyrInput(
                placeholder: '请输入邮箱地址',
                controller: _emailController,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),

            ZephyrFormItem(
              label: '密码',
              name: 'password',
              required: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入密码';
                }
                if (value.length < 6) {
                  return '密码长度不能少于6位';
                }
                return null;
              },
              child: ZephyrInput(
                placeholder: '请输入密码',
                controller: _passwordController,
                prefixIcon: Icons.lock,
                obscureText: true,
                maxLength: 20,
              ),
            ),

            // 数字输入部分
            _buildSectionTitle('数字输入'),

            ZephyrFormItem(
              label: '年龄',
              name: 'age',
              helperText: '请输入您的年龄（18-100岁）',
              child: ZephyrInputNumber(
                placeholder: '请输入年龄',
                controller: _ageController,
                min: 18,
                max: 100,
                step: 1,
                precision: 0,
                prefix: const Icon(Icons.cake, size: 20),
                suffix: const Text('岁'),
              ),
            ),

            ZephyrFormItem(
              label: '价格',
              name: 'price',
              helperText: '请输入价格（0-10000元）',
              child: ZephyrInputNumber(
                placeholder: '请输入价格',
                initialValue: _price,
                min: 0,
                max: 10000,
                step: 0.01,
                precision: 2,
                prefix: const Text('¥'),
                format: (value) => '¥${value.toStringAsFixed(2)}',
                onChanged: (value) => setState(() => _price = value),
              ),
            ),

            // 选择器部分
            _buildSectionTitle('选择器'),

            ZephyrFormItem(
              label: '性别',
              name: 'gender',
              required: true,
              child: ZephyrRadioGroup(
                items: const [
                  ZephyrRadioItem(value: 'male', label: '男'),
                  ZephyrRadioItem(value: 'female', label: '女'),
                  ZephyrRadioItem(value: 'other', label: '其他'),
                ],
                value: _gender,
                onChanged: (value) => setState(() => _gender = value?.toString() ?? ''),
                direction: ZephyrRadioDirection.horizontal,
              ),
            ),

            ZephyrFormItem(
              label: '国家',
              name: 'country',
              helperText: '请选择您的国家',
              child: ZephyrSelect<String>(
                placeholder: '请选择国家',
                value: _country.isEmpty ? null : _country,
                options: const [
                  ZephyrSelectOption(value: 'cn', label: '中国'),
                  ZephyrSelectOption(value: 'us', label: '美国'),
                  ZephyrSelectOption(value: 'uk', label: '英国'),
                  ZephyrSelectOption(value: 'jp', label: '日本'),
                  ZephyrSelectOption(value: 'kr', label: '韩国'),
                ],
                onChanged: (value) => setState(() => _country = value ?? ''),
              ),
            ),

            ZephyrFormItem(
              label: '爱好',
              name: 'hobbies',
              helperText: '请选择您的爱好（可多选）',
              child: ZephyrCheckboxGroup(
                items: const [
                  ZephyrCheckboxItem(value: 'reading', label: '阅读'),
                  ZephyrCheckboxItem(value: 'music', label: '音乐'),
                  ZephyrCheckboxItem(value: 'sports', label: '运动'),
                  ZephyrCheckboxItem(value: 'travel', label: '旅行'),
                  ZephyrCheckboxItem(value: 'cooking', label: '烹饪'),
                ],
                value: _hobbies,
                onChanged: (values) => setState(() => _hobbies = values),
                direction: Axis.horizontal,
              ),
            ),

            ZephyrFormItem(
              label: '评分',
              name: 'rating',
              helperText: '请为我们评分',
              child: ZephyrRating(
                value: _rating,
                onChanged: (value) => setState(() => _rating = value),
                maxValue: 5,
                size: 24,
              ),
            ),

            // 日期时间部分
            _buildSectionTitle('日期时间'),

            ZephyrFormItem(
              label: '出生日期',
              name: 'birthdate',
              helperText: '请选择您的出生日期',
              child: ZephyrDatePicker(
                initialDate: _selectedDate,
                onDateSelected: (date) => setState(() => _selectedDate = date),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ),
            ),

            ZephyrFormItem(
              label: '预约时间',
              name: 'appointment_time',
              helperText: '请选择预约时间',
              child: ZephyrTimePicker(
                initialTime: _selectedTime,
                onTimeSelected: (time) => setState(() => _selectedTime = time),
              ),
            ),

            // 颜色选择器
            _buildSectionTitle('颜色选择'),

            ZephyrFormItem(
              label: '主题颜色',
              name: 'theme_color',
              helperText: '请选择您喜欢的主题颜色',
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ZephyrColorPicker(
                  theme: ZephyrColorPickerTheme.light(),
                  initialColor: _selectedColor,
                  onColorChanged: (color) =>
                      setState(() => _selectedColor = color),
                  showPreview: true,
                ),
              ),
            ),

            // 其他组件
            _buildSectionTitle('其他组件'),

            ZephyrFormItem(
              label: '手机号码',
              name: 'phone',
              helperText: '请输入您的手机号码',
              child: ZephyrInput(
                placeholder: '请输入手机号码',
                controller: _phoneController,
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                maxLength: 11,
              ),
            ),

            ZephyrFormItem(
              label: '个人简介',
              name: 'bio',
              helperText: '请简单介绍一下自己',
              child: ZephyrTextArea(
                placeholder: '请输入个人简介...',
                maxLength: 200,
                maxLines: 4,
                onChanged: (value) => debugPrint('简介: $value'),
              ),
            ),

            ZephyrFormItem(
              label: '电子签名',
              name: 'signature',
              helperText: '请在此处签名',
              child: ZephyrSignaturePad(
                onSignatureChanged: (signature) {
                  debugPrint('Signature updated');
                },
                height: 150,
              ),
            ),

            ZephyrFormItem(
              label: '同意条款',
              name: 'terms',
              child: Row(
                children: [
                  ZephyrCheckbox(
                    value: _agreeToTerms,
                    onChanged: (value) =>
                        setState(() => _agreeToTerms = value),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('我已阅读并同意用户协议和隐私政策'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 提交按钮
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('提交表单'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _handleReset,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('重置表单'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}
