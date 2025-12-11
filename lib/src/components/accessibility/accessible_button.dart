import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_ui/src/core/accessibility/accessibility_types.dart';

class VelocityAccessibleButton extends StatelessWidget {
  const VelocityAccessibleButton({
    required this.text,
    super.key,
    this.icon,
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.type = ButtonType.text,
    this.size = ButtonSize.medium,
    this.isFullWidth = false,
    this.semanticLabel,
    this.focusNode,
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final ButtonType type;
  final ButtonSize size;
  final bool isFullWidth;
  final String? semanticLabel;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && !isLoading;
    final buttonHeight = _getButtonHeight(size);

    return Focus(
      focusNode: focusNode,
      onKey: (node, event) {
        if (isEnabled &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.space)) {
          onPressed?.call();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Semantics(
        label: semanticLabel ?? text,
        button: true,
        enabled: isEnabled,
        child: GestureDetector(
          onTap: isEnabled ? onPressed : null,
          child: Container(
            width: isFullWidth ? double.infinity : null,
            height: buttonHeight,
            padding: _getButtonPadding(size),
            decoration: _getButtonDecoration(type, isEnabled),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisSize:
                        isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon,
                            size: _getIconSize(size),
                            color: _getTextColor(type, isEnabled)),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        isLoading ? '加载中...' : text,
                        style: TextStyle(
                          fontSize: _getTextSize(size),
                          color: _getTextColor(type, isEnabled),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  double _getButtonHeight(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }

  EdgeInsets _getButtonPadding(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20);
    }
  }

  double _getTextSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 14;
      case ButtonSize.medium:
        return 16;
      case ButtonSize.large:
        return 18;
    }
  }

  double _getIconSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  Color _getTextColor(ButtonType type, bool isEnabled) {
    if (!isEnabled) {
      return Colors.grey;
    }
    switch (type) {
      case ButtonType.primary:
        return Colors.white;
      case ButtonType.secondary:
        return Colors.blue;
      case ButtonType.text:
        return Colors.blue;
      case ButtonType.danger:
        return Colors.white;
    }
  }

  Decoration _getButtonDecoration(ButtonType type, bool isEnabled) {
    if (!isEnabled) {
      return BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      );
    }
    switch (type) {
      case ButtonType.primary:
        return BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonType.secondary:
        return BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonType.text:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonType.danger:
        return BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        );
    }
  }
}

enum ButtonType {
  primary,
  secondary,
  text,
  danger,
}

enum ButtonSize {
  small,
  medium,
  large,
}
