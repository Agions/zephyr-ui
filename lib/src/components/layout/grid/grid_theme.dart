import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 网格布局主题配置
class ZephyrGridTheme {
  /// 默认间距
  final double defaultSpacing;

  /// 响应式断点
  final Map<String, double> breakpoints;

  /// 网格列数配置
  final Map<String, int> columnCounts;

  /// 构造函数
  const ZephyrGridTheme({
    this.defaultSpacing = 16.0,
    this.breakpoints = const {
      'xs': 0,
      'sm': 576,
      'md': 768,
      'lg': 992,
      'xl': 1200,
    },
    this.columnCounts = const {
      'xs': 4,
      'sm': 6,
      'md': 8,
      'lg': 10,
      'xl': 12,
    },
  });

  /// 从主题数据创建网格主题
  factory ZephyrGridTheme.fromThemeData(ZephyrThemeData themeData) {
    return ZephyrGridTheme(
      defaultSpacing: themeData.spacing,
    );
  }

  /// 获取当前屏幕尺寸对应的列数
  int getColumnCountForScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= breakpoints['xl']!) return columnCounts['xl']!;
    if (width >= breakpoints['lg']!) return columnCounts['lg']!;
    if (width >= breakpoints['md']!) return columnCounts['md']!;
    if (width >= breakpoints['sm']!) return columnCounts['sm']!;
    return columnCounts['xs']!;
  }

  /// 获取当前屏幕尺寸对应的间距
  double getSpacingForScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= breakpoints['xl']!) return defaultSpacing * 1.5;
    if (width >= breakpoints['lg']!) return defaultSpacing * 1.25;
    if (width >= breakpoints['md']!) return defaultSpacing;
    if (width >= breakpoints['sm']!) return defaultSpacing * 0.75;
    return defaultSpacing * 0.5;
  }
}