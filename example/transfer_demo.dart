import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI Transfer 组件示例
///
/// 展示穿梭框组件的各种用法和配置选项
class TransferDemo extends StatefulWidget {
  const TransferDemo({Key? key}) : super(key: key);

  @override
  State<TransferDemo> createState() => _TransferDemoState();
}

class _TransferDemoState extends State<TransferDemo> {
  List<String> _selectedUsers = ['user3', 'user5'];
  List<String> _selectedProducts = [];
  List<String> _selectedTags = ['tag1', 'tag3'];
  List<String> _selectedSkills = [];

  // 用户数据
  final List<TransferItem> _users = [
    const TransferItem(key: 'user1', title: '张三', description: '前端开发工程师'),
    const TransferItem(key: 'user2', title: '李四', description: '后端开发工程师'),
    const TransferItem(key: 'user3', title: '王五', description: 'UI/UX 设计师'),
    const TransferItem(key: 'user4', title: '赵六', description: '产品经理'),
    const TransferItem(key: 'user5', title: '钱七', description: '测试工程师'),
    const TransferItem(key: 'user6', title: '孙八', description: '运维工程师'),
    const TransferItem(key: 'user7', title: '周九', description: '数据分析师'),
    const TransferItem(key: 'user8', title: '吴十', description: '架构师'),
  ];

  // 产品数据
  final List<TransferItem> _products = [
    const TransferItem(
        key: 'product1', title: 'iPhone 15', description: '苹果最新款手机'),
    const TransferItem(
        key: 'product2', title: 'MacBook Pro', description: '专业级笔记本电脑'),
    const TransferItem(
        key: 'product3', title: 'iPad Air', description: '轻薄平板电脑'),
    const TransferItem(
        key: 'product4', title: 'Apple Watch', description: '智能手表'),
    const TransferItem(
        key: 'product5', title: 'AirPods Pro', description: '降噪耳机'),
    const TransferItem(
        key: 'product6', title: 'Mac Studio', description: '桌面工作站'),
  ];

  // 标签数据
  final List<TransferItem> _tags = [
    const TransferItem(key: 'tag1', title: 'JavaScript', description: '前端开发语言'),
    const TransferItem(key: 'tag2', title: 'Python', description: '通用编程语言'),
    const TransferItem(key: 'tag3', title: 'React', description: '前端框架'),
    const TransferItem(key: 'tag4', title: 'Node.js', description: '后端运行时'),
    const TransferItem(key: 'tag5', title: 'Vue.js', description: '前端框架'),
    const TransferItem(
        key: 'tag6', title: 'Django', description: 'Python Web框架'),
    const TransferItem(key: 'tag7', title: 'Flutter', description: '跨平台框架'),
    const TransferItem(key: 'tag8', title: 'Docker', description: '容器化技术'),
  ];

  // 技能数据
  final List<TransferItem> _skills = [
    const TransferItem(key: 'skill1', title: 'UI设计', description: '用户界面设计'),
    const TransferItem(key: 'skill2', title: 'UX设计', description: '用户体验设计'),
    const TransferItem(key: 'skill3', title: '交互设计', description: '交互流程设计'),
    const TransferItem(key: 'skill4', title: '视觉设计', description: '视觉元素设计'),
    const TransferItem(key: 'skill5', title: '原型设计', description: '产品原型制作'),
    const TransferItem(key: 'skill6', title: '设计规范', description: '设计系统制定'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Transfer 组件示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('基本用法'),
            _buildBasicTransfer(),
            const SizedBox(height: 32),
            _buildSectionTitle('带搜索的穿梭框'),
            _buildSearchableTransfer(),
            const SizedBox(height: 32),
            _buildSectionTitle('自定义渲染'),
            _buildCustomRenderTransfer(),
            const SizedBox(height: 32),
            _buildSectionTitle('单向穿梭框'),
            _buildOneWayTransfer(),
            const SizedBox(height: 32),
            _buildSectionTitle('带操作的穿梭框'),
            _buildOperationsTransfer(),
            const SizedBox(height: 32),
            _buildSectionTitle('选中的数据'),
            _buildSelectedData(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildBasicTransfer() {
    return Card(
      elevation: 2,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '团队成员分配',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTransfer(
                dataSource: _users,
                targetKeys: _selectedUsers,
                titles: ['可选成员', '已选成员'],
                operations: ['添加', '移除'],
                onChanged: (keys) {
                  setState(() {
                    _selectedUsers = keys;
                  });
                  debugPrint('选中的成员: $keys');
                },
                onSelectedChange: (keys) {
                  debugPrint('当前选中的项: $keys');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchableTransfer() {
    return Card(
      elevation: 2,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '产品选择（带搜索）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTransfer(
                dataSource: _products,
                targetKeys: _selectedProducts,
                titles: ['可选产品', '已选产品'],
                operations: ['添加', '移除'],
                showSearch: true,
                searchPlaceholder: '搜索产品名称',
                filterOption: (text, item) {
                  return item.title
                          .toLowerCase()
                          .contains(text.toLowerCase()) ||
                      (item.description
                              ?.toLowerCase()
                              .contains(text.toLowerCase()) ??
                          false);
                },
                onChanged: (keys) {
                  setState(() {
                    _selectedProducts = keys;
                  });
                  debugPrint('选中的产品: $keys');
                },
                notFoundContent: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('未找到匹配的产品', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomRenderTransfer() {
    return Card(
      elevation: 2,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '技术标签选择（自定义渲染）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTransfer(
                dataSource: _tags,
                targetKeys: _selectedTags,
                titles: ['可用标签', '已选标签'],
                operations: ['添加', '移除'],
                showSearch: true,
                renderItem: (item) => const Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              item.description ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '技术',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onChanged: (keys) {
                  setState(() {
                    _selectedTags = keys;
                  });
                  debugPrint('选中的标签: $keys');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOneWayTransfer() {
    return Card(
      elevation: 2,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '技能选择（单向穿梭）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTransfer(
                dataSource: _skills,
                targetKeys: _selectedSkills,
                titles: ['可选技能', '我的技能'],
                operations: ['添加'],
                oneWay: true,
                showSearch: true,
                onChanged: (keys) {
                  setState(() {
                    _selectedSkills = keys;
                  });
                  debugPrint('选中的技能: $keys');
                },
                footer: (direction) {
                  if (direction == TransferDirection.right) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '已选择 ${_selectedSkills.length} 项技能',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedSkills.clear();
                            });
                          },
                          child: const Text('清空'),
                        ),
                      ],
                    );
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationsTransfer() {
    return Card(
      elevation: 2,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '权限管理（带操作）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTransfer(
                dataSource: [
                  TransferItem(
                      key: 'perm1', title: '用户管理', description: '管理用户账户'),
                  TransferItem(
                      key: 'perm2', title: '角色管理', description: '管理角色权限'),
                  TransferItem(
                      key: 'perm3', title: '系统设置', description: '系统配置管理'),
                  TransferItem(
                      key: 'perm4', title: '数据查看', description: '查看系统数据'),
                  TransferItem(
                      key: 'perm5', title: '数据导出', description: '导出系统数据'),
                  TransferItem(
                      key: 'perm6', title: '日志查看', description: '查看系统日志'),
                ],
                targetKeys: ['perm1', 'perm3'],
                titles: ['可用权限', '已分配权限'],
                operations: ['分配', '回收'],
                showSearch: true,
                onChanged: (keys) {
                  debugPrint('分配的权限: $keys');
                },
                renderItem: (item) => Row(
                  children: [
                    const Icon(
                      Icons.security,
                      size: 20,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.description ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedData() {
    return Card(
      elevation: 2,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '当前选中的数据',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            if (_selectedUsers.isNotEmpty) ...[
              Text('团队成员:', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _selectedUsers.map((key) {
                  final user = _users.firstWhere((u) => u.key == key);
                  return Chip(
                    label: Text(user.title),
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.blue),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
            ],
            if (_selectedProducts.isNotEmpty) ...[
              Text('产品:', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _selectedProducts.map((key) {
                  final product = _products.firstWhere((p) => p.key == key);
                  return Chip(
                    label: Text(product.title),
                    backgroundColor: Colors.green.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.green),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
            ],
            if (_selectedSkills.isNotEmpty) ...[
              Text('技能:', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _selectedSkills.map((key) {
                  final skill = _skills.firstWhere((s) => s.key == key);
                  return Chip(
                    label: Text(skill.title),
                    backgroundColor: Colors.purple.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.purple),
                  );
                }).toList(),
              ),
            ],
            if (_selectedUsers.isEmpty &&
                _selectedProducts.isEmpty &&
                _selectedSkills.isEmpty)
              Center(
                child: Text(
                  '暂无选中的数据',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
