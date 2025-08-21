import 'package:flutter/material.dart';
import 'statistic_theme.dart';

/// 统计卡片类型
enum ZephyrStatisticType {
  /// 主要统计
  primary,
  
  /// 成功统计
  success,
  
  /// 警告统计
  warning,
  
  /// 错误统计
  error,
  
  /// 信息统计
  info,
  
  /// 自定义统计
  custom,
}

/// 趋势方向
enum ZephyrStatisticTrend {
  /// 上升
  up,
  
  /// 下降
  down,
  
  /// 持平
  flat,
}

/// 统计卡片数据
class ZephyrStatisticData {
  /// 标题
  final String title;
  
  /// 数值
  final String value;
  
  /// 描述
  final String? description;
  
  /// 趋势值
  final String? trendValue;
  
  /// 趋势方向
  final ZephyrStatisticTrend? trend;
  
  /// 图标
  final Widget? icon;
  
  /// 创建统计卡片数据
  const ZephyrStatisticData({
    required this.title,
    required this.value,
    this.description,
    this.trendValue,
    this.trend,
    this.icon,
  });
}

/// ZephyrUI 统计卡片组件
///
/// 一个功能丰富的统计卡片组件，用于展示关键业务指标和数据趋势。
///
/// 特性：
/// - 多种统计类型（主要/成功/警告/错误/信息）
/// - 趋势指示器
/// - 自定义图标
/// - 响应式设计
/// - 动画效果
/// - 主题支持
///
/// 示例用法：
/// ```dart
/// ZephyrStatistic(
///   type: ZephyrStatisticType.primary,
///   title: '总收入',
///   value: '¥125,430',
///   description: '较上月增长',
///   trendValue: '12.5%',
///   trend: ZephyrStatisticTrend.up,
///   icon: Icons.trending_up,
/// )
/// ```
class ZephyrStatistic extends StatefulWidget {
  /// 统计卡片类型
  final ZephyrStatisticType type;
  
  /// 标题
  final String title;
  
  /// 数值
  final String value;
  
  /// 描述
  final String? description;
  
  /// 趋势值
  final String? trendValue;
  
  /// 趋势方向
  final ZephyrStatisticTrend? trend;
  
  /// 图标
  final Widget? icon;
  
  /// 自定义数据
  final dynamic data;
  
  /// 是否显示加载状态
  final bool loading;
  
  /// 是否显示边框
  final bool showBorder;
  
  /// 是否显示图标
  final bool showIcon;
  
  /// 是否显示趋势
  final bool showTrend;
  
  /// 卡片点击回调
  final VoidCallback? onTap;
  
  /// 主题数据
  final ZephyrStatisticTheme? theme;
  
  /// 创建统计卡片组件
  const ZephyrStatistic({
    Key? key,
    required this.title,
    required this.value,
    this.type = ZephyrStatisticType.primary,
    this.description,
    this.trendValue,
    this.trend,
    this.icon,
    this.data,
    this.loading = false,
    this.showBorder = true,
    this.showIcon = true,
    this.showTrend = true,
    this.onTap,
    this.theme,
  }) : super(key: key);

  @override
  State<ZephyrStatistic> createState() => _ZephyrStatisticState();
}

class _ZephyrStatisticState extends State<ZephyrStatistic> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late ZephyrStatisticTheme _theme;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _theme = widget.theme ?? ZephyrStatisticTheme.light();
    _animationController.forward();
  }

  @override
  void didUpdateWidget(ZephyrStatistic oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrStatisticTheme.light();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getTypeColor() {
    switch (widget.type) {
      case ZephyrStatisticType.primary:
        return _theme.primaryColor;
      case ZephyrStatisticType.success:
        return _theme.successColor;
      case ZephyrStatisticType.warning:
        return _theme.warningColor;
      case ZephyrStatisticType.error:
        return _theme.errorColor;
      case ZephyrStatisticType.info:
        return _theme.infoColor;
      case ZephyrStatisticType.custom:
        return _theme.primaryColor;
    }
  }

  IconData _getTrendIcon() {
    switch (widget.trend) {
      case ZephyrStatisticTrend.up:
        return Icons.trending_up;
      case ZephyrStatisticTrend.down:
        return Icons.trending_down;
      case ZephyrStatisticTrend.flat:
        return Icons.trending_flat;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor() {
    if (widget.trend == null) return _theme.trendStyle.color ?? Colors.grey;
    
    switch (widget.trend!) {
      case ZephyrStatisticTrend.up:
        return _theme.successColor;
      case ZephyrStatisticTrend.down:
        return _theme.errorColor;
      case ZephyrStatisticTrend.flat:
        return _theme.warningColor;
    }
  }

  Widget _buildTrendIndicator() {
    if (!widget.showTrend || widget.trendValue == null || widget.trend == null) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _getTrendIcon(),
          size: 14,
          color: _getTrendColor(),
        ),
        const SizedBox(width: 4),
        Text(
          widget.trendValue!,
          style: _theme.trendStyle.copyWith(
            color: _getTrendColor(),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    if (!widget.showIcon) return const SizedBox.shrink();

    final icon = widget.icon ?? Icon(
      _getDefaultIcon(),
      color: _getTypeColor(),
      size: _theme.iconSize,
    );

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getTypeColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: icon,
    );
  }

  IconData _getDefaultIcon() {
    switch (widget.type) {
      case ZephyrStatisticType.primary:
        return Icons.analytics;
      case ZephyrStatisticType.success:
        return Icons.check_circle;
      case ZephyrStatisticType.warning:
        return Icons.warning;
      case ZephyrStatisticType.error:
        return Icons.error;
      case ZephyrStatisticType.info:
        return Icons.info;
      case ZephyrStatisticType.custom:
        return Icons.dashboard;
    }
  }

  Widget _buildLoadingOverlay() {
    if (!widget.loading) return const SizedBox.shrink();

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.1),
          borderRadius: _theme.borderRadius,
        ),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_getTypeColor()),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                color: _theme.backgroundColor,
                borderRadius: _theme.borderRadius,
                border: widget.showBorder && _theme.showBorder
                    ? Border.all(
                        color: _theme.borderColor,
                        width: _theme.borderWidth,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: _theme.padding,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题和图标
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: _theme.titleStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _buildIcon(),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // 数值
                      Text(
                        widget.value,
                        style: _theme.valueStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // 描述和趋势
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.description != null)
                            Expanded(
                              child: Text(
                                widget.description!,
                                style: _theme.descriptionStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          _buildTrendIndicator(),
                        ],
                      ),
                    ],
                  ),
                  _buildLoadingOverlay(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 统计卡片组组件
class ZephyrStatisticGroup extends StatelessWidget {
  /// 统计卡片列表
  final List<ZephyrStatistic> statistics;
  
  /// 网格间距
  final double spacing;
  
  /// 运行间距
  final double runSpacing;
  
  /// 每行卡片数量
  final int crossAxisCount;
  
  /// 子组件比例
  final double childAspectRatio;
  
  /// 创建统计卡片组
  const ZephyrStatisticGroup({
    Key? key,
    required this.statistics,
    this.spacing = 16,
    this.runSpacing = 16,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final actualCrossAxisCount = constraints.maxWidth < 600 
            ? 1 
            : constraints.maxWidth < 900 
                ? 2 
                : constraints.maxWidth < 1200 
                    ? 3 
                    : crossAxisCount;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: actualCrossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: runSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: statistics.length,
          itemBuilder: (context, index) {
            return statistics[index];
          },
        );
      },
    );
  }
}