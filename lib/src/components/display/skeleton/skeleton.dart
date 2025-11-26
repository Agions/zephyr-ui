/// ZephyrUI 骨架屏组件
///
/// 提供加载状态的占位符组件，支持多种形状和动画效果。
library skeleton;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 骨架屏组件
class ZephyrSkeleton extends StatefulWidget {
  /// 创建骨架屏组件
  const ZephyrSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.theme,
    this.loading = true,
    this.child,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.highlightColor,
  });

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 主题
  final ZephyrSkeletonTheme? theme;

  /// 是否处于加载状态
  final bool loading;

  /// 子组件
  final Widget? child;

  /// 动画持续时间
  final Duration animationDuration;

  /// 基础颜色
  final Color? baseColor;

  /// 高亮颜色
  final Color? highlightColor;

  @override
  State<ZephyrSkeleton> createState() => _ZephyrSkeletonState();
}

class _ZephyrSkeletonState extends State<ZephyrSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.loading) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(ZephyrSkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.loading != widget.loading) {
      if (widget.loading) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loading && widget.child != null) {
      return widget.child!;
    }

    final theme = widget.theme ?? ZephyrSkeletonTheme.of(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor ?? theme.baseColor,
                widget.highlightColor ?? theme.highlightColor,
                widget.baseColor ?? theme.baseColor,
              ],
              stops: [
                0.0,
                _animation.value.abs(),
                1.0,
              ],
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.baseColor ?? theme.baseColor,
              borderRadius: widget.borderRadius ?? theme.borderRadius,
            ),
            child: widget.child != null && widget.loading
                ? Opacity(
                    opacity: 0.0,
                    child: widget.child,
                  )
                : null,
          ),
        );
      },
    );
  }
}

/// 骨架屏文本组件
class ZephyrSkeletonText extends StatelessWidget {
  /// 创建骨架屏文本组件
  const ZephyrSkeletonText({
    super.key,
    this.lines = 3,
    this.lineHeight = 16,
    this.spacing = 8,
    this.width,
    this.lastLineWidth,
    this.theme,
    this.loading = true,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  /// 行数
  final int lines;

  /// 行高
  final double lineHeight;

  /// 行间距
  final double spacing;

  /// 宽度
  final double? width;

  /// 最后一行宽度
  final double? lastLineWidth;

  /// 主题
  final ZephyrSkeletonTheme? theme;

  /// 是否处于加载状态
  final bool loading;

  /// 动画持续时间
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(lines, (index) {
        final isLastLine = index == lines - 1;
        final lineWidth = isLastLine && lastLineWidth != null
            ? lastLineWidth!
            : width ?? double.infinity;

        return Padding(
          padding: EdgeInsets.only(
            bottom: isLastLine ? 0 : spacing,
          ),
          child: ZephyrSkeleton(
            width: lineWidth,
            height: lineHeight,
            theme: theme,
            loading: loading,
            animationDuration: animationDuration,
          ),
        );
      }),
    );
  }
}

/// 骨架屏头像组件
class ZephyrSkeletonAvatar extends StatelessWidget {
  /// 创建骨架屏头像组件
  const ZephyrSkeletonAvatar({
    super.key,
    this.size = 40,
    this.shape = BoxShape.circle,
    this.theme,
    this.loading = true,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  /// 大小
  final double size;

  /// 形状
  final BoxShape shape;

  /// 主题
  final ZephyrSkeletonTheme? theme;

  /// 是否处于加载状态
  final bool loading;

  /// 动画持续时间
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return ZephyrSkeleton(
      width: size,
      height: size,
      borderRadius: shape == BoxShape.circle
          ? BorderRadius.circular(size / 2)
          : BorderRadius.circular(8),
      theme: theme,
      loading: loading,
      animationDuration: animationDuration,
    );
  }
}

/// 骨架屏卡片组件
class ZephyrSkeletonCard extends StatelessWidget {
  /// 创建骨架屏卡片组件
  const ZephyrSkeletonCard({
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
    this.theme,
    this.loading = true,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.child,
  });

  /// 内边距
  final EdgeInsets padding;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 主题
  final ZephyrSkeletonTheme? theme;

  /// 是否处于加载状态
  final bool loading;

  /// 动画持续时间
  final Duration animationDuration;

  /// 子组件
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ZephyrSkeleton(
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(8)),
      theme: theme,
      loading: loading,
      animationDuration: animationDuration,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

/// 骨架屏列表组件
class ZephyrSkeletonList extends StatelessWidget {
  /// 创建骨架屏列表组件
  const ZephyrSkeletonList({
    super.key,
    this.itemCount = 5,
    this.itemSpacing = 16,
    this.itemPadding = const EdgeInsets.all(16),
    this.theme,
    this.loading = true,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.itemBuilder,
  });

  /// 项目数量
  final int itemCount;

  /// 项目间距
  final double itemSpacing;

  /// 项目内边距
  final EdgeInsets itemPadding;

  /// 主题
  final ZephyrSkeletonTheme? theme;

  /// 是否处于加载状态
  final bool loading;

  /// 动画持续时间
  final Duration animationDuration;

  /// 项目构建器
  final Widget Function(int index)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == itemCount - 1 ? 0 : itemSpacing,
          ),
          child: ZephyrSkeletonCard(
            padding: itemPadding,
            theme: theme,
            loading: loading,
            animationDuration: animationDuration,
            child: itemBuilder?.call(index) ?? _buildDefaultItem(),
          ),
        );
      }),
    );
  }

  Widget _buildDefaultItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ZephyrSkeletonAvatar(
              size: 40,
              theme: theme,
              loading: loading,
              animationDuration: animationDuration,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZephyrSkeleton(
                    height: 16,
                    width: double.infinity,
                    theme: theme,
                    loading: loading,
                    animationDuration: animationDuration,
                  ),
                  const SizedBox(height: 8),
                  ZephyrSkeleton(
                    height: 12,
                    width: 120,
                    theme: theme,
                    loading: loading,
                    animationDuration: animationDuration,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ZephyrSkeletonText(
          lines: 3,
          lineHeight: 14,
          spacing: 6,
          theme: theme,
          loading: loading,
          animationDuration: animationDuration,
        ),
      ],
    );
  }
}
