/// ZephyrUI 布局容器组件
///
/// 提供完整的页面布局系统，包含 Header、Sider、Content、Footer 等组件。
library layout;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/core/extensions/context_extensions.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 布局容器
///
/// 提供完整的页面布局系统，支持响应式设计和主题定制。
///
/// 示例用法:
/// ```dart
/// ZephyrLayout(
///   header: ZephyrHeader(
///     title: '应用标题',
///   ),
///   sider: ZephyrSider(
///     width: 200,
///     child: Text('侧边栏内容'),
///   ),
///   content: ZephyrContent(
///     child: Text('主要内容'),
///   ),
///   footer: ZephyrFooter(
///     child: Text('页脚内容'),
///   ),
/// )
/// ```
class ZephyrLayout extends StatefulWidget {
  /// 创建布局容器
  const ZephyrLayout({
    super.key,
    this.header,
    this.sider,
    this.content,
    this.footer,
    this.theme,
    this.responsive = true,
    this.siderCollapsed = false,
    this.onSiderCollapse,
  });

  /// 页头组件
  final Widget? header;

  /// 侧边栏组件
  final Widget? sider;

  /// 内容区域组件
  final Widget? content;

  /// 页脚组件
  final Widget? footer;

  /// 主题
  final ZephyrLayoutTheme? theme;

  /// 是否启用响应式
  final bool responsive;

  /// 侧边栏是否折叠
  final bool siderCollapsed;

  /// 侧边栏折叠状态变化回调
  final ValueChanged<bool>? onSiderCollapse;

  @override
  State<ZephyrLayout> createState() => _ZephyrLayoutState();
}

class _ZephyrLayoutState extends State<ZephyrLayout> {
  late bool _siderCollapsed;

  @override
  void initState() {
    super.initState();
    _siderCollapsed = widget.siderCollapsed;
  }

  @override
  void didUpdateWidget(ZephyrLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.siderCollapsed != widget.siderCollapsed) {
      _siderCollapsed = widget.siderCollapsed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? ZephyrLayoutTheme.of(context);
    final breakpoint = context.breakpoint;

    // 响应式处理：在小屏幕上自动折叠侧边栏
    var shouldCollapseSider = _siderCollapsed;
    if (widget.responsive &&
        (breakpoint == ZephyrBreakpoint.xs ||
            breakpoint == ZephyrBreakpoint.sm)) {
      shouldCollapseSider = true;
    }

    return Container(
      decoration: effectiveTheme.decoration,
      child: Column(
        children: [
          // Header
          if (widget.header != null) widget.header!,

          // Main content area with sider and content
          Expanded(
            child: Row(
              children: [
                // Sider
                if (widget.sider != null && !shouldCollapseSider) widget.sider!,

                // Content
                if (widget.content != null)
                  Expanded(
                    child: widget.content!,
                  ),
              ],
            ),
          ),

          // Footer
          if (widget.footer != null) widget.footer!,
        ],
      ),
    );
  }
}

/// ZephyrUI 布局主题
class ZephyrLayoutTheme {
  /// 创建布局主题
  const ZephyrLayoutTheme({
    this.backgroundColor,
    this.headerHeight,
    this.footerHeight,
    this.siderWidth,
    this.siderCollapsedWidth,
    this.contentPadding,
    this.decoration,
  });

  /// 背景色
  final Color? backgroundColor;

  /// 页头高度
  final double? headerHeight;

  /// 页脚高度
  final double? footerHeight;

  /// 侧边栏宽度
  final double? siderWidth;

  /// 侧边栏折叠宽度
  final double? siderCollapsedWidth;

  /// 内容区域内边距
  final EdgeInsetsGeometry? contentPadding;

  /// 装饰
  final BoxDecoration? decoration;

  /// 从上下文获取主题
  static ZephyrLayoutTheme of(BuildContext context) {
    final zephyrTheme = ZephyrTheme.of(context);
    return _defaultTheme(zephyrTheme);
  }

  /// 默认主题
  static ZephyrLayoutTheme _defaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    return ZephyrLayoutTheme(
      backgroundColor:
          isDark ? ZephyrColors.neutral900 : ZephyrColors.neutral50,
      headerHeight: 64.0,
      footerHeight: 48.0,
      siderWidth: 200.0,
      siderCollapsedWidth: 64.0,
      contentPadding: const EdgeInsets.all(ZephyrSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? ZephyrColors.neutral900 : ZephyrColors.neutral50,
      ),
    );
  }

  /// 创建主题副本
  ZephyrLayoutTheme copyWith({
    Color? backgroundColor,
    double? headerHeight,
    double? footerHeight,
    double? siderWidth,
    double? siderCollapsedWidth,
    EdgeInsetsGeometry? contentPadding,
    BoxDecoration? decoration,
  }) {
    return ZephyrLayoutTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerHeight: headerHeight ?? this.headerHeight,
      footerHeight: footerHeight ?? this.footerHeight,
      siderWidth: siderWidth ?? this.siderWidth,
      siderCollapsedWidth: siderCollapsedWidth ?? this.siderCollapsedWidth,
      contentPadding: contentPadding ?? this.contentPadding,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrLayoutTheme &&
        other.backgroundColor == backgroundColor &&
        other.headerHeight == headerHeight &&
        other.footerHeight == footerHeight &&
        other.siderWidth == siderWidth &&
        other.siderCollapsedWidth == siderCollapsedWidth &&
        other.contentPadding == contentPadding &&
        other.decoration == decoration;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      headerHeight,
      footerHeight,
      siderWidth,
      siderCollapsedWidth,
      contentPadding,
      decoration,
    );
  }
}
