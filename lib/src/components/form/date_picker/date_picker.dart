import 'package:flutter/material.dart';
import 'date_picker_theme.dart';
import 'package:intl/intl.dart';

/// 日期选择器选择模式
enum ZephyrDatePickerMode {
  /// 单个日期选择
  single,

  /// 日期范围选择
  range,
}

/// 日期选择器组件
///
/// 允许用户选择单个日期或日期范围
class ZephyrDatePicker extends StatefulWidget {
  /// 初始选中日期
  final DateTime? initialDate;

  /// 初始开始日期（范围模式）
  final DateTime? initialStartDate;

  /// 初始结束日期（范围模式）
  final DateTime? initialEndDate;

  /// 最早可选日期
  final DateTime firstDate;

  /// 最晚可选日期
  final DateTime lastDate;

  /// 选择模式
  final ZephyrDatePickerMode mode;

  /// 选择单个日期后回调
  final Function(DateTime)? onDateSelected;

  /// 选择日期范围后回调
  final Function(DateTime, DateTime)? onDateRangeSelected;

  /// 当前日期
  final DateTime? currentDate;

  /// 禁用的日期列表
  final List<DateTime>? disabledDates;

  /// 自定义日期构建器
  final Widget Function(BuildContext, DateTime, bool)? dateBuilder;

  /// 是否显示周末
  final bool showWeekends;

  /// 是否显示前一个月的日期
  final bool showLeadingDates;

  /// 是否显示后一个月的日期
  final bool showTrailingDates;

  /// 星期标题
  final List<String>? weekdayLabels;

  /// 月份标题格式
  final String? monthFormat;

  /// 是否显示重置按钮
  final bool showResetButton;

  /// 自定义主题
  final ZephyrDatePickerTheme? theme;

  /// 创建日期选择器
  const ZephyrDatePicker({
    Key? key,
    this.initialDate,
    this.initialStartDate,
    this.initialEndDate,
    required this.firstDate,
    required this.lastDate,
    this.mode = ZephyrDatePickerMode.single,
    this.onDateSelected,
    this.onDateRangeSelected,
    this.currentDate,
    this.disabledDates,
    this.dateBuilder,
    this.showWeekends = true,
    this.showLeadingDates = true,
    this.showTrailingDates = true,
    this.weekdayLabels,
    this.monthFormat,
    this.showResetButton = true,
    this.theme,
  }) : super(key: key);

  @override
  State<ZephyrDatePicker> createState() => _ZephyrDatePickerState();
}

class _ZephyrDatePickerState extends State<ZephyrDatePicker> {
  late DateTime _currentMonth;
  late DateTime? _selectedDate;
  late DateTime? _rangeStartDate;
  late DateTime? _rangeEndDate;
  late final ZephyrDatePickerTheme _theme;

  final List<String> _defaultWeekdayLabels = [
    '日',
    '一',
    '二',
    '三',
    '四',
    '五',
    '六'
  ];
  final DateFormat _defaultMonthFormat = DateFormat('yyyy年MM月');

  @override
  void initState() {
    super.initState();

    // 初始化当前显示月份
    if (widget.initialDate != null) {
      _currentMonth =
          DateTime(widget.initialDate!.year, widget.initialDate!.month, 1);
    } else if (widget.initialStartDate != null) {
      _currentMonth = DateTime(
          widget.initialStartDate!.year, widget.initialStartDate!.month, 1);
    } else {
      _currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    }

    // 初始化选中日期
    _selectedDate = widget.initialDate;
    _rangeStartDate = widget.initialStartDate;
    _rangeEndDate = widget.initialEndDate;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = widget.theme ?? ZephyrDatePickerTheme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        _buildCalendar(),
        _buildFooter(),
      ],
    );
  }

  /// 构建日历头部
  Widget _buildHeader() {
    final monthFormat = widget.monthFormat != null
        ? DateFormat(widget.monthFormat!)
        : _defaultMonthFormat;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: _theme.headerBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_currentMonth.year}年',
                  style: _theme.headerYearStyle,
                ),
                const SizedBox(height: 4),
                Text(
                  monthFormat
                      .format(_currentMonth)
                      .replaceAll(_currentMonth.year.toString(), '')
                      .trim(),
                  style: _theme.headerMonthStyle,
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _previousMonth,
                color: _theme.headerTextColor,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextMonth,
                color: _theme.headerTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建日历主体
  Widget _buildCalendar() {
    final List<Widget> dayLabels =
        (widget.weekdayLabels ?? _defaultWeekdayLabels)
            .map((label) => Container(
                  width: _theme.dateCellSize,
                  height: _theme.dateCellSize * 0.7,
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: _theme.weekdayStyle,
                  ),
                ))
            .toList();

    final List<Widget> days = _buildDays();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: dayLabels,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: _theme.dateCellSpacing,
            runSpacing: _theme.dateCellSpacing,
            children: days,
          ),
        ),
      ],
    );
  }

  /// 构建所有日期
  List<Widget> _buildDays() {
    final List<Widget> days = [];

    // 获取当前月的第一天是星期几（0为星期日）
    final int firstWeekday = _currentMonth.weekday;
    final int daysInPreviousMonth = _getPreviousMonthDays();

    // 添加上个月的日期
    if (widget.showLeadingDates) {
      final int prevMonthStart = daysInPreviousMonth - (firstWeekday % 7) + 1;

      for (int i = prevMonthStart; i <= daysInPreviousMonth; i++) {
        final DateTime date = DateTime(
          _currentMonth.year,
          _currentMonth.month - 1,
          i,
        );
        days.add(_buildDay(date, true));
      }
    } else {
      // 如果不显示上个月的日期，添加空白占位
      for (int i = 0; i < (firstWeekday % 7); i++) {
        days.add(
            SizedBox(width: _theme.dateCellSize, height: _theme.dateCellSize));
      }
    }

    // 添加当前月的日期
    final int daysInMonth =
        _getDaysInMonth(_currentMonth.year, _currentMonth.month);
    for (int i = 1; i <= daysInMonth; i++) {
      final DateTime date =
          DateTime(_currentMonth.year, _currentMonth.month, i);
      days.add(_buildDay(date, false));
    }

    // 添加下个月的日期（直到填满整个日历）
    if (widget.showTrailingDates) {
      final int remainingDays = 42 - days.length; // 6 rows * 7 days
      for (int i = 1; i <= remainingDays; i++) {
        final DateTime date = DateTime(
          _currentMonth.year,
          _currentMonth.month + 1,
          i,
        );
        days.add(_buildDay(date, true));
      }
    }

    return days;
  }

  /// 构建单个日期单元格
  Widget _buildDay(DateTime date, bool outsideMonth) {
    // 检查日期是否被禁用
    final bool isDisabled = _isDateDisabled(date);

    // 检查日期是否为周末
    final bool isWeekend =
        date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

    // 如果不显示周末且是周末，则禁用该日期
    if (!widget.showWeekends && isWeekend) {
      return SizedBox(width: _theme.dateCellSize, height: _theme.dateCellSize);
    }

    // 检查是否为当前日期
    final bool isCurrent = widget.currentDate != null &&
        date.year == widget.currentDate!.year &&
        date.month == widget.currentDate!.month &&
        date.day == widget.currentDate!.day;

    // 检查日期是否被选中
    bool isSelected = false;
    bool isInRange = false;

    if (widget.mode == ZephyrDatePickerMode.single) {
      isSelected = _selectedDate != null &&
          date.year == _selectedDate!.year &&
          date.month == _selectedDate!.month &&
          date.day == _selectedDate!.day;
    } else {
      // 检查是否为范围的开始或结束日期
      final bool isRangeStart = _rangeStartDate != null &&
          date.year == _rangeStartDate!.year &&
          date.month == _rangeStartDate!.month &&
          date.day == _rangeStartDate!.day;

      final bool isRangeEnd = _rangeEndDate != null &&
          date.year == _rangeEndDate!.year &&
          date.month == _rangeEndDate!.month &&
          date.day == _rangeEndDate!.day;

      isSelected = isRangeStart || isRangeEnd;

      // 检查日期是否在选中的范围内
      if (_rangeStartDate != null && _rangeEndDate != null) {
        final DateTime startDate = DateTime(_rangeStartDate!.year,
            _rangeStartDate!.month, _rangeStartDate!.day);
        final DateTime endDate = DateTime(
            _rangeEndDate!.year, _rangeEndDate!.month, _rangeEndDate!.day);
        final DateTime checkDate = DateTime(date.year, date.month, date.day);

        isInRange = checkDate.isAfter(startDate) && checkDate.isBefore(endDate);
      }
    }

    // 自定义日期构建器
    if (widget.dateBuilder != null) {
      return widget.dateBuilder!(context, date, isSelected);
    }

    // 日期文本样式
    TextStyle textStyle = _theme.dateStyle;

    if (outsideMonth) {
      textStyle = textStyle.copyWith(color: _theme.disabledDateTextColor);
    } else if (isDisabled) {
      textStyle = textStyle.copyWith(color: _theme.disabledDateTextColor);
    } else if (isWeekend && !isSelected) {
      textStyle = textStyle.copyWith(color: _theme.weekendDateTextColor);
    }

    if (isSelected) {
      textStyle = _theme.selectedDateStyle;
    } else if (isCurrent) {
      textStyle = textStyle.copyWith(color: _theme.currentDateTextColor);
    }

    // 背景颜色
    Color? backgroundColor;

    if (isSelected) {
      backgroundColor = _theme.selectedDateBackgroundColor;
    } else if (isCurrent) {
      backgroundColor = _theme.currentDateBackgroundColor;
    } else if (isInRange) {
      backgroundColor = _theme.rangeDateBackgroundColor;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : () => _onDateTap(date),
        borderRadius: BorderRadius.circular(_theme.dateCellBorderRadius),
        child: Container(
          width: _theme.dateCellSize,
          height: _theme.dateCellSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(_theme.dateCellBorderRadius),
          ),
          child: Text(
            date.day.toString(),
            style: textStyle,
          ),
        ),
      ),
    );
  }

  /// 构建底部操作区域
  Widget _buildFooter() {
    final bool hasSelection = widget.mode == ZephyrDatePickerMode.single
        ? _selectedDate != null
        : _rangeStartDate != null && _rangeEndDate != null;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.showResetButton) ...[
            TextButton(
              onPressed: _onReset,
              child: Text(
                _theme.resetButtonText,
                style: _theme.buttonTextStyle,
              ),
            ),
            const SizedBox(width: 8),
          ],
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              _theme.cancelButtonText,
              style: _theme.buttonTextStyle,
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: hasSelection ? _onConfirm : null,
            child: Text(
              _theme.confirmButtonText,
              style: hasSelection
                  ? _theme.buttonTextStyle
                  : _theme.disabledButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  /// 处理日期点击事件
  void _onDateTap(DateTime date) {
    if (widget.mode == ZephyrDatePickerMode.single) {
      setState(() {
        _selectedDate = date;
      });
    } else {
      if (_rangeStartDate == null ||
          (_rangeStartDate != null && _rangeEndDate != null)) {
        setState(() {
          _rangeStartDate = date;
          _rangeEndDate = null;
        });
      } else {
        if (date.isBefore(_rangeStartDate!)) {
          setState(() {
            _rangeEndDate = _rangeStartDate;
            _rangeStartDate = date;
          });
        } else {
          setState(() {
            _rangeEndDate = date;
          });
        }
      }
    }
  }

  /// 确认选择
  void _onConfirm() {
    if (widget.mode == ZephyrDatePickerMode.single && _selectedDate != null) {
      widget.onDateSelected?.call(_selectedDate!);
    } else if (widget.mode == ZephyrDatePickerMode.range &&
        _rangeStartDate != null &&
        _rangeEndDate != null) {
      widget.onDateRangeSelected?.call(_rangeStartDate!, _rangeEndDate!);
    }

    Navigator.of(context).pop();
  }

  /// 重置选择
  void _onReset() {
    setState(() {
      _selectedDate = null;
      _rangeStartDate = null;
      _rangeEndDate = null;
    });
  }

  /// 切换到上个月
  void _previousMonth() {
    setState(() {
      if (_currentMonth.month == 1) {
        _currentMonth = DateTime(_currentMonth.year - 1, 12, 1);
      } else {
        _currentMonth =
            DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
      }
    });
  }

  /// 切换到下个月
  void _nextMonth() {
    setState(() {
      if (_currentMonth.month == 12) {
        _currentMonth = DateTime(_currentMonth.year + 1, 1, 1);
      } else {
        _currentMonth =
            DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
      }
    });
  }

  /// 检查日期是否被禁用
  bool _isDateDisabled(DateTime date) {
    // 检查日期是否在可选范围内
    if (date.isBefore(widget.firstDate) || date.isAfter(widget.lastDate)) {
      return true;
    }

    // 检查日期是否在禁用列表中
    if (widget.disabledDates != null) {
      for (final DateTime disabledDate in widget.disabledDates!) {
        if (date.year == disabledDate.year &&
            date.month == disabledDate.month &&
            date.day == disabledDate.day) {
          return true;
        }
      }
    }

    return false;
  }

  /// 获取指定年月的天数
  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  /// 获取上个月的天数
  int _getPreviousMonthDays() {
    if (_currentMonth.month == 1) {
      return _getDaysInMonth(_currentMonth.year - 1, 12);
    } else {
      return _getDaysInMonth(_currentMonth.year, _currentMonth.month - 1);
    }
  }
}

/// 显示日期选择器对话框
Future<DateTime?> showZephyrDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  DateTime? currentDate,
  List<DateTime>? disabledDates,
  ZephyrDatePickerTheme? theme,
}) async {
  final DateTime? result = await showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 360.0,
            maxHeight: 500.0,
          ),
          child: ZephyrDatePicker(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
            mode: ZephyrDatePickerMode.single,
            currentDate: currentDate,
            disabledDates: disabledDates,
            theme: theme,
          ),
        ),
      );
    },
  );

  return result;
}

/// 显示日期范围选择器对话框
Future<DateTimeRange?> showZephyrDateRangePicker({
  required BuildContext context,
  DateTime? initialStartDate,
  DateTime? initialEndDate,
  required DateTime firstDate,
  required DateTime lastDate,
  DateTime? currentDate,
  List<DateTime>? disabledDates,
  ZephyrDatePickerTheme? theme,
}) async {
  final result = await showDialog<List<DateTime>>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 360.0,
            maxHeight: 500.0,
          ),
          child: ZephyrDatePicker(
            initialStartDate: initialStartDate,
            initialEndDate: initialEndDate,
            firstDate: firstDate,
            lastDate: lastDate,
            mode: ZephyrDatePickerMode.range,
            currentDate: currentDate,
            disabledDates: disabledDates,
            theme: theme,
            onDateRangeSelected: (start, end) {
              Navigator.of(context).pop([start, end]);
            },
          ),
        ),
      );
    },
  );

  if (result != null && result.length == 2) {
    return DateTimeRange(start: result[0], end: result[1]);
  }

  return null;
}
