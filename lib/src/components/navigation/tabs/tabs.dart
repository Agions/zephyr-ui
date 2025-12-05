/// VelocityUI 标签页组件
library velocity_tabs;

import 'package:flutter/material.dart';
import 'tabs_style.dart';

export 'tabs_style.dart';

/// VelocityUI 标签页
class VelocityTabs extends StatefulWidget {
  const VelocityTabs({
    super.key,
    required this.tabs,
    required this.children,
    this.initialIndex = 0,
    this.onChanged,
    this.style,
  });

  final List<String> tabs;
  final List<Widget> children;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final VelocityTabsStyle? style;

  @override
  State<VelocityTabs> createState() => _VelocityTabsState();
}

class _VelocityTabsState extends State<VelocityTabs> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.tabs.length, vsync: this, initialIndex: widget.initialIndex);
    _controller.addListener(() {
      if (!_controller.indexIsChanging) widget.onChanged?.call(_controller.index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocityTabsStyle();
    return Column(
      children: [
        TabBar(
          controller: _controller,
          tabs: widget.tabs.map((t) => Tab(text: t)).toList(),
          labelColor: effectiveStyle.labelColor,
          unselectedLabelColor: effectiveStyle.unselectedLabelColor,
          indicatorColor: effectiveStyle.indicatorColor,
          indicatorWeight: effectiveStyle.indicatorWeight,
          labelStyle: effectiveStyle.labelStyle,
          unselectedLabelStyle: effectiveStyle.unselectedLabelStyle,
        ),
        Expanded(child: TabBarView(controller: _controller, children: widget.children)),
      ],
    );
  }
}
