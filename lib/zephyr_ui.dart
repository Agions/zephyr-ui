/// ZephyrUI - 企业级Flutter UI组件库
///
/// 提供高质量、一致性强的UI组件，加速企业级Flutter应用的开发过程。
library zephyr_ui;

// 核心主题
export 'src/core/theme/theme.dart';
export 'src/core/theme/theme_data.dart';
export 'src/core/theme/theme_config.dart';
export 'src/core/theme/optimized_theme_data.dart';
export 'src/core/theme/optimized_theme_config.dart';
export 'src/core/theme/performance_theme_integration.dart';
export 'src/core/theme/performance_overlay.dart';

// 设计令牌和常量
export 'src/core/constants/design_tokens.dart';
export 'src/core/constants/enums.dart';

// 工具类
export 'src/utils/responsive/responsive_utils.dart';
export 'src/utils/helpers/color_utils.dart';
export 'src/utils/performance/performance_utils.dart';
// export 'src/utils/performance/enhanced_performance_utils.dart'; // Temporarily disabled due to conflicts
// export 'src/utils/build/build_optimization.dart'; // Temporarily disabled due to conflicts

// 性能优化
export 'src/core/lazy_loading/lazy_component_loader.dart';
export 'src/core/memory/memory_optimizer.dart';
export 'src/core/build/build_optimizer.dart';
export 'src/core/performance/performance_dashboard.dart';

// 配置
export 'src/core/config/production_config.dart';

// 扩展
// export 'src/extensions/context_extensions.dart';

// 组件库 - 使用统一的barrel导出策略
export 'src/components/index.dart';
