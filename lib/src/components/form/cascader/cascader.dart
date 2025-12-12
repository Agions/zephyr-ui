/// VelocityUI 级联选择器组件
library velocity_cascader;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';
import '../input/input.dart';
import 'cascader_style.dart';

export 'cascader_style.dart';

/// 级联选择器节点数据结构
class VelocityCascaderNode {
  /// 创建级联选择器节点
  const VelocityCascaderNode({
    required this.value,
    required this.label,
    this.children = const [],
    this.disabled = false,
  });

  final String value;
  final String label;
  final List<VelocityCascaderNode> children;
  final bool disabled;
}

/// 级联选择器组件
class VelocityCascader extends StatefulWidget {
  /// 创建级联选择器组件
  const VelocityCascader({
    required this.options,
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefixIcon = Icons.keyboard_arrow_down,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.separator = '/',
    this.onChanged,
    this.onSelected,
    this.expandTrigger = VelocityCascaderExpandTrigger.click,
    this.maxHeight = 300,
    this.style,
  });

  /// 选项列表
  final List<VelocityCascaderNode> options;

  /// 控制器
  final TextEditingController? controller;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 标签文本
  final String? label;

  /// 提示文本
  final String? hint;

  /// 帮助文本
  final String? helper;

  /// 错误文本
  final String? error;

  /// 前缀图标
  final IconData? prefixIcon;

  /// 后缀图标
  final IconData? suffixIcon;

  /// 是否启用
  final bool enabled;

  /// 是否只读
  final bool readOnly;

  /// 分隔符
  final String separator;

  /// 文本改变回调
  final ValueChanged<String>? onChanged;

  /// 选中回调
  final ValueChanged<List<String>>? onSelected;

  /// 展开触发方式
  final VelocityCascaderExpandTrigger expandTrigger;

  /// 最大高度
  final double maxHeight;

  /// 样式
  final VelocityCascaderStyle? style;

  @override
  State<VelocityCascader> createState() => _VelocityCascaderState();
}

/// 级联选择器展开触发方式
enum VelocityCascaderExpandTrigger {
  /// 点击
  click,

  /// 悬停（仅桌面端有效）
  hover,
}

class _VelocityCascaderState extends State<VelocityCascader> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isExpanded = false;
  List<List<VelocityCascaderNode>> _columns = [];
  List<String> _selectedValues = [];
  List<String> _selectedLabels = [];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _columns = [widget.options];
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _columns = [widget.options];
        _selectedValues = [];
        _selectedLabels = [];
      }
    });
  }

  void _selectNode(int columnIndex, VelocityCascaderNode node) {
    setState(() {
      if (columnIndex == _columns.length - 1) {
        // 选择了最后一列
        _selectedValues.add(node.value);
        _selectedLabels.add(node.label);

        final selectedText = _selectedLabels.join(widget.separator);
        _controller.text = selectedText;
        widget.onChanged?.call(selectedText);
        widget.onSelected?.call(_selectedValues);

        _isExpanded = false;
      } else {
        // 选择了中间列，继续展开下一列
        _selectedValues = _selectedValues.sublist(0, columnIndex);
        _selectedLabels = _selectedLabels.sublist(0, columnIndex);
        _selectedValues.add(node.value);
        _selectedLabels.add(node.label);

        final newColumns = _columns.sublist(0, columnIndex + 1);
        if (node.children.isNotEmpty) {
          newColumns.add(node.children);
        }
        _columns = newColumns;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VelocityInput(
          controller: _controller,
          focusNode: _focusNode,
          label: widget.label,
          hint: widget.hint,
          helper: widget.helper,
          error: widget.error,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onTap: widget.enabled && !widget.readOnly ? _toggleExpanded : null,
          style: widget.style,
        ),
        if (_isExpanded) _buildDropdown(),
      ],
    );
  }

  Widget _buildDropdown() {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    return Positioned(
      left: offset.dx,
      top: offset.dy + size.height + 4,
      width: size.width,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: widget.maxHeight,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: VelocityColors.withOpacity(Colors.black, 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: _columns.asMap().entries.map((entry) {
              final index = entry.key;
              final column = entry.value;

              return Expanded(
                child: Container(
                  height: widget.maxHeight,
                  decoration: BoxDecoration(
                    border: index < _columns.length - 1
                        ? Border(right: BorderSide(color: Colors.grey.shade200))
                        : null,
                  ),
                  child: ListView.builder(
                    itemCount: column.length,
                    itemBuilder: (context, i) {
                      final node = column[i];
                      final isSelected = _selectedValues.length > index &&
                          _selectedValues[index] == node.value;

                      return InkWell(
                        onTap: node.disabled
                            ? null
                            : () => _selectNode(index, node),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.shade50
                                : Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                node.label,
                                style: TextStyle(
                                  color: node.disabled
                                      ? Colors.grey.shade400
                                      : isSelected
                                          ? Colors.blue
                                          : Colors.black87,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              if (node.children.isNotEmpty)
                                Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                  color: Colors.grey.shade400,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
