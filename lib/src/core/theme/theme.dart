import 'package:flutter/material.dart';
import 'theme_data.dart';

/// ZephyrUI的主题提供者
///
/// 负责在widget树中分发主题数据，使所有组件能够访问统一的主题设置。
class ZephyrTheme extends InheritedWidget {
  /// 创建一个主题提供者
  const ZephyrTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// 主题数据
  final ZephyrThemeData data;

  /// 从当前上下文获取主题数据
  ///
  /// 如果在widget树中没有找到ZephyrTheme，则返回默认的亮色主题。
  static ZephyrThemeData of(BuildContext context) {
    final ZephyrTheme? theme =
        context.dependOnInheritedWidgetOfExactType<ZephyrTheme>();
    return theme?.data ?? ZephyrThemeData.light();
  }

  @override
  bool updateShouldNotify(ZephyrTheme oldWidget) => data != oldWidget.data;
}
