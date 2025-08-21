import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/component_card.dart';
import '../widgets/example_card.dart';

class BasicComponentsDemo extends StatelessWidget {
  const BasicComponentsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基础组件'),
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
          _buildButtonExamples(),
          const SizedBox(height: 32),
          _buildTextExamples(),
          const SizedBox(height: 32),
          _buildIconExamples(),
          const SizedBox(height: 32),
          _buildCardExamples(),
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
                child: _buildButtonExamples(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildTextExamples(),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildIconExamples(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildCardExamples(),
              ),
            ],
          ),
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
                child: _buildButtonExamples(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildTextExamples(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildIconExamples(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCardExamples(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '基础组件',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ZephyrUI 提供了一系列基础 UI 组件，这些组件遵循 Material Design 规范，具有一致的设计风格和良好的用户体验。',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonExamples() {
    return ExampleCard(
      title: '按钮组件',
      code: '''ElevatedButton(
  onPressed: () {},
  child: const Text('主要按钮'),
)

OutlinedButton(
  onPressed: () {},
  child: const Text('次要按钮'),
)

TextButton(
  onPressed: () {},
  child: const Text('文本按钮'),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础按钮',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('主要按钮'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('次要按钮'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('文本按钮'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '图标按钮',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save),
                label: const Text('保存'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                label: const Text('删除'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '按钮状态',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('正常状态'),
              ),
              ElevatedButton(
                onPressed: null,
                child: const Text('禁用状态'),
              ),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextExamples() {
    return ExampleCard(
      title: '文本组件',
      code: '''Text(
  '标题文本',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)

Text(
  '正文文本',
  style: TextStyle(
    fontSize: 16,
    color: Colors.grey[600],
  ),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '标题文本',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '副标题文本',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '正文文本内容，这是普通的正文文本样式。正文文本通常用于显示详细的信息内容。',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '小字文本',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '文本样式示例',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  '主要',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  '成功',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  '错误',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconExamples() {
    return ExampleCard(
      title: '图标组件',
      code: '''Icon(
  Icons.home,
  size: 24,
  color: Colors.blue,
)

Icon(
  Icons.favorite,
  size: 32,
  color: Colors.red,
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础图标',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Column(
                children: const [
                  Icon(Icons.home, size: 32, color: Colors.blue),
                  SizedBox(height: 4),
                  Text('首页'),
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.search, size: 32, color: Colors.green),
                  SizedBox(height: 4),
                  Text('搜索'),
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.notifications, size: 32, color: Colors.orange),
                  SizedBox(height: 4),
                  Text('通知'),
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.settings, size: 32, color: Colors.purple),
                  SizedBox(height: 4),
                  Text('设置'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '图标大小',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.star, size: 16, color: Colors.amber),
              Icon(Icons.star, size: 24, color: Colors.amber),
              Icon(Icons.star, size: 32, color: Colors.amber),
              Icon(Icons.star, size: 48, color: Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardExamples() {
    return ExampleCard(
      title: '卡片组件',
      code: '''Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('卡片标题'),
        SizedBox(height: 8),
        Text('卡片内容'),
      ],
    ),
  ),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础卡片',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '卡片标题',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '这是卡片的内容描述。卡片可以包含各种类型的内容，如文本、图片、按钮等。',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('取消'),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('确认'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '带图标的卡片',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person, size: 32),
              title: const Text('用户信息'),
              subtitle: const Text('查看和编辑用户资料'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}