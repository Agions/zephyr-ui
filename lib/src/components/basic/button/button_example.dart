import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrButton 组件示例
///
/// 展示了 ZephyrButton 组件的各种用法和样式
class ZephyrButtonExample extends StatelessWidget {
  /// 创建一个新的 ZephyrButtonExample 实例
  const ZephyrButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrButton 示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题和描述
            const Text(
              '按钮组件示例',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '展示 ZephyrButton 组件的各种类型、尺寸和状态',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // 按钮类型示例
            const Text(
              '按钮类型',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // 主要按钮
                ZephyrButton.primary(
                  text: '主要按钮',
                  onPressed: () => debugPrint('主要按钮点击'),
                ),
                // 次要按钮
                ZephyrButton.secondary(
                  text: '次要按钮',
                  onPressed: () => debugPrint('次要按钮点击'),
                ),
                // 轮廓按钮
                ZephyrButton.outline(
                  text: '轮廓按钮',
                  onPressed: () => debugPrint('轮廓按钮点击'),
                ),
                // 文本按钮
                ZephyrButton.text(
                  text: '文本按钮',
                  onPressed: () => debugPrint('文本按钮点击'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 按钮尺寸示例
            const Text(
              '按钮尺寸',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // 小型按钮
                ZephyrButton.primary(
                  text: '小型',
                  size: ZephyrButtonSize.small,
                  onPressed: () => debugPrint('小型按钮点击'),
                ),
                // 中型按钮
                ZephyrButton.primary(
                  text: '中型',
                  size: ZephyrButtonSize.medium,
                  onPressed: () => debugPrint('中型按钮点击'),
                ),
                // 大型按钮
                ZephyrButton.primary(
                  text: '大型',
                  size: ZephyrButtonSize.large,
                  onPressed: () => debugPrint('大型按钮点击'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 带图标的按钮示例
            const Text(
              '带图标按钮',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // 图标在左
                ZephyrButton.primary(
                  text: '带图标',
                  icon: Icons.add,
                  onPressed: () => debugPrint('带图标按钮点击'),
                ),
                // 图标按钮
                ZephyrButton.icon(
                  icon: Icons.favorite,
                  onPressed: () => debugPrint('图标按钮点击'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 按钮状态示例
            const Text(
              '按钮状态',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // 加载状态
                ZephyrButton.primary(
                  text: '加载中',
                  isLoading: true,
                  onPressed: () => debugPrint('加载中按钮点击'),
                ),
                // 禁用状态
                ZephyrButton.primary(
                  text: '已禁用',
                  isDisabled: true,
                  onPressed: () => debugPrint('禁用按钮点击'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 全宽按钮示例
            const Text(
              '全宽按钮',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ZephyrButton.primary(
              text: '全宽主要按钮',
              isFullWidth: true,
              onPressed: () => debugPrint('全宽按钮点击'),
            ),
            const SizedBox(height: 12),
            ZephyrButton.secondary(
              text: '全宽次要按钮',
              isFullWidth: true,
              onPressed: () => debugPrint('全宽次要按钮点击'),
            ),
          ],
        ),
      ),
    );
  }
}
