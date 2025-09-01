import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class AvatarDemo extends StatefulWidget {
  const AvatarDemo({Key? key}) : super(key: key);

  @override
  State<AvatarDemo> createState() => _AvatarDemoState();
}

class _AvatarDemoState extends State<AvatarDemo> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BasicAvatarDemo(),
    const StyleAvatarDemo(),
    const InteractiveAvatarDemo(),
    const AdvancedAvatarDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('头像组件演示'),
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
        title: const Text('关于头像组件'),
        content: const Text(
          'ZephyrAvatar 是一个功能丰富的头像组件，支持图片、文字、图标三种模式，'
          '提供多种尺寸和形状选择，并支持完整的主题定制。',
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

// 基础头像演示
class BasicAvatarDemo extends StatelessWidget {
  const BasicAvatarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础头像',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 图片头像
          _buildSection('图片头像', [
            ZephyrAvatar(
              image: const AssetImage('assets/images/user1.jpg'),
              size: ZephyrAvatarSize.medium,
              onTap: () => _showMessage(context, '点击了图片头像'),
            ),
            const SizedBox(width: 16),
            ZephyrAvatar(
              image: const AssetImage('assets/images/user2.jpg'),
              size: ZephyrAvatarSize.large,
              shape: ZephyrAvatarShape.square,
              onTap: () => _showMessage(context, '点击了方形头像'),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 文字头像
          _buildSection('文字头像', [
            ZephyrAvatar.text(
              text: '张三',
              size: ZephyrAvatarSize.medium,
              onTap: () => _showMessage(context, '点击了文字头像'),
            ),
            const SizedBox(width: 16),
            ZephyrAvatar.text(
              text: 'John Doe',
              size: ZephyrAvatarSize.large,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            const SizedBox(width: 16),
            ZephyrAvatar.text(
              text: '李四',
              size: ZephyrAvatarSize.small,
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 图标头像
          _buildSection('图标头像', [
            ZephyrAvatar.icon(
              icon: Icons.person,
              size: ZephyrAvatarSize.medium,
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              onTap: () => _showMessage(context, '点击了图标头像'),
            ),
            const SizedBox(width: 16),
            ZephyrAvatar.icon(
              icon: Icons.business,
              size: ZephyrAvatarSize.large,
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            const SizedBox(width: 16),
            ZephyrAvatar.icon(
              icon: Icons.school,
              size: ZephyrAvatarSize.small,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 基础头像
          _buildSection('基础头像', [
            ZephyrAvatar.text(
              text: 'Star',
              size: ZephyrAvatarSize.medium,
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
              onTap: () => _showMessage(context, '点击了基础头像'),
            ),
            const SizedBox(width: 16),
            ZephyrAvatar.text(
              text: 'AB',
              size: ZephyrAvatarSize.large,
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
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
          spacing: 16,
          runSpacing: 16,
          children: children,
        ),
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

// 样式头像演示
class StyleAvatarDemo extends StatelessWidget {
  const StyleAvatarDemo({Key? key}) : super(key: key);

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
          
          // 尺寸变体
          _buildSection('尺寸变体', [
            ZephyrAvatar.text(
              text: 'XS',
              size: ZephyrAvatarSize.extraSmall,
            ),
            const SizedBox(width: 8),
            ZephyrAvatar.text(
              text: 'S',
              size: ZephyrAvatarSize.small,
            ),
            const SizedBox(width: 8),
            ZephyrAvatar.text(
              text: 'M',
              size: ZephyrAvatarSize.medium,
            ),
            const SizedBox(width: 8),
            ZephyrAvatar.text(
              text: 'L',
              size: ZephyrAvatarSize.large,
            ),
            const SizedBox(width: 8),
            ZephyrAvatar.text(
              text: 'XL',
              size: ZephyrAvatarSize.extraLarge,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 形状变体
          _buildSection('形状变体', [
            ZephyrAvatar.text(
              text: '圆',
              shape: ZephyrAvatarShape.circle,
              size: ZephyrAvatarSize.large,
            ),
            const SizedBox(width: 16),
            ZephyrAvatar.text(
              text: '方',
              shape: ZephyrAvatarShape.square,
              size: ZephyrAvatarSize.large,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 边框和阴影
          _buildSection('边框和阴影', [
            ZephyrAvatar.text(
              text: '边框',
              size: ZephyrAvatarSize.large,
              borderWidth: 2,
              borderColor: Colors.blue,
            ),
            const SizedBox(width: 16),
            ZephyrAvatar.text(
              text: '阴影',
              size: ZephyrAvatarSize.large,
              elevation: 4,
            ),
            const SizedBox(width: 16),
            ZephyrAvatar.text(
              text: '全部',
              size: ZephyrAvatarSize.large,
              borderWidth: 2,
              borderColor: Colors.green,
              elevation: 4,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 颜色变体
          _buildSection('颜色变体', [
            ZephyrAvatar.text(
              text: 'A',
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrAvatar.text(
              text: 'B',
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrAvatar.text(
              text: 'C',
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrAvatar.text(
              text: 'D',
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            const SizedBox(width: 8),
            ZephyrAvatar.text(
              text: 'E',
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
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

// 交互头像演示
class InteractiveAvatarDemo extends StatelessWidget {
  const InteractiveAvatarDemo({Key? key}) : super(key: key);

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
          
          // 可点击头像
          _buildSection('可点击头像', [
            ZephyrAvatar.text(
              text: '点击',
              size: ZephyrAvatarSize.large,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onTap: () => _showMessage(context, '头像被点击'),
            ),
            const SizedBox(width: 16),
            ZephyrAvatar.icon(
              icon: Icons.person,
              size: ZephyrAvatarSize.large,
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              onTap: () => _showMessage(context, '图标头像被点击'),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 状态指示器
          _buildSection('状态指示器', [
            _buildStatusAvatar('在线', true),
            const SizedBox(width: 16),
            _buildStatusAvatar('离线', false),
            const SizedBox(width: 16),
            _buildStatusAvatar('忙碌', false, Colors.orange),
          ]),
          
          const SizedBox(height: 24),
          
          // 用户列表
          _buildSection('用户列表', [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildUserTile(context, '张三', '产品经理', true),
                  const Divider(),
                  _buildUserTile(context, '李四', 'UI设计师', false),
                  const Divider(),
                  _buildUserTile(context, '王五', '开发工程师', true),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildStatusAvatar(String name, bool isOnline, [Color? statusColor]) {
    return ZephyrAvatar.text(
      text: name,
      size: ZephyrAvatarSize.large,
    );
  }

  Widget _buildUserTile(BuildContext context, String name, String role, bool isOnline) {
    return ListTile(
      leading: _buildStatusAvatar(name, isOnline),
      title: Text(name),
      subtitle: Text(role),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showMessage(context, '查看 $name 的资料'),
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

// 高级头像演示
class AdvancedAvatarDemo extends StatelessWidget {
  const AdvancedAvatarDemo({Key? key}) : super(key: key);

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
          
          // 头像组
          _buildSection('头像组', [
            _buildAvatarGroup(),
          ]),
          
          const SizedBox(height: 24),
          
          // 用户卡片
          _buildSection('用户卡片', [
            _buildUserCard(context,
              name: '张三',
              role: '产品经理',
              status: '在线',
              avatarColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildUserCard(context,
              name: '李四',
              role: 'UI设计师',
              status: '离线',
              avatarColor: Colors.green,
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 头像选择器
          _buildSection('头像选择器', [
            _buildAvatarSelector(),
          ]),
        ],
      ),
    );
  }

  Widget _buildAvatarGroup() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '团队成员 (5)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ZephyrAvatar(
                text: '主',
                size: ZephyrAvatarSize.medium,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              const SizedBox(width: 8),
              ZephyrAvatar(
                text: 'A',
                size: ZephyrAvatarSize.small,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              const SizedBox(width: 8),
              ZephyrAvatar(
                text: 'B',
                size: ZephyrAvatarSize.small,
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              const SizedBox(width: 8),
              ZephyrAvatar(
                text: 'C',
                size: ZephyrAvatarSize.small,
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '+1',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, {
    required String name,
    required String role,
    required String status,
    required Color avatarColor,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ZephyrAvatar.text(
              text: name,
              size: ZephyrAvatarSize.large,
              backgroundColor: avatarColor,
              foregroundColor: Colors.white,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: status == '在线' ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () => _showMessage(context, '发送消息给 $name'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '选择头像',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
            children: [
              ZephyrAvatar.icon(
                icon: Icons.person,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              ZephyrAvatar.icon(
                icon: Icons.business,
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              ZephyrAvatar.icon(
                icon: Icons.school,
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              ZephyrAvatar.icon(
                icon: Icons.star,
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              ZephyrAvatar.text(
                text: 'A',
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              ZephyrAvatar.text(
                text: 'B',
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              ZephyrAvatar.text(
                text: 'C',
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
              ),
              ZephyrAvatar.text(
                text: 'D',
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
              ),
            ],
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