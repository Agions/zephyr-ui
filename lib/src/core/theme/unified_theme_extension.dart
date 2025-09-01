/// ZephyrUI 统一主题扩展
/// 
/// 为 Flutter 的 ThemeData 添加 ZephyrUI 的扩展功能
library unified_theme_extension;

import 'package:flutter/material.dart';
import 'unified_theme_data.dart';

/// ZephyrUI 统一主题扩展
class ZephyrUnifiedThemeExtension extends ThemeExtension<ZephyrUnifiedThemeExtension> {
  const ZephyrUnifiedThemeExtension({
    required this.data,
  });

  /// 主题数据
  final ZephyrUnifiedThemeData data;

  @override
  ZephyrUnifiedThemeExtension copyWith({
    ZephyrUnifiedThemeData? data,
  }) {
    return ZephyrUnifiedThemeExtension(
      data: data ?? this.data,
    );
  }

  @override
  ZephyrUnifiedThemeExtension lerp(ThemeExtension<ZephyrUnifiedThemeExtension>? other, double t) {
    if (other is! ZephyrUnifiedThemeExtension) {
      return this;
    }
    
    // 这里可以实现主题之间的插值动画
    return ZephyrUnifiedThemeExtension(
      data: data, // 简化处理，实际可以实现更复杂的插值逻辑
    );
  }

  /// 从主题数据创建扩展
  static ZephyrUnifiedThemeExtension fromThemeData(ZephyrUnifiedThemeData themeData) {
    return ZephyrUnifiedThemeExtension(data: themeData);
  }

  /// 从上下文获取主题数据
  static ZephyrUnifiedThemeData? of(BuildContext context) {
    final extension = Theme.of(context).extension<ZephyrUnifiedThemeExtension>();
    return extension?.data;
  }

  /// 创建默认扩展
  static ZephyrUnifiedThemeExtension get defaultLight => 
      ZephyrUnifiedThemeExtension(data: ZephyrUnifiedThemeData.light());

  static ZephyrUnifiedThemeExtension get defaultDark => 
      ZephyrUnifiedThemeExtension(data: ZephyrUnifiedThemeData.dark());
}

/// 主题扩展构建器
class ZephyrThemeExtensionBuilder extends StatelessWidget {
  const ZephyrThemeExtensionBuilder({
    Key? key,
    required this.themeData,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ZephyrUnifiedThemeData themeData;
  final Widget Function(BuildContext context, ZephyrUnifiedThemeData theme) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData.toMaterialTheme().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          ZephyrUnifiedThemeExtension.fromThemeData(themeData),
        ],
      ),
      child: Builder(
        builder: (context) {
          return builder(context, themeData);
        },
      ),
    );
  }
}

/// 主题切换动画包装器
class ZephyrAnimatedThemeSwitcher extends StatefulWidget {
  const ZephyrAnimatedThemeSwitcher({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<ZephyrAnimatedThemeSwitcher> createState() => _ZephyrAnimatedThemeSwitcherState();
}

class _ZephyrAnimatedThemeSwitcherState extends State<ZephyrAnimatedThemeSwitcher>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(ZephyrAnimatedThemeSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.curve != widget.curve) {
      _animation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: 0.95 + (0.05 * _animation.value),
            child: widget.child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// 主题监听器
class ZephyrThemeListener extends StatefulWidget {
  const ZephyrThemeListener({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final Widget Function(BuildContext context, ZephyrUnifiedThemeData? theme) builder;
  final Widget? child;

  @override
  State<ZephyrThemeListener> createState() => _ZephyrThemeListenerState();
}

class _ZephyrThemeListenerState extends State<ZephyrThemeListener> {
  ZephyrUnifiedThemeData? _currentTheme;

  @override
  Widget build(BuildContext context) {
    final theme = ZephyrUnifiedThemeExtension.of(context);
    
    if (theme != _currentTheme) {
      _currentTheme = theme;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }

    return widget.builder(context, _currentTheme);
  }
}

/// 主题提供者
class ZephyrThemeProvider extends InheritedWidget {
  const ZephyrThemeProvider({
    Key? key,
    required this.themeData,
    required Widget child,
  }) : super(key: key, child: child);

  final ZephyrUnifiedThemeData themeData;

  static ZephyrUnifiedThemeData? of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ZephyrThemeProvider>();
    return provider?.themeData;
  }

  @override
  bool updateShouldNotify(ZephyrThemeProvider oldWidget) {
    return oldWidget.themeData != themeData;
  }
}

/// 主题状态管理器
class ZephyrThemeStateManager extends StatefulWidget {
  const ZephyrThemeStateManager({
    Key? key,
    required this.child,
    this.onThemeChanged,
  }) : super(key: key);

  final Widget child;
  final Function(ZephyrUnifiedThemeData)? onThemeChanged;

  @override
  State<ZephyrThemeStateManager> createState() => _ZephyrThemeStateManagerState();

  static _ZephyrThemeStateManagerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ZephyrThemeStateManagerState>();
  }
}

class _ZephyrThemeStateManagerState extends State<ZephyrThemeStateManager> {
  ZephyrUnifiedThemeData? _currentTheme;

  ZephyrUnifiedThemeData? get currentTheme => _currentTheme;

  void updateTheme(ZephyrUnifiedThemeData newTheme) {
    if (_currentTheme != newTheme) {
      setState(() {
        _currentTheme = newTheme;
      });
      widget.onThemeChanged?.call(newTheme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrThemeProvider(
      themeData: _currentTheme ?? ZephyrUnifiedThemeData.light(),
      child: widget.child,
    );
  }
}

/// 主题装饰器
class ZephyrThemeDecorator extends StatelessWidget {
  const ZephyrThemeDecorator({
    Key? key,
    required this.child,
    this.themeData,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final Widget child;
  final ZephyrUnifiedThemeData? themeData;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = themeData ?? ZephyrUnifiedThemeExtension.of(context) ?? ZephyrUnifiedThemeData.light();

    return ZephyrAnimatedThemeSwitcher(
      duration: animationDuration,
      child: ZephyrThemeExtensionBuilder(
        themeData: effectiveTheme,
        builder: (context, theme) {
          return ZephyrThemeStateManager(
            onThemeChanged: (newTheme) {
              // 主题变化处理
            },
            child: child,
          );
        },
      ),
    );
  }
}

/// 主题调试器
class ZephyrThemeDebugger extends StatelessWidget {
  const ZephyrThemeDebugger({
    Key? key,
    this.enabled = true,
    this.child,
  }) : super(key: key);

  final bool enabled;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child ?? const SizedBox();
    }

    final theme = ZephyrUnifiedThemeExtension.of(context);
    if (theme == null) {
      return child ?? const SizedBox();
    }

    return Stack(
      children: [
        child ?? const SizedBox(),
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outline),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Debug',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Brightness: ${theme.brightness.name}',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  'Primary: ${theme.colorScheme.primary.value.toRadixString(16)}',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  'Secondary: ${theme.colorScheme.secondary.value.toRadixString(16)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}