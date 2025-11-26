import 'package:flutter/material.dart';
import 'dart:math' as math;

class ZephyrTimeline extends StatelessWidget {
  const ZephyrTimeline({
    required this.items,
    super.key,
    this.type = TimelineType.left,
    this.showConnectionLines = true,
    this.lineColor,
    this.dotColor,
    this.dotSize,
    this.reverse = false,
    this.header,
    this.footer,
  });
  final List<TimelineItem> items;
  final TimelineType type;
  final bool showConnectionLines;
  final Color? lineColor;
  final Color? dotColor;
  final double? dotSize;
  final bool reverse;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final effectiveItems = reverse ? items.reversed.toList() : items;

    return Column(
      children: [
        if (header != null) header!,
        _buildTimeline(context, effectiveItems),
        if (footer != null) footer!,
      ],
    );
  }

  Widget _buildTimeline(BuildContext context, List<TimelineItem> items) {
    switch (type) {
      case TimelineType.left:
        return _buildLeftTimeline(context, items);
      case TimelineType.right:
        return _buildRightTimeline(context, items);
      case TimelineType.alternate:
        return _buildAlternateTimeline(context, items);
      case TimelineType.center:
        return _buildCenterTimeline(context, items);
      default:
        return _buildLeftTimeline(context, items);
    }
  }

  Widget _buildLeftTimeline(BuildContext context, List<TimelineItem> items) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == items.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimelineDot(item, index),
            if (showConnectionLines && !isLast) _buildVerticalLine(),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTimelineContent(item),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildRightTimeline(BuildContext context, List<TimelineItem> items) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == items.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTimelineContent(item),
            ),
            const SizedBox(width: 16),
            if (showConnectionLines && !isLast) _buildVerticalLine(),
            _buildTimelineDot(item, index),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildAlternateTimeline(
      BuildContext context, List<TimelineItem> items) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == items.length - 1;
        final isLeft = index % 2 == 0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLeft) ...[
              Expanded(
                child: Container(),
              ),
              const SizedBox(width: 16),
            ],
            _buildTimelineDot(item, index),
            if (showConnectionLines && !isLast) _buildVerticalLine(),
            const SizedBox(width: 16),
            Expanded(
              child: isLeft ? _buildTimelineContent(item) : Container(),
            ),
            if (!isLeft) ...[
              const SizedBox(width: 16),
              Expanded(
                child: _buildTimelineContent(item),
              ),
            ],
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCenterTimeline(BuildContext context, List<TimelineItem> items) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == items.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTimelineContent(item),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                _buildTimelineDot(item, index),
                if (showConnectionLines && !isLast) _buildVerticalLine(),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTimelineContent(item),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTimelineDot(TimelineItem item, int index) {
    final effectiveDotColor =
        item.dotColor ?? dotColor ?? Theme.of(item.context!).primaryColor;
    final effectiveDotSize = item.dotSize ?? dotSize ?? 16;

    return Container(
      width: effectiveDotSize,
      height: effectiveDotSize,
      decoration: BoxDecoration(
        color: effectiveDotColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: item.dotIcon != null
          ? Icon(
              item.dotIcon,
              size: effectiveDotSize * 0.6,
              color: Colors.white,
            )
          : null,
    );
  }

  Widget _buildVerticalLine() {
    return Container(
      width: 2,
      height: 40,
      color: lineColor ?? Colors.grey[300],
    );
  }

  Widget _buildTimelineContent(TimelineItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (item.trailing != null) item.trailing!,
              ],
            ),
            if (item.subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                item.subtitle!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
            if (item.content != null) ...[
              const SizedBox(height: 8),
              item.content!,
            ],
            if (item.footer != null) ...[
              const SizedBox(height: 8),
              item.footer!,
            ],
          ],
        ),
      ),
    );
  }
}

class TimelineItem {
  TimelineItem({
    required this.title,
    this.context,
    this.subtitle,
    this.content,
    this.footer,
    this.trailing,
    this.dotIcon,
    this.dotColor,
    this.dotSize,
  });
  final BuildContext? context;
  final String title;
  final String? subtitle;
  final Widget? content;
  final Widget? footer;
  final Widget? trailing;
  final IconData? dotIcon;
  final Color? dotColor;
  final double? dotSize;
}

enum TimelineType {
  left,
  right,
  alternate,
  center,
}

class ZephyrProcessTimeline extends StatefulWidget {
  const ZephyrProcessTimeline({
    required this.steps,
    required this.currentStep,
    super.key,
    this.onStepChanged,
    this.style = ProcessTimelineStyle.horizontal,
    this.activeColor,
    this.inactiveColor,
    this.showStepNumbers = true,
    this.allowStepSelection = false,
  });
  final List<ProcessStep> steps;
  final int currentStep;
  final ValueChanged<int>? onStepChanged;
  final ProcessTimelineStyle style;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showStepNumbers;
  final bool allowStepSelection;

  @override
  State<ZephyrProcessTimeline> createState() => _ZephyrProcessTimelineState();
}

class _ZephyrProcessTimelineState extends State<ZephyrProcessTimeline> {
  @override
  Widget build(BuildContext context) {
    switch (widget.style) {
      case ProcessTimelineStyle.horizontal:
        return _buildHorizontalTimeline();
      case ProcessTimelineStyle.vertical:
        return _buildVerticalTimeline();
      case ProcessTimelineStyle.circular:
        return _buildCircularTimeline();
    }
  }

  Widget _buildHorizontalTimeline() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isActive = index <= widget.currentStep;
          final isCompleted = index < widget.currentStep;

          return Row(
            children: [
              _buildProcessStep(step, index, isActive, isCompleted),
              if (index < widget.steps.length - 1)
                _buildHorizontalConnector(isCompleted),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVerticalTimeline() {
    return Column(
      children: widget.steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isActive = index <= widget.currentStep;
        final isCompleted = index < widget.currentStep;

        return Column(
          children: [
            Row(
              children: [
                _buildProcessStep(step, index, isActive, isCompleted),
                if (index < widget.steps.length - 1)
                  _buildVerticalConnector(isCompleted),
              ],
            ),
            if (step.content != null)
              Padding(
                padding: const EdgeInsets.only(left: 32, top: 8, bottom: 24),
                child: step.content!,
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCircularTimeline() {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        children: [
          // 背景圆环
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.inactiveColor ?? Colors.grey[300]!,
                  width: 8,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 进度圆环
          Center(
            child: CustomPaint(
              painter: CircularProgressPainter(
                progress: (widget.currentStep + 1) / widget.steps.length,
                color: widget.activeColor ?? Theme.of(context).primaryColor,
              ),
              child: const SizedBox(
                width: 200,
                height: 200,
              ),
            ),
          ),
          // 步骤点
          ...widget.steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final angle =
                (index / widget.steps.length) * 2 * math.pi - math.pi / 2;
            const radius = 100;
            final x = radius * math.cos(angle) + 150;
            final y = radius * math.sin(angle) + 150;

            return Positioned(
              left: x - 16,
              top: y - 16,
              child: _buildProcessStep(step, index, index <= widget.currentStep,
                  index < widget.currentStep),
            );
          }).toList(),
          // 中心内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.currentStep + 1}',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '/ ${widget.steps.length}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessStep(
      ProcessStep step, int index, bool isActive, bool isCompleted) {
    final effectiveActiveColor =
        widget.activeColor ?? Theme.of(context).primaryColor;
    final effectiveInactiveColor = widget.inactiveColor ?? Colors.grey[300];

    return GestureDetector(
      onTap: widget.allowStepSelection
          ? () => widget.onStepChanged?.call(index)
          : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? effectiveActiveColor : effectiveInactiveColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: widget.showStepNumbers
              ? Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                )
              : (isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null),
        ),
      ),
    );
  }

  Widget _buildHorizontalConnector(bool isCompleted) {
    return Container(
      width: 40,
      height: 4,
      color: isCompleted
          ? (widget.activeColor ?? Theme.of(context).primaryColor)
          : (widget.inactiveColor ?? Colors.grey[300]),
    );
  }

  Widget _buildVerticalConnector(bool isCompleted) {
    return Container(
      width: 4,
      height: 40,
      color: isCompleted
          ? (widget.activeColor ?? Theme.of(context).primaryColor)
          : (widget.inactiveColor ?? Colors.grey[300]),
    );
  }
}

class ProcessStep {
  ProcessStep({
    required this.title,
    this.subtitle,
    this.content,
  });
  final String title;
  final String? subtitle;
  final Widget? content;
}

enum ProcessTimelineStyle {
  horizontal,
  vertical,
  circular,
}

class CircularProgressPainter extends CustomPainter {
  CircularProgressPainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;

    // 背景圆环
    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius, backgroundPaint);

    // 进度圆环
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = progress * 2 * math.pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
