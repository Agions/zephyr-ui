import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart' as table_calendar;

class ZephyrCalendar extends StatefulWidget {
  const ZephyrCalendar({
    super.key,
    this.selectedDay,
    this.onDaySelected,
    this.firstDay,
    this.lastDay,
    this.focusedDay,
  });

  final DateTime? selectedDay;
  final Function(DateTime, DateTime)? onDaySelected;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final DateTime? focusedDay;

  @override
  State<ZephyrCalendar> createState() => _ZephyrCalendarState();
}

class _ZephyrCalendarState extends State<ZephyrCalendar> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay ?? DateTime.now();
    _selectedDay = widget.selectedDay ?? DateTime.now();
    _firstDay = widget.firstDay ?? DateTime(DateTime.now().year - 1);
    _lastDay = widget.lastDay ?? DateTime(DateTime.now().year + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: table_calendar.TableCalendar(
        firstDay: _firstDay,
        lastDay: _lastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return _selectedDay.year == day.year &&
              _selectedDay.month == day.month &&
              _selectedDay.day == day.day;
        },
        onDaySelected: widget.onDaySelected ??
            (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
        calendarStyle: table_calendar.CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
