import 'package:flutter/material.dart';
import 'timeline_theme.dart';

/// 时间线节点类型
enum ZephyrTimelineNodeStatus {
  /// 等待中
  pending,
  
  /// 进行中
  processing,
  
  /// 已完成
  completed,
  
  /// 已失败
  failed,
  
  /// 已取消
  cancelled,
  
  /// 自定义
  custom,
}

/// 时间线节点
class ZephyrTimelineNode {
  /// 节点ID
  final String id;
  
  /// 节点标题
  final String title;
  
  /// 节点描述
  final String? description;
  
  /// 节点状态
  final ZephyrTimelineNodeStatus status;
  
  /// 节点时间
  final DateTime? time;
  
  /// 节点图标
  final Widget? icon;
  
  /// 节点颜色
  final Color? color;
  
  /// 自定义内容
  final Widget? content;
  
  /// 附加信息
  final String? extra;
  
  /// 是否可点击
  final bool clickable;
  
  /// 自定义数据
  final dynamic data;
  
  /// 创建时间线节点
  const ZephyrTimelineNode({
    required this.id,
    required this.title,
    this.description,
    this.status = ZephyrTimelineNodeStatus.pending,
    this.time,
    this.icon,
    this.color,
    this.content,
    this.extra,
    this.clickable = false,
    this.data,
  });
}

/// 时间线模式
enum ZephyrTimelineMode {
  /// 垂直模式
  vertical,
  
  /// 水平模式
  horizontal,
  
  /// 交替模式
  alternate,
}

/// 时间线布局
enum ZephyrTimelineLayout {
  /// 左对齐
  left,
  
  /// 右对齐
  right,
  
  /// 交替
  alternate,
  
  /// 居中
  center,
}

/// ZephyrUI 时间线组件
///
/// 一个功能丰富的时间线组件，支持多种布局模式和节点状态展示。
///
/// 特性：
/// - 多种布局模式（垂直/水平/交替）
/// - 丰富的节点状态
/// - 自定义节点样式
/// - 时间显示
/// - 动画效果
/// - 响应式设计
/// - 节点交互
///
/// 示例用法：
/// ```dart
/// ZephyrTimeline(
///   nodes: [
///     ZephyrTimelineNode(
///       id: '1',
///       title: '项目启动',
///       description: '项目正式启动',
///       status: ZephyrTimelineNodeStatus.completed,
///       time: DateTime(2024, 1, 1),
///     ),
///     ZephyrTimelineNode(
///       id: '2',
///       title: '需求分析',
///       description: '完成需求分析文档',
///       status: ZephyrTimelineNodeStatus.processing,
///       time: DateTime(2024, 1, 15),
///     ),
///   ],
///   onNodeTap: (node) => print('点击节点: ${node.title}'),
/// )
/// ```
class ZephyrTimeline extends StatefulWidget {
  /// 时间线节点
  final List<ZephyrTimelineNode> nodes;
  
  /// 时间线模式
  final ZephyrTimelineMode mode;
  
  /// 时间线布局
  final ZephyrTimelineLayout layout;
  
  /// 是否显示时间
  final bool showTime;
  
  /// 是否显示连接线
  final bool showConnector;
  
  /// 是否反向排列
  final bool reverse;
  
  /// 节点间距
  final double nodeSpacing;
  
  /// 节点大小
  final double nodeSize;
  
  /// 线条粗细
  final double lineWidth;
  
  /// 是否动画
  final bool animated;
  
  /// 动画持续时间
  final Duration animationDuration;
  
  /// 主题数据
  final ZephyrTimelineTheme? theme;
  
  /// 节点点击回调
  final Function(ZephyrTimelineNode node)? onNodeTap;
  
  /// 节点长按回调
  final Function(ZephyrTimelineNode node)? onNodeLongPress;
  
  /// 创建时间线组件
  const ZephyrTimeline({
    Key? key,
    required this.nodes,
    this.mode = ZephyrTimelineMode.vertical,
    this.layout = ZephyrTimelineLayout.left,
    this.showTime = true,
    this.showConnector = true,
    this.reverse = false,
    this.nodeSpacing = 40.0,
    this.nodeSize = 24.0,
    this.lineWidth = 2.0,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.theme,
    this.onNodeTap,
    this.onNodeLongPress,
  }) : super(key: key);

  @override
  State<ZephyrTimeline> createState() => _ZephyrTimelineState();
}

class _ZephyrTimelineState extends State<ZephyrTimeline> {
  late ZephyrTimelineTheme _theme;
  late List<ZephyrTimelineNode> _nodes;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrTimelineTheme.light();
    _nodes = widget.reverse ? widget.nodes.reversed.toList() : List.from(widget.nodes);
  }

  @override
  void didUpdateWidget(ZephyrTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrTimelineTheme.light();
    }
    if (widget.nodes != oldWidget.nodes) {
      _nodes = widget.reverse ? widget.nodes.reversed.toList() : List.from(widget.nodes);
    }
  }

  void _handleNodeTap(ZephyrTimelineNode node) {
    if (!node.clickable) return;
    widget.onNodeTap?.call(node);
  }

  void _handleNodeLongPress(ZephyrTimelineNode node) {
    widget.onNodeLongPress?.call(node);
  }

  Widget _buildNodeIcon(ZephyrTimelineNode node) {
    Color nodeColor;
    IconData iconData;
    
    switch (node.status) {
      case ZephyrTimelineNodeStatus.pending:
        nodeColor = node.color ?? _theme.pendingColor;
        iconData = Icons.circle_outlined;
        break;
      case ZephyrTimelineNodeStatus.processing:
        nodeColor = node.color ?? _theme.processingColor;
        iconData = Icons.autorenew;
        break;
      case ZephyrTimelineNodeStatus.completed:
        nodeColor = node.color ?? _theme.completedColor;
        iconData = Icons.check_circle;
        break;
      case ZephyrTimelineNodeStatus.failed:
        nodeColor = node.color ?? _theme.failedColor;
        iconData = Icons.error;
        break;
      case ZephyrTimelineNodeStatus.cancelled:
        nodeColor = node.color ?? _theme.cancelledColor;
        iconData = Icons.cancel;
        break;
      case ZephyrTimelineNodeStatus.custom:
        nodeColor = node.color ?? _theme.primaryColor;
        iconData = Icons.circle;
        break;
    }
    
    return Container(
      width: widget.nodeSize,
      height: widget.nodeSize,
      decoration: BoxDecoration(
        color: nodeColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: nodeColor,
          width: 2,
        ),
      ),
      child: node.icon ?? Icon(
        iconData,
        color: nodeColor,
        size: widget.nodeSize * 0.6,
      ),
    );
  }

  Widget _buildNodeContent(ZephyrTimelineNode node) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题
        Text(
          node.title,
          style: _theme.titleStyle.copyWith(
            color: node.status == ZephyrTimelineNodeStatus.failed
                ? _theme.failedColor
                : _theme.titleStyle.color,
          ),
        ),
        
        // 描述
        if (node.description != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              node.description!,
              style: _theme.descriptionStyle,
            ),
          ),
        
        // 时间
        if (widget.showTime && node.time != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _formatDateTime(node.time!),
              style: _theme.timeStyle,
            ),
          ),
        
        // 附加信息
        if (node.extra != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              node.extra!,
              style: _theme.extraStyle,
            ),
          ),
        
        // 自定义内容
        if (node.content != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: node.content!,
          ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays == 0) {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return '昨天 ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    }
  }

  Widget _buildVerticalTimeline() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _nodes.length,
      itemBuilder: (context, index) {
        final node = _nodes[index];
        final isLast = index == _nodes.length - 1;
        
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : widget.nodeSpacing),
          child: _buildVerticalNode(node, isLast),
        );
      },
    );
  }

  Widget _buildVerticalNode(ZephyrTimelineNode node, bool isLast) {
    Widget nodeContent;
    
    switch (widget.layout) {
      case ZephyrTimelineLayout.left:
        nodeContent = _buildLeftLayoutNode(node, isLast);
        break;
      case ZephyrTimelineLayout.right:
        nodeContent = _buildRightLayoutNode(node, isLast);
        break;
      case ZephyrTimelineLayout.alternate:
        nodeContent = _buildAlternateLayoutNode(node, isLast);
        break;
      case ZephyrTimelineLayout.center:
        nodeContent = _buildCenterLayoutNode(node, isLast);
        break;
    }
    
    return AnimatedSwitcher(
      duration: widget.animationDuration,
      child: nodeContent,
    );
  }

  Widget _buildLeftLayoutNode(ZephyrTimelineNode node, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 节点图标
        GestureDetector(
          onTap: () => _handleNodeTap(node),
          onLongPress: () => _handleNodeLongPress(node),
          child: _buildNodeIcon(node),
        ),
        
        const SizedBox(width: 16),
        
        // 连接线
        if (widget.showConnector && !isLast)
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: widget.nodeSize / 2),
              height: widget.lineWidth,
              color: _theme.connectorColor,
            ),
          )
        else
          const SizedBox(width: 16),
        
        const SizedBox(width: 16),
        
        // 节点内容
        Expanded(
          flex: 3,
          child: _buildNodeContent(node),
        ),
      ],
    );
  }

  Widget _buildRightLayoutNode(ZephyrTimelineNode node, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 节点内容
        Expanded(
          flex: 3,
          child: _buildNodeContent(node),
        ),
        
        const SizedBox(width: 16),
        
        // 连接线
        if (widget.showConnector && !isLast)
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: widget.nodeSize / 2),
              height: widget.lineWidth,
              color: _theme.connectorColor,
            ),
          )
        else
          const SizedBox(width: 16),
        
        const SizedBox(width: 16),
        
        // 节点图标
        GestureDetector(
          onTap: () => _handleNodeTap(node),
          onLongPress: () => _handleNodeLongPress(node),
          child: _buildNodeIcon(node),
        ),
      ],
    );
  }

  Widget _buildAlternateLayoutNode(ZephyrTimelineNode node, bool isLast) {
    final index = _nodes.indexOf(node);
    final isLeft = index % 2 == 0;
    
    return isLeft 
        ? _buildLeftLayoutNode(node, isLast)
        : _buildRightLayoutNode(node, isLast);
  }

  Widget _buildCenterLayoutNode(ZephyrTimelineNode node, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 节点内容（左侧）
        Expanded(
          child: _buildNodeContent(node),
        ),
        
        const SizedBox(width: 16),
        
        // 节点图标
        GestureDetector(
          onTap: () => _handleNodeTap(node),
          onLongPress: () => _handleNodeLongPress(node),
          child: _buildNodeIcon(node),
        ),
        
        const SizedBox(width: 16),
        
        // 连接线
        if (widget.showConnector && !isLast)
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: widget.nodeSize / 2),
              height: widget.lineWidth,
              color: _theme.connectorColor,
            ),
          )
        else
          const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHorizontalTimeline() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _nodes.asMap().entries.map((entry) {
          final index = entry.key;
          final node = entry.value;
          final isLast = index == _nodes.length - 1;
          
          return Row(
            children: [
              // 节点
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _handleNodeTap(node),
                    onLongPress: () => _handleNodeLongPress(node),
                    child: _buildNodeIcon(node),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 100,
                    child: Text(
                      node.title,
                      style: _theme.titleStyle,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              
              // 连接线
              if (!isLast && widget.showConnector) ...[
                Container(
                  width: 40,
                  height: widget.lineWidth,
                  color: _theme.connectorColor,
                ),
              ],
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: _theme.borderRadius,
        border: Border.all(
          color: _theme.borderColor,
          width: _theme.borderWidth,
        ),
      ),
      padding: _theme.padding,
      child: widget.mode == ZephyrTimelineMode.vertical
          ? _buildVerticalTimeline()
          : _buildHorizontalTimeline(),
    );
  }
}