/// 轮播图类型定义
library carousel_types;

import 'package:flutter/material.dart';

/// 轮播图项目
class ZephyrCarouselItem {
  const ZephyrCarouselItem({
    required this.child,
    this.label,
    this.customIndicator,
    this.metadata,
  });
  final Widget child;
  final String? label;
  final Widget? customIndicator;
  final Map<String, dynamic>? metadata;
}

/// 指示器类型
enum ZephyrCarouselIndicatorType {
  /// 点状指示器
  dots,

  /// 数字指示器
  numbers,

  /// 分数指示器 (1/5)
  fraction,

  /// 自定义指示器
  custom,
}

/// 轮播图配置
class ZephyrCarouselConfig {
  const ZephyrCarouselConfig({
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.loop = true,
    this.showIndicator = true,
    this.indicatorType = ZephyrCarouselIndicatorType.dots,
    this.indicatorAlignment = Alignment.bottomCenter,
    this.showNavigationButtons = true,
    this.enableSwipe = true,
    this.aspectRatio,
    this.height,
    this.curve = Curves.easeInOut,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  /// 是否自动播放
  final bool autoPlay;

  /// 自动播放间隔
  final Duration autoPlayInterval;

  /// 自动播放动画时长
  final Duration autoPlayAnimationDuration;

  /// 是否循环播放
  final bool loop;

  /// 是否显示指示器
  final bool showIndicator;

  /// 指示器类型
  final ZephyrCarouselIndicatorType indicatorType;

  /// 指示器位置
  final AlignmentGeometry indicatorAlignment;

  /// 是否显示导航按钮
  final bool showNavigationButtons;

  /// 是否允许滑动切换
  final bool enableSwipe;

  /// 宽高比
  final double? aspectRatio;

  /// 高度
  final double? height;

  /// 页面切换动画曲线
  final Curve curve;

  /// 页面切换动画时长
  final Duration animationDuration;
}
