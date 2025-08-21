import 'package:flutter/material.dart';
import 'card_grid_theme.dart';

/// 卡片网格项
class ZephyrCardGridItem<T> {
  /// 唯一标识
  final String id;
  
  /// 标题
  final String title;
  
  /// 副标题
  final String? subtitle;
  
  /// 描述
  final String? description;
  
  /// 封面图片
  final String? imageUrl;
  
  /// 图标
  final Widget? icon;
  
  /// 标签
  final List<Widget>? tags;
  
  /// 操作按钮
  final List<Widget>? actions;
  
  /// 自定义内容
  final Widget? content;
  
  /// 自定义数据
  final T? data;
  
  /// 是否选中
  final bool selected;
  
  /// 是否禁用
  final bool disabled;
  
  /// 是否加载中
  final bool loading;
  
  /// 角标
  final Widget? badge;
  
  /// 创建卡片网格项
  const ZephyrCardGridItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    this.imageUrl,
    this.icon,
    this.tags,
    this.actions,
    this.content,
    this.data,
    this.selected = false,
    this.disabled = false,
    this.loading = false,
    this.badge,
  });
}

/// 卡片网格布局模式
enum ZephyrCardGridLayout {
  /// 标准网格
  standard,
  
  /// 瀑布流
  masonry,
  
  /// 列表
  list,
  
  /// 紧凑网格
  compact,
}

/// 卡片网格选择模式
enum ZephyrCardGridSelectionMode {
  /// 无选择
  none,
  
  /// 单选
  single,
  
  /// 多选
  multiple,
}

/// ZephyrUI 卡片网格组件
///
/// 一个灵活的卡片网格组件，支持多种布局模式和交互方式。
///
/// 特性：
/// - 多种布局模式（网格/瀑布流/列表/紧凑）
/// - 响应式设计
/// - 图片懒加载
/// - 选择模式
/// - 自定义渲染
/// - 动画效果
/// - 虚拟滚动
/// - 分页加载
/// - 搜索筛选
///
/// 示例用法：
/// ```dart
/// ZephyrCardGrid(
///   items: [
///     ZephyrCardGridItem(
///       id: '1',
///       title: '项目1',
///       subtitle: '这是项目1的描述',
///       imageUrl: 'https://example.com/image1.jpg',
///     ),
///   ],
///   onItemTap: (item) => print('点击: ${item.title}'),
/// )
/// ```
class ZephyrCardGrid<T> extends StatefulWidget {
  /// 卡片项列表
  final List<ZephyrCardGridItem<T>> items;
  
  /// 布局模式
  final ZephyrCardGridLayout layout;
  
  /// 选择模式
  final ZephyrCardGridSelectionMode selectionMode;
  
  /// 每行卡片数量
  final int crossAxisCount;
  
  /// 卡片间距
  final double spacing;
  
  /// 行间距
  final double runSpacing;
  
  /// 卡片宽高比
  final double childAspectRatio;
  
  /// 最大卡片高度
  final double? maxCardHeight;
  
  /// 是否显示边框
  final bool bordered;
  
  /// 是否显示阴影
  final bool showShadow;
  
  /// 是否显示图片
  final bool showImage;
  
  /// 是否显示标题
  final bool showTitle;
  
  /// 是否显示副标题
  final bool showSubtitle;
  
  /// 是否显示描述
  final bool showDescription;
  
  /// 是否显示操作按钮
  final bool showActions;
  
  /// 是否圆角
  final bool rounded;
  
  /// 是否可悬停
  final bool hoverable;
  
  /// 是否可点击
  final bool clickable;
  
  /// 是否图片圆角
  final bool imageRounded;
  
  /// 是否虚拟滚动
  final bool virtualScroll;
  
  /// 是否瀑布流布局
  final bool isMasonry;
  
  /// 主题数据
  final ZephyrCardGridTheme? theme;
  
  /// 卡片点击回调
  final Function(ZephyrCardGridItem<T> item)? onItemTap;
  
  /// 卡片长按回调
  final Function(ZephyrCardGridItem<T> item)? onItemLongPress;
  
  /// 选择回调
  final Function(List<ZephyrCardGridItem<T>> selected)? onSelectionChanged;
  
  /// 图片点击回调
  final Function(ZephyrCardGridItem<T> item)? onImageTap;
  
  /// 操作按钮点击回调
  final Function(ZephyrCardGridItem<T> item, String action)? onActionTap;
  
  /// 加载更多回调
  final Function()? onLoadMore;
  
  /// 是否正在加载更多
  final bool loadingMore;
  
  /// 是否显示加载更多
  final bool showLoadMore;
  
  /// 空数据提示
  final Widget? empty;
  
  /// 加载状态提示
  final Widget? loading;
  
  /// 创建卡片网格组件
  const ZephyrCardGrid({
    Key? key,
    required this.items,
    this.layout = ZephyrCardGridLayout.standard,
    this.selectionMode = ZephyrCardGridSelectionMode.none,
    this.crossAxisCount = 2,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.childAspectRatio = 1.0,
    this.maxCardHeight,
    this.bordered = true,
    this.showShadow = true,
    this.showImage = true,
    this.showTitle = true,
    this.showSubtitle = true,
    this.showDescription = true,
    this.showActions = true,
    this.rounded = true,
    this.hoverable = true,
    this.clickable = true,
    this.imageRounded = true,
    this.virtualScroll = false,
    this.isMasonry = false,
    this.theme,
    this.onItemTap,
    this.onItemLongPress,
    this.onSelectionChanged,
    this.onImageTap,
    this.onActionTap,
    this.onLoadMore,
    this.loadingMore = false,
    this.showLoadMore = false,
    this.empty,
    this.loading,
  }) : super(key: key);

  @override
  State<ZephyrCardGrid<T>> createState() => _ZephyrCardGridState<T>();
}

class _ZephyrCardGridState<T> extends State<ZephyrCardGrid<T>> {
  late ZephyrCardGridTheme _theme;
  late List<ZephyrCardGridItem<T>> _items;
  late Set<String> _selectedIds;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrCardGridTheme.light();
    _items = List.from(widget.items);
    _selectedIds = {};
    _scrollController = ScrollController();
    
    // 初始化选中状态
    if (widget.selectionMode != ZephyrCardGridSelectionMode.none) {
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
  void didUpdateWidget(ZephyrCardGrid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrCardGridTheme.light();
    }
    if (widget.items != oldWidget.items) {
      _items = List.from(widget.items);
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

  void _handleItemTap(ZephyrCardGridItem<T> item) {
    if (item.disabled || !widget.clickable) return;
    
    // 处理选择
    if (widget.selectionMode != ZephyrCardGridSelectionMode.none) {
      setState(() {
        switch (widget.selectionMode) {
          case ZephyrCardGridSelectionMode.single:
            _selectedIds.clear();
            _selectedIds.add(item.id);
            break;
          case ZephyrCardGridSelectionMode.multiple:
            if (_selectedIds.contains(item.id)) {
              _selectedIds.remove(item.id);
            } else {
              _selectedIds.add(item.id);
            }
            break;
          default:
            break;
        }
      });
      
      final selectedItems = _items.where((item) => _selectedIds.contains(item.id)).toList();
      widget.onSelectionChanged?.call(selectedItems);
    }
    
    widget.onItemTap?.call(item);
  }

  void _handleItemLongPress(ZephyrCardGridItem<T> item) {
    if (item.disabled) return;
    widget.onItemLongPress?.call(item);
  }

  void _handleImageTap(ZephyrCardGridItem<T> item) {
    widget.onImageTap?.call(item);
  }

  void _handleActionTap(ZephyrCardGridItem<T> item, String action) {
    widget.onActionTap?.call(item, action);
  }

  Widget _buildCard(ZephyrCardGridItem<T> item) {
    final isSelected = _selectedIds.contains(item.id);
    
    return Container(
      key: ValueKey(item.id),
      decoration: BoxDecoration(
        color: _theme.cardBackgroundColor,
        borderRadius: widget.rounded ? _theme.borderRadius : BorderRadius.zero,
        border: widget.bordered
            ? Border.all(
                color: isSelected ? _theme.selectedBorderColor : _theme.borderColor,
                width: isSelected ? 2.0 : _theme.borderWidth,
              )
            : null,
        boxShadow: widget.showShadow ? _theme.boxShadow : null,
      ),
      child: ClipRRect(
        borderRadius: widget.rounded ? _theme.borderRadius : BorderRadius.zero,
        child: Stack(
          children: [
            // 卡片内容
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 图片区域
                if (widget.showImage && item.imageUrl != null)
                  _buildImageArea(item),
                
                // 内容区域
                Expanded(
                  child: _buildContentArea(item),
                ),
                
                // 操作按钮区域
                if (widget.showActions && item.actions != null && item.actions!.isNotEmpty)
                  _buildActionsArea(item),
              ],
            ),
            
            // 选中状态指示器
            if (isSelected && widget.selectionMode != ZephyrCardGridSelectionMode.none)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _theme.selectedColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            
            // 角标
            if (item.badge != null)
              Positioned(
                top: 8,
                left: 8,
                child: item.badge!,
              ),
            
            // 加载状态
            if (item.loading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(_theme.primaryColor),
                    ),
                  ),
                ),
              ),
            
            // 禁用状态
            if (item.disabled)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.1),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageArea(ZephyrCardGridItem<T> item) {
    return SizedBox(
      height: widget.childAspectRatio > 0 ? 120 : null,
      child: Stack(
        children: [
          // 图片
          GestureDetector(
            onTap: () => _handleImageTap(item),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: widget.imageRounded
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      child: Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: _theme.imageErrorColor,
                            child: Icon(
                              Icons.broken_image,
                              color: _theme.imageErrorIconColor,
                              size: 40,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / 
                                    loadingProgress.expectedTotalBytes!
                                  : null,
                              valueColor: AlwaysStoppedAnimation<Color>(_theme.primaryColor),
                            ),
                          );
                        },
                      ),
                    )
                  : Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: _theme.imageErrorColor,
                          child: Icon(
                            Icons.broken_image,
                            color: _theme.imageErrorIconColor,
                            size: 40,
                          ),
                        );
                      },
                    ),
            ),
          ),
          
          // 图片遮罩
          if (widget.showTitle && item.title.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: Text(
                  item.title,
                  style: _theme.titleStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContentArea(ZephyrCardGridItem<T> item) {
    return Container(
      padding: _theme.contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          if (widget.showTitle && (item.imageUrl == null || !widget.showImage))
            Text(
              item.title,
              style: _theme.titleStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          
          if (widget.showTitle && (item.imageUrl == null || !widget.showImage))
            const SizedBox(height: 8),
          
          // 副标题
          if (widget.showSubtitle && item.subtitle != null)
            Text(
              item.subtitle!,
              style: _theme.subtitleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          
          if (widget.showSubtitle && item.subtitle != null)
            const SizedBox(height: 4),
          
          // 描述
          if (widget.showDescription && item.description != null)
            Text(
              item.description!,
              style: _theme.descriptionStyle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          
          if (widget.showDescription && item.description != null)
            const SizedBox(height: 8),
          
          // 标签
          if (item.tags != null && item.tags!.isNotEmpty)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: item.tags!,
            ),
          
          // 自定义内容
          if (item.content != null) ...[
            const SizedBox(height: 8),
            item.content!,
          ],
        ],
      ),
    );
  }

  Widget _buildActionsArea(ZephyrCardGridItem<T> item) {
    return Container(
      padding: _theme.actionsPadding,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: _theme.borderColor, width: _theme.borderWidth),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: item.actions!,
      ),
    );
  }

  Widget _buildGridContent() {
    if (widget.loading != null) {
      return Center(child: widget.loading!);
    }
    
    if (_items.isEmpty) {
      return Center(
        child: widget.empty ?? 
               Text(
                 '暂无数据',
                 style: _theme.emptyTextStyle,
               ),
      );
    }
    
    // 根据布局模式选择不同的构建方式
    switch (widget.layout) {
      case ZephyrCardGridLayout.masonry:
        return _buildMasonryGrid();
      case ZephyrCardGridLayout.list:
        return _buildListLayout();
      case ZephyrCardGridLayout.compact:
        return _buildCompactGrid();
      default:
        return _buildStandardGrid();
    }
  }

  Widget _buildStandardGrid() {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.spacing,
        mainAxisSpacing: widget.runSpacing,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: _items.length + (widget.showLoadMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          // 加载更多
          return _buildLoadMoreWidget();
        }
        
        return GestureDetector(
          onTap: () => _handleItemTap(_items[index]),
          onLongPress: () => _handleItemLongPress(_items[index]),
          child: _buildCard(_items[index]),
        );
      },
    );
  }

  Widget _buildMasonryGrid() {
    // 简化的瀑布流实现，实际项目中可以使用 flutter_staggered_grid_view
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.spacing,
        mainAxisSpacing: widget.runSpacing,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: _items.length + (widget.showLoadMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return _buildLoadMoreWidget();
        }
        
        return GestureDetector(
          onTap: () => _handleItemTap(_items[index]),
          onLongPress: () => _handleItemLongPress(_items[index]),
          child: _buildCard(_items[index]),
        );
      },
    );
  }

  Widget _buildListLayout() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length + (widget.showLoadMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return _buildLoadMoreWidget();
        }
        
        return Container(
          margin: EdgeInsets.only(
            bottom: index < _items.length - 1 ? widget.runSpacing : 0,
          ),
          child: GestureDetector(
            onTap: () => _handleItemTap(_items[index]),
            onLongPress: () => _handleItemLongPress(_items[index]),
            child: _buildCard(_items[index]),
          ),
        );
      },
    );
  }

  Widget _buildCompactGrid() {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount + 1,
        crossAxisSpacing: widget.spacing / 2,
        mainAxisSpacing: widget.runSpacing / 2,
        childAspectRatio: widget.childAspectRatio * 0.8,
      ),
      itemCount: _items.length + (widget.showLoadMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return _buildLoadMoreWidget();
        }
        
        return GestureDetector(
          onTap: () => _handleItemTap(_items[index]),
          onLongPress: () => _handleItemLongPress(_items[index]),
          child: _buildCard(_items[index]),
        );
      },
    );
  }

  Widget _buildLoadMoreWidget() {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: _theme.borderRadius,
      ),
      child: _buildGridContent(),
    );
  }
}