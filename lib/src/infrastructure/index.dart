/// ZephyrUI DDD Architecture - Infrastructure Layer
///
/// Contains implementations of domain interfaces, external service integrations,
/// and infrastructure concerns like data persistence and external APIs.

library infrastructure;

// Existing repository implementations
export 'repositories/ui_component_repository_impl.dart';
export 'repositories/theme_repository_impl.dart';

// Existing external services
export 'external/shared_preferences_service.dart';

// Note: Additional infrastructure files will be added as the DDD architecture evolves
