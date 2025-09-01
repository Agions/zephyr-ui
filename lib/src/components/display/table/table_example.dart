// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'table.dart';

/// 表格组件示例
///
/// 展示ZephyrTable组件的各种用法和配置选项。
class ZephyrTableExample extends StatefulWidget {
  const ZephyrTableExample({Key? key}) : super(key: key);

  @override
  State<ZephyrTableExample> createState() => _ZephyrTableExampleState();
}

class _ZephyrTableExampleState extends State<ZephyrTableExample> {
  // 示例数据
  final List<Map<String, dynamic>> _users = [
    {'id': 1, 'name': '张三', 'email': 'zhangsan@example.com', 'age': 28, 'status': 'active'},
    {'id': 2, 'name': '李四', 'email': 'lisi@example.com', 'age': 32, 'status': 'inactive'},
    {'id': 3, 'name': '王五', 'email': 'wangwu@example.com', 'age': 25, 'status': 'active'},
    {'id': 4, 'name': '赵六', 'email': 'zhaoliu@example.com', 'age': 35, 'status': 'pending'},
    {'id': 5, 'name': '钱七', 'email': 'qianqi@example.com', 'age': 29, 'status': 'active'},
    {'id': 6, 'name': '孙八', 'email': 'sunba@example.com', 'age': 31, 'status': 'inactive'},
    {'id': 7, 'name': '周九', 'email': 'zhoujiu@example.com', 'age': 27, 'status': 'active'},
    {'id': 8, 'name': '吴十', 'email': 'wushi@example.com', 'age': 33, 'status': 'pending'},
    {'id': 9, 'name': '郑十一', 'email': 'zhengshiyi@example.com', 'age': 26, 'status': 'active'},
    {'id': 10, 'name': '王十二', 'email': 'wangshier@example.com', 'age': 30, 'status': 'inactive'},
  ];

  // 选中行
  final Set<Map<String, dynamic>> _selectedUsers = {};

  // 当前页码
  int _currentPage = 1;

  // 排序信息
  ZephyrTableSort? _currentSort;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('表格组件示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 基础表格
            _buildSectionTitle('基础表格'),
            _buildBasicTable(),
            const SizedBox(height: 32),
            
            // 可排序表格
            _buildSectionTitle('可排序表格'),
            _buildSortableTable(),
            const SizedBox(height: 32),
            
            // 可选择表格
            _buildSectionTitle('可选择表格'),
            _buildSelectableTable(),
            const SizedBox(height: 32),
            
            // 分页表格
            _buildSectionTitle('分页表格'),
            _buildPaginatedTable(),
            const SizedBox(height: 32),
            
            // 自定义单元格表格
            _buildSectionTitle('自定义单元格表格'),
            _buildCustomCellTable(),
            const SizedBox(height: 32),
            
            // 加载状态表格
            _buildSectionTitle('加载状态表格'),
            _buildLoadingTable(),
            const SizedBox(height: 32),
            
            // 空数据表格
            _buildSectionTitle('空数据表格'),
            _buildEmptyTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBasicTable() {
    return SizedBox(
      height: 300,
      child: ZephyrTable<Map<String, dynamic>>(
        data: _users.take(5).toList(),
        columns: const [
          ZephyrTableColumn<Map<String, dynamic>>(
            title: 'ID',
            dataKey: 'id',
            width: 80,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '姓名',
            dataKey: 'name',
            sortable: true,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '邮箱',
            dataKey: 'email',
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '年龄',
            dataKey: 'age',
            width: 80,
            alignment: Alignment.center,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '状态',
            dataKey: 'status',
            width: 100,
            alignment: Alignment.center,
          ),
        ],
        rowHeight: 48,
      ),
    );
  }

  Widget _buildSortableTable() {
    return SizedBox(
      height: 300,
      child: ZephyrTable<Map<String, dynamic>>(
        data: _users,
        columns: const [
          ZephyrTableColumn<Map<String, dynamic>>(
            title: 'ID',
            dataKey: 'id',
            width: 80,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '姓名',
            dataKey: 'name',
            sortable: true,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '邮箱',
            dataKey: 'email',
            sortable: true,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '年龄',
            dataKey: 'age',
            width: 80,
            sortable: true,
            alignment: Alignment.center,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '状态',
            dataKey: 'status',
            width: 100,
            alignment: Alignment.center,
          ),
        ],
        sort: _currentSort,
        onSort: (sort) {
          setState(() {
            _currentSort = sort;
          });
        },
        rowHeight: 48,
      ),
    );
  }

  Widget _buildSelectableTable() {
    return SizedBox(
      height: 300,
      child: ZephyrTable<Map<String, dynamic>>(
        data: _users.take(5).toList(),
        columns: const [
          ZephyrTableColumn<Map<String, dynamic>>(
            title: 'ID',
            dataKey: 'id',
            width: 80,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '姓名',
            dataKey: 'name',
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '邮箱',
            dataKey: 'email',
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '年龄',
            dataKey: 'age',
            width: 80,
            alignment: Alignment.center,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '状态',
            dataKey: 'status',
            width: 100,
            alignment: Alignment.center,
          ),
        ],
        selectable: true,
        selectedRows: _selectedUsers,
        onSelectionChanged: (selected) {
          setState(() {
            _selectedUsers.clear();
            _selectedUsers.addAll(selected);
          });
        },
        rowHeight: 48,
      ),
    );
  }

  Widget _buildPaginatedTable() {
    return SizedBox(
      height: 400,
      child: ZephyrTable<Map<String, dynamic>>(
        data: _users,
        columns: const [
          ZephyrTableColumn<Map<String, dynamic>>(
            title: 'ID',
            dataKey: 'id',
            width: 80,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '姓名',
            dataKey: 'name',
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '邮箱',
            dataKey: 'email',
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '年龄',
            dataKey: 'age',
            width: 80,
            alignment: Alignment.center,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '状态',
            dataKey: 'status',
            width: 100,
            alignment: Alignment.center,
          ),
        ],
        paginated: true,
        pageSize: 5,
        currentPage: _currentPage,
        onPageChange: (page, pageSize) {
          setState(() {
            _currentPage = page;
          });
        },
        rowHeight: 48,
      ),
    );
  }

  Widget _buildCustomCellTable() {
    return SizedBox(
      height: 300,
      child: ZephyrTable<Map<String, dynamic>>(
        data: _users.take(5).toList(),
        columns: [
          ZephyrTableColumn<Map<String, dynamic>>(
            title: 'ID',
            dataKey: 'id',
            width: 80,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '姓名',
            dataKey: 'name',
            cellBuilder: (context, data) {
              return Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(data['name'].toString()),
                ],
              );
            },
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '邮箱',
            dataKey: 'email',
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '年龄',
            dataKey: 'age',
            width: 80,
            alignment: Alignment.center,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '状态',
            dataKey: 'status',
            width: 100,
            alignment: Alignment.center,
            cellBuilder: (context, data) {
              final status = data['status'] as String;
              Color color;
              String text;
              
              switch (status) {
                case 'active':
                  color = Colors.green;
                  text = '活跃';
                  break;
                case 'inactive':
                  color = Colors.red;
                  text = '禁用';
                  break;
                case 'pending':
                  color = Colors.orange;
                  text = '待定';
                  break;
                default:
                  color = Colors.grey;
                  text = '未知';
              }
              
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ],
        rowHeight: 48,
      ),
    );
  }

  Widget _buildLoadingTable() {
    return SizedBox(
      height: 300,
      child: ZephyrTable<Map<String, dynamic>>(
        data: const [],
        columns: const [
          ZephyrTableColumn<Map<String, dynamic>>(
            title: 'ID',
            dataKey: 'id',
            width: 80,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '姓名',
            dataKey: 'name',
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '邮箱',
            dataKey: 'email',
          ),
        ],
        loading: true,
        rowHeight: 48,
      ),
    );
  }

  Widget _buildEmptyTable() {
    return SizedBox(
      height: 300,
      child: ZephyrTable<Map<String, dynamic>>(
        data: const [],
        columns: const [
          ZephyrTableColumn<Map<String, dynamic>>(
            title: 'ID',
            dataKey: 'id',
            width: 80,
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '姓名',
            dataKey: 'name',
          ),
          ZephyrTableColumn<Map<String, dynamic>>(
            title: '邮箱',
            dataKey: 'email',
          ),
        ],
        empty: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '暂无数据',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        rowHeight: 48,
      ),
    );
  }
}