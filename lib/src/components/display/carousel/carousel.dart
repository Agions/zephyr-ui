/// VelocityUI 轮播图组件
library velocity_carousel;

import 'package:flutter/material.dart';
import 'carousel_style.dart';

export 'carousel_style.dart';

/// VelocityUI 轮播图
class VelocityCarousel extends StatefulWidget {
  const VelocityCarousel({
    super.key,
    required this.items,
    this.height = 200,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.showIndicator = true,
    this.onPageChanged,
    this.style,
  });

  final List<Widget> items;
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final bool showIndicator;
  final ValueChanged<int>? onPageChanged;
  final VelocityCarouselStyle? style;

  @override
  State<VelocityCarousel> createState() => _VelocityCarouselState();
}

class _VelocityCarouselState extends State<VelocityCarousel> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    if (widget.autoPlay && widget.items.length > 1) _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(widget.autoPlayInterval, () {
      if (mounted && widget.autoPlay) {
        final nextPage = (_currentPage + 1) % widget.items.length;
        _controller.animateToPage(nextPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocityCarouselStyle();

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              widget.onPageChanged?.call(index);
            },
            itemBuilder: (context, index) => Padding(
              padding: effectiveStyle.itemPadding,
              child: ClipRRect(
                borderRadius: effectiveStyle.borderRadius,
                child: widget.items[index],
              ),
            ),
          ),
          if (widget.showIndicator && widget.items.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: effectiveStyle.indicatorBottom,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    widget.items.length,
                    (index) => Container(
                          width: _currentPage == index
                              ? effectiveStyle.activeIndicatorWidth
                              : effectiveStyle.indicatorSize,
                          height: effectiveStyle.indicatorSize,
                          margin: EdgeInsets.symmetric(
                              horizontal: effectiveStyle.indicatorSpacing / 2),
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? effectiveStyle.activeIndicatorColor
                                : effectiveStyle.indicatorColor,
                            borderRadius: BorderRadius.circular(
                                effectiveStyle.indicatorSize / 2),
                          ),
                        )),
              ),
            ),
        ],
      ),
    );
  }
}
