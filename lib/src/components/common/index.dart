// Common components exports
export 'base/chroma_base_component.dart';
export 'interfaces/component_interfaces.dart';
export 'mixins/component_mixins.dart';
export 'factories/component_factory.dart';

// Register built-in components on import
void _initComponents() {
  chromaComponentFactory.instance.registerBuiltInComponents();
}

// Auto-initialize components
const _initialized = _initComponents();
