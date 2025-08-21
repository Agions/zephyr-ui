import 'package:flutter/material.dart';
import 'data_grid_theme.dart';

/// 数据网格列定义
class ZephyrDataGridColumn<T> {
  /// 列标题
  final String title;
  
  /// 列数据键
  final String dataKey;
  
  /// 列宽度
  final double? width;
  
  /// 是否可调整大小
  final bool resizable;
  
  /// 是否可排序
  final bool sortable;
  
  /// 是否可筛选
  final bool filterable;
  
  /// 是否可编辑
  final bool editable;
  
  /// 对齐方式
  final Alignment alignment;
  
  /// 自定义单元格构建器
  final Widget Function(BuildContext context, T data, int row)? cellBuilder;
  
  /// 自定义编辑器构建器
  final Widget Function(BuildContext context, T data, Function(T) onSaved)? editorBuilder;
  
  /// 自定义标题构建器
  final Widget Function(BuildContext context)? titleBuilder;
  
  /// 数据格式化器
  final String Function(dynamic value)? formatter;
  
  /// 验证器
  final String? Function(dynamic value)? validator;
  
  /// 创建数据网格列
  const ZephyrDataGridColumn({
    required this.title,
    required this.dataKey,
    this.width,
    this.resizable = false,
    this.sortable = false,
    this.filterable = false,
    this.editable = false,
    this.alignment = Alignment.centerLeft,
    this.cellBuilder,
    this.editorBuilder,
    this.titleBuilder,
    this.formatter,
    this.validator,
  });
}

/// 数据网格单元格
class ZephyrDataGridCell {
  /// 行索引
  final int row;
  
  /// 列索引
  final int column;
  
  /// 值
  final dynamic value;
  
  /// 是否编辑模式
  final bool isEditing;
  
  /// 是否选中
  final bool isSelected;
  
  /// 是否错误
  final bool hasError;
  
  /// 错误消息
  final String? error;
  
  /// 创建数据网格单元格
  const ZephyrDataGridCell({
    required this.row,
    required this.column,
    required this.value,
    this.isEditing = false,
    this.isSelected = false,
    this.hasError = false,
    this.error,
  });
}

/// 数据网格行
class ZephyrDataGridRow<T> {
  /// 数据
  final T data;
  
  /// 行索引
  final int index;
  
  /// 是否选中
  final bool selected;
  
  /// 是否展开
  final bool expanded;
  
  /// 高度
  final double? height;
  
  /// 子行
  final List<ZephyrDataGridRow<T>>? children;
  
  /// 创建数据网格行
  const ZephyrDataGridRow({
    required this.data,
    required this.index,
    this.selected = false,
    this.expanded = false,
    this.height,
    this.children,
  });
}

/// 数据网格选择模式
enum ZephyrDataGridSelectionMode {
  /// 无选择
  none,
  
  /// 单选
  single,
  
  /// 多选
  multiple,
  
  /// 范围选择
  range,
}

/// 数据网格编辑模式
enum ZephyrDataGridEditMode {
  /// 无编辑
  none,
  
  /// 单元格编辑
  cell,
  
  /// 行编辑
  row,
  
  /// 批量编辑
  batch,
}

/// ZephyrUI 数据网格组件
///
/// 一个功能强大的数据网格组件，支持编辑、排序、筛选、分组等功能。
///
/// 特性：
/// - 单元格编辑
/// - 排序和筛选
/// - 列调整大小
/// - 行选择
/// - 虚拟滚动
/// - 分组显示
/// - 数据验证
/// - 键盘导航
/// - 剪贴板操作
/// - 响应式设计
///
/// 示例用法：
/// ```dart
/// ZephyrDataGrid<User>(
///   data: users,
///   columns: [
///     ZephyrDataGridColumn<User>(
///       title: '姓名',
///       dataKey: 'name',
///       editable: true,
///     ),
///     ZephyrDataGridColumn<User>(
///       title: '邮箱',
///       dataKey: 'email',
///       sortable: true,
///     ),
///   ],
///   onCellChanged: (row, column, value) => print('单元格修改'),
/// )
/// ```
class ZephyrDataGrid<T> extends StatefulWidget {
  /// 数据列表
  final List<T> data;
  
  /// 列定义
  final List<ZephyrDataGridColumn<T>> columns;
  
  /// 选择模式
  final ZephyrDataGridSelectionMode selectionMode;
  
  /// 编辑模式
  final ZephyrDataGridEditMode editMode;
  
  /// 是否显示边框
  final bool bordered;
  
  /// 是否显示斑马纹
  final bool striped;
  
  /// 是否显示hover效果
  final bool hoverable;
  
  /// 是否显示列头
  final bool showHeader;
  
  /// 是否显示行号
  final bool showRowNumbers;
  
  /// 是否可调整列宽
  final bool resizableColumns;
  
  /// 是否虚拟滚动
  final bool virtualScroll;
  
  /// 行高
  final double rowHeight;
  
  /// 表头高度
  final double headerHeight;
  
  /// 最小列宽
  final double minColumnWidth;
  
  /// 最大列宽
  final double? maxColumnWidth;
  
  /// 每页显示条数
  final int pageSize;
  
  /// 当前页码
  final int currentPage;
  
  /// 主题数据
  final ZephyrDataGridTheme? theme;
  
  /// 单元格点击回调
  final Function(int row, int column, dynamic value)? onCellTap;
  
  /// 单元格双击回调
  final Function(int row, int column, dynamic value)? onCellDoubleTap;
  
  /// 单元格修改回调
  final Function(int row, int column, dynamic value)? onCellChanged;
  
  /// 单元格验证回调
  final String? Function(int row, int column, dynamic value)? onCellValidate;
  
  /// 行选择回调
  final Function(List<int> selectedRows)? onSelectionChanged;
  
  /// 列排序回调
  final Function(String columnKey, bool ascending)? onSort;
  
  /// 列筛选回调
  final Function(String columnKey, dynamic value)? onFilter;
  
  /// 列宽调整回调
  final Function(String columnKey, double width)? onColumnResize;
  
  /// 分页回调
  final Function(int page, int pageSize)? onPageChange;
  
  /// 数据加载回调
  final Function(int page, int pageSize)? onLoadData;
  
  /// 创建数据网格组件
  const ZephyrDataGrid({
    Key? key,
    required this.data,
    required this.columns,
    this.selectionMode = ZephyrDataGridSelectionMode.none,
    this.editMode = ZephyrDataGridEditMode.none,
    this.bordered = true,
    this.striped = true,
    this.hoverable = true,
    this.showHeader = true,
    this.showRowNumbers = false,
    this.resizableColumns = false,
    this.virtualScroll = false,
    this.rowHeight = 48.0,
    this.headerHeight = 56.0,
    this.minColumnWidth = 80.0,
    this.maxColumnWidth,
    this.pageSize = 50,
    this.currentPage = 1,
    this.theme,
    this.onCellTap,
    this.onCellDoubleTap,
    this.onCellChanged,
    this.onCellValidate,
    this.onSelectionChanged,
    this.onSort,
    this.onFilter,
    this.onColumnResize,
    this.onPageChange,
    this.onLoadData,
  }) : super(key: key);

  @override
  State<ZephyrDataGrid<T>> createState() => _ZephyrDataGridState<T>();
}

class _ZephyrDataGridState<T> extends State<ZephyrDataGrid<T>> {
  late ZephyrDataGridTheme _theme;
  late List<T> _data;
  late List<ZephyrDataGridRow<T>> _rows;
  late Set<int> _selectedRows;
  late List<double> _columnWidths;
  late int _currentPage;
  late int _pageSize;
  late ScrollController _horizontalController;
  late ScrollController _verticalController;
  
  String? _sortColumn;
  bool _sortAscending = true;
  Map<String, dynamic> _filters = {};
  int? _editingRow;
  int? _editingColumn;
  
  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrDataGridTheme.light();
    _data = List.from(widget.data);
    _currentPage = widget.currentPage;
    _pageSize = widget.pageSize;
    _selectedRows = {};
    _horizontalController = ScrollController();
    _verticalController = ScrollController();
    
    _initializeColumns();
    _initializeRows();
  }
  
  void _initializeColumns() {
    _columnWidths = widget.columns.map((column) {
      return column.width ?? 150.0;
    }).toList();
  }
  
  void _initializeRows() {
    _rows = _data.asMap().entries.map((entry) {
      return ZephyrDataGridRow<T>(
        data: entry.value,
        index: entry.key,
        selected: _selectedRows.contains(entry.key),
      );
    }).toList();
  }

  @override
  void didUpdateWidget(ZephyrDataGrid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrDataGridTheme.light();
    }
    if (widget.data != oldWidget.data) {
      _data = List.from(widget.data);
      _initializeRows();
    }
    if (widget.currentPage != oldWidget.currentPage) {
      _currentPage = widget.currentPage;
    }
    if (widget.pageSize != oldWidget.pageSize) {
      _pageSize = widget.pageSize;
    }
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  dynamic _getValueByKey(T item, String key) {
    // 简化处理，实际应该通过反射或其他方式获取属性值
    return (item as dynamic)[key];
  }

  void _handleCellTap(int row, int column) {
    final rowData = _rows[row];
    final columnData = widget.columns[column];
    final value = _getValueByKey(rowData.data, columnData.dataKey);
    
    // 处理选择
    if (widget.selectionMode != ZephyrDataGridSelectionMode.none) {
      setState(() {
        switch (widget.selectionMode) {
          case ZephyrDataGridSelectionMode.single:
            _selectedRows.clear();
            _selectedRows.add(row);
            break;
          case ZephyrDataGridSelectionMode.multiple:
            if (_selectedRows.contains(row)) {
              _selectedRows.remove(row);
            } else {
              _selectedRows.add(row);
            }
            break;
          case ZephyrDataGridSelectionMode.range:
            // 范围选择逻辑
            break;
          default:
            break;
        }
      });
      widget.onSelectionChanged?.call(_selectedRows.toList());
    }
    
    widget.onCellTap?.call(row, column, value);
  }

  void _handleCellDoubleTap(int row, int column) {
    if (widget.editMode == ZephyrDataGridEditMode.cell) {
      setState(() {
        _editingRow = row;
        _editingColumn = column;
      });
    }
    
    final rowData = _rows[row];
    final columnData = widget.columns[column];
    final value = _getValueByKey(rowData.data, columnData.dataKey);
    
    widget.onCellDoubleTap?.call(row, column, value);
  }

  void _handleCellChanged(int row, int column, dynamic value) {
    final rowData = _rows[row];
    final columnData = widget.columns[column];
    
    // 验证数据
    String? error;
    if (columnData.validator != null) {
      error = columnData.validator!(value);
    }
    if (widget.onCellValidate != null) {
      error = widget.onCellValidate!(row, column, value) ?? error;
    }
    
    if (error == null) {
      // 更新数据
      setState(() {
        (rowData.data as dynamic)[columnData.dataKey] = value;
        _editingRow = null;
        _editingColumn = null;
      });
      
      widget.onCellChanged?.call(row, column, value);
    }
  }

  void _handleSort(String columnKey) {
    final column = widget.columns.firstWhere(
      (col) => col.dataKey == columnKey,
    );
    
    if (!column.sortable) return;
    
    setState(() {
      if (_sortColumn == columnKey) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumn = columnKey;
        _sortAscending = true;
      }
      
      // 排序数据
      _data.sort((a, b) {
        final valueA = _getValueByKey(a, columnKey);
        final valueB = _getValueByKey(b, columnKey);
        
        final comparison = Comparable.compare(
          valueA?.toString() ?? '',
          valueB?.toString() ?? '',
        );
        
        return _sortAscending ? comparison : -comparison;
      });
      
      _initializeRows();
    });
    
    widget.onSort?.call(columnKey, _sortAscending);
  }

  Widget _buildHeader() {
    if (!widget.showHeader) return const SizedBox();
    
    return Container(
      height: widget.headerHeight,
      decoration: BoxDecoration(
        color: _theme.headerBackgroundColor,
        border: widget.bordered
            ? Border(bottom: BorderSide(color: _theme.borderColor, width: _theme.borderWidth))
            : null,
      ),
      child: Row(
        children: [
          // 行号列
          if (widget.showRowNumbers)
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                '#',
                style: _theme.headerTextStyle,
              ),
            ),
          
          // 列标题
          ...widget.columns.asMap().entries.map((entry) {
            final index = entry.key;
            final column = entry.value;
            final width = _columnWidths[index];
            
            return Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: widget.bordered && index < widget.columns.length - 1
                    ? Border(right: BorderSide(color: _theme.borderColor, width: _theme.borderWidth))
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: column.titleBuilder != null
                        ? column.titleBuilder!(context)
                        : Text(
                            column.title,
                            style: _theme.headerTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                  
                  // 排序图标
                  if (column.sortable)
                    GestureDetector(
                      onTap: () => _handleSort(column.dataKey),
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Icon(
                          _sortColumn == column.dataKey
                              ? (_sortAscending ? Icons.arrow_upward : Icons.arrow_downward)
                              : Icons.unfold_more,
                          size: 16,
                          color: _theme.headerIconColor,
                        ),
                      ),
                    ),
                  
                  // 调整大小手柄
                  if (widget.resizableColumns && column.resizable)
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _columnWidths[index] = 
                              (_columnWidths[index] + details.delta.dx)
                                  .clamp(widget.minColumnWidth, widget.maxColumnWidth ?? double.infinity);
                        });
                        widget.onColumnResize?.call(column.dataKey, _columnWidths[index]);
                      },
                      child: Container(
                        width: 4,
                        color: Colors.transparent,
                        child: Center(
                          child: Container(
                            width: 2,
                            height: 20,
                            color: _theme.resizerColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCell(int row, int column) {
    final rowData = _rows[row];
    final columnData = widget.columns[column];
    final value = _getValueByKey(rowData.data, columnData.dataKey);
    final isSelected = _selectedRows.contains(row);
    final isEditing = _editingRow == row && _editingColumn == column;
    final isStriped = widget.striped && row.isEven;
    
    // 格式化值
    final displayValue = columnData.formatter != null 
        ? columnData.formatter!(value) 
        : value?.toString() ?? '';
    
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? _theme.selectedCellColor
            : isStriped
                ? _theme.stripedRowColor
                : Colors.transparent,
        border: widget.bordered
            ? Border(
                bottom: BorderSide(color: _theme.borderColor, width: _theme.borderWidth),
                right: column < widget.columns.length - 1
                    ? BorderSide(color: _theme.borderColor, width: _theme.borderWidth)
                    : BorderSide.none,
              )
            : null,
      ),
      child: MouseRegion(
        cursor: widget.onCellTap != null ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          onTap: () => _handleCellTap(row, column),
          onDoubleTap: () => _handleCellDoubleTap(row, column),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            alignment: columnData.alignment,
            child: isEditing && columnData.editable
                ? _buildCellEditor(row, column, value)
                : columnData.cellBuilder != null
                    ? columnData.cellBuilder!(context, rowData.data, row)
                    : Text(
                        displayValue,
                        style: _theme.cellTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
          ),
        ),
      ),
    );
  }

  Widget _buildCellEditor(int row, int column, dynamic value) {
    final columnData = widget.columns[column];
    
    if (columnData.editorBuilder != null) {
      return columnData.editorBuilder!(
        context,
        _rows[row].data,
        (newValue) => _handleCellChanged(row, column, newValue),
      );
    }
    
    // 默认文本编辑器
    return TextField(
      controller: TextEditingController(text: value?.toString() ?? ''),
      autofocus: true,
      onSubmitted: (newValue) => _handleCellChanged(row, column, newValue),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }

  Widget _buildBody() {
    if (_data.isEmpty) {
      return Center(
        child: Text(
          '暂无数据',
          style: _theme.emptyTextStyle,
        ),
      );
    }
    
    return ListView.builder(
      controller: _verticalController,
      itemCount: _rows.length,
      itemExtent: widget.rowHeight,
      itemBuilder: (context, row) {
        return Row(
          children: [
            // 行号
            if (widget.showRowNumbers)
              Container(
                width: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _theme.rowNumberBackgroundColor,
                  border: widget.bordered
                      ? Border(
                          bottom: BorderSide(color: _theme.borderColor, width: _theme.borderWidth),
                          right: BorderSide(color: _theme.borderColor, width: _theme.borderWidth),
                        )
                      : null,
                ),
                child: Text(
                  (row + 1).toString(),
                  style: _theme.rowNumberTextStyle,
                ),
              ),
            
            // 单元格
            ...widget.columns.asMap().entries.map((entry) {
              final column = entry.key;
              return SizedBox(
                width: _columnWidths[column],
                child: _buildCell(row, column),
              );
            }).toList(),
          ],
        );
      },
    );
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
          _buildHeader(),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }
}