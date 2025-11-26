import 'package:flutter/material.dart';
import 'table_theme.dart';

/// 表格列定义
class ZephyrTableColumn<T> {
  /// 创建表格列
  const ZephyrTableColumn({
    required this.title,
    required this.dataKey,
    this.width,
    this.sortable = false,
    this.filterable = false,
    this.alignment = Alignment.centerLeft,
    this.cellBuilder,
    this.titleBuilder,
    this.comparator,
  });

  /// 列标题
  final String title;

  /// 列数据键
  final String dataKey;

  /// 列宽度
  final double? width;

  /// 是否可排序
  final bool sortable;

  /// 是否可筛选
  final bool filterable;

  /// 对齐方式
  final Alignment alignment;

  /// 自定义单元格构建器
  final Widget Function(BuildContext context, T data)? cellBuilder;

  /// 自定义标题构建器
  final Widget Function(BuildContext context)? titleBuilder;

  /// 排序比较器
  final int Function(T a, T b, bool ascending)? comparator;
}

/// 表格排序信息
class ZephyrTableSort {
  /// 创建排序信息
  const ZephyrTableSort({
    required this.dataKey,
    this.ascending = true,
  });

  /// 排序字段
  final String dataKey;

  /// 是否升序
  final bool ascending;
}

/// 表格筛选信息
class ZephyrTableFilter {
  /// 创建筛选信息
  const ZephyrTableFilter({
    required this.dataKey,
    required this.value,
    this.operator = 'contains',
  });

  /// 筛选字段
  final String dataKey;

  /// 筛选值
  final dynamic value;

  /// 筛选操作符
  final String operator;
}

/// ZephyrUI 表格组件
///
/// 一个功能丰富的数据表格组件，支持排序、筛选、分页、选择等功能。
///
/// 特性：
/// - 灵活的列配置
/// - 排序和筛选
/// - 分页支持
/// - 行选择
/// - 自定义样式
/// - 虚拟滚动（大数据量优化）
/// - 响应式设计
///
/// 示例用法：
/// ```dart
/// ZephyrTable<User>(
///   data: users,
///   columns: [
///     ZephyrTableColumn<User>(
///       title: '姓名',
///       dataKey: 'name',
///       sortable: true,
///     ),
///     ZephyrTableColumn<User>(
///       title: '邮箱',
///       dataKey: 'email',
///       filterable: true,
///     ),
///   ],
///   onSelectionChanged: (selected) => debugPrint('选中: $selected'),
/// )
/// ```
class ZephyrTable<T> extends StatefulWidget {
  /// 创建表格组件
  const ZephyrTable({
    required this.data,
    required this.columns,
    super.key,
    this.bordered = true,
    this.striped = true,
    this.hoverable = true,
    this.selectable = false,
    this.paginated = false,
    this.pageSize = 10,
    this.currentPage = 1,
    this.sort,
    this.filters,
    this.selectedRows = const {},
    this.height,
    this.rowHeight = 48.0,
    this.headerHeight = 56.0,
    this.empty,
    this.loading = false,
    this.theme,
    this.onSort,
    this.onFilter,
    this.onPageChange,
    this.onSelectionChanged,
    this.onRowTap,
  });

  /// 表格数据
  final List<T> data;

  /// 列定义
  final List<ZephyrTableColumn<T>> columns;

  /// 是否显示边框
  final bool bordered;

  /// 是否显示斑马纹
  final bool striped;

  /// 是否显示hover效果
  final bool hoverable;

  /// 是否可选择行
  final bool selectable;

  /// 是否显示分页
  final bool paginated;

  /// 每页显示条数
  final int pageSize;

  /// 当前页码
  final int currentPage;

  /// 排序信息
  final ZephyrTableSort? sort;

  /// 筛选信息
  final List<ZephyrTableFilter>? filters;

  /// 选中的行
  final Set<T> selectedRows;

  /// 高度
  final double? height;

  /// 行高
  final double rowHeight;

  /// 表头高度
  final double headerHeight;

  /// 空数据提示
  final Widget? empty;

  /// 加载状态
  final bool loading;

  /// 主题数据
  final ZephyrTableTheme? theme;

  /// 排序回调
  final Function(ZephyrTableSort sort)? onSort;

  /// 筛选回调
  final Function(List<ZephyrTableFilter> filters)? onFilter;

  /// 分页回调
  final Function(int page, int pageSize)? onPageChange;

  /// 选择回调
  final Function(Set<T> selected)? onSelectionChanged;

  /// 行点击回调
  final Function(T data)? onRowTap;

  @override
  State<ZephyrTable<T>> createState() => _ZephyrTableState<T>();
}

class _ZephyrTableState<T> extends State<ZephyrTable<T>> {
  late ZephyrTableTheme _theme;
  late List<T> _filteredData;
  late List<T> _sortedData;
  late Set<T> _selectedRows;
  late int _currentPage;
  late int _pageSize;
  ZephyrTableSort? _currentSort;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrTableTheme.light();
    _selectedRows = Set.from(widget.selectedRows);
    _currentPage = widget.currentPage;
    _pageSize = widget.pageSize;
    _currentSort = widget.sort;
    _processData();
  }

  @override
  void didUpdateWidget(ZephyrTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrTableTheme.light();
    }
    if (widget.selectedRows != oldWidget.selectedRows) {
      _selectedRows = Set.from(widget.selectedRows);
    }
    if (widget.currentPage != oldWidget.currentPage) {
      _currentPage = widget.currentPage;
    }
    if (widget.pageSize != oldWidget.pageSize) {
      _pageSize = widget.pageSize;
    }
    if (widget.sort != oldWidget.sort) {
      _currentSort = widget.sort;
    }
    _processData();
  }

  void _processData() {
    // 应用筛选
    _filteredData = List.from(widget.data);
    if (widget.filters != null && widget.filters!.isNotEmpty) {
      for (final filter in widget.filters!) {
        _filteredData = _filteredData.where((item) {
          final value = _getValueByKey(item, filter.dataKey);
          return _applyFilter(value, filter.value, filter.operator);
        }).toList();
      }
    }

    // 应用排序
    _sortedData = List.from(_filteredData);
    if (_currentSort != null) {
      final column = widget.columns.firstWhere(
        (col) => col.dataKey == _currentSort!.dataKey,
        orElse: () => widget.columns.first,
      );

      if (column.comparator != null) {
        _sortedData
            .sort((a, b) => column.comparator!(a, b, _currentSort!.ascending));
      } else {
        _sortedData.sort((a, b) {
          final valueA = _getValueByKey(a, _currentSort!.dataKey);
          final valueB = _getValueByKey(b, _currentSort!.dataKey);

          if (_currentSort!.ascending) {
            return Comparable.compare(valueA.toString(), valueB.toString());
          } else {
            return Comparable.compare(valueB.toString(), valueA.toString());
          }
        });
      }
    }
  }

  dynamic _getValueByKey(T item, String key) {
    // 这里简化处理，实际应该通过反射或其他方式获取属性值
    // 在实际使用中，建议使用 data class 或 map
    return (item as dynamic)[key];
  }

  bool _applyFilter(dynamic value, dynamic filterValue, String operator) {
    final stringValue = value.toString();
    final filterString = filterValue.toString();

    switch (operator) {
      case 'equals':
        return stringValue == filterString;
      case 'contains':
        return stringValue.toLowerCase().contains(filterString.toLowerCase());
      case 'startsWith':
        return stringValue.toLowerCase().startsWith(filterString.toLowerCase());
      case 'endsWith':
        return stringValue.toLowerCase().endsWith(filterString.toLowerCase());
      default:
        return stringValue.toLowerCase().contains(filterString.toLowerCase());
    }
  }

  List<T> get _currentPageData {
    if (!widget.paginated) {
      return _sortedData;
    }

    final startIndex = (_currentPage - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;

    if (startIndex >= _sortedData.length) {
      return [];
    }

    return _sortedData.sublist(
      startIndex,
      endIndex.clamp(0, _sortedData.length),
    );
  }

  int get _totalPages {
    if (!widget.paginated) {
      return 1;
    }
    return (_sortedData.length / _pageSize).ceil();
  }

  void _handleSort(String dataKey) {
    final column = widget.columns.firstWhere(
      (col) => col.dataKey == dataKey,
    );

    if (!column.sortable) return;

    setState(() {
      if (_currentSort?.dataKey == dataKey) {
        _currentSort = ZephyrTableSort(
          dataKey: dataKey,
          ascending: !_currentSort!.ascending,
        );
      } else {
        _currentSort = ZephyrTableSort(dataKey: dataKey);
      }
      _processData();
    });

    widget.onSort?.call(_currentSort!);
  }

  void _handleSelectionChanged(T item, bool selected) {
    setState(() {
      if (selected) {
        _selectedRows.add(item);
      } else {
        _selectedRows.remove(item);
      }
    });

    widget.onSelectionChanged?.call(_selectedRows);
  }

  void _handleSelectAll(bool selected) {
    setState(() {
      if (selected) {
        _selectedRows.addAll(_currentPageData);
      } else {
        _selectedRows.removeAll(_currentPageData);
      }
    });

    widget.onSelectionChanged?.call(_selectedRows);
  }

  void _handlePageChange(int page) {
    setState(() {
      _currentPage = page;
    });

    widget.onPageChange?.call(page, _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: _theme.borderRadius,
        border: widget.bordered
            ? Border.all(color: _theme.borderColor, width: _theme.borderWidth)
            : null,
      ),
      child: Column(
        children: [
          // 表头
          _buildHeader(),

          // 表格内容
          Expanded(
            child: _buildBody(),
          ),

          // 分页器
          if (widget.paginated && _sortedData.isNotEmpty) _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: widget.headerHeight,
      decoration: BoxDecoration(
        color: _theme.headerBackgroundColor,
        border: widget.bordered
            ? Border(
                bottom: BorderSide(
                    color: _theme.borderColor, width: _theme.borderWidth))
            : null,
      ),
      child: Row(
        children: [
          // 选择框
          if (widget.selectable)
            Container(
              width: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Checkbox(
                value: _currentPageData.isNotEmpty &&
                    _currentPageData
                        .every((item) => _selectedRows.contains(item)),
                onChanged: (selected) => _handleSelectAll(selected ?? false),
              ),
            ),

          // 列标题
          ...widget.columns.map(
            (column) => Expanded(
              flex: column.width != null ? 1 : 0,
              child: Container(
                width: column.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: column.alignment,
                child: Row(
                  children: [
                    if (column.titleBuilder != null)
                      column.titleBuilder!(context)
                    else
                      Text(
                        column.title,
                        style: _theme.headerTextStyle,
                      ),
                    if (column.sortable)
                      GestureDetector(
                        onTap: () => _handleSort(column.dataKey),
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: Icon(
                            _currentSort?.dataKey == column.dataKey
                                ? (_currentSort!.ascending
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                                : Icons.unfold_more,
                            size: 16,
                            color: _theme.headerIconColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (widget.loading) {
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

    if (_sortedData.isEmpty) {
      return Center(
        child: widget.empty ??
            Text(
              '暂无数据',
              style: _theme.emptyTextStyle,
            ),
      );
    }

    return ListView.builder(
      itemCount: _currentPageData.length,
      itemExtent: widget.rowHeight,
      itemBuilder: (context, index) {
        final item = _currentPageData[index];
        final isSelected = _selectedRows.contains(item);
        final isStriped = widget.striped && index.isEven;

        return _buildRow(item, isSelected, isStriped);
      },
    );
  }

  Widget _buildRow(T item, bool isSelected, bool isStriped) {
    return MouseRegion(
      cursor: widget.onRowTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onRowTap != null ? () => widget.onRowTap!(item) : null,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? _theme.selectedRowColor
                : isStriped
                    ? _theme.stripedRowColor
                    : Colors.transparent,
            border: widget.bordered
                ? Border(
                    bottom: BorderSide(
                      color: _theme.borderColor,
                      width: _theme.borderWidth,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              // 选择框
              if (widget.selectable)
                Container(
                  width: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (selected) =>
                        _handleSelectionChanged(item, selected ?? false),
                  ),
                ),

              // 单元格
              ...widget.columns.map(
                (column) => Expanded(
                  flex: column.width != null ? 1 : 0,
                  child: Container(
                    width: column.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: column.alignment,
                    child: column.cellBuilder != null
                        ? column.cellBuilder!(context, item)
                        : Text(
                            _getValueByKey(item, column.dataKey).toString(),
                            style: _theme.cellTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _theme.footerBackgroundColor,
        border: widget.bordered
            ? Border(
                top: BorderSide(
                    color: _theme.borderColor, width: _theme.borderWidth))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 分页信息
          Text(
            '第 ${(_currentPage - 1) * _pageSize + 1}-${(_currentPage * _pageSize).clamp(1, _sortedData.length)} 条，共 ${_sortedData.length} 条',
            style: _theme.paginationTextStyle,
          ),

          // 分页控件
          Row(
            children: [
              // 上一页
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _currentPage > 1
                    ? () => _handlePageChange(_currentPage - 1)
                    : null,
                color: _theme.paginationIconColor,
              ),

              // 页码
              ...List.generate(_totalPages.clamp(1, 5), (index) {
                final page =
                    _currentPage <= 3 ? index + 1 : _currentPage + index - 2;

                if (page > _totalPages) return Container();

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: TextButton(
                    onPressed: () => _handlePageChange(page),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(32, 32),
                      backgroundColor: page == _currentPage
                          ? _theme.primaryColor
                          : Colors.transparent,
                      foregroundColor: page == _currentPage
                          ? Colors.white
                          : _theme.paginationTextColor,
                    ),
                    child: Text(page.toString()),
                  ),
                );
              }),

              // 下一页
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _currentPage < _totalPages
                    ? () => _handlePageChange(_currentPage + 1)
                    : null,
                color: _theme.paginationIconColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
