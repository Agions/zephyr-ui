/// ZephyrUI 轮播图组件
/// 
/// 提供专业的轮播图展示组件，支持多种样式和交互

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 轮播图指示器类型
enum ZephyrCarouselIndicatorType {
  dots,
  numbers,
  fraction,
  none,
}

/// 轮播图动画类型
enum ZephyrCarouselAnimationType {
  slide,
  fade,
  scale,
  depth,
}

/// 轮播图项目模型
class ZephyrCarouselItem {
  final String id;
  final Widget child;
  final String? title;
  final String? subtitle;
  final Widget? overlay;
  final VoidCallback? onTap;
  final Map<String, dynamic>? metadata;

  const ZephyrCarouselItem({
    required this.id,
    required this.child,
    this.title,
    this.subtitle,
    this.overlay,
    this.onTap,
    this.metadata,
  });
}

/// 轮播图组件
class ZephyrCarousel extends StatefulWidget {
  final List<ZephyrCarouselItem> items;
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final bool enableInfiniteScroll;
  final bool showIndicators;
  final ZephyrCarouselIndicatorType indicatorType;
  final ZephyrCarouselAnimationType animationType;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool showControls;
  final EdgeInsetsGeometry padding;
  final double viewportFraction;
  final ValueChanged<int>? onPageChanged;
  final ZephyrCarouselTheme? theme;

  const ZephyrCarousel({
    Key? key,
    required this.items,
    this.height = 200.0,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.enableInfiniteScroll = true,
    this.showIndicators = true,
    this.indicatorType = ZephyrCarouselIndicatorType.dots,
    this.animationType = ZephyrCarouselAnimationType.slide,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.showControls = true,
    this.padding = EdgeInsets.zero,
    this.viewportFraction = 1.0,
    this.onPageChanged,
    this.theme,
  }) : super(key: key);

  @override
  State<ZephyrCarousel> createState() => _ZephyrCarouselState();
}

class _ZephyrCarouselState extends State<ZephyrCarousel> {
  late PageController _pageController;
  late int _currentPage;
  late Timer _autoPlayTimer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.enableInfiniteScroll ? widget.length ~/ 2 : 0;
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: widget.viewportFraction,
    );
    
    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _autoPlayTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (timer) {
      if (!_isPaused && mounted) {
        _nextPage();
      }
    });
  }

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
    }
  }

  void _previousPage() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
    }
  }

  void _onPageChanged(int index) {
    if (!mounted) return;
    
    setState(() {
      _currentPage = index;
    });
    
    // 计算实际页面索引（用于无限滚动）
    final actualIndex = widget.enableInfiniteScroll 
        ? index % widget.items.length 
        : index;
    
    widget.onPageChanged?.call(actualIndex);
  }

  int get _realPageIndex {
    return widget.enableInfiniteScroll 
        ? _currentPage % widget.items.length 
        : _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrCarouselTheme.resolve(context, widget.theme);
    
    return ZephyrPerformanceWidget(
      widgetName: 'ZephyrCarousel',
      child: MouseRegion(
        onEnter: (_) => setState(() => _isPaused = true),
        onExit: (_) => setState(() => _isPaused = false),
        child: Container(
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: effectiveTheme.backgroundColor,
            borderRadius: BorderRadius.circular(effectiveTheme.borderRadius),
            boxShadow: effectiveTheme.boxShadow,
          ),
          child: Stack(
            children: [
              // 轮播图内容
              _buildCarouselContent(),
              
              // 控制按钮
              if (widget.showControls) _buildControls(effectiveTheme),
              
              // 指示器
              if (widget.showIndicators) _buildIndicators(effectiveTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselContent() {
    if (widget.items.isEmpty) {
      return const Center(
        child: ZephyrText.body(text: '没有可显示的内容'),
      );
    }

    final itemCount = widget.enableInfiniteScroll 
        ? widget.items.length * 1000 
        : widget.items.length;

    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final itemIndex = widget.enableInfiniteScroll 
            ? index % widget.items.length 
            : index;
        final item = widget.items[itemIndex];
        
        return _buildCarouselItem(item, itemIndex);
      },
    );
  }

  Widget _buildCarouselItem(ZephyrCarouselItem item, int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          value = value.abs();
          value = value.clamp(0.0, 1.0);
        }

        return Transform(
          transform: _buildTransform(value),
          child: Opacity(
            opacity: _buildOpacity(value),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: item.onTap,
        child: Stack(
          children: [
            // 主要内容
            Positioned.fill(
              child: item.child,
            ),
            
            // 覆盖层
            if (item.overlay != null)
              Positioned.fill(
                child: item.overlay!,
              ),
            
            // 文本信息
            if (item.title != null || item.subtitle != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.title != null)
                        ZephyrText.heading(
                          text: item.title!,
                          color: Colors.white,
                        ),
                      if (item.subtitle != null) ...[
                        const SizedBox(height: 4),
                        ZephyrText.body(
                          text: item.subtitle!,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Matrix4 _buildTransform(double value) {
    switch (widget.animationType) {
      case ZephyrCarouselAnimationType.slide:
        return Matrix4.translationValues(value * 100, 0, 0);
      case ZephyrCarouselAnimationType.fade:
        return Matrix4.identity();
      case ZephyrCarouselAnimationType.scale:
        final scale = 1.0 - (value * 0.2);
        return Matrix4.diagonal3Values(scale, scale, 1.0);
      case ZephyrCarouselAnimationType.depth:
        final scale = 1.0 - (value * 0.1);
        final translation = value * 50;
        return Matrix4.translationValues(translation, 0, 0)
          ..scale(scale);
    }
  }

  double _buildOpacity(double value) {
    switch (widget.animationType) {
      case ZephyrCarouselAnimationType.fade:
        return 1.0 - value;
      case ZephyrCarouselAnimationType.slide:
      case ZephyrCarouselAnimationType.scale:
      case ZephyrCarouselAnimationType.depth:
        return 1.0;
    }
  }

  Widget _buildControls(ZephyrCarouselTheme effectiveTheme) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧控制按钮
          if (widget.items.length > 1)
            _buildControlButton(
              icon: Icons.chevron_left,
              onPressed: _previousPage,
              alignment: Alignment.centerLeft,
              effectiveTheme: effectiveTheme,
            ),
          
          // 右侧控制按钮
          if (widget.items.length > 1)
            _buildControlButton(
              icon: Icons.chevron_right,
              onPressed: _nextPage,
              alignment: Alignment.centerRight,
              effectiveTheme: effectiveTheme,
            ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Alignment alignment,
    required ZephyrCarouselTheme effectiveTheme,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: effectiveTheme.controlBackgroundColor,
          shape: BoxShape.circle,
          boxShadow: effectiveTheme.controlBoxShadow,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onPressed,
            child: Container(
              width: 40,
              height: 40,
              child: Icon(
                icon,
                color: effectiveTheme.controlIconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicators(ZephyrCarouselTheme effectiveTheme) {
    if (widget.items.length <= 1) return const SizedBox.shrink();

    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: Center(
        child: switch (widget.indicatorType) {
          ZephyrCarouselIndicatorType.dots => _buildDotsIndicator(effectiveTheme),
          ZephyrCarouselIndicatorType.numbers => _buildNumbersIndicator(effectiveTheme),
          ZephyrCarouselIndicatorType.fraction => _buildFractionIndicator(effectiveTheme),
          ZephyrCarouselIndicatorType.none => const SizedBox.shrink(),
        },
      ),
    );
  }

  Widget _buildDotsIndicator(ZephyrCarouselTheme effectiveTheme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.items.length, (index) {
        final isActive = index == _realPageIndex;
        return Container(
          width: isActive ? 24.0 : 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: isActive 
                ? effectiveTheme.activeIndicatorColor 
                : effectiveTheme.inactiveIndicatorColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }

  Widget _buildNumbersIndicator(ZephyrCarouselTheme effectiveTheme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.items.length, (index) {
        final isActive = index == _realPageIndex;
        return GestureDetector(
          onTap: () {
            if (widget.enableInfiniteScroll) {
              final targetIndex = _currentPage + (index - _realPageIndex);
              _pageController.animateToPage(
                targetIndex,
                duration: widget.animationDuration,
                curve: widget.animationCurve,
              );
            } else {
              _pageController.animateToPage(
                index,
                duration: widget.animationDuration,
                curve: widget.animationCurve,
              );
            }
          },
          child: Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: isActive 
                  ? effectiveTheme.activeIndicatorColor 
                  : effectiveTheme.inactiveIndicatorColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: ZephyrText.body(
                text: '${index + 1}',
                color: isActive 
                    ? effectiveTheme.activeTextColor 
                    : effectiveTheme.inactiveTextColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFractionIndicator(ZephyrCarouselTheme effectiveTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: effectiveTheme.indicatorBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ZephyrText.body(
        text: '${_realPageIndex + 1} / ${widget.items.length}',
        color: effectiveTheme.indicatorTextColor,
      ),
    );
  }
}

/// 轮播图主题
class ZephyrCarouselTheme extends ThemeExtension<ZephyrCarouselTheme> {
  final Color backgroundColor;
  final Color activeIndicatorColor;
  final Color inactiveIndicatorColor;
  final Color indicatorBackgroundColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color indicatorTextColor;
  final Color controlBackgroundColor;
  final Color controlIconColor;
  final List<BoxShadow> controlBoxShadow;
  final List<BoxShadow> boxShadow;
  final double borderRadius;

  const ZephyrCarouselTheme({
    required this.backgroundColor,
    required this.activeIndicatorColor,
    required this.inactiveIndicatorColor,
    required this.indicatorBackgroundColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.indicatorTextColor,
    required this.controlBackgroundColor,
    required this.controlIconColor,
    required this.controlBoxShadow,
    required this.boxShadow,
    required this.borderRadius,
  });

  @override
  ZephyrCarouselTheme copyWith({
    Color? backgroundColor,
    Color? activeIndicatorColor,
    Color? inactiveIndicatorColor,
    Color? indicatorBackgroundColor,
    Color? activeTextColor,
    Color? inactiveTextColor,
    Color? indicatorTextColor,
    Color? controlBackgroundColor,
    Color? controlIconColor,
    List<BoxShadow>? controlBoxShadow,
    List<BoxShadow>? boxShadow,
    double? borderRadius,
  }) {
    return ZephyrCarouselTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeIndicatorColor: activeIndicatorColor ?? this.activeIndicatorColor,
      inactiveIndicatorColor: inactiveIndicatorColor ?? this.inactiveIndicatorColor,
      indicatorBackgroundColor: indicatorBackgroundColor ?? this.indicatorBackgroundColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
      indicatorTextColor: indicatorTextColor ?? this.indicatorTextColor,
      controlBackgroundColor: controlBackgroundColor ?? this.controlBackgroundColor,
      controlIconColor: controlIconColor ?? this.controlIconColor,
      controlBoxShadow: controlBoxShadow ?? this.controlBoxShadow,
      boxShadow: boxShadow ?? this.boxShadow,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ZephyrCarouselTheme lerp(ThemeExtension<ZephyrCarouselTheme>? other, double t) {
    if (other is! ZephyrCarouselTheme) {
      return this;
    }
    return ZephyrCarouselTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      activeIndicatorColor: Color.lerp(activeIndicatorColor, other.activeIndicatorColor, t)!,
      inactiveIndicatorColor: Color.lerp(inactiveIndicatorColor, other.inactiveIndicatorColor, t)!,
      indicatorBackgroundColor: Color.lerp(indicatorBackgroundColor, other.indicatorBackgroundColor, t)!,
      activeTextColor: Color.lerp(activeTextColor, other.activeTextColor, t)!,
      inactiveTextColor: Color.lerp(inactiveTextColor, other.inactiveTextColor, t)!,
      indicatorTextColor: Color.lerp(indicatorTextColor, other.indicatorTextColor, t)!,
      controlBackgroundColor: Color.lerp(controlBackgroundColor, other.controlBackgroundColor, t)!,
      controlIconColor: Color.lerp(controlIconColor, other.controlIconColor, t)!,
      controlBoxShadow: _lerpBoxShadow(controlBoxShadow, other.controlBoxShadow, t),
      boxShadow: _lerpBoxShadow(boxShadow, other.boxShadow, t),
      borderRadius: ui.lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
    );
  }

  static List<BoxShadow> _lerpBoxShadow(List<BoxShadow> a, List<BoxShadow> b, double t) {
    if (a.length != b.length) return a;
    return List.generate(a.length, (i) {
      return BoxShadow(
        color: Color.lerp(a[i].color, b[i].color, t)!,
        offset: Offset.lerp(a[i].offset, b[i].offset, t)!,
        blurRadius: ui.lerpDouble(a[i].blurRadius, b[i].blurRadius, t) ?? 0,
        spreadRadius: ui.lerpDouble(a[i].spreadRadius, b[i].spreadRadius, t) ?? 0,
      );
    });
  }

  static ZephyrCarouselTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrCarouselTheme>();
    return theme ?? _createDefaultTheme(ZephyrThemeData.of(context));
  }

  static ZephyrCarouselTheme resolve(
    BuildContext context,
    ZephyrCarouselTheme? theme,
  ) {
    return theme ?? of(context);
  }

  static ZephyrCarouselTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    return ZephyrCarouselTheme(
      backgroundColor: Colors.grey.shade100,
      activeIndicatorColor: Colors.blue,
      inactiveIndicatorColor: Colors.grey.shade300,
      indicatorBackgroundColor: Colors.black.withOpacity(0.5),
      activeTextColor: Colors.white,
      inactiveTextColor: Colors.grey,
      indicatorTextColor: Colors.white,
      controlBackgroundColor: Colors.black.withOpacity(0.3),
      controlIconColor: Colors.white,
      controlBoxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
      borderRadius: 12.0,
    );
  }
}