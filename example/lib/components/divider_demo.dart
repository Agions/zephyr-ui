import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class DividerDemo extends StatefulWidget {
  const DividerDemo({Key? key}) : super(key: key);

  @override
  State<DividerDemo> createState() => _DividerDemoState();
}

class _DividerDemoState extends State<DividerDemo> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BasicDividerDemo(),
    const StyleDividerDemo(),
    const InteractiveDividerDemo(),
    const AdvancedDividerDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分割线组件演示'),
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
        title: const Text('关于分割线组件'),
        content: const Text(
          'ZephyrDivider 是一个轻量级的分割线组件，支持水平和垂直两种方向，'
          '并提供丰富的样式定制选项。',
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

// 基础分割线演示
class BasicDividerDemo extends StatelessWidget {
  const BasicDividerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础分割线',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 水平分割线
          _buildSection('水平分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('上半部分内容'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(),
                  const SizedBox(height: 16),
                  const Text('下半部分内容'),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 垂直分割线
          _buildSection('垂直分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Expanded(child: Center(child: Text('左侧内容'))),
                  ZephyrDivider.vertical(),
                  const Expanded(child: Center(child: Text('中间内容'))),
                  ZephyrDivider.vertical(),
                  const Expanded(child: Center(child: Text('右侧内容'))),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 带文本的分割线
          _buildSection('带文本的分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('上半部分'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    text: '或者',
                    textStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('下半部分'),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 默认分割线
          _buildSection('默认样式', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('内容 1'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(), // 默认分割线
                  const SizedBox(height: 16),
                  const Text('内容 2'),
                ],
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

// 样式分割线演示
class StyleDividerDemo extends StatelessWidget {
  const StyleDividerDemo({Key? key}) : super(key: key);

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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('内容 1'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    color: Colors.grey[300], // 默认颜色
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 2'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    color: Colors.blue, // 蓝色分割线
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 3'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    color: Colors.red, // 红色分割线
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 4'),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 厚度变体
          _buildSection('厚度变体', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('内容 1'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    thickness: 1, // 默认厚度
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 2'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    thickness: 2, // 中等厚度
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 3'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    thickness: 4, // 厚分割线
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 4'),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 缩进变体
          _buildSection('缩进变体', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('内容 1'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    indent: 0, // 无缩进
                    endIndent: 0,
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 2'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    indent: 20, // 左侧缩进
                    endIndent: 20, // 右侧缩进
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 3'),
                  const SizedBox(height: 16),
                  ZephyrDivider.horizontal(
                    indent: 40, // 更大的缩进
                    endIndent: 40,
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 4'),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 间距变体
          _buildSection('间距变体', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('内容 1'),
                  ZephyrDivider.horizontal(
                    verticalSpacing: 8, // 小间距
                  ),
                  const Text('内容 2'),
                  ZephyrDivider.horizontal(
                    verticalSpacing: 16, // 中等间距
                  ),
                  const Text('内容 3'),
                  ZephyrDivider.horizontal(
                    verticalSpacing: 32, // 大间距
                  ),
                  const Text('内容 4'),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 垂直分割线样式
          _buildSection('垂直分割线样式', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Expanded(child: Center(child: Text('左侧'))),
                  ZephyrDivider.vertical(
                    color: Colors.blue,
                    thickness: 2,
                    width: 50,
                  ),
                  const Expanded(child: Center(child: Text('中间'))),
                  ZephyrDivider.vertical(
                    color: Colors.red,
                    thickness: 3,
                    width: 30,
                  ),
                  const Expanded(child: Center(child: Text('右侧'))),
                ],
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

// 交互分割线演示
class InteractiveDividerDemo extends StatelessWidget {
  const InteractiveDividerDemo({Key? key}) : super(key: key);

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
          
          // 列表中的分割线
          _buildSection('列表中的分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildListTile(context, '项目 1', '这是第一个项目的描述'),
                  ZephyrDivider.horizontal(
                    indent: 16, // 缩进到图标后面
                    endIndent: 16,
                  ),
                  _buildListTile(context, '项目 2', '这是第二个项目的描述'),
                  ZephyrDivider.horizontal(
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildListTile(context, '项目 3', '这是第三个项目的描述'),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 表格中的分割线
          _buildSection('表格中的分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildTableWithDividers(),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 导航分隔符
          _buildSection('导航分隔符', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildNavigationDivider(),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.star),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showMessage(context, '点击了 $title'),
    );
  }

  Widget _buildTableWithDividers() {
    final data = [
      ['姓名', '年龄', '职业'],
      ['张三', '25', '工程师'],
      ['李四', '30', '设计师'],
      ['王五', '28', '产品经理'],
    ];

    return Column(
      children: data.asMap().entries.map((entry) {
        final rowIndex = entry.key;
        final row = entry.value;
        
        return Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: row.asMap().entries.map((cellEntry) {
                  final cellIndex = cellEntry.key;
                  final cell = cellEntry.value;
                  
                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      child: Text(
                        cell,
                        style: rowIndex == 0
                            ? const TextStyle(fontWeight: FontWeight.bold)
                            : null,
                      ),
                    ),
                  );
                }).expand((cell) => [
                  cell,
                  if (cellIndex < row.length - 1)
                    ZephyrDivider.vertical(),
                ]).toList(),
              ),
            ),
            if (rowIndex < data.length - 1)
              ZephyrDivider.horizontal(
                indent: 0,
                endIndent: 0,
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildNavigationDivider() {
    final items = [
      NavItem(Icons.home, '首页', () => _showMessage(context, '首页')),
      NavItem(Icons.person, '个人中心', () => _showMessage(context, '个人中心')),
      NavItem(Icons.settings, '设置', () => _showMessage(context, '设置')),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '主要功能',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          
          return Column(
            children: [
              ListTile(
                leading: Icon(item.icon),
                title: Text(item.title),
                onTap: item.onTap,
              ),
              if (index < items.length - 1)
                ZephyrDivider.horizontal(
                  indent: 56, // 缩进到图标后面
                  endIndent: 16,
                ),
            ],
          );
        }).toList(),
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

// 高级分割线演示
class AdvancedDividerDemo extends StatelessWidget {
  const AdvancedDividerDemo({Key? key}) : super(key: key);

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
          
          // 时间线分割线
          _buildSection('时间线分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildTimelineDivider(),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 可隐藏分割线
          _buildSection('可隐藏分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const ToggleableDividerDemo(),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 分组分割线
          _buildSection('分组分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildGroupedDivider(),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 虚线分割线
          _buildSection('虚线分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('内容 1'),
                  const SizedBox(height: 16),
                  // 使用自定义装饰创建虚线效果
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomPaint(
                      painter: DashedLinePainter(
                        color: Colors.grey[400]!,
                        dashWidth: 5,
                        dashSpace: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('内容 2'),
                ],
              ),
            ),
          ]),
          
          const SizedBox(height: 24),
          
          // 带图标的分割线
          _buildSection('带图标的分割线', [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('上半部分'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ZephyrDivider.horizontal(
                          endIndent: 8,
                        ),
                      ),
                      const Icon(Icons.star, color: Colors.grey),
                      Expanded(
                        child: ZephyrDivider.horizontal(
                          indent: 8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('下半部分'),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildTimelineDivider() {
    final items = [
      TimelineItem('订单创建', '2024-01-01 10:00', Colors.green),
      TimelineItem('订单确认', '2024-01-01 10:30', Colors.blue),
      TimelineItem('订单发货', '2024-01-02 14:00', Colors.orange),
      TimelineItem('订单完成', '2024-01-03 16:00', Colors.green),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 时间线
            Column(
              children: [
                // 时间点
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                  ),
                ),
                // 垂直分割线
                if (index < items.length - 1)
                  Expanded(
                    child: ZephyrDivider.vertical(
                      color: Colors.grey[300],
                      thickness: 2,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  if (index < items.length - 1) ...[
                    const SizedBox(height: 16),
                    ZephyrDivider.horizontal(
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildGroupedDivider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '用户设置',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        ZephyrDivider.horizontal(
          indent: 16,
          endIndent: 16,
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('个人信息'),
                trailing: Icon(Icons.chevron_right),
              ),
              SizedBox(height: 12),
              ZephyrDivider.horizontal(
                indent: 16,
                endIndent: 16,
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('账号安全'),
                trailing: Icon(Icons.chevron_right),
              ),
              SizedBox(height: 12),
              ZephyrDivider.horizontal(
                indent: 16,
                endIndent: 16,
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('通知设置'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
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

// 导航项数据类
class NavItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const NavItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

// 时间线项数据类
class TimelineItem {
  final String title;
  final String subtitle;
  final Color color;

  const TimelineItem({
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

// 可隐藏分割线演示组件
class ToggleableDividerDemo extends StatefulWidget {
  const ToggleableDividerDemo({Key? key}) : super(key: key);

  @override
  State<ToggleableDividerDemo> createState() => _ToggleableDividerDemoState();
}

class _ToggleableDividerDemoState extends State<ToggleableDividerDemo> {
  bool _showDivider = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('上半部分内容'),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _showDivider
              ? const ZephyrDivider.horizontal(
                  color: Colors.blue,
                  thickness: 2,
                )
              : const SizedBox.shrink(),
        ),
        const Text('下半部分内容'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showDivider = !_showDivider;
            });
          },
          child: Text(_showDivider ? '隐藏分割线' : '显示分割线'),
        ),
      ],
    );
  }
}

// 虚线绘制器
class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}