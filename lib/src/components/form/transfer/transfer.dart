import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import 'transfer_theme.dart';

/// Zephyr穿梭框组件
///
/// 用于在两个列表之间移动选项，支持：
/// - 双向数据传输
/// - 搜索过滤
/// - 批量操作
/// - 自定义渲染
///
/// 示例用法:
/// ```dart
/// ZephyrTransfer(
///   dataSource: [
///     TransferItem(key: '1', title: '选项1', description: '描述1'),
///     TransferItem(key: '2', title: '选项2', description: '描述2'),
///   ],
///   targetKeys: ['2'],
///   onChanged: (targetKeys) => debugPrint(targetKeys),
/// )
/// ```
class ZephyrTransfer extends StatefulWidget {
  /// 创建穿梭框
  const ZephyrTransfer({
    required this.dataSource,
    super.key,
    this.targetKeys = const [],
    this.onChanged,
    this.selectedKeys = const [],
    this.onSelectedChange,
    this.titles = const ['源列表', '目标列表'],
    this.operations = const [],
    this.showSearch = false,
    this.filterOption,
    this.searchPlaceholder,
    this.notFoundContent,
    this.renderItem,
    this.footer,
    this.listStyle,
    this.disabled = false,
    this.oneWay = false,
    this.pagination,
    this.theme,
  });

  /// 数据源
  final List<TransferItem> dataSource;

  /// 目标列表的键值
  final List<String> targetKeys;

  /// 目标列表变化回调
  final void Function(List<String>)? onChanged;

  /// 选中项的键值
  final List<String> selectedKeys;

  /// 选中项变化回调
  final void Function(List<String>)? onSelectedChange;

  /// 列表标题
  final List<String> titles;

  /// 操作按钮文本
  final List<String> operations;

  /// 是否显示搜索框
  final bool showSearch;

  /// 过滤函数
  final bool Function(String, TransferItem)? filterOption;

  /// 搜索框占位符
  final String? searchPlaceholder;

  /// 无数据时的内容
  final Widget? notFoundContent;

  /// 自定义渲染函数
  final Widget Function(TransferItem)? renderItem;

  /// 底部内容
  final Widget? Function(TransferDirection)? footer;

  /// 列表样式
  final TransferListStyle? listStyle;

  /// 是否禁用
  final bool disabled;

  /// 是否单向传输
  final bool oneWay;

  /// 分页配置
  final TransferPagination? pagination;

  /// 主题
  final ZephyrTransferTheme? theme;

  @override
  State<ZephyrTransfer> createState() => _ZephyrTransferState();
}

class _ZephyrTransferState extends State<ZephyrTransfer> {
  late List<String> _targetKeys;
  late List<String> _selectedKeys;
  late TextEditingController _sourceSearchController;
  late TextEditingController _targetSearchController;
  String _sourceFilter = '';
  String _targetFilter = '';

  @override
  void initState() {
    super.initState();
    _targetKeys = List.from(widget.targetKeys);
    _selectedKeys = List.from(widget.selectedKeys);
    _sourceSearchController = TextEditingController();
    _targetSearchController = TextEditingController();

    _sourceSearchController.addListener(() {
      setState(() {
        _sourceFilter = _sourceSearchController.text;
      });
    });

    _targetSearchController.addListener(() {
      setState(() {
        _targetFilter = _targetSearchController.text;
      });
    });
  }

  @override
  void dispose() {
    _sourceSearchController.dispose();
    _targetSearchController.dispose();
    super.dispose();
  }

  List<TransferItem> get _sourceItems {
    return widget.dataSource.where((item) {
      if (_targetKeys.contains(item.key)) return false;
      if (_sourceFilter.isEmpty) return true;
      return widget.filterOption?.call(_sourceFilter, item) ??
          item.title.toLowerCase().contains(_sourceFilter.toLowerCase());
    }).toList();
  }

  List<TransferItem> get _targetItems {
    return widget.dataSource.where((item) {
      if (!_targetKeys.contains(item.key)) return false;
      if (_targetFilter.isEmpty) return true;
      return widget.filterOption?.call(_targetFilter, item) ??
          item.title.toLowerCase().contains(_targetFilter.toLowerCase());
    }).toList();
  }

  void _handleItemSelect(String key, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedKeys.contains(key)) {
          _selectedKeys.add(key);
        }
      } else {
        _selectedKeys.remove(key);
      }
    });

    if (widget.onSelectedChange != null) {
      widget.onSelectedChange!(_selectedKeys);
    }
  }

  void _handleSelectAll(TransferDirection direction, bool selected) {
    final items =
        direction == TransferDirection.left ? _sourceItems : _targetItems;
    final keys = items.map((item) => item.key).toList();

    setState(() {
      if (selected) {
        _selectedKeys.addAll(keys.where((key) => !_selectedKeys.contains(key)));
      } else {
        _selectedKeys =
            _selectedKeys.where((key) => !keys.contains(key)).toList();
      }
    });

    if (widget.onSelectedChange != null) {
      widget.onSelectedChange!(_selectedKeys);
    }
  }

  void _handleMove(TransferDirection direction) {
    if (widget.disabled) return;

    setState(() {
      if (direction == TransferDirection.right) {
        // 从源列表移动到目标列表
        _targetKeys
            .addAll(_selectedKeys.where((key) => !_targetKeys.contains(key)));
      } else {
        // 从目标列表移动到源列表
        _targetKeys =
            _targetKeys.where((key) => !_selectedKeys.contains(key)).toList();
      }
      _selectedKeys.clear();
    });

    if (widget.onChanged != null) {
      widget.onChanged!(_targetKeys);
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrTransferTheme.resolve(context, widget.theme);

    return Container(
      decoration: BoxDecoration(
        color: effectiveTheme.backgroundColor,
        borderRadius: const BorderRadius.circular(effectiveTheme.borderRadius),
        border: Border.all(
          color: effectiveTheme.borderColor,
          width: effectiveTheme.borderWidth,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTransferList(
              direction: TransferDirection.left,
              items: _sourceItems,
              title: widget.titles.isNotEmpty ? widget.titles[0] : '',
              theme: effectiveTheme,
            ),
          ),
          _buildOperations(effectiveTheme),
          if (!widget.oneWay)
            Expanded(
              child: _buildTransferList(
                direction: TransferDirection.right,
                items: _targetItems,
                title: widget.titles.length > 1 ? widget.titles[1] : '',
                theme: effectiveTheme,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransferList({
    required TransferDirection direction,
    required List<TransferItem> items,
    required String title,
    required ZephyrTransferTheme theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.listBorderColor,
          width: theme.listBorderWidth,
        ),
        borderRadius: const BorderRadius.circular(theme.listBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Container(
              padding: theme.headerPadding,
              decoration: BoxDecoration(
                color: theme.headerBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(theme.listBorderRadius),
                ),
                border: Border(
                  bottom: const BorderSide(
                    color: theme.headerBorderColor,
                    width: theme.headerBorderWidth,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.headerTextStyle,
                    ),
                  ),
                  if (widget.showSearch)
                    Expanded(
                      child: TextField(
                        controller: direction == TransferDirection.left
                            ? _sourceSearchController
                            : _targetSearchController,
                        decoration: InputDecoration(
                          hintText: widget.searchPlaceholder ?? '搜索',
                          hintStyle: theme.searchHintStyle,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(theme.searchBorderRadius),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: theme.searchFillColor,
                          contentPadding: theme.searchContentPadding,
                          prefixIcon: Icon(
                            Icons.search,
                            size: theme.searchIconSize,
                            color: theme.searchIconColor,
                          ),
                        ),
                        style: theme.searchTextStyle,
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: widget.notFoundContent ??
                        Text(
                          '暂无数据',
                          style: theme.emptyTextStyle,
                        ),
                  )
                : ListView.builder(
                    padding: theme.listPadding,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = _selectedKeys.contains(item.key);

                      return _buildTransferItem(
                        item: item,
                        isSelected: isSelected,
                        onSelected: (selected) =>
                            _handleItemSelect(item.key, selected),
                        theme: theme,
                      );
                    },
                  ),
          ),
          if (widget.footer != null)
            Container(
              padding: theme.footerPadding,
              decoration: BoxDecoration(
                border: Border(
                  top: const BorderSide(
                    color: theme.footerBorderColor,
                    width: theme.footerBorderWidth,
                  ),
                ),
              ),
              child: widget.footer!(direction),
            ),
        ],
      ),
    );
  }

  Widget _buildTransferItem({
    required TransferItem item,
    required bool isSelected,
    required ValueChanged<bool> onSelected,
    required ZephyrTransferTheme theme,
  }) {
    return Container(
      margin: theme.itemMargin,
      decoration: BoxDecoration(
        color: isSelected
            ? theme.itemSelectedBackgroundColor
            : theme.itemBackgroundColor,
        borderRadius: const BorderRadius.circular(theme.itemBorderRadius),
        border: Border.all(
          color: isSelected
              ? theme.itemSelectedBorderColor
              : theme.itemBorderColor,
          width: isSelected
              ? theme.itemSelectedBorderWidth
              : theme.itemBorderWidth,
        ),
      ),
      child: InkWell(
        onTap: () => onSelected(!isSelected),
        borderRadius: const BorderRadius.circular(theme.itemBorderRadius),
        child: Padding(
          padding: theme.itemPadding,
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (value) => onSelected(value ?? false),
                activeColor: theme.checkboxActiveColor,
                checkColor: theme.checkboxCheckColor,
              ),
              Expanded(
                child: widget.renderItem?.call(item) ??
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: theme.itemTitleStyle,
                        ),
                        if (item.description != null)
                          Text(
                            item.description!,
                            style: theme.itemDescriptionStyle,
                          ),
                      ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOperations(ZephyrTransferTheme theme) {
    return Padding(
      padding: theme.operationsPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.operations.isNotEmpty)
            _buildOperationButton(
              text: widget.operations[0],
              onPressed: _selectedKeys.isNotEmpty
                  ? () => _handleMove(TransferDirection.right)
                  : null,
              icon: Icons.arrow_forward,
              theme: theme,
            ),
          if (!widget.oneWay && widget.operations.length > 1)
            SizedBox(height: theme.operationSpacing),
          if (!widget.oneWay && widget.operations.length > 1)
            _buildOperationButton(
              text: widget.operations[1],
              onPressed: _selectedKeys.isNotEmpty
                  ? () => _handleMove(TransferDirection.left)
                  : null,
              icon: Icons.arrow_back,
              theme: theme,
            ),
        ],
      ),
    );
  }

  Widget _buildOperationButton({
    required String text,
    required VoidCallback? onPressed,
    required IconData icon,
    required ZephyrTransferTheme theme,
  }) {
    final isEnabled = onPressed != null;

    return Container(
      width: theme.operationButtonWidth,
      height: theme.operationButtonHeight,
      decoration: BoxDecoration(
        color: isEnabled
            ? theme.operationButtonBackgroundColor
            : theme.disabledOperationButtonBackgroundColor,
        borderRadius: const BorderRadius.circular(theme.operationButtonBorderRadius),
        border: Border.all(
          color: isEnabled
              ? theme.operationButtonBorderColor
              : theme.disabledOperationButtonBorderColor,
          width: theme.operationButtonBorderWidth,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius:
              BorderRadius.circular(theme.operationButtonBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: theme.operationIconSize,
                color: isEnabled
                    ? theme.operationIconColor
                    : theme.disabledOperationIconColor,
              ),
              SizedBox(width: theme.operationIconSpacing),
              Text(
                text,
                style: isEnabled
                    ? theme.operationTextStyle
                    : theme.disabledOperationTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 穿梭框数据项
class TransferItem {
  /// 创建穿梭框数据项
  const TransferItem({
    required this.key,
    required this.title,
    this.description,
    this.disabled = false,
    this.selected = false,
  });

  /// 键值
  final String key;

  /// 标题
  final String title;

  /// 描述
  final String? description;

  /// 是否禁用
  final bool disabled;

  /// 是否选中
  final bool selected;
}

/// 穿梭框方向
enum TransferDirection {
  /// 左侧（源列表）
  left,

  /// 右侧（目标列表）
  right,
}

/// 穿梭框列表样式
class TransferListStyle {
  const TransferListStyle({
    this.width,
    this.height,
    this.itemHeight,
  });

  /// 列表宽度
  final double? width;

  /// 列表高度
  final double? height;

  /// 列表项高度
  final double? itemHeight;
}

/// 穿梭框分页配置
class TransferPagination {
  const TransferPagination({
    required this.pageSize,
    this.showSizeChanger = false,
    this.pageSizeOptions = const [10, 20, 50, 100],
  });

  /// 每页条数
  final int pageSize;

  /// 是否显示每页条数选择器
  final bool showSizeChanger;

  /// 每页条数选项
  final List<int> pageSizeOptions;
}
