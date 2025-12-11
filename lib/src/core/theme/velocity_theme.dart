/// VelocityUI 主题提供者
///
/// 为应用提供主题上下文和主题切换功能。
library velocity_theme;

import 'package:flutter/material.dart';
import 'velocity_theme_data.dart';
import 'velocity_colors.dart';
import 'velocity_typography.dart';

/// VelocityUI 主题
class VelocityTheme extends StatelessWidget {
  const VelocityTheme({
    required this.data,
    required this.child,
    super.key,
  });

  /// 主题数据
  final VelocityThemeData data;

  /// 子组件
  final Widget child;

  /// 从上下文获取主题数据
  static VelocityThemeData of(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedVelocityTheme>();
    return inheritedTheme?.theme.data ?? VelocityThemeData.light();
  }

  /// 尝试从上下文获取主题数据
  static VelocityThemeData? maybeOf(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedVelocityTheme>();
    return inheritedTheme?.theme.data;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedVelocityTheme(
      theme: this,
      child: Theme(
        data: data.toThemeData(),
        child: child,
      ),
    );
  }
}

/// 继承的主题组件
class _InheritedVelocityTheme extends InheritedWidget {
  const _InheritedVelocityTheme({
    required this.theme,
    required super.child,
  });

  final VelocityTheme theme;

  @override
  bool updateShouldNotify(_InheritedVelocityTheme oldWidget) {
    return theme.data != oldWidget.theme.data;
  }
}

/// VelocityUI 主题构建器
class VelocityThemeBuilder extends StatelessWidget {
  const VelocityThemeBuilder({
    required this.builder,
    super.key,
  });

  /// 构建器
  final Widget Function(BuildContext context, VelocityThemeData theme) builder;

  @override
  Widget build(BuildContext context) {
    final theme = VelocityTheme.of(context);
    return builder(context, theme);
  }
}

/// VelocityUI 动态主题提供者
class VelocityDynamicTheme extends StatefulWidget {
  const VelocityDynamicTheme({
    required this.child,
    this.lightTheme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    super.key,
  });

  /// 子组件
  final Widget child;

  /// 亮色主题
  final VelocityThemeData? lightTheme;

  /// 暗色主题
  final VelocityThemeData? darkTheme;

  /// 主题模式
  final ThemeMode themeMode;

  @override
  State<VelocityDynamicTheme> createState() => VelocityDynamicThemeState();

  /// 获取状态
  static VelocityDynamicThemeState of(BuildContext context) {
    final state = context.findAncestorStateOfType<VelocityDynamicThemeState>();
    assert(state != null, 'VelocityDynamicTheme not found in context');
    return state!;
  }

  /// 尝试获取状态
  static VelocityDynamicThemeState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<VelocityDynamicThemeState>();
  }
}

/// VelocityUI 动态主题状态
class VelocityDynamicThemeState extends State<VelocityDynamicTheme> {
  late ThemeMode _themeMode;
  late VelocityThemeData _lightTheme;
  late VelocityThemeData _darkTheme;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
    _lightTheme = widget.lightTheme ?? VelocityThemeData.light();
    _darkTheme = widget.darkTheme ?? VelocityThemeData.dark();
  }

  /// 当前主题模式
  ThemeMode get themeMode => _themeMode;

  /// 亮色主题
  VelocityThemeData get lightTheme => _lightTheme;

  /// 暗色主题
  VelocityThemeData get darkTheme => _darkTheme;

  /// 当前主题
  VelocityThemeData get currentTheme {
    switch (_themeMode) {
      case ThemeMode.light:
        return _lightTheme;
      case ThemeMode.dark:
        return _darkTheme;
      case ThemeMode.system:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark ? _darkTheme : _lightTheme;
    }
  }

  /// 设置主题模式
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      setState(() {
        _themeMode = mode;
      });
    }
  }

  /// 切换主题
  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  /// 设置亮色主题
  void setLightTheme(VelocityThemeData theme) {
    setState(() {
      _lightTheme = theme;
    });
  }

  /// 设置暗色主题
  void setDarkTheme(VelocityThemeData theme) {
    setState(() {
      _darkTheme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VelocityTheme(
      data: currentTheme,
      child: widget.child,
    );
  }
}

/// VelocityUI 主题扩展
extension VelocityThemeExtension on BuildContext {
  /// 获取主题数据
  VelocityThemeData get velocityTheme => VelocityTheme.of(this);

  /// 获取颜色方案
  VelocityColorScheme get velocityColors => velocityTheme.colorScheme;

  /// 获取文本主题
  VelocityTextTheme get velocityTextTheme => velocityTheme.textTheme;

  /// 是否为暗色模式
  bool get isDarkMode => velocityTheme.brightness == Brightness.dark;
}
