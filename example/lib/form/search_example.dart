import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 搜索框
class SearchExample extends StatelessWidget {
  const SearchExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search 搜索框'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicSearch()),
            _buildSection('带取消按钮', _buildCancelSearch(context)),
            _buildSection('自定义样式', _buildCustomSearch()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: VelocityColors.gray800,
            ),
          ),
        ),
        content,
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }

  Widget _buildBasicSearch() {
    return VelocitySearch(
      placeholder: '请输入关键词',
      onChanged: (value) {
        print('Search changed: $value');
      },
      onSubmitted: (value) {
        print('Search submitted: $value');
      },
    );
  }

  Widget _buildCancelSearch(BuildContext context) {
    return VelocitySearch(
      placeholder: '搜索...',
      showCancelButton: true,
      onCancel: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('点击了取消')));
      },
    );
  }

  Widget _buildCustomSearch() {
    return const VelocitySearch(
      placeholder: '圆角搜索框',
      style: VelocitySearchStyle(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        backgroundColor: Color(0xFFF5F5F5),
      ),
    );
  }
}
