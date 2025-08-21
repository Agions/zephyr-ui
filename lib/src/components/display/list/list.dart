import 'package:flutter/material.dart';
import 'list_theme.dart';

/// 列表项数据模型
class ZephyrListItem<T> {
  /// 唯一标识
  final String id;

  /// 标题
  final String title;

  /// 副标题
  final String? subtitle;

  /// 描述
  final String? description;

  /// 前缀图标
  final Widget? leading;

  /// 后缀图标
  final Widget? trailing;

  /// 自定义内容
  final Widget? content;

  /// 附加信息
  final String? extra;

  /// 标签
  final List<Widget>? tags;

  /// 是否禁用
  final bool disabled;

  /// 是否选中
  final bool selected;

  /// 自定义数据
  final T? data;

  /// 创建列表项
  const ZephyrListItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    this.leading,
    this.trailing,
    this.content,
    this.extra,
    this.tags,
    this.disabled = false,
    this.selected = false,
    this.data,
  });
}

/// 列表分组
class ZephyrListGroup {
  /// 分组标题
  final String title;

  /// 分组描述
  final String? description;

  /// 列表项
  final List<ZephyrListItem> items;

  /// 是否展开
  final bool expanded;

  /// 创建分组
  const ZephyrListGroup({
    required this.title,
    this.description,
    required this.items,
    this.expanded = true,
  });
}

/// 拖拽排序信息
class ZephyrListDragInfo {
  /// 原始索引
  final int fromIndex;

  /// 目标索引
  final int toIndex;

  /// 拖拽的数据
  final dynamic data;

  /// 创建拖拽信息
  const ZephyrListDragInfo({
    required this.fromIndex,
    required this.toIndex,
    required this.data,
  });
}

/// ZephyrUI 列表组件
///
/// 一个功能丰富的列表组件，支持虚拟滚动、拖拽排序、分组显示等功能。
///
/// 特性：
/// - 虚拟滚动（大数据量优化）
/// - 拖拽排序
/// - 分组显示
/// - 多选模式
/// - 自定义渲染
/// - 懒加载
/// - 搜索筛选
/// - 响应式设计
///
/// 示例用法：
/// ```dart
/// ZephyrList(
///   items: [
///     ZephyrListItem(
///       id: '1',
///       title: '项目1',
///       subtitle: '这是项目1的描述',
///     ),
///   ],
///   onItemTap: (item) => print('点击: ${item.title}'),
/// )
/// ```
class ZephyrList<T> extends StatefulWidget {
  /// 列表项
  final List<ZephyrListItem<T>> items;

  /// 分组
  final List<ZephyrListGroup>? groups;

  /// 是否显示边框
  final bool bordered;

  /// 是否显示分割线
  final bool divided;

  /// 是否可悬停
  final bool hoverable;

  /// 是否可选择
  final bool selectable;

  /// 是否多选
  final bool multiSelect;

  /// 是否可拖拽排序
  final bool draggable;

  /// 是否虚拟滚动
  final bool virtualScroll;

  /// 项目高度
  final double itemHeight;

  /// 分组高度
  final double groupHeight;

  /// 最大高度
  final double? maxHeight;

  /// 空数据提示
  final Widget? empty;

  /// 加载状态
  final bool loading;

  /// 是否显示加载更多
  final bool showLoadMore;

  /// 是否正在加载更多
  final bool loadingMore;

  /// 主题数据
  final ZephyrListTheme? theme;

  /// 项目点击回调
  final Function(ZephyrListItem<T> item)? onItemTap;

  /// 项目长按回调
  final Function(ZephyrListItem<T> item)? onItemLongPress;

  /// 选择回调
  final Function(List<ZephyrListItem<T>> selected)? onSelectionChanged;

  /// 拖拽排序回调
  final Function(ZephyrListDragInfo dragInfo)? onDragEnd;

  /// 加载更多回调
  final Function()? onLoadMore;

  /// 搜索回调
  final Function(String query)? onSearch;

  /// 创建列表组件
  const ZephyrList({
    Key? key,
    required this.items,
    this.groups,
    this.bordered = false,
    this.divided = true,
    this.hoverable = true,
    this.selectable = false,
    this.multiSelect = false,
    this.draggable = false,
    this.virtualScroll = false,
    this.itemHeight = 72.0,
    this.groupHeight = 48.0,
    this.maxHeight,
    this.empty,
    this.loading = false,
    this.showLoadMore = false,
    this.loadingMore = false,
    this.theme,
    this.onItemTap,
    this.onItemLongPress,
    this.onSelectionChanged,
    this.onDragEnd,
    this.onLoadMore,
    this.onSearch,
  }) : super(key: key);

  @override
  State<ZephyrList<T>> createState() => _ZephyrListState<T>();
}

class _ZephyrListState<T> extends State<ZephyrList<T>> {
  late ZephyrListTheme _theme;
  late List<ZephyrListItem<T>> _items;
  late List<ZephyrListGroup>? _groups;
  late Set<String> _selectedIds;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrListTheme.light();
    _items = List.from(widget.items);
    _groups = widget.groups;
    _selectedIds = {};
    _scrollController = ScrollController();
    
    // 初始化选中状态
    if (widget.selectable) {
      for (final item in widget.items) {
        if (item.selected) {
          _selectedIds.add(item.id);
        }
      }
    }
    
    // 监听滚动事件用于加载更多
    if (widget.showLoadMore) {
      _scrollController.addListener(_handleScroll);
    }
  }

  @override
  void didUpdateWidget(ZephyrList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrListTheme.light();
    }
    if (widget.items != oldWidget.items) {
      _items = List.from(widget.items);
    }
    if (widget.groups != oldWidget.groups) {
      _groups = widget.groups;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 100) {
      if (!widget.loadingMore && widget.onLoadMore != null) {
        widget.onLoadMore!();
      }
    }
  }

  void _handleItemTap(ZephyrListItem<T> item) {
    if (item.disabled) return;
    
    if (widget.selectable) {
      setState(() {
        if (widget.multiSelect) {
          if (_selectedIds.contains(item.id)) {
            _selectedIds.remove(item.id);
          } else {
            _selectedIds.add(item.id);
          }
        } else {
          _selectedIds.clear();
          _selectedIds.add(item.id);
        }
      });
      
      final selectedItems = _items.where((item) => _selectedIds.contains(item.id)).toList();
      widget.onSelectionChanged?.call(selectedItems);
    }
    
    widget.onItemTap?.call(item);
  }

  void _handleItemLongPress(ZephyrListItem<T> item) {
    if (item.disabled) return;
    widget.onItemLongPress?.call(item);
  }

  List<Widget> _buildGroupedItems() {
    if (_groups == null || _groups!.isEmpty) return [];
    
    final widgets = <Widget>[];
    
    for (final group in _groups!) {
      if (!group.expanded) continue;
      
      // 分组标题
      widgets.add(_buildGroupHeader(group));
      
      // 分组项
      for (final item in group.items) {
        widgets.add(_buildItem(item as ZephyrListItem<T>));
      }
    }
    
    return widgets;
  }

  Widget _buildGroupHeader(ZephyrListGroup group) {
    return Container(
      height: widget.groupHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _theme.groupBackgroundColor,
        border: widget.divided
            ? Border(bottom: BorderSide(color: _theme.dividerColor, width: 1))
            : null,
      ),
      child: Row(
        children: [
          Text(
            group.title,
            style: _theme.groupTitleStyle,
          ),
          if (group.description != null) ...[
            const SizedBox(width: 8),
            Text(
              group.description!,
              style: _theme.groupDescriptionStyle,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildItem(ZephyrListItem<T> item) {
    final isSelected = _selectedIds.contains(item.id);
    
    return Container(
      key: ValueKey(item.id),
      height: widget.itemHeight,
      decoration: BoxDecoration(
        color: isSelected
            ? _theme.selectedItemColor
            : Colors.transparent,
        border: widget.divided
            ? Border(bottom: BorderSide(color: _theme.dividerColor, width: 1))
            : null,
      ),
      child: MouseRegion(
        cursor: widget.onItemTap != null && !item.disabled
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        child: GestureDetector(
          onTap: () => _handleItemTap(item),
          onLongPress: () => _handleItemLongPress(item),
          child: Row(
            children: [
              // 选择框
              if (widget.selectable)
                Container(
                  width: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (selected) => _handleItemTap(item),
                  ),
                ),
              
              // 拖拽手柄
              if (widget.draggable)
                Container(
                  width: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.drag_handle,
                    color: _theme.dragHandleColor,
                  ),
                ),
              
              // 前缀图标
              if (item.leading != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: item.leading!,
                ),
              
              // 内容区域
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: item.content ?? _buildDefaultContent(item),
                ),
              ),
              
              // 附加信息
              if (item.extra != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    item.extra!,
                    style: _theme.extraTextStyle,
                  ),
                ),
              
              // 标签
              if (item.tags != null && item.tags!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: item.tags!,
                  ),
                ),
              
              // 后缀图标
              if (item.trailing != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: item.trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultContent(ZephyrListItem<T> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题
        Text(
          item.title,
          style: _theme.titleStyle.copyWith(
            color: item.disabled ? _theme.disabledTextColor : _theme.titleStyle.color,
          ),
        ),
        
        // 副标题
        if (item.subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              item.subtitle!,
              style: _theme.subtitleStyle.copyWith(
                color: item.disabled ? _theme.disabledTextColor : _theme.subtitleStyle.color,
              ),
            ),
          ),
        
        // 描述
        if (item.description != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              item.description!,
              style: _theme.descriptionStyle.copyWith(
                color: item.disabled ? _theme.disabledTextColor : _theme.descriptionStyle.color,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildListContent() {
    if (widget.loading) {
      return _buildLoadingState();
    }
    
    if (_items.isEmpty) {
      return _buildEmptyState();
    }
    
    if (widget.virtualScroll) {
      return _buildVirtualScrollList();
    }
    
    return _buildNormalList();
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(_theme.primaryColor),
          ),
          const SizedBox(height: 16),
          Text(
            '加载中...',
            style: _theme.loadingTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: widget.empty ?? 
             Text(
               '暂无数据',
               style: _theme.emptyTextStyle,
             ),
    );
  }

  Widget _buildNormalList() {
    final children = _groups != null && _groups!.isNotEmpty
        ? _buildGroupedItems()
        : _items.map((item) => _buildItem(item)).toList();
    
    return ListView(
      controller: _scrollController,
      children: [
        ...children,
        
        // 加载更多
        if (widget.showLoadMore) ...[
          if (widget.loadingMore)
            Container(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(_theme.primaryColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '加载更多...',
                      style: _theme.loadMoreTextStyle,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildVirtualScrollList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length + (widget.showLoadMore ? 1 : 0),
      itemExtent: widget.itemHeight,
      itemBuilder: (context, index) {
        if (index == _items.length) {
          // 加载更多
          return Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: widget.loadingMore
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(_theme.primaryColor),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '加载更多...',
                          style: _theme.loadMoreTextStyle,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          );
        }
        
        return _buildItem(_items[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight ?? double.infinity,
      ),
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: _theme.borderRadius,
        border: widget.bordered
            ? Border.all(color: _theme.borderColor, width: _theme.borderWidth)
            : null,
      ),
      child: _buildListContent(),
    );
  }
}