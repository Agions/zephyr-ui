import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class ChipDemo extends StatefulWidget {
  const ChipDemo({Key? key}) : super(key: key);

  @override
  State<ChipDemo> createState() => _ChipDemoState();
}

class _ChipDemoState extends State<ChipDemo> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BasicChipDemo(),
    const StyleChipDemo(),
    const InteractiveChipDemo(),
    const AdvancedChipDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('标签组件演示'),
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
        title: const Text('关于标签组件'),
        content: const Text(
          'ZephyrChip 是一个多功能的标签组件，支持多种变体和交互模式，'
          '包括标准、可选择、过滤、输入和操作标签。',
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

// 基础标签演示
class BasicChipDemo extends StatelessWidget {
  const BasicChipDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础标签',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 标准标签
          _buildSection('标准标签', [
            ZephyrChip(
              label: 'Flutter',
              onPressed: () => _showMessage(context, '点击了 Flutter 标签'),
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: 'Dart',
              onPressed: () => _showMessage(context, '点击了 Dart 标签'),
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: 'React',
              onPressed: () => _showMessage(context, '点击了 React 标签'),
            ),
          ]),

          const SizedBox(height: 24),

          // 可选择标签
          _buildSection('可选择标签', [
            ZephyrChip.choice(
              label: '前端开发',
              selected: true,
              onSelected: (selected) =>
                  _showMessage(context, '前端开发: $selected'),
            ),
            const SizedBox(width: 8),
            ZephyrChip.choice(
              label: '后端开发',
              selected: false,
              onSelected: (selected) =>
                  _showMessage(context, '后端开发: $selected'),
            ),
            const SizedBox(width: 8),
            ZephyrChip.choice(
              label: '移动开发',
              selected: false,
              onSelected: (selected) =>
                  _showMessage(context, '移动开发: $selected'),
            ),
          ]),

          const SizedBox(height: 24),

          // 过滤标签
          _buildSection('过滤标签', [
            ZephyrChip.filter(
              label: '全部',
              selected: true,
              onSelected: (selected) => _showMessage(context, '全部: $selected'),
            ),
            const SizedBox(width: 8),
            ZephyrChip.filter(
              label: '进行中',
              selected: false,
              onSelected: (selected) => _showMessage(context, '进行中: $selected'),
            ),
            const SizedBox(width: 8),
            ZephyrChip.filter(
              label: '已完成',
              selected: false,
              onSelected: (selected) => _showMessage(context, '已完成: $selected'),
            ),
          ]),

          const SizedBox(height: 24),

          // 输入标签
          _buildSection('输入标签', [
            ZephyrChip.input(
              label: '标签1',
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () => _showMessage(context, '删除了 标签1'),
            ),
            const SizedBox(width: 8),
            ZephyrChip.input(
              label: '标签2',
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () => _showMessage(context, '删除了 标签2'),
            ),
            const SizedBox(width: 8),
            ZephyrChip.input(
              label: '标签3',
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () => _showMessage(context, '删除了 标签3'),
            ),
          ]),

          const SizedBox(height: 24),

          // 操作标签
          _buildSection('操作标签', [
            ZephyrChip.action(
              label: '添加',
              onPressed: () => _showMessage(context, '点击了添加按钮'),
            ),
            const SizedBox(width: 8),
            ZephyrChip.action(
              label: '编辑',
              onPressed: () => _showMessage(context, '点击了编辑按钮'),
            ),
            const SizedBox(width: 8),
            ZephyrChip.action(
              label: '删除',
              onPressed: () => _showMessage(context, '点击了删除按钮'),
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

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// 样式标签演示
class StyleChipDemo extends StatelessWidget {
  const StyleChipDemo({Key? key}) : super(key: key);

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

          // 带头像的标签
          _buildSection('带头像的标签', [
            ZephyrChip(
              label: '张三',
              avatar: ZephyrAvatar.text(
                text: '张',
                size: ZephyrAvatarSize.small,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: '李四',
              avatar: ZephyrAvatar.icon(
                icon: Icons.person,
                size: ZephyrAvatarSize.small,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: '王五',
              avatar: const Icon(Icons.star, size: 16),
              onPressed: () {},
            ),
          ]),

          const SizedBox(height: 24),

          // 颜色变体
          _buildSection('颜色变体', [
            ZephyrChip(
              label: '默认',
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: '成功',
              onPressed: () {},
              theme: ZephyrChipTheme(
                backgroundColor: Colors.green[100],
                selectedBackgroundColor: Colors.green,
                textColor: Colors.green[800],
                selectedTextColor: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: '警告',
              onPressed: () {},
              theme: ZephyrChipTheme(
                backgroundColor: Colors.orange[100],
                selectedBackgroundColor: Colors.orange,
                textColor: Colors.orange[800],
                selectedTextColor: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: '错误',
              onPressed: () {},
              theme: ZephyrChipTheme(
                backgroundColor: Colors.red[100],
                selectedBackgroundColor: Colors.red,
                textColor: Colors.red[800],
                selectedTextColor: Colors.white,
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 状态变体
          _buildSection('状态变体', [
            ZephyrChip.choice(
              label: '未选中',
              selected: false,
              onSelected: (selected) {},
            ),
            const SizedBox(width: 8),
            ZephyrChip.choice(
              label: '已选中',
              selected: true,
              onSelected: (selected) {},
            ),
            const SizedBox(width: 8),
            ZephyrChip.choice(
              label: '禁用',
              selected: false,
              enabled: false,
              onSelected: (selected) {},
            ),
          ]),

          const SizedBox(height: 24),

          // 技能标签
          _buildSection('技能标签', [
            ZephyrChip(
              label: 'Flutter',
              avatar: const Icon(Icons.code, size: 16),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: 'Dart',
              avatar: const Icon(Icons.language, size: 16),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: 'Firebase',
              avatar: const Icon(Icons.cloud, size: 16),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            ZephyrChip(
              label: 'REST API',
              avatar: const Icon(Icons.api, size: 16),
              onPressed: () {},
            ),
          ]),

          const SizedBox(height: 24),

          // 删除图标变体
          _buildSection('删除图标变体', [
            ZephyrChip.input(
              label: '默认删除',
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () {},
            ),
            const SizedBox(width: 8),
            ZephyrChip.input(
              label: '自定义删除',
              deleteIcon: const Icon(Icons.delete, size: 16),
              onDeleted: () {},
            ),
            const SizedBox(width: 8),
            ZephyrChip.input(
              label: '圆形删除',
              deleteIcon: const Icon(Icons.cancel, size: 16),
              onDeleted: () {},
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

// 交互标签演示
class InteractiveChipDemo extends StatefulWidget {
  const InteractiveChipDemo({Key? key}) : super(key: key);

  @override
  State<InteractiveChipDemo> createState() => _InteractiveChipDemoState();
}

class _InteractiveChipDemoState extends State<InteractiveChipDemo> {
  List<int> selectedChips = [];
  bool multiSelect = false;

  final List<ZephyrChipData> chips = [
    const ZephyrChipData(label: 'Flutter', avatar: Icon(Icons.code)),
    const ZephyrChipData(label: 'Dart', avatar: Icon(Icons.language)),
    const ZephyrChipData(label: 'React', avatar: Icon(Icons.web)),
    const ZephyrChipData(label: 'Vue', avatar: Icon(Icons.widgets)),
    const ZephyrChipData(label: 'Angular', avatar: Icon(Icons.polymer)),
  ];

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

          // 标签组
          _buildSection('标签组', [
            const Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('多选模式'),
                      Switch(
                        value: multiSelect,
                        onChanged: (value) {
                          setState(() {
                            multiSelect = value;
                            if (!multiSelect && selectedChips.isNotEmpty) {
                              selectedChips = [selectedChips.last];
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ZephyrChipGroup(
                    chips: chips,
                    selectedChips: selectedChips,
                    multiSelect: multiSelect,
                    onSelectionChanged: (selection) {
                      setState(() {
                        selectedChips = selection;
                      });
                      _showMessage(context, '选中了: $selection');
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    '选中了: ${selectedChips.map((i) => chips[i].label).join(', ')}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 过滤器标签
          _buildSection('过滤器标签', [
            const Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '任务过滤器',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ZephyrChip.filter(
                        label: '全部',
                        selected: true,
                        onSelected: (selected) =>
                            _showMessage(context, '全部: $selected'),
                      ),
                      ZephyrChip.filter(
                        label: '进行中',
                        selected: false,
                        onSelected: (selected) =>
                            _showMessage(context, '进行中: $selected'),
                      ),
                      ZephyrChip.filter(
                        label: '已完成',
                        selected: false,
                        onSelected: (selected) =>
                            _showMessage(context, '已完成: $selected'),
                      ),
                      ZephyrChip.filter(
                        label: '已取消',
                        selected: false,
                        onSelected: (selected) =>
                            _showMessage(context, '已取消: $selected'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 状态标签
          _buildSection('状态标签', [
            Row(
              children: [
                _buildStatusChip('在线', true),
                const SizedBox(width: 8),
                _buildStatusChip('离线', false),
                const SizedBox(width: 8),
                _buildStatusChip('忙碌', true, Colors.orange),
                const SizedBox(width: 8),
                _buildStatusChip('离开', false, Colors.red),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, bool isActive, [Color? activeColor]) {
    return ZephyrChip(
      label: label,
      avatar: const Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: isActive
              ? (activeColor ?? Colors.green)
              : (activeColor ?? Colors.grey),
          shape: BoxShape.circle,
        ),
      ),
      theme: ZephyrChipTheme(
        backgroundColor: isActive
            ? (activeColor?.withOpacity(0.1) ?? Colors.green[100])
            : (activeColor?.withOpacity(0.1) ?? Colors.grey[100]),
        textColor: isActive
            ? (activeColor ?? Colors.green)
            : (activeColor ?? Colors.grey),
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

// 高级标签演示
class AdvancedChipDemo extends StatefulWidget {
  const AdvancedChipDemo({Key? key}) : super(key: key);

  @override
  State<AdvancedChipDemo> createState() => _AdvancedChipDemoState();
}

class _AdvancedChipDemoState extends State<AdvancedChipDemo> {
  List<String> tags = ['Flutter', 'Dart'];
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTag() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        tags.add(_controller.text.trim());
        _controller.clear();
      });
      _showMessage(context, '添加标签: ${tags.last}');
    }
  }

  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
    _showMessage(context, '删除标签: $tag');
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

          // 输入标签
          _buildSection('输入标签', [
            const Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '标签输入',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags.map((tag) {
                      return ZephyrChip.input(
                        label: tag,
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => _removeTag(tag),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: '添加标签',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (_) => _addTag(),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _addTag,
                        child: Text('添加'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 动态标签
          _buildSection('动态标签', [
            const Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '实时标签流',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  StreamBuilder<List<String>>(
                    stream: _tagStream,
                    builder: (context, snapshot) {
                      final items = snapshot.data ?? _tags;

                      if (items.isEmpty) {
                        return const Center(
                          child: Text('暂无数据'),
                        );
                      }

                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: items.map((item) {
                          return ZephyrChip(
                            label: item,
                            onPressed: () =>
                                _showMessage(context, '点击标签: $item'),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _simulateTagUpdate,
                    child: Text('模拟标签更新'),
                  ),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 标签云
          _buildSection('标签云', [
            const Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '热门标签',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ZephyrChip(
                        label: 'Flutter',
                        onPressed: () => _showMessage(context, 'Flutter'),
                        theme: ZephyrChipTheme(
                          backgroundColor: Colors.blue[100],
                          textColor: Colors.blue[800],
                        ),
                      ),
                      ZephyrChip(
                        label: 'Dart',
                        onPressed: () => _showMessage(context, 'Dart'),
                        theme: ZephyrChipTheme(
                          backgroundColor: Colors.cyan[100],
                          textColor: Colors.cyan[800],
                        ),
                      ),
                      ZephyrChip(
                        label: 'React',
                        onPressed: () => _showMessage(context, 'React'),
                        theme: ZephyrChipTheme(
                          backgroundColor: Colors.blue[100],
                          textColor: Colors.blue[800],
                        ),
                      ),
                      ZephyrChip(
                        label: 'Vue',
                        onPressed: () => _showMessage(context, 'Vue'),
                        theme: ZephyrChipTheme(
                          backgroundColor: Colors.green[100],
                          textColor: Colors.green[800],
                        ),
                      ),
                      ZephyrChip(
                        label: 'Angular',
                        onPressed: () => _showMessage(context, 'Angular'),
                        theme: ZephyrChipTheme(
                          backgroundColor: Colors.red[100],
                          textColor: Colors.red[800],
                        ),
                      ),
                      ZephyrChip(
                        label: 'JavaScript',
                        onPressed: () => _showMessage(context, 'JavaScript'),
                        theme: ZephyrChipTheme(
                          backgroundColor: Colors.yellow[100],
                          textColor: Colors.yellow[800],
                        ),
                      ),
                      ZephyrChip(
                        label: 'TypeScript',
                        onPressed: () => _showMessage(context, 'TypeScript'),
                        theme: ZephyrChipTheme(
                          backgroundColor: Colors.blue[100],
                          textColor: Colors.blue[800],
                        ),
                      ),
                      ZephyrChip(
                        label: 'Python',
                        onPressed: () => _showMessage(context, 'Python'),
                        theme: ZephyrChipTheme(
                          backgroundColor: Colors.green[100],
                          textColor: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // 分类标签
          _buildSection('分类标签', [
            const Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '文章分类',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ZephyrChip(
                        label: '技术',
                        avatar: Icon(Icons.code, size: 16),
                        onPressed: () => _showMessage(context, '技术分类'),
                      ),
                      ZephyrChip(
                        label: '设计',
                        avatar: Icon(Icons.palette, size: 16),
                        onPressed: () => _showMessage(context, '设计分类'),
                      ),
                      ZephyrChip(
                        label: '产品',
                        avatar: Icon(Icons.lightbulb, size: 16),
                        onPressed: () => _showMessage(context, '产品分类'),
                      ),
                      ZephyrChip(
                        label: '运营',
                        avatar: Icon(Icons.trending_up, size: 16),
                        onPressed: () => _showMessage(context, '运营分类'),
                      ),
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

  void _simulateTagUpdate() {
    final newTags = [
      'Flutter ${DateTime.now().second}',
      'Dart ${DateTime.now().second}',
      'React ${DateTime.now().second}',
    ];
    _tagController.add(newTags);
  }

  // 模拟数据流
  final _tagController = StreamController<List<String>>.broadcast();
  final List<String> _tags = ['Flutter', 'Dart', 'React'];

  Stream<List<String>> get _tagStream => _tagController.stream;
}
