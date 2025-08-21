import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// ZephyrUI 轮播图主题配置
///
/// 提供轮播图的样式配置选项。
class ZephyrCarouselTheme {
  /// 导航按钮大小
  final double navigationButtonSize;
  
  /// 导航按钮图标大小
  final double navigationButtonIconSize;
  
  /// 导航按钮背景颜色
  final Color navigationButtonBackgroundColor;
  
  /// 导航按钮图标颜色
  final Color navigationButtonIconColor;
  
  /// 导航按钮阴影
  final List<BoxShadow>? navigationButtonShadow;
  
  /// 活动指示器大小
  final double activeIndicatorSize;
  
  /// 非活动指示器大小
  final double inactiveIndicatorSize;
  
  /// 活动指示器颜色
  final Color activeIndicatorColor;
  
  /// 非活动指示器颜色
  final Color inactiveIndicatorColor;
  
  /// 指示器背景颜色
  final Color indicatorBackgroundColor;
  
  /// 指示器文本样式
  final TextStyle indicatorTextStyle;
  
  /// 指示器间距
  final EdgeInsets indicatorSpacing;
  
  /// 指示器内边距
  final EdgeInsets indicatorPadding;

  /// 创建亮色主题
  const ZephyrCarouselTheme.light()
      : navigationButtonSize = 40,
        navigationButtonIconSize = 20,
        navigationButtonBackgroundColor = Colors.white,
        navigationButtonIconColor = Colors.black87,
        navigationButtonShadow = const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        activeIndicatorSize = 8,
        inactiveIndicatorSize = 6,
        activeIndicatorColor = const Color(0xFF3B82F6),
        inactiveIndicatorColor = const Color(0xFFD1D5DB),
        indicatorBackgroundColor = const Color(0x80000000),
        indicatorTextStyle = const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        indicatorSpacing = const EdgeInsets.symmetric(horizontal: 4),
        indicatorPadding = const EdgeInsets.all(16);

  /// 创建暗色主题
  const ZephyrCarouselTheme.dark()
      : navigationButtonSize = 40,
        navigationButtonIconSize = 20,
        navigationButtonBackgroundColor = const Color(0xFF1F2937),
        navigationButtonIconColor = Colors.white,
        navigationButtonShadow = const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        activeIndicatorSize = 8,
        inactiveIndicatorSize = 6,
        activeIndicatorColor = const Color(0xFF60A5FA),
        inactiveIndicatorColor = const Color(0xFF4B5563),
        indicatorBackgroundColor = const Color(0x80FFFFFF),
        indicatorTextStyle = const TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        indicatorSpacing = const EdgeInsets.symmetric(horizontal: 4),
        indicatorPadding = const EdgeInsets.all(16);

  /// 创建自定义主题
  const ZephyrCarouselTheme({
    required this.navigationButtonSize,
    required this.navigationButtonIconSize,
    required this.navigationButtonBackgroundColor,
    required this.navigationButtonIconColor,
    required this.navigationButtonShadow,
    required this.activeIndicatorSize,
    required this.inactiveIndicatorSize,
    required this.activeIndicatorColor,
    required this.inactiveIndicatorColor,
    required this.indicatorBackgroundColor,
    required this.indicatorTextStyle,
    required this.indicatorSpacing,
    required this.indicatorPadding,
  });

  /// 从上下文获取主题
  static ZephyrCarouselTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? const ZephyrCarouselTheme.dark() 
        : const ZephyrCarouselTheme.light();
  }

  /// 创建主题副本
  ZephyrCarouselTheme copyWith({
    double? navigationButtonSize,
    double? navigationButtonIconSize,
    Color? navigationButtonBackgroundColor,
    Color? navigationButtonIconColor,
    List<BoxShadow>? navigationButtonShadow,
    double? activeIndicatorSize,
    double? inactiveIndicatorSize,
    Color? activeIndicatorColor,
    Color? inactiveIndicatorColor,
    Color? indicatorBackgroundColor,
    TextStyle? indicatorTextStyle,
    EdgeInsets? indicatorSpacing,
    EdgeInsets? indicatorPadding,
  }) {
    return ZephyrCarouselTheme(
      navigationButtonSize: navigationButtonSize ?? this.navigationButtonSize,
      navigationButtonIconSize: navigationButtonIconSize ?? this.navigationButtonIconSize,
      navigationButtonBackgroundColor: navigationButtonBackgroundColor ?? this.navigationButtonBackgroundColor,
      navigationButtonIconColor: navigationButtonIconColor ?? this.navigationButtonIconColor,
      navigationButtonShadow: navigationButtonShadow ?? this.navigationButtonShadow,
      activeIndicatorSize: activeIndicatorSize ?? this.activeIndicatorSize,
      inactiveIndicatorSize: inactiveIndicatorSize ?? this.inactiveIndicatorSize,
      activeIndicatorColor: activeIndicatorColor ?? this.activeIndicatorColor,
      inactiveIndicatorColor: inactiveIndicatorColor ?? this.inactiveIndicatorColor,
      indicatorBackgroundColor: indicatorBackgroundColor ?? this.indicatorBackgroundColor,
      indicatorTextStyle: indicatorTextStyle ?? this.indicatorTextStyle,
      indicatorSpacing: indicatorSpacing ?? this.indicatorSpacing,
      indicatorPadding: indicatorPadding ?? this.indicatorPadding,
    );
  }

  /// 合并主题
  ZephyrCarouselTheme merge(ZephyrCarouselTheme other) {
    return copyWith(
      navigationButtonSize: other.navigationButtonSize,
      navigationButtonIconSize: other.navigationButtonIconSize,
      navigationButtonBackgroundColor: other.navigationButtonBackgroundColor,
      navigationButtonIconColor: other.navigationButtonIconColor,
      navigationButtonShadow: other.navigationButtonShadow,
      activeIndicatorSize: other.activeIndicatorSize,
      inactiveIndicatorSize: other.inactiveIndicatorSize,
      activeIndicatorColor: other.activeIndicatorColor,
      inactiveIndicatorColor: other.inactiveIndicatorColor,
      indicatorBackgroundColor: other.indicatorBackgroundColor,
      indicatorTextStyle: other.indicatorTextStyle,
      indicatorSpacing: other.indicatorSpacing,
      indicatorPadding: other.indicatorPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrCarouselTheme &&
        other.navigationButtonSize == navigationButtonSize &&
        other.navigationButtonIconSize == navigationButtonIconSize &&
        other.navigationButtonBackgroundColor == navigationButtonBackgroundColor &&
        other.navigationButtonIconColor == navigationButtonIconColor &&
        listEquals(other.navigationButtonShadow, navigationButtonShadow) &&
        other.activeIndicatorSize == activeIndicatorSize &&
        other.inactiveIndicatorSize == inactiveIndicatorSize &&
        other.activeIndicatorColor == activeIndicatorColor &&
        other.inactiveIndicatorColor == inactiveIndicatorColor &&
        other.indicatorBackgroundColor == indicatorBackgroundColor &&
        other.indicatorTextStyle == indicatorTextStyle &&
        other.indicatorSpacing == indicatorSpacing &&
        other.indicatorPadding == indicatorPadding;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      navigationButtonSize,
      navigationButtonIconSize,
      navigationButtonBackgroundColor,
      navigationButtonIconColor,
      ...navigationButtonShadow ?? [],
      activeIndicatorSize,
      inactiveIndicatorSize,
      activeIndicatorColor,
      inactiveIndicatorColor,
      indicatorBackgroundColor,
      indicatorTextStyle,
      indicatorSpacing,
      indicatorPadding,
    ]);
  }
}