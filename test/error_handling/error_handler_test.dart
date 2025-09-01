import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// TODO: 重新导入错误处理相关的文件
// import 'package:zephyr_ui/src/core/error_handling/error_handler.dart';
// import 'package:zephyr_ui/src/core/error_handling/error_types.dart';
import 'package:zephyr_ui/src/core/internationalization/error_messages.dart';

// 临时定义错误处理相关的类
class ZephyrErrorLogger {
  Future<void> logError(dynamic error) async {}
}

class ZephyrErrorReporter {
  Future<void> reportError(dynamic error) async {}
}

class ZephyrErrorHandler {
  static final ZephyrErrorHandler instance = ZephyrErrorHandler._internal();
  
  ZephyrErrorHandler._internal();

  void init(ZephyrErrorHandlerConfig config) {}

  Future<void> handleError(dynamic error, {BuildContext? context, dynamic strategy}) async {}
}

class ZephyrErrorHandlerConfig {
  final dynamic defaultStrategy;
  
  const ZephyrErrorHandlerConfig({this.defaultStrategy});
}

// Mock classes
class MockBuildContext extends Mock implements BuildContext {}

class MockErrorLogger extends Mock implements ZephyrErrorLogger {}

class MockErrorReporter extends Mock implements ZephyrErrorReporter {}

void main() {
  group('ZephyrErrorHandler', () {
    late ZephyrErrorHandler handler;
    late MockErrorLogger mockLogger;
    late MockErrorReporter mockReporter;
    late MockBuildContext mockContext;

    setUp(() {
      mockLogger = MockErrorLogger();
      mockReporter = MockErrorReporter();
      mockContext = MockBuildContext();
      
      // Mock the singleton instances
      when(() => mockLogger.logError(any())).thenAnswer((_) async {});
      when(() => mockReporter.reportError(any())).thenAnswer((_) async {});
      
      handler = ZephyrErrorHandler.instance;
    });

    tearDown(() {
      reset(mockLogger);
      reset(mockReporter);
      reset(mockContext);
    });

    group('Initialization', () {
      test('should initialize with default config', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        expect(handler, isNotNull);
      });

      test('should set Flutter error callback', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        // Verify FlutterError.onError is set
        expect(FlutterError.onError, isNotNull);
      });
    });

    group('Error Handling', () {
      test('should handle error with logOnly strategy', () async {
        final config = ZephyrErrorHandlerConfig(
          defaultStrategy: ZephyrErrorHandlingStrategy.logOnly,
        );
        handler.init(config);
        
        final error = ZephyrError(
          code: 'TEST_ERROR',
          message: 'Test error message',
        );
        
        await handler.handleError(error);
        
        verify(() => mockLogger.logError(error)).called(1);
        verifyNever(() => mockReporter.reportError(error));
      });

      test('should handle error with showUserMessage strategy', () async {
        final config = ZephyrErrorHandlerConfig(
          defaultStrategy: ZephyrErrorHandlingStrategy.showUserMessage,
        );
        handler.init(config);
        
        final error = ZephyrError(
          code: 'TEST_ERROR',
          message: 'Test error message',
        );
        
        await handler.handleError(error, context: mockContext);
        
        verify(() => mockLogger.logError(error)).called(1);
        verify(() => mockReporter.reportError(error)).called(1);
      });

      test('should handle error with autoRecover strategy', () async {
        final config = ZephyrErrorHandlerConfig(
          defaultStrategy: ZephyrErrorHandlingStrategy.autoRecover,
          enableAutoRecovery: true,
        );
        handler.init(config);
        
        final error = ZephyrError(
          code: 'TEST_ERROR',
          message: 'Test error message',
          isRecoverable: true,
        );
        
        // Register a recoverer
        handler.registerRecoverer('TEST_ERROR', (error) async {
          return null; // Successfully recovered
        });
        
        await handler.handleError(error, context: mockContext);
        
        verify(() => mockLogger.logError(error)).called(1);
        verify(() => mockReporter.reportError(error)).called(1);
      });

      test('should handle Flutter framework error', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        final exception = Exception('Flutter error');
        final stackTrace = StackTrace.current;
        
        FlutterError.onError!(FlutterErrorDetails(
          exception: exception,
          stack: stackTrace,
        ));
        
        verify(() => mockLogger.logError(argThat(
          isA<ZephyrError>()
            .having((e) => e.code, 'code', ZephyrErrorCodes.internalError)
            .having((e) => e.originalException, 'originalException', exception)
            .having((e) => e.stackTrace, 'stackTrace', stackTrace),
        ))).called(1);
      });
    });

    group('Error Recovery', () {
      test('should register and call recoverer', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        var recovererCalled = false;
        
        handler.registerRecoverer('TEST_ERROR', (error) async {
          recovererCalled = true;
          return null;
        });
        
        final error = ZephyrError(
          code: 'TEST_ERROR',
          message: 'Test error message',
          isRecoverable: true,
        );
        
        await handler.handleError(
          error,
          context: mockContext,
          strategy: ZephyrErrorHandlingStrategy.autoRecover,
        );
        
        expect(recovererCalled, isTrue);
      });

      test('should unregister recoverer', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        handler.registerRecoverer('TEST_ERROR', (error) async {
          return null;
        });
        
        handler.unregisterRecoverer('TEST_ERROR');
        
        // Should not throw when trying to recover with unregistered recoverer
        await expectLater(
          () => handler.handleError(
            ZephyrError(
              code: 'TEST_ERROR',
              message: 'Test error message',
              isRecoverable: true,
            ),
            context: mockContext,
            strategy: ZephyrErrorHandlingStrategy.autoRecover,
          ),
          returnsNormally,
        );
      });
    });

    group('Error Listeners', () {
      test('should notify error listeners', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        var listenerCalled = false;
        ZephyrError? receivedError;
        
        handler.addErrorListener((error) {
          listenerCalled = true;
          receivedError = error;
        });
        
        final error = ZephyrError(
          code: 'TEST_ERROR',
          message: 'Test error message',
        );
        
        await handler.handleError(error);
        
        expect(listenerCalled, isTrue);
        expect(receivedError, equals(error));
      });

      test('should remove error listener', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        var listenerCalled = false;
        
        void listener(ZephyrError error) {
          listenerCalled = true;
        }
        
        handler.addErrorListener(listener);
        handler.removeErrorListener(listener);
        
        final error = ZephyrError(
          code: 'TEST_ERROR',
          message: 'Test error message',
        );
        
        await handler.handleError(error);
        
        expect(listenerCalled, isFalse);
      });
    });

    group('Safe Execution', () {
      test('should execute function safely', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        final result = await handler.safeExecute(() async {
          return 'success';
        });
        
        expect(result, equals('success'));
      });

      test('should handle function error', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        expect(
          () => handler.safeExecute(() async {
            throw Exception('Function error');
          }),
          throwsA(isA<Exception>()),
        );
      });

      test('should handle async error', () async {
        final config = ZephyrErrorHandlerConfig();
        handler.init(config);
        
        final future = Future.error(Exception('Async error'));
        
        // Should not throw
        handler.handleAsyncError(future);
        
        // Wait for async processing
        await Future.delayed(Duration.zero);
        
        verify(() => mockLogger.logError(argThat(
          isA<ZephyrError>()
            .having((e) => e.code, 'code', ZephyrErrorCodes.operationFailed),
        ))).called(1);
      });
    });

    group('Error Types', () {
      test('should create component error', () {
        final error = ZephyrComponentError(
          componentName: 'TestComponent',
          code: 'COMPONENT_ERROR',
          message: 'Component error message',
        );
        
        expect(error.componentName, equals('TestComponent'));
        expect(error.code, equals('COMPONENT_ERROR'));
        expect(error.message, equals('Component error message'));
      });

      test('should create theme error', () {
        final error = ZephyrThemeError(
          themeName: 'TestTheme',
          code: 'THEME_ERROR',
          message: 'Theme error message',
        );
        
        expect(error.themeName, equals('TestTheme'));
        expect(error.code, equals('THEME_ERROR'));
        expect(error.message, equals('Theme error message'));
      });

      test('should create network error', () {
        final error = ZephyrNetworkError(
          statusCode: 404,
          url: 'https://example.com',
          code: 'NETWORK_ERROR',
          message: 'Network error message',
        );
        
        expect(error.statusCode, equals(404));
        expect(error.url, equals('https://example.com'));
        expect(error.code, equals('NETWORK_ERROR'));
        expect(error.message, equals('Network error message'));
      });

      test('should create validation error', () {
        final error = ZephyrValidationError(
          field: 'email',
          value: 'invalid-email',
          code: 'VALIDATION_ERROR',
          message: 'Validation error message',
        );
        
        expect(error.field, equals('email'));
        expect(error.value, equals('invalid-email'));
        expect(error.code, equals('VALIDATION_ERROR'));
        expect(error.message, equals('Validation error message'));
      });

      test('should create accessibility error', () {
        final error = ZephyrAccessibilityError(
          checkItem: 'color_contrast',
          wcagGuideline: '1.4.3',
          code: 'ACCESSIBILITY_ERROR',
          message: 'Accessibility error message',
        );
        
        expect(error.checkItem, equals('color_contrast'));
        expect(error.wcagGuideline, equals('1.4.3'));
        expect(error.code, equals('ACCESSIBILITY_ERROR'));
        expect(error.message, equals('Accessibility error message'));
      });
    });

    group('Error Codes', () {
      test('should have all required error codes', () {
        expect(ZephyrErrorCodes.unknownError, equals('UNKNOWN_ERROR'));
        expect(ZephyrErrorCodes.internalError, equals('INTERNAL_ERROR'));
        expect(ZephyrErrorCodes.invalidArgument, equals('INVALID_ARGUMENT'));
        expect(ZephyrErrorCodes.operationFailed, equals('OPERATION_FAILED'));
        expect(ZephyrErrorCodes.networkError, equals('NETWORK_ERROR'));
        expect(ZephyrErrorCodes.validationError, equals('VALIDATION_ERROR'));
        expect(ZephyrErrorCodes.accessibilityError, equals('ACCESSIBILITY_ERROR'));
      });
    });

    group('Error Levels', () {
      test('should map error levels correctly', () {
        expect(ZephyrErrorLevel.debug.index, equals(0));
        expect(ZephyrErrorLevel.info.index, equals(1));
        expect(ZephyrErrorLevel.warning.index, equals(2));
        expect(ZephyrErrorLevel.error.index, equals(3));
        expect(ZephyrErrorLevel.critical.index, equals(4));
        expect(ZephyrErrorLevel.fatal.index, equals(5));
      });
    });

    group('Error Handling Strategies', () {
      test('should have all required strategies', () {
        expect(ZephyrErrorHandlingStrategy.values, contains(ZephyrErrorHandlingStrategy.logOnly));
        expect(ZephyrErrorHandlingStrategy.values, contains(ZephyrErrorHandlingStrategy.showUserMessage));
        expect(ZephyrErrorHandlingStrategy.values, contains(ZephyrErrorHandlingStrategy.showDetailedDialog));
        expect(ZephyrErrorHandlingStrategy.values, contains(ZephyrErrorHandlingStrategy.autoRecover));
        expect(ZephyrErrorHandlingStrategy.values, contains(ZephyrErrorHandlingStrategy.navigateToErrorPage));
        expect(ZephyrErrorHandlingStrategy.values, contains(ZephyrErrorHandlingStrategy.restartApp));
      });
    });
  });
}