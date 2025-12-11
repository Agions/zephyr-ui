import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 列表
class ListExample extends StatelessWidget {
  const ListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List 列表'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础列表项', _buildBasicListTile()),
            _buildSection('列表分组', _buildListGroup()),
            _buildSection('带选择状态', _buildSelectedListTile()),
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

  Widget _buildBasicListTile() {
    return Column(
      children: [
        VelocityListTile(
          title: const Text('单行列表'),
          onTap: () {},
        ),
        VelocityListTile(
          leading: const Icon(Icons.star),
          title: const Text('带图标的列表'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        VelocityListTile(
          title: const Text('双行列表'),
          subtitle: const Text('这是详细描述信息'),
          trailing: const VelocityTag(text: 'Tag'),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildListGroup() {
    return VelocityListGroup(
      header: const Text('设置'),
      children: [
        VelocityListTile(
          leading: const Icon(Icons.wifi),
          title: const Text('Wi-Fi'),
          trailing: const VelocitySwitch(value: true, onChanged: null),
        ),
        VelocityListTile(
          leading: const Icon(Icons.bluetooth),
          title: const Text('蓝牙'),
          trailing: const Text('已关闭'),
          onTap: () {},
        ),
        VelocityListTile(
          leading: const Icon(Icons.data_usage),
          title: const Text('移动网络'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSelectedListTile() {
    return const VelocityListTile(
      leading: Icon(Icons.check),
      title: Text('由于被选中所以高亮'),
      selected: true,
    );
  }
}
