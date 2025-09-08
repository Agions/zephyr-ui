/// chromaUI 分割视图组件
///
/// 提供可调整大小的分割视图，支持水平和垂直分割。
library split_view;

import 'package:flutter/material.dart';
import 'package:chroma_ui/chroma_ui.dart';

/// 分割方向
enum chromaSplitDirection {
  /// 水平分割
  horizontal,

  /// 垂直分割
  vertical,
}

/// chromaUI 分割视图组件
///
/// 提供可调整大小的分割视图，支持水平和垂直分割。
///
/// 示例用法:
/// ```dart
/// chromaSplitView(
///   direction: chromaSplitDirection.horizontal,
///   initialRatio: 0.3,
///   children: [
///     Container(color: Colors.blue, child: Text('左侧面板')),
///     Container(color: Colors.green, child: Text('右侧面板')),
///   ],
/// )
/// ```
class chromaSplitView extends StatefulWidget {
  /// 创建分割视图
  const chromaSplitView({
    Key? key,
    required this.children,
    this.direction = chromaSplitDirection.horizontal,
    this.initialRatio = 0.5,
    this.minRatio = 0.1,
    this.maxRatio = 0.9,
    this.dividerWidth = 4.0,
    this.dividerColor,
    this.dividerHoverColor,
    this.handleSize = 40.0,
    this.handleColor,
    this.theme,
  }) : super(key: key);

  /// 子组件列表（必须包含2个组件）
  final List<Widget> children;

  /// 分割方向
  final chromaSplitDirection direction;

  /// 初始分割比例
  final double initialRatio;

  /// 最小分割比例
  final double minRatio;

  /// 最大分割比例
  final double maxRatio;

  /// 分割条宽度
  final double dividerWidth;

  /// 分割条颜色
  final Color? dividerColor;

  /// 分割条悬停颜色
  final Color? dividerHoverColor;

  /// 手柄大小
  final double handleSize;

  /// 手柄颜色
  final Color? handleColor;

  /// 主题
  final chromaSplitViewTheme? theme;

  @override
  State<chromaSplitView> createState() => _chromaSplitViewState();
}

class _chromaSplitViewState extends State<chromaSplitView> {
  late double _ratio;
  bool _isDragging = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _ratio = widget.initialRatio.clamp(widget.minRatio, widget.maxRatio);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? chromaSplitViewTheme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildSplitView(context, constraints, theme);
      },
    );
  }

  Widget _buildSplitView(BuildContext context, BoxConstraints constraints, chromaSplitViewTheme theme) {
    if (widget.children.length != 2) {
      return const Center(
        child: Text('SplitView requires exactly 2 children'),
      );
    }

    final isHorizontal = widget.direction == chromaSplitDirection.horizontal;
    final totalSize = isHorizontal ? constraints.maxWidth : constraints.maxHeight;
    final dividerSize = widget.dividerWidth;
    final firstSize = (totalSize - dividerSize) * _ratio;
    final secondSize = totalSize - firstSize - dividerSize;

    return isHorizontal
        ? Row(
            children: [
              SizedBox(
                width: firstSize,
                child: widget.children[0],
              ),
              _buildDivider(theme),
              SizedBox(
                width: secondSize,
                child: widget.children[1],
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                height: firstSize,
                child: widget.children[0],
              ),
              _buildDivider(theme),
              SizedBox(
                height: secondSize,
                child: widget.children[1],
              ),
            ],
          );
  }

  Widget _buildDivider(chromaSplitViewTheme theme) {
    final isHorizontal = widget.direction == chromaSplitDirection.horizontal;
    final dividerColor = _isHovering
        ? (widget.dividerHoverColor ?? theme.dividerHoverColor)
        : (widget.dividerColor ?? theme.dividerColor);
    final handleColor = widget.handleColor ?? theme.handleColor;

    return MouseRegion(
      cursor: isHorizontal
          ? SystemMouseCursors.resizeColumn
          : SystemMouseCursors.resizeRow,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onPanStart: (_) => setState(() => _isDragging = true),
        onPanEnd: (_) => setState(() => _isDragging = false),
        onPanUpdate: (details) {
          if (!_isDragging) return;

          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final position = renderBox.localToGlobal(Offset.zero);
          final size = renderBox.size;

          final totalSize = isHorizontal ? size.width : size.height;
          final offset = isHorizontal ? details.globalPosition.dx - position.dx : details.globalPosition.dy - position.dy;

          setState(() {
            _ratio = (offset / totalSize).clamp(widget.minRatio, widget.maxRatio);
          });
        },
        child: Container(
          width: isHorizontal ? widget.dividerWidth : double.infinity,
          height: isHorizontal ? double.infinity : widget.dividerWidth,
          color: dividerColor,
          child: Center(
            child: Container(
              width: isHorizontal ? widget.handleSize : widget.dividerWidth,
              height: isHorizontal ? widget.dividerWidth : widget.handleSize,
              decoration: BoxDecoration(
                color: handleColor,
                borderRadius: BorderRadius.circular(
                  isHorizontal ? widget.dividerWidth / 2 : widget.handleSize / 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 分割视图主题
class chromaSplitViewTheme extends ThemeExtension<chromaSplitViewTheme> {
  const chromaSplitViewTheme({
    this.dividerColor,
    this.dividerHoverColor,
    this.handleColor,
  });

  final Color? dividerColor;
  final Color? dividerHoverColor;
  final Color? handleColor;

  @override
  chromaSplitViewTheme copyWith({
    Color? dividerColor,
    Color? dividerHoverColor,
    Color? handleColor,
  }) {
    return chromaSplitViewTheme(
      dividerColor: dividerColor ?? this.dividerColor,
      dividerHoverColor: dividerHoverColor ?? this.dividerHoverColor,
      handleColor: handleColor ?? this.handleColor,
    );
  }

  @override
  chromaSplitViewTheme lerp(ThemeExtension<chromaSplitViewTheme>? other, double t) {
    if (other is! chromaSplitViewTheme) {
      return this;
    }

    return chromaSplitViewTheme(
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      dividerHoverColor: Color.lerp(dividerHoverColor, other.dividerHoverColor, t),
      handleColor: Color.lerp(handleColor, other.handleColor, t),
    );
  }

  static chromaSplitViewTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<chromaSplitViewTheme>() ?? _fallbackTheme(context);
  }

  static chromaSplitViewTheme _fallbackTheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return chromaSplitViewTheme(
      dividerColor: colorScheme.outline.withValues(alpha: 0.3),
      dividerHoverColor: colorScheme.primary.withValues(alpha: 0.5),
      handleColor: colorScheme.primary,
    );
  }
}
