import 'package:flutter/material.dart';
import 'index.dart';

class DisplayComponentsDemo extends StatefulWidget {
  const DisplayComponentsDemo({Key? key}) : super(key: key);

  @override
  State<DisplayComponentsDemo> createState() => _DisplayComponentsDemoState();
}

class _DisplayComponentsDemoState extends State<DisplayComponentsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Display Components'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Calendar Component'),
          _buildCalendarDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('List Component'),
          _buildListDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Statistic Component'),
          _buildStatisticDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Table Component'),
          _buildTableDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Timeline Component'),
          _buildTimelineDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Data Grid Component'),
          _buildDataGridDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Card Grid Component'),
          _buildCardGridDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Progress Indicators Component'),
          _buildProgressIndicatorsDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Status Indicators Component'),
          _buildStatusIndicatorsDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Badge Displays Component'),
          _buildBadgeDisplaysDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Avatar Groups Component'),
          _buildAvatarGroupsDemo(),
          
          const SizedBox(height: 32),
          _buildSectionTitle('Tag Clouds Component'),
          _buildTagCloudsDemo(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildCalendarDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calendar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 400,
              child: ZephyrCalendar(
                events: [
                  ZephyrCalendarEvent(
                    id: '1',
                    title: '团队会议',
                    start: DateTime.now(),
                    end: DateTime.now().add(const Duration(hours: 2)),
                    color: Colors.blue,
                  ),
                  ZephyrCalendarEvent(
                    id: '2',
                    title: '项目评审',
                    start: DateTime.now().add(const Duration(days: 1)),
                    end: DateTime.now().add(const Duration(days: 1, hours: 3)),
                    color: Colors.green,
                  ),
                ],
                onDateSelected: (dates) {
                  if (dates.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selected: ${dates.first}')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'List',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrList(
                items: [
                  ZephyrListItem(
                    id: '1',
                    title: '项目 A',
                    subtitle: '正在进行中',
                    description: '这是一个重要的项目，需要按时完成',
                    extra: '80%',
                  ),
                  ZephyrListItem(
                    id: '2',
                    title: '项目 B',
                    subtitle: '已完成',
                    description: '项目已经成功交付',
                    extra: '100%',
                  ),
                  ZephyrListItem(
                    id: '3',
                    title: '项目 C',
                    subtitle: '计划中',
                    description: '准备开始的新项目',
                    extra: '0%',
                  ),
                ],
                onItemTap: (item) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clicked: ${item.title}')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ZephyrStatisticGroup(
              statistics: [
                ZephyrStatistic(
                  title: '总收入',
                  value: '¥125,430',
                  description: '较上月增长',
                  trendValue: '12.5%',
                  trend: ZephyrStatisticTrend.up,
                  type: ZephyrStatisticType.primary,
                ),
                ZephyrStatistic(
                  title: '活跃用户',
                  value: '8,234',
                  description: '日活跃用户',
                  trendValue: '5.2%',
                  trend: ZephyrStatisticTrend.up,
                  type: ZephyrStatisticType.success,
                ),
                ZephyrStatistic(
                  title: '转化率',
                  value: '68.5%',
                  description: '用户转化率',
                  trendValue: '2.1%',
                  trend: ZephyrStatisticTrend.down,
                  type: ZephyrStatisticType.warning,
                ),
                ZephyrStatistic(
                  title: '错误率',
                  value: '0.3%',
                  description: '系统错误率',
                  trendValue: '0.1%',
                  trend: ZephyrStatisticTrend.down,
                  type: ZephyrStatisticType.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableDemo() {
    final data = [
      {'name': '张三', 'email': 'zhangsan@example.com', 'role': '开发者'},
      {'name': '李四', 'email': 'lisi@example.com', 'role': '设计师'},
      {'name': '王五', 'email': 'wangwu@example.com', 'role': '产品经理'},
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Table',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTable(
                data: data,
                columns: [
                  ZephyrTableColumn(
                    title: '姓名',
                    dataKey: 'name',
                    sortable: true,
                  ),
                  ZephyrTableColumn(
                    title: '邮箱',
                    dataKey: 'email',
                    filterable: true,
                  ),
                  ZephyrTableColumn(
                    title: '角色',
                    dataKey: 'role',
                  ),
                ],
                onRowTap: (row) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: ${row['name']}')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Timeline',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTimeline(
                nodes: [
                  ZephyrTimelineNode(
                    id: '1',
                    title: '项目启动',
                    description: '项目正式启动',
                    status: ZephyrTimelineNodeStatus.completed,
                    time: DateTime(2024, 1, 1),
                  ),
                  ZephyrTimelineNode(
                    id: '2',
                    title: '需求分析',
                    description: '完成需求分析文档',
                    status: ZephyrTimelineNodeStatus.processing,
                    time: DateTime(2024, 1, 15),
                  ),
                  ZephyrTimelineNode(
                    id: '3',
                    title: '设计阶段',
                    description: 'UI/UX设计',
                    status: ZephyrTimelineNodeStatus.pending,
                    time: DateTime(2024, 2, 1),
                  ),
                ],
                onNodeTap: (node) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clicked: ${node.title}')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataGridDemo() {
    final data = [
      {'name': '产品A', 'price': 99.99, 'stock': 100, 'category': '电子产品'},
      {'name': '产品B', 'price': 199.99, 'stock': 50, 'category': '家居'},
      {'name': '产品C', 'price': 299.99, 'stock': 200, 'category': '服装'},
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data Grid',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrDataGrid(
                data: data,
                columns: [
                  ZephyrDataGridColumn(
                    title: '产品名称',
                    dataKey: 'name',
                    editable: true,
                  ),
                  ZephyrDataGridColumn(
                    title: '价格',
                    dataKey: 'price',
                    formatter: (value) => '¥$value',
                  ),
                  ZephyrDataGridColumn(
                    title: '库存',
                    dataKey: 'stock',
                  ),
                  ZephyrDataGridColumn(
                    title: '分类',
                    dataKey: 'category',
                  ),
                ],
                onCellTap: (row, column, value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cell: $value')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardGridDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Card Grid',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 400,
              child: ZephyrCardGrid(
                items: [
                  ZephyrCardGridItem(
                    id: '1',
                    title: '现代设计',
                    subtitle: '简约而不简单',
                    description: '采用最新的设计理念，打造极致用户体验',
                    imageUrl: 'https://via.placeholder.com/300x200',
                  ),
                  ZephyrCardGridItem(
                    id: '2',
                    title: '响应式布局',
                    subtitle: '适配各种设备',
                    description: '完美支持桌面端和移动端，确保最佳显示效果',
                    imageUrl: 'https://via.placeholder.com/300x200',
                  ),
                  ZephyrCardGridItem(
                    id: '3',
                    title: '性能优化',
                    subtitle: '极速加载体验',
                    description: '通过多种优化手段，提供流畅的用户体验',
                    imageUrl: 'https://via.placeholder.com/300x200',
                  ),
                  ZephyrCardGridItem(
                    id: '4',
                    title: '安全可靠',
                    subtitle: '数据安全保障',
                    description: '采用最新的安全技术，保护用户数据安全',
                    imageUrl: 'https://via.placeholder.com/300x200',
                  ),
                ],
                onItemTap: (item) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clicked: ${item.title}')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicatorsDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress Indicators',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ZephyrProgressIndicator(
                        type: ZephyrProgressType.linear,
                        value: 0.75,
                        style: ZephyrProgressStyle.primary,
                        showValue: true,
                      ),
                      const SizedBox(height: 16),
                      ZephyrProgressIndicator(
                        type: ZephyrProgressType.circular,
                        value: 0.5,
                        style: ZephyrProgressStyle.success,
                        showValue: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      ZephyrProgressIndicator(
                        type: ZephyrProgressType.ring,
                        value: 0.9,
                        style: ZephyrProgressStyle.warning,
                        showValue: true,
                      ),
                      const SizedBox(height: 16),
                      ZephyrProgressIndicator(
                        type: ZephyrProgressType.wave,
                        value: 0.3,
                        style: ZephyrProgressStyle.error,
                        showValue: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicatorsDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status Indicators',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  label: '已完成',
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.warning,
                  label: '警告',
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.error,
                  label: '错误',
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.processing,
                  label: '处理中',
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.pending,
                  label: '等待中',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeDisplaysDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Badge Displays',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ZephyrBadge(
                  text: 'New',
                  type: ZephyrBadgeType.primary,
                ),
                ZephyrBadge(
                  text: 'Success',
                  type: ZephyrBadgeType.success,
                ),
                ZephyrBadge(
                  text: 'Warning',
                  type: ZephyrBadgeType.warning,
                ),
                ZephyrBadge(
                  text: 'Error',
                  type: ZephyrBadgeType.error,
                ),
                ZephyrBadge(
                  text: 'Info',
                  type: ZephyrBadgeType.info,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ZephyrDotBadge(
                  count: 5,
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue,
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                ZephyrDotBadge(
                  isDot: true,
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.green,
                    child: const Icon(Icons.mail, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarGroupsDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Avatar Groups',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ZephyrAvatar(
                  name: '张三',
                  size: ZephyrAvatarSize.medium,
                ),
                const SizedBox(width: 8),
                ZephyrAvatar(
                  name: '李四',
                  size: ZephyrAvatarSize.medium,
                ),
                const SizedBox(width: 8),
                ZephyrAvatar(
                  name: '王五',
                  size: ZephyrAvatarSize.medium,
                ),
                const SizedBox(width: 16),
                ZephyrAvatarGroup(
                  avatars: [
                    ZephyrAvatar(name: '用户A', size: ZephyrAvatarSize.small),
                    ZephyrAvatar(name: '用户B', size: ZephyrAvatarSize.small),
                    ZephyrAvatar(name: '用户C', size: ZephyrAvatarSize.small),
                    ZephyrAvatar(name: '用户D', size: ZephyrAvatarSize.small),
                  ],
                  stacked: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagCloudsDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tag Clouds',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ZephyrTagCloud(
              tags: [
                ZephyrTag(text: 'Flutter', type: ZephyrTagType.primary),
                ZephyrTag(text: 'Dart', type: ZephyrTagType.success),
                ZephyrTag(text: 'React', type: ZephyrTagType.warning),
                ZephyrTag(text: 'Vue', type: ZephyrTagType.error),
                ZephyrTag(text: 'Angular', type: ZephyrTagType.info),
                ZephyrTag(text: 'JavaScript', type: ZephyrTagType.default_),
                ZephyrTag(text: 'TypeScript', type: ZephyrTagType.primary),
                ZephyrTag(text: 'Node.js', type: ZephyrTagType.success),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Selectable Tags',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ZephyrSelectableTagCloud(
              options: ['Frontend', 'Backend', 'Full Stack', 'Mobile', 'Desktop'],
              selectedTags: ['Frontend'],
              onSelectionChanged: (selected) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: $selected')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}