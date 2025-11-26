import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrUI Form Components Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FormComponentsTestPage(),
    );
  }
}

class FormComponentsTestPage extends StatelessWidget {
  const FormComponentsTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Components Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ZephyrForm Test',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ZephyrForm 测试
            ZephyrForm(
              onSubmitted: (values) {
                debugPrint('Form submitted: $values');
                return values;
              },
              children: [
                ZephyrFormItem(
                  label: '用户名',
                  required: true,
                  helperText: '请输入您的用户名',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '用户名不能为空';
                    }
                    return null;
                  },
                  child: const ZephyrInput(
                    placeholder: '请输入用户名',
                  ),
                ),
                ZephyrFormItem(
                  label: '年龄',
                  required: true,
                  helperText: '请输入您的年龄',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '年龄不能为空';
                    }
                    return null;
                  },
                  child: const ZephyrInputNumber(
                    placeholder: '请输入年龄',
                    min: 0,
                    max: 150,
                    precision: 0,
                  ),
                ),
                ZephyrFormItem(
                  label: '爱好',
                  helperText: '选择您的爱好',
                  child: ZephyrTransfer(
                    dataSource: const [
                      TransferItem(key: '1', title: '读书', description: '阅读书籍'),
                      TransferItem(key: '2', title: '音乐', description: '听音乐'),
                      TransferItem(key: '3', title: '运动', description: '体育锻炼'),
                      TransferItem(key: '4', title: '旅行', description: '旅游观光'),
                    ],
                    titles: const ['可选爱好', '已选爱好'],
                    operations: const ['添加', '移除'],
                    showSearch: true,
                    searchPlaceholder: '搜索爱好',
                    onChanged: (targetKeys) {
                      debugPrint('Selected hobbies: $targetKeys');
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            const Text(
              'Individual Components Test',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 独立组件测试
            ZephyrInputNumber(
              placeholder: '请输入数量',
              min: 0,
              max: 100,
              step: 1,
              precision: 0,
              onChanged: (value) {
                debugPrint('InputNumber value: $value');
              },
            ),

            const SizedBox(height: 16),

            ZephyrTransfer(
              dataSource: const [
                TransferItem(key: '1', title: '选项1', description: '描述1'),
                TransferItem(key: '2', title: '选项2', description: '描述2'),
                TransferItem(key: '3', title: '选项3', description: '描述3'),
              ],
              titles: const ['源列表', '目标列表'],
              operations: const ['>', '<'],
              showSearch: true,
              onChanged: (targetKeys) {
                debugPrint('Transfer target keys: $targetKeys');
              },
            ),
          ],
        ),
      ),
    );
  }
}
