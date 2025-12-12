/// VelocityUI 日历组件
library velocity_calendar;

import 'dart:collection';
import 'package:flutter/material.dart';
import 'calendar_style.dart';

/// 日历控制器
class VelocityCalendarController {
  /// 创建日历控制器
  VelocityCalendarController({
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    VelocityCalendarSelectionMode initialSelectionMode =
        VelocityCalendarSelectionMode.single,
    VelocityCalendarViewMode initialViewMode = VelocityCalendarViewMode.month,
    DateTime? selectedDate,
    List<DateTime>? selectedDates,
    DateTime? startDate,
    DateTime? endDate,
  })  : _currentDate = initialDate ?? DateTime.now(),
        _minDate = minDate ?? DateTime(1900),
        _maxDate = maxDate ?? DateTime(2100),
        _selectionMode = initialSelectionMode,
        _viewMode = initialViewMode,
        _selectedDate = selectedDate,
        _selectedDates = selectedDates ?? [],
        _startDate = startDate,
        _endDate = endDate;

  DateTime _currentDate;
  DateTime get currentDate => _currentDate;

  set currentDate(DateTime date) {
    _currentDate = date;
    _updateListeners();
  }

  DateTime _minDate;
  DateTime get minDate => _minDate;

  set minDate(DateTime date) {
    _minDate = date;
    _updateListeners();
  }

  DateTime _maxDate;
  DateTime get maxDate => _maxDate;

  set maxDate(DateTime date) {
    _maxDate = date;
    _updateListeners();
  }

  VelocityCalendarSelectionMode _selectionMode;
  VelocityCalendarSelectionMode get selectionMode => _selectionMode;

  set selectionMode(VelocityCalendarSelectionMode mode) {
    _selectionMode = mode;
    _updateListeners();
  }

  VelocityCalendarViewMode _viewMode;
  VelocityCalendarViewMode get viewMode => _viewMode;

  set viewMode(VelocityCalendarViewMode mode) {
    _viewMode = mode;
    _updateListeners();
  }

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? date) {
    _selectedDate = date;
    _updateListeners();
  }

  List<DateTime> _selectedDates;
  List<DateTime> get selectedDates => UnmodifiableListView(_selectedDates);

  set selectedDates(List<DateTime> dates) {
    _selectedDates = dates;
    _updateListeners();
  }

  DateTime? _startDate;
  DateTime? get startDate => _startDate;

  set startDate(DateTime? date) {
    _startDate = date;
    _updateListeners();
  }

  DateTime? _endDate;
  DateTime? get endDate => _endDate;

  set endDate(DateTime? date) {
    _endDate = date;
    _updateListeners();
  }

  final List<ValueChanged<VelocityCalendarController>> _listeners = [];

  void addListener(ValueChanged<VelocityCalendarController> listener) {
    _listeners.add(listener);
  }

  void removeListener(ValueChanged<VelocityCalendarController> listener) {
    _listeners.remove(listener);
  }

  void _updateListeners() {
    for (final listener in _listeners) {
      listener(this);
    }
  }

  /// 跳转到指定日期
  void jumpToDate(DateTime date) {
    currentDate = date;
  }

  /// 跳转到今天
  void jumpToToday() {
    currentDate = DateTime.now();
  }

  /// 上一个月
  void previousMonth() {
    currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
  }

  /// 下一个月
  void nextMonth() {
    currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
  }

  /// 上一年
  void previousYear() {
    currentDate = DateTime(currentDate.year - 1, currentDate.month, 1);
  }

  /// 下一年
  void nextYear() {
    currentDate = DateTime(currentDate.year + 1, currentDate.month, 1);
  }

  /// 切换视图模式
  void toggleViewMode() {
    viewMode = viewMode == VelocityCalendarViewMode.month
        ? VelocityCalendarViewMode.year
        : VelocityCalendarViewMode.month;
  }

  /// 选择日期
  void selectDate(DateTime date) {
    if (date.isBefore(minDate) || date.isAfter(maxDate)) return;

    switch (selectionMode) {
      case VelocityCalendarSelectionMode.single:
        selectedDate = date;
        startDate = null;
        endDate = null;
        break;
      case VelocityCalendarSelectionMode.range:
        if (startDate == null || (startDate != null && endDate != null)) {
          startDate = date;
          endDate = null;
        } else if (endDate == null) {
          if (date.isAfter(startDate!)) {
            endDate = date;
          } else {
            endDate = startDate;
            startDate = date;
          }
        }
        selectedDate = null;
        break;
      case VelocityCalendarSelectionMode.multiple:
        if (_selectedDates.any((d) => isSameDay(d, date))) {
          _selectedDates.removeWhere((d) => isSameDay(d, date));
        } else {
          _selectedDates.add(date);
        }
        selectedDate = null;
        startDate = null;
        endDate = null;
        break;
      case VelocityCalendarSelectionMode.none:
        break;
    }

    _updateListeners();
  }

  /// 清除选择
  void clearSelection() {
    selectedDate = null;
    selectedDates = [];
    startDate = null;
    endDate = null;
  }

  /// 检查日期是否选中
  bool isSelected(DateTime date) {
    if (selectionMode == VelocityCalendarSelectionMode.single) {
      return selectedDate != null && isSameDay(selectedDate!, date);
    } else if (selectionMode == VelocityCalendarSelectionMode.range) {
      return (startDate != null &&
              endDate != null &&
              (isSameDay(startDate!, date) || isSameDay(endDate!, date))) ||
          (startDate != null && endDate == null && isSameDay(startDate!, date));
    } else if (selectionMode == VelocityCalendarSelectionMode.multiple) {
      return selectedDates.any((d) => isSameDay(d, date));
    }
    return false;
  }

  /// 检查日期是否在范围内
  bool isInRange(DateTime date) {
    if (selectionMode == VelocityCalendarSelectionMode.range &&
        startDate != null &&
        endDate != null) {
      return date.isAfter(startDate!) && date.isBefore(endDate!);
    }
    return false;
  }

  /// 检查是否是开始日期
  bool isStartDate(DateTime date) {
    return selectionMode == VelocityCalendarSelectionMode.range &&
        startDate != null &&
        isSameDay(startDate!, date);
  }

  /// 检查是否是结束日期
  bool isEndDate(DateTime date) {
    return selectionMode == VelocityCalendarSelectionMode.range &&
        endDate != null &&
        isSameDay(endDate!, date);
  }

  /// 检查是否是今天
  bool isToday(DateTime date) {
    final today = DateTime.now();
    return isSameDay(date, today);
  }

  /// 检查是否是同一天
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// 检查是否是同一月
  bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  /// 检查是否是同一年
  bool isSameYear(DateTime date1, DateTime date2) {
    return date1.year == date2.year;
  }
}

/// VelocityUI 日历组件
class VelocityCalendar extends StatefulWidget {
  /// 创建日历组件
  const VelocityCalendar({
    super.key,
    this.controller,
    this.style,
    this.onDateSelected,
    this.onViewModeChanged,
    this.onMonthChanged,
    this.headerBuilder,
    this.dayBuilder,
    this.weekdayBuilder,
    this.locale = 'zh_CN',
    this.firstDayOfWeek = 1,
    this.showTodayButton = true,
    this.todayButtonText = '今天',
  });

  /// 日历控制器
  final VelocityCalendarController? controller;

  /// 日历样式
  final VelocityCalendarStyle? style;

  /// 日期选择回调
  final ValueChanged<DateTime>? onDateSelected;

  /// 视图模式变化回调
  final ValueChanged<VelocityCalendarViewMode>? onViewModeChanged;

  /// 月份变化回调
  final ValueChanged<DateTime>? onMonthChanged;

  /// 自定义头部构建器
  final Widget Function(BuildContext, DateTime, VelocityCalendarController)?
      headerBuilder;

  /// 自定义日期构建器
  final Widget Function(BuildContext, DateTime, VelocityCalendarController)?
      dayBuilder;

  /// 自定义星期构建器
  final Widget Function(BuildContext, int)? weekdayBuilder;

  /// 语言环境
  final String locale;

  /// 一周的第一天（0: 周日, 1: 周一, ..., 6: 周六）
  final int firstDayOfWeek;

  /// 是否显示今天按钮
  final bool showTodayButton;

  /// 今天按钮文本
  final String todayButtonText;

  @override
  State<VelocityCalendar> createState() => _VelocityCalendarState();
}

class _VelocityCalendarState extends State<VelocityCalendar> {
  late VelocityCalendarController _controller;
  final List<String> _weekdays = ['日', '一', '二', '三', '四', '五', '六'];
  final List<String> _months = [
    '一月',
    '二月',
    '三月',
    '四月',
    '五月',
    '六月',
    '七月',
    '八月',
    '九月',
    '十月',
    '十一月',
    '十二月'
  ];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? VelocityCalendarController();
    _controller.addListener(_onControllerUpdate);
  }

  @override
  void didUpdateWidget(VelocityCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onControllerUpdate);
      _controller = widget.controller ?? VelocityCalendarController();
      _controller.addListener(_onControllerUpdate);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    if (widget.controller == null) {
      // 如果是内部创建的控制器，不需要dispose，因为它没有资源需要释放
    }
    super.dispose();
  }

  void _onControllerUpdate(VelocityCalendarController controller) {
    setState(() {});
  }

  List<DateTime> _getMonthDays(DateTime date) {
    final days = <DateTime>[];
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    final startOffset = (firstDay.weekday - widget.firstDayOfWeek) % 7;
    final previousMonthDays = startOffset;
    final nextMonthDays = 42 - previousMonthDays - lastDay.day;

    // 添加上个月的日期
    for (var i = previousMonthDays; i > 0; i--) {
      days.add(DateTime(date.year, date.month, -i + 1));
    }

    // 添加当月的日期
    for (var i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(date.year, date.month, i));
    }

    // 添加下个月的日期
    for (var i = 1; i <= nextMonthDays; i++) {
      days.add(DateTime(date.year, date.month + 1, i));
    }

    return days;
  }

  Widget _buildHeader() {
    if (widget.headerBuilder != null) {
      return widget.headerBuilder!(
          context, _controller.currentDate, _controller);
    }

    final effectiveStyle = widget.style ?? VelocityCalendarStyle();
    return Container(
      height: effectiveStyle.headerHeight,
      padding: effectiveStyle.headerPadding,
      decoration: BoxDecoration(
        color: effectiveStyle.headerBackgroundColor,
        border: effectiveStyle.showBorders
            ? Border(
                bottom: BorderSide(
                    color: effectiveStyle.borderColor,
                    width: effectiveStyle.borderWidth))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (effectiveStyle.showMonthNavigator)
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left,
                      color: effectiveStyle.arrowColor),
                  onPressed: () {
                    _controller.previousMonth();
                    widget.onMonthChanged?.call(_controller.currentDate);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right,
                      color: effectiveStyle.arrowColor),
                  onPressed: () {
                    _controller.nextMonth();
                    widget.onMonthChanged?.call(_controller.currentDate);
                  },
                ),
              ],
            ),
          Text(
            '${_controller.currentDate.year}年${_months[_controller.currentDate.month - 1]}',
            style: effectiveStyle.headerTitleStyle
                .copyWith(color: effectiveStyle.headerTextColor),
          ),
          if (widget.showTodayButton)
            TextButton(
              onPressed: () {
                _controller.jumpToToday();
                widget.onMonthChanged?.call(_controller.currentDate);
              },
              child: Text(
                widget.todayButtonText,
                style: effectiveStyle.headerSubtitleStyle
                    .copyWith(color: effectiveStyle.headerTextColor),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWeekdays() {
    final effectiveStyle = widget.style ?? VelocityCalendarStyle();
    if (!effectiveStyle.showWeekdays) return const SizedBox.shrink();

    final weekdays = <Widget>[];
    for (var i = 0; i < 7; i++) {
      final weekdayIndex = (widget.firstDayOfWeek + i) % 7;
      weekdays.add(
        Expanded(
          child: widget.weekdayBuilder != null
              ? widget.weekdayBuilder!(context, weekdayIndex)
              : Container(
                  height: effectiveStyle.weekdayHeight,
                  alignment: Alignment.center,
                  child: Text(
                    _weekdays[weekdayIndex],
                    style: effectiveStyle.weekdayTextStyle
                        .copyWith(color: effectiveStyle.weekdayTextColor),
                  ),
                ),
        ),
      );
    }

    return Container(
      decoration: effectiveStyle.showBorders
          ? BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: effectiveStyle.borderColor,
                      width: effectiveStyle.borderWidth)),
            )
          : null,
      child: Row(children: weekdays),
    );
  }

  Widget _buildDay(DateTime date) {
    if (widget.dayBuilder != null) {
      return widget.dayBuilder!(context, date, _controller);
    }

    final effectiveStyle = widget.style ?? VelocityCalendarStyle();
    final isCurrentMonth = _controller.currentDate.month == date.month;
    final isToday = _controller.isToday(date);
    final isSelected = _controller.isSelected(date);
    final isInRange = _controller.isInRange(date);
    final isStart = _controller.isStartDate(date);
    final isEnd = _controller.isEndDate(date);
    final isDisabled =
        date.isBefore(_controller.minDate) || date.isAfter(_controller.maxDate);
    final isOutside = !isCurrentMonth;

    var backgroundColor = Colors.transparent;
    var textColor = effectiveStyle.dayTextColor;
    var textStyle = effectiveStyle.dayTextStyle;

    if (isDisabled) {
      textColor = effectiveStyle.disabledTextColor;
      textStyle = effectiveStyle.disabledTextStyle;
    } else if (isOutside) {
      textColor = effectiveStyle.outsideTextColor;
      textStyle = effectiveStyle.outsideTextStyle;
    } else if (isSelected) {
      backgroundColor = effectiveStyle.selectedBackgroundColor;
      textColor = effectiveStyle.selectedTextColor;
      textStyle = effectiveStyle.selectedTextStyle;
    } else if (isToday) {
      backgroundColor = effectiveStyle.todayBackgroundColor;
      textColor = effectiveStyle.todayTextColor;
      textStyle = effectiveStyle.todayTextStyle;
    } else if (isInRange) {
      backgroundColor = effectiveStyle.rangeBackgroundColor;
      textColor = effectiveStyle.rangeTextColor;
      textStyle = effectiveStyle.rangeTextStyle;
    } else if (isStart || isEnd) {
      backgroundColor = effectiveStyle.rangeStartEndBackgroundColor;
      textColor = effectiveStyle.rangeTextColor;
      textStyle = effectiveStyle.rangeTextStyle;
    }

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              _controller.selectDate(date);
              widget.onDateSelected?.call(date);
            },
      child: Container(
        width: effectiveStyle.cellSize,
        height: effectiveStyle.cellSize,
        padding: effectiveStyle.cellPadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(effectiveStyle.radius),
        ),
        child: Text(
          date.day.toString(),
          style: textStyle.copyWith(color: textColor),
        ),
      ),
    );
  }

  Widget _buildMonthView() {
    final days = _getMonthDays(_controller.currentDate);
    final rows = <Widget>[];
    final effectiveStyle = widget.style ?? VelocityCalendarStyle();

    for (var i = 0; i < 6; i++) {
      final rowDays = days.sublist(i * 7, (i + 1) * 7);
      final row = Row(
        children:
            rowDays.map((day) => Expanded(child: _buildDay(day))).toList(),
      );
      rows.add(row);
    }

    return Column(
      children: [
        if (effectiveStyle.showHeader) _buildHeader(),
        if (effectiveStyle.showWeekdays) _buildWeekdays(),
        ...rows,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? VelocityCalendarStyle();
    return Container(
      margin: effectiveStyle.margin,
      padding: effectiveStyle.padding,
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        border: effectiveStyle.showBorders
            ? Border.all(
                color: effectiveStyle.borderColor,
                width: effectiveStyle.borderWidth)
            : null,
        borderRadius: BorderRadius.circular(effectiveStyle.radius),
      ),
      child: _buildMonthView(),
    );
  }
}
