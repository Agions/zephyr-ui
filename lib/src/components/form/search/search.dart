/// VelocityUI 搜索框组件
library velocity_search;

import 'package:flutter/material.dart';
import 'search_style.dart';

export 'search_style.dart';

/// VelocityUI 搜索框
class VelocitySearch extends StatefulWidget {
  const VelocitySearch({
    super.key,
    this.controller,
    this.placeholder = '搜索',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
    this.showCancelButton = false,
    this.cancelText = '取消',
    this.onCancel,
    this.style,
  });

  final TextEditingController? controller;
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool autofocus;
  final bool showCancelButton;
  final String cancelText;
  final VoidCallback? onCancel;
  final VelocitySearchStyle? style;

  @override
  State<VelocitySearch> createState() => _VelocitySearchState();
}

class _VelocitySearchState extends State<VelocitySearch> {
  late TextEditingController _controller;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() => setState(() => _showClear = _controller.text.isNotEmpty);

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocitySearchStyle();

    return Row(
      children: [
        Expanded(
          child: Container(
            height: effectiveStyle.height,
            decoration: BoxDecoration(
              color: effectiveStyle.backgroundColor,
              borderRadius: effectiveStyle.borderRadius,
              border: Border.all(color: effectiveStyle.borderColor),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: effectiveStyle.iconPadding),
                  child: Icon(Icons.search, size: effectiveStyle.iconSize, color: effectiveStyle.iconColor),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: widget.autofocus,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: widget.placeholder,
                      hintStyle: effectiveStyle.placeholderStyle,
                      border: InputBorder.none,
                      contentPadding: effectiveStyle.contentPadding,
                      isDense: true,
                    ),
                    style: effectiveStyle.textStyle,
                  ),
                ),
                if (_showClear)
                  GestureDetector(
                    onTap: _clear,
                    child: Padding(
                      padding: EdgeInsets.only(right: effectiveStyle.iconPadding),
                      child: Icon(Icons.cancel, size: effectiveStyle.clearIconSize, color: effectiveStyle.clearIconColor),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (widget.showCancelButton)
          GestureDetector(
            onTap: widget.onCancel,
            child: Padding(
              padding: EdgeInsets.only(left: effectiveStyle.cancelSpacing),
              child: Text(widget.cancelText, style: effectiveStyle.cancelStyle),
            ),
          ),
      ],
    );
  }
}
