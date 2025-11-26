import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class TourDemo extends StatefulWidget {
  const TourDemo({Key? key}) : super(key: key);

  @override
  State<TourDemo> createState() => _TourDemoState();
}

class _TourDemoState extends State<TourDemo> {
  final GlobalKey _fabKey = GlobalKey();
  final GlobalKey _searchKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _settingsKey = GlobalKey();

  bool _showTour = false;
  final ZephyrTourController _tourController = ZephyrTourController([]);

  List<ZephyrTourStep> get _tourSteps => [
        const ZephyrTourStep(
          id: 'welcome',
          title: 'Welcome to Tour Demo',
          content:
              'This is a demonstration of the ZephyrUI Tour component. Let\'s explore the features!',
          order: 0,
        ),
        ZephyrTourStep(
          id: 'fab',
          title: 'Floating Action Button',
          content:
              'This is the floating action button. Tap it to perform primary actions.',
          order: 1,
          targetKey: _fabKey,
        ),
        ZephyrTourStep(
          id: 'search',
          title: 'Search Bar',
          content: 'Use this search bar to find content quickly.',
          order: 2,
          targetKey: _searchKey,
        ),
        ZephyrTourStep(
          id: 'menu',
          title: 'Navigation Menu',
          content: 'Access different sections from this menu.',
          order: 3,
          targetKey: _menuKey,
        ),
        ZephyrTourStep(
          id: 'content',
          title: 'Main Content',
          content: 'This is where your main content will be displayed.',
          order: 4,
          targetKey: _contentKey,
        ),
        ZephyrTourStep(
          id: 'settings',
          title: 'Settings',
          content: 'Configure your preferences in the settings.',
          order: 5,
          targetKey: _settingsKey,
        ),
        const ZephyrTourStep(
          id: 'complete',
          title: 'Tour Complete!',
          content:
              'Congratulations! You\'ve completed the tour. You can now explore the app on your own.',
          order: 6,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tour Component Demo'),
        actions: [
          IconButton(
            key: _settingsKey,
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings opened')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildMainContent(),
          if (_showTour)
            ZephyrTour(
              steps: _tourSteps,
              autoStart: true,
              onTourComplete: () {
                setState(() {
                  _showTour = false;
                });
              },
              onTourSkip: () {
                setState(() {
                  _showTour = false;
                });
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB tapped!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        // Search bar
        const Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            key: _searchKey,
            decoration: InputDecoration(
              labelText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),

        // Navigation menu
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            key: _menuKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Home tapped')),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashboard'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dashboard tapped')),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile tapped')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Main content area
        Expanded(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              key: _contentKey,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tour Component Features',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildFeatureList(),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Tour controls
        const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Tour Controls',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showTour = true;
                      });
                    },
                    child: Text('Start Tour'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _tourController.startTour();
                      setState(() {
                        _showTour = true;
                      });
                    },
                    child: Text('Start with Controller'),
                  ),
                ],
              ),
              SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  _showCustomTour();
                },
                child: Text('Custom Tour'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeatureItem('Step-by-step guidance', Icons.list),
        _buildFeatureItem('Target highlighting', Icons.highlight),
        _buildFeatureItem('Interactive tooltips', Icons.chat),
        _buildFeatureItem('Progress indicators', Icons.trending_up),
        _buildFeatureItem('Customizable styling', Icons.palette),
        _buildFeatureItem('Accessibility support', Icons.accessibility),
        _buildFeatureItem('Keyboard navigation', Icons.keyboard),
        _buildFeatureItem('Responsive design', Icons.smartphone),
      ],
    );
  }

  Widget _buildFeatureItem(String title, IconData icon) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }

  void _showCustomTour() {
    setState(() {
      _showTour = true;
    });
  }
}
