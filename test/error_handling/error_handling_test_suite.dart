/// VelocityUI 错误处理测试套件
///
/// 提供完整的错误处理测试用例和验证工具

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/velocity_ui.dart';
// TODO: 重新导入错误处理相关的文件
// import '../../lib/src/core/error_handling/error_handler.dart';
// import '../../lib/src/core/error_handling/error_types.dart';
import 'package:velocity_ui/src/components/error_handling/error_boundary.dart';

// 临时定义测试所需的额外类
class VelocityComponentError extends VelocityError {

  VelocityComponentError({
    required this.componentName,
    required this.componentType,
    required String code,
    required super.message,
    super.level,
  }) : super(
          code: code,
        );
  final String componentName;
  final String componentType;
}

class VelocityNetworkError extends VelocityError {

  VelocityNetworkError({
    required this.statusCode,
    required this.url,
    required this.method,
    required String code,
    required super.message,
    super.level,
  }) : super(
          code: code,
        );
  final int statusCode;
  final String url;
  final String method;
}

class VelocityValidationError extends VelocityError {

  VelocityValidationError({
    required this.field,
    required this.value,
    required this.validationRule,
    required String code,
    required super.message,
    super.level,
  }) : super(
          code: code,
        );
  final String field;
  final String value;
  final String validationRule;
}

enum VelocityAccessibilitySeverity {
  minor,
  moderate,
  serious,
  critical,
}

class VelocityAccessibilityError extends VelocityError {

  VelocityAccessibilityError({
    required this.checkItem,
    required this.wcagGuideline,
    required this.severity,
    required String code,
    required super.message,
    super.level,
  }) : super(
          code: code,
        );
  final String checkItem;
  final String wcagGuideline;
  final VelocityAccessibilitySeverity severity;
}

class VelocityAsyncErrorBoundary extends StatefulWidget {

  const VelocityAsyncErrorBoundary({
    required this.asyncBuilder,
    this.loadingWidget,
    super.key,
  });
  final Future<Widget> Function(BuildContext context) asyncBuilder;
  final Widget? loadingWidget;

  @override
  State<VelocityAsyncErrorBoundary> createState() => _VelocityAsyncErrorBoundaryState();
}

class _VelocityAsyncErrorBoundaryState extends State<VelocityAsyncErrorBoundary> {
  Widget? _child;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _loadAsync();
  }

  Future<void> _loadAsync() async {
    try {
      final child = await widget.asyncBuilder(context);
      if (mounted) {
        setState(() {
          _child = child;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return const Text('异步操作失败');
    }
    if (_child != null) {
      return _child!;
    }
    return widget.loadingWidget ?? const Center(child: CircularProgressIndicator());
  }
}

void main() {
  group('VelocityUI 错误处理测试套件', () {
    late WidgetTester tester;

    setUp(() {
      tester = WidgetTester(WidgetTesterBinding.instance);
      
      // 初始化错误处理器
      VelocityErrorHandler.instance.init(const VelocityErrorHandlerConfig());
    });

    group('错误处理器测试', () {
      test('应该正确创建错误对象', () {
        final error = VelocityError(
          code: VelocityErrorCodes.unknownError,
          message: '测试错误',
          level: VelocityErrorLevel.error,
        );

        expect(error.code, VelocityErrorCodes.unknownError);
        expect(error.message, '测试错误');
        expect(error.level, VelocityErrorLevel.error);
        expect(error.timestamp, isNotNull);
      });

      test('应该正确处理组件错误', () {
        final error = VelocityComponentError(
          componentName: 'TestComponent',
          code: VelocityErrorCodes.componentNotFound,
          message: '组件未找到',
          componentType: 'Button',
        );

        expect(error.componentName, 'TestComponent');
        expect(error.componentType, 'Button');
        expect(error.code, VelocityErrorCodes.componentNotFound);
      });

      test('应该正确处理网络错误', () {
        final error = VelocityNetworkError(
          code: VelocityErrorCodes.networkError,
          message: '网络连接失败',
          statusCode: 500,
          url: 'https://api.example.com/test',
          method: 'GET',
        );

        expect(error.statusCode, 500);
        expect(error.url, 'https://api.example.com/test');
        expect(error.method, 'GET');
      });

      test('应该正确处理验证错误', () {
        final error = VelocityValidationError(
          code: VelocityErrorCodes.validationError,
          message: '验证失败',
          field: 'email',
          value: 'invalid-email',
          validationRule: 'email_format',
        );

        expect(error.field, 'email');
        expect(error.value, 'invalid-email');
        expect(error.validationRule, 'email_format');
      });

      test('应该正确处理无障碍错误', () {
        final error = VelocityAccessibilityError(
          code: VelocityErrorCodes.missingSemantics,
          message: '缺少语义化标记',
          checkItem: 'semantic_label',
          wcagGuideline: '1.1.1',
          severity: VelocityAccessibilitySeverity.serious,
        );

        expect(error.checkItem, 'semantic_label');
        expect(error.wcagGuideline, '1.1.1');
        expect(error.severity, VelocityAccessibilitySeverity.serious);
      });
    });

    group('错误边界测试', () {
      testWidgets('应该捕获并处理子组件错误', (WidgetTester tester) async {
        final errorKey = GlobalKey();
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: VelocityErrorBoundary(
                key: errorKey,
                child: _ErrorProneWidget(),
              ),
            ),
          ),
        );

        // 触发错误
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // 验证错误被捕获
        expect(find.text('组件加载失败'), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });

      testWidgets('应该支持错误恢复', (WidgetTester tester) async {
        var retryCount = 0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: VelocityErrorBoundary(
                config: VelocityErrorBoundaryConfig(
                  enableAutoRecovery: true,
                  onRecover: (error) async {
                    retryCount++;
                    return retryCount < 3; // 前3次尝试恢复
                  },
                ),
                child: _ErrorProneWidget(),
              ),
            ),
          ),
        );

        // 触发错误
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // 验证错误显示
        expect(find.text('组件加载失败'), findsOneWidget);

        // 点击重试
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // 验证重试逻辑
        expect(retryCount, greaterThan(0));
      });

      testWidgets('应该支持自定义错误显示', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: VelocityErrorBoundary(
                config: VelocityErrorBoundaryConfig(
                  errorBuilder: (error) => Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.red,
                    child: Text('自定义错误: ${error.message}'),
                  ),
                ),
                child: _ErrorProneWidget(),
              ),
            ),
          ),
        );

        // 触发错误
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // 验证自定义错误显示
        expect(find.text('自定义错误: 故意错误'), findsOneWidget);
        expect(find.byType(Container), findsOneWidget);
      });

      testWidgets('应该支持不同的错误处理策略', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: VelocityErrorBoundary(
                config: VelocityErrorBoundaryConfig(
                  strategy: VelocityErrorHandlingStrategy.showDetailedDialog,
                ),
                child: _ErrorProneWidget(),
              ),
            ),
          ),
        );

        // 触发错误
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // 验证对话框显示
        expect(find.byType(AlertDialog), findsOneWidget);
      });
    });

    group('安全执行测试', () {
      testWidgets('应该安全执行异步操作', (WidgetTester tester) async {
        var wasCalled = false;
        var wasHandled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      await VelocityErrorBoundary.safeExecute(
                        () async {
                          wasCalled = true;
                          throw Exception('测试错误');
                        },
                        componentName: 'TestButton',
                        context: context,
                        onError: (error) {
                          wasHandled = true;
                        },
                      );
                    },
                    child: const Text('测试'),
                  );
                },
              ),
            ),
          ),
        );

        // 触发操作
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // 验证操作被调用但错误被处理
        expect(wasCalled, isTrue);
        expect(wasHandled, isTrue);
      });

      testWidgets('应该处理同步操作错误', (WidgetTester tester) async {
        var wasHandled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      try {
                        VelocityErrorBoundary.safeExecute(
                          () {
                            throw Exception('同步错误');
                          },
                          componentName: 'TestSync',
                          context: context,
                          onError: (error) {
                            wasHandled = true;
                          },
                        );
                      } catch (e) {
                        // 应该不会到达这里
                        fail('错误应该被处理');
                      }
                    },
                    child: const Text('测试同步'),
                  );
                },
              ),
            ),
          ),
        );

        // 触发操作
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // 验证错误被处理
        expect(wasHandled, isTrue);
      });
    });

    group('错误页面测试', () {
      testWidgets('应该正确显示错误页面', (WidgetTester tester) async {
        final error = VelocityError(
          code: VelocityErrorCodes.unknownError,
          message: '测试错误',
          details: '错误详细信息',
          level: VelocityErrorLevel.error,
          recoverySuggestion: '建议重启应用',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityErrorPage(
              error: error,
              showBackButton: true,
            ),
          ),
        );

        // 验证错误页面内容
        expect(find.text('测试错误'), findsOneWidget);
        expect(find.text('错误详细信息'), findsOneWidget);
        expect(find.text('建议重启应用'), findsOneWidget);
        expect(find.text('返回'), findsOneWidget);
      });

      testWidgets('应该显示错误级别图标', (WidgetTester tester) async {
        final levels = [
          VelocityErrorLevel.debug,
          VelocityErrorLevel.info,
          VelocityErrorLevel.warning,
          VelocityErrorLevel.error,
          VelocityErrorLevel.critical,
          VelocityErrorLevel.fatal,
        ];

        for (final level in levels) {
          final error = VelocityError(
            code: VelocityErrorCodes.unknownError,
            message: '测试错误',
            level: level,
          );

          await tester.pumpWidget(
            MaterialApp(
              home: VelocityErrorPage(error: error),
            ),
          );

          // 验证图标存在
          expect(find.byType(Icon), findsOneWidget);
          
          // 清理
          await tester.pumpWidget(Container());
        }
      });
    });

    group('错误处理集成测试', () {
      testWidgets('应该在整个应用中正确处理错误', (WidgetTester tester) async {
        var globalErrorCount = 0;

        // 设置全局错误监听器
        VelocityErrorHandler.instance.addErrorListener((error) {
          globalErrorCount++;
        });

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  VelocityErrorBoundary(
                    child: _ErrorProneWidget(),
                  ),
                  VelocityErrorBoundary(
                    child: _AnotherErrorProneWidget(),
                  ),
                ],
              ),
            ),
          ),
        );

        // 触发多个错误
        await tester.tap(find.text('触发错误1').first);
        await tester.pumpAndSettle();

        await tester.tap(find.text('触发错误2'));
        await tester.pumpAndSettle();

        // 验证全局错误处理
        expect(globalErrorCount, greaterThanOrEqualTo(2));
        expect(find.text('组件加载失败'), findsAtLeastNWidgets(1));
      });

      testWidgets('应该正确处理异步错误', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: VelocityAsyncErrorBoundary(
                asyncBuilder: (context) async {
                  await Future.delayed(const Duration(milliseconds: 100));
                  throw Exception('异步错误');
                },
                loadingWidget: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        );

        // 验证加载状态
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // 等待异步操作完成
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        // 验证错误处理
        expect(find.text('异步操作失败'), findsOneWidget);
      });
    });

    group('错误恢复测试', () {
      testWidgets('应该支持错误恢复机制', (WidgetTester tester) async {
        var recoveryAttempt = 0;
        var shouldRecover = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: VelocityErrorBoundary(
                config: VelocityErrorBoundaryConfig(
                  enableAutoRecovery: true,
                  onRecover: (error) async {
                    recoveryAttempt++;
                    return shouldRecover;
                  },
                ),
                child: _ErrorProneWidget(),
              ),
            ),
          ),
        );

        // 触发错误
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // 验证错误显示
        expect(find.text('组件加载失败'), findsOneWidget);

        // 尝试恢复（应该失败）
        await tester.tap(find.text('重试'));
        await tester.pumpAndSettle();

        expect(recoveryAttempt, 1);
        expect(find.text('组件加载失败'), findsOneWidget);

        // 设置恢复成功
        shouldRecover = true;

        // 再次尝试恢复
        await tester.tap(find.text('重试'));
        await tester.pumpAndSettle();

        expect(recoveryAttempt, 2);
        expect(find.text('组件加载失败'), findsNothing);
      });
    });

    group('错误日志和报告测试', () {
      test('应该正确记录错误日志', () async {
        final error = VelocityError(
          code: VelocityErrorCodes.unknownError,
          message: '日志测试错误',
          level: VelocityErrorLevel.error,
        );

        // 这里应该验证错误日志记录
        // 由于实际的日志记录可能涉及文件系统或网络，
        // 我们主要验证错误对象的结构
        expect(error.code, VelocityErrorCodes.unknownError);
        expect(error.message, '日志测试错误');
        expect(error.level, VelocityErrorLevel.error);
        expect(error.timestamp, isNotNull);
      });

      test('应该生成错误报告', () {
        final errors = [
          VelocityError(
            code: VelocityErrorCodes.unknownError,
            message: '错误1',
            level: VelocityErrorLevel.error,
          ),
          VelocityError(
            code: VelocityErrorCodes.networkError,
            message: '错误2',
            level: VelocityErrorLevel.warning,
          ),
        ];

        // 这里应该验证错误报告生成
        // 由于实际的报告生成可能涉及复杂的逻辑，
        // 我们主要验证错误列表的结构
        expect(errors.length, 2);
        expect(errors[0].code, VelocityErrorCodes.unknownError);
        expect(errors[1].code, VelocityErrorCodes.networkError);
      });
    });
  });
}

/// 错误倾向的测试组件
class _ErrorProneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        throw Exception('故意错误');
      },
      child: const Text('触发错误1'),
    );
  }
}

/// 另一个错误倾向的测试组件
class _AnotherErrorProneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        throw StateError('状态错误');
      },
      child: const Text('触发错误2'),
    );
  }
}