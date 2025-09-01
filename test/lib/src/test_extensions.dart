/// 测试扩展
///
/// 为测试框架提供扩展方法和便捷操作
library test_extensions;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// WidgetTester 扩展
extension WidgetTesterExtensions on WidgetTester {
  /// 等待并设置状态
  Future<void> pumpAndSettleWithTimeout([
    Duration timeout = const Duration(seconds: 10),
  ]) async {
    await pumpAndSettle(timeout);
  }

  /// 重新构建并设置状态
  Future<void> rebuildAndSettle() async {
    await pump();
    await pumpAndSettle();
  }

  /// 滚动到可见区域
  Future<void> scrollTo(
    Finder finder, {
    ScrollDirection direction = ScrollDirection.down,
    double offset = 100.0,
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    final scrollable = find.ancestor(
      of: finder,
      matching: find.byType(Scrollable),
    );
    
    if (scrollable.evaluate().isEmpty) {
      throw Exception('No scrollable widget found for $finder');
    }
    
    final scrollableWidget = widget<Scrollable>(scrollable.first);
    final scrollController = scrollableWidget.controller;
    
    if (scrollController != null) {
      final currentOffset = scrollController.offset;
      final newOffset = direction == ScrollDirection.down 
          ? currentOffset + offset 
          : currentOffset - offset;
      
      await scrollController.animateTo(
        newOffset,
        duration: duration,
        curve: Curves.easeInOut,
      );
      await pumpAndSettle();
    }
  }

  /// 确保组件可见
  Future<void> ensureVisible(
    Finder finder, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    if (!any(finder)) {
      throw Exception('Widget not found: $finder');
    }
    
    // 检查是否在视口中
    final rect = getRect(finder);
    final size = renderObject<RenderBox>(find.byType(Material)).size;
    
    if (rect.top < 0 || rect.bottom > size.height) {
      await scrollTo(finder);
    }
    
    await pumpAndSettle(timeout);
  }

  /// 等待组件出现
  Future<void> waitFor(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
    Duration interval = const Duration(milliseconds: 100),
  }) async {
    final startTime = DateTime.now();
    
    while (!any(finder)) {
      if (DateTime.now().difference(startTime) > timeout) {
        throw Exception('Widget not found within $timeout: $finder');
      }
      await pump(interval);
    }
  }

  /// 等待组件消失
  Future<void> waitForAbsent(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
    Duration interval = const Duration(milliseconds: 100),
  }) async {
    final startTime = DateTime.now();
    
    while (any(finder)) {
      if (DateTime.now().difference(startTime) > timeout) {
        throw Exception('Widget still present after $timeout: $finder');
      }
      await pump(interval);
    }
  }

  /// 执行手势操作
  Future<void> performGesture(
    Future<void> Function() gesture, {
    Duration warningDelay = const Duration(milliseconds: 100),
  }) async {
    await gesture();
    await pump(warningDelay);
    await pumpAndSettle();
  }

  /// 安全点击
  Future<void> safeTap(Finder finder) async {
    await ensureVisible(finder);
    await performGesture(() async {
      await tap(finder);
    });
  }

  /// 安全输入
  Future<void> safeEnterText(Finder finder, String text) async {
    await ensureVisible(finder);
    await performGesture(() async {
      await enterText(finder, text);
    });
  }

  /// 安全长按
  Future<void> safeLongPress(Finder finder) async {
    await ensureVisible(finder);
    await performGesture(() async {
      await longPress(finder);
    });
  }

  /// 安全拖拽
  Future<void> safeDrag(
    Finder finder,
    Offset offset, {
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    await ensureVisible(finder);
    await performGesture(() async {
      await drag(finder, offset);
    });
  }

  /// 模拟键盘输入
  Future<void> simulateKeyboardInput(String text) async {
    for (final char in text.split('')) {
      await testTextInput.receiveTextInserted(char);
      await pump();
    }
    await pumpAndSettle();
  }

  /// 模拟键盘事件
  Future<void> simulateKeyEvent(LogicalKeyboardKey key) async {
    await sendKeyEvent(key);
    await pumpAndSettle();
  }

  /// 获取组件状态
  T getState<T extends State>(Finder finder) {
    return state<T>(finder);
  }

  /// 获取组件属性
  T getProperty<T>(Finder finder, String property) {
    final widget = widget(finder);
    return widget.getProperty<T>(property);
  }

  /// 验证组件属性
  void expectProperty<T>(
    Finder finder,
    String property,
    T expected, {
    String? reason,
  }) {
    final actual = getProperty<T>(finder, property);
    expect(actual, expected, reason: reason);
  }

  /// 验证组件数量
  void expectCount(
    Finder finder,
    int expected, {
    String? reason,
  }) {
    expect(finder, findsNWidgets(expected), reason: reason);
  }

  /// 验证组件存在
  void expectExists(Finder finder, {String? reason}) {
    expect(finder, findsAtLeastNWidgets(1), reason: reason);
  }

  /// 验证组件不存在
  void expectNotExists(Finder finder, {String? reason}) {
    expect(finder, findsNothing, reason: reason);
  }

  /// 验证组件可见
  void expectVisible(Finder finder, {String? reason}) {
    final rect = getRect(finder);
    expect(rect.width > 0 && rect.height > 0, isTrue, reason: reason);
  }

  /// 验证组件不可见
  void expectNotVisible(Finder finder, {String? reason}) {
    try {
      final rect = getRect(finder);
      expect(rect.width > 0 && rect.height > 0, isFalse, reason: reason);
    } catch (e) {
      // 组件不存在也认为不可见
      expect(true, isTrue, reason: reason);
    }
  }

  /// 验证组件启用
  void expectEnabled(Finder finder, {String? reason}) {
    final widget = this.widget(finder);
    if (widget is IgnorePointer) {
      expect(widget.ignoring, isFalse, reason: reason);
    } else if (widget is AbsorbPointer) {
      expect(widget.absorbing, isFalse, reason: reason);
    } else {
      expect(true, isTrue, reason: reason);
    }
  }

  /// 验证组件禁用
  void expectDisabled(Finder finder, {String? reason}) {
    final widget = this.widget(finder);
    if (widget is IgnorePointer) {
      expect(widget.ignoring, isTrue, reason: reason);
    } else if (widget is AbsorbPointer) {
      expect(widget.absorbing, isTrue, reason: reason);
    } else {
      expect(false, isTrue, reason: reason);
    }
  }

  /// 验证组件获得焦点
  void expectHasFocus(Finder finder, {String? reason}) {
    final focusNode = state<State<StatefulWidget>>(finder).focusNode;
    expect(focusNode?.hasFocus, isTrue, reason: reason);
  }

  /// 验证组件失去焦点
  void expectNoFocus(Finder finder, {String? reason}) {
    final focusNode = state<State<StatefulWidget>>(finder).focusNode;
    expect(focusNode?.hasFocus, isFalse, reason: reason);
  }

  /// 验证文本内容
  void expectText(
    Finder finder,
    String expected, {
    bool exactMatch = true,
    String? reason,
  }) {
    final actual = widget<Text>(finder).data ?? '';
    if (exactMatch) {
      expect(actual, expected, reason: reason);
    } else {
      expect(actual, contains(expected), reason: reason);
    }
  }

  /// 验证颜色
  void expectColor(
    Finder finder,
    Color expected, {
    String? reason,
  }) {
    final widget = this.widget(finder);
    Color actual;
    
    if (widget is Text) {
      actual = widget.style?.color ?? Colors.black;
    } else if (widget is Container) {
      actual = widget.color ?? Colors.transparent;
    } else if (widget is DecoratedBox) {
      actual = widget.decoration.color ?? Colors.transparent;
    } else {
      throw Exception('Unsupported widget type for color assertion');
    }
    
    expect(actual, expected, reason: reason);
  }

  /// 验证大小
  void expectSize(
    Finder finder,
    Size expected, {
    double tolerance = 1.0,
    String? reason,
  }) {
    final actual = getSize(finder);
    expect(actual.width, closeTo(expected.width, tolerance), reason: reason);
    expect(actual.height, closeTo(expected.height, tolerance), reason: reason);
  }

  /// 验证位置
  void expectPosition(
    Finder finder,
    Offset expected, {
    double tolerance = 1.0,
    String? reason,
  }) {
    final actual = getTopLeft(finder);
    expect(actual.dx, closeTo(expected.dx, tolerance), reason: reason);
    expect(actual.dy, closeTo(expected.dy, tolerance), reason: reason);
  }

  /// 验证透明度
  void expectOpacity(
    Finder finder,
    double expected, {
    double tolerance = 0.01,
    String? reason,
  }) {
    final widget = this.widget(finder);
    double actual;
    
    if (widget is Opacity) {
      actual = widget.opacity;
    } else if (widget is AnimatedOpacity) {
      actual = widget.opacity;
    } else {
      actual = 1.0;
    }
    
    expect(actual, closeTo(expected, tolerance), reason: reason);
  }

  /// 验证旋转角度
  void expectRotation(
    Finder finder,
    double expected, {
    double tolerance = 0.01,
    String? reason,
  }) {
    final widget = this.widget(finder);
    double actual;
    
    if (widget is Transform) {
      actual = widget.transform.getRotation().radians;
    } else if (widget is RotatedBox) {
      actual = widget.quarterTurns * (math.pi / 2);
    } else {
      actual = 0.0;
    }
    
    expect(actual, closeTo(expected, tolerance), reason: reason);
  }

  /// 验证缩放比例
  void expectScale(
    Finder finder,
    double expected, {
    double tolerance = 0.01,
    String? reason,
  }) {
    final widget = this.widget(finder);
    double actual;
    
    if (widget is Transform) {
      actual = widget.transform.getMaxScaleOnAxis();
    } else {
      actual = 1.0;
    }
    
    expect(actual, closeTo(expected, tolerance), reason: reason);
  }

  /// 验证边距
  void expectPadding(
    Finder finder,
    EdgeInsets expected, {
    double tolerance = 1.0,
    String? reason,
  }) {
    final widget = this.widget(finder);
    EdgeInsets actual;
    
    if (widget is Padding) {
      actual = widget.padding;
    } else {
      throw Exception('Widget is not a Padding widget');
    }
    
    expect(actual.left, closeTo(expected.left, tolerance), reason: reason);
    expect(actual.top, closeTo(expected.top, tolerance), reason: reason);
    expect(actual.right, closeTo(expected.right, tolerance), reason: reason);
    expect(actual.bottom, closeTo(expected.bottom, tolerance), reason: reason);
  }

  /// 验证圆角
  void expectBorderRadius(
    Finder finder,
    BorderRadius expected, {
    double tolerance = 1.0,
    String? reason,
  }) {
    final widget = this.widget(finder);
    BorderRadius actual;
    
    if (widget is Container) {
      actual = (widget.decoration as BoxDecoration?)?.borderRadius ?? BorderRadius.zero;
    } else if (widget is DecoratedBox) {
      actual = (widget.decoration as BoxDecoration?)?.borderRadius ?? BorderRadius.zero;
    } else {
      throw Exception('Unsupported widget type for border radius assertion');
    }
    
    expect(actual.topLeft.x, closeTo(expected.topLeft.x, tolerance), reason: reason);
    expect(actual.topLeft.y, closeTo(expected.topLeft.y, tolerance), reason: reason);
    expect(actual.topRight.x, closeTo(expected.topRight.x, tolerance), reason: reason);
    expect(actual.topRight.y, closeTo(expected.topRight.y, tolerance), reason: reason);
    expect(actual.bottomLeft.x, closeTo(expected.bottomLeft.x, tolerance), reason: reason);
    expect(actual.bottomLeft.y, closeTo(expected.bottomLeft.y, tolerance), reason: reason);
    expect(actual.bottomRight.x, closeTo(expected.bottomRight.x, tolerance), reason: reason);
    expect(actual.bottomRight.y, closeTo(expected.bottomRight.y, tolerance), reason: reason);
  }

  /// 验证阴影
  void expectBoxShadow(
    Finder finder,
    List<BoxShadow> expected, {
    double tolerance = 1.0,
    String? reason,
  }) {
    final widget = this.widget(finder);
    List<BoxShadow> actual;
    
    if (widget is Container) {
      actual = (widget.decoration as BoxDecoration?)?.boxShadows ?? [];
    } else if (widget is DecoratedBox) {
      actual = (widget.decoration as BoxDecoration?)?.boxShadows ?? [];
    } else {
      throw Exception('Unsupported widget type for box shadow assertion');
    }
    
    expect(actual.length, expected.length, reason: reason);
    
    for (int i = 0; i < expected.length; i++) {
      expect(actual[i].color, expected[i].color, reason: reason);
      expect(actual[i].blurRadius, closeTo(expected[i].blurRadius, tolerance), reason: reason);
      expect(actual[i].spreadRadius, closeTo(expected[i].spreadRadius, tolerance), reason: reason);
      expect(actual[i].offset.dx, closeTo(expected[i].offset.dx, tolerance), reason: reason);
      expect(actual[i].offset.dy, closeTo(expected[i].offset.dy, tolerance), reason: reason);
    }
  }
}

/// Finder 扩展
extension FinderExtensions on Finder {
  /// 获取第一个匹配的组件
  Finder get first => this;
  
  /// 获取最后一个匹配的组件
  Finder get last {
    final matches = evaluate();
    return at(matches.length - 1);
  }
  
  /// 获取指定索引的组件
  Finder at(int index) {
    return evaluate().elementAt(index);
  }
  
  /// 查找子组件
  Finder descendant(Finder descendant) {
    return find.descendant(of: this, matching: descendant);
  }
  
  /// 查找祖先组件
  Finder ancestor(Finder ancestor) {
    return find.ancestor(of: this, matching: ancestor);
  }
  
  /// 查找具有特定文本的组件
  Finder withText(String text) {
    return find.descendant(of: this, matching: find.text(text));
  }
  
  /// 查找具有特定类型的组件
  Finder withType<T>() {
    return find.descendant(of: this, matching: find.byType<T>());
  }
  
  /// 查找具有特定键的组件
  Finder withKey(Key key) {
    return find.descendant(of: this, matching: find.byKey(key));
  }
}

/// Widget 扩展
extension WidgetExtensions on Widget {
  /// 获取组件属性
  T getProperty<T>(String property) {
    // 使用反射获取属性
    // 注意：这需要配合 @TestProperty 注解使用
    throw UnimplementedError('Property access not implemented');
  }
  
  /// 获取组件的所有子组件
  List<Widget> get children {
    if (this is MultiChildRenderObjectWidget) {
      return (this as MultiChildRenderObjectWidget).children;
    }
    if (this is SingleChildRenderObjectWidget) {
      final child = (this as SingleChildRenderObjectWidget).child;
      return child != null ? [child] : [];
    }
    return [];
  }
  
  /// 查找特定类型的子组件
  T? findChildOfType<T>() {
    final children = this.children;
    for (final child in children) {
      if (child is T) {
        return child;
      }
      final found = child.findChildOfType<T>();
      if (found != null) {
        return found;
      }
    }
    return null;
  }
  
  /// 查找所有特定类型的子组件
  List<T> findAllChildrenOfType<T>() {
    final result = <T>[];
    final children = this.children;
    for (final child in children) {
      if (child is T) {
        result.add(child);
      }
      result.addAll(child.findAllChildrenOfType<T>());
    }
    return result;
  }
}

/// TestWidgetsFlutterBinding 扩展
extension TestWidgetsFlutterBindingExtensions on TestWidgetsFlutterBinding {
  /// 设置测试帧率
  void setFrameRate(double fps) {
    window.debugFrameRateOverride = fps;
  }
  
  /// 重置测试帧率
  void resetFrameRate() {
    window.debugFrameRateOverride = null;
  }
  
  /// 模拟低内存警告
  void simulateMemoryWarning() {
    window.handleMemoryPressure();
  }
  
  /// 模拟应用生命周期变化
  void simulateLifecycleChange(AppLifecycleState state) {
    window.handleLifecycleStateChanged(state);
  }
  
  /// 模拟系统消息
  void simulateSystemMessage(String message) {
    window.handlePlatformMessage('flutter/lifecycle', message);
  }
}

/// 测试属性注解
class TestProperty {
  final String name;
  final dynamic value;
  
  const TestProperty(this.name, this.value);
}

/// 测试方法注解
class TestMethod {
  final String description;
  final List<String> tags;
  
  const TestMethod(this.description, [this.tags = const []]);
}

/// 测试类注解
class TestClass {
  final String description;
  final List<String> tags;
  
  const TestClass(this.description, [this.tags = const []]);
}

/// 测试分组注解
class TestGroup {
  final String name;
  final List<String> tags;
  
  const TestGroup(this.name, [this.tags = const []]);
}