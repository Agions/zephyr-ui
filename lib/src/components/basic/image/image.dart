/// ZephyrUI Image 图片组件
///
/// 提供图片加载、占位符、错误处理等功能

library image;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 图片加载状态枚举
enum ZephyrImageLoadState {
  loading,
  loaded,
  error,
}

/// 图片形状枚举
enum ZephyrImageShape {
  rectangle, // 矩形
  square, // 正方形
  circle, // 圆形
  rounded, // 圆角矩形
}

/// 图片适配模式枚举
enum ZephyrImageFit {
  fill, // 填充
  cover, // 覆盖
  contain, // 包含
  fitWidth, // 适应宽度
  fitHeight, // 适应高度
  none, // 无适配
}

/// Image 组件
class ZephyrImage extends StatefulWidget {
  const ZephyrImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.bytes,
    this.width,
    this.height,
    this.shape = ZephyrImageShape.rectangle,
    this.fit = ZephyrImageFit.cover,
    this.backgroundColor,
    this.placeholder,
    this.errorWidget,
    this.fadeDuration = const Duration(milliseconds: 300),
    this.borderRadius,
    this.boxFit,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.useCache = true,
    this.headers,
    this.onLoad,
    this.onError,
  }) : assert(
          imageUrl != null || assetPath != null || bytes != null,
          'Either imageUrl, assetPath, or bytes must be provided',
        );
  final String? imageUrl;
  final String? assetPath;
  final Uint8List? bytes;
  final double? width;
  final double? height;
  final ZephyrImageShape shape;
  final ZephyrImageFit fit;
  final Color? backgroundColor;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeDuration;
  final double? borderRadius;
  final BoxFit? boxFit;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final bool useCache;
  final Map<String, String>? headers;
  final VoidCallback? onLoad;
  final VoidCallback? onError;

  @override
  State<ZephyrImage> createState() => _ZephyrImageState();
}

class _ZephyrImageState extends State<ZephyrImage> {
  ZephyrImageLoadState _loadState = ZephyrImageLoadState.loading;
  ImageProvider? _imageProvider;
  ImageInfo? _imageInfo;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(ZephyrImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl ||
        oldWidget.assetPath != widget.assetPath ||
        oldWidget.bytes != widget.bytes) {
      _loadImage();
    }
  }

  @override
  void dispose() {
    _imageInfo?.dispose();
    super.dispose();
  }

  void _loadImage() {
    if (widget.imageUrl != null) {
      _loadNetworkImage();
    } else if (widget.assetPath != null) {
      _loadAssetImage();
    } else if (widget.bytes != null) {
      _loadMemoryImage();
    }
  }

  void _loadNetworkImage() {
    _imageProvider = NetworkImage(
      widget.imageUrl!,
      headers: widget.headers,
    );

    final stream = _imageProvider!.resolve(
      ImageConfiguration.empty,
    );

    stream.addListener(
      ImageStreamListener(
        (ImageInfo info, bool synchronousCall) {
          if (mounted) {
            setState(() {
              _loadState = ZephyrImageLoadState.loaded;
              _imageInfo = info;
            });
            widget.onLoad?.call();
          }
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          if (mounted) {
            setState(() {
              _loadState = ZephyrImageLoadState.error;
              _errorMessage = exception.toString();
            });
            widget.onError?.call();
          }
        },
      ),
    );
  }

  void _loadAssetImage() {
    _imageProvider = AssetImage(widget.assetPath!);

    final stream = _imageProvider!.resolve(
      ImageConfiguration.empty,
    );

    stream.addListener(
      ImageStreamListener(
        (ImageInfo info, bool synchronousCall) {
          if (mounted) {
            setState(() {
              _loadState = ZephyrImageLoadState.loaded;
              _imageInfo = info;
            });
            widget.onLoad?.call();
          }
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          if (mounted) {
            setState(() {
              _loadState = ZephyrImageLoadState.error;
              _errorMessage = exception.toString();
            });
            widget.onError?.call();
          }
        },
      ),
    );
  }

  void _loadMemoryImage() {
    _imageProvider = MemoryImage(widget.bytes!);

    final stream = _imageProvider!.resolve(
      ImageConfiguration.empty,
    );

    stream.addListener(
      ImageStreamListener(
        (ImageInfo info, bool synchronousCall) {
          if (mounted) {
            setState(() {
              _loadState = ZephyrImageLoadState.loaded;
              _imageInfo = info;
            });
            widget.onLoad?.call();
          }
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          if (mounted) {
            setState(() {
              _loadState = ZephyrImageLoadState.error;
              _errorMessage = exception.toString();
            });
            widget.onError?.call();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget imageWidget;

    if (_loadState == ZephyrImageLoadState.loading) {
      imageWidget = widget.placeholder ?? _getDefaultPlaceholder(context);
    } else if (_loadState == ZephyrImageLoadState.error) {
      imageWidget = widget.errorWidget ?? _getDefaultErrorWidget(context);
    } else {
      imageWidget = _buildImage();
    }

    return _applyShape(imageWidget);
  }

  Widget _buildImage() {
    final effectiveFit = widget.boxFit ?? _getBoxFit();

    Widget image = Image(
      image: _imageProvider!,
      width: widget.width,
      height: widget.height,
      fit: effectiveFit,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: widget.fadeDuration,
          child: child,
        );
      },
    );

    return image;
  }

  BoxFit _getBoxFit() {
    switch (widget.fit) {
      case ZephyrImageFit.fill:
        return BoxFit.fill;
      case ZephyrImageFit.cover:
        return BoxFit.cover;
      case ZephyrImageFit.contain:
        return BoxFit.contain;
      case ZephyrImageFit.fitWidth:
        return BoxFit.fitWidth;
      case ZephyrImageFit.fitHeight:
        return BoxFit.fitHeight;
      case ZephyrImageFit.none:
        return BoxFit.none;
    }
  }

  Widget _applyShape(Widget child) {
    final effectiveBorderRadius =
        widget.borderRadius ?? _getDefaultBorderRadius();

    switch (widget.shape) {
      case ZephyrImageShape.circle:
        return ClipOval(
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: child,
          ),
        );
      case ZephyrImageShape.square:
        return Container(
          width: widget.width ?? widget.height,
          height: widget.height ?? widget.width,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
          ),
          child: child,
        );
      case ZephyrImageShape.rounded:
        return ClipRRect(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          child: child,
        );
      case ZephyrImageShape.rectangle:
      default:
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
          ),
          child: child,
        );
    }
  }

  Widget _getDefaultPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(
            widget.borderRadius ?? _getDefaultBorderRadius()),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              color: theme.colorScheme.onSurfaceVariant,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              '加载中...',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDefaultErrorWidget(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(
            widget.borderRadius ?? _getDefaultBorderRadius()),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image_outlined,
              color: theme.colorScheme.onErrorContainer,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              '加载失败',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getDefaultBorderRadius() {
    switch (widget.shape) {
      case ZephyrImageShape.circle:
        return 0;
      case ZephyrImageShape.square:
        return 0;
      case ZephyrImageShape.rounded:
        return 8;
      case ZephyrImageShape.rectangle:
      default:
        return 0;
    }
  }
}

/// 网络图片组件
class ZephyrNetworkImage extends StatelessWidget {
  const ZephyrNetworkImage({
    required this.url,
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = ZephyrImageShape.rectangle,
    this.fit = ZephyrImageFit.cover,
    this.placeholder,
    this.errorWidget,
    this.headers,
    this.fadeDuration = const Duration(milliseconds: 300),
  });
  final String url;
  final double? width;
  final double? height;
  final ZephyrImageShape shape;
  final ZephyrImageFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Map<String, String>? headers;
  final Duration fadeDuration;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ZephyrImage(
      imageUrl: url,
      width: width,
      height: height,
      shape: shape,
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
      headers: headers,
      fadeDuration: fadeDuration,
      borderRadius: borderRadius,
    );
  }
}

/// 资源图片组件
class ZephyrAssetImage extends StatelessWidget {
  const ZephyrAssetImage({
    required this.path,
    super.key,
    this.width,
    this.height,
    this.shape = ZephyrImageShape.rectangle,
    this.fit = ZephyrImageFit.cover,
    this.placeholder,
    this.errorWidget,
    this.fadeDuration = const Duration(milliseconds: 300),
  });

  final String path;
  final double? width;
  final double? height;
  final ZephyrImageShape shape;
  final ZephyrImageFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeDuration;

  @override
  Widget build(BuildContext context) {
    return ZephyrImage(
      assetPath: path,
      width: width,
      height: height,
      shape: shape,
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
      fadeDuration: fadeDuration,
    );
  }
}

/// 内存图片组件
class ZephyrMemoryImage extends StatelessWidget {
  const ZephyrMemoryImage({
    required this.bytes,
    super.key,
    this.width,
    this.height,
    this.shape = ZephyrImageShape.rectangle,
    this.fit = ZephyrImageFit.cover,
    this.placeholder,
    this.errorWidget,
    this.fadeDuration = const Duration(milliseconds: 300),
  });

  final Uint8List bytes;
  final double? width;
  final double? height;
  final ZephyrImageShape shape;
  final ZephyrImageFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeDuration;

  @override
  Widget build(BuildContext context) {
    return ZephyrImage(
      bytes: bytes,
      width: width,
      height: height,
      shape: shape,
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
      fadeDuration: fadeDuration,
    );
  }
}

/// 头像图片组件
class ZephyrAvatarImage extends StatelessWidget {
  const ZephyrAvatarImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.size = 40,
    this.name,
    this.backgroundColor,
    this.textColor,
    this.placeholder,
    this.errorWidget,
  }) : assert(
          imageUrl != null || assetPath != null || name != null,
          'Either imageUrl, assetPath, or name must be provided',
        );

  final String? imageUrl;
  final String? assetPath;
  final double size;
  final String? name;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null || assetPath != null) {
      return ZephyrImage(
        imageUrl: imageUrl,
        assetPath: assetPath,
        width: size,
        height: size,
        shape: ZephyrImageShape.circle,
        placeholder: placeholder ?? _buildNameAvatar(context),
        errorWidget: errorWidget ?? _buildNameAvatar(context),
      );
    } else {
      return _buildNameAvatar(context);
    }
  }

  Widget _buildNameAvatar(BuildContext context) {
    final theme = Theme.of(context);
    final initials = name != null ? _getInitials(name!) : '';

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: theme.textTheme.titleMedium?.copyWith(
            color: textColor ?? theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return '';
  }
}

/// 图片画廊组件
class ZephyrImageGallery extends StatefulWidget {
  const ZephyrImageGallery({
    required this.imageUrls,
    super.key,
    this.height = 200,
    this.viewportFraction = 0.8,
    this.onPageChanged,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.showIndicator = true,
  });

  final List<String> imageUrls;
  final double height;
  final double viewportFraction;
  final Function(int index)? onPageChanged;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final bool showIndicator;

  @override
  State<ZephyrImageGallery> createState() => _ZephyrImageGalleryState();
}

class _ZephyrImageGalleryState extends State<ZephyrImageGallery> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: widget.viewportFraction,
    );

    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
      if (_currentIndex < widget.imageUrls.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              widget.onPageChanged?.call(index);
            },
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ZephyrNetworkImage(
                  url: widget.imageUrls[index],
                  shape: ZephyrImageShape.rounded,
                ),
              );
            },
          ),
        ),
        if (widget.showIndicator) _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.imageUrls.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withValues(alpha:0.3),
            ),
          ),
        ),
      ),
    );
  }
}
