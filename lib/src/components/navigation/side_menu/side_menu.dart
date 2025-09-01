import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 侧边菜单项配置
class ZephyrSideMenuItem {
  const ZephyrSideMenuItem({
    required this.title,
    this.icon,
    this.onTap,
    this.isActive = false,
    this.badge,
    this.children = const [],
  });

  /// 菜单项标题
  final String title;

  /// 菜单项图标
  final IconData? icon;

  /// 点击回调
  final VoidCallback? onTap;

  /// 是否为激活状态
  final bool isActive;

  /// 徽章
  final Widget? badge;

  /// 子菜单项列表
  final List<ZephyrSideMenuItem> children;

  /// 创建一个新的菜单项，并替换指定字段
  ZephyrSideMenuItem copyWith({
    String? title,
    IconData? icon,
    VoidCallback? onTap,
    bool? isActive,
    Widget? badge,
    List<ZephyrSideMenuItem>? children,
  }) {
    return ZephyrSideMenuItem(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      onTap: onTap ?? this.onTap,
      isActive: isActive ?? this.isActive,
      badge: badge ?? this.badge,
      children: children ?? this.children,
    );
  }
}

/// Zephyr侧边菜单控制器
class ZephyrSideMenuController extends ChangeNotifier {
  ZephyrSideMenuController({
    this.isExpanded = true,
    this.selectedIndex = 0,
  });

  /// 菜单是否展开
  bool isExpanded;

  /// 当前选中的菜单索引
  int selectedIndex;

  /// 切换菜单展开/收起状态
  void toggleExpanded() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  /// 选择指定索引的菜单项
  void selectItem(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }
}

/// Zephyr UI侧边菜单组件
///
/// 一个符合企业应用规范的侧边导航菜单，支持展开/收起、多级菜单等功能。
class ZephyrSideMenu extends StatefulWidget {
  /// 创建一个侧边菜单
  const ZephyrSideMenu({
    Key? key,
    required this.items,
    this.controller,
    this.header,
    this.footer,
    this.theme,
    this.onSelectionChanged,
    this.width,
    this.backgroundColor,
  }) : super(key: key);

  /// 菜单项列表
  final List<ZephyrSideMenuItem> items;

  /// 菜单控制器
  final ZephyrSideMenuController? controller;

  /// 菜单头部
  final Widget? header;

  /// 菜单底部
  final Widget? footer;

  /// 菜单主题
  final ZephyrSideMenuTheme? theme;

  /// 选择变更回调
  final ValueChanged<int>? onSelectionChanged;

  /// 菜单宽度
  final double? width;

  /// 背景色
  final Color? backgroundColor;

  @override
  State<ZephyrSideMenu> createState() => _ZephyrSideMenuState();
}

class _ZephyrSideMenuState extends State<ZephyrSideMenu> {
  late ZephyrSideMenuController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ZephyrSideMenuController();
    _controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(ZephyrSideMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller!.removeListener(_handleControllerChanged);
      }
      _controller = widget.controller ?? ZephyrSideMenuController();
      _controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleControllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ZephyrTheme.of(context);
    final effectiveTheme = ZephyrSideMenuTheme.resolve(
      context,
      widget.theme,
    );

    final double effectiveWidth = widget.width ?? effectiveTheme.width!;
    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? effectiveTheme.backgroundColor!;

    return Container(
      width: effectiveWidth,
      color: effectiveBackgroundColor,
      child: Column(
        children: [
          if (widget.header != null)
            Container(
              color: effectiveTheme.headerBackgroundColor,
              child: widget.header,
            ),
          Expanded(
            child: ListView.builder(
              padding: effectiveTheme.contentPadding,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return _buildMenuItem(
                  context,
                  item,
                  index,
                  effectiveTheme,
                );
              },
            ),
          ),
          if (widget.footer != null)
            Container(
              color: effectiveTheme.footerBackgroundColor,
              child: widget.footer,
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    ZephyrSideMenuItem item,
    int index,
    ZephyrSideMenuTheme theme,
  ) {
    final bool isSelected = _controller.selectedIndex == index;
    final bool isActive = item.isActive || isSelected;

    final TextStyle? textStyle =
        isActive ? theme.activeItemTextStyle : theme.itemTextStyle;

    final Color? iconColor = isActive ? theme.activeIconColor : theme.iconColor;

    final Color? backgroundColor =
        isActive ? theme.activeItemBackgroundColor : null;

    return InkWell(
      onTap: () {
        _controller.selectItem(index);
        if (widget.onSelectionChanged != null) {
          widget.onSelectionChanged!(index);
        }
        if (item.onTap != null) {
          item.onTap!();
        }
      },
      child: Container(
        height: theme.itemHeight,
        margin: EdgeInsets.symmetric(vertical: theme.itemSpacing! / 2),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            if (item.icon != null)
              Icon(
                item.icon,
                color: iconColor,
                size: 20,
              ),
            if (item.icon != null) const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: textStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (item.badge != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: item.badge,
              )
            else
              const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

/// Zephyr侧边菜单布局
///
/// 用于创建带有侧边菜单的页面布局。
class ZephyrSideMenuLayout extends StatefulWidget {
  const ZephyrSideMenuLayout({
    Key? key,
    required this.menu,
    required this.content,
    this.controller,
    this.expandedWidth = 240.0,
    this.collapsedWidth = 72.0,
    this.breakpoint = 600.0,
    this.showMenuButton = true,
  }) : super(key: key);

  /// 侧边菜单
  final ZephyrSideMenu menu;

  /// 主要内容
  final Widget content;

  /// 菜单控制器
  final ZephyrSideMenuController? controller;

  /// 展开状态宽度
  final double expandedWidth;

  /// 收起状态宽度
  final double collapsedWidth;

  /// 响应式断点
  final double breakpoint;

  /// 是否显示菜单按钮
  final bool showMenuButton;

  @override
  State<ZephyrSideMenuLayout> createState() => _ZephyrSideMenuLayoutState();
}

class _ZephyrSideMenuLayoutState extends State<ZephyrSideMenuLayout> {
  late ZephyrSideMenuController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ZephyrSideMenuController();
  }

  @override
  void didUpdateWidget(ZephyrSideMenuLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller &&
        widget.controller != null) {
      _controller = widget.controller!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen =
        MediaQuery.of(context).size.width < widget.breakpoint;

    // 在小屏幕上始终收起菜单
    final bool isExpanded = isSmallScreen ? false : _controller.isExpanded;

    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isExpanded ? widget.expandedWidth : widget.collapsedWidth,
            child: widget.menu,
          ),
          Expanded(
            child: Scaffold(
              appBar: widget.showMenuButton
                  ? AppBar(
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        icon: Icon(
                          isExpanded ? Icons.menu_open : Icons.menu,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.toggleExpanded();
                          });
                        },
                      ),
                    )
                  : null,
              body: widget.content,
            ),
          ),
        ],
      ),
      // 在小屏幕上显示抽屉菜单
      drawer: isSmallScreen
          ? Drawer(
              child: widget.menu,
            )
          : null,
    );
  }
}
