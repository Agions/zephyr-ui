/// ZephyrUI Tree Component
///
/// A hierarchical tree component with expand/collapse functionality,
/// selection support, and customizable styling.
library tree;

import 'package:flutter/material.dart';
import 'tree_theme.dart';

/// Tree node data
class ZephyrTreeNode<T> {
  const ZephyrTreeNode({
    required this.id,
    required this.label,
    this.data,
    this.icon,
    this.expandedIcon,
    this.collapsedIcon,
    this.children = const [],
    this.isExpanded = false,
    this.isSelected = false,
    this.isDisabled = false,
    this.customWidget,
    this.metadata,
  });

  /// Create a copy of the node with modified properties
  ZephyrTreeNode<T> copyWith({
    String? id,
    String? label,
    T? data,
    IconData? icon,
    IconData? expandedIcon,
    IconData? collapsedIcon,
    List<ZephyrTreeNode<T>>? children,
    bool? isExpanded,
    bool? isSelected,
    bool? isDisabled,
    Widget? customWidget,
    Map<String, dynamic>? metadata,
  }) {
    return ZephyrTreeNode<T>(
      id: id ?? this.id,
      label: label ?? this.label,
      data: data ?? this.data,
      icon: icon ?? this.icon,
      expandedIcon: expandedIcon ?? this.expandedIcon,
      collapsedIcon: collapsedIcon ?? this.collapsedIcon,
      children: children ?? this.children,
      isExpanded: isExpanded ?? this.isExpanded,
      isSelected: isSelected ?? this.isSelected,
      isDisabled: isDisabled ?? this.isDisabled,
      customWidget: customWidget ?? this.customWidget,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Check if the node has children
  bool get hasChildren => children.isNotEmpty;

  /// Unique identifier for the node
  final String id;

  /// Display label
  final String label;

  /// Data associated with the node
  final T? data;

  /// Icon for the node
  final IconData? icon;

  /// Expanded icon
  final IconData? expandedIcon;

  /// Collapsed icon
  final IconData? collapsedIcon;

  /// Child nodes
  final List<ZephyrTreeNode<T>> children;

  /// Whether the node is expanded
  final bool isExpanded;

  /// Whether the node is selected
  final bool isSelected;

  /// Whether the node is disabled
  final bool isDisabled;

  /// Custom widget for the node
  final Widget? customWidget;

  /// Additional metadata
  final Map<String, dynamic>? metadata;
}

/// Tree component
class ZephyrTree<T> extends StatefulWidget {
  /// Creates a tree component
  const ZephyrTree({
    required this.nodes,
    super.key,
    this.indentation = 24,
    this.nodeHeight = 32,
    this.iconSize = 16,
    this.showLines = true,
    this.showIcons = true,
    this.allowMultipleSelection = false,
    this.allowExpandCollapse = true,
    this.highlightSearchResults = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.enableAccessibilityFeatures = true,
    this.shrinkWrap = false,
    this.onNodeTap,
    this.onNodeExpand,
    this.onNodeCollapse,
    this.onNodeSelect,
    this.theme,
    this.scrollController,
    this.physics,
    this.expandIcon = Icons.keyboard_arrow_right,
    this.collapseIcon = Icons.keyboard_arrow_down,
    this.leafIcon,
    this.initialExpandedNodes = const [],
    this.initialSelectedNodes = const [],
    this.disabledNodes = const [],
    this.searchQuery,
    this.semanticLabel,
    this.padding,
  });

  /// Root nodes of the tree
  final List<ZephyrTreeNode<T>> nodes;

  /// Callback when a node is tapped
  final void Function(ZephyrTreeNode<T> node)? onNodeTap;

  /// Callback when a node is expanded
  final void Function(ZephyrTreeNode<T> node)? onNodeExpand;

  /// Callback when a node is collapsed
  final void Function(ZephyrTreeNode<T> node)? onNodeCollapse;

  /// Callback when a node is selected
  final void Function(ZephyrTreeNode<T> node)? onNodeSelect;

  /// Theme configuration
  final ZephyrTreeTheme? theme;

  /// Indentation for child nodes
  final double indentation;

  /// Height of each node
  final double nodeHeight;

  /// Size of icons
  final double iconSize;

  /// Icon for expandable nodes
  final IconData expandIcon;

  /// Icon for expanded nodes
  final IconData collapseIcon;

  /// Icon for leaf nodes
  final IconData? leafIcon;

  /// Show connecting lines
  final bool showLines;

  /// Show node icons
  final bool showIcons;

  /// Allow multiple selection
  final bool allowMultipleSelection;

  /// Allow expand/collapse
  final bool allowExpandCollapse;

  /// Initially expanded node IDs
  final List<String> initialExpandedNodes;

  /// Initially selected node IDs
  final List<String> initialSelectedNodes;

  /// Disabled node IDs
  final List<String> disabledNodes;

  /// Search query for filtering
  final String? searchQuery;

  /// Highlight search results
  final bool highlightSearchResults;

  /// Animation duration
  final Duration animationDuration;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Enable accessibility features
  final bool enableAccessibilityFeatures;

  /// Scroll controller
  final ScrollController? scrollController;

  /// Scroll physics
  final ScrollPhysics? physics;

  /// Shrink wrap content
  final bool shrinkWrap;

  /// Padding
  final EdgeInsets? padding;

  @override
  State<ZephyrTree<T>> createState() => _ZephyrTreeState<T>();
}

class _ZephyrTreeState<T> extends State<ZephyrTree<T>> {
  late List<ZephyrTreeNode<T>> _nodes;
  final Set<String> _expandedNodes = {};
  final Set<String> _selectedNodes = {};
  final Set<String> _disabledNodes = {};

  @override
  void initState() {
    super.initState();
    _nodes = widget.nodes;
    _expandedNodes.addAll(widget.initialExpandedNodes);
    _selectedNodes.addAll(widget.initialSelectedNodes);
    _disabledNodes.addAll(widget.disabledNodes);
  }

  @override
  void didUpdateWidget(ZephyrTree<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.nodes != widget.nodes) {
      _nodes = widget.nodes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredNodes = _filterNodes(_nodes);

    return Semantics(
      label: widget.semanticLabel ??
          'Tree view with ${filteredNodes.length} items',
      enabled: widget.enableAccessibilityFeatures,
      child: ListView.builder(
        controller: widget.scrollController,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        padding: widget.padding,
        itemCount: filteredNodes.length,
        itemBuilder: (context, index) {
          final node = filteredNodes[index];
          return _buildTreeNode(node, 0);
        },
      ),
    );
  }

  List<ZephyrTreeNode<T>> _filterNodes(List<ZephyrTreeNode<T>> nodes) {
    if (widget.searchQuery == null || widget.searchQuery!.isEmpty) {
      return nodes;
    }

    return nodes.where((node) => _nodeMatchesSearch(node)).toList();
  }

  bool _nodeMatchesSearch(ZephyrTreeNode<T> node) {
    final matches =
        node.label.toLowerCase().contains(widget.searchQuery!.toLowerCase());
    if (matches) return true;

    // Check children recursively
    return node.children.any((child) => _nodeMatchesSearch(child));
  }

  Widget _buildTreeNode(ZephyrTreeNode<T> node, int level) {
    final theme = widget.theme ?? ZephyrTreeTheme.of(context);
    final isExpanded = _expandedNodes.contains(node.id);
    final isSelected = _selectedNodes.contains(node.id);
    final isDisabled = _disabledNodes.contains(node.id) || node.isDisabled;
    final hasChildren = node.hasChildren;
    final isHighlighted = widget.searchQuery != null &&
        widget.highlightSearchResults &&
        node.label.toLowerCase().contains(widget.searchQuery!.toLowerCase());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNodeRow(
          node,
          level,
          isExpanded,
          isSelected,
          isDisabled,
          hasChildren,
          isHighlighted,
          theme,
        ),
        if (hasChildren && isExpanded)
          Padding(
            padding: EdgeInsets.only(left: widget.indentation),
            child: Column(
              children: node.children
                  .map((child) => _buildTreeNode(child, level + 1))
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildNodeRow(
    ZephyrTreeNode<T> node,
    int level,
    bool isExpanded,
    bool isSelected,
    bool isDisabled,
    bool hasChildren,
    bool isHighlighted,
    ZephyrTreeTheme theme,
  ) {
    var nodeContent =
        node.customWidget ?? _buildDefaultNodeContent(node, theme);

    // Add highlight if needed
    if (isHighlighted) {
      nodeContent = Container(
        decoration: BoxDecoration(
          color: theme.highlightColor.withAlpha(77),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: nodeContent,
      );
    }

    // Add selection styling
    if (isSelected) {
      nodeContent = Container(
        decoration: BoxDecoration(
          color: theme.selectedColor.withAlpha(26),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(
            color: theme.selectedColor,
            width: 1,
          ),
        ),
        child: nodeContent,
      );
    }

    // Add disabled styling
    if (isDisabled) {
      nodeContent = Opacity(
        opacity: 0.5,
        child: nodeContent,
      );
    }

    // Make interactive if not disabled
    if (!isDisabled) {
      nodeContent = InkWell(
        onTap: () => _handleNodeTap(node),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: nodeContent,
      );
    }

    // Add indentation
    return Padding(
      padding: EdgeInsets.only(left: level * widget.indentation),
      child: SizedBox(
        height: widget.nodeHeight,
        child: Row(
          children: [
            // Expand/collapse button
            if (hasChildren && widget.allowExpandCollapse)
              _buildExpandCollapseButton(node, isExpanded, theme),
            if (hasChildren && widget.allowExpandCollapse)
              const SizedBox(width: 8),
            // Node icon
            if (widget.showIcons && node.icon != null)
              Icon(
                node.icon,
                size: widget.iconSize,
                color: theme.iconColor,
              ),
            if (widget.showIcons && node.icon != null) const SizedBox(width: 8),
            // Node content
            Expanded(
              child: DefaultTextStyle(
                style: isSelected
                    ? theme.selectedTextStyle
                    : (isDisabled ? theme.disabledTextStyle : theme.textStyle),
                child: nodeContent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultNodeContent(
      ZephyrTreeNode<T> node, ZephyrTreeTheme theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            node.label,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (node.metadata != null && node.metadata!['badge'] != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: theme.badgeColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              node.metadata!['badge'].toString(),
              style: theme.badgeTextStyle,
            ),
          ),
      ],
    );
  }

  Widget _buildExpandCollapseButton(
    ZephyrTreeNode<T> node,
    bool isExpanded,
    ZephyrTreeTheme theme,
  ) {
    return GestureDetector(
      onTap: () => _handleExpandCollapse(node),
      child: Icon(
        isExpanded ? widget.collapseIcon : widget.expandIcon,
        size: widget.iconSize,
        color: theme.expandCollapseColor,
      ),
    );
  }

  void _handleNodeTap(ZephyrTreeNode<T> node) {
    widget.onNodeTap?.call(node);

    // Handle selection
    if (!widget.allowMultipleSelection) {
      _selectedNodes.clear();
    }

    if (_selectedNodes.contains(node.id)) {
      _selectedNodes.remove(node.id);
    } else {
      _selectedNodes.add(node.id);
    }

    widget.onNodeSelect?.call(node);
    setState(() {});
  }

  void _handleExpandCollapse(ZephyrTreeNode<T> node) {
    if (_expandedNodes.contains(node.id)) {
      _expandedNodes.remove(node.id);
      widget.onNodeCollapse?.call(node);
    } else {
      _expandedNodes.add(node.id);
      widget.onNodeExpand?.call(node);
    }
    setState(() {});
  }
}

/// Tree view controller for managing tree state
class ZephyrTreeController<T> {
  ZephyrTreeController(this._nodes);

  /// Get the current nodes
  List<ZephyrTreeNode<T>> get nodes => _nodes;

  final List<ZephyrTreeNode<T>> _nodes;
  final Set<String> _expandedNodes = {};
  final Set<String> _selectedNodes = {};

  /// Expand a node
  void expandNode(String nodeId) {
    _expandedNodes.add(nodeId);
  }

  /// Collapse a node
  void collapseNode(String nodeId) {
    _expandedNodes.remove(nodeId);
  }

  /// Toggle node expansion
  void toggleNode(String nodeId) {
    if (_expandedNodes.contains(nodeId)) {
      _expandedNodes.remove(nodeId);
    } else {
      _expandedNodes.add(nodeId);
    }
  }

  /// Select a node
  void selectNode(String nodeId, {bool multiple = false}) {
    if (!multiple) {
      _selectedNodes.clear();
    }
    _selectedNodes.add(nodeId);
  }

  /// Deselect a node
  void deselectNode(String nodeId) {
    _selectedNodes.remove(nodeId);
  }

  /// Get expanded nodes
  Set<String> get expandedNodes => _expandedNodes;

  /// Get selected nodes
  Set<String> get selectedNodes => _selectedNodes;

  /// Find node by ID
  ZephyrTreeNode<T>? findNode(String nodeId) {
    return _findNodeRecursive(_nodes, nodeId);
  }

  ZephyrTreeNode<T>? _findNodeRecursive(
      List<ZephyrTreeNode<T>> nodes, String nodeId) {
    for (final node in nodes) {
      if (node.id == nodeId) {
        return node;
      }
      final found = _findNodeRecursive(node.children, nodeId);
      if (found != null) {
        return found;
      }
    }
    return null;
  }
}
