import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrDivider 组件示例
///
/// 展示了 ZephyrDivider 组件的各种用法和样式
class ZephyrDividerExample extends StatelessWidget {
  /// 创建一个新的 ZephyrDividerExample 实例
  const ZephyrDividerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrDivider 示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题和描述
            const Text(
              '分割线组件示例',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '展示 ZephyrDivider 组件的各种用法和样式',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // 水平分割线示例
            const Text(
              '水平分割线',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildHorizontalDividers(),
            const SizedBox(height: 32),

            // 垂直分割线示例
            const Text(
              '垂直分割线',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildVerticalDividers(),
            const SizedBox(height: 32),

            // 自定义样式分割线示例
            const Text(
              '自定义样式分割线',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCustomDividers(),
            const SizedBox(height: 32),

            // 分割线在实际布局中的应用示例
            const Text(
              '分割线在布局中的应用',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildLayoutExample(),
          ],
        ),
      ),
    );
  }

  /// 构建水平分割线示例
  Widget _buildHorizontalDividers() {
    return Column(
      children: [
        _buildSection(
          title: '默认水平分割线',
          content: const ZephyrDivider.horizontal(),
        ),
        const SizedBox(height: 16),
        _buildSection(
          title: '带缩进的水平分割线',
          content: const ZephyrDivider.horizontal(
            indent: 20,
            endIndent: 20,
          ),
        ),
        const SizedBox(height: 16),
        _buildSection(
          title: '粗分割线',
          content: const ZephyrDivider.horizontal(
            thickness: 3,
          ),
        ),
        const SizedBox(height: 16),
        _buildSection(
          title: '自定义高度的分割线',
          content: const ZephyrDivider.horizontal(
            height: 40,
          ),
        ),
      ],
    );
  }

  /// 构建垂直分割线示例
  Widget _buildVerticalDividers() {
    return Column(
      children: [
        _buildSection(
          title: '默认垂直分割线',
          content: SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('左侧内容'),
                const ZephyrDivider.vertical(),
                const Text('右侧内容'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildSection(
          title: '带缩进的垂直分割线',
          content: SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('左侧内容'),
                const ZephyrDivider.vertical(
                  indent: 20,
                  endIndent: 20,
                ),
                const Text('右侧内容'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildSection(
          title: '粗垂直分割线',
          content: SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('左侧内容'),
                const ZephyrDivider.vertical(
                  thickness: 3,
                ),
                const Text('右侧内容'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 构建自定义样式分割线示例
  Widget _buildCustomDividers() {
    return Column(
      children: [
        _buildSection(
          title: '自定义颜色的分割线',
          content: const ZephyrDivider.horizontal(
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 16),
        _buildSection(
          title: '细分割线',
          content: const ZephyrDivider.horizontal(
            thickness: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildSection(
          title: '长缩进分割线',
          content: const ZephyrDivider.horizontal(
            indent: 100,
            endIndent: 100,
          ),
        ),
      ],
    );
  }

  /// 构建分割线在实际布局中的应用示例
  Widget _buildLayoutExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '用户信息',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('姓名:'),
                Text('张三'),
              ],
            ),
            const ZephyrDivider.horizontal(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('年龄:'),
                Text('25'),
              ],
            ),
            const ZephyrDivider.horizontal(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('性别:'),
                Text('男'),
              ],
            ),
            const ZephyrDivider.horizontal(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('职业:'),
                Text('开发者'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '联系方式',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.phone, color: Colors.blue),
                    const SizedBox(height: 8),
                    const Text('电话'),
                  ],
                ),
                const ZephyrDivider.vertical(),
                Column(
                  children: [
                    Icon(Icons.email, color: Colors.green),
                    const SizedBox(height: 8),
                    const Text('邮箱'),
                  ],
                ),
                const ZephyrDivider.vertical(),
                Column(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(height: 8),
                    const Text('地址'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建示例区块
  Widget _buildSection({
    required String title,
    required Widget content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }
}
