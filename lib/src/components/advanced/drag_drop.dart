import 'package:flutter/material.dart';

class ZDraggableList<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item, int index) itemBuilder;
  final void Function(List<T> newList)? onReorder;
  final Widget? header;
  final Widget? footer;
  final bool useLongPress;
  final Color? dragHandleColor;
  final double? itemHeight;

  const ZDraggableList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onReorder,
    this.header,
    this.footer,
    this.useLongPress = false,
    this.dragHandleColor,
    this.itemHeight,
  });

  @override
  State<ZDraggableList<T>> createState() => _ZDraggableListState<T>();
}

class _ZDraggableListState<T> extends State<ZDraggableList<T>> {
  late List<T> _items;
  int? _draggingIndex;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  void didUpdateWidget(ZDraggableList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _items = List.from(widget.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.header != null) widget.header!,
        Expanded(
          child: ReorderableListView(
            buildDefaultDragHandles: !widget.useLongPress,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              });
              
              widget.onReorder?.call(_items);
            },
            children: _items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              
              return _buildDraggableItem(
                key: ValueKey(item),
                item: item,
                index: index,
              );
            }).toList(),
          ),
        ),
        if (widget.footer != null) widget.footer!,
      ],
    );
  }

  Widget _buildDraggableItem({
    required Key key,
    required T item,
    required int index,
  }) {
    return Card(
      key: key,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: widget.useLongPress
          ? LongPressDraggable(
              data: index,
              feedback: Material(
                child: _buildItemContent(item, index, true),
                elevation: 4,
              ),
              childWhenDragging: Opacity(
                opacity: 0.5,
                child: _buildItemContent(item, index, false),
              ),
              child: _buildItemContent(item, index, false),
            )
          : _buildItemContent(item, index, false),
    );
  }

  Widget _buildItemContent(T item, int index, bool isDragging) {
    return Container(
      height: widget.itemHeight ?? 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (!widget.useLongPress)
            ReorderableDragStartListener(
              index: index,
              child: Container(
                width: 24,
                height: 24,
                child: Icon(
                  Icons.drag_handle,
                  color: widget.dragHandleColor ?? Colors.grey[600],
                ),
              ),
            ),
          if (!widget.useLongPress) const SizedBox(width: 16),
          Expanded(
            child: widget.itemBuilder(item, index),
          ),
        ],
      ),
    );
  }
}

class ZSortableGrid<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item, int index) itemBuilder;
  final void Function(List<T> newList)? onReorder;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final Widget? header;
  final Widget? footer;
  final bool useLongPress;

  const ZSortableGrid({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onReorder,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.childAspectRatio = 1.0,
    this.header,
    this.footer,
    this.useLongPress = false,
  });

  @override
  State<ZSortableGrid<T>> createState() => _ZSortableGridState<T>();
}

class _ZSortableGridState<T> extends State<ZSortableGrid<T>> {
  late List<T> _items;
  int? _draggingIndex;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  void didUpdateWidget(ZSortableGrid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _items = List.from(widget.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.header != null) widget.header!,
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              mainAxisSpacing: widget.mainAxisSpacing,
              crossAxisSpacing: widget.crossAxisSpacing,
              childAspectRatio: widget.childAspectRatio,
            ),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return _buildDraggableGridItem(
                item: _items[index],
                index: index,
              );
            },
          ),
        ),
        if (widget.footer != null) widget.footer!,
      ],
    );
  }

  Widget _buildDraggableGridItem({
    required T item,
    required int index,
  }) {
    return LongPressDraggable(
      data: index,
      feedback: Material(
        child: _buildGridItemContent(item, index, true),
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildGridItemContent(item, index, false),
      ),
      onDragEnd: (details) {
        _handleDrop(details, index);
      },
      child: DragTarget<int>(
        onWillAccept: (data) => data != index,
        onAccept: (data) {
          _handleReorder(data, index);
        },
        builder: (context, candidateData, rejectedData) {
          return _buildGridItemContent(item, index, false);
        },
      ),
    );
  }

  Widget _buildGridItemContent(T item, int index, bool isDragging) {
    return Card(
      elevation: isDragging ? 8 : 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: widget.itemBuilder(item, index),
      ),
    );
  }

  void _handleDrop(DraggableDetails details, int fromIndex) {
    // 处理拖拽结束逻辑
  }

  void _handleReorder(int fromIndex, int toIndex) {
    setState(() {
      final item = _items.removeAt(fromIndex);
      _items.insert(toIndex, item);
    });
    
    widget.onReorder?.call(_items);
  }
}

class ZKanbanBoard extends StatefulWidget {
  final List<KanbanColumn> columns;
  final Widget Function(KanbanItem item) itemBuilder;
  final void Function(KanbanItem item, String fromColumn, String toColumn)? onItemMove;
  final void Function(KanbanItem item)? onItemTap;
  final Color? columnColor;
  final double? columnWidth;

  const ZKanbanBoard({
    super.key,
    required this.columns,
    required this.itemBuilder,
    this.onItemMove,
    this.onItemTap,
    this.columnColor,
    this.columnWidth,
  });

  @override
  State<ZKanbanBoard> createState() => _ZKanbanBoardState();
}

class _ZKanbanBoardState extends State<ZKanbanBoard> {
  late List<KanbanColumn> _columns;

  @override
  void initState() {
    super.initState();
    _columns = widget.columns.map((column) => KanbanColumn(
      id: column.id,
      title: column.title,
      items: List.from(column.items),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Row(
        children: _columns.map((column) {
          return Expanded(
            child: _buildKanbanColumn(column),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKanbanColumn(KanbanColumn column) {
    return Container(
      width: widget.columnWidth ?? 300,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: widget.columnColor ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    column.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${column.items.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: DragTarget<KanbanItem>(
              onWillAccept: (item) => true,
              onAccept: (item) {
                _handleItemAccept(item, column.id);
              },
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: column.items.length,
                  itemBuilder: (context, index) {
                    final item = column.items[index];
                    return _buildKanbanItem(item, column.id);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanItem(KanbanItem item, String columnId) {
    return LongPressDraggable<KanbanItem>(
      data: item,
      feedback: Material(
        child: _buildItemCard(item, true),
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildItemCard(item, false),
      ),
      child: _buildItemCard(item, false),
    );
  }

  Widget _buildItemCard(KanbanItem item, bool isDragging) {
    return Card(
      elevation: isDragging ? 8 : 2,
      child: InkWell(
        onTap: () => widget.onItemTap?.call(item),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: widget.itemBuilder(item),
        ),
      ),
    );
  }

  void _handleItemAccept(KanbanItem item, String toColumnId) {
    setState(() {
      // 从所有列中移除项目
      for (var column in _columns) {
        column.items.remove(item);
      }
      
      // 添加到目标列
      final targetColumn = _columns.firstWhere((c) => c.id == toColumnId);
      targetColumn.items.add(item);
    });
    
    widget.onItemMove?.call(item, '', toColumnId);
  }
}

class KanbanColumn {
  final String id;
  final String title;
  final List<KanbanItem> items;

  KanbanColumn({
    required this.id,
    required this.title,
    required this.items,
  });
}

class KanbanItem {
  final String id;
  final String title;
  final String? description;
  final Map<String, dynamic>? data;

  KanbanItem({
    required this.id,
    required this.title,
    this.description,
    this.data,
  });
}