/// ZephyrUI Dropdown 下拉菜单组件
///
/// 提供下拉菜单功能，支持单选、多选、搜索等功能

library dropdown;

import 'package:flutter/material.dart';

/// 下拉菜单项
class ZephyrDropdownItem<T> {
  const ZephyrDropdownItem({
    required this.value,
    required this.label,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.subtitle,
    this.textColor,
  });
  final T value;
  final String label;
  final Widget? leading;
  final Widget? trailing;
  final bool enabled;
  final String? subtitle;
  final Color? textColor;
}

/// 下拉菜单样式
enum ZephyrDropdownStyle {
  standard, // 标准样式
  outlined, // 边框样式
  filled, // 填充样式
}

/// 下拉菜单大小
enum ZephyrDropdownSize {
  small, // 小尺寸
  medium, // 中等尺寸
  large, // 大尺寸
}

/// Dropdown 组件
class ZephyrDropdown<T> extends StatefulWidget {
  const ZephyrDropdown({
    required this.items,
    super.key,
    this.value,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.onChanged,
    this.style = ZephyrDropdownStyle.outlined,
    this.size = ZephyrDropdownSize.medium,
    this.isDense = false,
    this.isExpanded = false,
    this.icon,
    this.iconColor,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.showSearch = false,
    this.searchHintText = '搜索...',
    this.enabled = true,
    this.disabledHint,
    this.maxItemsToShow,
    this.showClearButton = false,
    this.onClear,
    this.displayBuilder,
    this.itemBuilder,
  });
  final List<ZephyrDropdownItem<T>> items;
  final T? value;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final ValueChanged<T?>? onChanged;
  final ZephyrDropdownStyle style;
  final ZephyrDropdownSize size;
  final bool isDense;
  final bool isExpanded;
  final Widget? icon;
  final Color? iconColor;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool showSearch;
  final String searchHintText;
  final bool enabled;
  final Widget? disabledHint;
  final int? maxItemsToShow;
  final bool showClearButton;
  final VoidCallback? onClear;
  final String Function(T)? displayBuilder;
  final Widget Function(ZephyrDropdownItem<T>)? itemBuilder;

  @override
  State<ZephyrDropdown<T>> createState() => _ZephyrDropdownState<T>();
}

class _ZephyrDropdownState<T> extends State<ZephyrDropdown<T>> {
  late TextEditingController _searchController;
  List<ZephyrDropdownItem<T>> _filteredItems = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.items;
  }

  @override
  void didUpdateWidget(ZephyrDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _filterItems();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    if (_searchQuery.isEmpty) {
      setState(() {
        _filteredItems = widget.items;
      });
    } else {
      setState(() {
        _filteredItems = widget.items.where((item) {
          return item.label
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              (item.subtitle
                      ?.toLowerCase()
                      .contains(_searchQuery.toLowerCase()) ??
                  false);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: widget.errorText != null
                  ? theme.colorScheme.error
                  : theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],
        _buildDropdown(),
        if (widget.errorText != null || widget.helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.errorText ?? widget.helperText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: widget.errorText != null
                  ? theme.colorScheme.error
                  : theme.colorScheme.onSurface.withValues(alpha:0.6),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdown() {
    final theme = Theme.of(context);
    final effectiveItems = widget.maxItemsToShow != null
        ? _filteredItems.take(widget.maxItemsToShow!).toList()
        : _filteredItems;

    return DropdownButtonFormField<T>(
      value: widget.value,
      items: effectiveItems.map((item) {
        return DropdownMenuItem<T>(
          value: item.value,
          enabled: item.enabled,
          child: widget.itemBuilder?.call(item) ?? _buildMenuItem(item),
        );
      }).toList(),
      onChanged: widget.enabled ? widget.onChanged : null,
      hint: widget.hintText != null ? Text(widget.hintText!) : null,
      disabledHint: widget.disabledHint,
      style: theme.textTheme.bodyMedium,
      decoration: _getInputDecoration(theme),
      icon: widget.icon ?? const Icon(Icons.keyboard_arrow_down),
      iconSize: _getIconSize(),
      iconEnabledColor: widget.iconColor ?? theme.colorScheme.onSurface,
      iconDisabledColor: theme.colorScheme.onSurface.withValues(alpha:0.38),
      isDense: widget.isDense,
      isExpanded: widget.isExpanded,
      dropdownColor: theme.colorScheme.surface,
      borderRadius:
          BorderRadius.circular(widget.borderRadius ?? _getBorderRadius()),
      focusColor: theme.colorScheme.primary.withValues(alpha:0.1),
      onTap: () {
        if (widget.showSearch) {
          _showSearchDialog();
        }
      },
    );
  }

  Widget _buildMenuItem(ZephyrDropdownItem<T> item) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (item.leading != null) ...[
            item.leading!,
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: item.textColor ?? theme.colorScheme.onSurface,
                  ),
                ),
                if (item.subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha:0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (item.trailing != null) ...[
            const SizedBox(width: 12),
            item.trailing!,
          ],
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration(ThemeData theme) {
    final fillColor = widget.fillColor ?? _getFillColor(theme);
    final borderColor = widget.borderColor ?? theme.colorScheme.outline;
    const borderRadius = 8.0;

    switch (widget.style) {
      case ZephyrDropdownStyle.standard:
        return InputDecoration(
          hintText: widget.hintText,
          errorText: null, // 错误文本在外部显示
          helperText: null, // 帮助文本在外部显示
          contentPadding: widget.contentPadding ?? _getContentPadding(),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
          suffixIcon: widget.showClearButton && widget.value != null
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: widget.onClear ??
                      () {
                        widget.onChanged?.call(null);
                      },
                )
              : null,
        );
      case ZephyrDropdownStyle.outlined:
        return InputDecoration(
          hintText: widget.hintText,
          errorText: null,
          helperText: null,
          contentPadding: widget.contentPadding ?? _getContentPadding(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
          ),
          filled: false,
          suffixIcon: widget.showClearButton && widget.value != null
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: widget.onClear ??
                      () {
                        widget.onChanged?.call(null);
                      },
                )
              : null,
        );
      case ZephyrDropdownStyle.filled:
        return InputDecoration(
          hintText: widget.hintText,
          errorText: null,
          helperText: null,
          contentPadding: widget.contentPadding ?? _getContentPadding(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: fillColor,
          suffixIcon: widget.showClearButton && widget.value != null
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: widget.onClear ??
                      () {
                        widget.onChanged?.call(null);
                      },
                )
              : null,
        );
    }
  }

  Color _getFillColor(ThemeData theme) {
    return widget.enabled
        ? theme.colorScheme.surfaceContainerHighest.withValues(alpha:0.5)
        : theme.colorScheme.surfaceContainerHighest.withValues(alpha:0.2);
  }

  EdgeInsetsGeometry _getContentPadding() {
    switch (widget.size) {
      case ZephyrDropdownSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ZephyrDropdownSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
      case ZephyrDropdownSize.medium:
      default:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ZephyrDropdownSize.small:
        return 18;
      case ZephyrDropdownSize.large:
        return 24;
      case ZephyrDropdownSize.medium:
      default:
        return 20;
    }
  }

  double _getBorderRadius() {
    switch (widget.size) {
      case ZephyrDropdownSize.small:
        return 6;
      case ZephyrDropdownSize.large:
        return 12;
      case ZephyrDropdownSize.medium:
      default:
        return 8;
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.searchHintText),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: widget.searchHintText,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                    _filterItems();
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return ListTile(
                        leading: item.leading,
                        title: Text(item.label),
                        subtitle:
                            item.subtitle != null ? Text(item.subtitle!) : null,
                        trailing: item.trailing,
                        onTap: item.enabled
                            ? () {
                                Navigator.pop(context);
                                widget.onChanged?.call(item.value);
                              }
                            : null,
                        enabled: item.enabled,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
          ],
        );
      },
    );
  }
}

/// 多选下拉菜单组件
class ZephyrMultiSelectDropdown<T> extends StatefulWidget {
  const ZephyrMultiSelectDropdown({
    required this.items,
    required this.values,
    super.key,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.onChanged,
    this.style = ZephyrDropdownStyle.outlined,
    this.size = ZephyrDropdownSize.medium,
    this.isDense = false,
    this.isExpanded = false,
    this.icon,
    this.iconColor,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.showSearch = false,
    this.searchHintText = '搜索...',
    this.enabled = true,
    this.maxItemsToShow,
    this.showSelectAll = false,
    this.selectAllText = '全选',
    this.displayBuilder,
  });
  final List<ZephyrDropdownItem<T>> items;
  final List<T> values;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final ValueChanged<List<T>>? onChanged;
  final ZephyrDropdownStyle style;
  final ZephyrDropdownSize size;
  final bool isDense;
  final bool isExpanded;
  final Widget? icon;
  final Color? iconColor;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool showSearch;
  final String searchHintText;
  final bool enabled;
  final int? maxItemsToShow;
  final bool showSelectAll;
  final String selectAllText;
  final Widget Function(List<T>)? displayBuilder;

  @override
  State<ZephyrMultiSelectDropdown<T>> createState() =>
      _ZephyrMultiSelectDropdownState<T>();
}

class _ZephyrMultiSelectDropdownState<T>
    extends State<ZephyrMultiSelectDropdown<T>> {
  late TextEditingController _searchController;
  List<ZephyrDropdownItem<T>> _filteredItems = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.items;
  }

  @override
  void didUpdateWidget(ZephyrMultiSelectDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _filterItems();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    if (_searchQuery.isEmpty) {
      setState(() {
        _filteredItems = widget.items;
      });
    } else {
      setState(() {
        _filteredItems = widget.items.where((item) {
          return item.label
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              (item.subtitle
                      ?.toLowerCase()
                      .contains(_searchQuery.toLowerCase()) ??
                  false);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: widget.errorText != null
                  ? theme.colorScheme.error
                  : theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],
        _buildDropdown(),
        if (widget.errorText != null || widget.helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.errorText ?? widget.helperText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: widget.errorText != null
                  ? theme.colorScheme.error
                  : theme.colorScheme.onSurface.withValues(alpha:0.6),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdown() {
    final theme = Theme.of(context);

    return InkWell(
      onTap: widget.enabled ? _showSelectionDialog : null,
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      child: InputDecorator(
        decoration: _getInputDecoration(theme),
        isEmpty: widget.values.isEmpty,
        child: widget.values.isEmpty
            ? Text(
                widget.hintText ?? '请选择',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha:0.6),
                ),
              )
            : widget.displayBuilder?.call(widget.values) ??
                _buildSelectedItems(),
      ),
    );
  }

  Widget _buildSelectedItems() {
    final theme = Theme.of(context);
    final displayCount = widget.values.length > 3 ? 3 : widget.values.length;

    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: widget.values.take(displayCount).map((value) {
              final item = widget.items.firstWhere(
                (item) => item.value == value,
                orElse: () => ZephyrDropdownItem(
                  value: value,
                  label: value.toString(),
                ),
              );
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        if (widget.values.length > 3) ...[
          Text(
            ' +${widget.values.length - 3}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:0.6),
            ),
          ),
        ],
      ],
    );
  }

  InputDecoration _getInputDecoration(ThemeData theme) {
    final fillColor = widget.fillColor ?? _getFillColor(theme);
    final borderColor = widget.borderColor ?? theme.colorScheme.outline;
    const borderRadius = 8.0;

    switch (widget.style) {
      case ZephyrDropdownStyle.standard:
        return InputDecoration(
          hintText: widget.hintText,
          errorText: null,
          helperText: null,
          contentPadding: widget.contentPadding ?? _getContentPadding(),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
          suffixIcon: widget.icon ?? const Icon(Icons.keyboard_arrow_down),
        );
      case ZephyrDropdownStyle.outlined:
        return InputDecoration(
          hintText: widget.hintText,
          errorText: null,
          helperText: null,
          contentPadding: widget.contentPadding ?? _getContentPadding(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
          ),
          filled: false,
          suffixIcon: widget.icon ?? const Icon(Icons.keyboard_arrow_down),
        );
      case ZephyrDropdownStyle.filled:
        return InputDecoration(
          hintText: widget.hintText,
          errorText: null,
          helperText: null,
          contentPadding: widget.contentPadding ?? _getContentPadding(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: fillColor,
          suffixIcon: widget.icon ?? const Icon(Icons.keyboard_arrow_down),
        );
    }
  }

  Color _getFillColor(ThemeData theme) {
    return widget.enabled
        ? theme.colorScheme.surfaceContainerHighest.withValues(alpha:0.5)
        : theme.colorScheme.surfaceContainerHighest.withValues(alpha:0.2);
  }

  EdgeInsetsGeometry _getContentPadding() {
    switch (widget.size) {
      case ZephyrDropdownSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ZephyrDropdownSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
      case ZephyrDropdownSize.medium:
      default:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(widget.hintText ?? '请选择'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showSearch) ...[
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: widget.searchHintText,
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                          _filterItems();
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (widget.showSelectAll) ...[
                      CheckboxListTile(
                        title: Text(widget.selectAllText),
                        value: _filteredItems.every(
                            (item) => widget.values.contains(item.value)),
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              final newValues = List<T>.from(widget.values);
                              for (final item in _filteredItems) {
                                if (!newValues.contains(item.value)) {
                                  newValues.add(item.value);
                                }
                              }
                              widget.onChanged?.call(newValues);
                            } else {
                              final newValues = List<T>.from(widget.values);
                              newValues.removeWhere((value) => _filteredItems
                                  .any((item) => item.value == value));
                              widget.onChanged?.call(newValues);
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          final isSelected = widget.values.contains(item.value);
                          return CheckboxListTile(
                            title: Text(item.label),
                            subtitle: item.subtitle != null
                                ? Text(item.subtitle!)
                                : null,
                            value: isSelected,
                            onChanged: item.enabled
                                ? (value) {
                                    setState(() {
                                      final newValues =
                                          List<T>.from(widget.values);
                                      if (value == true) {
                                        newValues.add(item.value);
                                      } else {
                                        newValues.remove(item.value);
                                      }
                                      widget.onChanged?.call(newValues);
                                    });
                                  }
                                : null,
                            enabled: item.enabled,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('确定'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

/// 下拉菜单工具类
class ZephyrDropdownUtils {
  /// 创建简单的下拉菜单项列表
  static List<ZephyrDropdownItem<T>> createItems<T>(
    List<T> values,
    List<String> labels, {
    List<Widget?>? leading,
    List<Widget?>? trailing,
    List<bool>? enabled,
  }) {
    return List.generate(values.length, (index) {
      return ZephyrDropdownItem<T>(
        value: values[index],
        label: labels[index],
        leading: index < (leading?.length ?? 0) ? leading![index] : null,
        trailing: index < (trailing?.length ?? 0) ? trailing![index] : null,
        enabled: index < (enabled?.length ?? 0) ? enabled![index] : true,
      );
    });
  }

  /// 创建枚举类型的下拉菜单项
  static List<ZephyrDropdownItem<T>> createEnumItems<T>(
    List<T> enumValues, {
    String Function(T)? labelBuilder,
    Widget Function(T)? leadingBuilder,
    Widget Function(T)? trailingBuilder,
  }) {
    return enumValues.map((value) {
      return ZephyrDropdownItem<T>(
        value: value,
        label: labelBuilder?.call(value) ?? value.toString(),
        leading: leadingBuilder?.call(value),
        trailing: trailingBuilder?.call(value),
      );
    }).toList();
  }
}
