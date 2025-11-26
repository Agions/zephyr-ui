import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrCard 组件示例
///
/// 展示了 ZephyrCard 组件的各种变体和用法
class ZephyrCardExample extends StatelessWidget {
  /// 创建一个新的 ZephyrCardExample 实例
  const ZephyrCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrCard 示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题和描述
            const Text(
              '卡片组件示例',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '展示 ZephyrCard 组件的各种变体和用法',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // 卡片变体示例
            const Text(
              '卡片变体',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                // 标准卡片
                _buildCardVariant(
                  title: '标准卡片',
                  card: ZephyrCard(
                    child: _buildCardContent(),
                    onTap: () => debugPrint('标准卡片点击'),
                  ),
                ),
                const SizedBox(height: 16),
                // 扁平卡片
                _buildCardVariant(
                  title: '扁平卡片',
                  card: ZephyrCard.flat(
                    child: _buildCardContent(),
                    onTap: () => debugPrint('扁平卡片点击'),
                  ),
                ),
                const SizedBox(height: 16),
                // 高阴影卡片
                _buildCardVariant(
                  title: '高阴影卡片',
                  card: ZephyrCard.elevated(
                    child: _buildCardContent(),
                    onTap: () => debugPrint('高阴影卡片点击'),
                  ),
                ),
                const SizedBox(height: 16),
                // 填充卡片
                _buildCardVariant(
                  title: '填充卡片',
                  card: ZephyrCard.filled(
                    child: _buildCardContent(),
                    onTap: () => debugPrint('填充卡片点击'),
                  ),
                ),
                const SizedBox(height: 16),
                // 轮廓卡片
                _buildCardVariant(
                  title: '轮廓卡片',
                  card: ZephyrCard.outlined(
                    child: _buildCardContent(),
                    onTap: () => debugPrint('轮廓卡片点击'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 自定义卡片示例
            const Text(
              '自定义卡片',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                // 自定义颜色卡片
                _buildCardVariant(
                  title: '自定义颜色卡片',
                  card: ZephyrCard(
                    backgroundColor: Colors.blue.shade50,
                    foregroundColor: Colors.blue.shade800,
                    child: _buildCardContent(),
                    onTap: () => debugPrint('自定义颜色卡片点击'),
                  ),
                ),
                const SizedBox(height: 16),
                // 自定义圆角卡片
                _buildCardVariant(
                  title: '自定义圆角卡片',
                  card: ZephyrCard(
                    borderRadius: BorderRadius.circular(20),
                    child: _buildCardContent(),
                    onTap: () => debugPrint('自定义圆角卡片点击'),
                  ),
                ),
                const SizedBox(height: 16),
                // 禁用状态卡片
                _buildCardVariant(
                  title: '禁用状态卡片',
                  card: ZephyrCard(
                    child: _buildCardContent(),
                    enabled: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 带图片的卡片示例
            const Text(
              '带图片的卡片',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ZephyrCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 图片
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/800/400'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // 内容
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '风景图片',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '这是一张风景图片，展示了美丽的自然风光。',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ZephyrButton.text(
                              text: '取消',
                              onPressed: () => debugPrint('取消'),
                            ),
                            const SizedBox(width: 12),
                            ZephyrButton.primary(
                              text: '查看详情',
                              onPressed: () => debugPrint('查看详情'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () => debugPrint('带图片的卡片点击'),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建卡片变体示例
  Widget _buildCardVariant({
    required String title,
    required Widget card,
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
        card,
      ],
    );
  }

  /// 构建卡片内容
  Widget _buildCardContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '卡片标题',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '这是卡片的内容描述，展示了卡片组件的基本用法。',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ZephyrButton.text(
                text: '了解更多',
                onPressed: () => debugPrint('了解更多'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
