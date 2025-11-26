import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrChip 组件示例
///
/// 展示了 ZephyrChip 组件的各种变体和用法
class ZephyrChipExample extends StatelessWidget {
  /// 创建一个新的 ZephyrChipExample 实例
  const ZephyrChipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrChip 示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题和描述
            const Text(
              '芯片组件示例',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '展示 ZephyrChip 组件的各种变体和用法',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // 芯片变体示例
            const Text(
              '芯片变体',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // 标准芯片
                ZephyrChip(
                  label: '标准芯片',
                  onPressed: () => debugPrint('标准芯片点击'),
                ),
                // 可选择芯片
                ZephyrChip.choice(
                  label: '可选择芯片',
                  selected: true,
                  onSelected: (selected) => debugPrint('可选择芯片: $selected'),
                ),
                // 过滤芯片
                ZephyrChip.filter(
                  label: '过滤芯片',
                  selected: false,
                  onSelected: (selected) => debugPrint('过滤芯片: $selected'),
                ),
                // 输入芯片
                ZephyrChip.input(
                  label: '输入芯片',
                  onDeleted: () => debugPrint('输入芯片删除'),
                ),
                // 操作芯片
                ZephyrChip.action(
                  label: '操作芯片',
                  onPressed: () => debugPrint('操作芯片点击'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 带头像的芯片示例
            const Text(
              '带头像的芯片',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // 带图片头像的芯片
                ZephyrChip(
                  label: '张三',
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage('https://picsum.photos/100/100'),
                  ),
                  onPressed: () => debugPrint('带图片头像的芯片点击'),
                ),
                // 带图标头像的芯片
                ZephyrChip(
                  label: '李四',
                  avatar: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  onPressed: () => debugPrint('带图标头像的芯片点击'),
                ),
                // 带文本头像的芯片
                ZephyrChip(
                  label: '王五',
                  avatar: const CircleAvatar(
                    child: Text('王'),
                  ),
                  onPressed: () => debugPrint('带文本头像的芯片点击'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 芯片组示例
            const Text(
              '芯片组',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _ChipGroupExample(),
            const SizedBox(height: 24),

            // 自定义样式芯片示例
            const Text(
              '自定义样式芯片',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // 自定义颜色芯片
                ZephyrChip(
                  label: '自定义颜色',
                  onPressed: () => debugPrint('自定义颜色芯片点击'),
                ),
                // 禁用状态芯片
                ZephyrChip(
                  label: '禁用芯片',
                  enabled: false,
                  onPressed: () => debugPrint('禁用芯片点击'),
                ),
                // 选中状态芯片
                ZephyrChip.choice(
                  label: '选中芯片',
                  selected: true,
                  onSelected: (selected) => debugPrint('选中芯片: $selected'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 输入芯片示例
            const Text(
              '输入芯片',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _InputChipExample(),
          ],
        ),
      ),
    );
  }
}

/// 芯片组示例组件
class _ChipGroupExample extends StatefulWidget {
  /// 创建一个新的 _ChipGroupExample 实例
  const _ChipGroupExample();

  @override
  State<_ChipGroupExample> createState() => __ChipGroupExampleState();
}

class __ChipGroupExampleState extends State<_ChipGroupExample> {
  List<int> _selectedChips = [0];

  final List<ZephyrChipData> _chips = [
    const ZephyrChipData(label: '前端开发'),
    const ZephyrChipData(label: '后端开发'),
    const ZephyrChipData(label: '移动开发'),
    const ZephyrChipData(label: 'DevOps'),
    const ZephyrChipData(label: '数据科学'),
    const ZephyrChipData(label: '人工智能'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 单选芯片组
        const Text(
          '单选芯片组',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ZephyrChipGroup(
          chips: _chips,
          selectedChips: _selectedChips,
          multiSelect: false,
          onSelectionChanged: (selectedChips) {
            setState(() {
              _selectedChips = selectedChips;
            });
            debugPrint('单选芯片组选择: $selectedChips');
          },
        ),
        const SizedBox(height: 16),
        // 多选芯片组
        const Text(
          '多选芯片组',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ZephyrChipGroup(
          chips: _chips,
          selectedChips: [1, 3],
          multiSelect: true,
          onSelectionChanged: (selectedChips) {
            debugPrint('多选芯片组选择: $selectedChips');
          },
        ),
      ],
    );
  }
}

/// 输入芯片示例组件
class _InputChipExample extends StatefulWidget {
  /// 创建一个新的 _InputChipExample 实例
  const _InputChipExample();

  @override
  State<_InputChipExample> createState() => __InputChipExampleState();
}

class __InputChipExampleState extends State<_InputChipExample> {
  List<String> _tags = ['Flutter', 'Dart', 'UI'];
  String _inputText = '';

  void _addTag() {
    if (_inputText.isNotEmpty && !_tags.contains(_inputText)) {
      setState(() {
        _tags.add(_inputText);
        _inputText = '';
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _tags.map((tag) {
            return ZephyrChip.input(
              label: tag,
              onDeleted: () => _removeTag(tag),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '添加标签',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _inputText = value;
                  });
                },
                onSubmitted: (value) {
                  _addTag();
                },
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _addTag,
              child: const Text('添加'),
            ),
          ],
        ),
      ],
    );
  }
}
