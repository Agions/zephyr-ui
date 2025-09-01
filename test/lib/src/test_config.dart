/// 测试配置
///
/// 定义测试体系的全局配置和常量
library test_config;

/// 测试超时配置
class TestTimeouts {
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration widgetTimeout = Duration(seconds: 15);
  static const Duration integrationTimeout = Duration(minutes: 5);
  static const Duration goldenTimeout = Duration(seconds: 10);
  static const Duration performanceTimeout = Duration(seconds: 60);
}

/// 测试覆盖率配置
class TestCoverage {
  static const double minimumCoverage = 0.85;
  static const double unitTestCoverage = 0.90;
  static const double widgetTestCoverage = 0.85;
  static const double integrationTestCoverage = 0.70;
  static const double goldenTestCoverage = 0.80;
}

/// 测试环境配置
class TestEnvironment {
  static const String development = 'development';
  static const String staging = 'staging';
  static const String production = 'production';
  static const String ci = 'ci';
}

/// 测试类型
enum TestType {
  unit,
  widget,
  integration,
  golden,
  performance,
  accessibility,
}

/// 测试优先级
enum TestPriority {
  critical,
  high,
  medium,
  low,
}

/// 测试标签
class TestTags {
  static const String unit = 'unit';
  static const String widget = 'widget';
  static const String integration = 'integration';
  static const String golden = 'golden';
  static const String performance = 'performance';
  static const String accessibility = 'accessibility';
  static const String regression = 'regression';
  static const String smoke = 'smoke';
  static const String e2e = 'e2e';
}

/// 测试配置
class TestConfig {
  static const bool enableGoldenTests = true;
  static const bool enablePerformanceTests = true;
  static const bool enableAccessibilityTests = true;
  static const bool enableCoverage = true;
  static const bool enableReporting = true;
  
  static const double goldenTolerance = 0.05;
  static const double performanceThreshold = 16.0; // ms
  static const int memoryThreshold = 100; // MB
  
  static const List<String> excludedPaths = [
    'lib/**/*.g.dart',
    'lib/**/*.freezed.dart',
    'lib/**/*.mocks.dart',
    'lib/src/generated/',
  ];
  
  static const List<String> includedPaths = [
    'lib/src/core/',
    'lib/src/components/',
    'lib/src/utils/',
  ];
}