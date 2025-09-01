/// 测试包装器
///
/// 提供测试组件的包装器和辅助工具
library test_wrappers;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/core/constants/design_tokens.dart';
import 'package:zephyr_ui/src/core/constants/enums.dart';

/// 测试包装器基类
abstract class TestWrapper {
  final Widget child;
  final ThemeMode themeMode;
  final Brightness brightness;
  final Locale? locale;
  final List<LocalizationsDelegate>? localizationsDelegates;
  final List<NavigatorObserver>? navigatorObservers;
  final Size size;
  final double devicePixelRatio;
  final TextScalingFactor textScaleFactor;
  
  const TestWrapper({
    required this.child,
    this.themeMode = ThemeMode.system,
    this.brightness = Brightness.light,
    this.locale,
    this.localizationsDelegates,
    this.navigatorObservers,
    this.size = const Size(800, 600),
    this.devicePixelRatio = 2.0,
    this.textScaleFactor = TextScalingFactor.noScaling,
  });
  
  Widget build();
}

/// 基础测试包装器
class BasicTestWrapper extends TestWrapper {
  const BasicTestWrapper({
    required super.child,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.size,
    super.devicePixelRatio,
    super.textScaleFactor,
  });
  
  @override
  Widget build() {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          devicePixelRatio: devicePixelRatio,
          platformBrightness: brightness,
          textScaleFactor: textScaleFactor.scale,
        ),
        child: Material(
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          child: child,
        ),
      ),
    );
  }
}

/// 主题测试包装器
class ThemeTestWrapper extends TestWrapper {
  final ThemeData? theme;
  final ThemeData? darkTheme;
  
  const ThemeTestWrapper({
    required super.child,
    this.theme,
    this.darkTheme,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.size,
    super.devicePixelRatio,
    super.textScaleFactor,
  });
  
  @override
  Widget build() {
    return MaterialApp(
      theme: theme ?? ThemeData.light(),
      darkTheme: darkTheme ?? ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          devicePixelRatio: devicePixelRatio,
          platformBrightness: brightness,
          textScaleFactor: textScaleFactor.scale,
        ),
        child: Material(
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          child: child,
        ),
      ),
    );
  }
}

/// Scaffold 测试包装器
class ScaffoldTestWrapper extends TestWrapper {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final Widget? persistentFooterButtons;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool? primary;
  
  const ScaffoldTestWrapper({
    required super.child,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.persistentFooterButtons,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.size,
    super.devicePixelRatio,
    super.textScaleFactor,
  });
  
  @override
  Widget build() {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          devicePixelRatio: devicePixelRatio,
          platformBrightness: brightness,
          textScaleFactor: textScaleFactor.scale,
        ),
        child: Scaffold(
          appBar: appBar,
          body: child,
          floatingActionButton: floatingActionButton,
          drawer: drawer,
          endDrawer: endDrawer,
          bottomNavigationBar: bottomNavigationBar,
          persistentFooterButtons: persistentFooterButtons,
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          primary: primary,
        ),
      ),
    );
  }
}

/// 对话框测试包装器
class DialogTestWrapper extends TestWrapper {
  final Widget? dialog;
  final Widget? alertDialog;
  final Widget? bottomSheet;
  final Widget? modalBottomSheet;
  
  const DialogTestWrapper({
    required super.child,
    this.dialog,
    this.alertDialog,
    this.bottomSheet,
    this.modalBottomSheet,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.size,
    super.devicePixelRatio,
    super.textScaleFactor,
  });
  
  @override
  Widget build() {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          devicePixelRatio: devicePixelRatio,
          platformBrightness: brightness,
          textScaleFactor: textScaleFactor.scale,
        ),
        child: Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (dialog != null) {
                showDialog(context: context, builder: (_) => dialog!);
              }
              if (alertDialog != null) {
                showDialog(context: context, builder: (_) => alertDialog!);
              }
              if (bottomSheet != null) {
                Scaffold.of(context).showBottomSheet((_) => bottomSheet!);
              }
              if (modalBottomSheet != null) {
                showModalBottomSheet(context: context, builder: (_) => modalBottomSheet!);
              }
            });
            return Material(
              color: brightness == Brightness.dark ? Colors.black : Colors.white,
              child: child,
            );
          },
        ),
      ),
    );
  }
}

/// 导航测试包装器
class NavigationTestWrapper extends TestWrapper {
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final Route<dynamic>? Function(RouteSettings)? onUnknownRoute;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  
  const NavigationTestWrapper({
    required super.child,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.onGenerateInitialRoutes,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.size,
    super.devicePixelRatio,
    super.textScaleFactor,
  });
  
  @override
  Widget build() {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      routes: routes ?? {'/': (context) => child},
      initialRoute: initialRoute ?? '/',
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
    );
  }
}

/// 滚动测试包装器
class ScrollTestWrapper extends TestWrapper {
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool? reverse;
  final bool? primary;
  final Axis? scrollDirection;
  
  const ScrollTestWrapper({
    required super.child,
    this.controller,
    this.physics,
    this.padding,
    this.reverse,
    this.primary,
    this.scrollDirection,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.size,
    super.devicePixelRatio,
    super.textScaleFactor,
  });
  
  @override
  Widget build() {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          devicePixelRatio: devicePixelRatio,
          platformBrightness: brightness,
          textScaleFactor: textScaleFactor.scale,
        ),
        child: SingleChildScrollView(
          controller: controller,
          physics: physics,
          padding: padding,
          reverse: reverse ?? false,
          primary: primary,
          scrollDirection: scrollDirection ?? Axis.vertical,
          child: Material(
            color: brightness == Brightness.dark ? Colors.black : Colors.white,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// 响应式测试包装器
class ResponsiveTestWrapper extends TestWrapper {
  final List<Size> breakpoints;
  final Widget Function(BuildContext, Size)? responsiveBuilder;
  
  const ResponsiveTestWrapper({
    required super.child,
    this.breakpoints = const [
      Size(320, 568),   // Mobile
      Size(768, 1024),  // Tablet
      Size(1024, 768), // Desktop
      Size(1440, 900), // Large Desktop
    ],
    this.responsiveBuilder,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.devicePixelRatio,
    super.textScaleFactor,
  }) : super(size: breakpoints.first);
  
  @override
  Widget build() {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: LayoutBuilder(
        builder: (context, constraints) {
          final currentSize = constraints.biggest;
          return MediaQuery(
            data: MediaQueryData(
              size: currentSize,
              devicePixelRatio: devicePixelRatio,
              platformBrightness: brightness,
              textScaleFactor: textScaleFactor.scale,
            ),
            child: Material(
              color: brightness == Brightness.dark ? Colors.black : Colors.white,
              child: responsiveBuilder?.call(context, currentSize) ?? child,
            ),
          );
        },
      ),
    );
  }
  
  /// 在不同断点下测试组件
  static Future<void> testBreakpoints(
    WidgetTester tester,
    Widget Function(BuildContext) widgetBuilder, {
    List<Size> breakpoints = const [
      Size(320, 568),   // Mobile
      Size(768, 1024),  // Tablet
      Size(1024, 768), // Desktop
      Size(1440, 900), // Large Desktop
    ],
    required Future<void> Function(WidgetTester, Size) testCallback,
  }) async {
    for (final breakpoint in breakpoints) {
      await tester.pumpWidget(
        ResponsiveTestWrapper(
          breakpoints: [breakpoint],
          child: Builder(
            builder: (context) => widgetBuilder(context),
          ),
        ),
      );
      
      await testCallback(tester, breakpoint);
    }
  }
}

/// 动画测试包装器
class AnimationTestWrapper extends TestWrapper {
  final Duration? duration;
  final Curve? curve;
  final AnimationController? controller;
  final Widget Function(AnimationController)? animationBuilder;
  
  const AnimationTestWrapper({
    required super.child,
    this.duration,
    this.curve,
    this.controller,
    this.animationBuilder,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.size,
    super.devicePixelRatio,
    super.textScaleFactor,
  });
  
  @override
  Widget build() {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          devicePixelRatio: devicePixelRatio,
          platformBrightness: brightness,
          textScaleFactor: textScaleFactor.scale,
        ),
        child: Material(
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          child: animationBuilder != null
              ? AnimatedBuilder(
                  animation: controller ?? AnimationController(
                    vsync: tester,
                    duration: duration ?? const Duration(milliseconds: 300),
                  ),
                  builder: (context, child) {
                    return animationBuilder!(controller ?? AnimationController(
                      vsync: tester,
                      duration: duration ?? const Duration(milliseconds: 300),
                    ));
                  },
                )
              : child,
        ),
      ),
    );
  }
  
  /// 获取测试器
  static WidgetTester get tester {
    throw UnimplementedError('Use WidgetTester from test context');
  }
}

/// 状态管理测试包装器
class StateManagementTestWrapper extends TestWrapper {
  final Widget Function(BuildContext)? stateBuilder;
  final Object? state;
  final Function(Object?)? onStateChanged;
  
  const StateManagementTestWrapper({
    required super.child,
    this.stateBuilder,
    this.state,
    this.onStateChanged,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.size,
    super.devicePixelRatio,
    super.textScaleFactor,
  });
  
  @override
  Widget build() {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          devicePixelRatio: devicePixelRatio,
          platformBrightness: brightness,
          textScaleFactor: textScaleFactor.scale,
        ),
        child: Material(
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          child: stateBuilder?.call(context) ?? child,
        ),
      ),
    );
  }
}

/// 表单测试包装器
class FormTestWrapper extends TestWrapper {
  final GlobalKey<FormState>? formKey;
  final bool autovalidateMode;
  final Widget Function(BuildContext)? formBuilder;
  
  const FormTestWrapper({
    required super.child,
    this.formKey,
    this.autovalidateMode = false,
    this.formBuilder,
    super.themeMode,
    super.brightness,
    super.locale,
    super.localizationsDelegates,
    super.navigatorObservers,
    super.size,
    super.devicePixelRatio,
    super.textScaleFactor,
  });
  
  @override
  Widget build() {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          devicePixelRatio: devicePixelRatio,
          platformBrightness: brightness,
          textScaleFactor: textScaleFactor.scale,
        ),
        child: Material(
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: formBuilder?.call(context) ?? child,
          ),
        ),
      ),
    );
  }
}

/// 测试包装器工厂
class TestWrapperFactory {
  /// 创建基础测试包装器
  static BasicTestWrapper basic({
    required Widget child,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return BasicTestWrapper(
      child: child,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
  
  /// 创建主题测试包装器
  static ThemeTestWrapper themed({
    required Widget child,
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return ThemeTestWrapper(
      child: child,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
  
  /// 创建Scaffold测试包装器
  static ScaffoldTestWrapper scaffold({
    required Widget child,
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? drawer,
    Widget? endDrawer,
    Widget? bottomNavigationBar,
    Widget? persistentFooterButtons,
    Color? backgroundColor,
    bool? resizeToAvoidBottomInset,
    bool? primary,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return ScaffoldTestWrapper(
      child: child,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
      persistentFooterButtons: persistentFooterButtons,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
  
  /// 创建对话框测试包装器
  static DialogTestWrapper dialog({
    required Widget child,
    Widget? dialog,
    Widget? alertDialog,
    Widget? bottomSheet,
    Widget? modalBottomSheet,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return DialogTestWrapper(
      child: child,
      dialog: dialog,
      alertDialog: alertDialog,
      bottomSheet: bottomSheet,
      modalBottomSheet: modalBottomSheet,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
  
  /// 创建导航测试包装器
  static NavigationTestWrapper navigation({
    required Widget child,
    Map<String, WidgetBuilder>? routes,
    String? initialRoute,
    Route<dynamic>? Function(RouteSettings)? onGenerateRoute,
    Route<dynamic>? Function(RouteSettings)? onUnknownRoute,
    List<Route<dynamic>> Function(String)? onGenerateInitialRoutes,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return NavigationTestWrapper(
      child: child,
      routes: routes,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
  
  /// 创建滚动测试包装器
  static ScrollTestWrapper scroll({
    required Widget child,
    ScrollController? controller,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    bool? reverse,
    bool? primary,
    Axis? scrollDirection,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return ScrollTestWrapper(
      child: child,
      controller: controller,
      physics: physics,
      padding: padding,
      reverse: reverse,
      primary: primary,
      scrollDirection: scrollDirection,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
  
  /// 创建响应式测试包装器
  static ResponsiveTestWrapper responsive({
    required Widget child,
    List<Size> breakpoints = const [
      Size(320, 568),   // Mobile
      Size(768, 1024),  // Tablet
      Size(1024, 768), // Desktop
      Size(1440, 900), // Large Desktop
    ],
    Widget Function(BuildContext, Size)? responsiveBuilder,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return ResponsiveTestWrapper(
      child: child,
      breakpoints: breakpoints,
      responsiveBuilder: responsiveBuilder,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
  
  /// 创建动画测试包装器
  static AnimationTestWrapper animation({
    required Widget child,
    Duration? duration,
    Curve? curve,
    AnimationController? controller,
    Widget Function(AnimationController)? animationBuilder,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return AnimationTestWrapper(
      child: child,
      duration: duration,
      curve: curve,
      controller: controller,
      animationBuilder: animationBuilder,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
  
  /// 创建状态管理测试包装器
  static StateManagementTestWrapper stateManagement({
    required Widget child,
    Widget Function(BuildContext)? stateBuilder,
    Object? state,
    Function(Object?)? onStateChanged,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return StateManagementTestWrapper(
      child: child,
      stateBuilder: stateBuilder,
      state: state,
      onStateChanged: onStateChanged,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
  
  /// 创建表单测试包装器
  static FormTestWrapper form({
    required Widget child,
    GlobalKey<FormState>? formKey,
    bool autovalidateMode = false,
    Widget Function(BuildContext)? formBuilder,
    ThemeMode themeMode = ThemeMode.system,
    Brightness brightness = Brightness.light,
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<NavigatorObserver>? navigatorObservers,
    Size size = const Size(800, 600),
    double devicePixelRatio = 2.0,
    TextScalingFactor textScaleFactor = TextScalingFactor.noScaling,
  }) {
    return FormTestWrapper(
      child: child,
      formKey: formKey,
      autovalidateMode: autovalidateMode,
      formBuilder: formBuilder,
      themeMode: themeMode,
      brightness: brightness,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      navigatorObservers: navigatorObservers,
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
    );
  }
}

/// 文本缩放因子枚举
enum TextScalingFactor {
  noScaling(1.0),
  small(0.8),
  medium(1.2),
  large(1.5),
  extraLarge(2.0),
  custom(1.0);
  
  const TextScalingFactor(this.scale);
  
  final double scale;
}