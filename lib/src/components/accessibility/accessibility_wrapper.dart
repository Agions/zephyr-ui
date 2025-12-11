import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_ui/src/core/accessibility/accessibility_types.dart';

class VelocityAccessibilityWrapperConfig {
  const VelocityAccessibilityWrapperConfig({
    this.enableTextScaling = false,
    this.textScaleFactor = 1.0,
    this.enableTouchTargetSize = false,
    this.minTouchTargetSize = 48.0,
    this.enableHighContrast = false,
    this.enableKeyboardNavigation = false,
    this.enableFocusHighlight = false,
    this.enableFocusIndicator = false,
    this.enableSemantics = false,
    this.focusColor,
    this.focusBorderWidth = 2.0,
    this.semanticData,
  });

  final bool enableTextScaling;
  final double textScaleFactor;
  final bool enableTouchTargetSize;
  final double minTouchTargetSize;
  final bool enableHighContrast;
  final bool enableKeyboardNavigation;
  final bool enableFocusHighlight;
  final bool enableFocusIndicator;
  final bool enableSemantics;
  final Color? focusColor;
  final double focusBorderWidth;
  final VelocitySemanticData? semanticData;

  VelocityAccessibilityWrapperConfig copyWith({
    bool? enableTextScaling,
    double? textScaleFactor,
    bool? enableTouchTargetSize,
    double? minTouchTargetSize,
    bool? enableHighContrast,
    bool? enableKeyboardNavigation,
    bool? enableFocusHighlight,
    bool? enableFocusIndicator,
    bool? enableSemantics,
    Color? focusColor,
    double? focusBorderWidth,
    VelocitySemanticData? semanticData,
  }) {
    return VelocityAccessibilityWrapperConfig(
      enableTextScaling: enableTextScaling ?? this.enableTextScaling,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      enableTouchTargetSize:
          enableTouchTargetSize ?? this.enableTouchTargetSize,
      minTouchTargetSize: minTouchTargetSize ?? this.minTouchTargetSize,
      enableHighContrast: enableHighContrast ?? this.enableHighContrast,
      enableKeyboardNavigation:
          enableKeyboardNavigation ?? this.enableKeyboardNavigation,
      enableFocusHighlight: enableFocusHighlight ?? this.enableFocusHighlight,
      enableFocusIndicator: enableFocusIndicator ?? this.enableFocusIndicator,
      enableSemantics: enableSemantics ?? this.enableSemantics,
      focusColor: focusColor ?? this.focusColor,
      focusBorderWidth: focusBorderWidth ?? this.focusBorderWidth,
      semanticData: semanticData ?? this.semanticData,
    );
  }
}

class VelocitySemanticData {
  const VelocitySemanticData({
    this.label,
    this.hint,
    this.value,
    this.description,
    this.checked,
    this.selected,
    this.enabled = true,
    this.readOnly = false,
    this.obscured = false,
    this.disabled = false,
  });

  final String? label;
  final String? hint;
  final String? value;
  final String? description;
  final bool? checked;
  final bool? selected;
  final bool enabled;
  final bool readOnly;
  final bool obscured;
  final bool disabled;
}

class VelocityAccessibilityWrapper extends StatelessWidget {
  const VelocityAccessibilityWrapper({
    required this.child,
    super.key,
    this.config = const VelocityAccessibilityWrapperConfig(),
    this.isInteractive = false,
    this.keyboardCallbacks = const {},
    this.semanticData,
    this.componentType,
    this.isForm = false,
  });

  final Widget child;
  final VelocityAccessibilityWrapperConfig config;
  final bool isInteractive;
  final Map<String, VoidCallback> keyboardCallbacks;
  final VelocitySemanticData? semanticData;
  final VelocityAccessibilityComponentType? componentType;
  final bool isForm;

  @override
  Widget build(BuildContext context) {
    var current = child;

    // Apply text scaling
    if (config.enableTextScaling) {
      current = MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(config.textScaleFactor),
        ),
        child: current,
      );
    }

    // Apply touch target size
    if (config.enableTouchTargetSize) {
      current = SizedBox.expand(
        child: SizedBox(
          width: config.minTouchTargetSize,
          height: config.minTouchTargetSize,
          child: Center(child: current),
        ),
      );
    }

    // Apply high contrast
    if (config.enableHighContrast) {
      current = Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          child: current,
        ),
      );
    }

    // Apply keyboard navigation
    if (config.enableKeyboardNavigation && isInteractive) {
      current = Focus(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              keyboardCallbacks['onEnter']?.call();
              return KeyEventResult.handled;
            }
            if (event.logicalKey == LogicalKeyboardKey.space) {
              keyboardCallbacks['onSpace']?.call();
              return KeyEventResult.handled;
            }
            if (event.logicalKey == LogicalKeyboardKey.tab) {
              keyboardCallbacks['onTab']?.call();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: current,
      );
    }

    // Apply focus highlight
    if (config.enableFocusHighlight) {
      current = Focus(
        canRequestFocus: isInteractive,
        child: Builder(builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return Container(
            decoration: BoxDecoration(
              border: isFocused
                  ? Border.all(
                      color: config.focusColor ?? Colors.blue,
                      width: config.focusBorderWidth,
                    )
                  : null,
            ),
            child: current,
          );
        }),
      );
    }

    // Apply semantic data
    if (semanticData != null) {
      current = Semantics(
        label: semanticData?.label,
        hint: semanticData?.hint,
        value: semanticData?.value,
        checked: semanticData?.checked,
        selected: semanticData?.selected,
        enabled: (semanticData?.enabled ?? true) &&
            !(semanticData?.disabled ?? false),
        readOnly: semanticData?.readOnly,
        obscured: semanticData?.obscured,
        child: current,
      );
    }

    return current;
  }
}
