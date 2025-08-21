import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/components/basic/badge/badge.dart';

class BadgeDemo extends StatefulWidget {
  const BadgeDemo({Key? key}) : super(key: key);

  @override
  State<BadgeDemo> createState() => _BadgeDemoState();
}

class _BadgeDemoState extends State<BadgeDemo> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BasicBadgeDemo(),
    const StyleBadgeDemo(),
    const InteractiveBadgeDemo(),
    const AdvancedBadgeDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('徽章组件演示'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showAboutDialog(),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '基础',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            label: '样式',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: '交互',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets),
            label: '高级',
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('关于徽章组件'),
        content: const Text(
          'ZephyrBadge 是一个轻量级的徽章组件，支持文本、数字、圆点三种模式，'
          '提供灵活的样式定制和定位选项。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

// 基础徽章演示
class BasicBadgeDemo extends StatelessWidget {
  const BasicBadgeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础徽章',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 文本徽章
          _buildSection('文本徽章', [
            ZephyrBadge(
              content: '新',
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '热门',
              backgroundColor: Colors.orange,
              textColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '推荐',
              backgroundColor: Colors.green,
              textColor: Colors.white,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 数字徽章
          _buildSection('数字徽章', [
            ZephyrBadge.count(
              count: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrBadge.count(
              count: 9,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrBadge.count(
              count: 99,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrBadge.count(
              count: 100,
              maxCount: 99,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 圆点徽章
          _buildSection('圆点徽章', [
            ZephyrBadge.dot(),
            const SizedBox(width: 8),
            ZephyrBadge.dot(backgroundColor: Colors.green),
            const SizedBox(width: 8),
            ZephyrBadge.dot(backgroundColor: Colors.orange),
            const SizedBox(width: 8),
            ZephyrBadge.dot(backgroundColor: Colors.red),
          ]),
          
          const SizedBox(height: 24),
          
          // 默认徽章
          _buildSection('默认样式', [
            ZephyrBadge(content: '默认'),
            const SizedBox(width: 8),
            ZephyrBadge.count(count: 5),
            const SizedBox(width: 8),
            ZephyrBadge.dot(),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: children,
        ),
      ],
    );
  }
}

// 样式徽章演示
class StyleBadgeDemo extends StatelessWidget {
  const StyleBadgeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '样式定制',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 颜色变体
          _buildSection('颜色变体', [
            ZephyrBadge(
              content: '默认',
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '成功',
              backgroundColor: Colors.green,
              textColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '警告',
              backgroundColor: Colors.orange,
              textColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '错误',
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '信息',
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 边框样式
          _buildSection('边框样式', [
            ZephyrBadge(
              content: '无边框',
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '边框',
              backgroundColor: Colors.white,
              textColor: Colors.blue,
              borderWidth: 1,
              borderColor: Colors.blue,
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '粗边框',
              backgroundColor: Colors.white,
              textColor: Colors.red,
              borderWidth: 2,
              borderColor: Colors.red,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 圆角样式
          _buildSection('圆角样式', [
            ZephyrBadge(
              content: '默认',
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '圆角',
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(width: 8),
            ZephyrBadge(
              content: '方形',
              borderRadius: BorderRadius.circular(2),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 数字徽章变体
          _buildSection('数字变体', [
            ZephyrBadge.count(count: 1),
            const SizedBox(width: 8),
            ZephyrBadge.count(count: 9),
            const SizedBox(width: 8),
            ZephyrBadge.count(count: 99),
            const SizedBox(width: 8),
            ZephyrBadge.count(
              count: 100,
              maxCount: 99,
            ),
            const SizedBox(width: 8),
            ZephyrBadge.count(
              count: 999,
              maxCount: 999,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: children,
        ),
      ],
    );
  }
}

// 交互徽章演示
class InteractiveBadgeDemo extends StatelessWidget {
  const InteractiveBadgeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '交互功能',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 带徽章的图标
          _buildSection('带徽章的图标', [
            _buildBadgedIcon(Icons.notifications, 3, () {
              _showMessage(context, '查看通知');
            }),
            const SizedBox(width: 16),
            _buildBadgedIcon(Icons.mail, 12, () {
              _showMessage(context, '查看邮件');
            }),
            const SizedBox(width: 16),
            _buildBadgedIcon(Icons.shopping_cart, 0, () {
              _showMessage(context, '查看购物车');
            }),
          ]),
          
          const SizedBox(height: 24),
          
          // 带徽章的列表项
          _buildSection('带徽章的列表项', [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildBadgedListItem(
                    '收件箱',
                    '5 封未读邮件',
                    '5',
                    Colors.blue,
                    () => _showMessage(context, '打开收件箱'),
                  ),
                  const Divider(),
                  _buildBadgedListItem(
                    '任务',
                    '3 个待办事项',
                    '3',
                    Colors.orange,
                    () => _showMessage(context, '查看任务'),
                  ),
                  const Divider(),
                  _buildBadgedListItem(
                    '日历',
                    '今日无日程',
                    null,
                    null,
                    () => _showMessage(context, '查看日历'),
                  ),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 状态指示器
          _buildSection('状态指示器', [
            _buildStatusIndicator('服务器状态', '在线', Colors.green),
            const SizedBox(height: 8),
            _buildStatusIndicator('数据库状态', '维护中', Colors.orange),
            const SizedBox(height: 8),
            _buildStatusIndicator('API 状态', '离线', Colors.red),
          ]),
        ],
      ),
    );
  }

  Widget _buildBadgedIcon(
    IconData icon,
    int? count,
    VoidCallback? onTap,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onTap,
        ),
        if (count != null && count > 0)
          Positioned(
            right: -6,
            top: -6,
            child: ZephyrBadge.count(
              count: count,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
          ),
      ],
    );
  }

  Widget _buildBadgedListItem(
    String title,
    String subtitle,
    String? badge,
    Color? badgeColor,
    VoidCallback? onTap,
  ) {
    return ListTile(
      leading: const Icon(Icons.inbox),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: badge != null
          ? ZephyrBadge(
              content: badge,
              backgroundColor: badgeColor,
              textColor: Colors.white,
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildStatusIndicator(
    String label,
    String status,
    Color statusColor,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZephyrBadge.dot(
              backgroundColor: statusColor,
            ),
            const SizedBox(width: 4),
            Text(
              status,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
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

// 高级徽章演示
class AdvancedBadgeDemo extends StatefulWidget {
  const AdvancedBadgeDemo({Key? key}) : super(key: key);

  @override
  State<AdvancedBadgeDemo> createState() => _AdvancedBadgeDemoState();
}

class _AdvancedBadgeDemoState extends State<AdvancedBadgeDemo> {
  // 模拟数据流
  final _notificationController = StreamController<int>.broadcast();
  final _messageController = StreamController<int>.broadcast();
  
  int _notificationCount = 3;
  int _messageCount = 12;

  @override
  void dispose() {
    _notificationController.close();
    _messageController.close();
    super.dispose();
  }

  void _incrementNotification() {
    setState(() {
      _notificationCount++;
    });
    _notificationController.add(_notificationCount);
  }

  void _incrementMessage() {
    setState(() {
      _messageCount++;
    });
    _messageController.add(_messageCount);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '高级应用',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 徽章包装器
          _buildSection('徽章包装器', [
            Row(
              children: [
                Expanded(
                  child: _buildBadgeWrapper(
                    '通知',
                    3,
                    Colors.red,
                    () => _showMessage(context, '查看通知'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBadgeWrapper(
                    '消息',
                    12,
                    Colors.blue,
                    () => _showMessage(context, '查看消息'),
                  ),
                ),
              ],
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 动态徽章
          _buildSection('动态徽章', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '实时通知',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildDynamicBadge(
                        '通知',
                        _notificationStream,
                        Colors.red,
                      ),
                      const SizedBox(width: 16),
                      _buildDynamicBadge(
                        '消息',
                        _messageStream,
                        Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _simulateNotification(),
                    child: const Text('模拟通知'),
                  ),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 多位置徽章
          _buildSection('多位置徽章', [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // 中心内容
                  const Center(
                    child: Text(
                      '内容区域',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  // 四个角的徽章
                  Positioned(
                    left: 8,
                    top: 8,
                    child: ZephyrBadge(
                      content: '左上',
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: ZephyrBadge(
                      content: '右上',
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: ZephyrBadge(
                      content: '左下',
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: ZephyrBadge(
                      content: '右下',
                      backgroundColor: Colors.orange,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 批量徽章
          _buildSection('批量徽章', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '标签云',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ZephyrBadge(content: 'Flutter'),
                      ZephyrBadge(content: 'Dart'),
                      ZephyrBadge(content: 'React'),
                      ZephyrBadge(content: 'Vue'),
                      ZephyrBadge(content: 'Angular'),
                      ZephyrBadge(content: 'JavaScript'),
                      ZephyrBadge(content: 'TypeScript'),
                      ZephyrBadge(content: 'Python'),
                      ZephyrBadge(content: 'Java'),
                      ZephyrBadge(content: 'Go'),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildBadgeWrapper(
    String text,
    int count,
    Color color,
    VoidCallback? onTap,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ElevatedButton(
          onPressed: onTap,
          child: Text(text),
        ),
        if (count > 0)
          Positioned(
            right: -6,
            top: -6,
            child: ZephyrBadge.count(
              count: count,
              backgroundColor: color,
              textColor: Colors.white,
            ),
          ),
      ],
    );
  }

  Widget _buildDynamicBadge(
    String text,
    Stream<int> stream,
    Color color,
  ) {
    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            ElevatedButton(
              onPressed: () => _showMessage(context, '查看$text'),
              child: Text(text),
            ),
            if (count > 0)
              Positioned(
                right: -6,
                top: -6,
                child: ZephyrBadge.count(
                  count: count,
                  backgroundColor: color,
                  textColor: Colors.white,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
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

  void _simulateNotification() {
    // 模拟通知更新
    _notificationController.add(_notificationCount + 1);
  }
  
  Stream<int> get _notificationStream => _notificationController.stream;
  Stream<int> get _messageStream => _messageController.stream;
}