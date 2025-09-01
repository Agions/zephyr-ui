/// 测试入口文件
///
/// 提供测试的入口点和配置
library test_entry;

import 'package:flutter_test/flutter_test.dart';
import 'test_architecture.dart';
import 'test_runner.dart';

/// 测试配置
class TestConfiguration {
  static const bool enablePerformanceTests = true;
  static const bool enableAccessibilityTests = true;
  static const bool enableGoldenTests = true;
  static const bool enableCoverage = true;
  static const bool enableReporting = true;
  
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const double goldenTolerance = 0.05;
  static const double performanceThreshold = 16.0;
  static const int memoryThreshold = 100;
  
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

/// 测试套件基类
abstract class TestSuite {
  final String name;
  final List<VoidCallback> setUpCallbacks = [];
  final List<VoidCallback> tearDownCallbacks = [];
  final List<VoidCallback> testCallbacks = [];
  
  TestSuite(this.name);
  
  /// 添加设置回调
  void addSetUp(VoidCallback callback) {
    setUpCallbacks.add(callback);
  }
  
  /// 添加清理回调
  void addTearDown(VoidCallback callback) {
    tearDownCallbacks.add(callback);
  }
  
  /// 添加测试回调
  void addTest(VoidCallback callback) {
    testCallbacks.add(callback);
  }
  
  /// 运行测试套件
  Future<void> run() async {
    print('🚀 Running test suite: $name');
    
    // 执行设置
    for (final callback in setUpCallbacks) {
      callback();
    }
    
    try {
      // 执行测试
      for (final callback in testCallbacks) {
        callback();
      }
    } finally {
      // 执行清理
      for (final callback in tearDownCallbacks) {
        callback();
      }
    }
    
    print('✅ Test suite completed: $name');
  }
}

/// 单元测试套件
class UnitTestSuite extends TestSuite {
  UnitTestSuite() : super('Unit Tests');
  
  @override
  Future<void> run() async {
    print('🧪 Running unit tests...');
    await super.run();
  }
}

/// 组件测试套件
class WidgetTestSuite extends TestSuite {
  WidgetTestSuite() : super('Widget Tests');
  
  @override
  Future<void> run() async {
    print('🔧 Running widget tests...');
    await super.run();
  }
}

/// 集成测试套件
class IntegrationTestSuite extends TestSuite {
  IntegrationTestSuite() : super('Integration Tests');
  
  @override
  Future<void> run() async {
    print('🔗 Running integration tests...');
    await super.run();
  }
}

/// 性能测试套件
class PerformanceTestSuite extends TestSuite {
  PerformanceTestSuite() : super('Performance Tests');
  
  @override
  Future<void> run() async {
    print('⚡ Running performance tests...');
    await super.run();
  }
}

/// 无障碍测试套件
class AccessibilityTestSuite extends TestSuite {
  AccessibilityTestSuite() : super('Accessibility Tests');
  
  @override
  Future<void> run() async {
    print('♿ Running accessibility tests...');
    await super.run();
  }
}

/// 截图测试套件
class GoldenTestSuite extends TestSuite {
  GoldenTestSuite() : super('Golden Tests');
  
  @override
  Future<void> run() async {
    print('🖼️ Running golden tests...');
    await super.run();
  }
}

/// 测试运行器
class TestRunner {
  final List<TestSuite> suites = [];
  
  /// 添加测试套件
  void addSuite(TestSuite suite) {
    suites.add(suite);
  }
  
  /// 运行所有测试
  Future<void> runAll() async {
    print('🎯 Running all test suites...');
    
    for (final suite in suites) {
      await suite.run();
    }
    
    print('🎉 All test suites completed!');
  }
  
  /// 运行指定测试套件
  Future<void> runSuite(String name) async {
    final suite = suites.firstWhere(
      (s) => s.name == name,
      orElse: () => throw Exception('Test suite not found: $name'),
    );
    
    await suite.run();
  }
  
  /// 获取默认测试运行器
  static TestRunner getDefault() {
    final runner = TestRunner();
    
    runner.addSuite(UnitTestSuite());
    runner.addSuite(WidgetTestSuite());
    runner.addSuite(IntegrationTestSuite());
    
    if (TestConfiguration.enablePerformanceTests) {
      runner.addSuite(PerformanceTestSuite());
    }
    
    if (TestConfiguration.enableAccessibilityTests) {
      runner.addSuite(AccessibilityTestSuite());
    }
    
    if (TestConfiguration.enableGoldenTests) {
      runner.addSuite(GoldenTestSuite());
    }
    
    return runner;
  }
}

/// 测试入口点
void main(List<String> args) async {
  // 初始化测试数据工厂
  TestDataFactoryManager.initializeDefaultFactories();
  
  // 注册常用测试用例
  CommonTestFixtures.registerCommonFixtures();
  
  // 创建测试运行器
  final runner = TestRunner.getDefault();
  
  if (args.isEmpty) {
    print('用法: dart test [选项]');
    print('选项:');
    print('  all - 运行所有测试');
    print('  unit - 运行单元测试');
    print('  widget - 运行组件测试');
    print('  integration - 运行集成测试');
    print('  performance - 运行性能测试');
    print('  accessibility - 运行无障碍测试');
    print('  golden - 运行截图测试');
    print('  report - 生成测试报告');
    print('  clean - 清理测试结果');
    return;
  }
  
  final command = args.first;
  
  switch (command) {
    case 'all':
      await runner.runAll();
      break;
    case 'unit':
      await runner.runSuite('Unit Tests');
      break;
    case 'widget':
      await runner.runSuite('Widget Tests');
      break;
    case 'integration':
      await runner.runSuite('Integration Tests');
      break;
    case 'performance':
      if (TestConfiguration.enablePerformanceTests) {
        await runner.runSuite('Performance Tests');
      } else {
        print('Performance tests are disabled');
      }
      break;
    case 'accessibility':
      if (TestConfiguration.enableAccessibilityTests) {
        await runner.runSuite('Accessibility Tests');
      } else {
        print('Accessibility tests are disabled');
      }
      break;
    case 'golden':
      if (TestConfiguration.enableGoldenTests) {
        await runner.runSuite('Golden Tests');
      } else {
        print('Golden tests are disabled');
      }
      break;
    case 'report':
      if (TestConfiguration.enableReporting) {
        await TestRunner.runTestsWithReport();
      } else {
        print('Reporting is disabled');
      }
      break;
    case 'clean':
      await TestRunner.cleanTestResults();
      break;
    default:
      print('未知命令: $command');
  }
}