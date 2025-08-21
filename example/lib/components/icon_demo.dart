import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class IconDemo extends StatelessWidget {
  const IconDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图标组件演示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '基础图标',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 基础图标展示
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildIconCard(Icons.home, '首页', Colors.blue),
                _buildIconCard(Icons.search, '搜索', Colors.green),
                _buildIconCard(Icons.person, '个人', Colors.purple),
                _buildIconCard(Icons.settings, '设置', Colors.orange),
                _buildIconCard(Icons.favorite, '收藏', Colors.red),
                _buildIconCard(Icons.share, '分享', Colors.teal),
                _buildIconCard(Icons.download, '下载', Colors.indigo),
                _buildIconCard(Icons.notifications, '通知', Colors.pink),
              ],
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '图标尺寸',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 尺寸变化
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    ZephyrIcon(Icons.star, size: 16),
                    const SizedBox(height: 4),
                    const Text('16px', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    ZephyrIcon(Icons.star, size: 24),
                    const SizedBox(height: 4),
                    const Text('24px', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    ZephyrIcon(Icons.star, size: 32),
                    const SizedBox(height: 4),
                    const Text('32px', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    ZephyrIcon(Icons.star, size: 48),
                    const SizedBox(height: 4),
                    const Text('48px', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '图标颜色',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 颜色变化
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ZephyrIcon(Icons.check_circle, size: 32, color: Colors.green),
                ZephyrIcon(Icons.error, size: 32, color: Colors.red),
                ZephyrIcon(Icons.warning, size: 32, color: Colors.orange),
                ZephyrIcon(Icons.info, size: 32, color: Colors.blue),
                ZephyrIcon(Icons.help, size: 32, color: Colors.purple),
                ZephyrIcon(Icons.star, size: 32, color: Colors.amber),
                ZephyrIcon(Icons.favorite, size: 32, color: Colors.pink),
                ZephyrIcon(Icons.cloud, size: 32, color: Colors.cyan),
              ],
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '可点击图标',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 可点击图标
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildClickableIcon(Icons.thumb_up, '点赞', Colors.blue),
                _buildClickableIcon(Icons.comment, '评论', Colors.green),
                _buildClickableIcon(Icons.share, '分享', Colors.orange),
                _buildClickableIcon(Icons.bookmark, '收藏', Colors.red),
              ],
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '带背景图标',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 带背景图标
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildIconWithBackground(Icons.phone, '电话', Colors.blue.withOpacity(0.1)),
                _buildIconWithBackground(Icons.email, '邮件', Colors.green.withOpacity(0.1)),
                _buildIconWithBackground(Icons.location_on, '位置', Colors.red.withOpacity(0.1)),
                _buildIconWithBackground(Icons.web, '网站', Colors.purple.withOpacity(0.1)),
              ],
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '状态图标',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 状态图标
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ZephyrIcon(Icons.check_circle, size: 20, color: Colors.green),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('任务已完成')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ZephyrIcon(Icons.pending, size: 20, color: Colors.orange),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('任务进行中')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ZephyrIcon(Icons.error, size: 20, color: Colors.red),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('任务失败')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '图标 + 文本',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 图标文本组合
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildIconText(Icons.phone, '联系电话', '138-0000-0000'),
                    const Divider(),
                    _buildIconText(Icons.email, '邮箱地址', 'example@email.com'),
                    const Divider(),
                    _buildIconText(Icons.location_on, '地址', '北京市朝阳区'),
                    const Divider(),
                    _buildIconText(Icons.language, '网站', 'www.example.com'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '交互式图标',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 交互式图标
            const _InteractiveIconDemo(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconCard(IconData icon, String label, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrIcon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableIcon(IconData icon, String label, Color color) {
    return Card(
      child: InkWell(
        onTap: () => _showMessage('$label 被点击'),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ZephyrIcon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithBackground(IconData icon, String label, Color backgroundColor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: ZephyrIcon(icon, size: 24),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String label, String value) {
    return Row(
      children: [
        ZephyrIcon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }

  void _showMessage(String message) {
    // 这里可以添加显示消息的逻辑
    debugPrint(message);
  }
}

class _InteractiveIconDemo extends StatefulWidget {
  const _InteractiveIconDemo();

  @override
  _InteractiveIconDemoState createState() => _InteractiveIconDemoState();
}

class _InteractiveIconDemoState extends State<_InteractiveIconDemo> {
  bool _isFavorite = false;
  int _likeCount = 42;
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '交互式图标示例',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 收藏图标
                Column(
                  children: [
                    ZephyrIcon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 32,
                      color: _isFavorite ? Colors.red : Colors.grey,
                      onPressed: () => setState(() => _isFavorite = !_isFavorite),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isFavorite ? '已收藏' : '收藏',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                
                // 点赞图标
                Column(
                  children: [
                    ZephyrIcon(
                      _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      size: 32,
                      color: _isLiked ? Colors.blue : Colors.grey,
                      onPressed: () {
                        setState(() {
                          _isLiked = !_isLiked;
                          _likeCount += _isLiked ? 1 : -1;
                        });
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$_likeCount',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                
                // 分享图标
                Column(
                  children: [
                    ZephyrIcon(
                      Icons.share,
                      size: 32,
                      color: Colors.green,
                      onPressed: () => _showMessage('分享功能'),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '分享',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    debugPrint(message);
  }
}