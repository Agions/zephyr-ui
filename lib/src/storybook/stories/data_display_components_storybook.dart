import 'package:flutter/material.dart';
import 'package:chroma_ui/chroma_ui.dart';

/// 数据展示组件 Storybook 故事
class DataDisplayComponentsStorybook {
  /// 获取所有数据展示组件的故事
  static List<StorybookStory> getStories() {
    return [
      _tableStory(),
      _listStory(),
      _gridStory(),
      _cardListStory(),
      _timelineStory(),
      _treeViewStory(),
      _badgeListStory(),
      _progressIndicatorStory(),
      _statisticsCardStory(),
      _dataFilterStory(),
    ];
  }

  /// 表格组件故事
  static StorybookStory _tableStory() {
    return StorybookStory(
      name: 'chromaEnhancedTable',
      category: '数据展示组件',
      description: '企业级表格组件，支持排序、过滤、分页等功能',
      component: (context, controls) {
        // 示例数据
        final users = [
          {'id': 1, 'name': '张三', 'email': 'zhangsan@example.com', 'age': 25, 'status': 'active'},
          {'id': 2, 'name': '李四', 'email': 'lisi@example.com', 'age': 30, 'status': 'inactive'},
          {'id': 3, 'name': '王五', 'email': 'wangwu@example.com', 'age': 28, 'status': 'active'},
          {'id': 4, 'name': '赵六', 'email': 'zhaoliu@example.com', 'age': 35, 'status': 'pending'},
          {'id': 5, 'name': '钱七', 'email': 'qianqi@example.com', 'age': 22, 'status': 'active'},
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础表格', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: chromaEnhancedTable<Map<String, dynamic>>(
                columns: [
                  TableColumn(
                    title: 'ID',
                    key: 'id',
                    width: 80,
                    cellBuilder: (data) => Text(data['id'].toString()),
                  ),
                  TableColumn(
                    title: '姓名',
                    key: 'name',
                    width: 120,
                    cellBuilder: (data) => Text(data['name']),
                  ),
                  TableColumn(
                    title: '邮箱',
                    key: 'email',
                    width: 200,
                    cellBuilder: (data) => Text(data['email']),
                  ),
                  TableColumn(
                    title: '年龄',
                    key: 'age',
                    width: 80,
                    cellBuilder: (data) => Text(data['age'].toString()),
                    sortable: true,
                  ),
                  TableColumn(
                    title: '状态',
                    key: 'status',
                    width: 100,
                    cellBuilder: (data) => _buildStatusBadge(data['status']),
                  ),
                ],
                data: users,
                enableSorting: true,
                enablePagination: true,
                rowsPerPage: 5,
              ),
            ),
            const SizedBox(height: 24),
            const Text('带过滤的表格', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: chromaEnhancedTable<Map<String, dynamic>>(
                columns: [
                  TableColumn(
                    title: '产品',
                    key: 'product',
                    width: 150,
                    cellBuilder: (data) => Text(data['product']),
                  ),
                  TableColumn(
                    title: '类别',
                    key: 'category',
                    width: 120,
                    cellBuilder: (data) => Text(data['category']),
                    filterable: true,
                  ),
                  TableColumn(
                    title: '价格',
                    key: 'price',
                    width: 100,
                    cellBuilder: (data) => Text('¥${data['price']}'),
                    sortable: true,
                  ),
                  TableColumn(
                    title: '库存',
                    key: 'stock',
                    width: 80,
                    cellBuilder: (data) => Text(data['stock'].toString()),
                  ),
                  TableColumn(
                    title: '操作',
                    key: 'actions',
                    width: 120,
                    cellBuilder: (data) => Row(
                      children: [
                        chromaButton(
                          text: '编辑',
                          variant: 'secondary',
                          size: 'small',
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        chromaButton(
                          text: '删除',
                          variant: 'danger',
                          size: 'small',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
                data: [
                  {'product': 'iPhone 14', 'category': '手机', 'price': 5999, 'stock': 50},
                  {'product': 'MacBook Pro', 'category': '笔记本', 'price': 12999, 'stock': 25},
                  {'product': 'iPad Air', 'category': '平板', 'price': 3999, 'stock': 30},
                  {'product': 'Apple Watch', 'category': '手表', 'price': 2999, 'stock': 40},
                  {'product': 'AirPods Pro', 'category': '耳机', 'price': 1999, 'stock': 100},
                ],
                enableSorting: true,
                enableFiltering: true,
                enablePagination: true,
                rowsPerPage: 3,
              ),
            ),
          ],
        );
      },
      controls: [
        StorybookBooleanControl(
          label: '启用排序',
          defaultValue: true,
          description: '是否启用排序功能',
        ),
        StorybookBooleanControl(
          label: '启用过滤',
          defaultValue: true,
          description: '是否启用过滤功能',
        ),
        StorybookBooleanControl(
          label: '启用分页',
          defaultValue: true,
          description: '是否启用分页功能',
        ),
        StorybookNumberControl(
          label: '每页行数',
          defaultValue: 5,
          description: '每页显示的行数',
        ),
        StorybookBooleanControl(
          label: '显示边框',
          defaultValue: true,
          description: '是否显示表格边框',
        ),
      ],
      codeExample: '''
// 基础表格
chromaEnhancedTable<Map<String, dynamic>>(
  columns: [
    TableColumn(
      title: 'ID',
      key: 'id',
      width: 80,
      cellBuilder: (data) => Text(data['id'].toString()),
    ),
    TableColumn(
      title: '姓名',
      key: 'name',
      width: 120,
      cellBuilder: (data) => Text(data['name']),
    ),
    TableColumn(
      title: '邮箱',
      key: 'email',
      width: 200,
      cellBuilder: (data) => Text(data['email']),
    ),
  ],
  data: users,
  enableSorting: true,
  enablePagination: true,
  rowsPerPage: 5,
)

// 带过滤的表格
chromaEnhancedTable<Map<String, dynamic>>(
  columns: [
    TableColumn(
      title: '产品',
      key: 'product',
      width: 150,
      cellBuilder: (data) => Text(data['product']),
    ),
    TableColumn(
      title: '类别',
      key: 'category',
      width: 120,
      cellBuilder: (data) => Text(data['category']),
      filterable: true,
    ),
    TableColumn(
      title: '价格',
      key: 'price',
      width: 100,
      cellBuilder: (data) => Text('¥${data['price']}'),
      sortable: true,
    ),
  ],
  data: products,
  enableSorting: true,
  enableFiltering: true,
  enablePagination: true,
  rowsPerPage: 10,
)
''',
    );
  }

  /// 列表组件故事
  static StorybookStory _listStory() {
    return StorybookStory(
      name: 'chromaList',
      category: '数据展示组件',
      description: '灵活的列表组件，支持多种布局和交互',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaList(
            items: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('张三'),
                subtitle: const Text('zhangsan@example.com'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('李四'),
                subtitle: const Text('lisi@example.com'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('王五'),
                subtitle: const Text('wangwu@example.com'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('分组列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaList(
            groupBy: (item) => item['group'],
            groupHeaderBuilder: (group) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                group,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            items: [
              {'title': 'iPhone 14', 'subtitle': '最新款iPhone', 'group': '手机'},
              {'title': 'Samsung Galaxy S23', 'subtitle': '三星旗舰手机', 'group': '手机'},
              {'title': 'MacBook Pro', 'subtitle': '专业笔记本电脑', 'group': '电脑'},
              {'title': 'Dell XPS 13', 'subtitle: '轻薄笔记本电脑', 'group': '电脑'},
              {'title': 'iPad Air', 'subtitle': '轻薄平板', 'group': '平板'},
              {'title': 'Surface Pro', 'subtitle': '二合一平板', 'group': '平板'},
            ].map((item) => ListTile(
              leading: Icon(_getCategoryIcon(item['group'])),
              title: Text(item['title']),
              subtitle: Text(item['subtitle']),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            )).toList(),
          ),
          const SizedBox(height: 24),
          const Text('可选择列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          StatefulBuilder(
            builder: (context, setState) {
              final selectedItems = <String>{};

              return chromaList(
                selectionMode: ListSelectionMode.multiple,
                onSelectionChanged: (selected) {
                  setState(() {
                    selectedItems.clear();
                    selectedItems.addAll(selected);
                  });
                },
                items: [
                  {'id': '1', 'title': 'Flutter', 'subtitle': '跨平台UI框架'},
                  {'id': '2', 'title': 'React', 'subtitle': 'JavaScript库'},
                  {'id': '3', 'title': 'Vue', 'subtitle': '渐进式框架'},
                  {'id': '4', 'title': 'Angular', 'subtitle': '完整框架'},
                ].map((item) => ListTile(
                  leading: const Icon(Icons.code),
                  title: Text(item['title']),
                  subtitle: Text(item['subtitle']),
                  selected: selectedItems.contains(item['id']),
                )).toList(),
              );
            },
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '选择模式',
          defaultValue: 'none',
          options: ['none', 'single', 'multiple'],
          description: '列表的选择模式',
        ),
        StorybookBooleanControl(
          label: '启用分组',
          defaultValue: false,
          description: '是否启用分组',
        ),
        StorybookBooleanControl(
          label: '启用搜索',
          defaultValue: false,
          description: '是否启用搜索功能',
        ),
        StorybookBooleanControl(
          label: '启用排序',
          defaultValue: false,
          description: '是否启用排序功能',
        ),
      ],
      codeExample: '''
// 基础列表
chromaList(
  items: [
    ListTile(
      leading: Icon(Icons.person),
      title: Text('张三'),
      subtitle: Text('zhangsan@example.com'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    ),
    ListTile(
      leading: Icon(Icons.person),
      title: Text('李四'),
      subtitle: Text('lisi@example.com'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    ),
  ],
)

// 分组列表
chromaList(
  groupBy: (item) => item['category'],
  groupHeaderBuilder: (group) => Padding(
    padding: EdgeInsets.all(16),
    child: Text(
      group,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ),
  ),
  items: items.map((item) => ListTile(
    leading: Icon(_getCategoryIcon(item['category'])),
    title: Text(item['name']),
    subtitle: Text(item['description']),
    onTap: () {},
  )).toList(),
)

// 可选择列表
chromaList(
  selectionMode: ListSelectionMode.multiple,
  onSelectionChanged: (selected) {
    print('选中的项目: $selected');
  },
  items: items.map((item) => ListTile(
    leading: Icon(Icons.item),
    title: Text(item['title']),
    subtitle: Text(item['subtitle']),
  )).toList(),
)
''',
    );
  }

  /// 网格组件故事
  static StorybookStory _gridStory() {
    return StorybookStory(
      name: 'chromaGrid',
      category: '数据展示组件',
      description: '响应式网格组件，支持多种布局模式',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础网格', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaGrid(
            columns: 3,
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildGridItem('Flutter', '跨平台UI框架', Colors.blue),
              _buildGridItem('React', 'JavaScript库', Colors.cyan),
              _buildGridItem('Vue', '渐进式框架', Colors.green),
              _buildGridItem('Angular', '完整框架', Colors.red),
              _buildGridItem('Svelte', '编译型框架', Colors.orange),
              _buildGridItem('Next.js', 'React框架', Colors.purple),
            ],
          ),
          const SizedBox(height: 24),
          const Text('响应式网格', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaGrid(
            columns: ResponsiveGridValue(
              xs: 1,
              sm: 2,
              md: 3,
              lg: 4,
              xl: 5,
            ),
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildGridCard('项目 1', '这是项目 1 的描述', Icons.project),
              _buildGridCard('项目 2', '这是项目 2 的描述', Icons.project),
              _buildGridCard('项目 3', '这是项目 3 的描述', Icons.project),
              _buildGridCard('项目 4', '这是项目 4 的描述', Icons.project),
              _buildGridCard('项目 5', '这是项目 5 的描述', Icons.project),
              _buildGridCard('项目 6', '这是项目 6 的描述', Icons.project),
              _buildGridCard('项目 7', '这是项目 7 的描述', Icons.project),
              _buildGridCard('项目 8', '这是项目 8 的描述', Icons.project),
            ],
          ),
          const SizedBox(height: 24),
          const Text('可拖拽网格', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaGrid(
            columns: 3,
            spacing: 16,
            runSpacing: 16,
            draggable: true,
            onReorder: (oldIndex, newIndex) {
              print('项目从 $oldIndex 移动到 $newIndex');
            },
            children: [
              _buildDraggableItem('任务 1', Colors.blue),
              _buildDraggableItem('任务 2', Colors.green),
              _buildDraggableItem('任务 3', Colors.orange),
              _buildDraggableItem('任务 4', Colors.purple),
              _buildDraggableItem('任务 5', Colors.red),
              _buildDraggableItem('任务 6', Colors.cyan),
            ],
          ),
        ],
      ),
      controls: [
        StorybookNumberControl(
          label: '列数',
          defaultValue: 3,
          description: '网格的列数',
        ),
        StorybookNumberControl(
          label: '间距',
          defaultValue: 16,
          description: '网格项之间的间距',
        ),
        StorybookBooleanControl(
          label: '响应式',
          defaultValue: false,
          description: '是否启用响应式布局',
        ),
        StorybookBooleanControl(
          label: '可拖拽',
          defaultValue: false,
          description: '是否启用拖拽功能',
        ),
      ],
      codeExample: '''
// 基础网格
chromaGrid(
  columns: 3,
  spacing: 16,
  runSpacing: 16,
  children: [
    _buildGridItem('Flutter', '跨平台UI框架', Colors.blue),
    _buildGridItem('React', 'JavaScript库', Colors.cyan),
    _buildGridItem('Vue', '渐进式框架', Colors.green),
    _buildGridItem('Angular', '完整框架', Colors.red),
  ],
)

// 响应式网格
chromaGrid(
  columns: ResponsiveGridValue(
    xs: 1,
    sm: 2,
    md: 3,
    lg: 4,
    xl: 5,
  ),
  spacing: 16,
  runSpacing: 16,
  children: children,
)

// 可拖拽网格
chromaGrid(
  columns: 3,
  spacing: 16,
  runSpacing: 16,
  draggable: true,
  onReorder: (oldIndex, newIndex) {
    print('项目从 $oldIndex 移动到 $newIndex');
  },
  children: items,
)
''',
    );
  }

  /// 卡片列表组件故事
  static StorybookStory _cardListStory() {
    return StorybookStory(
      name: 'chromaCardList',
      category: '数据展示组件',
      description: '卡片列表组件，适用于展示结构化数据',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础卡片列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaCardList(
            items: [
              CardListItem(
                title: 'Flutter 开发',
                subtitle: '跨平台移动应用开发',
                leading: const Icon(Icons.mobile_app, color: Colors.blue),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              CardListItem(
                title: '移动开发',
                subtitle: '现代移动应用开发',
                leading: const Icon(Icons.smartphone, color: Colors.green),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              CardListItem(
                title: '后端开发',
                subtitle: '服务器端应用开发',
                leading: const Icon(Icons.storage, color: Colors.orange),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('带操作的卡片列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaCardList(
            items: [
              CardListItem(
                title: '用户管理',
                subtitle: '管理系统用户',
                leading: const Icon(Icons.people, color: Colors.blue),
                actions: [
                  chromaButton(
                    text: '编辑',
                    variant: 'secondary',
                    size: 'small',
                    onPressed: () {},
                  ),
                  chromaButton(
                    text: '删除',
                    variant: 'danger',
                    size: 'small',
                    onPressed: () {},
                  ),
                ],
              ),
              CardListItem(
                title: '角色管理',
                subtitle: '管理用户角色',
                leading: const Icon(Icons.admin_panel_settings, color: Colors.green),
                actions: [
                  chromaButton(
                    text: '编辑',
                    variant: 'secondary',
                    size: 'small',
                    onPressed: () {},
                  ),
                  chromaButton(
                    text: '删除',
                    variant: 'danger',
                    size: 'small',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('可选择卡片列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          StatefulBuilder(
            builder: (context, setState) {
              final selectedItems = <String>{};

              return chromaCardList(
                selectionMode: CardListSelectionMode.multiple,
                onSelectionChanged: (selected) {
                  setState(() {
                    selectedItems.clear();
                    selectedItems.addAll(selected);
                  });
                },
                items: [
                  CardListItem(
                    id: '1',
                    title: '任务 1',
                    subtitle: '完成项目文档',
                    leading: const Icon(Icons.task, color: Colors.blue),
                    selected: selectedItems.contains('1'),
                  ),
                  CardListItem(
                    id: '2',
                    title: '任务 2',
                    subtitle: '代码审查',
                    leading: const Icon(Icons.code, color: Colors.green),
                    selected: selectedItems.contains('2'),
                  ),
                  CardListItem(
                    id: '3',
                    title: '任务 3',
                    subtitle: '部署应用',
                    leading: const Icon(Icons.deployed_code, color: Colors.orange),
                    selected: selectedItems.contains('3'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '选择模式',
          defaultValue: 'none',
          options: ['none', 'single', 'multiple'],
          description: '卡片列表的选择模式',
        ),
        StorybookBooleanControl(
          label: '显示分隔线',
          defaultValue: true,
          description: '是否显示卡片之间的分隔线',
        ),
        StorybookBooleanControl(
          label: '圆角边框',
          defaultValue: true,
          description: '是否使用圆角边框',
        ),
        StorybookBooleanControl(
          label: '悬停效果',
          defaultValue: true,
          description: '是否启用悬停效果',
        ),
      ],
      codeExample: '''
// 基础卡片列表
chromaCardList(
  items: [
    CardListItem(
      title: 'Flutter 开发',
      subtitle: '跨平台移动应用开发',
      leading: Icon(Icons.mobile_app, color: Colors.blue),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    ),
    CardListItem(
      title: 'Web 开发',
      subtitle: '现代Web应用开发',
      leading: Icon(Icons.web, color: Colors.green),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    ),
  ],
)

// 带操作的卡片列表
chromaCardList(
  items: [
    CardListItem(
      title: '用户管理',
      subtitle: '管理系统用户',
      leading: Icon(Icons.people, color: Colors.blue),
      actions: [
        chromaButton(
          text: '编辑',
          variant: 'secondary',
          size: 'small',
          onPressed: () {},
        ),
        chromaButton(
          text: '删除',
          variant: 'danger',
          size: 'small',
          onPressed: () {},
        ),
      ],
    ),
  ],
)

// 可选择卡片列表
chromaCardList(
  selectionMode: CardListSelectionMode.multiple,
  onSelectionChanged: (selected) {
    print('选中的项目: $selected');
  },
  items: items,
)
''',
    );
  }

  /// 时间线组件故事
  static StorybookStory _timelineStory() {
    return StorybookStory(
      name: 'chromaTimeline',
      category: '数据展示组件',
      description: '时间线组件，用于展示事件序列',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础时间线', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaTimeline(
            items: [
              TimelineItem(
                title: '项目启动',
                subtitle: '项目正式启动',
                time: '2024-01-01',
                icon: Icons.flag,
                iconColor: Colors.blue,
              ),
              TimelineItem(
                title: '需求分析',
                subtitle: '完成需求收集和分析',
                time: '2024-01-15',
                icon: Icons.analytics,
                iconColor: Colors.green,
              ),
              TimelineItem(
                title: '设计阶段',
                subtitle: '完成UI/UX设计',
                time: '2024-02-01',
                icon: Icons.design_services,
                iconColor: Colors.orange,
              ),
              TimelineItem(
                title: '开发阶段',
                subtitle: '开始编码开发',
                time: '2024-02-15',
                icon: Icons.code,
                iconColor: Colors.purple,
              ),
              TimelineItem(
                title: '测试阶段',
                subtitle: '进行系统测试',
                time: '2024-03-01',
                icon: Icons.bug_report,
                iconColor: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('垂直时间线', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: chromaTimeline(
              direction: Axis.vertical,
              items: [
                TimelineItem(
                  title: '订单创建',
                  subtitle: '订单号: #12345',
                  time: '10:00',
                  icon: Icons.shopping_cart,
                  iconColor: Colors.blue,
                ),
                TimelineItem(
                  title: '支付完成',
                  subtitle: '支付方式: 支付宝',
                  time: '10:05',
                  icon: Icons.payment,
                  iconColor: Colors.green,
                ),
                TimelineItem(
                  title: '订单发货',
                  subtitle: '快递单号: SF123456789',
                  time: '10:30',
                  icon: Icons.local_shipping,
                  iconColor: Colors.orange,
                ),
                TimelineItem(
                  title: '订单完成',
                  subtitle: '用户已签收',
                  time: '14:00',
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('交替时间线', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaTimeline(
            alternate: true,
            items: [
              TimelineItem(
                title: '事件 1',
                subtitle: '这是第一个事件',
                time: '09:00',
                icon: Icons.event,
                iconColor: Colors.blue,
              ),
              TimelineItem(
                title: '事件 2',
                subtitle: '这是第二个事件',
                time: '10:00',
                icon: Icons.event,
                iconColor: Colors.green,
              ),
              TimelineItem(
                title: '事件 3',
                subtitle: '这是第三个事件',
                time: '11:00',
                icon: Icons.event,
                iconColor: Colors.orange,
              ),
              TimelineItem(
                title: '事件 4',
                subtitle: '这是第四个事件',
                time: '12:00',
                icon: Icons.event,
                iconColor: Colors.purple,
              ),
            ],
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '方向',
          defaultValue: 'horizontal',
          options: ['horizontal', 'vertical'],
          description: '时间线的方向',
        ),
        StorybookBooleanControl(
          label: '交替显示',
          defaultValue: false,
          description: '是否交替显示时间线项目',
        ),
        StorybookBooleanControl(
          label: '显示连接线',
          defaultValue: true,
          description: '是否显示时间线连接线',
        ),
        StorybookBooleanControl(
          label: '显示时间',
          defaultValue: true,
          description: '是否显示时间信息',
        ),
      ],
      codeExample: '''
// 基础时间线
chromaTimeline(
  items: [
    TimelineItem(
      title: '项目启动',
      subtitle: '项目正式启动',
      time: '2024-01-01',
      icon: Icons.flag,
      iconColor: Colors.blue,
    ),
    TimelineItem(
      title: '需求分析',
      subtitle: '完成需求收集和分析',
      time: '2024-01-15',
      icon: Icons.analytics,
      iconColor: Colors.green,
    ),
    TimelineItem(
      title: '设计阶段',
      subtitle: '完成UI/UX设计',
      time: '2024-02-01',
      icon: Icons.design_services,
      iconColor: Colors.orange,
    ),
  ],
)

// 垂直时间线
chromaTimeline(
  direction: Axis.vertical,
  items: items,
)

// 交替时间线
chromaTimeline(
  alternate: true,
  items: items,
)
''',
    );
  }

  /// 树形视图组件故事
  static StorybookStory _treeViewStory() {
    return StorybookStory(
      name: 'chromaTreeView',
      category: '数据展示组件',
      description: '树形视图组件，用于展示层级数据',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础树形视图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaTreeView(
            nodes: [
              TreeNode(
                title: '根节点',
                children: [
                  TreeNode(
                    title: '子节点 1',
                    children: [
                      TreeNode(title: '叶子节点 1-1'),
                      TreeNode(title: '叶子节点 1-2'),
                    ],
                  ),
                  TreeNode(
                    title: '子节点 2',
                    children: [
                      TreeNode(title: '叶子节点 2-1'),
                      TreeNode(title: '叶子节点 2-2'),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('文件系统树形视图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaTreeView(
            nodes: [
              TreeNode(
                title: 'src',
                icon: Icons.folder,
                iconColor: Colors.orange,
                children: [
                  TreeNode(
                    title: 'components',
                    icon: Icons.folder,
                    iconColor: Colors.orange,
                    children: [
                      TreeNode(
                        title: 'button.dart',
                        icon: Icons.description,
                        iconColor: Colors.blue,
                      ),
                      TreeNode(
                        title: 'input.dart',
                        icon: Icons.description,
                        iconColor: Colors.blue,
                      ),
                    ],
                  ),
                  TreeNode(
                    title: 'pages',
                    icon: Icons.folder,
                    iconColor: Colors.orange,
                    children: [
                      TreeNode(
                        title: 'home.dart',
                        icon: Icons.description,
                        iconColor: Colors.blue,
                      ),
                      TreeNode(
                        title: 'about.dart',
                        icon: Icons.description,
                        iconColor: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('可选择树形视图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          StatefulBuilder(
            builder: (context, setState) {
              final selectedNodes = <String>{};

              return chromaTreeView(
                selectionMode: TreeSelectionMode.multiple,
                onSelectionChanged: (selected) {
                  setState(() {
                    selectedNodes.clear();
                    selectedNodes.addAll(selected);
                  });
                },
                nodes: [
                  TreeNode(
                    id: '1',
                    title: '部门 1',
                    children: [
                      TreeNode(
                        id: '1-1',
                        title: '团队 1-1',
                        children: [
                          TreeNode(id: '1-1-1', title: '成员 1-1-1'),
                          TreeNode(id: '1-1-2', title: '成员 1-1-2'),
                        ],
                      ),
                      TreeNode(
                        id: '1-2',
                        title: '团队 1-2',
                        children: [
                          TreeNode(id: '1-2-1', title: '成员 1-2-1'),
                          TreeNode(id: '1-2-2', title: '成员 1-2-2'),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '选择模式',
          defaultValue: 'none',
          options: ['none', 'single', 'multiple'],
          description: '树形视图的选择模式',
        ),
        StorybookBooleanControl(
          label: '展开全部',
          defaultValue: false,
          description: '是否默认展开全部节点',
        ),
        StorybookBooleanControl(
          label: '显示图标',
          defaultValue: true,
          description: '是否显示节点图标',
        ),
        StorybookBooleanControl(
          label: '显示连接线',
          defaultValue: true,
          description: '是否显示节点连接线',
        ),
      ],
      codeExample: '''
// 基础树形视图
chromaTreeView(
  nodes: [
    TreeNode(
      title: '根节点',
      children: [
        TreeNode(
          title: '子节点 1',
          children: [
            TreeNode(title: '叶子节点 1-1'),
            TreeNode(title: '叶子节点 1-2'),
          ],
        ),
        TreeNode(
          title: '子节点 2',
          children: [
            TreeNode(title: '叶子节点 2-1'),
            TreeNode(title: '叶子节点 2-2'),
          ],
        ),
      ],
    ),
  ],
)

// 文件系统树形视图
chromaTreeView(
  nodes: [
    TreeNode(
      title: 'src',
      icon: Icons.folder,
      iconColor: Colors.orange,
      children: [
        TreeNode(
          title: 'components',
          icon: Icons.folder,
          iconColor: Colors.orange,
          children: [
            TreeNode(
              title: 'button.dart',
              icon: Icons.description,
              iconColor: Colors.blue,
            ),
          ],
        ),
      ],
    ),
  ],
)

// 可选择树形视图
chromaTreeView(
  selectionMode: TreeSelectionMode.multiple,
  onSelectionChanged: (selected) {
    print('选中的节点: $selected');
  },
  nodes: nodes,
)
''',
    );
  }

  /// 徽章列表组件故事
  static StorybookStory _badgeListStory() {
    return StorybookStory(
      name: 'chromaBadgeList',
      category: '数据展示组件',
      description: '徽章列表组件，用于展示标签和分类',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础徽章列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaBadgeList(
            badges: [
              BadgeItem(
                text: 'Flutter',
                variant: 'primary',
              ),
              BadgeItem(
                text: 'Dart',
                variant: 'secondary',
              ),
              BadgeItem(
                text: 'React',
                variant: 'success',
              ),
              BadgeItem(
                text: 'Vue',
                variant: 'warning',
              ),
              BadgeItem(
                text: 'Angular',
                variant: 'danger',
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('可删除徽章列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          StatefulBuilder(
            builder: (context, setState) {
              final badges = [
                BadgeItem(
                  id: '1',
                  text: 'JavaScript',
                  variant: 'primary',
                ),
                BadgeItem(
                  id: '2',
                  text: 'TypeScript',
                  variant: 'secondary',
                ),
                BadgeItem(
                  id: '3',
                  text: 'Python',
                  variant: 'success',
                ),
                BadgeItem(
                  id: '4',
                  text: 'Java',
                  variant: 'warning',
                ),
              ];

              return chromaBadgeList(
                deletable: true,
                onDelete: (badgeId) {
                  print('删除徽章: $badgeId');
                },
                badges: badges,
              );
            },
          ),
          const SizedBox(height: 24),
          const Text('可选择徽章列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          StatefulBuilder(
            builder: (context, setState) {
              final selectedBadges = <String>{};

              return chromaBadgeList(
                selectable: true,
                onSelectionChanged: (selected) {
                  setState(() {
                    selectedBadges.clear();
                    selectedBadges.addAll(selected);
                  });
                },
                badges: [
                  BadgeItem(
                    id: 'frontend',
                    text: '前端',
                    variant: 'primary',
                  ),
                  BadgeItem(
                    id: 'backend',
                    text: '后端',
                    variant: 'secondary',
                  ),
                  BadgeItem(
                    id: 'fullstack',
                    text: '全栈',
                    variant: 'success',
                  ),
                  BadgeItem(
                    id: 'mobile',
                    text: '移动端',
                    variant: 'warning',
                  ),
                  BadgeItem(
                    id: 'devops',
                    text: '运维',
                    variant: 'danger',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          const Text('带计数的徽章列表', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaBadgeList(
            showCounts: true,
            badges: [
              BadgeItem(
                text: '待办',
                variant: 'warning',
                count: 5,
              ),
              BadgeItem(
                text: '进行中',
                variant: 'primary',
                count: 12,
              ),
              BadgeItem(
                text: '已完成',
                variant: 'success',
                count: 28,
              ),
              BadgeItem(
                text: '已取消',
                variant: 'danger',
                count: 3,
              ),
            ],
          ),
        ],
      ),
      controls: [
        StorybookBooleanControl(
          label: '可删除',
          defaultValue: false,
          description: '是否可删除徽章',
        ),
        StorybookBooleanControl(
          label: '可选择',
          defaultValue: false,
          description: '是否可选择徽章',
        ),
        StorybookBooleanControl(
          label: '显示计数',
          defaultValue: false,
          description: '是否显示徽章计数',
        ),
        StorybookBooleanControl(
          label: '可换行',
          defaultValue: true,
          description: '是否允许徽章换行',
        ),
      ],
      codeExample: '''
// 基础徽章列表
chromaBadgeList(
  badges: [
    BadgeItem(
      text: 'Flutter',
      variant: 'primary',
    ),
    BadgeItem(
      text: 'Dart',
      variant: 'secondary',
    ),
    BadgeItem(
      text: 'React',
      variant: 'success',
    ),
  ],
)

// 可删除徽章列表
chromaBadgeList(
  deletable: true,
  onDelete: (badgeId) {
    print('删除徽章: $badgeId');
  },
  badges: badges,
)

// 可选择徽章列表
chromaBadgeList(
  selectable: true,
  onSelectionChanged: (selected) {
    print('选中的徽章: $selected');
  },
  badges: badges,
)

// 带计数的徽章列表
chromaBadgeList(
  showCounts: true,
  badges: [
    BadgeItem(
      text: '待办',
      variant: 'warning',
      count: 5,
    ),
    BadgeItem(
      text: '进行中',
      variant: 'primary',
      count: 12,
    ),
  ],
)
''',
    );
  }

  /// 进度指示器组件故事
  static StorybookStory _progressIndicatorStory() {
    return StorybookStory(
      name: 'chromaProgressIndicator',
      category: '数据展示组件',
      description: '进度指示器组件，支持多种进度显示方式',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('线性进度条', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Column(
            children: [
              chromaProgressIndicator(
                value: 0.3,
                label: '下载进度',
                showPercentage: true,
              ),
              const SizedBox(height: 16),
              chromaProgressIndicator(
                value: 0.7,
                label: '上传进度',
                variant: 'primary',
              ),
              const SizedBox(height: 16),
              chromaProgressIndicator(
                value: 0.5,
                label: '处理进度',
                variant: 'success',
                showPercentage: true,
              ),
              const SizedBox(height: 16),
              chromaProgressIndicator(
                value: null,
                label: '加载中...',
                variant: 'secondary',
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('圆形进度条', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: chromaProgressIndicator(
                  value: 0.3,
                  type: ProgressType.circular,
                  size: 60,
                  strokeWidth: 6,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: chromaProgressIndicator(
                  value: 0.7,
                  type: ProgressType.circular,
                  size: 60,
                  strokeWidth: 6,
                  variant: 'primary',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: chromaProgressIndicator(
                  value: 0.5,
                  type: ProgressType.circular,
                  size: 60,
                  strokeWidth: 6,
                  variant: 'success',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: chromaProgressIndicator(
                  value: null,
                  type: ProgressType.circular,
                  size: 60,
                  strokeWidth: 6,
                  variant: 'secondary',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('步骤进度条', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaProgressIndicator(
            type: ProgressType.stepper,
            steps: [
              StepItem(title: '开始', completed: true),
              StepItem(title: '进行中', active: true),
              StepItem(title: '待完成'),
              StepItem(title: '结束'),
            ],
          ),
          const SizedBox(height: 24),
          const Text('分段进度条', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaProgressIndicator(
            type: ProgressType.segmented,
            segments: [
              ProgressSegment(value: 0.2, color: Colors.blue),
              ProgressSegment(value: 0.3, color: Colors.green),
              ProgressSegment(value: 0.1, color: Colors.orange),
              ProgressSegment(value: 0.4, color: Colors.red),
            ],
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '类型',
          defaultValue: 'linear',
          options: ['linear', 'circular', 'stepper', 'segmented'],
          description: '进度指示器的类型',
        ),
        StorybookNumberControl(
          label: '进度值',
          defaultValue: 0.5,
          description: '进度值（0-1，null表示不确定）',
        ),
        StorybookSelectControl(
          label: '变体',
          defaultValue: 'primary',
          options: ['primary', 'secondary', 'success', 'warning', 'danger'],
          description: '进度指示器的视觉变体',
        ),
        StorybookBooleanControl(
          label: '显示百分比',
          defaultValue: false,
          description: '是否显示百分比',
        ),
        StorybookBooleanControl(
          label: '显示标签',
          defaultValue: false,
          description: '是否显示标签',
        ),
      ],
      codeExample: '''
// 线性进度条
chromaProgressIndicator(
  value: 0.7,
  label: '下载进度',
  showPercentage: true,
  variant: 'primary',
)

// 圆形进度条
chromaProgressIndicator(
  value: 0.5,
  type: ProgressType.circular,
  size: 60,
  strokeWidth: 6,
  variant: 'success',
)

// 步骤进度条
chromaProgressIndicator(
  type: ProgressType.stepper,
  steps: [
    StepItem(title: '开始', completed: true),
    StepItem(title: '进行中', active: true),
    StepItem(title: '待完成'),
    StepItem(title: '结束'),
  ],
)

// 分段进度条
chromaProgressIndicator(
  type: ProgressType.segmented,
  segments: [
    ProgressSegment(value: 0.2, color: Colors.blue),
    ProgressSegment(value: 0.3, color: Colors.green),
    ProgressSegment(value: 0.1, color: Colors.orange),
    ProgressSegment(value: 0.4, color: Colors.red),
  ],
)

// 不确定进度
chromaProgressIndicator(
  value: null,
  label: '加载中...',
  variant: 'secondary',
)
''',
    );
  }

  /// 统计卡片组件故事
  static StorybookStory _statisticsCardStory() {
    return StorybookStory(
      name: 'chromaStatisticsCard',
      category: '数据展示组件',
      description: '统计卡片组件，用于展示关键指标',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础统计卡片', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaGrid(
            columns: 2,
            spacing: 16,
            children: [
              chromaStatisticsCard(
                title: '总用户数',
                value: '12,345',
                subtitle: '较上月增长 15%',
                trend: StatisticsTrend.up,
                trendValue: '15%',
                icon: Icons.people,
                iconColor: Colors.blue,
              ),
              chromaStatisticsCard(
                title: '总收入',
                value: '¥234,567',
                subtitle: '较上月增长 8%',
                trend: StatisticsTrend.up,
                trendValue: '8%',
                icon: Icons.attach_money,
                iconColor: Colors.green,
              ),
              chromaStatisticsCard(
                title: '订单数',
                value: '1,234',
                subtitle: '较上月下降 3%',
                trend: StatisticsTrend.down,
                trendValue: '3%',
                icon: Icons.shopping_cart,
                iconColor: Colors.orange,
              ),
              chromaStatisticsCard(
                title: '转化率',
                value: '2.5%',
                subtitle: '与上月持平',
                trend: StatisticsTrend.stable,
                trendValue: '0%',
                icon: Icons.trending_up,
                iconColor: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('迷你统计卡片', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaGrid(
            columns: 4,
            spacing: 16,
            children: [
              chromaStatisticsCard(
                title: '浏览量',
                value: '45.6K',
                size: StatisticsSize.small,
                icon: Icons.visibility,
                iconColor: Colors.blue,
              ),
              chromaStatisticsCard(
                title: '点赞数',
                value: '1.2K',
                size: StatisticsSize.small,
                icon: Icons.thumb_up,
                iconColor: Colors.red,
              ),
              chromaStatisticsCard(
                title: '评论数',
                value: '234',
                size: StatisticsSize.small,
                icon: Icons.comment,
                iconColor: Colors.green,
              ),
              chromaStatisticsCard(
                title: '分享数',
                value: '89',
                size: StatisticsSize.small,
                icon: Icons.share,
                iconColor: Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('带图表的统计卡片', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaStatisticsCard(
            title: '周活跃用户',
            value: '8,456',
            subtitle: '过去7天的活跃用户数',
            trend: StatisticsTrend.up,
            trendValue: '12%',
            icon: Icons.show_chart,
            iconColor: Colors.blue,
            chart: Container(
              height: 60,
              child: const Placeholder(),
            ),
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '尺寸',
          defaultValue: 'normal',
          options: ['small', 'normal', 'large'],
          description: '统计卡片的尺寸',
        ),
        StorybookSelectControl(
          label: '趋势',
          defaultValue: 'up',
          options: ['up', 'down', 'stable'],
          description: '数据趋势',
        ),
        StorybookBooleanControl(
          label: '显示图标',
          defaultValue: true,
          description: '是否显示图标',
        ),
        StorybookBooleanControl(
          label: '显示趋势',
          defaultValue: true,
          description: '是否显示趋势信息',
        ),
        StorybookBooleanControl(
          label: '显示副标题',
          defaultValue: true,
          description: '是否显示副标题',
        ),
      ],
      codeExample: '''
// 基础统计卡片
chromaStatisticsCard(
  title: '总用户数',
  value: '12,345',
  subtitle: '较上月增长 15%',
  trend: StatisticsTrend.up,
  trendValue: '15%',
  icon: Icons.people,
  iconColor: Colors.blue,
)

// 迷你统计卡片
chromaStatisticsCard(
  title: '浏览量',
  value: '45.6K',
  size: StatisticsSize.small,
  icon: Icons.visibility,
  iconColor: Colors.blue,
)

// 带图表的统计卡片
chromaStatisticsCard(
  title: '周活跃用户',
  value: '8,456',
  subtitle: '过去7天的活跃用户数',
  trend: StatisticsTrend.up,
  trendValue: '12%',
  icon: Icons.show_chart,
  iconColor: Colors.blue,
  chart: Container(
    height: 60,
    child: LineChart(
      // 图表组件
    ),
  ),
)
''',
    );
  }

  /// 数据过滤器组件故事
  static StorybookStory _dataFilterStory() {
    return StorybookStory(
      name: 'chromaDataFilter',
      category: '数据展示组件',
      description: '数据过滤器组件，支持多种过滤条件',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础过滤器', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaDataFilter(
            filters: [
              FilterItem(
                label: '状态',
                type: FilterType.select,
                options: ['全部', '活跃', '禁用', '待审核'],
                value: '全部',
              ),
              FilterItem(
                label: '日期范围',
                type: FilterType.dateRange,
                value: null,
              ),
              FilterItem(
                label: '关键词',
                type: FilterType.search,
                placeholder: '搜索关键词...',
                value: '',
              ),
            ],
            onFilterChanged: (filters) {
              print('过滤条件: $filters');
            },
          ),
          const SizedBox(height: 24),
          const Text('高级过滤器', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaDataFilter(
            layout: FilterLayout.advanced,
            filters: [
              FilterItem(
                label: '产品类别',
                type: FilterType.multiSelect,
                options: ['电子产品', '服装', '食品', '图书'],
                value: [],
              ),
              FilterItem(
                label: '价格区间',
                type: FilterType.range,
                min: 0,
                max: 10000,
                value: RangeValues(0, 10000),
              ),
              FilterItem(
                label: '评分',
                type: FilterType.rating,
                value: 0,
              ),
              FilterItem(
                label: '品牌',
                type: FilterType.checkbox,
                options: ['苹果', '三星', '华为', '小米'],
                value: [],
              ),
            ],
            onFilterChanged: (filters) {
              print('高级过滤条件: $filters');
            },
          ),
          const SizedBox(height: 24),
          const Text='快速过滤器', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaDataFilter(
            layout: FilterLayout.quick,
            filters: [
              FilterItem(
                label: '时间',
                type: FilterType.quickSelect,
                options: ['今天', '本周', '本月', '本年'],
                value: '本周',
              ),
              FilterItem(
                label: '排序',
                type: FilterType.sort,
                options: ['最新', '最热', '推荐'],
                value: '最新',
              ),
            ],
            onFilterChanged: (filters) {
              print('快速过滤条件: $filters');
            },
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '布局',
          defaultValue: 'basic',
          options: ['basic', 'advanced', 'quick'],
          description: '过滤器的布局方式',
        ),
        StorybookBooleanControl(
          label: '显示重置按钮',
          defaultValue: true,
          description: '是否显示重置按钮',
        ),
        StorybookBooleanControl(
          label: '显示应用按钮',
          defaultValue: true,
          description: '是否显示应用按钮',
        ),
        StorybookBooleanControl(
          label: '实时过滤',
          defaultValue: false,
          description: '是否启用实时过滤',
        ),
      ],
      codeExample: '''
// 基础过滤器
chromaDataFilter(
  filters: [
    FilterItem(
      label: '状态',
      type: FilterType.select,
      options: ['全部', '活跃', '禁用', '待审核'],
      value: '全部',
    ),
    FilterItem(
      label: '日期范围',
      type: FilterType.dateRange,
      value: null,
    ),
    FilterItem(
      label: '关键词',
      type: FilterType.search,
      placeholder: '搜索关键词...',
      value: '',
    ),
  ],
  onFilterChanged: (filters) {
    print('过滤条件: $filters');
  },
)

// 高级过滤器
chromaDataFilter(
  layout: FilterLayout.advanced,
  filters: [
    FilterItem(
      label: '产品类别',
      type: FilterType.multiSelect,
      options: ['电子产品', '服装', '食品', '图书'],
      value: [],
    ),
    FilterItem(
      label: '价格区间',
      type: FilterType.range,
      min: 0,
      max: 10000,
      value: RangeValues(0, 10000),
    ),
  ],
  onFilterChanged: (filters) {
    print('高级过滤条件: $filters');
  },
)

// 快速过滤器
chromaDataFilter(
  layout: FilterLayout.quick,
  filters: [
    FilterItem(
      label: '时间',
      type: FilterType.quickSelect,
      options: ['今天', '本周', '本月', '本年'],
      value: '本周',
    ),
    FilterItem(
      label: '排序',
      type: FilterType.sort,
      options: ['最新', '最热', '推荐'],
      value: '最新',
    ),
  ],
  onFilterChanged: (filters) {
    print('快速过滤条件: $filters');
  },
)
''',
    );
  }

  /// 构建状态徽章
  static Widget _buildStatusBadge(String status) {
    Color color;
    String text;

    switch (status) {
      case 'active':
        color = Colors.green;
        text = '活跃';
        break;
      case 'inactive':
        color = Colors.grey;
        text = '禁用';
        break;
      case 'pending':
        color = Colors.orange;
        text = '待审核';
        break;
      default:
        color = Colors.blue;
        text = '未知';
    }

    return chromaBadge(
      text: text,
      variant: 'primary',
      backgroundColor: color.withOpacity(0.1),
      textColor: color,
    );
  }

  /// 获取分类图标
  static IconData _getCategoryIcon(String category) {
    switch (category) {
      case '手机':
        return Icons.smartphone;
      case '电脑':
        return Icons.laptop;
      case '平板':
        return Icons.tablet;
      default:
        return Icons.device_unknown;
    }
  }

  /// 构建网格项
  static Widget _buildGridItem(String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.grid_view,
            color: color,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 构建网格卡片
  static Widget _buildGridCard(String title, String subtitle, IconData icon) {
    return chromaCard(
      title: title,
      content: Text(subtitle),
      leading: Icon(icon, color: Colors.blue),
      onTap: () {},
    );
  }

  /// 构建可拖拽项
  static Widget _buildDraggableItem(String title, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.drag_handle, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
