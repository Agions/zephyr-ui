import 'package:flutter/material.dart';

// 完整的组件示例应用
class CompleteComponentDemo extends StatefulWidget {
  const CompleteComponentDemo({super.key});

  @override
  State<CompleteComponentDemo> createState() => _CompleteComponentDemoState();
}

class _CompleteComponentDemoState extends State<CompleteComponentDemo> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeDemo(),
    const ButtonDemo(),
    const FormDemo(),
    const LayoutDemo(),
    const FeedbackDemo(),
    const AdvancedDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 完整组件示例'),
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
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: '按钮',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: '表单',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: '布局',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '反馈',
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
        title: const Text('关于 ZephyrUI'),
        content: const Text(
          'ZephyrUI 是一个专业的 Flutter UI 组件库，提供丰富的组件和主题系统，帮助开发者快速构建高质量的应用程序。',
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

// 首页演示
class HomeDemo extends StatelessWidget {
  const HomeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 欢迎横幅
          const Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '欢迎使用 ZephyrUI',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '专业的 Flutter UI 组件库',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                  child: Text('开始使用'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // 功能特性
          const Text(
            '核心特性',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: [
              _buildFeatureCard(
                Icons.palette,
                '主题系统',
                '支持深色/浅色主题，完全可定制',
                Colors.blue,
              ),
              _buildFeatureCard(
                Icons.devices,
                '响应式设计',
                '适配手机、平板、桌面等多种设备',
                Colors.green,
              ),
              _buildFeatureCard(
                Icons.accessibility,
                '无障碍设计',
                '符合 WCAG 标准，支持屏幕阅读器',
                Colors.purple,
              ),
              _buildFeatureCard(
                Icons.speed,
                '高性能',
                '优化的渲染性能，流畅的用户体验',
                Colors.orange,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // 组件预览
          const Text(
            '组件预览',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildComponentPreview(),

          const SizedBox(height: 32),

          // 快速开始
          const Text(
            '快速开始',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          const Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. 添加依赖',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'dependencies:\n  zephyr_ui: ^0.3.0',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '2. 导入并使用',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'import \'package:zephyr_ui/zephyr_ui.dart\';\n\nZephyrButton(\n  text: \'点击我\',\n  onPressed: () {},\n)',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      IconData icon, String title, String description, Color color) {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: color),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentPreview() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('主要按钮'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('次要按钮'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: '输入框',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text('评分'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.toggle_on, color: Colors.blue),
                    Text('开关'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.check_box, color: Colors.green),
                    Text('复选框'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 按钮组件演示
class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '按钮组件',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 基础按钮
          _buildSection('基础按钮', [
            ElevatedButton(
              onPressed: () {},
              child: const Text('主要按钮'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {},
              child: const Text('次要按钮'),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {},
              child: const Text('文本按钮'),
            ),
          ]),

          const SizedBox(height: 24),

          // 按钮状态
          _buildSection('按钮状态', [
            ElevatedButton(
              onPressed: () {},
              child: const Text('正常状态'),
            ),
            const SizedBox(width: 8),
            const ElevatedButton(
              onPressed: null,
              child: Text('禁用状态'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('加载中'),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 图标按钮
          _buildSection('图标按钮', [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save),
              label: const Text('保存'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete),
              label: const Text('删除'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 按钮组
          _buildSection('按钮组', [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('上一步'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('下一步'),
                  ),
                ),
              ],
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

// 表单组件演示
class FormDemo extends StatelessWidget {
  const FormDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '表单组件',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: '用户名',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: '邮箱',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: '密码',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text('记住我'),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text('忘记密码？'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('登录'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '其他表单组件',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // 开关
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('通知'),
                      Switch(value: true, onChanged: (value) {}),
                    ],
                  ),
                  Divider(),
                  // 滑块
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('音量'),
                      Slider(
                        value: 0.7,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Divider(),
                  // 单选按钮
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('性别'),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'male',
                            groupValue: 'male',
                            onChanged: (value) {},
                          ),
                          Text('男'),
                          Radio<String>(
                            value: 'female',
                            groupValue: 'male',
                            onChanged: (value) {},
                          ),
                          Text('女'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 布局组件演示
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '布局组件',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 卡片布局
          _buildSection('卡片布局', [
            Card(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '用户名',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'user@example.com',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text('这是卡片的内容描述，可以包含任何信息。'),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('取消'),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('确认'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 网格布局
          _buildSection('网格布局', [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
              children: [
                _buildGridItem(Icons.home, '首页'),
                _buildGridItem(Icons.search, '搜索'),
                _buildGridItem(Icons.person, '个人'),
                _buildGridItem(Icons.settings, '设置'),
              ],
            ),
          ]),

          const SizedBox(height: 24),

          // 列表布局
          _buildSection('列表布局', [
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildListItem(Icons.mail, '邮件', '3 封未读'),
                _buildListItem(Icons.phone, '电话', '2 个未接'),
                _buildListItem(Icons.message, '消息', '5 条新消息'),
                _buildListItem(Icons.notification_add, '通知', '1 个新通知'),
              ],
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

  Widget _buildGridItem(IconData icon, String label) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, String subtitle) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}

// 反馈组件演示
class FeedbackDemo extends StatelessWidget {
  const FeedbackDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '反馈组件',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 提示信息
          _buildSection('提示信息', [
            const Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue[700]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '提示',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        Text('这是一条信息提示'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 进度指示器
          _buildSection('进度指示器', [
            const Column(
              children: [
                LinearProgressIndicator(value: 0.7),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0%'),
                    Text('70%'),
                    Text('100%'),
                  ],
                ),
              ],
            ),
          ]),

          const SizedBox(height: 24),

          // 徽章
          _buildSection('徽章', [
            Row(
              children: [
                Stack(
                  children: [
                    const Icon(Icons.notifications),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: const Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Stack(
                  children: [
                    const Icon(Icons.mail),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: const Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          'New',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),

          const SizedBox(height: 24),

          // 工具提示
          _buildSection('工具提示', [
            Tooltip(
              message: '点击查看详情',
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('悬停查看提示'),
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

// 高级组件演示
class AdvancedDemo extends StatelessWidget {
  const AdvancedDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '高级组件',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 标签页
          _buildSection('标签页', [
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: '标签1'),
                      Tab(text: '标签2'),
                      Tab(text: '标签3'),
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                    child: TabBarView(
                      children: [
                        _buildTabContent('标签1 内容'),
                        _buildTabContent('标签2 内容'),
                        _buildTabContent('标签3 内容'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 数据表格
          _buildSection('数据表格', [
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('姓名')),
                    DataColumn(label: Text('年龄')),
                    DataColumn(label: Text('职业')),
                    DataColumn(label: Text('状态')),
                  ],
                  rows: [
                    _buildDataRow('张三', 25, '工程师', '在职'),
                    _buildDataRow('李四', 30, '设计师', '在职'),
                    _buildDataRow('王五', 28, '产品经理', '休假'),
                  ],
                ),
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 时间选择器
          _buildSection('时间选择器', [
            ElevatedButton(
              onPressed: () => _showDatePicker(context),
              child: const Text('选择日期'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _showTimePicker(context),
              child: const Text('选择时间'),
            ),
          ]),

          const SizedBox(height: 24),

          // 底部操作表
          _buildSection('底部操作表', [
            ElevatedButton(
              onPressed: () => _showBottomSheet(context),
              child: const Text('显示底部表单'),
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

  Widget _buildTabContent(String content) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  DataRow _buildDataRow(String name, int age, String job, String status) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text('$age')),
        DataCell(Text(job)),
        DataCell(
          const Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status == '在职' ? Colors.green[100] : Colors.orange[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: status == '在职' ? Colors.green[800] : Colors.orange[800],
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
  }

  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '选择操作',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('编辑'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('分享'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('删除'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
