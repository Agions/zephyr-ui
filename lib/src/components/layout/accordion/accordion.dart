/// ZephyrUI 手风琴组件
///
/// 提供可折叠的内容面板，支持多个面板同时展开或单个面板展开。
library accordion;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 手风琴项目
class ZephyrAccordionItem {
  /// 创建手风琴项目
  const ZephyrAccordionItem({
    required this.title,
    required this.content,
    this.icon,
    this.expandedIcon,
    this.disabled = false,
    this.onExpanded,
    this.onCollapsed,
  });

  /// 标题
  final Widget title;

  /// 内容
  final Widget content;

  /// 图标
  final Widget? icon;

  /// 展开时的图标
  final Widget? expandedIcon;

  /// 是否禁用
  final bool disabled;

  /// 展开回调
  final VoidCallback? onExpanded;

  /// 折叠回调
  final VoidCallback? onCollapsed;
}

/// ZephyrUI 手风琴组件
class ZephyrAccordion extends StatefulWidget {
  /// 创建手风琴组件
  const ZephyrAccordion({
    required this.items,
    super.key,
    this.expandedIndex = 0,
    this.multipleExpansion = false,
    this.theme,
    this.onItemChanged,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.titlePadding,
    this.contentPadding,
    this.separator = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.expandedIcon = const Icon(Icons.expand_less),
    this.collapsedIcon = const Icon(Icons.expand_more),
  });

  /// 手风琴项目列表
  final List<ZephyrAccordionItem> items;

  /// 默认展开的索引
  final int expandedIndex;

  /// 是否允许多个同时展开
  final bool multipleExpansion;

  /// 主题
  final ZephyrAccordionTheme? theme;

  /// 项目变化回调
  final Function(int index, bool expanded)? onItemChanged;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 边框颜色
  final Color? borderColor;

  /// 背景色
  final Color? backgroundColor;

  /// 展开时的背景色
  final Color? expandedBackgroundColor;

  /// 标题内边距
  final EdgeInsets? titlePadding;

  /// 内容内边距
  final EdgeInsets? contentPadding;

  /// 是否显示分隔线
  final bool separator;

  /// 动画持续时间
  final Duration animationDuration;

  /// 展开图标
  final Widget expandedIcon;

  /// 折叠图标
  final Widget collapsedIcon;

  @override
  State<ZephyrAccordion> createState() => _ZephyrAccordionState();
}

class _ZephyrAccordionState extends State<ZephyrAccordion> {
  late List<bool> _expandedStates;

  @override
  void initState() {
    super.initState();
    _expandedStates = List<bool>.filled(widget.items.length, false);
    if (widget.expandedIndex >= 0 &&
        widget.expandedIndex < widget.items.length) {
      _expandedStates[widget.expandedIndex] = true;
    }
  }

  @override
  void didUpdateWidget(ZephyrAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      _expandedStates = List<bool>.filled(widget.items.length, false);
      if (widget.expandedIndex >= 0 &&
          widget.expandedIndex < widget.items.length) {
        _expandedStates[widget.expandedIndex] = true;
      }
    }
  }

  void _toggleItem(int index) {
    if (widget.items[index].disabled) return;

    setState(() {
      final wasExpanded = _expandedStates[index];

      if (widget.multipleExpansion) {
        _expandedStates[index] = !wasExpanded;
      } else {
        _expandedStates = List<bool>.filled(widget.items.length, false);
        _expandedStates[index] = !wasExpanded;
      }

      if (_expandedStates[index]) {
        widget.items[index].onExpanded?.call();
      } else {
        widget.items[index].onCollapsed?.call();
      }

      widget.onItemChanged?.call(index, _expandedStates[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrAccordionTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? theme.borderRadius,
        border: Border.all(
          color: widget.borderColor ?? theme.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: List.generate(widget.items.length, (index) {
          final isExpanded = _expandedStates[index];
          final item = widget.items[index];

          return Column(
            children: [
              _buildItemHeader(context, theme, index, item, isExpanded),
              if (isExpanded) _buildItemContent(context, theme, item),
              if (widget.separator && index < widget.items.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: widget.borderColor ?? theme.borderColor,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildItemHeader(
    BuildContext context,
    ZephyrAccordionTheme theme,
    int index,
    ZephyrAccordionItem item,
    bool isExpanded,
  ) {
    final effectiveTheme = item.disabled ? theme.disabled : theme;

    return InkWell(
      onTap: () => _toggleItem(index),
      borderRadius: widget.borderRadius ?? theme.borderRadius,
      child: Container(
        width: double.infinity,
        padding: widget.titlePadding ?? effectiveTheme.titlePadding,
        decoration: BoxDecoration(
          color: isExpanded
              ? (widget.expandedBackgroundColor ??
                  effectiveTheme.expandedBackgroundColor)
              : (widget.backgroundColor ?? effectiveTheme.backgroundColor),
          borderRadius: widget.borderRadius ?? theme.borderRadius,
        ),
        child: Row(
          children: [
            if (item.icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: item.icon!,
              ),
            Expanded(
              child: DefaultTextStyle(
                style: effectiveTheme.titleStyle,
                child: item.title,
              ),
            ),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0.0,
              duration: widget.animationDuration,
              child: isExpanded
                  ? (item.expandedIcon ?? widget.expandedIcon)
                  : widget.collapsedIcon,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemContent(
    BuildContext context,
    ZephyrAccordionTheme theme,
    ZephyrAccordionItem item,
  ) {
    return Container(
      width: double.infinity,
      padding: widget.contentPadding ?? theme.contentPadding,
      decoration: BoxDecoration(
        color: widget.expandedBackgroundColor ?? theme.expandedBackgroundColor,
        borderRadius: widget.borderRadius ?? theme.borderRadius,
      ),
      child: DefaultTextStyle(
        style: theme.contentStyle,
        child: item.content,
      ),
    );
  }
}
