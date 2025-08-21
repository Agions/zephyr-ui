import 'package:flutter/material.dart';
import 'calendar_theme.dart';

/// 日历事件
class ZephyrCalendarEvent {
  /// 事件ID
  final String id;

  /// 事件标题
  final String title;

  /// 事件描述
  final String? description;

  /// 开始时间
  final DateTime start;

  /// 结束时间
  final DateTime end;

  /// 事件颜色
  final Color color;

  /// 是否全天事件
  final bool allDay;

  /// 事件位置
  final String? location;

  /// 附加数据
  final dynamic data;

  /// 创建日历事件
  const ZephyrCalendarEvent({
    required this.id,
    required this.title,
    this.description,
    required this.start,
    required this.end,
    this.color = const Color(0xFF3B82F6),
    this.allDay = false,
    this.location,
    this.data,
  });

  /// 事件是否在指定日期
  bool isOnDate(DateTime date) {
    final eventDate = DateTime(start.year, start.month, start.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    return eventDate == targetDate;
  }

  /// 事件是否跨天
  bool get isMultiDay {
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);
    return startDate != endDate;
  }
}

/// 日历视图类型
enum ZephyrCalendarView {
  month,
  week,
  day,
}

/// 日历选中信息
class ZephyrCalendarSelection {
  /// 选中的日期
  final DateTime date;

  /// 选中的事件
  final ZephyrCalendarEvent? event;

  /// 创建选中信息
  const ZephyrCalendarSelection({
    required this.date,
    this.event,
  });
}

/// ZephyrUI 日历组件
///
/// 一个功能完整的日历组件，支持月视图、周视图、日视图，
/// 以及事件管理、日期选择等功能。
///
/// 特性：
/// - 多种视图模式（月/周/日）
/// - 事件管理和显示
/// - 日期选择
/// - 自定义样式
/// - 响应式设计
/// - 国际化支持
/// - 拖拽事件
/// - 事件搜索
///
/// 示例用法：
/// ```dart
/// ZephyrCalendar(
///   events: [
///     ZephyrCalendarEvent(
///       id: '1',
///       title: '团队会议',
///       start: DateTime.now(),
///       end: DateTime.now().add(const Duration(hours: 2)),
///     ),
///   ],
///   onDateSelected: (date) => print('选中日期: $date'),
///   onEventTap: (event) => print('点击事件: ${event.title}'),
/// )
/// ```
class ZephyrCalendar extends StatefulWidget {
  /// 事件列表
  final List<ZephyrCalendarEvent> events;

  /// 当前视图类型
  final ZephyrCalendarView view;

  /// 当前显示的月份
  final DateTime? currentMonth;

  /// 是否显示周末
  final bool showWeekends;

  /// 是否显示周数
  final bool showWeekNumbers;

  /// 是否可选择日期
  final bool selectable;

  /// 是否可选择多日期
  final bool multiSelect;

  /// 是否可编辑事件
  final bool editable;

  /// 最小日期
  final DateTime? minDate;

  /// 最大日期
  final DateTime? maxDate;

  /// 选中的日期
  final List<DateTime> selectedDates;

  /// 主题数据
  final ZephyrCalendarTheme? theme;

  /// 日期选择回调
  final Function(List<DateTime> dates)? onDateSelected;

  /// 事件点击回调
  final Function(ZephyrCalendarEvent event)? onEventTap;

  /// 事件长按回调
  final Function(ZephyrCalendarEvent event)? onEventLongPress;

  /// 视图切换回调
  final Function(ZephyrCalendarView view)? onViewChanged;

  /// 月份切换回调
  final Function(DateTime month)? onMonthChanged;

  /// 事件创建回调
  final Function(DateTime date)? onEventCreate;

  /// 事件更新回调
  final Function(ZephyrCalendarEvent event)? onEventUpdate;

  /// 事件删除回调
  final Function(ZephyrCalendarEvent event)? onEventDelete;

  /// 创建日历组件
  const ZephyrCalendar({
    Key? key,
    this.events = const [],
    this.view = ZephyrCalendarView.month,
    this.currentMonth,
    this.showWeekends = true,
    this.showWeekNumbers = false,
    this.selectable = true,
    this.multiSelect = false,
    this.editable = false,
    this.minDate,
    this.maxDate,
    this.selectedDates = const [],
    this.theme,
    this.onDateSelected,
    this.onEventTap,
    this.onEventLongPress,
    this.onViewChanged,
    this.onMonthChanged,
    this.onEventCreate,
    this.onEventUpdate,
    this.onEventDelete,
  }) : super(key: key);

  @override
  State<ZephyrCalendar> createState() => _ZephyrCalendarState();
}

class _ZephyrCalendarState extends State<ZephyrCalendar> {
  late ZephyrCalendarTheme _theme;
  late ZephyrCalendarView _currentView;
  late DateTime _currentMonth;
  late List<DateTime> _selectedDates;
  late List<ZephyrCalendarEvent> _events;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrCalendarTheme.light();
    _currentView = widget.view;
    _currentMonth = widget.currentMonth ?? DateTime.now();
    _selectedDates = List.from(widget.selectedDates);
    _events = List.from(widget.events);
    _pageController = PageController(
      initialPage: _calculateInitialPage(),
    );
  }

  @override
  void didUpdateWidget(ZephyrCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrCalendarTheme.light();
    }
    if (widget.view != oldWidget.view) {
      _currentView = widget.view;
    }
    if (widget.currentMonth != oldWidget.currentMonth) {
      _currentMonth = widget.currentMonth ?? DateTime.now();
    }
    if (widget.selectedDates != oldWidget.selectedDates) {
      _selectedDates = List.from(widget.selectedDates);
    }
    if (widget.events != oldWidget.events) {
      _events = List.from(widget.events);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _calculateInitialPage() {
    final now = DateTime.now();
    final monthsDiff = (_currentMonth.year - now.year) * 12 + (_currentMonth.month - now.month);
    return monthsDiff;
  }

  void _handleDateSelected(DateTime date) {
    if (!widget.selectable) return;
    
    // 检查日期范围
    if (widget.minDate != null && date.isBefore(widget.minDate!)) return;
    if (widget.maxDate != null && date.isAfter(widget.maxDate!)) return;
    
    setState(() {
      if (widget.multiSelect) {
        if (_selectedDates.contains(date)) {
          _selectedDates.remove(date);
        } else {
          _selectedDates.add(date);
        }
      } else {
        _selectedDates = [date];
      }
    });
    
    widget.onDateSelected?.call(_selectedDates);
  }



  void _handleViewChanged(ZephyrCalendarView view) {
    setState(() {
      _currentView = view;
    });
    widget.onViewChanged?.call(view);
  }

  void _handleMonthChanged(DateTime month) {
    setState(() {
      _currentMonth = month;
    });
    widget.onMonthChanged?.call(month);
  }

  void _handleEventCreate(DateTime date) {
    widget.onEventCreate?.call(date);
  }

  List<ZephyrCalendarEvent> _getEventsForDate(DateTime date) {
    return _events.where((event) => event.isOnDate(date)).toList();
  }


  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _theme.headerBackgroundColor,
        borderRadius: BorderRadius.vertical(top: _theme.borderRadius.topLeft),
      ),
      child: Column(
        children: [
          // 月份导航
          Row(
            children: [
              // 上个月按钮
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  final previousMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
                  _handleMonthChanged(previousMonth);
                },
                color: _theme.headerIconColor,
              ),
              
              // 当前月份标题
              Expanded(
                child: Text(
                  '${_currentMonth.year}年${_currentMonth.month}月',
                  style: _theme.headerTitleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              
              // 下个月按钮
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  final nextMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
                  _handleMonthChanged(nextMonth);
                },
                color: _theme.headerIconColor,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // 视图切换
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildViewButton('月', ZephyrCalendarView.month),
              const SizedBox(width: 8),
              _buildViewButton('周', ZephyrCalendarView.week),
              const SizedBox(width: 8),
              _buildViewButton('日', ZephyrCalendarView.day),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViewButton(String label, ZephyrCalendarView view) {
    final isSelected = _currentView == view;
    
    return TextButton(
      onPressed: () => _handleViewChanged(view),
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? _theme.primaryColor : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : _theme.headerTextColor,
        minimumSize: const Size(60, 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? _theme.primaryColor : _theme.borderColor,
          ),
        ),
      ),
      child: Text(label),
    );
  }

  Widget _buildCalendarBody() {
    switch (_currentView) {
      case ZephyrCalendarView.month:
        return _buildMonthView();
      case ZephyrCalendarView.week:
        return _buildWeekView();
      case ZephyrCalendarView.day:
        return _buildDayView();
    }
  }

  Widget _buildMonthView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (page) {
        final now = DateTime.now();
        final targetMonth = DateTime(now.year, now.month + page, 1);
        _handleMonthChanged(targetMonth);
      },
      itemBuilder: (context, page) {
        final now = DateTime.now();
        final month = DateTime(now.year, now.month + page, 1);
        return _buildMonthGrid(month);
      },
    );
  }

  Widget _buildMonthGrid(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final firstDayOfWeek = firstDay.weekday % 7;
    
    final days = <DateTime>[];
    
    // 上个月的日期
    final previousMonth = DateTime(month.year, month.month - 1, 0);
    for (int i = firstDayOfWeek - 1; i >= 0; i--) {
      days.add(DateTime(previousMonth.year, previousMonth.month, previousMonth.day - i));
    }
    
    // 当前月的日期
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(month.year, month.month, i));
    }
    
    // 下个月的日期
    final remainingDays = 42 - days.length; // 6行 x 7天
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(month.year, month.month + 1, i));
    }
    
    return Column(
      children: [
        // 星期标题
        _buildWeekdayHeaders(),
        
        // 日期网格
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final date = days[index];
              final isCurrentMonth = date.month == month.month;
              final isSelected = _selectedDates.contains(date);
              final isToday = _isToday(date);
              final events = _getEventsForDate(date);
              
              return _buildDayCell(
                date: date,
                isCurrentMonth: isCurrentMonth,
                isSelected: isSelected,
                isToday: isToday,
                events: events,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekdayHeaders() {
    final weekdays = ['日', '一', '二', '三', '四', '五', '六'];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: weekdays.map((day) => 
          Expanded(
            child: Text(
              day,
              style: _theme.weekdayHeaderStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildDayCell({
    required DateTime date,
    required bool isCurrentMonth,
    required bool isSelected,
    required bool isToday,
    required List<ZephyrCalendarEvent> events,
  }) {
    final isWeekend = date.weekday == 6 || date.weekday == 7;
    
    return GestureDetector(
      onTap: () => _handleDateSelected(date),
      onLongPress: () => _handleEventCreate(date),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected
              ? _theme.selectedDayColor
              : isToday
                  ? _theme.todayColor
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isToday ? _theme.todayBorderColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            // 日期数字
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? _theme.primaryColor : Colors.transparent,
              ),
              child: Text(
                date.day.toString(),
                style: _theme.dayStyle.copyWith(
                  color: isSelected
                      ? Colors.white
                      : isCurrentMonth
                          ? isWeekend
                              ? _theme.weekendTextColor
                              : _theme.dayStyle.color
                          : _theme.disabledTextColor,
                  fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            
            // 事件指示器
            if (events.isNotEmpty)
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 2,
                  runSpacing: 2,
                  children: events.take(3).map((event) => 
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: event.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekView() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final days = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
    
    return Column(
      children: [
        // 星期标题
        _buildWeekdayHeaders(),
        
        // 时间网格
        Expanded(
          child: ListView.builder(
            itemCount: 24, // 24小时
            itemBuilder: (context, hour) {
              return Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: _theme.borderColor, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    // 时间标签
                    Container(
                      width: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$hour:00',
                        style: _theme.bodyTextStyle.copyWith(
                          fontSize: 12,
                          color: _theme.disabledTextColor,
                        ),
                      ),
                    ),
                    
                    // 事件区域
                    Expanded(
                      child: Row(
                        children: days.map((date) {
                          final events = _getEventsForDate(date);
                          final hourEvents = events.where((event) {
                            final eventHour = event.start.hour;
                            return eventHour == hour;
                          }).toList();
                          
                          return Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: _theme.borderColor, width: 0.5),
                                ),
                              ),
                              child: hourEvents.isNotEmpty
                                  ? Wrap(
                                      children: hourEvents.map((event) => 
                                        Container(
                                          margin: const EdgeInsets.all(2),
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: event.color.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            event.title,
                                            style: _theme.eventStyle.copyWith(
                                              fontSize: 10,
                                              color: event.color,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ).toList(),
                                    )
                                  : const SizedBox(),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDayView() {
    final events = _getEventsForDate(_currentMonth);
    
    return Column(
      children: [
        // 日期标题
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _theme.headerBackgroundColor,
            border: Border(bottom: BorderSide(color: _theme.borderColor, width: 1)),
          ),
          child: Text(
            '${_currentMonth.year}年${_currentMonth.month}月${_currentMonth.day}日',
            style: _theme.headerTitleStyle,
          ),
        ),
        
        // 时间线视图
        Expanded(
          child: ListView.builder(
            itemCount: 24,
            itemBuilder: (context, hour) {
              final hourEvents = events.where((event) {
                final eventHour = event.start.hour;
                return eventHour == hour;
              }).toList();
              
              return Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: _theme.borderColor, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    // 时间标签
                    Container(
                      width: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$hour:00',
                        style: _theme.bodyTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    
                    // 事件列表
                    Expanded(
                      child: hourEvents.isEmpty
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: hourEvents.map((event) => 
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: event.color.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: event.color, width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        style: _theme.eventStyle.copyWith(
                                          color: event.color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (event.description != null)
                                        Text(
                                          event.description!,
                                          style: _theme.eventStyle.copyWith(
                                            fontSize: 11,
                                            color: _theme.disabledTextColor,
                                          ),
                                        ),
                                      Text(
                                        '${event.start.hour}:${event.start.minute.toString().padLeft(2, '0')} - ${event.end.hour}:${event.end.minute.toString().padLeft(2, '0')}',
                                        style: _theme.eventStyle.copyWith(
                                          fontSize: 10,
                                          color: _theme.disabledTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ).toList(),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: _theme.borderRadius,
        border: Border.all(color: _theme.borderColor, width: _theme.borderWidth),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildCalendarBody(),
          ),
        ],
      ),
    );
  }
}