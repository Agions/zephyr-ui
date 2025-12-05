/// VelocityUI 加载组件
library velocity_loading;

import 'package:flutter/material.dart';
import 'loading_style.dart';

export 'loading_style.dart';

/// 加载类型
enum VelocityLoadingType { circular, linear }

/// VelocityUI 加载组件
class VelocityLoading extends StatelessWidget {
  const VelocityLoading({
    super.key,
    this.type = VelocityLoadingType.circular,
    this.size = 24,
    this.strokeWidth = 2,
    this.value,
    this.style,
  });

  final VelocityLoadingType type;
  final double size;
  final double strokeWidth;
  final double? value;
  final VelocityLoadingStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityLoadingStyle();
    
    if (type == VelocityLoadingType.linear) {
      return SizedBox(
        width: effectiveStyle.linearWidth,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: effectiveStyle.backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveStyle.color),
          minHeight: effectiveStyle.linearHeight,
        ),
      );
    }
    
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        backgroundColor: effectiveStyle.backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(effectiveStyle.color),
      ),
    );
  }
}

/// VelocityUI 加载覆盖层
class VelocityLoadingOverlay extends StatelessWidget {
  const VelocityLoadingOverlay({
    super.key,
    required this.child,
    required this.loading,
    this.message,
    this.style,
  });

  final Widget child;
  final bool loading;
  final String? message;
  final VelocityLoadingOverlayStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityLoadingOverlayStyle();
    
    return Stack(
      children: [
        child,
        if (loading)
          Positioned.fill(
            child: Container(
              color: effectiveStyle.effectiveOverlayColor,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    VelocityLoading(style: effectiveStyle.loadingStyle),
                    if (message != null) ...[
                      SizedBox(height: effectiveStyle.messageSpacing),
                      Text(message!, style: effectiveStyle.messageStyle),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
