/// ZephyrUI 侧边栏组件
///
/// 提供可折叠的侧边栏组件，支持响应式设计。
library sider;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 侧边栏
///
/// 可折叠的侧边栏组件，支持响应式设计和主题定制。
///
/// 示例用法:
/// ```dart
/// ZephyrSider(
///   width: 200,
///   child: Column(
///     children: [
///       Text('菜单项1'),
///       Text('菜单项2'),
///     ],
///   ),
/// )
/// ```
class ZephyrSider extends StatefulWidget {
  /// 创建侧边栏
  const ZephyrSider({
    required this.child,
    super.key,
    this.width,
    this.collapsedWidth,
    this.collapsible = true,
    this.collapsed = false,
    this.onCollapse,
    this.theme,
    this.breakpoint,
    this.trigger,
  });

  /// 子组件
  final Widget child;

  /// 宽度
  final double? width;

  /// 折叠宽度
  final double? collapsedWidth;

  /// 是否可折叠
  final bool collapsible;

  /// 是否折叠
  final bool collapsed;

  /// 折叠状态变化回调
  final ValueChanged<bool>? onCollapse;

  /// 主题
  final ZephyrSiderTheme? theme;

  /// 响应式断点
  final ZephyrBreakpoint? breakpoint;

  /// 自定义折叠触发器
  final Widget? trigger;

  @override
  State<ZephyrSider> createState() => _ZephyrSiderState();
}

class _ZephyrSiderState extends State<ZephyrSider> {
  late bool _collapsed;

  @override
  void initState() {
    super.initState();
    _collapsed = widget.collapsed;
  }

  @override
  void didUpdateWidget(ZephyrSider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.collapsed != widget.collapsed) {
      _collapsed = widget.collapsed;
    }
  }

  void _handleCollapse() {
    if (!widget.collapsible) return;

    setState(() {
      _collapsed = !_collapsed;
    });
    widget.onCollapse?.call(_collapsed);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? ZephyrSiderTheme.of(context);
    final effectiveWidth = _collapsed
        ? (widget.collapsedWidth ?? effectiveTheme.collapsedWidth)
        : (widget.width ?? effectiveTheme.width);

    return Container(
      width: effectiveWidth,
      decoration: _buildDecoration(effectiveTheme),
      child: Column(
        children: [
          // 折叠触发器
          if (widget.collapsible) _buildTrigger(effectiveTheme),

          // 主要内容
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }

  /// 构建装饰
  BoxDecoration _buildDecoration(ZephyrSiderTheme theme) {
    return BoxDecoration(
      color: theme.backgroundColor,
      border: theme.border,
      boxShadow: theme.boxShadow,
    );
  }

  /// 构建折叠触发器
  Widget _buildTrigger(ZephyrSiderTheme theme) {
    return Container(
      height: theme.triggerHeight,
      padding: theme.triggerPadding,
      decoration: BoxDecoration(
        color: theme.triggerBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.borderColor!,
            width: 1,
          ),
        ),
      ),
      child: widget.trigger ??
          InkWell(
            onTap: _handleCollapse,
            borderRadius: BorderRadius.circular(ZephyrRadius.sm),
            child: Icon(
              _collapsed ? Icons.chevron_right : Icons.chevron_left,
              color: theme.triggerIconColor,
              size: theme.triggerIconSize,
            ),
          ),
    );
  }
}

/// ZephyrUI 侧边栏主题
class ZephyrSiderTheme {
  /// 创建侧边栏主题
  const ZephyrSiderTheme({
    this.backgroundColor,
    this.width,
    this.collapsedWidth,
    this.border,
    this.boxShadow,
    this.triggerHeight,
    this.triggerPadding,
    this.triggerBackgroundColor,
    this.triggerIconColor,
    this.triggerIconSize,
    this.borderColor,
  });

  /// 背景色
  final Color? backgroundColor;

  /// 宽度
  final double? width;

  /// 折叠宽度
  final double? collapsedWidth;

  /// 边框
  final Border? border;

  /// 阴影
  final List<BoxShadow>? boxShadow;

  /// 触发器高度
  final double? triggerHeight;

  /// 触发器内边距
  final EdgeInsetsGeometry? triggerPadding;

  /// 触发器背景色
  final Color? triggerBackgroundColor;

  /// 触发器图标颜色
  final Color? triggerIconColor;

  /// 触发器图标大小
  final double? triggerIconSize;

  /// 边框颜色
  final Color? borderColor;

  /// 从上下文获取主题
  static ZephyrSiderTheme of(BuildContext context) {
    final zephyrTheme = ZephyrTheme.of(context);
    return _defaultTheme(zephyrTheme);
  }

  /// 默认主题
  static ZephyrSiderTheme _defaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    return ZephyrSiderTheme(
      backgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      width: 200.0,
      collapsedWidth: 64.0,
      border: Border(
        right: BorderSide(
          color: isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral200,
          width: 1,
        ),
      ),
      boxShadow: ZephyrShadows.sm,
      triggerHeight: 48.0,
      triggerPadding: const EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.sm,
      ),
      triggerBackgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      triggerIconColor:
          isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral600,
      triggerIconSize: 20.0,
      borderColor: isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral200,
    );
  }

  /// 创建主题副本
  ZephyrSiderTheme copyWith({
    Color? backgroundColor,
    double? width,
    double? collapsedWidth,
    Border? border,
    List<BoxShadow>? boxShadow,
    double? triggerHeight,
    EdgeInsetsGeometry? triggerPadding,
    Color? triggerBackgroundColor,
    Color? triggerIconColor,
    double? triggerIconSize,
    Color? borderColor,
  }) {
    return ZephyrSiderTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      width: width ?? this.width,
      collapsedWidth: collapsedWidth ?? this.collapsedWidth,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      triggerHeight: triggerHeight ?? this.triggerHeight,
      triggerPadding: triggerPadding ?? this.triggerPadding,
      triggerBackgroundColor:
          triggerBackgroundColor ?? this.triggerBackgroundColor,
      triggerIconColor: triggerIconColor ?? this.triggerIconColor,
      triggerIconSize: triggerIconSize ?? this.triggerIconSize,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrSiderTheme &&
        other.backgroundColor == backgroundColor &&
        other.width == width &&
        other.collapsedWidth == collapsedWidth &&
        other.border == border &&
        other.boxShadow == boxShadow &&
        other.triggerHeight == triggerHeight &&
        other.triggerPadding == triggerPadding &&
        other.triggerBackgroundColor == triggerBackgroundColor &&
        other.triggerIconColor == triggerIconColor &&
        other.triggerIconSize == triggerIconSize &&
        other.borderColor == borderColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      width,
      collapsedWidth,
      border,
      boxShadow,
      triggerHeight,
      triggerPadding,
      triggerBackgroundColor,
      triggerIconColor,
      triggerIconSize,
      borderColor,
    );
  }
}
