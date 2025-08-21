import 'package:flutter/material.dart';
import 'checkbox_group.dart';

/// CheckboxGroup组件的使用示例
class CheckboxGroupExample extends StatefulWidget {
  /// 构造函数
  const CheckboxGroupExample({Key? key}) : super(key: key);

  @override
  State<CheckboxGroupExample> createState() => _CheckboxGroupExampleState();
}

class _CheckboxGroupExampleState extends State<CheckboxGroupExample> {
  // 水果选择示例
  List<String> _selectedFruits = ['apple', 'banana'];

  // 颜色选择示例
  List<String> _selectedColors = ['red'];

  // 禁用示例
  List<String> _selectedSizes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('复选框组示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            const Text(
              '垂直排列复选框组',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 垂直排列的水果选择
            ZephyrCheckboxGroup(
              items: const [
                ZephyrCheckboxItem(value: 'apple', label: '苹果'),
                ZephyrCheckboxItem(value: 'banana', label: '香蕉'),
                ZephyrCheckboxItem(value: 'orange', label: '橙子'),
                ZephyrCheckboxItem(value: 'grape', label: '葡萄'),
                ZephyrCheckboxItem(
                    value: 'watermelon', label: '西瓜', disabled: true),
              ],
              value: _selectedFruits,
              onChanged: (values) {
                setState(() {
                  _selectedFruits = values;
                });
              },
            ),

            const SizedBox(height: 16),
            Text('已选择: ${_selectedFruits.join(", ")}'),

            const SizedBox(height: 32),

            // 标题
            const Text(
              '水平排列复选框组',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 水平排列的颜色选择
            ZephyrCheckboxGroup(
              items: const [
                ZephyrCheckboxItem(value: 'red', label: '红色'),
                ZephyrCheckboxItem(value: 'green', label: '绿色'),
                ZephyrCheckboxItem(value: 'blue', label: '蓝色'),
              ],
              value: _selectedColors,
              onChanged: (values) {
                setState(() {
                  _selectedColors = values;
                });
              },
              direction: Axis.horizontal,
              spacing: 16.0,
            ),

            const SizedBox(height: 16),
            Text('已选择: ${_selectedColors.join(", ")}'),

            const SizedBox(height: 32),

            // 标题
            const Text(
              '禁用状态复选框组',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 禁用的尺寸选择
            ZephyrCheckboxGroup(
              items: const [
                ZephyrCheckboxItem(value: 'small', label: '小号'),
                ZephyrCheckboxItem(value: 'medium', label: '中号'),
                ZephyrCheckboxItem(value: 'large', label: '大号'),
              ],
              value: _selectedSizes,
              onChanged: (values) {
                setState(() {
                  _selectedSizes = values;
                });
              },
              disabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
