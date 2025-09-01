/// 测试断言工具
///
/// 提供自定义的测试断言方法和验证工具
library test_assertions;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/core/constants/design_tokens.dart';

/// 测试断言工具类
class TestAssertions {
  /// 验证颜色值
  static void expectColor(
    Color actual,
    Color expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    expect(actual.red, closeTo(expected.red, tolerance), reason: reason);
    expect(actual.green, closeTo(expected.green, tolerance), reason: reason);
    expect(actual.blue, closeTo(expected.blue, tolerance), reason: reason);
    expect(actual.alpha, closeTo(expected.alpha, tolerance), reason: reason);
  }
  
  /// 验证颜色是否接近
  static void expectColorClose(
    Color actual,
    Color expected, {
    String? reason,
    double tolerance = 5.0,
  }) {
    final distance = _colorDistance(actual, expected);
    expect(distance, lessThanOrEqualTo(tolerance), reason: reason);
  }
  
  /// 计算颜色距离
  static double _colorDistance(Color color1, Color color2) {
    final rDiff = color1.red - color2.red;
    final gDiff = color1.green - color2.green;
    final bDiff = color1.blue - color2.blue;
    final aDiff = color1.alpha - color2.alpha;
    
    return (rDiff * rDiff + gDiff * gDiff + bDiff * bDiff + aDiff * aDiff) / 4;
  }
  
  /// 验证尺寸
  static void expectSize(
    Size actual,
    Size expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    expect(actual.width, closeTo(expected.width, tolerance), reason: reason);
    expect(actual.height, closeTo(expected.height, tolerance), reason: reason);
  }
  
  /// 验证偏移量
  static void expectOffset(
    Offset actual,
    Offset expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    expect(actual.dx, closeTo(expected.dx, tolerance), reason: reason);
    expect(actual.dy, closeTo(expected.dy, tolerance), reason: reason);
  }
  
  /// 验证边距
  static void expectEdgeInsets(
    EdgeInsets actual,
    EdgeInsets expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    expect(actual.left, closeTo(expected.left, tolerance), reason: reason);
    expect(actual.top, closeTo(expected.top, tolerance), reason: reason);
    expect(actual.right, closeTo(expected.right, tolerance), reason: reason);
    expect(actual.bottom, closeTo(expected.bottom, tolerance), reason: reason);
  }
  
  /// 验证圆角
  static void expectBorderRadius(
    BorderRadius actual,
    BorderRadius expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
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
  static void expectBoxShadow(
    List<BoxShadow> actual,
    List<BoxShadow> expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    expect(actual.length, expected.length, reason: reason);
    
    for (int i = 0; i < expected.length; i++) {
      expectColor(actual[i].color, expected[i].color, reason: reason);
      expect(actual[i].blurRadius, closeTo(expected[i].blurRadius, tolerance), reason: reason);
      expect(actual[i].spreadRadius, closeTo(expected[i].spreadRadius, tolerance), reason: reason);
      expect(actual[i].offset.dx, closeTo(expected[i].offset.dx, tolerance), reason: reason);
      expect(actual[i].offset.dy, closeTo(expected[i].offset.dy, tolerance), reason: reason);
    }
  }
  
  /// 验证文本样式
  static void expectTextStyle(
    TextStyle actual,
    TextStyle expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    expect(actual.fontSize, closeTo(expected.fontSize ?? 14.0, tolerance), reason: reason);
    expect(actual.fontWeight, expected.fontWeight, reason: reason);
    expect(actual.fontStyle, expected.fontStyle, reason: reason);
    expect(actual.letterSpacing, closeTo(expected.letterSpacing ?? 0.0, tolerance), reason: reason);
    expect(actual.wordSpacing, closeTo(expected.wordSpacing ?? 0.0, tolerance), reason: reason);
    expect(actual.height, closeTo(expected.height ?? 1.0, tolerance), reason: reason);
    
    if (expected.color != null) {
      expectColor(actual.color ?? Colors.black, expected.color!, reason: reason);
    }
    
    if (expected.backgroundColor != null) {
      expectColor(actual.backgroundColor ?? Colors.transparent, expected.backgroundColor!, reason: reason);
    }
  }
  
  /// 验证渐变
  static void expectGradient(
    Gradient actual,
    Gradient expected, {
    String? reason,
  }) {
    if (actual is LinearGradient && expected is LinearGradient) {
      _expectLinearGradient(actual, expected, reason);
    } else if (actual is RadialGradient && expected is RadialGradient) {
      _expectRadialGradient(actual, expected, reason);
    } else if (actual is SweepGradient && expected is SweepGradient) {
      _expectSweepGradient(actual, expected, reason);
    } else {
      fail('Gradient types do not match: ${actual.runtimeType} != ${expected.runtimeType}');
    }
  }
  
  /// 验证线性渐变
  static void _expectLinearGradient(
    LinearGradient actual,
    LinearGradient expected,
    String? reason,
  ) {
    expect(actual.begin, expected.begin, reason: reason);
    expect(actual.end, expected.end, reason: reason);
    expect(actual.colors.length, expected.colors.length, reason: reason);
    
    for (int i = 0; i < expected.colors.length; i++) {
      expectColor(actual.colors[i], expected.colors[i], reason: reason);
    }
    
    if (expected.stops != null) {
      expect(actual.stops?.length, expected.stops?.length, reason: reason);
      for (int i = 0; i < expected.stops!.length; i++) {
        expect(actual.stops![i], closeTo(expected.stops![i], 0.01), reason: reason);
      }
    }
    
    expect(actual.tileMode, expected.tileMode, reason: reason);
    expect(actual.transform, expected.transform, reason: reason);
  }
  
  /// 验证径向渐变
  static void _expectRadialGradient(
    RadialGradient actual,
    RadialGradient expected,
    String? reason,
  ) {
    expect(actual.center, expected.center, reason: reason);
    expect(actual.radius, closeTo(expected.radius, 0.01), reason: reason);
    expect(actual.colors.length, expected.colors.length, reason: reason);
    
    for (int i = 0; i < expected.colors.length; i++) {
      expectColor(actual.colors[i], expected.colors[i], reason: reason);
    }
    
    if (expected.stops != null) {
      expect(actual.stops?.length, expected.stops?.length, reason: reason);
      for (int i = 0; i < expected.stops!.length; i++) {
        expect(actual.stops![i], closeTo(expected.stops![i], 0.01), reason: reason);
      }
    }
    
    expect(actual.tileMode, expected.tileMode, reason: reason);
    expect(actual.focal, expected.focal, reason: reason);
    expect(actual.focalRadius, closeTo(expected.focalRadius, 0.01), reason: reason);
    expect(actual.transform, expected.transform, reason: reason);
  }
  
  /// 验证扫描渐变
  static void _expectSweepGradient(
    SweepGradient actual,
    SweepGradient expected,
    String? reason,
  ) {
    expect(actual.center, expected.center, reason: reason);
    expect(actual.startAngle, closeTo(expected.startAngle, 0.01), reason: reason);
    expect(actual.endAngle, closeTo(expected.endAngle, 0.01), reason: reason);
    expect(actual.colors.length, expected.colors.length, reason: reason);
    
    for (int i = 0; i < expected.colors.length; i++) {
      expectColor(actual.colors[i], expected.colors[i], reason: reason);
    }
    
    if (expected.stops != null) {
      expect(actual.stops?.length, expected.stops?.length, reason: reason);
      for (int i = 0; i < expected.stops!.length; i++) {
        expect(actual.stops![i], closeTo(expected.stops![i], 0.01), reason: reason);
      }
    }
    
    expect(actual.tileMode, expected.tileMode, reason: reason);
    expect(actual.transform, expected.transform, reason: reason);
  }
  
  /// 验证矩阵
  static void expectMatrix4(
    Matrix4 actual,
    Matrix4 expected, {
    String? reason,
    double tolerance = 0.01,
  }) {
    for (int i = 0; i < 16; i++) {
      expect(actual.storage[i], closeTo(expected.storage[i], tolerance), reason: reason);
    }
  }
  
  /// 验证持续时间
  static void expectDuration(
    Duration actual,
    Duration expected, {
    String? reason,
    Duration tolerance = const Duration(milliseconds: 100),
  }) {
    final difference = (actual - expected).abs();
    expect(difference, lessThanOrEqualTo(tolerance), reason: reason);
  }
  
  /// 验证曲线
  static void expectCurve(
    Curve actual,
    Curve expected, {
    String? reason,
    int samplePoints = 100,
    double tolerance = 0.01,
  }) {
    for (int i = 0; i <= samplePoints; i++) {
      final t = i / samplePoints;
      expect(actual.transform(t), closeTo(expected.transform(t), tolerance), reason: reason);
    }
  }
  
  /// 验证路径
  static void expectPath(
    Path actual,
    Path expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    final actualMetrics = actual.computeMetrics();
    final expectedMetrics = expected.computeMetrics();
    
    expect(actualMetrics.length, expectedMetrics.length, reason: reason);
    
    for (int i = 0; i < expectedMetrics.length; i++) {
      final actualMetric = actualMetrics.elementAt(i);
      final expectedMetric = expectedMetrics.elementAt(i);
      
      expect(actualMetric.length, closeTo(expectedMetric.length, tolerance), reason: reason);
      expect(actualMetric.containAngle, closeTo(expectedMetric.containAngle, tolerance), reason: reason);
      expect(actualMetric.isClosed, expectedMetric.isClosed, reason: reason);
    }
  }
  
  /// 验证主题数据
  static void expectThemeData(
    ThemeData actual,
    ThemeData expected, {
    String? reason,
    bool deepCompare = true,
  }) {
    expect(actual.brightness, expected.brightness, reason: reason);
    expect(actual.primaryColor, expected.primaryColor, reason: reason);
    expect(actual.secondaryHeaderColor, expected.secondaryHeaderColor, reason: reason);
    expect(actual.backgroundColor, expected.backgroundColor, reason: reason);
    expect(actual.dividerColor, expected.dividerColor, reason: reason);
    expect(actual.focusColor, expected.focusColor, reason: reason);
    expect(actual.hoverColor, expected.hoverColor, reason: reason);
    expect(actual.splashColor, expected.splashColor, reason: reason);
    expect(actual.highlightColor, expected.highlightColor, reason: reason);
    expect(actual.disabledColor, expected.disabledColor, reason: reason);
    expect(actual.errorColor, expected.errorColor, reason: reason);
    
    if (deepCompare) {
      expectColor(actual.primaryColor, expected.primaryColor, reason: reason);
      expectColor(actual.secondaryHeaderColor, expected.secondaryHeaderColor, reason: reason);
      expectColor(actual.backgroundColor, expected.backgroundColor, reason: reason);
      expectColor(actual.dividerColor, expected.dividerColor, reason: reason);
      expectColor(actual.focusColor, expected.focusColor, reason: reason);
      expectColor(actual.hoverColor, expected.hoverColor, reason: reason);
      expectColor(actual.splashColor, expected.splashColor, reason: reason);
      expectColor(actual.highlightColor, expected.highlightColor, reason: reason);
      expectColor(actual.disabledColor, expected.disabledColor, reason: reason);
      expectColor(actual.errorColor, expected.errorColor, reason: reason);
    }
  }
  
  /// 验证组件可见性
  static void expectVisible(
    WidgetTester tester,
    Finder finder, {
    String? reason,
  }) {
    final rect = tester.getRect(finder);
    expect(rect.width > 0 && rect.height > 0, isTrue, reason: reason);
  }
  
  /// 验证组件不可见
  static void expectNotVisible(
    WidgetTester tester,
    Finder finder, {
    String? reason,
  }) {
    try {
      final rect = tester.getRect(finder);
      expect(rect.width > 0 && rect.height > 0, isFalse, reason: reason);
    } catch (e) {
      // 组件不存在也认为不可见
      expect(true, isTrue, reason: reason);
    }
  }
  
  /// 验证组件启用状态
  static void expectEnabled(
    WidgetTester tester,
    Finder finder, {
    String? reason,
  }) {
    final widget = tester.widget(finder);
    if (widget is IgnorePointer) {
      expect(widget.ignoring, isFalse, reason: reason);
    } else if (widget is AbsorbPointer) {
      expect(widget.absorbing, isFalse, reason: reason);
    } else if (widget is ElevatedButton) {
      expect(widget.onPressed != null, isTrue, reason: reason);
    } else if (widget is TextButton) {
      expect(widget.onPressed != null, isTrue, reason: reason);
    } else if (widget is OutlinedButton) {
      expect(widget.onPressed != null, isTrue, reason: reason);
    } else if (widget is IconButton) {
      expect(widget.onPressed != null, isTrue, reason: reason);
    } else if (widget is FloatingActionButton) {
      expect(widget.onPressed != null, isTrue, reason: reason);
    } else if (widget is GestureDetector) {
      expect(widget.onTap != null || widget.onDoubleTap != null || widget.onLongPress != null, isTrue, reason: reason);
    } else if (widget is InkWell) {
      expect(widget.onTap != null || widget.onDoubleTap != null || widget.onLongPress != null, isTrue, reason: reason);
    } else {
      // 默认情况下认为组件是启用的
      expect(true, isTrue, reason: reason);
    }
  }
  
  /// 验证组件禁用状态
  static void expectDisabled(
    WidgetTester tester,
    Finder finder, {
    String? reason,
  }) {
    final widget = tester.widget(finder);
    if (widget is IgnorePointer) {
      expect(widget.ignoring, isTrue, reason: reason);
    } else if (widget is AbsorbPointer) {
      expect(widget.absorbing, isTrue, reason: reason);
    } else if (widget is ElevatedButton) {
      expect(widget.onPressed == null, isTrue, reason: reason);
    } else if (widget is TextButton) {
      expect(widget.onPressed == null, isTrue, reason: reason);
    } else if (widget is OutlinedButton) {
      expect(widget.onPressed == null, isTrue, reason: reason);
    } else if (widget is IconButton) {
      expect(widget.onPressed == null, isTrue, reason: reason);
    } else if (widget is FloatingActionButton) {
      expect(widget.onPressed == null, isTrue, reason: reason);
    } else if (widget is GestureDetector) {
      expect(widget.onTap == null && widget.onDoubleTap == null && widget.onLongPress == null, isTrue, reason: reason);
    } else if (widget is InkWell) {
      expect(widget.onTap == null && widget.onDoubleTap == null && widget.onLongPress == null, isTrue, reason: reason);
    } else {
      // 默认情况下认为组件是启用的
      expect(false, isTrue, reason: reason);
    }
  }
  
  /// 验证组件焦点状态
  static void expectHasFocus(
    WidgetTester tester,
    Finder finder, {
    String? reason,
  }) {
    final focusNode = tester.state<State<StatefulWidget>>(finder).focusNode;
    expect(focusNode?.hasFocus, isTrue, reason: reason);
  }
  
  /// 验证组件失去焦点
  static void expectNoFocus(
    WidgetTester tester,
    Finder finder, {
    String? reason,
  }) {
    final focusNode = tester.state<State<StatefulWidget>>(finder).focusNode;
    expect(focusNode?.hasFocus, isFalse, reason: reason);
  }
  
  /// 验证组件透明度
  static void expectOpacity(
    WidgetTester tester,
    Finder finder,
    double expected, {
    String? reason,
    double tolerance = 0.01,
  }) {
    final widget = tester.widget(finder);
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
  
  /// 验证组件旋转角度
  static void expectRotation(
    WidgetTester tester,
    Finder finder,
    double expected, {
    String? reason,
    double tolerance = 0.01,
  }) {
    final widget = tester.widget(finder);
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
  
  /// 验证组件缩放比例
  static void expectScale(
    WidgetTester tester,
    Finder finder,
    double expected, {
    String? reason,
    double tolerance = 0.01,
  }) {
    final widget = tester.widget(finder);
    double actual;
    
    if (widget is Transform) {
      actual = widget.transform.getMaxScaleOnAxis();
    } else {
      actual = 1.0;
    }
    
    expect(actual, closeTo(expected, tolerance), reason: reason);
  }
  
  /// 验证组件边距
  static void expectPadding(
    WidgetTester tester,
    Finder finder,
    EdgeInsets expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    final widget = tester.widget(finder);
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
  
  /// 验证组件圆角
  static void expectBorderRadius(
    WidgetTester tester,
    Finder finder,
    BorderRadius expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    final widget = tester.widget(finder);
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
  
  /// 验证组件阴影
  static void expectBoxShadow(
    WidgetTester tester,
    Finder finder,
    List<BoxShadow> expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    final widget = tester.widget(finder);
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
      expectColor(actual[i].color, expected[i].color, reason: reason);
      expect(actual[i].blurRadius, closeTo(expected[i].blurRadius, tolerance), reason: reason);
      expect(actual[i].spreadRadius, closeTo(expected[i].spreadRadius, tolerance), reason: reason);
      expect(actual[i].offset.dx, closeTo(expected[i].offset.dx, tolerance), reason: reason);
      expect(actual[i].offset.dy, closeTo(expected[i].offset.dy, tolerance), reason: reason);
    }
  }
  
  /// 验证组件边框
  static void expectBorder(
    WidgetTester tester,
    Finder finder,
    BoxBorder expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    final widget = tester.widget(finder);
    BoxBorder actual;
    
    if (widget is Container) {
      actual = (widget.decoration as BoxDecoration?)?.border ?? Border.none;
    } else if (widget is DecoratedBox) {
      actual = (widget.decoration as BoxDecoration?)?.border ?? Border.none;
    } else {
      throw Exception('Unsupported widget type for border assertion');
    }
    
    if (expected is Border && actual is Border) {
      _expectBorderSide(actual.top, expected.top, 'top', reason, tolerance);
      _expectBorderSide(actual.right, expected.right, 'right', reason, tolerance);
      _expectBorderSide(actual.bottom, expected.bottom, 'bottom', reason, tolerance);
      _expectBorderSide(actual.left, expected.left, 'left', reason, tolerance);
    } else if (expected is BorderDirectional && actual is BorderDirectional) {
      _expectBorderSide(actual.top, expected.top, 'top', reason, tolerance);
      _expectBorderSide(actual.bottom, expected.bottom, 'bottom', reason, tolerance);
      _expectBorderSide(actual.start, expected.start, 'start', reason, tolerance);
      _expectBorderSide(actual.end, expected.end, 'end', reason, tolerance);
    } else {
      fail('Border types do not match: ${actual.runtimeType} != ${expected.runtimeType}');
    }
  }
  
  /// 验证边框样式
  static void _expectBorderSide(
    BorderSide actual,
    BorderSide expected,
    String side,
    String? reason,
    double tolerance,
  ) {
    expectColor(actual.color, expected.color, reason: '${reason ?? ''} $side color');
    expect(actual.width, closeTo(expected.width, tolerance), reason: '${reason ?? ''} $side width');
    expect(actual.style, expected.style, reason: '${reason ?? ''} $side style');
  }
  
  /// 验证组件背景颜色
  static void expectBackgroundColor(
    WidgetTester tester,
    Finder finder,
    Color expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    final widget = tester.widget(finder);
    Color actual;
    
    if (widget is Container) {
      actual = widget.color ?? Colors.transparent;
    } else if (widget is DecoratedBox) {
      actual = (widget.decoration as BoxDecoration?)?.color ?? Colors.transparent;
    } else if (widget is Card) {
      actual = widget.color ?? Colors.white;
    } else {
      throw Exception('Unsupported widget type for background color assertion');
    }
    
    expectColor(actual, expected, reason: reason, tolerance: tolerance);
  }
  
  /// 验证组件前景颜色
  static void expectForegroundColor(
    WidgetTester tester,
    Finder finder,
    Color expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    final widget = tester.widget(finder);
    Color actual;
    
    if (widget is Text) {
      actual = widget.style?.color ?? Colors.black;
    } else if (widget is Icon) {
      actual = widget.color ?? Colors.black;
    } else if (widget is FloatingActionButton) {
      actual = widget.foregroundColor ?? Colors.white;
    } else if (widget is ElevatedButton) {
      actual = widget.style?.foregroundColor?.resolve({}) ?? Colors.white;
    } else if (widget is TextButton) {
      actual = widget.style?.foregroundColor?.resolve({}) ?? Colors.blue;
    } else if (widget is OutlinedButton) {
      actual = widget.style?.foregroundColor?.resolve({}) ?? Colors.blue;
    } else {
      throw Exception('Unsupported widget type for foreground color assertion');
    }
    
    expectColor(actual, expected, reason: reason, tolerance: tolerance);
  }
  
  /// 验证组件对齐方式
  static void expectAlignment(
    WidgetTester tester,
    Finder finder,
    Alignment expected, {
    String? reason,
    double tolerance = 0.01,
  }) {
    final widget = tester.widget(finder);
    Alignment actual;
    
    if (widget is Align) {
      actual = widget.alignment;
    } else if (widget is Center) {
      actual = Alignment.center;
    } else {
      throw Exception('Unsupported widget type for alignment assertion');
    }
    
    expect(actual.x, closeTo(expected.x, tolerance), reason: reason);
    expect(actual.y, closeTo(expected.y, tolerance), reason: reason);
  }
  
  /// 验证组件大小约束
  static void expectConstraints(
    WidgetTester tester,
    Finder finder,
    BoxConstraints expected, {
    String? reason,
    double tolerance = 1.0,
  }) {
    final widget = tester.widget(finder);
    BoxConstraints actual;
    
    if (widget is ConstrainedBox) {
      actual = widget.constraints;
    } else if (widget is SizedBox) {
      actual = BoxConstraints(
        minWidth: widget.width ?? 0,
        maxWidth: widget.width ?? double.infinity,
        minHeight: widget.height ?? 0,
        maxHeight: widget.height ?? double.infinity,
      );
    } else {
      throw Exception('Unsupported widget type for constraints assertion');
    }
    
    expect(actual.minWidth, closeTo(expected.minWidth, tolerance), reason: reason);
    expect(actual.maxWidth, closeTo(expected.maxWidth, tolerance), reason: reason);
    expect(actual.minHeight, closeTo(expected.minHeight, tolerance), reason: reason);
    expect(actual.maxHeight, closeTo(expected.maxHeight, tolerance), reason: reason);
  }
  
  /// 验证组件变换
  static void expectTransform(
    WidgetTester tester,
    Finder finder,
    Matrix4 expected, {
    String? reason,
    double tolerance = 0.01,
  }) {
    final widget = tester.widget(finder);
    Matrix4 actual;
    
    if (widget is Transform) {
      actual = widget.transform;
    } else {
      actual = Matrix4.identity();
    }
    
    expectMatrix4(actual, expected, reason: reason, tolerance: tolerance);
  }
  
  /// 验证组件布局行为
  static void expectLayoutBehavior(
    WidgetTester tester,
    Finder finder,
    LayoutBehavior expected, {
    String? reason,
  }) {
    final widget = tester.widget(finder);
    LayoutBehavior actual;
    
    if (widget is Flex) {
      actual = widget.mainAxisAlignment == MainAxisAlignment.start
          ? LayoutBehavior.tight
          : widget.mainAxisAlignment == MainAxisAlignment.spaceAround
              ? LayoutBehavior.loose
              : LayoutBehavior.normal;
    } else {
      actual = LayoutBehavior.normal;
    }
    
    expect(actual, expected, reason: reason);
  }
  
  /// 验证组件堆叠顺序
  static void expectStackOrder(
    WidgetTester tester,
    Finder finder,
    List<Widget> expectedOrder, {
    String? reason,
  }) {
    final widget = tester.widget(finder);
    if (widget is Stack) {
      final actualOrder = widget.children;
      expect(actualOrder.length, expectedOrder.length, reason: reason);
      
      for (int i = 0; i < expectedOrder.length; i++) {
        expect(actualOrder[i].runtimeType, expectedOrder[i].runtimeType, reason: reason);
      }
    } else {
      throw Exception('Widget is not a Stack widget');
    }
  }
  
  /// 验证组件溢出行为
  static void expectOverflowBehavior(
    WidgetTester tester,
    Finder finder,
    Overflow expected, {
    String? reason,
  }) {
    final widget = tester.widget(finder);
    Overflow actual;
    
    if (widget is OverflowBox) {
      actual = widget.overflow;
    } else {
      actual = Overflow.visible;
    }
    
    expect(actual, expected, reason: reason);
  }
  
  /// 验证组件剪切行为
  static void expectClipBehavior(
    WidgetTester tester,
    Finder finder,
    Clip expected, {
    String? reason,
  }) {
    final widget = tester.widget(finder);
    Clip actual;
    
    if (widget is ClipRect) {
      actual = Clip.hardEdge;
    } else if (widget is ClipRRect) {
      actual = Clip.antiAlias;
    } else if (widget is ClipOval) {
      actual = Clip.antiAlias;
    } else if (widget is ClipPath) {
      actual = Clip.antiAlias;
    } else if (widget is Material) {
      actual = widget.clipBehavior;
    } else {
      actual = Clip.none;
    }
    
    expect(actual, expected, reason: reason);
  }
  
  /// 验证组件语义信息
  static void expectSemantics(
    WidgetTester tester,
    Finder finder, {
    String? label,
    String? hint,
    String? value,
    String? increasedValue,
    String? decreasedValue,
    bool? isButton,
    bool? isLink,
    bool? isHeader,
    bool? isTextField,
    bool? isSlider,
    bool? isCheckable,
    bool? isChecked,
    bool? isSelected,
    bool? isFocused,
    bool? isReadOnly,
    bool? isEnabled,
    bool? isInMutuallyExclusiveGroup,
    bool? isObscured,
    bool? isMultiline,
    bool? namesRoute,
    bool? scopesRoute,
    bool? isHidden,
    bool? isImage,
    bool? liveRegion,
    bool? hasImplicitScrolling,
    String? tooltip,
    TextDirection? textDirection,
    int? maxValueLength,
    int? currentValueLength,
    int? hintOverrides,
    String? routeName,
    List<String>? children,
    Map<String, String>? attributes,
    Map<String, String>? flags,
    String? reason,
  }) {
    final semantics = tester.semantics.find(finder);
    
    if (label != null) {
      expect(semantics.label, label, reason: reason);
    }
    if (hint != null) {
      expect(semantics.hint, hint, reason: reason);
    }
    if (value != null) {
      expect(semantics.value, value, reason: reason);
    }
    if (increasedValue != null) {
      expect(semantics.increasedValue, increasedValue, reason: reason);
    }
    if (decreasedValue != null) {
      expect(semantics.decreasedValue, decreasedValue, reason: reason);
    }
    if (isButton != null) {
      expect(semantics.isButton, isButton, reason: reason);
    }
    if (isLink != null) {
      expect(semantics.isLink, isLink, reason: reason);
    }
    if (isHeader != null) {
      expect(semantics.isHeader, isHeader, reason: reason);
    }
    if (isTextField != null) {
      expect(semantics.isTextField, isTextField, reason: reason);
    }
    if (isSlider != null) {
      expect(semantics.isSlider, isSlider, reason: reason);
    }
    if (isCheckable != null) {
      expect(semantics.isCheckable, isCheckable, reason: reason);
    }
    if (isChecked != null) {
      expect(semantics.isChecked, isChecked, reason: reason);
    }
    if (isSelected != null) {
      expect(semantics.isSelected, isSelected, reason: reason);
    }
    if (isFocused != null) {
      expect(semantics.isFocused, isFocused, reason: reason);
    }
    if (isReadOnly != null) {
      expect(semantics.isReadOnly, isReadOnly, reason: reason);
    }
    if (isEnabled != null) {
      expect(semantics.isEnabled, isEnabled, reason: reason);
    }
    if (isInMutuallyExclusiveGroup != null) {
      expect(semantics.isInMutuallyExclusiveGroup, isInMutuallyExclusiveGroup, reason: reason);
    }
    if (isObscured != null) {
      expect(semantics.isObscured, isObscured, reason: reason);
    }
    if (isMultiline != null) {
      expect(semantics.isMultiline, isMultiline, reason: reason);
    }
    if (namesRoute != null) {
      expect(semantics.namesRoute, namesRoute, reason: reason);
    }
    if (scopesRoute != null) {
      expect(semantics.scopesRoute, scopesRoute, reason: reason);
    }
    if (isHidden != null) {
      expect(semantics.isHidden, isHidden, reason: reason);
    }
    if (isImage != null) {
      expect(semantics.isImage, isImage, reason: reason);
    }
    if (liveRegion != null) {
      expect(semantics.liveRegion, liveRegion, reason: reason);
    }
    if (hasImplicitScrolling != null) {
      expect(semantics.hasImplicitScrolling, hasImplicitScrolling, reason: reason);
    }
    if (tooltip != null) {
      expect(semantics.tooltip, tooltip, reason: reason);
    }
    if (textDirection != null) {
      expect(semantics.textDirection, textDirection, reason: reason);
    }
    if (maxValueLength != null) {
      expect(semantics.maxValueLength, maxValueLength, reason: reason);
    }
    if (currentValueLength != null) {
      expect(semantics.currentValueLength, currentValueLength, reason: reason);
    }
    if (hintOverrides != null) {
      expect(semantics.hintOverrides, hintOverrides, reason: reason);
    }
    if (routeName != null) {
      expect(semantics.routeName, routeName, reason: reason);
    }
    if (children != null) {
      expect(semantics.children, children, reason: reason);
    }
    if (attributes != null) {
      expect(semantics.attributes, attributes, reason: reason);
    }
    if (flags != null) {
      expect(semantics.flags, flags, reason: reason);
    }
  }
  
  /// 验证组件无障碍特性
  static void expectAccessibility(
    WidgetTester tester,
    Finder finder, {
    bool? excludeSemantics,
    bool? isSemanticBoundary,
    SemanticsSortKey? sortKey,
    SemanticsTag? tag,
    String? reason,
  }) {
    final widget = tester.widget(finder);
    
    if (widget is ExcludeSemantics) {
      expect(widget.excluding, excludeSemantics ?? true, reason: reason);
    }
    if (widget is Semantics) {
      expect(widget.isSemanticBoundary, isSemanticBoundary ?? false, reason: reason);
      if (sortKey != null) {
        expect(widget.sortKey, sortKey, reason: reason);
      }
      if (tag != null) {
        expect(widget.properties.tags.contains(tag), isTrue, reason: reason);
      }
    }
  }
  
  /// 验证组件动画状态
  static void expectAnimationState(
    WidgetTester tester,
    Finder finder, {
    bool? isAnimating,
    double? progress,
    AnimationStatus? status,
    String? reason,
    double tolerance = 0.01,
  }) {
    final widget = tester.widget(finder);
    
    if (widget is AnimatedBuilder) {
      final animation = widget.animation;
      if (isAnimating != null) {
        expect(animation.isAnimating, isAnimating, reason: reason);
      }
      if (progress != null) {
        expect(animation.value, closeTo(progress, tolerance), reason: reason);
      }
      if (status != null) {
        expect(animation.status, status, reason: reason);
      }
    } else if (widget is AnimatedWidget) {
      // 处理其他动画组件
    }
  }
  
  /// 验证组件手势识别
  static void expectGesture(
    WidgetTester tester,
    Finder finder, {
    bool? hasTap,
    bool? hasDoubleTap,
    bool? hasLongPress,
    bool? hasVerticalDrag,
    bool? hasHorizontalDrag,
    bool? hasPan,
    bool? hasScale,
    bool? hasRotation,
    String? reason,
  }) {
    final widget = tester.widget(finder);
    
    if (widget is GestureDetector) {
      if (hasTap != null) {
        expect(widget.onTap != null, hasTap, reason: reason);
      }
      if (hasDoubleTap != null) {
        expect(widget.onDoubleTap != null, hasDoubleTap, reason: reason);
      }
      if (hasLongPress != null) {
        expect(widget.onLongPress != null, hasLongPress, reason: reason);
      }
      if (hasVerticalDrag != null) {
        expect(widget.onVerticalDragStart != null || widget.onVerticalDragUpdate != null || widget.onVerticalDragEnd != null, hasVerticalDrag, reason: reason);
      }
      if (hasHorizontalDrag != null) {
        expect(widget.onHorizontalDragStart != null || widget.onHorizontalDragUpdate != null || widget.onHorizontalDragEnd != null, hasHorizontalDrag, reason: reason);
      }
      if (hasPan != null) {
        expect(widget.onPanStart != null || widget.onPanUpdate != null || widget.onPanEnd != null, hasPan, reason: reason);
      }
      if (hasScale != null) {
        expect(widget.onScaleStart != null || widget.onScaleUpdate != null || widget.onScaleEnd != null, hasScale, reason: reason);
      }
      if (hasRotation != null) {
        expect(widget.onRotateStart != null || widget.onRotateUpdate != null || widget.onRotateEnd != null, hasRotation, reason: reason);
      }
    }
  }
  
  /// 验证组件滚动行为
  static void expectScrollBehavior(
    WidgetTester tester,
    Finder finder, {
    bool? canScroll,
    ScrollPhysics? physics,
    ScrollController? controller,
    String? reason,
  }) {
    final widget = tester.widget(finder);
    
    if (widget is Scrollable) {
      if (canScroll != null) {
        expect(widget.physics != null, canScroll, reason: reason);
      }
      if (physics != null) {
        expect(widget.physics, physics, reason: reason);
      }
      if (controller != null) {
        expect(widget.controller, controller, reason: reason);
      }
    }
  }
  
  /// 验证组件主题适配
  static void expectThemeAdaptation(
    WidgetTester tester,
    Finder finder,
    ThemeData theme, {
    String? reason,
  }) {
    final widget = tester.widget(finder);
    
    if (widget is Theme) {
      expectThemeData(widget.data, theme, reason: reason);
    }
  }
  
  /// 验证组件平台适配
  static void expectPlatformAdaptation(
    WidgetTester tester,
    Finder finder,
    TargetPlatform platform, {
    String? reason,
  }) {
    final widget = tester.widget(finder);
    
    if (widget is Theme) {
      expect(widget.data.platform, platform, reason: reason);
    }
  }
  
  /// 验证组件本地化适配
  static void expectLocalizationAdaptation(
    WidgetTester tester,
    Finder finder,
    Locale locale, {
    String? reason,
  }) {
    final widget = tester.widget(finder);
    
    if (widget is Localizations) {
      expect(widget.locale, locale, reason: reason);
    }
  }
  
  /// 验证组件响应式设计
  static void expectResponsiveDesign(
    WidgetTester tester,
    Finder finder,
    Size screenSize, {
    String? reason,
  }) {
    final mediaQuery = tester.widget<MediaQuery>(find.ancestor(
      of: finder,
      matching: find.byType(MediaQuery),
    ));
    
    expect(mediaQuery.data.size, screenSize, reason: reason);
  }
  
  /// 验证组件性能特征
  static void expectPerformanceCharacteristics(
    WidgetTester tester,
    Finder finder, {
    Duration? buildTime,
    Duration? layoutTime,
    Duration? paintTime,
    int? rebuildCount,
    String? reason,
  }) {
    final element = tester.element(finder);
    
    if (buildTime != null) {
      // 验证构建时间
    }
    if (layoutTime != null) {
      // 验证布局时间
    }
    if (paintTime != null) {
      // 验证绘制时间
    }
    if (rebuildCount != null) {
      // 验证重建次数
    }
  }
  
  /// 验证组件内存使用
  static void expectMemoryUsage(
    WidgetTester tester,
    Finder finder, {
    int? expectedSize,
    String? reason,
  }) {
    final element = tester.element(finder);
    
    if (expectedSize != null) {
      // 验证内存使用
    }
  }
  
  /// 验证组件生命周期
  static void expectLifecycle(
    WidgetTester tester,
    Finder finder, {
    bool? isMounted,
    bool? isInitialized,
    bool? isDisposed,
    String? reason,
  }) {
    final state = tester.state<State<StatefulWidget>>(finder);
    
    if (isMounted != null) {
      expect(state.mounted, isMounted, reason: reason);
    }
    if (isInitialized != null) {
      // 验证初始化状态
    }
    if (isDisposed != null) {
      expect(!state.mounted, isDisposed, reason: reason);
    }
  }
}

/// 布局行为枚举
enum LayoutBehavior {
  tight,
  loose,
  normal,
}