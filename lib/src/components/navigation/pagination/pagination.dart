/// ZephyrUI 分页组件
/// 
/// 提供数据分页功能，支持多种样式和自定义配置。
library pagination;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 分页组件配置
class ZephyrPaginationConfig {
  /// 创建分页配置
  const ZephyrPaginationConfig({
    this.currentPage = 1,
    this.totalItems = 0,
    this.itemsPerPage = 10,
    this.maxVisiblePages = 7,
    this.showFirstLast = true,
    this.showPreviousNext = true,
    this.showPageSizeSelector = false,
    this.pageSizeOptions = const [10, 20, 50, 100],
  });

  /// 当前页码
  final int currentPage;

  /// 总项目数
  final int totalItems;

  /// 每页项目数
  final int itemsPerPage;

  /// 最大显示页码数
  final int maxVisiblePages;

  /// 是否显示首页和末页按钮
  final bool showFirstLast;

  /// 是否显示上一页和下一页按钮
  final bool showPreviousNext;

  /// 是否显示每页项目数选择器
  final bool showPageSizeSelector;

  /// 每页项目数选项
  final List<int> pageSizeOptions;

  /// 获取总页数
  int get totalPages => (totalItems / itemsPerPage).ceil();

  /// 获取起始索引
  int get startIndex => (currentPage - 1) * itemsPerPage + 1;

  /// 获取结束索引
  int get endIndex => currentPage * itemsPerPage < totalItems
      ? currentPage * itemsPerPage
      : totalItems;

  /// 是否有上一页
  bool get hasPrevious => currentPage > 1;

  /// 是否有下一页
  bool get hasNext => currentPage < totalPages;
}

/// ZephyrUI 分页组件
class ZephyrPagination extends StatefulWidget {
  /// 创建分页组件
  const ZephyrPagination({
    Key? key,
    required this.config,
    this.onPageChanged,
    this.onPageSizeChanged,
    this.theme,
    this.alignment = WrapAlignment.center,
    this.spacing = 8,
    this.runSpacing = 8,
    this.showPageInfo = true,
    this.pageInfoBuilder,
    this.pageButtonBuilder,
    this.firstPageButtonBuilder,
    this.lastPageButtonBuilder,
    this.previousPageButtonBuilder,
    this.nextPageButtonBuilder,
    this.pageSizeSelectorBuilder,
  }) : super(key: key);

  /// 分页配置
  final ZephyrPaginationConfig config;

  /// 页码变化回调
  final Function(int page)? onPageChanged;

  /// 每页项目数变化回调
  final Function(int pageSize)? onPageSizeChanged;

  /// 主题
  final ZephyrPaginationTheme? theme;

  /// 对齐方式
  final WrapAlignment alignment;

  /// 水平间距
  final double spacing;

  /// 垂直间距
  final double runSpacing;

  /// 是否显示页码信息
  final bool showPageInfo;

  /// 页码信息构建器
  final Widget Function(BuildContext context, ZephyrPaginationConfig config)? pageInfoBuilder;

  /// 页码按钮构建器
  final Widget Function(
    BuildContext context,
    int page,
    bool isCurrent,
    VoidCallback onTap,
  )? pageButtonBuilder;

  /// 首页按钮构建器
  final Widget Function(
    BuildContext context,
    VoidCallback onTap,
    bool disabled,
  )? firstPageButtonBuilder;

  /// 末页按钮构建器
  final Widget Function(
    BuildContext context,
    VoidCallback onTap,
    bool disabled,
  )? lastPageButtonBuilder;

  /// 上一页按钮构建器
  final Widget Function(
    BuildContext context,
    VoidCallback onTap,
    bool disabled,
  )? previousPageButtonBuilder;

  /// 下一页按钮构建器
  final Widget Function(
    BuildContext context,
    VoidCallback onTap,
    bool disabled,
  )? nextPageButtonBuilder;

  /// 每页项目数选择器构建器
  final Widget Function(
    BuildContext context,
    int currentSize,
    List<int> options,
    Function(int) onChanged,
  )? pageSizeSelectorBuilder;

  @override
  State<ZephyrPagination> createState() => _ZephyrPaginationState();
}

class _ZephyrPaginationState extends State<ZephyrPagination> {
  late ZephyrPaginationConfig _config;

  @override
  void initState() {
    super.initState();
    _config = widget.config;
  }

  @override
  void didUpdateWidget(ZephyrPagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config != widget.config) {
      _config = widget.config;
    }
  }

  List<int> _getVisiblePages() {
    final totalPages = _config.totalPages;
    final currentPage = _config.currentPage;
    final maxVisible = _config.maxVisiblePages;

    if (totalPages <= maxVisible) {
      return List.generate(totalPages, (index) => index + 1);
    }

    List<int> pages = [];
    final halfVisible = (maxVisible - 1) ~/ 2;

    if (currentPage <= halfVisible) {
      pages = List.generate(maxVisible - 1, (index) => index + 1);
      pages.add(totalPages);
    } else if (currentPage >= totalPages - halfVisible) {
      pages.add(1);
      pages.addAll(List.generate(maxVisible - 1, (index) => totalPages - maxVisible + 2 + index));
    } else {
      pages.add(1);
      pages.addAll(List.generate(maxVisible - 2, (index) => currentPage - halfVisible + index));
      pages.add(totalPages);
    }

    return pages;
  }

  void _goToPage(int page) {
    if (page < 1 || page > _config.totalPages || page == _config.currentPage) {
      return;
    }

    setState(() {
      _config = ZephyrPaginationConfig(
        currentPage: page,
        totalItems: _config.totalItems,
        itemsPerPage: _config.itemsPerPage,
        maxVisiblePages: _config.maxVisiblePages,
        showFirstLast: _config.showFirstLast,
        showPreviousNext: _config.showPreviousNext,
        showPageSizeSelector: _config.showPageSizeSelector,
        pageSizeOptions: _config.pageSizeOptions,
      );
    });

    widget.onPageChanged?.call(page);
  }

  void _changePageSize(int pageSize) {
    if (pageSize == _config.itemsPerPage) {
      return;
    }

    final newCurrentPage = ((_config.currentPage - 1) * _config.itemsPerPage ~/ pageSize) + 1;

    setState(() {
      _config = ZephyrPaginationConfig(
        currentPage: newCurrentPage,
        totalItems: _config.totalItems,
        itemsPerPage: pageSize,
        maxVisiblePages: _config.maxVisiblePages,
        showFirstLast: _config.showFirstLast,
        showPreviousNext: _config.showPreviousNext,
        showPageSizeSelector: _config.showPageSizeSelector,
        pageSizeOptions: _config.pageSizeOptions,
      );
    });

    widget.onPageSizeChanged?.call(pageSize);
    widget.onPageChanged?.call(newCurrentPage);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrPaginationTheme.of(context);

    if (_config.totalPages <= 1) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        if (widget.showPageInfo) _buildPageInfo(theme),
        Wrap(
          alignment: widget.alignment,
          spacing: widget.spacing,
          runSpacing: widget.runSpacing,
          children: [
            if (_config.showFirstLast) _buildFirstButton(theme),
            if (_config.showPreviousNext) _buildPreviousButton(theme),
            ..._buildPageButtons(theme),
            if (_config.showPreviousNext) _buildNextButton(theme),
            if (_config.showFirstLast) _buildLastButton(theme),
            if (_config.showPageSizeSelector) _buildPageSizeSelector(theme),
          ],
        ),
      ],
    );
  }

  Widget _buildPageInfo(ZephyrPaginationTheme theme) {
    return widget.pageInfoBuilder?.call(context, _config) ??
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            '显示 ${_config.startIndex}-${_config.endIndex} 条，共 ${_config.totalItems} 条',
            style: theme.pageInfoStyle,
          ),
        );
  }

  Widget _buildFirstButton(ZephyrPaginationTheme theme) {
    final disabled = !_config.hasPrevious;
    return widget.firstPageButtonBuilder?.call(
      context,
      () => _goToPage(1),
      disabled,
    ) ??
        ZephyrButton.outline(
          text: '',
          onPressed: disabled ? null : () => _goToPage(1),
          icon: Icons.first_page,
          size: ZephyrButtonSize.small,
        );
  }

  Widget _buildPreviousButton(ZephyrPaginationTheme theme) {
    final disabled = !_config.hasPrevious;
    return widget.previousPageButtonBuilder?.call(
      context,
      () => _goToPage(_config.currentPage - 1),
      disabled,
    ) ??
        ZephyrButton.outline(
          text: '',
          onPressed: disabled ? null : () => _goToPage(_config.currentPage - 1),
          icon: Icons.chevron_left,
          size: ZephyrButtonSize.small,
        );
  }

  Widget _buildNextButton(ZephyrPaginationTheme theme) {
    final disabled = !_config.hasNext;
    return widget.nextPageButtonBuilder?.call(
      context,
      () => _goToPage(_config.currentPage + 1),
      disabled,
    ) ??
        ZephyrButton.outline(
          text: '',
          onPressed: disabled ? null : () => _goToPage(_config.currentPage + 1),
          icon: Icons.chevron_right,
          size: ZephyrButtonSize.small,
        );
  }

  Widget _buildLastButton(ZephyrPaginationTheme theme) {
    final disabled = !_config.hasNext;
    return widget.lastPageButtonBuilder?.call(
      context,
      () => _goToPage(_config.totalPages),
      disabled,
    ) ??
        ZephyrButton.outline(
          text: '',
          onPressed: disabled ? null : () => _goToPage(_config.totalPages),
          icon: Icons.last_page,
          size: ZephyrButtonSize.small,
        );
  }

  List<Widget> _buildPageButtons(ZephyrPaginationTheme theme) {
    final visiblePages = _getVisiblePages();
    final List<Widget> buttons = [];

    for (int i = 0; i < visiblePages.length; i++) {
      final page = visiblePages[i];
      final isCurrent = page == _config.currentPage;

      // 添加省略号
      if (i > 0 && page - visiblePages[i - 1] > 1) {
        buttons.add(
          Text(
            '...',
            style: theme.ellipsisStyle,
          ),
        );
      }

      buttons.add(
        widget.pageButtonBuilder?.call(
          context,
          page,
          isCurrent,
          () => _goToPage(page),
        ) ??
            ZephyrButton.primary(
              text: page.toString(),
              onPressed: isCurrent ? null : () => _goToPage(page),
              size: ZephyrButtonSize.small,
            ),
      );
    }

    return buttons;
  }

  Widget _buildPageSizeSelector(ZephyrPaginationTheme theme) {
    return widget.pageSizeSelectorBuilder?.call(
      context,
      _config.itemsPerPage,
      _config.pageSizeOptions,
      _changePageSize,
    ) ??
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: theme.borderColor),
            borderRadius: theme.borderRadius,
          ),
          child: DropdownButton<int>(
            value: _config.itemsPerPage,
            underline: Container(),
            isDense: true,
            items: _config.pageSizeOptions.map((size) {
              return DropdownMenuItem<int>(
                value: size,
                child: Text('$size 条/页'),
              );
            }).toList(),
            onChanged: (size) {
              if (size != null) {
                _changePageSize(size);
              }
            },
          ),
        );
  }
}