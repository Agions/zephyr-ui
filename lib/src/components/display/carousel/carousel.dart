import 'dart:async';
import 'package:flutter/material.dart';
import 'carousel_theme.dart';
import 'carousel_types.dart';

/// ZephyrUI 轮播图组件
///
/// 提供功能丰富的轮播图组件，支持自动播放、手动切换、指示器等功能。
///
/// 示例用法:
/// ```dart
/// ZephyrCarousel(
///   items: [
///     ZephyrCarouselItem(
///       child: Image.asset('assets/image1.jpg'),
///       label: '图片 1',
///     ),
///     ZephyrCarouselItem(
///       child: Image.asset('assets/image2.jpg'),
///       label: '图片 2',
///     ),
///   ],
///   config: const ZephyrCarouselConfig(
///     autoPlay: true,
///     autoPlayInterval: Duration(seconds: 3),
///   ),
/// )
/// ```
class ZephyrCarousel extends StatefulWidget {
  const ZephyrCarousel({
    required this.items,
    super.key,
    this.config = const ZephyrCarouselConfig(),
    this.theme,
    this.onPageChanged,
  });

  /// 轮播图项目
  final List<ZephyrCarouselItem> items;

  /// 轮播图配置
  final ZephyrCarouselConfig config;

  /// 轮播图主题
  final ZephyrCarouselTheme? theme;

  /// 页面变化回调
  final Function(int index)? onPageChanged;

  @override
  State<ZephyrCarousel> createState() => _ZephyrCarouselState();
}

class _ZephyrCarouselState extends State<ZephyrCarousel> {
  late PageController _pageController;
  late int _currentIndex;
  Timer? _autoPlayTimer;
  bool _isUserInteracting = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController = PageController();

    if (widget.config.autoPlay) {
      _startAutoPlay();
    }
  }

  @override
  void didUpdateWidget(ZephyrCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.autoPlay != widget.config.autoPlay) {
      if (widget.config.autoPlay) {
        _startAutoPlay();
      } else {
        _stopAutoPlay();
      }
    }
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  /// 开始自动播放
  void _startAutoPlay() {
    _stopAutoPlay();
    _autoPlayTimer = Timer.periodic(
      widget.config.autoPlayInterval,
      (timer) {
        if (!_isUserInteracting && widget.items.length > 1) {
          _nextPage();
        }
      },
    );
  }

  /// 停止自动播放
  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  /// 下一页
  void _nextPage() {
    if (_pageController.hasClients) {
      if (_currentIndex < widget.items.length - 1) {
        _pageController.nextPage(
          duration: widget.config.animationDuration,
          curve: widget.config.curve,
        );
      } else if (widget.config.loop) {
        _pageController.animateToPage(
          0,
          duration: widget.config.animationDuration,
          curve: widget.config.curve,
        );
      }
    }
  }

  /// 上一页
  void _previousPage() {
    if (_pageController.hasClients) {
      if (_currentIndex > 0) {
        _pageController.previousPage(
          duration: widget.config.animationDuration,
          curve: widget.config.curve,
        );
      } else if (widget.config.loop) {
        _pageController.animateToPage(
          widget.items.length - 1,
          duration: widget.config.animationDuration,
          curve: widget.config.curve,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? ZephyrCarouselTheme.of(context);

    return SizedBox(
      height: widget.config.height,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildPageView(),
                _buildNavigationButtons(effectiveTheme),
              ],
            ),
          ),
          if (widget.config.showIndicator) _buildIndicator(effectiveTheme),
        ],
      ),
    );
  }

  /// 构建页面视图
  Widget _buildPageView() {
    return GestureDetector(
      onTapDown: (_) {
        _isUserInteracting = true;
        if (widget.config.autoPlay) {
          _stopAutoPlay();
        }
      },
      onTapUp: (_) {
        _isUserInteracting = false;
        if (widget.config.autoPlay) {
          _startAutoPlay();
        }
      },
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.config.loop ? null : widget.items.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index % widget.items.length;
          });
          widget.onPageChanged?.call(_currentIndex);
        },
        allowImplicitScrolling: widget.config.enableSwipe,
        physics: widget.config.enableSwipe
            ? const PageScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final itemIndex =
              widget.config.loop ? index % widget.items.length : index;
          return widget.items[itemIndex].child;
        },
      ),
    );
  }

  /// 构建导航按钮
  Widget _buildNavigationButtons(ZephyrCarouselTheme theme) {
    if (!widget.config.showNavigationButtons || widget.items.length <= 1) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        // 上一页按钮
        Positioned(
          left: 8,
          top: 0,
          bottom: 0,
          child: Center(
            child: _buildNavigationButton(
              icon: Icons.chevron_left,
              onPressed: _previousPage,
              theme: theme,
            ),
          ),
        ),
        // 下一页按钮
        Positioned(
          right: 8,
          top: 0,
          bottom: 0,
          child: Center(
            child: _buildNavigationButton(
              icon: Icons.chevron_right,
              onPressed: _nextPage,
              theme: theme,
            ),
          ),
        ),
      ],
    );
  }

  /// 构建单个导航按钮
  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onPressed,
    required ZephyrCarouselTheme theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.navigationButtonBackgroundColor,
        shape: BoxShape.circle,
        boxShadow: theme.navigationButtonShadow,
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: theme.navigationButtonSize,
            height: theme.navigationButtonSize,
            child: Icon(
              icon,
              color: theme.navigationButtonIconColor,
              size: theme.navigationButtonIconSize,
            ),
          ),
        ),
      ),
    );
  }

  /// 构建指示器
  Widget _buildIndicator(ZephyrCarouselTheme theme) {
    return Padding(
      padding: theme.indicatorPadding,
      child: Align(
        alignment: widget.config.indicatorAlignment,
        child: _buildIndicatorContent(theme),
      ),
    );
  }

  /// 构建指示器内容
  Widget _buildIndicatorContent(ZephyrCarouselTheme theme) {
    switch (widget.config.indicatorType) {
      case ZephyrCarouselIndicatorType.dots:
        return _buildDotsIndicator(theme);
      case ZephyrCarouselIndicatorType.numbers:
        return _buildNumbersIndicator(theme);
      case ZephyrCarouselIndicatorType.fraction:
        return _buildFractionIndicator(theme);
      case ZephyrCarouselIndicatorType.custom:
        return _buildCustomIndicator(theme);
    }
  }

  /// 构建点状指示器
  Widget _buildDotsIndicator(ZephyrCarouselTheme theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.items.length, (index) {
        final isSelected = index == _currentIndex;

        return GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: widget.config.animationDuration,
              curve: widget.config.curve,
            );
          },
          child: Container(
            width: isSelected
                ? theme.activeIndicatorSize
                : theme.inactiveIndicatorSize,
            height: isSelected
                ? theme.activeIndicatorSize
                : theme.inactiveIndicatorSize,
            margin: theme.indicatorSpacing,
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.activeIndicatorColor
                  : theme.inactiveIndicatorColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }

  /// 构建数字指示器
  Widget _buildNumbersIndicator(ZephyrCarouselTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.indicatorBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${_currentIndex + 1}',
        style: theme.indicatorTextStyle,
      ),
    );
  }

  /// 构建分数指示器
  Widget _buildFractionIndicator(ZephyrCarouselTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.indicatorBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${_currentIndex + 1} / ${widget.items.length}',
        style: theme.indicatorTextStyle,
      ),
    );
  }

  /// 构建自定义指示器
  Widget _buildCustomIndicator(ZephyrCarouselTheme theme) {
    final item = widget.items[_currentIndex];
    return item.customIndicator ?? _buildDotsIndicator(theme);
  }
}
