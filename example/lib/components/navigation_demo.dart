/// ZephyrUI Navigation Components Demo
/// 
/// Comprehensive demo showcasing all navigation components.
library navigation_demo;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class NavigationComponentsDemo extends StatefulWidget {
  const NavigationComponentsDemo({super.key});

  @override
  State<NavigationComponentsDemo> createState() => _NavigationComponentsDemoState();
}

class _NavigationComponentsDemoState extends State<NavigationComponentsDemo>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _bottomNavIndex = 0;
  int _stepperIndex = 0;
  int _paginationCurrentPage = 1;
  int _paginationItemsPerPage = 10;
  final int _paginationTotalItems = 100;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Components Demo'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Bottom Nav'),
            Tab(text: 'Breadcrumb'),
            Tab(text: 'Navigation Rail'),
            Tab(text: 'Side Menu'),
            Tab(text: 'Tabs'),
            Tab(text: 'Stepper'),
            Tab(text: 'Pagination'),
            Tab(text: 'Tree View'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBottomNavDemo(),
          _buildBreadcrumbDemo(),
          _buildNavigationRailDemo(),
          _buildSideMenuDemo(),
          _buildTabsDemo(),
          _buildStepperDemo(),
          _buildPaginationDemo(),
          _buildTreeViewDemo(),
        ],
      ),
    );
  }

  Widget _buildBottomNavDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bottom Navigation Bar',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          const Text('Standard Bottom Navigation'),
          const SizedBox(height: 8),
          ZephyrBottomNavigationBar(
            currentIndex: _bottomNavIndex,
            onTap: (index) => setState(() => _bottomNavIndex = index),
            items: [
              ZephyrBottomNavigationItem(
                icon: const Icon(Icons.home),
                label: 'Home',
                activeIcon: const Icon(Icons.home_filled),
                badge: ZephyrBadge.count(count: 5),
              ),
              ZephyrBottomNavigationItem(
                icon: const Icon(Icons.search),
                label: 'Search',
              ),
              ZephyrBottomNavigationItem(
                icon: const Icon(Icons.notifications),
                label: 'Notifications',
                badge: ZephyrBadge.dot(),
              ),
              ZephyrBottomNavigationItem(
                icon: const Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          const Text('Bottom Navigation with Dots'),
          const SizedBox(height: 8),
          ZephyrBottomNavigationBarWithDots(
            currentIndex: _bottomNavIndex,
            onTap: (index) => setState(() => _bottomNavIndex = index),
            showDotIndicator: true,
            dotColor: Colors.blue,
            items: [
              ZephyrBottomNavigationItem(
                icon: const Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              ZephyrBottomNavigationItem(
                icon: const Icon(Icons.analytics),
                label: 'Analytics',
              ),
              ZephyrBottomNavigationItem(
                icon: const Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Breadcrumb Navigation',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          const Text('Standard Breadcrumb'),
          const SizedBox(height: 8),
          ZephyrBreadcrumb(
            items: [
              ZephyrBreadcrumbItem(
                title: 'Home',
                icon: const Icon(Icons.home, size: 16),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigated to Home')),
                ),
              ),
              ZephyrBreadcrumbItem(
                title: 'Products',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigated to Products')),
                ),
              ),
              ZephyrBreadcrumbItem(
                title: 'Electronics',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigated to Electronics')),
                ),
              ),
              ZephyrBreadcrumbItem(
                title: 'Smartphones',
                isCurrent: true,
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          const Text('Collapsible Breadcrumb'),
          const SizedBox(height: 8),
          ZephyrCollapsibleBreadcrumb(
            maxCollapsedItems: 3,
            items: [
              ZephyrBreadcrumbItem(
                title: 'Home',
                icon: const Icon(Icons.home, size: 16),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigated to Home')),
                ),
              ),
              ZephyrBreadcrumbItem(
                title: 'Department',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigated to Department')),
                ),
              ),
              ZephyrBreadcrumbItem(
                title: 'Category',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigated to Category')),
                ),
              ),
              ZephyrBreadcrumbItem(
                title: 'Subcategory',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigated to Subcategory')),
                ),
              ),
              ZephyrBreadcrumbItem(
                title: 'Product',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigated to Product')),
                ),
              ),
              ZephyrBreadcrumbItem(
                title: 'Details',
                isCurrent: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRailDemo() {
    return Row(
      children: [
        ZephyrExpandableNavigationRail(
          currentIndex: 0,
          onTap: (index) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigated to item $index')),
          ),
          items: [
            ZephyrRailItem(
              icon: const Icon(Icons.dashboard),
              label: 'Dashboard',
              selectedIcon: const Icon(Icons.dashboard_outlined),
              badge: ZephyrBadge.count(count: 3),
            ),
            ZephyrRailItem(
              icon: const Icon(Icons.analytics),
              label: 'Analytics',
            ),
            ZephyrRailItem(
              icon: const Icon(Icons.notifications),
              label: 'Notifications',
              badge: ZephyrBadge.dot(),
            ),
            ZephyrRailItem(
              icon: const Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          leading: const Padding(
            padding: EdgeInsets.all(16.0),
            child: FlutterLogo(size: 32),
          ),
          trailing: const Icon(Icons.help_outline),
        ),
        const Expanded(
          child: Center(
            child: Text('Navigation Rail Demo\nClick items to navigate'),
          ),
        ),
      ],
    );
  }

  Widget _buildSideMenuDemo() {
    final menuItems = [
      ZephyrSideMenuItem(
        title: 'Dashboard',
        icon: Icons.dashboard,
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dashboard selected')),
        ),
      ),
      ZephyrSideMenuItem(
        title: 'Analytics',
        icon: Icons.analytics,
        children: [
          ZephyrSideMenuItem(
            title: 'Reports',
            icon: Icons.description,
          ),
          ZephyrSideMenuItem(
            title: 'Charts',
            icon: Icons.bar_chart,
          ),
        ],
      ),
      ZephyrSideMenuItem(
        title: 'Settings',
        icon: Icons.settings,
        badge: ZephyrBadge.count(count: 5),
      ),
      ZephyrSideMenuItem(
        title: 'Help',
        icon: Icons.help,
      ),
    ];

    return ZephyrSideMenuLayout(
      menu: ZephyrSideMenu(
        items: menuItems,
        header: Container(
          padding: const EdgeInsets.all(16.0),
          child: const FlutterLogo(size: 48),
        ),
        footer: Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text('v1.0.0'),
        ),
      ),
      content: const Center(
        child: Text('Side Menu Demo\nClick menu items to navigate'),
      ),
    );
  }

  Widget _buildTabsDemo() {
    return Column(
      children: [
        ZephyrTabs(
          tabs: [
            ZephyrTabItem(
              label: 'Overview',
              icon: const Icon(Icons.dashboard),
              content: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Dashboard overview content goes here.'),
              ),
            ),
            ZephyrTabItem(
              label: 'Analytics',
              icon: const Icon(Icons.analytics),
              content: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Analytics data and charts go here.'),
              ),
            ),
            ZephyrTabItem(
              label: 'Reports',
              icon: const Icon(Icons.description),
              content: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Reports and documents go here.'),
              ),
            ),
          ],
          type: ZephyrTabsType.line,
        ),
      ],
    );
  }

  Widget _buildStepperDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stepper Demo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          ZephyrStepper(
            currentStep: _stepperIndex,
            onStepTapped: (index) => setState(() => _stepperIndex = index),
            onStepContinue: () {
              if (_stepperIndex < 2) {
                setState(() => _stepperIndex++);
              }
            },
            onStepCancel: () {
              if (_stepperIndex > 0) {
                setState(() => _stepperIndex--);
              }
            },
            steps: [
              ZephyrStep(
                title: 'Personal Information',
                subtitle: 'Enter your details',
                content: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(decoration: InputDecoration(labelText: 'Name')),
                      SizedBox(height: 16),
                      TextField(decoration: InputDecoration(labelText: 'Email')),
                    ],
                  ),
                ),
              ),
              ZephyrStep(
                title: 'Address',
                subtitle: 'Enter your address',
                content: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(decoration: InputDecoration(labelText: 'Street')),
                      SizedBox(height: 16),
                      TextField(decoration: InputDecoration(labelText: 'City')),
                    ],
                  ),
                ),
              ),
              ZephyrStep(
                title: 'Confirmation',
                subtitle: 'Review your information',
                content: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text('Please review your information before submitting.'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationDemo() {
    final config = ZephyrPaginationConfig(
      currentPage: _paginationCurrentPage,
      totalItems: _paginationTotalItems,
      itemsPerPage: _paginationItemsPerPage,
      maxVisiblePages: 7,
      showPageSizeSelector: true,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pagination Demo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          ZephyrPagination(
            config: config,
            onPageChanged: (page) => setState(() => _paginationCurrentPage = page),
            onPageSizeChanged: (pageSize) => setState(() => _paginationItemsPerPage = pageSize),
          ),
          
          const SizedBox(height: 32),
          const Text('Data Items'),
          const SizedBox(height: 8),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: _paginationItemsPerPage,
              itemBuilder: (context, index) {
                final itemIndex = (_paginationCurrentPage - 1) * _paginationItemsPerPage + index + 1;
                return ListTile(
                  title: Text('Item $itemIndex'),
                  subtitle: Text('This is item number $itemIndex'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeViewDemo() {
    final treeNodes = [
      ZephyrTreeNode(
        id: '1',
        label: 'Documents',
        icon: Icons.folder,
        expandedIcon: Icons.folder_open,
        children: [
          ZephyrTreeNode(
            id: '1-1',
            label: 'Work',
            icon: Icons.folder,
            expandedIcon: Icons.folder_open,
            children: [
              ZephyrTreeNode(
                id: '1-1-1',
                label: 'Report.pdf',
                icon: Icons.picture_as_pdf,
              ),
              ZephyrTreeNode(
                id: '1-1-2',
                label: 'Presentation.pptx',
                icon: Icons.slideshow,
              ),
            ],
          ),
          ZephyrTreeNode(
            id: '1-2',
            label: 'Personal',
            icon: Icons.folder,
            expandedIcon: Icons.folder_open,
            children: [
              ZephyrTreeNode(
                id: '1-2-1',
                label: 'Resume.docx',
                icon: Icons.description,
              ),
            ],
          ),
        ],
      ),
      ZephyrTreeNode(
        id: '2',
        label: 'Images',
        icon: Icons.folder,
        expandedIcon: Icons.folder_open,
        children: [
          ZephyrTreeNode(
            id: '2-1',
            label: 'Vacation',
            icon: Icons.folder,
            expandedIcon: Icons.folder_open,
            children: [
              ZephyrTreeNode(
                id: '2-1-1',
                label: 'Beach.jpg',
                icon: Icons.image,
              ),
              ZephyrTreeNode(
                id: '2-1-2',
                label: 'Mountain.jpg',
                icon: Icons.image,
              ),
            ],
          ),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tree View Demo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ZephyrTree(
              nodes: treeNodes,
              onNodeTap: (node) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: ${node.label}')),
              ),
              onNodeExpand: (node) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Expanded: ${node.label}')),
              ),
              onNodeCollapse: (node) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Collapsed: ${node.label}')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}