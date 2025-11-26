import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class TreeDemo extends StatefulWidget {
  const TreeDemo({Key? key}) : super(key: key);

  @override
  State<TreeDemo> createState() => _TreeDemoState();
}

class _TreeDemoState extends State<TreeDemo> {
  late List<ZephyrTreeNode<String>> _fileSystemNodes;
  late List<ZephyrTreeNode<String>> _departmentNodes;
  String _searchQuery = '';
  final ZephyrTreeController<String> _controller = ZephyrTreeController([]);

  @override
  void initState() {
    super.initState();
    _initializeNodes();
  }

  void _initializeNodes() {
    _fileSystemNodes = [
      const ZephyrTreeNode(
        id: 'root',
        label: 'Project Root',
        icon: Icons.folder,
        children: [
          ZephyrTreeNode(
            id: 'src',
            label: 'src',
            icon: Icons.folder,
            children: [
              ZephyrTreeNode(
                id: 'components',
                label: 'components',
                icon: Icons.folder,
                children: [
                  ZephyrTreeNode(
                    id: 'button.dart',
                    label: 'button.dart',
                    icon: Icons.description,
                  ),
                  ZephyrTreeNode(
                    id: 'input.dart',
                    label: 'input.dart',
                    icon: Icons.description,
                  ),
                ],
              ),
              ZephyrTreeNode(
                id: 'utils',
                label: 'utils',
                icon: Icons.folder,
                children: [
                  ZephyrTreeNode(
                    id: 'helpers.dart',
                    label: 'helpers.dart',
                    icon: Icons.description,
                  ),
                ],
              ),
            ],
          ),
          ZephyrTreeNode(
            id: 'pubspec.yaml',
            label: 'pubspec.yaml',
            icon: Icons.description,
          ),
          ZephyrTreeNode(
            id: 'README.md',
            label: 'README.md',
            icon: Icons.description,
          ),
        ],
      ),
    ];

    _departmentNodes = [
      const ZephyrTreeNode(
        id: 'company',
        label: 'Company',
        icon: Icons.business,
        children: [
          ZephyrTreeNode(
            id: 'engineering',
            label: 'Engineering',
            icon: Icons.build,
            metadata: {'badge': '15'},
            children: [
              ZephyrTreeNode(
                id: 'frontend',
                label: 'Frontend',
                icon: Icons.computer,
                metadata: {'badge': '8'},
              ),
              ZephyrTreeNode(
                id: 'backend',
                label: 'Backend',
                icon: Icons.storage,
                metadata: {'badge': '7'},
              ),
            ],
          ),
          ZephyrTreeNode(
            id: 'design',
            label: 'Design',
            icon: Icons.palette,
            metadata: {'badge': '5'},
            children: [
              ZephyrTreeNode(
                id: 'ui',
                label: 'UI Design',
                icon: Icons.brush,
              ),
              ZephyrTreeNode(
                id: 'ux',
                label: 'UX Research',
                icon: Icons.psychology,
              ),
            ],
          ),
          ZephyrTreeNode(
            id: 'marketing',
            label: 'Marketing',
            icon: Icons.campaign,
            metadata: {'badge': '3'},
          ),
        ],
      ),
    ];

    _controller.nodes = _departmentNodes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tree Component Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('File System Tree'),
            _buildFileSystemTree(),
            const SizedBox(height: 32),
            _buildSectionTitle('Department Tree'),
            _buildDepartmentTree(),
            const SizedBox(height: 32),
            _buildSectionTitle('Searchable Tree'),
            _buildSearchableTree(),
            const SizedBox(height: 32),
            _buildSectionTitle('Interactive Demo'),
            _buildInteractiveDemo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildFileSystemTree() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('File System Structure:'),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTree<String>(
                nodes: _fileSystemNodes,
                allowMultipleSelection: false,
                showIcons: true,
                indentation: 24,
                onNodeTap: (node) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tapped: ${node.label}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentTree() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Organization Structure:'),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTree<String>(
                nodes: _departmentNodes,
                allowMultipleSelection: true,
                showIcons: true,
                indentation: 24,
                initialExpandedNodes: ['company', 'engineering'],
                onNodeSelect: (node) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${node.label}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchableTree() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Searchable Tree:'),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTree<String>(
                nodes: _departmentNodes,
                searchQuery: _searchQuery,
                highlightSearchResults: true,
                showIcons: true,
                indentation: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Interactive Demo:'),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.expandNode('company');
                    setState(() {});
                  },
                  child: Text('Expand All'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _controller.collapseNode('company');
                    setState(() {});
                  },
                  child: Text('Collapse All'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _controller.selectNode('engineering', multiple: true);
                    _controller.selectNode('design', multiple: true);
                    setState(() {});
                  },
                  child: Text('Select Depts'),
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ZephyrTree<String>(
                nodes: _controller.nodes,
                showIcons: true,
                indentation: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
