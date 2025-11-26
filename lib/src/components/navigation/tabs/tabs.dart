import 'package:flutter/material.dart';
import 'tabs_theme.dart';

/// 标签页数据项
class ZephyrTabItem {
  /// 创建标签页项
  const ZephyrTabItem({
    required this.label,
    required this.content,
    this.icon,
    this.badge,
    this.enabled = true,
  });

  /// 标签文本
  final String label;

  /// 标签内容
  final Widget content;

  /// 标签图标
  final Widget? icon;

  /// 标签徽章
  final Widget? badge;

  /// 是否启用
  final bool enabled;
}

/// 标签页类型
enum ZephyrTabsType {
  /// 线条型（底部指示器）
  line,

  /// 卡片型（背景色区分）
  card,

  /// 按钮型（圆角背景）
  button,
}

/// ZephyrUI 标签页组件
///
/// 一个功能丰富的标签页组件，支持多种样式和交互模式。
///
/// 示例用法:
/// ```dart
/// ZephyrTabs(
///   tabs: [
///     ZephyrTabItem(
///       label: '首页',
///       icon: Icon(Icons.home),
///       content: Text('首页内容'),
///     ),
///     ZephyrTabItem(
///       label: '设置',
///       icon: Icon(Icons.settings),
///       content: Text('设置内容'),
///     ),
///   ],
/// )
/// ```
class ZephyrTabs extends StatefulWidget {
  /// 创建一个标签页组件
  const ZephyrTabs({
    required this.tabs,
    super.key,
    this.initialIndex = 0,
    this.type = ZephyrTabsType.line,
    this.scrollable = false,
    this.onTabChanged,
    this.theme,
  });

  /// 标签页列表
  final List<ZephyrTabItem> tabs;

  /// 初始选中索引
  final int initialIndex;

  /// 标签页类型
  final ZephyrTabsType type;

  /// 是否可滚动
  final bool scrollable;

  /// 标签页变更回调
  final ValueChanged<int>? onTabChanged;

  /// 自定义主题
  final ZephyrTabsTheme? theme;

  @override
  State<ZephyrTabs> createState() => _ZephyrTabsState();
}

class _ZephyrTabsState extends State<ZephyrTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _tabController = TabController(
      length: widget.tabs.length,
      initialIndex: widget.initialIndex,
      vsync: this,
    );
    _tabController.addListener(_handleTabChanged);
  }

  @override
  void didUpdateWidget(ZephyrTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: widget.tabs.length,
        initialIndex: widget.initialIndex.clamp(0, widget.tabs.length - 1),
        vsync: this,
      );
      _tabController.addListener(_handleTabChanged);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChanged() {
    if (_tabController.indexIsChanging) return;

    final newIndex = _tabController.index;
    if (_currentIndex != newIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
      widget.onTabChanged?.call(newIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrTabsTheme.of(context);

    return Column(
      children: [
        _buildTabBar(theme),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabs.map((tab) => tab.content).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(ZephyrTabsTheme theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.borderColor,
            width: 1.0,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: widget.scrollable,
        indicatorColor: widget.type == ZephyrTabsType.line
            ? theme.indicatorColor
            : Colors.transparent,
        indicatorWeight: theme.indicatorHeight,
        labelColor: theme.selectedTextStyle.color,
        unselectedLabelColor: theme.unselectedTextStyle.color,
        labelStyle: theme.selectedTextStyle,
        unselectedLabelStyle: theme.unselectedTextStyle,
        labelPadding: widget.scrollable
            ? EdgeInsets.symmetric(horizontal: theme.spacing)
            : EdgeInsets.zero,
        tabs: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          return _buildTab(theme, tab, index);
        }).toList(),
      ),
    );
  }

  Widget _buildTab(ZephyrTabsTheme theme, ZephyrTabItem tab, int index) {
    final isSelected = _currentIndex == index;
    final isEnabled = tab.enabled;

    Widget tabContent = Container(
      height: theme.tabHeight,
      padding: theme.tabPadding,
      decoration: _getTabDecoration(theme, isSelected, isEnabled),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (tab.icon != null) ...[
            tab.icon!,
            SizedBox(width: theme.spacing),
          ],
          Flexible(
            child: Text(
              tab.label,
              style: _getTabTextStyle(theme, isSelected, isEnabled),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (tab.badge != null) ...[
            SizedBox(width: theme.spacing),
            tab.badge!,
          ],
        ],
      ),
    );

    if (!isEnabled) {
      tabContent = Opacity(
        opacity: 0.5,
        child: tabContent,
      );
    }

    return Tab(child: tabContent);
  }

  BoxDecoration? _getTabDecoration(
      ZephyrTabsTheme theme, bool isSelected, bool isEnabled) {
    if (!isEnabled) {
      return BoxDecoration(
        color: theme.disabledTabColor,
        borderRadius:
            widget.type == ZephyrTabsType.button ? theme.borderRadius : null,
      );
    }

    switch (widget.type) {
      case ZephyrTabsType.line:
        return null;
      case ZephyrTabsType.card:
        return BoxDecoration(
          color: isSelected ? theme.selectedTabColor : theme.unselectedTabColor,
        );
      case ZephyrTabsType.button:
        return BoxDecoration(
          color: isSelected ? theme.selectedTabColor : theme.unselectedTabColor,
          borderRadius: theme.borderRadius,
        );
    }
  }

  TextStyle _getTabTextStyle(
      ZephyrTabsTheme theme, bool isSelected, bool isEnabled) {
    if (!isEnabled) {
      return theme.disabledTextStyle;
    }

    return isSelected ? theme.selectedTextStyle : theme.unselectedTextStyle;
  }
}

/// 简化的标签页组件，只显示标签栏
class ZephyrTabBar extends StatefulWidget {
  /// 创建一个标签栏组件
  const ZephyrTabBar({
    required this.tabs,
    super.key,
    this.initialIndex = 0,
    this.type = ZephyrTabsType.line,
    this.scrollable = false,
    this.onTabChanged,
    this.theme,
  });

  /// 标签页列表
  final List<ZephyrTabItem> tabs;

  /// 初始选中索引
  final int initialIndex;

  /// 标签页类型
  final ZephyrTabsType type;

  /// 是否可滚动
  final bool scrollable;

  /// 标签页变更回调
  final ValueChanged<int>? onTabChanged;

  /// 自定义主题
  final ZephyrTabsTheme? theme;

  @override
  State<ZephyrTabBar> createState() => _ZephyrTabBarState();
}

class _ZephyrTabBarState extends State<ZephyrTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _tabController = TabController(
      length: widget.tabs.length,
      initialIndex: widget.initialIndex,
      vsync: this,
    );
    _tabController.addListener(_handleTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChanged() {
    if (_tabController.indexIsChanging) return;

    final newIndex = _tabController.index;
    if (_currentIndex != newIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
      widget.onTabChanged?.call(newIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrTabsTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.borderColor,
            width: 1.0,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: widget.scrollable,
        indicatorColor: widget.type == ZephyrTabsType.line
            ? theme.indicatorColor
            : Colors.transparent,
        indicatorWeight: theme.indicatorHeight,
        labelColor: theme.selectedTextStyle.color,
        unselectedLabelColor: theme.unselectedTextStyle.color,
        labelStyle: theme.selectedTextStyle,
        unselectedLabelStyle: theme.unselectedTextStyle,
        tabs: widget.tabs.map((tab) => Tab(text: tab.label)).toList(),
      ),
    );
  }
}
