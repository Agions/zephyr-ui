import 'package:flutter/material.dart';

import 'package:zephyr_ui/zephyr_ui.dart';

/// 选择器选项数据项
class ZephyrSelectOption<T> {
  /// 选项值
  final T value;

  /// 选项显示文本
  final String label;

  /// 选项描述（可选）
  final String? description;

  /// 选项图标（可选）
  final Widget? icon;

  /// 是否禁用此选项
  final bool disabled;

  /// 创建选择器选项
  const ZephyrSelectOption({
    required this.value,
    required this.label,
    this.description,
    this.icon,
    this.disabled = false,
  });
}

/// ZephyrUI 选择器组件
///
/// 一个功能丰富的下拉选择器组件，支持搜索、多选、分组等功能。
///
/// 示例用法:
/// ```dart
/// ZephyrSelect<String>(
///   label: '选择城市',
///   placeholder: '请选择城市',
///   options: [
///     ZephyrSelectOption(value: 'beijing', label: '北京'),
///     ZephyrSelectOption(value: 'shanghai', label: '上海'),
///   ],
///   onChanged: (value) => print(value),
/// )
/// ```
class ZephyrSelect<T> extends StatefulWidget {
  /// 创建一个选择器组件
  const ZephyrSelect({
    super.key,
    required this.options,
    this.value,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.size = ZephyrSize.md,
    this.enabled = true,
    this.required = false,
    this.searchable = false,
    this.clearable = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onFocusChange,
    this.validator,
    this.theme,
  });

  /// 选项列表
  final List<ZephyrSelectOption<T>> options;

  /// 当前选中的值
  final T? value;

  /// 标签文本
  final String? label;

  /// 占位符文本
  final String? placeholder;

  /// 帮助文本
  final String? helperText;

  /// 错误文本
  final String? errorText;

  /// 组件尺寸
  final ZephyrSize size;

  /// 是否启用
  final bool enabled;

  /// 是否必填
  final bool required;

  /// 是否可搜索
  final bool searchable;

  /// 是否可清除
  final bool clearable;

  /// 前缀图标
  final Widget? prefixIcon;

  /// 后缀图标
  final Widget? suffixIcon;

  /// 值变更回调
  final ValueChanged<T?>? onChanged;

  /// 焦点变更回调
  final ValueChanged<bool>? onFocusChange;

  /// 验证器
  final String? Function(T?)? validator;

  /// 自定义主题
  final ZephyrSelectTheme? theme;

  @override
  State<ZephyrSelect<T>> createState() => _ZephyrSelectState<T>();
}

class _ZephyrSelectState<T> extends State<ZephyrSelect<T>> {
  late FocusNode _focusNode;
  late TextEditingController _searchController;
  bool _isFocused = false;
  bool _isDropdownOpen = false;
  String? _errorText;
  List<ZephyrSelectOption<T>> _filteredOptions = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _searchController = TextEditingController();
    _focusNode.addListener(_handleFocusChange);
    _filteredOptions = widget.options;
    _errorText = widget.errorText;
  }

  @override
  void didUpdateWidget(ZephyrSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      _filteredOptions = widget.options;
    }
    if (oldWidget.errorText != widget.errorText) {
      _errorText = widget.errorText;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    final isFocused = _focusNode.hasFocus;
    if (_isFocused != isFocused) {
      setState(() {
        _isFocused = isFocused;
      });
      widget.onFocusChange?.call(isFocused);
    }
  }

  void _handleOptionSelected(T? value) {
    // 执行验证
    if (widget.validator != null) {
      final error = widget.validator!(value);
      if (_errorText != error) {
        setState(() {
          _errorText = error;
        });
      }
    }

    setState(() {
      _isDropdownOpen = false;
    });

    widget.onChanged?.call(value);
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });

    if (_isDropdownOpen) {
      _focusNode.requestFocus();
    }
  }

  void _handleSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredOptions = widget.options;
      } else {
        _filteredOptions = widget.options
            .where((option) =>
                option.label.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _clearSelection() {
    _handleOptionSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrSelectTheme.of(context);
    final selectedOptions =
        widget.options.where((option) => option.value == widget.value);
    final selectedOption =
        selectedOptions.isNotEmpty ? selectedOptions.first : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          _buildLabel(theme),
          const SizedBox(height: 8),
        ],
        Stack(
          children: [
            _buildSelectField(theme, selectedOption),
            if (_isDropdownOpen) _buildDropdown(theme),
          ],
        ),
        if (widget.helperText != null || _errorText != null) ...[
          const SizedBox(height: 4),
          _buildHelperText(theme),
        ],
      ],
    );
  }

  Widget _buildLabel(ZephyrSelectTheme theme) {
    return RichText(
      text: TextSpan(
        text: widget.label,
        style: theme.labelStyle,
        children: widget.required
            ? [
                TextSpan(
                  text: ' *',
                  style: theme.labelStyle.copyWith(
                    color: theme.errorBorderColor,
                  ),
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildSelectField(
      ZephyrSelectTheme theme, ZephyrSelectOption<T>? selectedOption) {
    final hasError = _errorText != null;
    final borderColor = hasError
        ? theme.errorBorderColor
        : _isFocused
            ? theme.focusedBorderColor
            : theme.borderColor;

    return GestureDetector(
      onTap: _toggleDropdown,
      child: Container(
        height: _getFieldHeight(),
        decoration: BoxDecoration(
          color: widget.enabled
              ? theme.backgroundColor
              : theme.disabledBackgroundColor,
          border: Border.all(
            color: widget.enabled ? borderColor : theme.disabledBorderColor,
            width: theme.borderWidth,
          ),
          borderRadius: theme.borderRadius,
        ),
        child: Row(
          children: [
            if (widget.prefixIcon != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: widget.prefixIcon,
              ),
            ],
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildFieldContent(theme, selectedOption),
              ),
            ),
            if (widget.clearable &&
                selectedOption != null &&
                widget.enabled) ...[
              GestureDetector(
                onTap: _clearSelection,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.clear,
                    size: 16,
                    color: theme.placeholderStyle.color,
                  ),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: widget.suffixIcon ??
                  Icon(
                    _isDropdownOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: widget.enabled
                        ? theme.textStyle.color
                        : theme.disabledBorderColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldContent(
      ZephyrSelectTheme theme, ZephyrSelectOption<T>? selectedOption) {
    if (selectedOption != null) {
      return Row(
        children: [
          if (selectedOption.icon != null) ...[
            selectedOption.icon!,
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              selectedOption.label,
              style: theme.textStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return Text(
      widget.placeholder ?? '',
      style: theme.placeholderStyle,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildHelperText(ZephyrSelectTheme theme) {
    final text = _errorText ?? widget.helperText;
    final style =
        _errorText != null ? theme.errorTextStyle : theme.helperTextStyle;

    return Text(
      text ?? '',
      style: style,
    );
  }

  Widget _buildDropdown(ZephyrSelectTheme theme) {
    return Positioned(
      top: _getFieldHeight() + 4,
      left: 0,
      right: 0,
      child: Material(
        elevation: theme.elevation,
        borderRadius: theme.dropdownBorderRadius,
        shadowColor: theme.dropdownShadowColor,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: theme.maxDropdownHeight,
          ),
          decoration: BoxDecoration(
            color: theme.dropdownBackgroundColor,
            border: Border.all(
              color: theme.dropdownBorderColor,
              width: theme.borderWidth,
            ),
            borderRadius: theme.dropdownBorderRadius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.searchable) _buildSearchField(theme),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _filteredOptions.length,
                  itemBuilder: (context, index) {
                    final option = _filteredOptions[index];
                    return _buildOption(theme, option);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(ZephyrSelectTheme theme) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: const BorderSide(
            color: theme.dropdownBorderColor,
            width: theme.borderWidth,
          ),
        ),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: '搜索选项...',
          hintStyle: theme.placeholderStyle,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          prefixIcon: Icon(
            Icons.search,
            size: 16,
            color: theme.placeholderStyle.color,
          ),
        ),
        style: theme.optionTextStyle,
        onChanged: _handleSearch,
      ),
    );
  }

  Widget _buildOption(ZephyrSelectTheme theme, ZephyrSelectOption<T> option) {
    final isSelected = option.value == widget.value;
    final isDisabled = option.disabled;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : () => _handleOptionSelected(option.value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? theme.selectedOptionBackgroundColor : null,
          ),
          child: Row(
            children: [
              if (option.icon != null) ...[
                option.icon!,
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label,
                      style: isSelected
                          ? theme.selectedOptionTextStyle
                          : isDisabled
                              ? theme.optionTextStyle.copyWith(
                                  color: theme.optionTextStyle.color
                                      ?.withValues(alpha: 0.5),
                                )
                              : theme.optionTextStyle,
                    ),
                    if (option.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        option.description!,
                        style: theme.optionTextStyle.copyWith(
                          fontSize: 12,
                          color: theme.optionTextStyle.color
                              ?.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check,
                  size: 16,
                  color: theme.selectedOptionTextStyle.color,
                ),
            ],
          ),
        ),
      ),
    );
  }

  double _getFieldHeight() {
    switch (widget.size) {
      case ZephyrSize.xs:
        return 32.0;
      case ZephyrSize.sm:
        return 36.0;
      case ZephyrSize.md:
        return 40.0;
      case ZephyrSize.lg:
        return 44.0;
      case ZephyrSize.xl:
        return 48.0;
    }
  }
}
