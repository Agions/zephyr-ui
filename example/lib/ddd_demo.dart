/// ZephyrUI DDD Architecture Demo
///
/// Demonstrates the usage of the DDD architecture in ZephyrUI components.

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class ZephyrDDDDemo extends StatefulWidget {
  const ZephyrDDDDemo({super.key});

  @override
  State<ZephyrDDDDemo> createState() => _ZephyrDDDDemoState();
}

class _ZephyrDDDDemoState extends State<ZephyrDDDDemo> {
  late UIComponentEntity _component;
  final UIComponentRepository _repository = UIComponentRepositoryImpl();

  @override
  void initState() {
    super.initState();
    _initializeComponent();
  }

  Future<void> _initializeComponent() async {
    // Create a component using DDD entities
    _component = UIComponentEntity(
      id: ComponentId.generate(),
      componentType: 'button',
      name: 'Primary Button',
      description: 'A primary button component',
      size: SizeValue.md,
    );

    // Save the component using repository
    await _repository.save(_component);

    // Publish domain event
    if (mounted) {
      context.publishDomainEvent(ZephyrComponentLifecycleEvent(
        componentType: _component.componentType,
        componentId: _component.id.value,
        lifecyclePhase: 'initialized',
        metadata: {'componentName': _component.name},
      ));
    }
  }

  Future<void> _handleComponentAction() async {
    // Update component state using domain logic
    final updatedComponent = _component.resize(SizeValue.lg);
    setState(() {
      _component = updatedComponent;
    });

    // Save the updated component
    await _repository.save(_component);
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrEventSubscriber<ZephyrComponentLifecycleEvent>(
      onEvent: (event) {
        // Handle component lifecycle events
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Component ${event.componentType} ${event.lifecyclePhase}'),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ZephyrUI DDD Architecture Demo'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Component Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 16),
              Text('ID: ${_component.id.value}'),
              Text('Type: ${_component.componentType}'),
              Text('Name: ${_component.name}'),
              Text('Size: ${_component.size.value}'),
              Text('Enabled: ${_component.isEnabled}'),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  await _handleComponentAction();
                },
                child: Text('Resize Component'),
              ),
              SizedBox(height: 24),
              Text(
                'DDD Architecture Features:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Text('• Domain Entities with business logic'),
              Text('• Value Objects with validation'),
              Text('• Repository Pattern for data access'),
              Text('• Dependency Injection container'),
              Text('• Event-driven communication'),
              Text('• Clear separation of concerns'),
            ],
          ),
        ),
      ),
    );
  }
}
