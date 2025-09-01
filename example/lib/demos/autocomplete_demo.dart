import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// AutoComplete Demo Page
/// 
/// Demonstrates the capabilities of the ZephyrAutoComplete component
class AutoCompleteDemo extends StatefulWidget {
  const AutoCompleteDemo({Key? key}) : super(key: key);

  @override
  State<AutoCompleteDemo> createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedItem;
  final List<String> _selectedItems = [];

  // Sample data for demonstration
  final List<String> _countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'China',
    'India',
    'Brazil',
    'Mexico',
    'Spain',
    'Italy',
    'Netherlands',
    'Sweden',
    'Norway',
    'Denmark',
    'Finland',
    'Switzerland',
    'Austria',
  ];

  final List<Map<String, dynamic>> _users = [
    {'id': 1, 'name': 'John Doe', 'email': 'john@example.com', 'role': 'Developer'},
    {'id': 2, 'name': 'Jane Smith', 'email': 'jane@example.com', 'role': 'Designer'},
    {'id': 3, 'name': 'Bob Johnson', 'email': 'bob@example.com', 'role': 'Manager'},
    {'id': 4, 'name': 'Alice Brown', 'email': 'alice@example.com', 'role': 'Developer'},
    {'id': 5, 'name': 'Charlie Wilson', 'email': 'charlie@example.com', 'role': 'Analyst'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoComplete Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic AutoComplete'),
            const SizedBox(height: 16),
            ZephyrAutoComplete<String>(
              items: _countries,
              controller: TextEditingController(),
              placeholder: 'Search countries...',
              onSelected: (value) {
                setState(() {
                  _selectedItem = value;
                });
              },
            ),
            const SizedBox(height: 16),
            if (_selectedItem != null)
              Text('Selected: $_selectedItem',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Multi-Select AutoComplete'),
            const SizedBox(height: 16),
            ZephyrAutoComplete<String>(
              items: _countries,
              controller: TextEditingController(),
              placeholder: 'Select multiple countries...',
              multiSelect: true,
              onSelected: (value) {
                setState(() {
                  if (!_selectedItems.contains(value)) {
                    _selectedItems.add(value);
                  }
                });
              },
              ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: _selectedItems
                  .map((item) => ZephyrChip(
                        label: item,
                        onDeleted: () {
                          setState(() {
                            _selectedItems.remove(item);
                          });
                        },
                      ))
                  .toList(),
            ),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Custom Item Builder'),
            const SizedBox(height: 16),
            ZephyrAutoComplete<Map<String, dynamic>>(
              items: _users,
              controller: TextEditingController(),
              placeholder: 'Search users...',
              displayStringForOption: (user) => user['name'],
              itemBuilder: (context, user, isSelected) {
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  trailing: Text(user['role']),
                );
              },
            ),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Async Data Loading'),
            const SizedBox(height: 16),
            ZephyrAutoComplete<String>(
              items: const [], // Will be loaded async
              controller: TextEditingController(),
              placeholder: 'Search (async)...',
              asyncItems: (query) async {
                await Future.delayed(const Duration(milliseconds: 500));
                return _countries
                    .where((country) => 
                        country.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              },
            ),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Features'),
            const SizedBox(height: 16),
            const Text('• Keyboard navigation support'),
            const Text('• Multi-select with tags'),
            const Text('• Custom item rendering'),
            const Text('• Async data loading'),
            const Text('• Debounced search'),
            const Text('• Accessibility support'),
            const Text('• Customizable themes'),
            const Text('• Validation support'),
            const Text('• Responsive design'),
            const Text('• Mobile-friendly'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}