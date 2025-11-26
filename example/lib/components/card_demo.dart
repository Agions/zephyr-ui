import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class CardDemo extends StatefulWidget {
  const CardDemo({Key? key}) : super(key: key);

  @override
  State<CardDemo> createState() => _CardDemoState();
}

class _CardDemoState extends State<CardDemo> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BasicCardDemo(),
    const StyleCardDemo(),
    const InteractiveCardDemo(),
    const AdvancedCardDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('卡片组件演示'),
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
        title: const Text('关于卡片组件'),
        content: const Text(
          'ZephyrCard 是一个多功能的卡片组件，支持多种视觉样式变体，'
          '包括标准、扁平、高阴影、填充和轮廓样式。',
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

// 基础卡片演示
class BasicCardDemo extends StatelessWidget {
  const BasicCardDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础卡片',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 标准卡片
          _buildSection('标准卡片', [
            ZephyrCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '卡片标题',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '这是卡片的内容描述，可以包含任何文本或组件。',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              onTap: () => _showMessage(context, '标准卡片被点击'),
            ),
          ]),

          const SizedBox(height: 24),

          // 扁平卡片
          _buildSection('扁平卡片', [
            ZephyrCard.flat(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('这是一个扁平卡片，没有阴影效果'),
              ),
              onTap: () => _showMessage(context, '扁平卡片被点击'),
            ),
          ]),

          const SizedBox(height: 24),

          // 高阴影卡片
          _buildSection('高阴影卡片', [
            ZephyrCard.elevated(
              elevation: 8,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('这是一个高阴影卡片'),
              ),
              onTap: () => _showMessage(context, '高阴影卡片被点击'),
            ),
          ]),

          const SizedBox(height: 24),

          // 填充卡片
          _buildSection('填充卡片', [
            ZephyrCard.filled(
              backgroundColor: Colors.blue[50],
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('这是一个填充卡片，有背景色'),
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 轮廓卡片
          _buildSection('轮廓卡片', [
            ZephyrCard.outlined(
              borderColor: Colors.blue,
              borderWidth: 2,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('这是一个轮廓卡片，只有边框'),
              ),
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

// 样式卡片演示
class StyleCardDemo extends StatelessWidget {
  const StyleCardDemo({Key? key}) : super(key: key);

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

          // 背景颜色
          _buildSection('背景颜色', [
            const ZephyrCard(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('默认背景'),
              ),
            ),
            const SizedBox(height: 16),
            ZephyrCard(
              backgroundColor: Colors.blue[50],
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('蓝色背景'),
              ),
            ),
            const SizedBox(height: 16),
            ZephyrCard(
              backgroundColor: Colors.green[50],
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('绿色背景'),
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 阴影效果
          _buildSection('阴影效果', [
            const ZephyrCard(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('无阴影'),
              ),
            ),
            const SizedBox(height: 16),
            const ZephyrCard(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('轻微阴影'),
              ),
            ),
            const SizedBox(height: 16),
            const ZephyrCard(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('中等阴影'),
              ),
            ),
            const SizedBox(height: 16),
            const ZephyrCard(
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('深阴影'),
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 圆角样式
          _buildSection('圆角样式', [
            const ZephyrCard(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('默认圆角'),
              ),
            ),
            const SizedBox(height: 16),
            ZephyrCard(
              borderRadius: BorderRadius.circular(4),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('小圆角'),
              ),
            ),
            const SizedBox(height: 16),
            ZephyrCard(
              borderRadius: BorderRadius.circular(16),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('大圆角'),
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 边框样式
          _buildSection('边框样式', [
            ZephyrCard.outlined(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('默认边框'),
              ),
            ),
            const SizedBox(height: 16),
            ZephyrCard.outlined(
              borderColor: Colors.blue,
              borderWidth: 2,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('蓝色边框'),
              ),
            ),
            const SizedBox(height: 16),
            ZephyrCard.outlined(
              borderColor: Colors.red,
              borderWidth: 3,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('红色边框'),
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 尺寸定制
          _buildSection('尺寸定制', [
            const ZephyrCard(
              width: 200,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('固定宽度'),
              ),
            ),
            const SizedBox(height: 16),
            const ZephyrCard(
              height: 100,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('固定高度'),
              ),
            ),
            const SizedBox(height: 16),
            const ZephyrCard(
              width: 200,
              height: 150,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('固定尺寸'),
              ),
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
        ...children,
      ],
    );
  }
}

// 交互卡片演示
class InteractiveCardDemo extends StatelessWidget {
  const InteractiveCardDemo({Key? key}) : super(key: key);

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

          // 可点击卡片
          _buildSection('可点击卡片', [
            ZephyrCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('点击我！'),
              ),
              onTap: () => _showMessage(context, '卡片被点击'),
            ),
            const SizedBox(height: 16),
            ZephyrCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('长按我！'),
              ),
              onLongPress: () => _showMessage(context, '卡片被长按'),
            ),
          ]),

          const SizedBox(height: 24),

          // 禁用状态
          _buildSection('禁用状态', [
            ZephyrCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('启用状态'),
              ),
              onTap: () => _showMessage(context, '启用卡片被点击'),
            ),
            const SizedBox(height: 16),
            ZephyrCard(
              enabled: false,
              onTap: () => _showMessage(context, '禁用卡片被点击'),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('禁用状态'),
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 用户信息卡片
          _buildSection('用户信息卡片', [
            _buildUserCard(
              name: '张三',
              email: 'zhangsan@example.com',
              avatar: 'assets/images/user1.jpg',
              onTap: () => _showMessage(context, '查看用户资料'),
            ),
          ]),

          const SizedBox(height: 24),

          // 设置项卡片
          _buildSection('设置项卡片', [
            const Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildSettingItemCard(
                    title: '账号设置',
                    subtitle: '管理您的账号信息',
                    onTap: () => _showMessage(context, '打开账号设置'),
                  ),
                  Divider(),
                  _buildSettingItemCard(
                    title: '通知设置',
                    subtitle: '管理推送通知',
                    onTap: () => _showMessage(context, '打开通知设置'),
                  ),
                  Divider(),
                  _buildSettingItemCard(
                    title: '隐私设置',
                    subtitle: '管理隐私选项',
                    onTap: () => _showMessage(context, '打开隐私设置'),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildUserCard({
    required String name,
    required String email,
    required String avatar,
    VoidCallback? onTap,
  }) {
    return ZephyrCard(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            ZephyrAvatar.text(
              text: name,
              size: ZephyrAvatarSize.large,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItemCard({
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ZephyrCard.flat(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
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

// 高级卡片演示
class AdvancedCardDemo extends StatelessWidget {
  const AdvancedCardDemo({Key? key}) : super(key: key);

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

          // 统计卡片
          _buildSection('统计卡片', [
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: '总用户',
                    value: '1,234',
                    change: '+12%',
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    title: '销售额',
                    value: '¥56,789',
                    change: '+8%',
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: '订单数',
                    value: '89',
                    change: '-3%',
                    icon: Icons.shopping_cart,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    title: '转化率',
                    value: '3.2%',
                    change: '+0.5%',
                    icon: Icons.trending_up,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ]),

          const SizedBox(height: 24),

          // 产品卡片
          _buildSection('产品卡片', [
            _buildProductCard(
              name: '无线耳机',
              description: '高品质无线蓝牙耳机，主动降噪功能',
              price: 299.99,
              image: 'assets/images/product1.jpg',
              onAddToCart: () => _showMessage(context, '添加到购物车'),
            ),
          ]),

          const SizedBox(height: 24),

          // 可折叠卡片
          _buildSection('可折叠卡片', [
            const ExpandableCard(
              title: '详细信息',
              initiallyExpanded: true,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('这是可展开的内容区域'),
                  SizedBox(height: 8),
                  Text('可以包含任何组件'),
                  SizedBox(height: 8),
                  Text('例如列表、表单等'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const ExpandableCard(
              title: '技术规格',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('版本: 1.0.0'),
                  SizedBox(height: 4),
                  Text('大小: 10MB'),
                  SizedBox(height: 4),
                  Text('支持平台: iOS, Android'),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 响应式卡片布局
          _buildSection('响应式布局', [
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // 平板或桌面布局
                  return const Row(
                    children: [
                      Expanded(
                        child: ZephyrCard(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('左侧卡片'),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ZephyrCard(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('右侧卡片'),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // 手机布局
                  return const Column(
                    children: [
                      ZephyrCard(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('上方卡片'),
                        ),
                      ),
                      SizedBox(height: 16),
                      ZephyrCard(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('下方卡片'),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String change,
    required IconData icon,
    required Color color,
  }) {
    return ZephyrCard(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
            Text(
              change,
              style: TextStyle(
                fontSize: 12,
                color: change.startsWith('+') ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard({
    required String name,
    required String description,
    required double price,
    required String image,
    VoidCallback? onAddToCart,
  }) {
    return ZephyrCard.elevated(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 产品图片
          const Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              color: Colors.grey[200],
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 64,
                color: Colors.grey,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '¥$price',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onAddToCart,
                      child: Text('加入购物车'),
                    ),
                  ],
                ),
              ],
            ),
          ),
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

// 可折叠卡片组件
class ExpandableCard extends StatefulWidget {
  final String title;
  final Widget content;
  final bool initiallyExpanded;

  const ExpandableCard({
    Key? key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
  }) : super(key: key);

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: widget.content,
            ),
          ],
        ],
      ),
    );
  }
}
