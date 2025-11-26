import 'package:flutter/material.dart';
import 'popover_theme.dart';

class ZephyrPopover extends StatefulWidget {
  const ZephyrPopover({
    required this.child,
    required this.content,
    super.key,
    this.title,
    this.actions,
    this.theme,
    this.placement = ZephyrPopoverPlacement.bottom,
    this.trigger = ZephyrPopoverTrigger.click,
    this.width = 300,
    this.arrow = true,
    this.disabled = false,
    this.closeOnClickOutside = true,
    this.closeOnScroll = false,
    this.padding,
    this.borderRadius,
  });

  final Widget child;
  final Widget content;
  final String? title;
  final List<Widget>? actions;
  final ZephyrPopoverTheme? theme;
  final ZephyrPopoverPlacement placement;
  final ZephyrPopoverTrigger trigger;
  final double width;
  final bool arrow;
  final bool disabled;
  final bool closeOnClickOutside;
  final bool closeOnScroll;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  @override
  State<ZephyrPopover> createState() => _ZephyrPopoverState();
}

class _ZephyrPopoverState extends State<ZephyrPopover> {
  bool _isShowing = false;
  final LayerLink _link = LayerLink();

  void _togglePopover() {
    if (widget.disabled) return;

    setState(() {
      _isShowing = !_isShowing;
    });
  }

  void _hidePopover() {
    setState(() {
      _isShowing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = widget.theme ?? ZephyrPopoverTheme.of(context);

    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        onTap: widget.trigger == ZephyrPopoverTrigger.click
            ? _togglePopover
            : null,
        child: MouseRegion(
          onEnter: widget.trigger == ZephyrPopoverTrigger.hover
              ? (_) => _togglePopover()
              : null,
          onExit: widget.trigger == ZephyrPopoverTrigger.hover
              ? (_) => _hidePopover()
              : null,
          child: widget.child,
        ),
      ),
    );
  }
}

class ZephyrPopoverContent extends StatelessWidget {
  const ZephyrPopoverContent({
    required this.child,
    super.key,
    this.title,
    this.actions,
    this.theme,
    this.width = 300,
    this.padding,
    this.borderRadius,
  });

  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final ZephyrPopoverTheme? theme;
  final double width;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final themeData = theme ?? ZephyrPopoverTheme.of(context);
    final effectivePadding = padding ?? themeData.padding;
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(themeData.borderRadius ?? 8);

    return Container(
      width: width,
      constraints: BoxConstraints(
        minHeight: 40,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        color: themeData.backgroundColor,
        borderRadius: effectiveBorderRadius,
        boxShadow: themeData.boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              padding: effectivePadding,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: themeData.borderColor!,
                    width: 1,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title!,
                      style: themeData.titleStyle,
                    ),
                  ),
                ],
              ),
            ),
          Flexible(
            child: SingleChildScrollView(
              padding: effectivePadding,
              child: DefaultTextStyle(
                style: themeData.contentStyle ??
                    Theme.of(context).textTheme.bodyMedium!,
                child: child,
              ),
            ),
          ),
          if (actions != null && actions!.isNotEmpty)
            Container(
              padding: effectivePadding,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: themeData.borderColor!,
                    width: 1,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            ),
        ],
      ),
    );
  }
}

class ZephyrPopoverCard extends StatelessWidget {
  const ZephyrPopoverCard({
    required this.child,
    super.key,
    this.theme,
    this.width = 300,
    this.padding,
    this.borderRadius,
    this.elevation,
  });

  final Widget child;
  final ZephyrPopoverTheme? theme;
  final double width;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final themeData = theme ?? ZephyrPopoverTheme.of(context);
    final effectivePadding = padding ?? themeData.padding;
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(themeData.borderRadius ?? 8);
    final effectiveElevation = elevation ?? themeData.elevation;

    return Card(
      elevation: effectiveElevation,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
      ),
      child: Container(
        width: width,
        padding: effectivePadding,
        child: DefaultTextStyle(
          style:
              themeData.contentStyle ?? Theme.of(context).textTheme.bodyMedium!,
          child: child,
        ),
      ),
    );
  }
}

class ZephyrPopoverList extends StatelessWidget {
  const ZephyrPopoverList({
    required this.items,
    super.key,
    this.theme,
    this.width = 200,
    this.padding,
    this.borderRadius,
  });

  final List<Widget> items;
  final ZephyrPopoverTheme? theme;
  final double width;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final themeData = theme ?? ZephyrPopoverTheme.of(context);
    final effectivePadding = padding ?? EdgeInsets.zero;
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(themeData.borderRadius ?? 8);

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: themeData.backgroundColor,
        borderRadius: effectiveBorderRadius,
        boxShadow: themeData.boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          return Padding(
            padding: effectivePadding,
            child: item,
          );
        }).toList(),
      ),
    );
  }
}

enum ZephyrPopoverPlacement {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  leftTop,
  leftBottom,
  rightTop,
  rightBottom,
}

enum ZephyrPopoverTrigger {
  hover,
  click,
  focus,
  manual,
}
