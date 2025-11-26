import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// Breadcrumb Demo Page
///
/// Demonstrates the usage of the ZephyrBreadcrumb component
class BreadcrumbDemo extends StatefulWidget {
  const BreadcrumbDemo({Key? key}) : super(key: key);

  @override
  State<BreadcrumbDemo> createState() => _BreadcrumbDemoState();
}

class _BreadcrumbDemoState extends State<BreadcrumbDemo> {
  final List<String> _navigationHistory = const ['/home'];

  final List<ZephyrBreadcrumbItem> _basicItems = const [
    ZephyrBreadcrumbItem(
      title: 'Home',
      icon: Icons.home,
      route: '/home',
    ),
    ZephyrBreadcrumbItem(
      title: 'Products',
      icon: Icons.inventory_2,
      route: '/products',
    ),
    ZephyrBreadcrumbItem(
      title: 'Electronics',
      icon: Icons.devices,
      route: '/products/electronics',
    ),
    ZephyrBreadcrumbItem(
      title: 'Smartphones',
      icon: Icons.smartphone,
      route: '/products/electronics/smartphones',
      isCurrent: true,
    ),
  ];

  final List<ZephyrBreadcrumbItem> _longItems = const [
    ZephyrBreadcrumbItem(
      title: 'Home',
      icon: Icons.home,
      route: '/home',
    ),
    ZephyrBreadcrumbItem(
      title: 'Administration',
      icon: Icons.admin_panel_settings,
      route: '/admin',
    ),
    ZephyrBreadcrumbItem(
      title: 'User Management',
      icon: Icons.people,
      route: '/admin/users',
    ),
    ZephyrBreadcrumbItem(
      title: 'Role Management',
      icon: Icons.security,
      route: '/admin/users/roles',
    ),
    ZephyrBreadcrumbItem(
      title: 'Permission Settings',
      icon: Icons.lock,
      route: '/admin/users/roles/permissions',
    ),
    ZephyrBreadcrumbItem(
      title: 'Access Control Lists',
      icon: Icons.list_alt,
      route: '/admin/users/roles/permissions/acls',
    ),
    ZephyrBreadcrumbItem(
      title: 'Policy Configuration',
      icon: Icons.policy,
      route: '/admin/users/roles/permissions/acls/policies',
      isCurrent: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breadcrumb Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDemoSection(
              'Basic Breadcrumb',
              ZephyrBreadcrumb(
                items: _basicItems,
                theme: ZephyrBreadcrumbTheme.light(),
                semanticLabel: 'Product navigation breadcrumb',
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Breadcrumb with Custom Separator',
              ZephyrBreadcrumb(
                items: _basicItems,
                separator: const Text('>',
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                theme: ZephyrBreadcrumbTheme.light(),
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Breadcrumb with Auto Collapse',
              ZephyrBreadcrumb(
                items: _longItems,
                maxItems: 4,
                collapsedLabel: '⋯',
                autoCollapse: true,
                theme: ZephyrBreadcrumbTheme.light(),
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Dark Theme Breadcrumb',
              const Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16),
                child: ZephyrBreadcrumb(
                  items: _basicItems,
                  theme: ZephyrBreadcrumbTheme.dark(),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Wrapped Breadcrumb',
              ZephyrBreadcrumb(
                items: _longItems,
                wrapContent: true,
                maxWidth: 400,
                theme: ZephyrBreadcrumbTheme.light(),
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Breadcrumb without Icons',
              ZephyrBreadcrumb(
                items: _basicItems,
                showIcons: false,
                theme: ZephyrBreadcrumbTheme.light(),
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Breadcrumb with Custom Styling',
              ZephyrBreadcrumb(
                items: _basicItems,
                theme: ZephyrBreadcrumbTheme.custom(
                  itemStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple[700],
                  ),
                  clickableItemStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple[500],
                  ),
                  currentItemStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.purple[900],
                  ),
                  currentItemBackgroundColor: Colors.purple[50],
                  separatorIcon: Icons.arrow_forward,
                  separatorColor: Colors.purple[400],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Interactive Breadcrumb Demo',
              const Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Navigation Path: ${_navigationHistory.join(' > ')}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 16),
                    ZephyrBreadcrumb(
                      items: _buildInteractiveItems(),
                      theme: ZephyrBreadcrumbTheme.light(),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _navigateBack,
                          child: Text('Navigate Back'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _navigateForward,
                          child: Text('Navigate Forward'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Generated from Path',
              ZephyrBreadcrumb(
                items: _buildItemsFromPath(
                    '/dashboard/products/electronics/smartphones/iphone-15'),
                theme: ZephyrBreadcrumbTheme.light(),
              ),
            ),
            const SizedBox(height: 32),
            _buildUtilitiesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  List<ZephyrBreadcrumbItem> _buildInteractiveItems() {
    return _navigationHistory.map((path) {
      final segments = path.split('/').where((s) => s.isNotEmpty).toList();
      final title = segments.isEmpty ? 'Home' : segments.last;
      final isCurrent = path == _navigationHistory.last;

      return ZephyrBreadcrumbItem(
        title: _formatTitle(title),
        route: path,
        icon: _getIconForPath(path),
        isCurrent: isCurrent,
        onTap: () => _handleNavigationByPath(path),
      );
    }).toList();
  }

  List<ZephyrBreadcrumbItem> _buildItemsFromPath(String path) {
    final generated = ZephyrBreadcrumbUtils.generateFromPath(path);
    return generated.map((item) {
      return ZephyrBreadcrumbItem(
        title: item['title'],
        route: item['route'],
        icon: item['icon'],
        isCurrent: item['isCurrent'] ?? false,
      );
    }).toList();
  }

  String _formatTitle(String title) {
    return title
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  IconData _getIconForPath(String path) {
    if (path.contains('home')) return Icons.home;
    if (path.contains('dashboard')) return Icons.dashboard;
    if (path.contains('product')) return Icons.inventory_2;
    if (path.contains('electronics')) return Icons.devices;
    if (path.contains('smartphone')) return Icons.smartphone;
    if (path.contains('user')) return Icons.person;
    if (path.contains('setting')) return Icons.settings;
    return Icons.folder;
  }

  void _handleNavigationByPath(String path) {
    setState(() {
      _navigationHistory.add(path);
    });
  }

  void _navigateBack() {
    if (_navigationHistory.length > 1) {
      setState(() {
        _navigationHistory.removeLast();
      });
    }
  }

  void _navigateForward() {
    // Simulate forward navigation
    final currentPath = _navigationHistory.last;
    if (currentPath == '/home') {
      _handleNavigationByPath('/dashboard');
    } else if (currentPath == '/dashboard') {
      _handleNavigationByPath('/dashboard/products');
    }
  }

  Widget _buildUtilitiesSection() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Breadcrumb Utilities',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            _buildPathGenerator(),
            SizedBox(height: 16),
            _buildValidationDemo(),
          ],
        ),
      ),
    );
  }

  Widget _buildPathGenerator() {
    final pathController = TextEditingController(
        text: '/dashboard/products/electronics/smartphones');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Path Generator'),
        const SizedBox(height: 8),
        TextField(
          controller: pathController,
          decoration: const InputDecoration(
            labelText: 'Enter path',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        ZephyrBreadcrumb(
          items: _buildItemsFromPath(pathController.text),
          theme: ZephyrBreadcrumbTheme.light(),
        ),
      ],
    );
  }

  Widget _buildValidationDemo() {
    final validItems = [
      const ZephyrBreadcrumbItem(title: 'Home', route: '/'),
      const ZephyrBreadcrumbItem(title: 'Products', route: '/products'),
      const ZephyrBreadcrumbItem(
          title: 'Electronics',
          route: '/products/electronics',
          isCurrent: true),
    ];

    final invalidItems = [
      const ZephyrBreadcrumbItem(title: 'Home', route: '/'),
      const ZephyrBreadcrumbItem(title: 'Products', route: '/products'),
      const ZephyrBreadcrumbItem(
          title: 'Electronics', route: '/products/electronics'),
      // Missing current item
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Validation Demo'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Valid Breadcrumb: ${ZephyrBreadcrumbUtils.validateItems(validItems.map((item) => {
                            'title': item.title,
                            'route': item.route,
                            'isCurrent': item.isCurrent,
                          }).toList())}'),
                  const SizedBox(height: 8),
                  ZephyrBreadcrumb(
                    items: validItems,
                    theme: ZephyrBreadcrumbTheme.light(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Invalid Breadcrumb: ${ZephyrBreadcrumbUtils.validateItems(invalidItems.map((item) => {
                            'title': item.title,
                            'route': item.route,
                            'isCurrent': item.isCurrent,
                          }).toList())}'),
                  const SizedBox(height: 8),
                  ZephyrBreadcrumb(
                    items: invalidItems,
                    theme: ZephyrBreadcrumbTheme.light(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
