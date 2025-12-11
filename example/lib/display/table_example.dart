import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 表格
class TableExample extends StatelessWidget {
  const TableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table 表格'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础表格', _buildBasicTable()),
            _buildSection('带边框 & 斑马纹', _buildBorderedTable()),
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

  Widget _buildBasicTable() {
    return VelocityTable(
      columns: const [
        VelocityTableColumn(title: '姓名', flex: 1),
        VelocityTableColumn(title: '年龄', flex: 1),
        VelocityTableColumn(title: '地址', flex: 2),
      ],
      rows: [
        VelocityTableRow(cells: ['张三', 18, '北京市朝阳区']),
        VelocityTableRow(cells: ['李四', 25, '上海市浦东新区']),
        VelocityTableRow(cells: ['王五', 30, '深圳市南山区']),
      ],
    );
  }

  Widget _buildBorderedTable() {
    return VelocityTable(
      bordered: true,
      striped: true,
      columns: const [
        VelocityTableColumn(title: '姓名'),
        VelocityTableColumn(title: '状态'),
        VelocityTableColumn(title: '操作', align: TextAlign.center),
      ],
      rows: [
        VelocityTableRow(cells: [
          'Item 1',
          const VelocityTag(text: '正常', type: VelocityTagType.success),
          VelocityButton(size: VelocityButtonSize.small, child: const Text('编辑'), onPressed: () {}),
        ]),
        VelocityTableRow(cells: [
          'Item 2',
          const VelocityTag(text: '警告', type: VelocityTagType.warning),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VelocityButton(
                size: VelocityButtonSize.small,
                type: VelocityButtonType.primary,
                child: const Text('编辑'),
                onPressed: () {},
              ),
              VelocityButton(
                size: VelocityButtonSize.small,
                type: VelocityButtonType.text,
                style: const VelocityButtonStyle(foregroundColor: VelocityColors.error),
                child: const Text('删除'),
                onPressed: () {},
              ),
            ],
          ),
        ]),
        VelocityTableRow(cells: [
          'Item 3',
          const VelocityTag(text: '错误', type: VelocityTagType.error),
          VelocityButton(size: VelocityButtonSize.small, child: const Text('编辑'), onPressed: () {}),
        ]),
      ],
    );
  }
}
