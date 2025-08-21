/// ZephyrUI 表单组件示例
///
/// 展示所有表单组件的使用方法和效果。
library form_components_demo;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class FormComponentsDemo extends StatelessWidget {
  const FormComponentsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 表单组件演示'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('输入框组件'),
            const SizedBox(height: 16),
            _buildInputDemo(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('选择器组件'),
            const SizedBox(height: 16),
            _buildSelectDemo(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('复选框组件'),
            const SizedBox(height: 16),
            _buildCheckboxDemo(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('单选框组件'),
            const SizedBox(height: 16),
            _buildRadioDemo(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('开关组件'),
            const SizedBox(height: 16),
            _buildSwitchDemo(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('滑块组件'),
            const SizedBox(height: 16),
            _buildSliderDemo(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('日期选择器'),
            const SizedBox(height: 16),
            _buildDatePickerDemo(context),
            const SizedBox(height: 32),
            
            _buildSectionTitle('时间选择器'),
            const SizedBox(height: 16),
            _buildTimePickerDemo(context),
            const SizedBox(height: 32),
            
            _buildSectionTitle('评分组件'),
            const SizedBox(height: 16),
            _buildRatingDemo(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInputDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ZephyrInput(
          label: '用户名',
          placeholder: '请输入用户名',
          helperText: '用户名长度为3-20个字符',
        ),
        const SizedBox(height: 16),
        const ZephyrInput.password(
          label: '密码',
          placeholder: '请输入密码',
        ),
        const SizedBox(height: 16),
        const ZephyrInput.email(
          label: '邮箱',
          placeholder: '请输入邮箱地址',
        ),
        const SizedBox(height: 16),
        const ZephyrInput.textarea(
          label: '个人简介',
          placeholder: '请输入个人简介',
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildSelectDemo() {
    final options = [
      const ZephyrSelectOption(value: 'beijing', label: '北京'),
      const ZephyrSelectOption(value: 'shanghai', label: '上海'),
      const ZephyrSelectOption(value: 'guangzhou', label: '广州'),
      const ZephyrSelectOption(value: 'shenzhen', label: '深圳'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrSelect<String>(
          label: '选择城市',
          placeholder: '请选择城市',
          options: options,
          onChanged: (value) => print('Selected: $value'),
        ),
        const SizedBox(height: 16),
        ZephyrSelect<String>(
          label: '可搜索选择',
          placeholder: '请选择城市（可搜索）',
          options: options,
          searchable: true,
          clearable: true,
          onChanged: (value) => print('Selected: $value'),
        ),
      ],
    );
  }

  Widget _buildCheckboxDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrCheckbox(
          value: true,
          onChanged: (value) => print('Checkbox changed: $value'),
          label: '我同意服务条款',
          sublabel: '请仔细阅读服务条款',
        ),
        const SizedBox(height: 16),
        ZephyrCheckbox(
          value: false,
          onChanged: (value) => print('Checkbox changed: $value'),
          label: '订阅邮件通知',
          sublabel: '我们会定期发送产品更新信息',
        ),
        const SizedBox(height: 16),
        const Text('复选框组：'),
        const SizedBox(height: 8),
        ZephyrCheckboxGroup(
          items: const [
            ZephyrCheckboxItem(value: 'apple', label: '苹果'),
            ZephyrCheckboxItem(value: 'banana', label: '香蕉'),
            ZephyrCheckboxItem(value: 'orange', label: '橙子'),
          ],
          value: const ['apple'],
          onChanged: (values) => print('Selected fruits: $values'),
        ),
      ],
    );
  }

  Widget _buildRadioDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ZephyrRadio<bool>(
          value: true,
          groupValue: true,
          label: '选项1',
          sublabel: '这是第一个选项',
        ),
        const SizedBox(height: 16),
        const ZephyrRadio<bool>(
          value: false,
          groupValue: true,
          label: '选项2',
          sublabel: '这是第二个选项',
        ),
        const SizedBox(height: 16),
        const Text('单选框组：'),
        const SizedBox(height: 8),
        ZephyrRadioGroup<String>(
          items: const [
            ZephyrRadioItem(value: 'male', label: '男'),
            ZephyrRadioItem(value: 'female', label: '女'),
            ZephyrRadioItem(value: 'other', label: '其他'),
          ],
          value: 'male',
          onChanged: (value) => print('Selected gender: $value'),
        ),
      ],
    );
  }

  Widget _buildSwitchDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('启用通知', style: TextStyle(fontSize: 16)),
                  const Text('接收应用通知', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            ZephyrSwitch(
              value: true,
              onChanged: (value) => print('Switch changed: $value'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('深色模式', style: TextStyle(fontSize: 16)),
                  const Text('切换应用主题', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            ZephyrSwitch(
              value: false,
              onChanged: (value) => print('Switch changed: $value'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSliderDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('标准滑块'),
        const SizedBox(height: 8),
        ZephyrSlider(
          value: 0.5,
          onChanged: (value) => print('Slider value: $value'),
        ),
        const SizedBox(height: 16),
        const Text('离散滑块'),
        const SizedBox(height: 8),
        ZephyrSlider(
          value: 3,
          min: 0,
          max: 10,
          type: ZephyrSliderType.discrete,
          divisions: 10,
          onChanged: (value) => print('Slider value: $value'),
        ),
        const SizedBox(height: 16),
        const Text('带指示器的滑块'),
        const SizedBox(height: 8),
        ZephyrSlider(
          value: 75,
          min: 0,
          max: 100,
          type: ZephyrSliderType.indicator,
          onChanged: (value) => print('Slider value: $value'),
        ),
      ],
    );
  }

  Widget _buildDatePickerDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: const Text('选择日期'),
                content: SizedBox(
                  width: 400,
                  height: 400,
                  child: ZephyrDatePicker(
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    initialDate: DateTime.now(),
                    onDateSelected: (date) {
                      print('Selected date: $date');
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text('取消'),
                  ),
                ],
              ),
            );
          },
          child: const Text('选择日期'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: const Text('选择日期范围'),
                content: SizedBox(
                  width: 400,
                  height: 400,
                  child: ZephyrDatePicker(
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    initialStartDate: DateTime.now().subtract(const Duration(days: 7)),
                    initialEndDate: DateTime.now(),
                    mode: ZephyrDatePickerMode.range,
                    onDateRangeSelected: (start, end) {
                      print('Selected range: $start - $end');
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text('取消'),
                  ),
                ],
              ),
            );
          },
          child: const Text('选择日期范围'),
        ),
      ],
    );
  }

  Widget _buildTimePickerDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () async {
            final time = await showZephyrTimePicker(
              context: context,
              initialTime: const TimeOfDay(hour: 14, minute: 30),
            );
            if (time != null) {
              print('Selected time: $time');
            }
          },
          child: const Text('选择时间（24小时制）'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            final time = await showZephyrTimePicker(
              context: context,
              initialTime: const TimeOfDay(hour: 2, minute: 30),
              mode: ZephyrTimePickerMode.hour12,
            );
            if (time != null) {
              print('Selected time: $time');
            }
          },
          child: const Text('选择时间（12小时制）'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            final time = await showZephyrTimePicker(
              context: context,
              initialTime: const TimeOfDay(hour: 14, minute: 30),
              minuteInterval: 15,
            );
            if (time != null) {
              print('Selected time: $time');
            }
          },
          child: const Text('选择时间（15分钟间隔）'),
        ),
      ],
    );
  }

  Widget _buildRatingDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('评分组件'),
        const SizedBox(height: 8),
        ZephyrRating(
          value: 4,
          maxValue: 5,
          onChanged: (value) => print('Rating: $value'),
        ),
        const SizedBox(height: 16),
        const Text('只读评分'),
        const SizedBox(height: 8),
        const ZephyrRatingDisplay(
          value: 4.5,
          maxValue: 5,
          allowHalfRating: true,
          showValue: true,
        ),
        const SizedBox(height: 16),
        const Text('自定义图标评分'),
        const SizedBox(height: 8),
        ZephyrRating(
          value: 3,
          maxValue: 5,
          customIcons: const [Icons.favorite, Icons.favorite_border],
          selectedColor: Colors.red,
          onChanged: (value) => print('Rating: $value'),
        ),
      ],
    );
  }
}