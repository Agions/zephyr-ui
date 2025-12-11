/// VelocityUI 日期选择器组件
library velocity_date_picker;

import 'package:flutter/material.dart';
import '../input/input.dart';
import '../input/input_style.dart';
import 'date_picker_style.dart';

export 'date_picker_style.dart';

/// VelocityUI 日期选择器组件
enum VelocityDatePickerType {
  /// 仅日期选择
  date,
  /// 仅时间选择
  time,
  /// 日期时间选择
  datetime,
}

/// VelocityUI 日期选择器组件
class VelocityDatePicker extends StatefulWidget {
  /// 创建日期选择器组件
  const VelocityDatePicker({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefixIcon = Icons.calendar_today,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.format,
    this.type = VelocityDatePickerType.date,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.onDateSelected,
    this.style,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool enabled;
  final bool readOnly;
  final String? format;
  final VelocityDatePickerType type;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<String>? onChanged;
  final ValueChanged<DateTime>? onDateSelected;
  final VelocityDatePickerStyle? style;

  @override
  State<VelocityDatePicker> createState() => _VelocityDatePickerState();
}

class _VelocityDatePickerState extends State<VelocityDatePicker> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _showDatePicker() async {
    final now = DateTime.now();
    final initialDate = widget.initialDate ?? now;
    final firstDate = widget.firstDate ?? now.subtract(const Duration(days: 365 * 10));
    final lastDate = widget.lastDate ?? now.add(const Duration(days: 365 * 10));

    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    if (widget.type == VelocityDatePickerType.date || widget.type == VelocityDatePickerType.datetime) {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            child: child!, 
          );
        },
      );
    } else {
      selectedDate = initialDate;
    }

    if (selectedDate != null && (widget.type == VelocityDatePickerType.time || widget.type == VelocityDatePickerType.datetime)) {
      selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            child: child!, 
          );
        },
      );
    } else if (widget.type == VelocityDatePickerType.date) {
      selectedTime = TimeOfDay.fromDateTime(initialDate);
    }

    if (selectedDate != null && selectedTime != null) {
      final DateTime finalDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      String formattedDate;
      if (widget.format != null) {
        formattedDate = _formatDate(finalDate, widget.format!);
      } else {
        switch (widget.type) {
          case VelocityDatePickerType.date:
            formattedDate = '${finalDate.year}-${finalDate.month.toString().padLeft(2, '0')}-${finalDate.day.toString().padLeft(2, '0')}';
            break;
          case VelocityDatePickerType.time:
            formattedDate = '${finalDate.hour.toString().padLeft(2, '0')}:${finalDate.minute.toString().padLeft(2, '0')}';
            break;
          case VelocityDatePickerType.datetime:
            formattedDate = '${finalDate.year}-${finalDate.month.toString().padLeft(2, '0')}-${finalDate.day.toString().padLeft(2, '0')} ${finalDate.hour.toString().padLeft(2, '0')}:${finalDate.minute.toString().padLeft(2, '0')}';
            break;
        }
      }

      _controller.text = formattedDate;
      widget.onChanged?.call(formattedDate);
      widget.onDateSelected?.call(finalDate);
    }
  }

  String _formatDate(DateTime date, String format) {
    return format
        .replaceAll('yyyy', date.year.toString())
        .replaceAll('MM', date.month.toString().padLeft(2, '0'))
        .replaceAll('dd', date.day.toString().padLeft(2, '0'))
        .replaceAll('HH', date.hour.toString().padLeft(2, '0'))
        .replaceAll('mm', date.minute.toString().padLeft(2, '0'))
        .replaceAll('ss', date.second.toString().padLeft(2, '0'));
  }

  @override
  Widget build(BuildContext context) {
    return VelocityInput(
      controller: _controller,
      focusNode: _focusNode,
      label: widget.label,
      hint: widget.hint,
      helper: widget.helper,
      error: widget.error,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.enabled && !widget.readOnly ? _showDatePicker : null,
      style: widget.style,
    );
  }
}

/// VelocityUI 时间选择器组件
class VelocityTimePicker extends StatelessWidget {
  /// 创建时间选择器组件
  const VelocityTimePicker({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefixIcon = Icons.access_time,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.format,
    this.initialTime,
    this.onChanged,
    this.onTimeSelected,
    this.style,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool enabled;
  final bool readOnly;
  final String? format;
  final TimeOfDay? initialTime;
  final ValueChanged<String>? onChanged;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final VelocityDatePickerStyle? style;

  @override
  Widget build(BuildContext context) {
    return VelocityDatePicker(
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      helper: helper,
      error: error,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabled: enabled,
      readOnly: readOnly,
      format: format,
      type: VelocityDatePickerType.time,
      initialDate: initialTime != null
          ? DateTime.now().copyWith(hour: initialTime!.hour, minute: initialTime!.minute)
          : null,
      onChanged: onChanged,
      onDateSelected: (date) {
        onTimeSelected?.call(TimeOfDay.fromDateTime(date));
      },
      style: style,
    );
  }
}
