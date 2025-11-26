import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// AutoComplete Component
/// 
/// A powerful autocomplete component with filtering, customization,
/// and accessibility support for enterprise applications.
class ZephyrAutoComplete<T> extends StatefulWidget {
  final List<T> items;
  final TextEditingController controller;
  final String? placeholder;
  final String Function(T) displayStringForOption;
  final Widget Function(BuildContext, T, bool)? itemBuilder;
  final void Function(T)? onSelected;
  final bool multiSelect;
  final List<T> selectedItems;
  final Future<List<T>> Function(String)? asyncItems;
  final ZephyrAutoCompleteTheme theme;
  final bool enabled;
  final bool readOnly;
  final String? errorText;
  final String? helperText;
  final FocusNode? focusNode;
  final int? maxSuggestions;
  final Duration? debounceDuration;
  final bool showClearButton;
  final bool showLoadingIndicator;
  final bool enableKeyboardNavigation;
  final bool enableAccessibilityFeatures;
  final String? semanticLabel;
  final String? semanticHint;
  final bool autoFocus;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final bool Function(T)? filterPredicate;
  final int Function(T, T)? sortPredicate;
  final bool Function(T, String)? searchPredicate;

  const ZephyrAutoComplete({
    super.key,
    required this.items,
    required this.controller,
    required String Function(T) displayStringForOption,
    this.placeholder,
    this.itemBuilder,
    this.onSelected,
    this.multiSelect = false,
    this.selectedItems = const [],
    this.asyncItems,
    ZephyrAutoCompleteTheme? theme,
    this.enabled = true,
    this.readOnly = false,
    this.errorText,
    this.helperText,
    this.focusNode,
    this.maxSuggestions,
    this.debounceDuration,
    this.showClearButton = true,
    this.showLoadingIndicator = true,
    this.enableKeyboardNavigation = true,
    this.enableAccessibilityFeatures = true,
    this.semanticLabel,
    this.semanticHint,
    this.autoFocus = false,
    this.margin,
    this.width,
    this.height,
    this.constraints,
    this.onTap,
    this.onClear,
    this.filterPredicate,
    this.sortPredicate,
    this.searchPredicate,
  })  : theme = theme ?? ZephyrAutoCompleteTheme.light(),
        displayStringForOption = displayStringForOption;

  @override
  State<ZephyrAutoComplete<T>> createState() => _ZephyrAutoCompleteState<T>();
}

class _ZephyrAutoCompleteState<T> extends State<ZephyrAutoComplete<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  List<T> _filteredItems = [];
  List<T> _asyncItems = [];
  bool _isLoading = false;
  bool _showSuggestions = false;
  int _selectedIndex = -1;
  Timer? _debounceTimer;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _textFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _focusNode = widget.focusNode ?? FocusNode();
    _filteredItems = widget.items;
    
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _focusNode.removeListener(_onFocusChange);
    _controller.removeListener(_onTextChanged);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _showSuggestions = _focusNode.hasFocus;
    });
  }

  void _onTextChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    final debounceDuration = widget.debounceDuration ?? widget.theme.debounceDuration ?? const Duration(milliseconds: 300);
    _debounceTimer = Timer(debounceDuration, () {
      _filterItems();
    });
  }

  Future<void> _filterItems() async {
    final query = _controller.text;
    
    if (widget.asyncItems != null) {
      setState(() {
        _isLoading = true;
        _showSuggestions = true;
      });
      
      try {
        final results = await widget.asyncItems!(query);
        setState(() {
          _asyncItems = results;
          _isLoading = false;
          _selectedIndex = -1;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        _showSuggestions = true;
        _selectedIndex = -1;
      });

      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items.where((item) {
          if (widget.filterPredicate != null) {
            return widget.filterPredicate!(item);
          }
          
          if (widget.searchPredicate != null) {
            return widget.searchPredicate!(item, query);
          }
          
          final displayString = widget.displayStringForOption(item).toLowerCase();
          return displayString.contains(query.toLowerCase());
        }).toList();
        
        if (widget.sortPredicate != null) {
          _filteredItems.sort(widget.sortPredicate);
        }
      }
    }
  }

  void _selectItem(T item) {
    if (!widget.enabled || widget.readOnly) return;

    if (widget.multiSelect) {
      if (!widget.selectedItems.contains(item)) {
        widget.onSelected?.call(item);
      }
    } else {
      _controller.text = widget.displayStringForOption(item);
      widget.onSelected?.call(item);
      _focusNode.unfocus();
    }
    
    setState(() {
      _showSuggestions = false;
      _selectedIndex = -1;
    });
  }

  
  void _clearSelection() {
    _controller.clear();
    widget.onClear?.call();
    setState(() {
      _showSuggestions = false;
      _selectedIndex = -1;
    });
  }

  void _handleKeyDown(KeyEvent event) {
    if (!widget.enableKeyboardNavigation || !_showSuggestions) return;

    final items = widget.asyncItems != null ? _asyncItems : _filteredItems;
    final maxSuggestions = widget.maxSuggestions ?? widget.theme.maxSuggestions ?? 10;
    final visibleItems = items.take(maxSuggestions).toList();

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _selectedIndex = (_selectedIndex + 1) % visibleItems.length;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _selectedIndex = _selectedIndex <= 0 ? visibleItems.length - 1 : _selectedIndex - 1;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (_selectedIndex >= 0 && _selectedIndex < visibleItems.length) {
        _selectItem(visibleItems[_selectedIndex]);
      }
    } else if (event.logicalKey == LogicalKeyboardKey.escape) {
      setState(() {
        _showSuggestions = false;
        _selectedIndex = -1;
      });
    }
  }

  Widget _buildTextField() {
    final theme = widget.theme;
    final hasError = widget.errorText != null;
    final isDisabled = !widget.enabled || widget.readOnly;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _textFieldKey,
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        constraints: widget.constraints,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autoFocus,
          style: theme.inputStyle?.copyWith(
            color: isDisabled ? theme.disabledTextColor : theme.textColor,
          ) ?? const TextStyle(),
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: theme.placeholderStyle?.copyWith(
              color: isDisabled ? theme.disabledTextColor : theme.placeholderColor,
            ) ?? const TextStyle(),
            contentPadding: theme.contentPadding,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.circular(theme.borderRadius ?? 8.0),
              borderSide: const BorderSide(
                color: hasError ? (theme.errorBorderColor ?? Colors.red) : (theme.borderColor ?? Colors.grey),
                width: theme.borderWidth ?? 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.circular(theme.borderRadius ?? 8.0),
              borderSide: const BorderSide(
                color: hasError ? (theme.errorBorderColor ?? Colors.red) : (theme.borderColor ?? Colors.grey),
                width: theme.borderWidth ?? 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.circular(theme.borderRadius ?? 8.0),
              borderSide: const BorderSide(
                color: hasError ? (theme.errorBorderColor ?? Colors.red) : (theme.focusedBorderColor ?? Colors.blue),
                width: theme.borderWidth ?? 1.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.circular(theme.borderRadius ?? 8.0),
              borderSide: const BorderSide(
                color: theme.disabledBorderColor ?? Colors.grey,
                width: theme.borderWidth ?? 1.0,
              ),
            ),
            filled: true,
            fillColor: isDisabled ? theme.disabledBackgroundColor : theme.backgroundColor,
            suffixIcon: _buildSuffixIcon(),
            errorText: widget.errorText,
            helperText: widget.helperText,
          ),
          onTap: widget.onTap,
          onSubmitted: (value) {
            if (_selectedIndex >= 0) {
              final items = widget.asyncItems != null ? _asyncItems : _filteredItems;
              final maxSuggestions = widget.maxSuggestions ?? widget.theme.maxSuggestions ?? 10;
              final visibleItems = items.take(maxSuggestions).toList();
              
              if (_selectedIndex < visibleItems.length) {
                _selectItem(visibleItems[_selectedIndex]);
              }
            }
          },
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    final theme = widget.theme;
    final isDisabled = !widget.enabled || widget.readOnly;

    if (widget.showLoadingIndicator && _isLoading) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(theme.loadingIndicatorColor ?? Colors.blue),
          ),
        ),
      );
    }

    if (widget.showClearButton && _controller.text.isNotEmpty && !isDisabled) {
      return IconButton(
        icon: Icon(Icons.clear, color: theme.clearButtonColor),
        onPressed: _clearSelection,
        tooltip: 'Clear',
      );
    }

    return null;
  }

  Widget _buildSuggestions() {
    final theme = widget.theme;
    final items = widget.asyncItems != null ? _asyncItems : _filteredItems;
    final maxSuggestions = widget.maxSuggestions ?? widget.theme.maxSuggestions ?? 10;
    final visibleItems = items.take(maxSuggestions).toList();

    if (visibleItems.isEmpty && !_isLoading) {
      return _buildNoResults();
    }

    return CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: false,
      offset: Offset(0, _textFieldKey.currentContext?.size?.height ?? 0),
      child: Material(
        elevation: theme.elevation ?? 4.0,
        color: theme.suggestionBackgroundColor ?? Colors.white,
        borderRadius: const BorderRadius.circular(theme.borderRadius ?? 8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: theme.suggestionMaxHeight ?? 300.0,
            minWidth: _textFieldKey.currentContext?.size?.width ?? 200,
          ),
          child: _isLoading
              ? _buildLoading()
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: visibleItems.length,
                  itemBuilder: (context, index) {
                    final item = visibleItems[index];
                    final isSelected = index == _selectedIndex;
                    
                    return _buildSuggestionItem(item, isSelected);
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(T item, bool isSelected) {
    final theme = widget.theme;
    
    return InkWell(
      onTap: () => _selectItem(item),
      child: Container(
        color: isSelected ? theme.selectedItemBackgroundColor : null,
        padding: theme.suggestionPadding,
        child: widget.itemBuilder?.call(context, item, isSelected) ?? 
            Text(
              widget.displayStringForOption(item),
              style: isSelected ? theme.selectedItemStyle : theme.suggestionStyle,
            ),
      ),
    );
  }

  Widget _buildLoading() {
    final theme = widget.theme;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(theme.loadingIndicatorColor ?? Colors.blue),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Loading...',
              style: theme.placeholderStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    final theme = widget.theme;
    
    return CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: false,
      offset: Offset(0, _textFieldKey.currentContext?.size?.height ?? 0),
      child: Material(
        elevation: theme.elevation ?? 4.0,
        color: theme.suggestionBackgroundColor ?? Colors.white,
        borderRadius: const BorderRadius.circular(theme.borderRadius ?? 8.0),
        child: Container(
          padding: theme.suggestionPadding,
          child: Text(
            'No results found',
            style: theme.noResultsStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildMultiSelectTags() {
    if (!widget.multiSelect || widget.selectedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: widget.selectedItems.map((item) {
          return ZephyrChip(
            label: widget.displayStringForOption(item),
            onDeleted: () {
              setState(() {
                widget.selectedItems.remove(item);
              });
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Semantics(
      label: widget.semanticLabel ?? 'Autocomplete input',
      hint: widget.semanticHint ?? 'Type to search',
      enabled: widget.enabled,
      child: FocusScope(
        child: KeyboardListener(
          focusNode: FocusNode(),
          onKeyEvent: _handleKeyDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(),
              _buildMultiSelectTags(),
              if (_showSuggestions && widget.enabled) _buildSuggestions(),
            ],
          ),
        ),
      ),
    );
  }
}