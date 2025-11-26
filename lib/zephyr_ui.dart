/// ZephyrUI - A comprehensive Flutter UI component library
///
/// Provides high-quality, consistent UI components for building beautiful Flutter applications.
library zephyr_ui;

// Core theme and utilities
export 'src/core/theme/theme.dart';
export 'src/core/theme/theme_data.dart';
export 'src/core/theme/theme_configurations.dart';
export 'src/core/theme/theme_utils.dart';

// Design tokens and constants
export 'src/core/constants/design_tokens.dart';
export 'src/core/constants/enums.dart';

// DDD Architecture
export 'src/core/dependency_injection.dart';
export 'src/core/event_bus.dart';
export 'src/core/ddd_config.dart';

// Core utilities
export 'src/core/index.dart';
export 'src/core/error_handler.dart';

// Domain Layer
export 'src/domain/index.dart';

// Application Layer
export 'src/application/index.dart';

// Infrastructure Layer
export 'src/infrastructure/index.dart';

// Presentation Layer
export 'src/presentation/index.dart';

// Basic components
export 'src/components/basic/avatar/index.dart';
export 'src/components/basic/badge/index.dart';
export 'src/components/basic/button/index.dart';
export 'src/components/basic/card/index.dart';
export 'src/components/basic/chip/index.dart';
export 'src/components/basic/divider/index.dart';
export 'src/components/basic/icon/index.dart';
export 'src/components/basic/image/index.dart';
export 'src/components/basic/dropdown/index.dart';
export 'src/components/basic/tag/index.dart';
export 'src/components/basic/text/index.dart';
export 'src/components/basic/typography/index.dart';

// Form components
export 'src/components/form/index.dart';
export 'src/components/form/auto_complete/index.dart';
export 'src/components/form/checkbox/index.dart';
export 'src/components/form/checkbox_group/index.dart';
export 'src/components/form/color_picker/index.dart';
export 'src/components/form/date_picker/index.dart';
export 'src/components/form/file_upload/index.dart';
export 'src/components/form/input/index.dart';
export 'src/components/form/radio/index.dart';
export 'src/components/form/radio_group/index.dart';
export 'src/components/form/rating/index.dart';
export 'src/components/form/select/index.dart';
export 'src/components/form/signature/index.dart';
export 'src/components/form/slider/index.dart';
export 'src/components/form/switch/index.dart';
export 'src/components/form/text_area/index.dart';
export 'src/components/form/time_picker/index.dart';

// Navigation components
export 'src/components/navigation/bottom_navigation_bar/index.dart';
export 'src/components/navigation/navigation_rail/index.dart';
export 'src/components/navigation/pagination/index.dart';
export 'src/components/navigation/side_menu/index.dart';
export 'src/components/navigation/stepper/index.dart';
export 'src/components/navigation/tabs/index.dart';
export 'src/components/navigation/tree/index.dart';

// Feedback components
export 'src/components/feedback/alert/index.dart';
export 'src/components/feedback/modal/index.dart';
export 'src/components/feedback/progress/index.dart';
export 'src/components/feedback/toast/index.dart';
export 'src/components/feedback/tour/index.dart';
export 'src/components/feedback/message/index.dart';
export 'src/components/feedback/notification/index.dart';
export 'src/components/feedback/popconfirm/index.dart';
export 'src/components/feedback/spin/index.dart';
export 'src/components/feedback/backtop/index.dart';
export 'src/components/feedback/accessibility/index.dart';
export 'src/components/feedback/performance/index.dart';

// Display components
export 'src/components/display/calendar/index.dart';
export 'src/components/display/carousel/index.dart';
export 'src/components/display/charts/index.dart';
export 'src/components/display/list/index.dart';
export 'src/components/display/statistic/index.dart';
export 'src/components/display/table/index.dart';
export 'src/components/display/timeline/index.dart';
export 'src/components/display/empty/index.dart';
export 'src/components/display/result/index.dart';
export 'src/components/display/skeleton/index.dart';
export 'src/components/display/description/index.dart';
export 'src/components/display/tooltip/index.dart';
export 'src/components/display/popover/index.dart';

// Layout components
export 'src/components/layout/accordion/index.dart';
export 'src/components/layout/container/index.dart';
export 'src/components/layout/grid/index.dart';
export 'src/components/layout/layout/index.dart';
export 'src/components/layout/sider/index.dart';
export 'src/components/layout/header/index.dart';
export 'src/components/layout/footer/index.dart';
export 'src/components/layout/content/index.dart';
export 'src/components/layout/row/index.dart';
export 'src/components/layout/column/index.dart' hide ZephyrColumn;
export 'src/components/layout/space/index.dart';

// Utilities
export 'src/utils/helpers/color_utils.dart';
