import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/example_card.dart';

class LayoutComponentsDemo extends StatelessWidget {
  const LayoutComponentsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('布局组件'),
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
          _buildContainerExamples(),
          const SizedBox(height: 32),
          _buildGridExamples(),
          const SizedBox(height: 32),
          _buildAccordionExamples(),
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
                child: _buildContainerExamples(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildGridExamples(),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildAccordionExamples(),
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
                child: _buildContainerExamples(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildGridExamples(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildAccordionExamples(),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '布局组件',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ZephyrUI 提供了多种布局组件，帮助您构建灵活且美观的用户界面。',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildContainerExamples() {
    return ExampleCard(
      title: '容器组件',
      code: '''const Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue[50],
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.blue[200]!),
  ),
  child: Text('容器内容'),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础容器',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Text('这是一个基础容器'),
          ),
          const SizedBox(height: 16),
          const Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Text('圆角更大的容器'),
          ),
          const SizedBox(height: 16),
          const Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text('带阴影的容器'),
          ),
        ],
      ),
    );
  }

  Widget _buildGridExamples() {
    return ExampleCard(
      title: '网格布局',
      code: '''GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  children: [
    Card(child: Center(child: Text('项目1'))),
    Card(child: Center(child: Text('项目2'))),
    Card(child: Center(child: Text('项目3'))),
    Card(child: Center(child: Text('项目4'))),
  ],
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '2列网格',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.2,
            children: const [
              Card(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, size: 32),
                      SizedBox(height: 8),
                      Text('首页'),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 32),
                      SizedBox(height: 8),
                      Text('搜索'),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 32),
                      SizedBox(height: 8),
                      Text('个人'),
                    ],
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings, size: 32),
                      SizedBox(height: 8),
                      Text('设置'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '3列网格',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.0,
            children: [
              const Container(
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('1')),
              ),
              const Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('2')),
              ),
              const Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('3')),
              ),
              const Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('4')),
              ),
              const Container(
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('5')),
              ),
              const Container(
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('6')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionExamples() {
    return ExampleCard(
      title: '折叠面板',
      code: '''ExpansionPanelList(
  expansionCallback: (panelIndex, isExpanded) {
    setState(() {
      _isExpanded = !isExpanded;
    });
  },
  children: [
    ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text('面板标题'),
        );
      },
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('面板内容'),
      ),
      isExpanded: _isExpanded,
    ),
  ],
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础折叠面板',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('个人信息'),
                  trailing: const Icon(Icons.chevron_down),
                  onTap: () {},
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('这里显示个人信息的详细内容'),
                ),
                const Divider(),
                ListTile(
                  title: const Text('账户设置'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: const Text('隐私设置'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '多面板折叠',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: ExpansionPanelList(
              elevation: 0,
              expansionCallback: (panelIndex, isExpanded) {},
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      title: Text('面板 1'),
                      subtitle: Text('点击展开查看内容'),
                    );
                  },
                  body: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('这是面板1的内容区域，可以包含任何类型的内容。'),
                  ),
                  isExpanded: true,
                ),
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      title: Text('面板 2'),
                      subtitle: Text('点击展开查看内容'),
                    );
                  },
                  body: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('这是面板2的内容区域，可以包含任何类型的内容。'),
                  ),
                  isExpanded: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
