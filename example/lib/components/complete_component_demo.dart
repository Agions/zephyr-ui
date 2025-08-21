import 'package:flutter/material.dart';

class CompleteComponentDemo extends StatefulWidget {
  const CompleteComponentDemo({super.key});

  @override
  State<CompleteComponentDemo> createState() => _CompleteComponentDemoState();
}

class _CompleteComponentDemoState extends State<CompleteComponentDemo> {
  int _badgeCount = 5;
  bool _isDarkMode = false;
  int _rating = 3;
  bool _isSwitched = false;
  double _sliderValue = 0.5;
  String _selectedChip = 'React';
  final List<String> _chips = ['React', 'Vue', 'Angular', 'Flutter', 'Svelte'];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ZephyrUI 完整组件演示'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Avatar 组件'),
              _buildAvatarDemo(),
              
              const SizedBox(height: 32),
              _buildSectionHeader('Badge 组件'),
              _buildBadgeDemo(),
              
              const SizedBox(height: 32),
              _buildSectionHeader('Divider 组件'),
              _buildDividerDemo(),
              
              const SizedBox(height: 32),
              _buildSectionHeader('Card 组件'),
              _buildCardDemo(),
              
              const SizedBox(height: 32),
              _buildSectionHeader('Chip 组件'),
              _buildChipDemo(),
              
              const SizedBox(height: 32),
              _buildSectionHeader('Button 组件'),
              _buildButtonDemo(),
              
              const SizedBox(height: 32),
              _buildSectionHeader('交互组件'),
              _buildInteractiveDemo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAvatarDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '头像组件演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                // 文字头像
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: const Text(
                    'ZT',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                
                // 图标头像
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                
                // 不同尺寸
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.orange,
                  child: const Text(
                    'S',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.purple,
                  child: const Text(
                    'L',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                
                // 方形头像
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'SQ',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                
                // 带边框头像
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: const Text(
                    'B',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '徽章组件演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // 标准徽章
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'New',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Hot',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Sale',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // 数字徽章
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$_badgeCount',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '99+',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '999+',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // 圆点徽章
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _badgeCount++;
                });
              },
              child: const Text('增加徽章数量'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '分割线组件演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('内容区域 1'),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            const Text('内容区域 2'),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: Text('左侧内容')),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.shade300,
                ),
                const Expanded(child: Text('右侧内容')),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              thickness: 2,
              color: Colors.blue,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '卡片组件演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(height: 8),
                        const Text(
                          '特色功能',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '这是一个功能卡片，展示重要信息',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.blue.shade50,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info, color: Colors.blue),
                        const SizedBox(height: 8),
                        const Text(
                          '信息卡片',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '提供重要信息和提示',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '标签组件演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: _chips.map((chip) {
                final isSelected = _selectedChip == chip;
                return InputChip(
                  label: Text(chip),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedChip = selected ? chip : '';
                    });
                  },
                  backgroundColor: isSelected ? Colors.blue : Colors.grey.shade200,
                  selectedColor: Colors.blue.shade100,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text('已选择: $_selectedChip'),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '按钮组件演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('主要按钮'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('次要按钮'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('边框按钮'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('文本按钮'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('图标按钮'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '交互组件演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 开关
            Row(
              children: [
                const Text('开关'),
                const SizedBox(width: 16),
                Switch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 滑块
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('滑块值: ${(_sliderValue * 100).round()}%'),
                Slider(
                  value: _sliderValue,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 评分
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('评分: $_rating'),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = index + 1;
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}