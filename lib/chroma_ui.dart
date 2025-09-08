/// ChromaUI - Enterprise-Grade Flutter UI Component Library
///
/// A comprehensive, scalable, and maintainable UI component library for building
/// beautiful and performant Flutter applications.
///
/// Features:
/// - 50+ reusable UI components
/// - Comprehensive theme system
/// - Form validation system
/// - Advanced charts and data visualization
/// - Enhanced tables with sorting/filtering/pagination
/// - Advanced file upload with drag-and-drop
/// - Performance optimization utilities
/// - Comprehensive test coverage
/// - Developer experience tools
library chroma_ui;

// Core architecture and infrastructure
export 'src/core/architecture/dependency_injection/dependency_injection.dart' hide ChromaServiceLocator;
export 'src/core/architecture/service_locator/service_locator.dart';
export 'src/core/architecture/state_management/state_management.dart';
export 'src/core/config/environment_config.dart';
export 'src/core/config/feature_flags.dart';
export 'src/core/config/app_config.dart';
export 'src/core/config/mobile_config.dart';

// Core theme and utilities
export 'src/core/theme/chroma_theme.dart';
export 'src/core/theme/chroma_theme_data.dart';
export 'src/core/theme/theme_configurations.dart';
export 'src/core/theme/theme_utils.dart';
export 'src/core/theme/performance_theme_integration.dart';
export 'src/core/theme/unified_theme_data.dart';

// Design tokens and constants
export 'src/core/constants/chroma_tokens.dart';
export 'src/core/constants/enums.dart' hide ChromaStepState;

// Core utilities
export 'src/core/extensions/context_extensions.dart';
export 'src/core/utils/helpers/helpers.dart';
export 'src/core/utils/responsive/responsive_utils.dart';
export 'src/core/utils/performance/performance_utils.dart' hide MemoryInfo, PerformanceMetrics, PerformanceMonitor;

// Enhanced Components (New Architecture)
export 'src/components/components.dart';



// Performance widgets
export 'src/widgets/optimized/performance_widgets.dart' hide PerformanceMonitor;

// Services
export 'src/services/analytics/analytics_service.dart';
export 'src/services/logging/logging_service.dart';
export 'src/services/monitoring/monitoring_service.dart' hide PerformanceMonitor;
export 'src/services/storage/storage_service.dart';

