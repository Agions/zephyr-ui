/// ZephyrUI Rating Component
/// 
/// A comprehensive star rating component with interactive selection,
/// half-star support, and customizable styling.
library rating;

import 'package:flutter/material.dart';
import 'rating_theme.dart';

/// Rating item data
class ZephyrRatingItem {
  final double value;
  final String? label;
  final String? description;
  final IconData? icon;
  final Color? color;

  const ZephyrRatingItem({
    required this.value,
    this.label,
    this.description,
    this.icon,
    this.color,
  });
}

/// Main rating component
class ZephyrRating extends StatefulWidget {
  /// Creates a rating component
  const ZephyrRating({
    super.key,
    this.value = 0,
    this.maxValue = 5,
    this.onChanged,
    this.onHover,
    this.theme,
    this.size = 24,
    this.spacing = 4,
    this.allowHalfRating = false,
    this.allowClear = false,
    this.readOnly = false,
    this.itemCount,
    this.disabled = false,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.showLabels = false,
    this.showTooltip = true,
    this.tooltipPrefix,
    this.customIcons,
    this.unselectedColor,
    this.selectedColor,
    this.hoverColor,
    this.animationDuration = const Duration(milliseconds: 200),
    this.semanticLabel,
    this.enableAccessibilityFeatures = true,
  });

  /// Current rating value
  final double value;

  /// Maximum rating value
  final double maxValue;

  /// Callback when rating changes
  final ValueChanged<double>? onChanged;

  /// Callback when hovering over rating
  final ValueChanged<double>? onHover;

  /// Theme configuration
  final ZephyrRatingTheme? theme;

  /// Size of each rating item
  final double size;

  /// Spacing between rating items
  final double spacing;

  /// Allow half-star ratings
  final bool allowHalfRating;

  /// Allow clearing the rating by clicking again
  final bool allowClear;

  /// Whether the rating is read-only
  final bool readOnly;

  /// Number of rating items (if different from maxValue)
  final int? itemCount;

  /// Whether the rating is disabled
  final bool disabled;

  /// Direction of rating layout
  final Axis direction;

  /// Alignment of rating items
  final WrapAlignment alignment;

  /// Show labels below rating items
  final bool showLabels;

  /// Show tooltips on hover
  final bool showTooltip;

  /// Prefix for tooltip text
  final String? tooltipPrefix;

  /// Custom icons for rating items
  final List<IconData>? customIcons;

  /// Color for unselected items
  final Color? unselectedColor;

  /// Color for selected items
  final Color? selectedColor;

  /// Color for hover state
  final Color? hoverColor;

  /// Animation duration
  final Duration animationDuration;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Enable accessibility features
  final bool enableAccessibilityFeatures;

  @override
  State<ZephyrRating> createState() => _ZephyrRatingState();
}

class _ZephyrRatingState extends State<ZephyrRating> {
  late double _hoverValue;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _hoverValue = widget.value;
  }

  @override
  void didUpdateWidget(ZephyrRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _hoverValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrRatingTheme.of(context);
    final itemCount = widget.itemCount ?? widget.maxValue.round();
    final effectiveValue = widget.value.clamp(0.0, widget.maxValue);
    final effectiveHoverValue = _hoverValue.clamp(0.0, widget.maxValue);

    return Semantics(
      label: widget.semanticLabel ?? 'Rating: ${effectiveValue.toStringAsFixed(1)} out of ${widget.maxValue}',
      value: effectiveValue.toStringAsFixed(1),
      enabled: !widget.disabled && !widget.readOnly,
      child: _buildRatingContent(theme, itemCount, effectiveValue, effectiveHoverValue),
    );
  }

  Widget _buildRatingContent(
    ZephyrRatingTheme theme,
    int itemCount,
    double effectiveValue,
    double effectiveHoverValue,
  ) {
    final items = List.generate(itemCount, (index) {
      final itemValue = (index + 1).toDouble();
      final isHalf = widget.allowHalfRating && 
          (effectiveValue >= itemValue - 0.5 && effectiveValue < itemValue);
      final isHoverHalf = widget.allowHalfRating && 
          (effectiveHoverValue >= itemValue - 0.5 && effectiveHoverValue < itemValue);
      final isSelected = effectiveValue >= itemValue || isHalf;
      final isHovered = _isHovering && (effectiveHoverValue >= itemValue || isHoverHalf);

      return _buildRatingItem(
        theme,
        itemValue,
        isSelected,
        isHovered,
        isHalf,
        isHoverHalf,
      );
    });

    return widget.direction == Axis.horizontal
        ? Wrap(
            spacing: widget.spacing,
            runSpacing: widget.spacing,
            alignment: widget.alignment,
            children: items,
          )
        : Column(
            spacing: widget.spacing,
            children: items,
          );
  }

  Widget _buildRatingItem(
    ZephyrRatingTheme theme,
    double itemValue,
    bool isSelected,
    bool isHovered,
    bool isHalf,
    bool isHoverHalf,
  ) {
    Widget icon = _buildIcon(theme, isSelected, isHovered, isHalf, isHoverHalf);

    if (widget.showTooltip) {
      icon = Tooltip(
        message: '${widget.tooltipPrefix ?? "Rate"} ${itemValue.toStringAsFixed(widget.allowHalfRating ? 1 : 0)}',
        child: icon,
      );
    }

    if (!widget.readOnly && !widget.disabled) {
      icon = MouseRegion(
        onEnter: (_) => _handleMouseEnter(itemValue),
        onExit: (_) => _handleMouseExit(),
        child: GestureDetector(
          onTap: () => _handleTap(itemValue),
          child: icon,
        ),
      );
    }

    if (widget.showLabels) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 4),
          Text(
            itemValue.toStringAsFixed(widget.allowHalfRating ? 1 : 0),
            style: theme.labelStyle,
          ),
        ],
      );
    }

    return icon;
  }

  Widget _buildIcon(
    ZephyrRatingTheme theme,
    bool isSelected,
    bool isHovered,
    bool isHalf,
    bool isHoverHalf,
  ) {
    final iconData = widget.customIcons?.isEmpty == true
        ? theme.selectedIcon
        : (widget.customIcons?[(isHalf || isHoverHalf) ? (isSelected ? 0 : 1) : isSelected ? 0 : 1] ?? 
           (isSelected ? theme.selectedIcon : theme.unselectedIcon));

    final color = _getIconColor(theme, isSelected, isHovered);

    return AnimatedSwitcher(
      duration: widget.animationDuration,
      child: Icon(
        iconData,
        size: widget.size,
        color: color,
      ),
    );
  }

  Color _getIconColor(ZephyrRatingTheme theme, bool isSelected, bool isHovered) {
    if (widget.disabled) {
      return theme.disabledColor;
    }
    
    if (isHovered) {
      return widget.hoverColor ?? theme.hoverColor;
    }
    
    if (isSelected) {
      return widget.selectedColor ?? theme.selectedColor;
    }
    
    return widget.unselectedColor ?? theme.unselectedColor;
  }

  void _handleMouseEnter(double value) {
    if (widget.disabled || widget.readOnly) return;
    
    setState(() {
      _isHovering = true;
      _hoverValue = value;
    });
    
    widget.onHover?.call(value);
  }

  void _handleMouseExit() {
    if (widget.disabled || widget.readOnly) return;
    
    setState(() {
      _isHovering = false;
      _hoverValue = widget.value;
    });
  }

  void _handleTap(double value) {
    if (widget.disabled || widget.readOnly) return;
    
    double newValue = value;
    
    // Handle half-star rating
    if (widget.allowHalfRating) {
      final difference = value - widget.value;
      if (difference.abs() < 0.5) {
        newValue = value - 0.5;
      }
    }
    
    // Handle clear functionality
    if (widget.allowClear && widget.value == newValue) {
      newValue = 0;
    }
    
    widget.onChanged?.call(newValue.clamp(0.0, widget.maxValue));
  }
}

/// Rating display component (read-only)
class ZephyrRatingDisplay extends StatelessWidget {
  /// Creates a rating display component
  const ZephyrRatingDisplay({
    super.key,
    required this.value,
    this.maxValue = 5,
    this.theme,
    this.size = 16,
    this.spacing = 2,
    this.allowHalfRating = false,
    this.itemCount,
    this.direction = Axis.horizontal,
    this.showValue = false,
    this.valueStyle,
    this.customIcons,
    this.unselectedColor,
    this.selectedColor,
    this.semanticLabel,
    this.enableAccessibilityFeatures = true,
  });

  /// Rating value to display
  final double value;

  /// Maximum rating value
  final double maxValue;

  /// Theme configuration
  final ZephyrRatingTheme? theme;

  /// Size of each rating item
  final double size;

  /// Spacing between rating items
  final double spacing;

  /// Allow half-star display
  final bool allowHalfRating;

  /// Number of rating items
  final int? itemCount;

  /// Direction of rating layout
  final Axis direction;

  /// Show numeric value
  final bool showValue;

  /// Style for numeric value
  final TextStyle? valueStyle;

  /// Custom icons for rating items
  final List<IconData>? customIcons;

  /// Color for unselected items
  final Color? unselectedColor;

  /// Color for selected items
  final Color? selectedColor;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Enable accessibility features
  final bool enableAccessibilityFeatures;

  @override
  Widget build(BuildContext context) {
    return ZephyrRating(
      value: value,
      maxValue: maxValue,
      theme: theme,
      size: size,
      spacing: spacing,
      allowHalfRating: allowHalfRating,
      itemCount: itemCount,
      direction: direction,
      readOnly: true,
      customIcons: customIcons,
      unselectedColor: unselectedColor,
      selectedColor: selectedColor,
      semanticLabel: semanticLabel,
      enableAccessibilityFeatures: enableAccessibilityFeatures,
    );
  }
}