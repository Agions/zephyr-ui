/// 测试辅助类
///
/// 提供通用的测试辅助功能和工具方法
library test_helpers;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// 测试辅助类
class TestHelpers {
  /// 创建测试用的 BuildContext
  static Widget createTestWidget({
    required Widget child,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
  }) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: Material(
        color: brightness == Brightness.dark ? Colors.black : Colors.white,
        child: child,
      ),
    );
  }

  /// 创建测试用的 Scaffold
  static Widget createTestScaffold({
    required Widget child,
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? drawer,
    Widget? endDrawer,
    Widget? bottomNavigationBar,
    Widget? persistentFooterButtons,
  }) {
    return Scaffold(
      appBar: appBar,
      body: child,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
      persistentFooterButtons: persistentFooterButtons,
    );
  }

  /// 等待指定的持续时间
  static Future<void> wait(Duration duration) {
    return Future.delayed(duration);
  }

  /// 等待直到条件满足
  static Future<void> waitUntil(
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 10),
    Duration interval = const Duration(milliseconds: 100),
  }) async {
    final startTime = DateTime.now();
    
    while (!condition()) {
      if (DateTime.now().difference(startTime) > timeout) {
        throw TimeoutException('Condition not met within $timeout');
      }
      await wait(interval);
    }
  }

  /// 模拟用户滚动
  static Future<void> scroll(
    WidgetTester tester,
    Finder finder, {
    ScrollDirection direction = ScrollDirection.down,
    double offset = 100.0,
  }) async {
    final scrollable = find.ancestor(
      of: finder,
      matching: find.byType(Scrollable),
    );
    
    expect(scrollable, findsAtLeastNWidgets(1), 
           reason: 'No scrollable widget found for $finder');
    
    final scrollableWidget = tester.widget<Scrollable>(scrollable.first);
    final scrollController = scrollableWidget.controller;
    
    if (scrollController != null) {
      final currentOffset = scrollController.offset;
      final newOffset = direction == ScrollDirection.down 
          ? currentOffset + offset 
          : currentOffset - offset;
      
      await scrollController.animateTo(
        newOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      await tester.pumpAndSettle();
    }
  }

  /// 模拟用户点击
  static Future<void> tap(
    WidgetTester tester,
    Finder finder, {
    Duration warningDelay = const Duration(milliseconds: 100),
  }) async {
    expect(finder, findsAtLeastNWidgets(1), 
           reason: 'No widget found for $finder');
    
    await tester.tap(finder);
    await tester.pump(warningDelay);
    await tester.pumpAndSettle();
  }

  /// 模拟用户输入
  static Future<void> enterText(
    WidgetTester tester,
    Finder finder,
    String text, {
    Duration warningDelay = const Duration(milliseconds: 100),
  }) async {
    expect(finder, findsAtLeastNWidgets(1), 
           reason: 'No widget found for $finder');
    
    await tester.enterText(finder, text);
    await tester.pump(warningDelay);
    await tester.pumpAndSettle();
  }

  /// 模拟用户拖拽
  static Future<void> drag(
    WidgetTester tester,
    Finder finder,
    Offset offset, {
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    expect(finder, findsAtLeastNWidgets(1), 
           reason: 'No widget found for $finder');
    
    await tester.drag(finder, offset);
    await tester.pumpAndSettle(duration);
  }

  /// 模拟用户长按
  static Future<void> longPress(
    WidgetTester tester,
    Finder finder, {
    Duration duration = const Duration(milliseconds: 500),
  }) async {
    expect(finder, findsAtLeastNWidgets(1), 
           reason: 'No widget found for $finder');
    
    await tester.longPress(finder);
    await tester.pump(duration);
    await tester.pumpAndSettle();
  }

  /// 获取组件的大小和位置
  static Rect getWidgetRect(WidgetTester tester, Finder finder) {
    expect(finder, findsAtLeastNWidgets(1), 
           reason: 'No widget found for $finder');
    
    final renderObject = tester.renderObject(finder);
    return renderObject.paintBounds;
  }

  /// 获取组件的文本内容
  static String getText(WidgetTester tester, Finder finder) {
    expect(finder, findsAtLeastNWidgets(1), 
           reason: 'No widget found for $finder');
    
    final widget = tester.widget<Text>(finder);
    return widget.data ?? '';
  }

  /// 验证组件是否可见
  static bool isVisible(WidgetTester tester, Finder finder) {
    try {
      final rect = getWidgetRect(tester, finder);
      return rect.width > 0 && rect.height > 0;
    } catch (e) {
      return false;
    }
  }

  /// 验证组件是否启用
  static bool isEnabled(WidgetTester tester, Finder finder) {
    try {
      final widget = tester.widget(finder);
      if (widget is IgnorePointer) {
        return !widget.ignoring;
      }
      if (widget is AbsorbPointer) {
        return !widget.absorbing;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 验证组件是否获得焦点
  static bool hasFocus(WidgetTester tester, Finder finder) {
    try {
      final focusNode = tester.state<State<StatefulWidget>>(finder).focusNode;
      return focusNode?.hasFocus ?? false;
    } catch (e) {
      return false;
    }
  }

  /// 设置组件焦点
  static Future<void> setFocus(
    WidgetTester tester,
    Finder finder, {
    Duration warningDelay = const Duration(milliseconds: 100),
  }) async {
    expect(finder, findsAtLeastNWidgets(1), 
           reason: 'No widget found for $finder');
    
    await tester.showKeyboard(finder);
    await tester.pump(warningDelay);
    await tester.pumpAndSettle();
  }

  /// 隐藏键盘
  static Future<void> hideKeyboard(WidgetTester tester) async {
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  /// 模拟页面导航
  static Future<void> navigateTo(
    WidgetTester tester,
    String routeName, {
    Object? arguments,
  }) async {
    final navigator = find.byType(Navigator);
    expect(navigator, findsOneWidget, 
           reason: 'No Navigator widget found');
    
    final navigatorState = tester.state<NavigatorState>(navigator);
    navigatorState.pushNamed(routeName, arguments: arguments);
    await tester.pumpAndSettle();
  }

  /// 模拟页面返回
  static Future<void> navigateBack(WidgetTester tester) async {
    final navigator = find.byType(Navigator);
    expect(navigator, findsOneWidget, 
           reason: 'No Navigator widget found');
    
    final navigatorState = tester.state<NavigatorState>(navigator);
    navigatorState.pop();
    await tester.pumpAndSettle();
  }

  /// 验证当前页面
  static void expectCurrentPage(WidgetTester tester, String expectedRoute) {
    final navigator = find.byType(Navigator);
    expect(navigator, findsOneWidget, 
           reason: 'No Navigator widget found');
    
    final navigatorState = tester.state<NavigatorState>(navigator);
    expect(navigatorState.canPop(), isTrue);
    expect(navigatorState.currentRoute?.settings.name, expectedRoute);
  }

  /// 验证对话框显示
  static void expectDialogShowing(WidgetTester tester, {String? title}) {
    final dialogFinder = find.byType(Dialog);
    expect(dialogFinder, findsAtLeastNWidgets(1), 
           reason: 'No dialog widget found');
    
    if (title != null) {
      final titleFinder = find.text(title);
      expect(titleFinder, findsAtLeastNWidgets(1), 
             reason: 'Dialog with title "$title" not found');
    }
  }

  /// 验证对话框关闭
  static void expectDialogNotShowing(WidgetTester tester) {
    final dialogFinder = find.byType(Dialog);
    expect(dialogFinder, findsNothing, 
           reason: 'Dialog is still showing');
  }

  /// 关闭对话框
  static Future<void> closeDialog(WidgetTester tester) async {
    final material = find.descendant(
      of: find.byType(Dialog),
      matching: find.byType(Material),
    );
    
    if (material.evaluate().isNotEmpty) {
      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();
    }
  }

  /// 验证SnackBar显示
  static void expectSnackBarShowing(WidgetTester tester, String message) {
    final snackBarFinder = find.byType(SnackBar);
    expect(snackBarFinder, findsAtLeastNWidgets(1), 
           reason: 'No SnackBar widget found');
    
    final messageFinder = find.text(message);
    expect(messageFinder, findsAtLeastNWidgets(1), 
           reason: 'SnackBar with message "$message" not found');
  }

  /// 验证SnackBar关闭
  static void expectSnackBarNotShowing(WidgetTester tester) {
    final snackBarFinder = find.byType(SnackBar);
    expect(snackBarFinder, findsNothing, 
           reason: 'SnackBar is still showing');
  }

  /// 创建测试用的主题数据
  static ThemeData createTestTheme({
    Brightness brightness = Brightness.light,
    Color primaryColor = Colors.blue,
    Color secondaryColor = Colors.green,
    Color backgroundColor = Colors.white,
    Color surfaceColor = Colors.white,
    Color errorColor = Colors.red,
  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        secondary: secondaryColor,
        background: backgroundColor,
        surface: surfaceColor,
        error: errorColor,
      ),
    );
  }

  /// 创建测试用的 MediaQuery
  static Widget createTestMediaQuery({
    required Widget child,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    Brightness brightness = Brightness.light,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return MediaQuery(
      data: MediaQueryData(
        size: size,
        devicePixelRatio: devicePixelRatio,
        platformBrightness: brightness, textScaler: TextScaler.linear(textScaleFactor.scale),
      ),
      child: child,
    );
  }
}

/// 测试异常类
class TestException implements Exception {
  
  TestException(this.message);
  final String message;
  
  @override
  String toString() => 'TestException: $message';
}

/// 超时异常
class TimeoutException implements Exception {
  
  TimeoutException(this.message);
  final String message;
  
  @override
  String toString() => 'TimeoutException: $message';
}

/// 测试失败异常
class TestFailureException implements Exception {
  
  TestFailureException(this.message);
  final String message;
  
  @override
  String toString() => 'TestFailureException: $message';
}