import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('按钮组件演示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '按钮类型',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 基础按钮 - 使用Flutter原生按钮作为示例
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () => _showMessage(context, '默认按钮被点击'),
                  child: const Text('默认按钮'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _showMessage(context, '主要按钮被点击'),
                  child: const Text('主要按钮'),
                ),
                OutlinedButton(
                  onPressed: () => _showMessage(context, '次要按钮被点击'),
                  child: const Text('次要按钮'),
                ),
                TextButton(
                  onPressed: () => _showMessage(context, '文本按钮被点击'),
                  child: const Text('文本按钮'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              '按钮尺寸',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 尺寸变化
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ZephyrButton(
                  text: '小号',
                  size: ZephyrButtonSize.small,
                  onPressed: () {},
                ),
                ZephyrButton(
                  text: '中号',
                  size: ZephyrButtonSize.medium,
                  onPressed: () {},
                ),
                ZephyrButton(
                  text: '大号',
                  size: ZephyrButtonSize.large,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              '按钮状态',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 状态变化
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ZephyrButton(
                  text: '正常状态',
                  onPressed: () {},
                ),
                ZephyrButton(
                  text: '禁用状态',
                  onPressed: null,
                ),
                ZephyrButton(
                  text: '加载中...',
                  loading: true,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              '带图标的按钮',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 图标按钮
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ZephyrButton(
                  text: '保存',
                  icon: Icons.save,
                  onPressed: () => _showMessage(context, '保存按钮被点击'),
                ),
                ZephyrButton(
                  text: '删除',
                  icon: Icons.delete,
                  onPressed: () => _showMessage(context, '删除按钮被点击'),
                ),
                ZephyrButton(
                  text: '分享',
                  icon: Icons.share,
                  onPressed: () => _showMessage(context, '分享按钮被点击'),
                ),
                ZephyrButton(
                  text: '下载',
                  icon: Icons.download,
                  onPressed: () => _showMessage(context, '下载按钮被点击'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              '全宽按钮',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 全宽按钮
            Column(
              children: [
                ZephyrButton(
                  text: '全宽主要按钮',
                  fullWidth: true,
                  onPressed: () => _showMessage(context, '全宽按钮被点击'),
                ),
                const SizedBox(height: 12),
                ZephyrButton.outlined(
                  text: '全宽轮廓按钮',
                  fullWidth: true,
                  onPressed: () => _showMessage(context, '全宽轮廓按钮被点击'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              '按钮组',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 按钮组
            Row(
              children: [
                Expanded(
                  child: ZephyrButton.outlined(
                    text: '上一步',
                    onPressed: () => _showMessage(context, '上一步'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ZephyrButton(
                    text: '下一步',
                    onPressed: () => _showMessage(context, '下一步'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              '自定义颜色按钮',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 自定义颜色
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ZephyrButton(
                  text: '成功',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  onPressed: () => _showMessage(context, '成功按钮被点击'),
                ),
                ZephyrButton(
                  text: '警告',
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                  onPressed: () => _showMessage(context, '警告按钮被点击'),
                ),
                ZephyrButton(
                  text: '危险',
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  onPressed: () => _showMessage(context, '危险按钮被点击'),
                ),
                ZephyrButton(
                  text: '信息',
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () => _showMessage(context, '信息按钮被点击'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
