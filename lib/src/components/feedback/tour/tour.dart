/// ZephyrUI Tour Component
///
/// A comprehensive feature tour component for onboarding and guiding users
/// through application features with step-by-step tutorials.
library tour;

import 'package:flutter/material.dart';
import 'tour_theme.dart';

/// Tour step data
class ZephyrTourStep {
  const ZephyrTourStep({
    required this.id,
    required this.title,
    required this.content,
    this.targetKey,
    this.targetRect,
    this.order = 0,
    this.isOptional = false,
    this.customWidget,
    this.nextStepId,
    this.previousStepId,
    this.onShow,
    this.onComplete,
    this.onSkip,
    this.metadata,
  });

  /// Unique identifier for the step
  final String id;

  /// Title of the step
  final String title;

  /// Content/description of the step
  final String content;

  /// Target widget key for highlighting
  final GlobalKey? targetKey;

  /// Target widget position (if no key is provided)
  final Rect? targetRect;

  /// Step order
  final int order;

  /// Whether the step is optional
  final bool isOptional;

  /// Custom widget for the step
  final Widget? customWidget;

  /// Next step ID
  final String? nextStepId;

  /// Previous step ID
  final String? previousStepId;

  /// Callback when step is shown
  final VoidCallback? onShow;

  /// Callback when step is completed
  final VoidCallback? onComplete;

  /// Callback when step is skipped
  final VoidCallback? onSkip;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  /// Create a copy of the step with modified properties
  ZephyrTourStep copyWith({
    String? id,
    String? title,
    String? content,
    GlobalKey? targetKey,
    Rect? targetRect,
    int? order,
    bool? isOptional,
    Widget? customWidget,
    String? nextStepId,
    String? previousStepId,
    VoidCallback? onShow,
    VoidCallback? onComplete,
    VoidCallback? onSkip,
    Map<String, dynamic>? metadata,
  }) {
    return ZephyrTourStep(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      targetKey: targetKey ?? this.targetKey,
      targetRect: targetRect ?? this.targetRect,
      order: order ?? this.order,
      isOptional: isOptional ?? this.isOptional,
      customWidget: customWidget ?? this.customWidget,
      nextStepId: nextStepId ?? this.nextStepId,
      previousStepId: previousStepId ?? this.previousStepId,
      onShow: onShow ?? this.onShow,
      onComplete: onComplete ?? this.onComplete,
      onSkip: onSkip ?? this.onSkip,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// Tour component
class ZephyrTour extends StatefulWidget {
  /// Creates a tour component
  const ZephyrTour({
    required this.steps,
    super.key,
    this.theme,
    this.onTourStart,
    this.onTourComplete,
    this.onTourSkip,
    this.onStepChange,
    this.autoStart = false,
    this.showSkipButton = true,
    this.showNextButton = true,
    this.showPreviousButton = true,
    this.showProgress = true,
    this.showStepNumbers = true,
    this.allowSkip = true,
    this.allowNavigation = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.overlayColor = const Color(0x80000000),
    this.highlightPadding = 8,
    this.highlightBorderRadius = 8,
    this.tooltipOffset = const Offset(0, 8),
    this.semanticLabel,
    this.enableAccessibilityFeatures = true,
    this.storageKey,
    this.persistenceMode = ZephyrTourPersistence.none,
    this.startStepId,
    this.currentStepId,
  });

  /// Tour steps
  final List<ZephyrTourStep> steps;

  /// Theme configuration
  final ZephyrTourTheme? theme;

  /// Callback when tour starts
  final VoidCallback? onTourStart;

  /// Callback when tour completes
  final VoidCallback? onTourComplete;

  /// Callback when tour is skipped
  final VoidCallback? onTourSkip;

  /// Callback when step changes
  final void Function(ZephyrTourStep step)? onStepChange;

  /// Auto start the tour
  final bool autoStart;

  /// Show skip button
  final bool showSkipButton;

  /// Show next button
  final bool showNextButton;

  /// Show previous button
  final bool showPreviousButton;

  /// Show progress indicator
  final bool showProgress;

  /// Show step numbers
  final bool showStepNumbers;

  /// Allow skipping steps
  final bool allowSkip;

  /// Allow navigation between steps
  final bool allowNavigation;

  /// Animation duration
  final Duration animationDuration;

  /// Overlay color
  final Color overlayColor;

  /// Highlight padding
  final double highlightPadding;

  /// Highlight border radius
  final double highlightBorderRadius;

  /// Tooltip offset
  final Offset tooltipOffset;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Enable accessibility features
  final bool enableAccessibilityFeatures;

  /// Storage key for persistence
  final String? storageKey;

  /// Persistence mode
  final ZephyrTourPersistence persistenceMode;

  /// Starting step ID
  final String? startStepId;

  /// Current step ID (for controlled mode)
  final String? currentStepId;

  @override
  State<ZephyrTour> createState() => _ZephyrTourState();
}

class _ZephyrTourState extends State<ZephyrTour> {
  late List<ZephyrTourStep> _steps;
  int _currentStepIndex = 0;
  bool _isTourActive = false;
  OverlayEntry? _overlayEntry;
  Rect? _targetRect;
  final GlobalKey _overlayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _steps = widget.steps;
    _steps.sort((a, b) => a.order.compareTo(b.order));

    if (widget.autoStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startTour();
      });
    }
  }

  @override
  void didUpdateWidget(ZephyrTour oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.steps != widget.steps) {
      _steps = widget.steps;
      _steps.sort((a, b) => a.order.compareTo(b.order));
    }

    if (oldWidget.currentStepId != widget.currentStepId) {
      if (widget.currentStepId != null) {
        final index =
            _steps.indexWhere((step) => step.id == widget.currentStepId);
        if (index != -1) {
          _currentStepIndex = index;
          _updateTargetRect();
        }
      }
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget;
  }

  void _startTour() {
    if (_steps.isEmpty) return;

    setState(() {
      _isTourActive = true;
    });

    if (widget.startStepId != null) {
      final index = _steps.indexWhere((step) => step.id == widget.startStepId);
      if (index != -1) {
        _currentStepIndex = index;
      }
    }

    widget.onTourStart?.call();
    _showOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => _buildOverlay(),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _updateTargetRect();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateTargetRect() {
    if (_currentStepIndex >= _steps.length) return;

    final step = _steps[_currentStepIndex];
    if (step.targetKey != null) {
      final context = step.targetKey!.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        setState(() {
          _targetRect = Rect.fromLTWH(
            position.dx,
            position.dy,
            renderBox.size.width,
            renderBox.size.height,
          );
        });
      }
    } else if (step.targetRect != null) {
      setState(() {
        _targetRect = step.targetRect;
      });
    } else {
      setState(() {
        _targetRect = null;
      });
    }

    step.onShow?.call();
    widget.onStepChange?.call(step);
  }

  Widget _buildOverlay() {
    final theme = widget.theme ?? ZephyrTourTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: Stack(
        key: _overlayKey,
        children: [
          // Overlay background
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                if (widget.allowSkip) {
                  _skipTour();
                }
              },
              child: CustomPaint(
                painter: _TourOverlayPainter(
                  targetRect: _targetRect,
                  overlayColor: widget.overlayColor,
                  highlightPadding: widget.highlightPadding,
                  highlightBorderRadius: widget.highlightBorderRadius,
                ),
              ),
            ),
          ),

          // Tour tooltip
          if (_targetRect != null)
            Positioned(
              left: _targetRect!.left + widget.tooltipOffset.dx,
              top: _targetRect!.bottom + widget.tooltipOffset.dy,
              child: _buildTooltip(theme),
            )
          else
            Center(
              child: _buildTooltip(theme),
            ),
        ],
      ),
    );
  }

  Widget _buildTooltip(ZephyrTourTheme theme) {
    if (_currentStepIndex >= _steps.length) return const SizedBox();

    final step = _steps[_currentStepIndex];

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 64,
        minWidth: 280,
      ),
      child: Card(
        elevation: theme.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.borderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: theme.headerPadding,
              decoration: BoxDecoration(
                color: theme.headerColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(theme.borderRadius),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.showStepNumbers)
                    Text(
                      '${_currentStepIndex + 1} / ${_steps.length}',
                      style: theme.stepNumberStyle,
                    ),
                  const SizedBox(height: 4),
                  Text(
                    step.title,
                    style: theme.titleStyle,
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: theme.contentPadding,
              child: step.customWidget ??
                  Text(
                    step.content,
                    style: theme.contentStyle,
                  ),
            ),

            // Progress
            if (widget.showProgress && _steps.length > 1)
              Padding(
                padding: theme.progressPadding,
                child: LinearProgressIndicator(
                  value: (_currentStepIndex + 1) / _steps.length,
                  backgroundColor: theme.progressBackgroundColor,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(theme.progressColor),
                ),
              ),

            // Actions
            Padding(
              padding: theme.actionPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous button
                  if (widget.showPreviousButton && _currentStepIndex > 0)
                    TextButton(
                      onPressed: _previousStep,
                      child: Text(theme.previousButtonText),
                    )
                  else
                    const SizedBox(width: 80),

                  // Skip button
                  if (widget.showSkipButton && widget.allowSkip)
                    TextButton(
                      onPressed: _skipTour,
                      child: Text(theme.skipButtonText),
                    ),

                  // Next button
                  if (widget.showNextButton)
                    ElevatedButton(
                      onPressed: _nextStep,
                      child: Text(
                        _currentStepIndex == _steps.length - 1
                            ? theme.completeButtonText
                            : theme.nextButtonText,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextStep() {
    if (_currentStepIndex >= _steps.length) return;

    final step = _steps[_currentStepIndex];
    step.onComplete?.call();

    if (_currentStepIndex == _steps.length - 1) {
      _completeTour();
    } else {
      setState(() {
        _currentStepIndex++;
      });
      _updateTargetRect();
    }
  }

  void _previousStep() {
    if (_currentStepIndex <= 0) return;

    setState(() {
      _currentStepIndex--;
    });
    _updateTargetRect();
  }

  void _skipTour() {
    final step = _steps[_currentStepIndex];
    step.onSkip?.call();

    widget.onTourSkip?.call();
    _endTour();
  }

  void _completeTour() {
    widget.onTourComplete?.call();
    _endTour();
  }

  void _endTour() {
    setState(() {
      _isTourActive = false;
    });
    _removeOverlay();
  }
}

/// Tour overlay painter
class _TourOverlayPainter extends CustomPainter {
  _TourOverlayPainter({
    required this.overlayColor,
    required this.highlightPadding,
    required this.highlightBorderRadius,
    this.targetRect,
  });
  final Rect? targetRect;
  final Color overlayColor;
  final double highlightPadding;
  final double highlightBorderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    if (targetRect != null) {
      final highlightRect = targetRect!.inflate(highlightPadding);

      // Create a path for the highlight area
      final path = Path()
        ..addRRect(RRect.fromRectAndRadius(
          highlightRect,
          Radius.circular(highlightBorderRadius),
        ));

      // Clear the highlight area
      canvas.saveLayer(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint(),
      );
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
      canvas.drawPath(
        path,
        Paint()
          ..blendMode = BlendMode.clear
          ..color = Colors.transparent,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _TourOverlayPainter oldDelegate) {
    return oldDelegate.targetRect != targetRect ||
        oldDelegate.overlayColor != overlayColor ||
        oldDelegate.highlightPadding != highlightPadding ||
        oldDelegate.highlightBorderRadius != highlightBorderRadius;
  }
}

/// Tour persistence mode
enum ZephyrTourPersistence {
  /// No persistence
  none,

  /// Store in shared preferences
  sharedPreferences,

  /// Store in memory
  memory,
}

/// Tour controller for managing tour state
class ZephyrTourController {
  ZephyrTourController(this.steps);
  final List<ZephyrTourStep> steps;
  int currentStepIndex = 0;
  bool isTourActive = false;

  void startTour() {
    isTourActive = true;
    currentStepIndex = 0;
  }

  void nextStep() {
    if (currentStepIndex < steps.length - 1) {
      currentStepIndex++;
    }
  }

  void previousStep() {
    if (currentStepIndex > 0) {
      currentStepIndex--;
    }
  }

  void skipTour() {
    isTourActive = false;
  }

  void completeTour() {
    isTourActive = false;
  }

  void goToStep(int index) {
    if (index >= 0 && index < steps.length) {
      currentStepIndex = index;
    }
  }

  ZephyrTourStep? get currentStep {
    if (currentStepIndex >= 0 && currentStepIndex < steps.length) {
      return steps[currentStepIndex];
    }
    return null;
  }
}
