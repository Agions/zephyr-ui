/// VelocityUI 树形组件
library velocity_tree;

import 'package:flutter/material.dart';
import 'tree_style.dart';

export 'tree_style.dart';

/// 树形节点数据结构
class VelocityTreeNode {
  /// 创建树形节点
  const VelocityTreeNode({
    required this.key,
    required this.title,
    this.children = const [],
    this.icon,
    this.disabled = false,
    this.expanded = false,
    this.checked = false,
    this.isLeaf = false,
    this.data,
  });

  /// 节点唯一标识
  final String key;

  /// 节点标题
  final String title;

  /// 子节点列表
  final List<VelocityTreeNode> children;

  /// 节点图标
  final IconData? icon;

  /// 是否禁用
  final bool disabled;

  /// 是否展开
  final bool expanded;

  /// 是否选中
  final bool checked;

  /// 是否为叶子节点
  final bool isLeaf;

  /// 附加数据
  final dynamic data;

  /// 复制节点并替换指定属性
  VelocityTreeNode copyWith({
    String? key,
    String? title,
    List<VelocityTreeNode>? children,
    IconData? icon,
    bool? disabled,
    bool? expanded,
    bool? checked,
    bool? isLeaf,
    dynamic data,
  }) {
    return VelocityTreeNode(
      key: key ?? this.key,
      title: title ?? this.title,
      children: children ?? this.children,
      icon: icon ?? this.icon,
      disabled: disabled ?? this.disabled,
      expanded: expanded ?? this.expanded,
      checked: checked ?? this.checked,
      isLeaf: isLeaf ?? this.isLeaf,
      data: data ?? this.data,
    );
  }
}

/// 树形组件
class VelocityTree extends StatefulWidget {
  /// 创建树形组件
  const VelocityTree({
    required this.data,
    super.key,
    this.onNodeClick,
    this.onNodeExpand,
    this.onNodeCheck,
    this.expandAll = false,
    this.checkable = false,
    this.selectable = true,
    this.showLines = true,
    this.defaultExpandedKeys = const [],
    this.defaultCheckedKeys = const [],
    this.defaultSelectedKeys = const [],
    this.style,
  });

  /// 树形数据
  final List<VelocityTreeNode> data;

  /// 节点点击回调
  final ValueChanged<VelocityTreeNode>? onNodeClick;

  /// 节点展开回调
  final ValueChanged<VelocityTreeNode>? onNodeExpand;

  /// 节点选中回调
  final ValueChanged<Set<String>>? onNodeCheck;

  /// 是否展开所有节点
  final bool expandAll;

  /// 是否支持复选
  final bool checkable;

  /// 是否支持选择
  final bool selectable;

  /// 是否显示连接线
  final bool showLines;

  /// 默认展开的节点 key 列表
  final List<String> defaultExpandedKeys;

  /// 默认选中的节点 key 列表
  final List<String> defaultCheckedKeys;

  /// 默认选中的节点 key 列表
  final List<String> defaultSelectedKeys;

  /// 样式
  final VelocityTreeStyle? style;

  @override
  State<VelocityTree> createState() => _VelocityTreeState();
}

class _VelocityTreeState extends State<VelocityTree> {
  late List<VelocityTreeNode> _data;
  late Set<String> _expandedKeys;
  late Set<String> _checkedKeys;
  late Set<String> _selectedKeys;
  late VelocityTreeStyle _style;

  @override
  void initState() {
    super.initState();
    _style = widget.style ?? VelocityTreeStyle.defaults();
    _expandedKeys = widget.defaultExpandedKeys.toSet();
    _checkedKeys = widget.defaultCheckedKeys.toSet();
    _selectedKeys = widget.defaultSelectedKeys.toSet();
    _data = widget.data;

    if (widget.expandAll) {
      _expandAllNodes();
    }
  }

  void _expandAllNodes() {
    void expandNode(List<VelocityTreeNode> nodes) {
      for (final node in nodes) {
        _expandedKeys.add(node.key);
        if (node.children.isNotEmpty) {
          expandNode(node.children);
        }
      }
    }

    expandNode(_data);
  }

  void _toggleExpand(String key) {
    setState(() {
      if (_expandedKeys.contains(key)) {
        _expandedKeys.remove(key);
      } else {
        _expandedKeys.add(key);
      }
    });
  }

  void _toggleCheck(String key) {
    setState(() {
      if (_checkedKeys.contains(key)) {
        _checkedKeys.remove(key);
      } else {
        _checkedKeys.add(key);
      }
      widget.onNodeCheck?.call(_checkedKeys);
    });
  }

  void _toggleSelect(String key) {
    setState(() {
      if (_selectedKeys.contains(key)) {
        _selectedKeys.remove(key);
      } else {
        _selectedKeys = {key};
      }
    });
  }

  List<Widget> _renderNodes(List<VelocityTreeNode> nodes, int level) {
    final result = <Widget>[];

    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final isLast = i == nodes.length - 1;
      final isExpanded = _expandedKeys.contains(node.key);
      final isChecked = _checkedKeys.contains(node.key);
      final isSelected = _selectedKeys.contains(node.key);

      result.add(_renderNode(
        node,
        level,
        isLast,
        isExpanded,
        isChecked,
        isSelected,
      ));

      if (isExpanded && node.children.isNotEmpty) {
        result.addAll(_renderNodes(node.children, level + 1));
      }
    }

    return result;
  }

  Widget _renderNode(
    VelocityTreeNode node,
    int level,
    bool isLast,
    bool isExpanded,
    bool isChecked,
    bool isSelected,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: level * _style.indent),
      child: InkWell(
        onTap: node.disabled
            ? null
            : () {
                widget.onNodeClick?.call(node);
                if (widget.selectable) {
                  _toggleSelect(node.key);
                }
                if (!node.isLeaf &&
                    (node.children.isNotEmpty || !node.isLeaf)) {
                  _toggleExpand(node.key);
                  widget.onNodeExpand?.call(node);
                }
              },
        child: Container(
          padding: _style.nodePadding,
          decoration: BoxDecoration(
            color: isSelected
                ? _style.selectedBackgroundColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              if (widget.showLines && level > 0) ...[
                _buildLine(level, isLast),
              ],
              if (!node.isLeaf &&
                  (node.children.isNotEmpty || !node.isLeaf)) ...[
                InkWell(
                  onTap: node.disabled
                      ? null
                      : () {
                          _toggleExpand(node.key);
                          widget.onNodeExpand?.call(node);
                        },
                  child: Icon(
                    isExpanded ? _style.collapseIcon : _style.expandIcon,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 4),
              ] else if (widget.showLines) ...[
                const SizedBox(width: 20),
              ],
              if (widget.checkable) ...[
                Checkbox(
                  value: isChecked,
                  onChanged: node.disabled
                      ? null
                      : (value) {
                          _toggleCheck(node.key);
                        },
                  activeColor: _style.checkboxColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const SizedBox(width: 4),
              ],
              if (node.icon != null) ...[
                Icon(
                  node.icon,
                  size: 16,
                  color: node.disabled ? Colors.grey.shade400 : null,
                ),
                const SizedBox(width: 4),
              ],
              Expanded(
                child: Text(
                  node.title,
                  style: node.disabled
                      ? TextStyle(color: Colors.grey.shade400)
                      : isSelected
                          ? _style.selectedTextStyle ??
                              TextStyle(
                                color: _style.checkboxColor,
                                fontWeight: FontWeight.bold,
                              )
                          : _style.textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLine(int level, bool isLast) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Stack(
        children: [
          // 竖线
          if (!isLast)
            Positioned(
              left: 10,
              top: 0,
              bottom: -20,
              width: _style.lineWidth,
              child: Container(color: _style.lineColor),
            ),
          // 横线
          Positioned(
            left: 0,
            top: 10,
            right: 0,
            width: 10 - _style.lineWidth / 2,
            height: _style.lineWidth,
            child: Container(color: _style.lineColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: _renderNodes(_data, 0),
    );
  }
}

/// 可选择的树形组件
class VelocitySelectableTree extends StatelessWidget {
  /// 创建可选择的树形组件
  const VelocitySelectableTree({
    required this.data,
    super.key,
    this.onSelect,
    this.selectedKey,
    this.style,
  });

  /// 树形数据
  final List<VelocityTreeNode> data;

  /// 选择回调
  final ValueChanged<VelocityTreeNode>? onSelect;

  /// 当前选中的节点 key
  final String? selectedKey;

  /// 样式
  final VelocityTreeStyle? style;

  @override
  Widget build(BuildContext context) {
    return VelocityTree(
      data: data,
      onNodeClick: onSelect,
      selectable: true,
      checkable: false,
      defaultSelectedKeys: selectedKey != null ? [selectedKey!] : [],
      style: style,
    );
  }
}

/// 可复选的树形组件
class VelocityCheckableTree extends StatelessWidget {
  /// 创建可复选的树形组件
  const VelocityCheckableTree({
    required this.data,
    super.key,
    this.onCheck,
    this.checkedKeys = const <String>{},
    this.style,
  });

  /// 树形数据
  final List<VelocityTreeNode> data;

  /// 复选回调
  final ValueChanged<Set<String>>? onCheck;

  /// 当前选中的节点 key 列表
  final Set<String> checkedKeys;

  /// 样式
  final VelocityTreeStyle? style;

  @override
  Widget build(BuildContext context) {
    return VelocityTree(
      data: data,
      onNodeCheck: onCheck,
      checkable: true,
      selectable: false,
      defaultCheckedKeys: checkedKeys.toList(),
      style: style,
    );
  }
}
