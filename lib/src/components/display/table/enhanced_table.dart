import 'package:flutter/material.dart';
import 'package:chroma_ui/src/core/theme/chroma_colors.dart';
import 'package:chroma_ui/src/core/theme/chroma_spacing.dart';
import 'package:chroma_ui/src/core/theme/chroma_typography.dart';
import 'package:chroma_ui/src/components/basic/button.dart';

class chromaEnhancedTable<T> extends StatefulWidget {
  final List<TableColumn<T>> columns;
  final List<T> data;
  final Widget Function(BuildContext, T)? rowBuilder;
  final Widget Function(BuildContext, T, TableColumn<T>)? cellBuilder;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final bool showBorder;
  final bool showHeader;
  final bool showFooter;
  final bool enableSorting;
  final bool enableFiltering;
  final bool enablePagination;
  final bool enableSelection;
  final bool enableRowHover;
  final bool enableColumnResize;
  final bool striped;
  final bool compact;
  final Color? borderColor;
  final Color? headerColor;
  final Color? hoverColor;
  final Color? selectedColor;
  final Color? stripeColor;
  final int? pageSize;
  final ValueChanged<T>? onRowTap;
  final ValueChanged<List<T>>? onSelectionChanged;
  final Widget Function(BuildContext, List<T>)? footerBuilder;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final bool isLoading;
  final ScrollController? scrollController;
  final SortDirection? initialSortDirection;
  final String? initialSortColumn;

  const chromaEnhancedTable({
    required this.columns,
    required this.data,
    this.rowBuilder,
    this.cellBuilder,
    this.padding,
    this.height,
    this.width,
    this.showBorder = true,
    this.showHeader = true,
    this.showFooter = false,
    this.enableSorting = true,
    this.enableFiltering = true,
    this.enablePagination = true,
    this.enableSelection = false,
    this.enableRowHover = true,
    this.enableColumnResize = true,
    this.striped = false,
    this.compact = false,
    this.borderColor,
    this.headerColor,
    this.hoverColor,
    this.selectedColor,
    this.stripeColor,
    this.pageSize = 10,
    this.onRowTap,
    this.onSelectionChanged,
    this.footerBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.isLoading = false,
    this.scrollController,
    this.initialSortDirection,
    this.initialSortColumn,
    super.key,
  });

  @override
  State<chromaEnhancedTable<T>> createState() => _chromaEnhancedTableState<T>();
}

class _chromaEnhancedTableState<T> extends State<chromaEnhancedTable<T>> {
  late List<T> _filteredData;
  late List<T> _displayedData;
  late List<T> _selectedData;
  late int _currentPage;
  late int _pageSize;
  late Map<String, SortDirection> _sortDirections;
  late Map<String, String> _filterValues;
  late Map<String, double> _columnWidths;
  String? _sortColumn;
  SortDirection _sortDirection = SortDirection.ascending;
  bool _isResizing = false;
  int? _resizingColumn;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _filteredData = List<T>.from(widget.data);
    _displayedData = [];
    _selectedData = [];
    _currentPage = 0;
    _pageSize = widget.pageSize ?? 10;
    _sortDirections = {};
    _filterValues = {};
    _columnWidths = {};
    _sortColumn = widget.initialSortColumn;
    _sortDirection = widget.initialSortDirection ?? SortDirection.ascending;

    // Initialize column widths
    for (final column in widget.columns) {
      _columnWidths[column.id] = column.width ?? 150.0;
    }

    _applyFiltersAndSort();
    _updateDisplayedData();
  }

  @override
  void didUpdateWidget(chromaEnhancedTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _filteredData = List<T>.from(widget.data);
      _applyFiltersAndSort();
      _updateDisplayedData();
    }
  }

  void _applyFiltersAndSort() {
    // Apply filters
    _filteredData = widget.data.where((item) {
      for (final column in widget.columns) {
        final filterValue = _filterValues[column.id];
        if (filterValue != null && filterValue.isNotEmpty) {
          final cellValue = column.valueGetter(item).toString().toLowerCase();
          if (!cellValue.contains(filterValue.toLowerCase())) {
            return false;
          }
        }
      }
      return true;
    }).toList();

    // Apply sorting
    if (_sortColumn != null && widget.enableSorting) {
      final column = widget.columns.firstWhere(
        (col) => col.id == _sortColumn,
        orElse: () => widget.columns.first,
      );

      _filteredData.sort((a, b) {
        final valueA = column.valueGetter(a);
        final valueB = column.valueGetter(b);

        int comparison;
        if (valueA is Comparable && valueB is Comparable) {
          comparison = valueA.compareTo(valueB);
        } else {
          comparison = valueA.toString().compareTo(valueB.toString());
        }

        return _sortDirection == SortDirection.ascending ? comparison : -comparison;
      });
    }
  }

  void _updateDisplayedData() {
    final startIndex = _currentPage * _pageSize;
    final endIndex = startIndex + _pageSize;
    _displayedData = _filteredData.sublist(
      startIndex,
      endIndex > _filteredData.length ? _filteredData.length : endIndex,
    );
  }

  void _handleSort(String columnId) {
    if (!widget.enableSorting) return;

    setState(() {
      if (_sortColumn == columnId) {
        _sortDirection = _sortDirection == SortDirection.ascending
            ? SortDirection.descending
            : SortDirection.ascending;
      } else {
        _sortColumn = columnId;
        _sortDirection = SortDirection.ascending;
      }

      _sortDirections[columnId] = _sortDirection;
      _currentPage = 0;
      _applyFiltersAndSort();
      _updateDisplayedData();
    });
  }

  void _handleFilter(String columnId, String value) {
    setState(() {
      _filterValues[columnId] = value;
      _currentPage = 0;
      _applyFiltersAndSort();
      _updateDisplayedData();
    });
  }

  void _handlePageChange(int page) {
    setState(() {
      _currentPage = page;
      _updateDisplayedData();
    });
  }

  void _handleSelectionChanged(T item, bool selected) {
    setState(() {
      if (selected) {
        _selectedData.add(item);
      } else {
        _selectedData.remove(item);
      }
      widget.onSelectionChanged?.call(_selectedData);
    });
  }

  void _handleSelectAll(bool selected) {
    setState(() {
      if (selected) {
        _selectedData = List<T>.from(_displayedData);
      } else {
        _selectedData.clear();
      }
      widget.onSelectionChanged?.call(_selectedData);
    });
  }

  void _startColumnResize(int columnIndex, double startX) {
    setState(() {
      _isResizing = true;
      _resizingColumn = columnIndex;
    });
  }

  void _updateColumnResize(double delta) {
    if (_isResizing && _resizingColumn != null) {
      final column = widget.columns[_resizingColumn!];
      setState(() {
        _columnWidths[column.id] = (_columnWidths[column.id] ?? 150.0) + delta;
      });
    }
  }

  void _endColumnResize() {
    setState(() {
      _isResizing = false;
      _resizingColumn = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<chromaColors>()!;
    final spacing = theme.extension<chromaSpacing>()!;
    final typography = theme.extension<chromaTypography>()!;

    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding ?? spacing.paddingMd,
      decoration: BoxDecoration(
        border: widget.showBorder
            ? Border.all(color: widget.borderColor ?? colors.outline)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.showHeader) _buildHeader(colors, spacing, typography),
          if (widget.enableFiltering) _buildFilterRow(colors, spacing, typography),
          Expanded(
            child: _buildTableContent(colors, spacing, typography),
          ),
          if (widget.showFooter) _buildFooter(colors, spacing, typography),
          if (widget.enablePagination) _buildPagination(colors, spacing, typography),
        ],
      ),
    );
  }

  Widget _buildHeader(chromaColors colors, chromaSpacing spacing, chromaTypography typography) {
    return Container(
      color: widget.headerColor ?? colors.surfaceVariant,
      padding: EdgeInsets.symmetric(
        horizontal: spacing.spacingMd,
        vertical: widget.compact ? spacing.spacingSm : spacing.spacingMd,
      ),
      child: Row(
        children: [
          if (widget.enableSelection)
            Checkbox(
              value: _displayedData.isNotEmpty && _selectedData.length == _displayedData.length,
              onChanged: _handleSelectAll,
            ),
          ...widget.columns.map((column) {
            final isSortable = widget.enableSorting && column.sortable;
            final sortDirection = _sortDirections[column.id];
            final isSorted = _sortColumn == column.id;

            return Expanded(
              flex: column.flex ?? 1,
              child: GestureDetector(
                onTap: isSortable ? () => _handleSort(column.id) : null,
                child: Container(
                  width: _columnWidths[column.id],
                  padding: EdgeInsets.symmetric(horizontal: spacing.spacingSm),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          column.label,
                          style: typography.labelLarge?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isSortable)
                        Icon(
                          isSorted
                              ? (sortDirection == SortDirection.ascending
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward)
                              : Icons.swap_vert,
                          size: 16,
                          color: isSorted ? colors.primary : colors.onSurfaceVariant,
                        ),
                      if (widget.enableColumnResize)
                        MouseRegion(
                          cursor: SystemMouseCursors.resizeColumn,
                          child: GestureDetector(
                            onPanStart: (details) => _startColumnResize(
                              widget.columns.indexOf(column),
                              details.localPosition.dx,
                            ),
                            onPanUpdate: (details) => _updateColumnResize(details.delta.dx),
                            onPanEnd: (details) => _endColumnResize(),
                            child: Container(
                              width: 4,
                              height: 20,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterRow(chromaColors colors, chromaSpacing spacing, chromaTypography typography) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.spacingMd,
        vertical: spacing.spacingSm,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.outline.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          if (widget.enableSelection) const SizedBox(width: 24),
          ...widget.columns.map((column) {
            return Expanded(
              flex: column.flex ?? 1,
              child: Container(
                width: _columnWidths[column.id],
                padding: EdgeInsets.symmetric(horizontal: spacing.spacingSm),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Filter ${column.label}',
                    hintStyle: typography.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: colors.outline.withOpacity(0.3)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: spacing.spacingSm,
                      vertical: spacing.spacingXs,
                    ),
                  ),
                  style: typography.bodySmall?.copyWith(color: colors.onSurface),
                  onChanged: (value) => _handleFilter(column.id, value),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTableContent(chromaColors colors, chromaSpacing spacing, chromaTypography typography) {
    if (widget.isLoading) {
      return Center(
        child: widget.loadingWidget ?? const CircularProgressIndicator(),
      );
    }

    if (_displayedData.isEmpty) {
      return Center(
        child: widget.emptyWidget ??
            Text(
              'No data available',
              style: typography.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
            ),
      );
    }

    return ListView.builder(
      controller: widget.scrollController,
      itemCount: _displayedData.length,
      itemBuilder: (context, index) {
        final item = _displayedData[index];
        final isSelected = _selectedData.contains(item);
        final isStriped = widget.striped && index.isEven;

        return widget.rowBuilder?.call(context, item) ??
            _buildDefaultRow(context, item, colors, spacing, typography, isSelected, isStriped);
      },
    );
  }

  Widget _buildDefaultRow(
    BuildContext context,
    T item,
    chromaColors colors,
    chromaSpacing spacing,
    chromaTypography typography,
    bool isSelected,
    bool isStriped,
  ) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: GestureDetector(
        onTap: widget.onRowTap != null ? () => widget.onRowTap!(item) : null,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? (widget.selectedColor ?? colors.primaryContainer)
                : isStriped
                    ? (widget.stripeColor ?? colors.surfaceVariant.withOpacity(0.3))
                    : null,
            border: Border(
              bottom: BorderSide(color: colors.outline.withOpacity(0.1)),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: spacing.spacingMd,
            vertical: widget.compact ? spacing.spacingSm : spacing.spacingMd,
          ),
          child: Row(
            children: [
              if (widget.enableSelection)
                Checkbox(
                  value: isSelected,
                  onChanged: (selected) => _handleSelectionChanged(item, selected ?? false),
                ),
              ...widget.columns.map((column) {
                final cellValue = column.valueGetter(item);
                return Expanded(
                  flex: column.flex ?? 1,
                  child: Container(
                    width: _columnWidths[column.id],
                    padding: EdgeInsets.symmetric(horizontal: spacing.spacingSm),
                    child: widget.cellBuilder?.call(context, item, column) ??
                        Text(
                          cellValue.toString(),
                          style: typography.bodyMedium?.copyWith(
                            color: colors.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(chromaColors colors, chromaSpacing spacing, chromaTypography typography) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.spacingMd,
        vertical: spacing.spacingSm,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        border: Border(top: BorderSide(color: colors.outline.withOpacity(0.2))),
      ),
      child: widget.footerBuilder?.call(context, _filteredData) ??
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing ${_currentPage * _pageSize + 1}-${(_currentPage + 1) * _pageSize} of ${_filteredData.length} items',
                style: typography.bodySmall?.copyWith(color: colors.onSurfaceVariant),
              ),
              Text(
                'Selected: ${_selectedData.length}',
                style: typography.bodySmall?.copyWith(color: colors.onSurfaceVariant),
              ),
            ],
          ),
    );
  }

  Widget _buildPagination(chromaColors colors, chromaSpacing spacing, chromaTypography typography) {
    final totalPages = (_filteredData.length / _pageSize).ceil();
    if (totalPages <= 1) return const SizedBox();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.spacingMd,
        vertical: spacing.spacingSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          chromaButton.secondary(
            text: 'Previous',
            onPressed: _currentPage > 0 ? () => _handlePageChange(_currentPage - 1) : null,
            size: ButtonSize.small,
          ),
          SizedBox(width: spacing.spacingMd),
          ...List.generate(totalPages, (index) {
            final isActive = index == _currentPage;
            return chromaButton(
              text: (index + 1).toString(),
              onPressed: () => _handlePageChange(index),
              variant: isActive ? ButtonVariant.primary : ButtonVariant.text,
              size: ButtonSize.small,
            );
          }).expand((button) => [button, SizedBox(width: spacing.spacingXs)]).take(totalPages * 2 - 1),
          SizedBox(width: spacing.spacingMd),
          chromaButton.secondary(
            text: 'Next',
            onPressed: _currentPage < totalPages - 1 ? () => _handlePageChange(_currentPage + 1) : null,
            size: ButtonSize.small,
          ),
        ],
      ),
    );
  }
}

class TableColumn<T> {
  final String id;
  final String label;
  final dynamic Function(T) valueGetter;
  final double? width;
  final int? flex;
  final bool sortable;
  final bool filterable;
  final Widget Function(BuildContext, T, dynamic)? cellBuilder;

  const TableColumn({
    required this.id,
    required this.label,
    required this.valueGetter,
    this.width,
    this.flex,
    this.sortable = true,
    this.filterable = true,
    this.cellBuilder,
  });
}

enum SortDirection {
  ascending,
  descending,
}
