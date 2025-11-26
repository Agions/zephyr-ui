import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/example_card.dart';

class DisplayComponentsDemo extends StatelessWidget {
  const DisplayComponentsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('展示组件'),
        elevation: 0,
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          _buildTableExample(),
          const SizedBox(height: 32),
          _buildListExample(),
          const SizedBox(height: 32),
          _buildTimelineExample(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTableExample(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildListExample(),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildTimelineExample(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTableExample(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildListExample(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildTimelineExample(),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '展示组件',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ZephyrUI 提供了多种展示组件，用于展示数据、列表、时间线等信息。',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTableExample() {
    return ExampleCard(
      title: '数据表格',
      code: '''DataTable(
  columns: [
    DataColumn(label: Text('姓名')),
    DataColumn(label: Text('年龄')),
    DataColumn(label: Text('职业')),
  ],
  rows: [
    DataRow(cells: [
      DataCell(Text('张三')),
      DataCell(Text('25')),
      DataCell(Text('工程师')),
    ]),
    DataRow(cells: [
      DataCell(Text('李四')),
      DataCell(Text('30')),
      DataCell(Text('设计师')),
    ]),
  ],
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础数据表格',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
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
                  _buildDataRow('赵六', 35, '经理', '在职'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '带排序的表格',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '用户列表',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Table(
                    border: TableBorder.all(color: Colors.grey[300]!),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        children: [
                          _buildTableHeader('姓名'),
                          _buildTableHeader('邮箱'),
                          _buildTableHeader('注册时间'),
                        ],
                      ),
                      TableRow(
                        children: [
                          _buildTableCell('张三'),
                          _buildTableCell('zhangsan@example.com'),
                          _buildTableCell('2024-01-15'),
                        ],
                      ),
                      TableRow(
                        children: [
                          _buildTableCell('李四'),
                          _buildTableCell('lisi@example.com'),
                          _buildTableCell('2024-01-20'),
                        ],
                      ),
                      TableRow(
                        children: [
                          _buildTableCell('王五'),
                          _buildTableCell('wangwu@example.com'),
                          _buildTableCell('2024-01-25'),
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

  Widget _buildTableHeader(String text) {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Text(text),
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

  Widget _buildListExample() {
    return ExampleCard(
      title: '列表组件',
      code: '''ListView(
  children: [
    ListTile(
      leading: Icon(Icons.mail),
      title: Text('邮件'),
      subtitle: Text('3 封未读'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    ),
    ListTile(
      leading: Icon(Icons.phone),
      title: Text('电话'),
      subtitle: Text('2 个未接'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    ),
  ],
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础列表',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 300,
            child: Card(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.mail, color: Colors.blue),
                    title: Text('邮件'),
                    subtitle: Text('3 封未读邮件'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.green),
                    title: Text('电话'),
                    subtitle: Text('2 个未接来电'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.message, color: Colors.purple),
                    title: Text('消息'),
                    subtitle: Text('5 条新消息'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.orange),
                    title: Text('通知'),
                    subtitle: Text('1 个新通知'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '带头像的列表',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 250,
            child: ListView(
              children: [
                _buildUserListTile('张三', 'zhangsan@example.com', '在线'),
                _buildUserListTile('李四', 'lisi@example.com', '离线'),
                _buildUserListTile('王五', 'wangwu@example.com', '忙碌'),
                _buildUserListTile('赵六', 'zhaoliu@example.com', '在线'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserListTile(String name, String email, String status) {
    Color statusColor;
    switch (status) {
      case '在线':
        statusColor = Colors.green;
        break;
      case '忙碌':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      child: ListTile(
        leading: Stack(
          children: [
            const CircleAvatar(
              child: Icon(Icons.person),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: const Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        title: Text(name),
        subtitle: Text(email),
        trailing: const Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildTimelineExample() {
    return ExampleCard(
      title: '时间线',
      code: '''Column(
  children: [
    _buildTimelineItem(
      '订单创建',
      '2024-01-01 10:00',
      Icons.receipt,
      Colors.blue,
    ),
    _buildTimelineItem(
      '订单支付',
      '2024-01-01 10:30',
      Icons.payment,
      Colors.green,
    ),
    _buildTimelineItem(
      '订单发货',
      '2024-01-02 09:00',
      Icons.local_shipping,
      Colors.orange,
    ),
  ],
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '垂直时间线',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '订单时间线',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildTimelineItem(
                    '订单创建',
                    '2024-01-01 10:00',
                    '用户创建了订单，等待支付',
                    Icons.receipt,
                    Colors.blue,
                    true,
                  ),
                  _buildTimelineItem(
                    '订单支付',
                    '2024-01-01 10:30',
                    '用户已完成支付',
                    Icons.payment,
                    Colors.green,
                    true,
                  ),
                  _buildTimelineItem(
                    '订单发货',
                    '2024-01-02 09:00',
                    '商家已发货，预计3天内送达',
                    Icons.local_shipping,
                    Colors.orange,
                    true,
                  ),
                  _buildTimelineItem(
                    '订单完成',
                    '等待中',
                    '等待用户确认收货',
                    Icons.check_circle,
                    Colors.grey,
                    false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    String title,
    String time,
    String description,
    IconData icon,
    Color color,
    bool completed,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: completed ? color : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 14,
                color: Colors.white,
              ),
            ),
            if (completed)
              const Container(
                width: 2,
                height: 40,
                color: Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: completed ? Colors.black : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
