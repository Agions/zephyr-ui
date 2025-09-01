# ZephyrCalendar 日历组件

日历组件是ZephyrUI展示系统中的重要组件，提供了强大的日期选择和展示功能。支持多种日历模式、自定义样式和交互方式，是构建日期选择器、日程管理、活动日历等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种日历模式**: 支持月视图、周视图、日视图等多种模式
- **灵活布局**: 支持水平和垂直布局，自定义大小和样式
- **丰富交互**: 支持日期选择、范围选择、多日期选择等交互
- **自定义样式**: 支持自定义日期样式、标记、装饰等
- **国际化支持**: 支持多语言和本地化格式
- **主题适配**: 完整的主题系统支持

### 适用场景
- 日期选择器
- 日程管理
- 活动日历
- 预订系统
- 考勤管理
- 任务规划

## 🚀 基础用法

### 基本日历

```dart
class BasicCalendarExample extends StatefulWidget {
  @override
  _BasicCalendarExampleState createState() => _BasicCalendarExampleState();
}

class _BasicCalendarExampleState extends State<BasicCalendarExample> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本日历'),
      ),
      body: Column(
        children: [
          // 选中的日期显示
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Center(
              child: Text(
                '选中日期: ${_formatDate(_selectedDate)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // 日历组件
          Expanded(
            child: ZephyrCalendar(
              selectedDate: _selectedDate,
              focusedDate: _focusedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  _focusedDate = date;
                });
              },
              onFocusedDateChanged: (date) {
                setState(() => _focusedDate = date);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }
}
```

### 范围选择日历

```dart
class RangeCalendarExample extends StatefulWidget {
  @override
  _RangeCalendarExampleState createState() => _RangeCalendarExampleState();
}

class _RangeCalendarExampleState extends State<RangeCalendarExample> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('范围选择日历'),
      ),
      body: Column(
        children: [
          // 选择范围显示
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.green[50],
            child: Center(
              child: Text(
                _startDate != null && _endDate != null
                    ? '选择范围: ${_formatDate(_startDate!)} - ${_formatDate(_endDate!)}'
                    : _startDate != null
                        ? '开始日期: ${_formatDate(_startDate!)}'
                        : '请选择日期范围',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // 日历组件
          Expanded(
            child: ZephyrCalendar(
              mode: ZephyrCalendarMode.range,
              startDate: _startDate,
              endDate: _endDate,
              focusedDate: _focusedDate,
              onDateSelected: (date) {
                setState(() {
                  if (_startDate == null) {
                    _startDate = date;
                  } else if (_endDate == null) {
                    if (date.isBefore(_startDate!)) {
                      _endDate = _startDate;
                      _startDate = date;
                    } else {
                      _endDate = date;
                    }
                  } else {
                    _startDate = date;
                    _endDate = null;
                  }
                  _focusedDate = date;
                });
              },
              onFocusedDateChanged: (date) {
                setState(() => _focusedDate = date);
              },
            ),
          ),
          
          // 清除按钮
          if (_startDate != null)
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _startDate = null;
                    _endDate = null;
                  });
                },
                child: Text('清除选择'),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }
}
```

### 多日期选择日历

```dart
class MultiSelectCalendarExample extends StatefulWidget {
  @override
  _MultiSelectCalendarExampleState createState() => _MultiSelectCalendarExampleState();
}

class _MultiSelectCalendarExampleState extends State<MultiSelectCalendarExample> {
  Set<DateTime> _selectedDates = {};
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多日期选择日历'),
      ),
      body: Column(
        children: [
          // 选中的日期显示
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.purple[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '已选择 ${_selectedDates.length} 个日期',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _selectedDates.map((date) {
                    return Chip(
                      label: Text(_formatDate(date)),
                      onDeleted: () {
                        setState(() {
                          _selectedDates.remove(date);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // 日历组件
          Expanded(
            child: ZephyrCalendar(
              mode: ZephyrCalendarMode.multiSelect,
              selectedDates: _selectedDates,
              focusedDate: _focusedDate,
              onDateSelected: (date) {
                setState(() {
                  if (_selectedDates.contains(date)) {
                    _selectedDates.remove(date);
                  } else {
                    _selectedDates.add(date);
                  }
                  _focusedDate = date;
                });
              },
              onFocusedDateChanged: (date) {
                setState(() => _focusedDate = date);
              },
            ),
          ),
          
          // 清除按钮
          if (_selectedDates.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedDates.clear();
                  });
                },
                child: Text('清除所有选择'),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }
}
```

## 🎨 样式定制

### 自定义日期样式

```dart
class CustomStyleCalendarExample extends StatefulWidget {
  @override
  _CustomStyleCalendarExampleState createState() => _CustomStyleCalendarExampleState();
}

class _CustomStyleCalendarExampleState extends State<CustomStyleCalendarExample> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义日期样式'),
      ),
      body: ZephyrCalendar(
        selectedDate: _selectedDate,
        focusedDate: _focusedDate,
        onDateSelected: (date) {
          setState(() {
            _selectedDate = date;
            _focusedDate = date;
          });
        },
        onFocusedDateChanged: (date) {
          setState(() => _focusedDate = date;
        },
        style: ZephyrCalendarStyle(
          headerStyle: ZephyrCalendarHeaderStyle(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.all(16),
          ),
          weekdayStyle: ZephyrCalendarWeekdayStyle(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          dayStyle: ZephyrCalendarDayStyle(
            textStyle: TextStyle(fontSize: 14),
            selectedTextStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            selectedBackgroundColor: Colors.deepPurple,
            todayTextStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            todayBackgroundColor: Colors.orange[50],
            disabledTextStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
            borderRadius: BorderRadius.circular(8),
            padding: EdgeInsets.all(8),
          ),
        ),
      ),
    );
  }
}
```

### 带事件标记的日历

```dart
class EventCalendarExample extends StatefulWidget {
  @override
  _EventCalendarExampleState createState() => _EventCalendarExampleState();
}

class _EventCalendarExampleState extends State<EventCalendarExample> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  
  // 模拟事件数据
  final Map<DateTime, List<CalendarEvent>> _events = {
    DateTime(2025, 8, 20): [
      CalendarEvent(
        title: '团队会议',
        time: '10:00',
        color: Colors.blue,
      ),
      CalendarEvent(
        title: '项目评审',
        time: '14:00',
        color: Colors.green,
      ),
    ],
    DateTime(2025, 8, 22): [
      CalendarEvent(
        title: '客户拜访',
        time: '09:30',
        color: Colors.orange,
      ),
    ],
    DateTime(2025, 8, 25): [
      CalendarEvent(
        title: '产品发布',
        time: '15:00',
        color: Colors.purple,
      ),
      CalendarEvent(
        title: '庆祝派对',
        time: '18:00',
        color: Colors.red,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带事件标记的日历'),
      ),
      body: Column(
        children: [
          // 选中日期的事件显示
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_formatDate(_selectedDate)} 的日程',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ..._buildEventList(_selectedDate),
              ],
            ),
          ),
          
          // 日历组件
          Expanded(
            child: ZephyrCalendar(
              selectedDate: _selectedDate,
              focusedDate: _focusedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  _focusedDate = date;
                });
              },
              onFocusedDateChanged: (date) {
                setState(() => _focusedDate = date;
              },
              dayBuilder: (context, date, isFocused, isSelected, isToday, isEnabled) {
                final hasEvents = _events.containsKey(date);
                final eventCount = _events[date]?.length ?? 0;
                
                return Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue
                        : isToday
                            ? Colors.blue[50]
                            : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected || isToday
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? Colors.white
                                : isEnabled
                                    ? Colors.black
                                    : Colors.grey[400],
                          ),
                        ),
                      ),
                      if (hasEvents)
                        Positioned(
                          bottom: 2,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              math.min(eventCount, 3),
                              (index) => Container(
                                width: 4,
                                height: 4,
                                margin: EdgeInsets.symmetric(horizontal: 1),
                                decoration: BoxDecoration(
                                  color: _events[date]![index].color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildEventList(DateTime date) {
    final events = _events[date] ?? [];
    
    if (events.isEmpty) {
      return [
        Text(
          '暂无日程安排',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ];
    }
    
    return events.map((event) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: event.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: event.color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: event.color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    event.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }
}

class CalendarEvent {
  final String title;
  final String time;
  final Color color;
  
  CalendarEvent({
    required this.title,
    required this.time,
    required this.color,
  });
}
```

### 紧凑型日历

```dart
class CompactCalendarExample extends StatefulWidget {
  @override
  _CompactCalendarExampleState createState() => _CompactCalendarExampleState();
}

class _CompactCalendarExampleState extends State<CompactCalendarExample> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紧凑型日历'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ZephyrCalendar(
          selectedDate: _selectedDate,
          focusedDate: _focusedDate,
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date;
              _focusedDate = date;
            });
          },
          onFocusedDateChanged: (date) {
            setState(() => _focusedDate = date;
          },
          style: ZephyrCalendarStyle(
            compact: true,
            headerStyle: ZephyrCalendarHeaderStyle(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            weekdayStyle: ZephyrCalendarWeekdayStyle(
              textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              padding: EdgeInsets.symmetric(vertical: 4),
            ),
            dayStyle: ZephyrCalendarDayStyle(
              textStyle: TextStyle(fontSize: 12),
              selectedTextStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(4),
              padding: EdgeInsets.all(4),
            ),
          ),
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 周视图日历

```dart
class WeekViewCalendarExample extends StatefulWidget {
  @override
  _WeekViewCalendarExampleState createState() => _WeekViewCalendarExampleState();
}

class _WeekViewCalendarExampleState extends State<WeekViewCalendarExample> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  ZephyrCalendarView _view = ZephyrCalendarView.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('周视图日历'),
        actions: [
          PopupMenuButton<ZephyrCalendarView>(
            initialValue: _view,
            onSelected: (view) {
              setState(() => _view = view);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ZephyrCalendarView.month,
                child: Text('月视图'),
              ),
              PopupMenuItem(
                value: ZephyrCalendarView.week,
                child: Text('周视图'),
              ),
              PopupMenuItem(
                value: ZephyrCalendarView.day,
                child: Text('日视图'),
              ),
            ],
          ),
        ],
      ),
      body: ZephyrCalendar(
        view: _view,
        selectedDate: _selectedDate,
        focusedDate: _focusedDate,
        onDateSelected: (date) {
          setState(() {
            _selectedDate = date;
            _focusedDate = date;
          });
        },
        onFocusedDateChanged: (date) {
          setState(() => _focusedDate = date;
        },
        weekDays: ['一', '二', '三', '四', '五', '六', '日'],
        firstDayOfWeek: DateTime.monday,
        style: ZephyrCalendarStyle(
          headerStyle: ZephyrCalendarHeaderStyle(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          dayStyle: ZephyrCalendarDayStyle(
            selectedBackgroundColor: Colors.teal,
            todayBackgroundColor: Colors.teal[50],
          ),
        ),
      ),
    );
  }
}
```

### 自定义日历头部

```dart
class CustomHeaderCalendarExample extends StatefulWidget {
  @override
  _CustomHeaderCalendarExampleState createState() => _CustomHeaderCalendarExampleState();
}

class _CustomHeaderCalendarExampleState extends State<CustomHeaderCalendarExample> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义日历头部'),
      ),
      body: ZephyrCalendar(
        selectedDate: _selectedDate,
        focusedDate: _focusedDate,
        onDateSelected: (date) {
          setState(() {
            _selectedDate = date;
            _focusedDate = date;
          });
        },
        onFocusedDateChanged: (date) {
          setState(() => _focusedDate = date;
        },
        headerBuilder: (context, focusedDate) {
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                // 年月显示
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _focusedDate = DateTime(
                            _focusedDate.year,
                            _focusedDate.month - 1,
                            _focusedDate.day,
                          );
                        });
                      },
                    ),
                    Text(
                      '${_focusedDate.year}年${_focusedDate.month}月',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _focusedDate = DateTime(
                            _focusedDate.year,
                            _focusedDate.month + 1,
                            _focusedDate.day,
                          );
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // 快速跳转按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _focusedDate = DateTime.now();
                          _selectedDate = DateTime.now();
                        });
                      },
                      child: Text(
                        '今天',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _focusedDate = DateTime(
                            _focusedDate.year,
                            _focusedDate.month,
                            1,
                          );
                        });
                      },
                      child: Text(
                        '月初',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _focusedDate = DateTime(
                            _focusedDate.year,
                            _focusedDate.month + 1,
                            0,
                          );
                        });
                      },
                      child: Text(
                        '月末',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

### 带禁用日期的日历

```dart
class DisabledDatesCalendarExample extends StatefulWidget {
  @override
  _DisabledDatesCalendarExampleState createState() => _DisabledDatesCalendarExampleState();
}

class _DisabledDatesCalendarExampleState extends State<DisabledDatesCalendarExample> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  
  // 定义禁用日期规则
  bool _isDateDisabled(DateTime date) {
    // 禁用过去的日期
    if (date.isBefore(DateTime.now())) {
      return true;
    }
    
    // 禁用周末
    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      return true;
    }
    
    // 禁用特定日期
    final disabledDates = [
      DateTime(2025, 8, 25),
      DateTime(2025, 8, 26),
      DateTime(2025, 9, 1),
    ];
    
    return disabledDates.any((disabledDate) => 
      date.year == disabledDate.year &&
      date.month == disabledDate.month &&
      date.day == disabledDate.day
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带禁用日期的日历'),
      ),
      body: Column(
        children: [
          // 说明信息
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.orange[50],
            child: Text(
              '只能选择今天及之后的周一至周五',
              style: TextStyle(
                fontSize: 14,
                color: Colors.orange[800],
              ),
            ),
          ),
          
          // 日历组件
          Expanded(
            child: ZephyrCalendar(
              selectedDate: _selectedDate,
              focusedDate: _focusedDate,
              onDateSelected: (date) {
                if (!_isDateDisabled(date)) {
                  setState(() {
                    _selectedDate = date;
                    _focusedDate = date;
                  });
                }
              },
              onFocusedDateChanged: (date) {
                setState(() => _focusedDate = date;
              },
              isDateEnabled: (date) => !_isDateDisabled(date),
              style: ZephyrCalendarStyle(
                dayStyle: ZephyrCalendarDayStyle(
                  disabledTextStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                    decoration: TextDecoration.lineThrough,
                  ),
                  disabledBackgroundColor: Colors.grey[100],
                ),
              ),
            ),
          ),
          
          // 选中的日期显示
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Center(
              child: Text(
                '选中日期: ${_formatDate(_selectedDate)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }
}
```

### 国际化日历

```dart
class InternationalCalendarExample extends StatefulWidget {
  @override
  _InternationalCalendarExampleState createState() => _InternationalCalendarExampleState();
}

class _InternationalCalendarExampleState extends State<InternationalCalendarExample> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  String _locale = 'zh_CN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('国际化日历'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _locale,
            onSelected: (locale) {
              setState(() => _locale = locale);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'zh_CN',
                child: Text('中文'),
              ),
              PopupMenuItem(
                value: 'en_US',
                child: Text('English'),
              ),
              PopupMenuItem(
                value: 'ja_JP',
                child: Text('日本語'),
              ),
            ],
          ),
        ],
      ),
      body: ZephyrCalendar(
        selectedDate: _selectedDate,
        focusedDate: _focusedDate,
        locale: _locale,
        onDateSelected: (date) {
          setState(() {
            _selectedDate = date;
            _focusedDate = date;
          });
        },
        onFocusedDateChanged: (date) {
          setState(() => _focusedDate = date;
        },
        firstDayOfWeek: _locale == 'en_US' ? DateTime.sunday : DateTime.monday,
        style: ZephyrCalendarStyle(
          headerStyle: ZephyrCalendarHeaderStyle(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          dayStyle: ZephyrCalendarDayStyle(
            selectedBackgroundColor: Colors.indigo,
            todayBackgroundColor: Colors.indigo[50],
          ),
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrCalendar()

```dart
const ZephyrCalendar({
  Key? key,
  DateTime? selectedDate,
  Set<DateTime>? selectedDates,
  DateTime? startDate,
  DateTime? endDate,
  DateTime focusedDate,
  ZephyrCalendarMode mode = ZephyrCalendarMode.single,
  ZephyrCalendarView view = ZephyrCalendarView.month,
  ValueChanged<DateTime>? onDateSelected,
  ValueChanged<DateTime>? onFocusedDateChanged,
  ZephyrCalendarStyle? style,
  String? locale,
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? firstDayOfWeek,
  List<String>? weekDays,
  bool Function(DateTime)? isDateEnabled,
  Widget Function(BuildContext, DateTime)? dayBuilder,
  Widget Function(BuildContext, DateTime)? headerBuilder,
  EdgeInsetsGeometry? padding,
  bool showWeekNumbers = false,
  bool showTodayButton = true,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `selectedDate`: 选中的日期
- `selectedDates`: 多选的日期集合
- `startDate`: 范围选择的开始日期
- `endDate`: 范围选择的结束日期
- `focusedDate`: 当前聚焦的日期
- `mode`: 日历模式
- `view`: 日历视图
- `onDateSelected`: 日期选择回调
- `onFocusedDateChanged`: 聚焦日期变化回调
- `style`: 日历样式
- `locale`: 本地化设置
- `firstDate`: 可选择的最早日期
- `lastDate`: 可选择的最晚日期
- `firstDayOfWeek`: 每周的第一天
- `weekDays`: 星期显示文本
- `isDateEnabled`: 日期是否可选择的判断函数
- `dayBuilder`: 日期构建器
- `headerBuilder`: 头部构建器
- `padding`: 内边距
- `showWeekNumbers`: 是否显示周数
- `showTodayButton`: 是否显示今天按钮
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 枚举类型

#### ZephyrCalendarMode

```dart
enum ZephyrCalendarMode {
  single,       // 单选模式
  range,        // 范围选择模式
  multiSelect,  // 多选模式
}
```

#### ZephyrCalendarView

```dart
enum ZephyrCalendarView {
  month, // 月视图
  week,  // 周视图
  day,   // 日视图
}
```

### 样式类

#### ZephyrCalendarStyle

```dart
class ZephyrCalendarStyle {
  final ZephyrCalendarHeaderStyle? headerStyle;
  final ZephyrCalendarWeekdayStyle? weekdayStyle;
  final ZephyrCalendarDayStyle? dayStyle;
  final EdgeInsetsGeometry? padding;
  final bool compact;
  final Color? backgroundColor;
  final double? daySize;
  final double? daySpacing;
}
```

#### ZephyrCalendarHeaderStyle

```dart
class ZephyrCalendarHeaderStyle {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? height;
}
```

#### ZephyrCalendarWeekdayStyle

```dart
class ZephyrCalendarWeekdayStyle {
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? height;
}
```

#### ZephyrCalendarDayStyle

```dart
class ZephyrCalendarDayStyle {
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final TextStyle? todayTextStyle;
  final TextStyle? disabledTextStyle;
  final TextStyle? rangeTextStyle;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? todayBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color? rangeBackgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrCalendarTheme(
        defaultHeaderStyle: ZephyrCalendarHeaderStyle(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.all(16),
          height: 56,
        ),
        defaultWeekdayStyle: ZephyrCalendarWeekdayStyle(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
          height: 32,
        ),
        defaultDayStyle: ZephyrCalendarDayStyle(
          textStyle: TextStyle(fontSize: 14),
          selectedTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          todayTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          disabledTextStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
          ),
          selectedBackgroundColor: Colors.blue,
          todayBackgroundColor: Colors.blue[50],
          disabledBackgroundColor: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          padding: EdgeInsets.all(8),
        ),
        defaultPadding: EdgeInsets.all(16),
        compactDayStyle: ZephyrCalendarDayStyle(
          textStyle: TextStyle(fontSize: 12),
          selectedTextStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(4),
          padding: EdgeInsets.all(4),
        ),
        rangeStartStyle: ZephyrCalendarDayStyle(
          selectedBackgroundColor: Colors.green,
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        rangeEndStyle: ZephyrCalendarDayStyle(
          selectedBackgroundColor: Colors.green,
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        rangeMiddleStyle: ZephyrCalendarDayStyle(
          backgroundColor: Colors.green[50],
          textStyle: TextStyle(
            color: Colors.green[800],
          ),
        ),
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeInOut,
        hoverColor: Colors.grey.withOpacity(0.1),
        focusColor: Colors.blue.withOpacity(0.1),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultHeaderStyle`: 默认头部样式
- `defaultWeekdayStyle`: 默认星期样式
- `defaultDayStyle`: 默认日期样式
- `defaultPadding`: 默认内边距
- `compactDayStyle`: 紧凑型日期样式
- `rangeStartStyle`: 范围开始样式
- `rangeEndStyle`: 范围结束样式
- `rangeMiddleStyle`: 范围中间样式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的日期范围限制

```dart
// ✅ 好的做法：设置合理的日期选择范围
ZephyrCalendar(
  firstDate: DateTime.now(), // 只能选择今天及以后的日期
  lastDate: DateTime.now().add(Duration(days: 365)), // 限制一年内
  selectedDate: _selectedDate,
  onDateSelected: _handleDateSelection,
)

// ✅ 好的做法：根据业务场景设置范围
ZephyrCalendar(
  firstDate: DateTime(2020, 1, 1), // 历史数据查看
  lastDate: DateTime.now(),
  selectedDate: _selectedDate,
  onDateSelected: _handleDateSelection,
)

// ❌ 避免的做法：不限制日期范围
ZephyrCalendar(
  selectedDate: _selectedDate,
  onDateSelected: _handleDateSelection,
  // 用户可能选择不合理的日期
)
```

### 2. 性能优化

```dart
// ✅ 好的做法：使用状态管理避免不必要的重建
class OptimizedCalendar extends StatefulWidget {
  @override
  _OptimizedCalendarState createState() => _OptimizedCalendarState();
}

class _OptimizedCalendarState extends State<OptimizedCalendar> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  void _handleDateSelection(DateTime date) {
    setState(() {
      _selectedDate = date;
      _focusedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrCalendar(
      selectedDate: _selectedDate,
      focusedDate: _focusedDate,
      onDateSelected: _handleDateSelection,
      // 使用缓存的样式
      style: _getCachedStyle(),
    );
  }
}

// ✅ 好的做法：延迟加载事件数据
ZephyrCalendar(
  selectedDate: _selectedDate,
  onDateSelected: (date) {
    _loadEventsForDate(date);
  },
)

// ❌ 避免的做法：在日历中处理大量数据
ZephyrCalendar(
  dayBuilder: (context, date) {
    // 避免在构建器中进行复杂计算
    return _buildComplexDayWidget(date);
  },
)
```

### 3. 用户体验优化

```dart
// ✅ 好的做法：提供清晰的视觉反馈
ZephyrCalendar(
  selectedDate: _selectedDate,
  onDateSelected: (date) {
    setState(() => _selectedDate = date);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已选择: ${_formatDate(date)}')),
    );
  },
  style: ZephyrCalendarStyle(
    dayStyle: ZephyrCalendarDayStyle(
      selectedBackgroundColor: Colors.blue,
      todayBackgroundColor: Colors.blue[50],
      // 清晰的视觉区分
    ),
  ),
)

// ✅ 好的做法：支持键盘导航
ZephyrCalendar(
  enableAccessibilityFeatures: true,
  semanticLabel: '日期选择器',
  // 支持键盘操作
)

// ✅ 好的做法：提供快速导航
ZephyrCalendar(
  headerBuilder: (context, focusedDate) {
    return _buildCustomHeaderWithQuickNavigation(focusedDate);
  },
  showTodayButton: true,
)

// ❌ 避免的做法：缺乏用户反馈
ZephyrCalendar(
  selectedDate: _selectedDate,
  onDateSelected: (date) {
    setState(() => _selectedDate = date);
    // 没有用户反馈
  },
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrCalendar(
  semanticLabel: '日期选择日历',
  enableAccessibilityFeatures: true,
  selectedDate: _selectedDate,
  onDateSelected: _handleDateSelection,
)

// ✅ 好的做法：为特殊日期提供描述
ZephyrCalendar(
  dayBuilder: (context, date) {
    final hasEvent = _events.containsKey(date);
    return Container(
      child: Text(
        '${date.day}',
        semanticsLabel: hasEvent 
            ? '${date.month}月${date.day}日，有日程安排'
            : '${date.month}月${date.day}日',
      ),
    );
  },
)

// ✅ 好的做法：确保足够的点击区域
ZephyrCalendar(
  style: ZephyrCalendarStyle(
    dayStyle: ZephyrCalendarDayStyle(
      padding: EdgeInsets.all(12), // 足够的点击区域
    ),
  ),
)

// ❌ 避免的做法：缺乏语义信息
ZephyrCalendar(
  selectedDate: _selectedDate,
  onDateSelected: _handleDateSelection,
  // 缺乏无障碍支持
)
```

## 🔄 相关组件

- **ZephyrDatePicker**: 日期选择器组件
- **ZephyrTimePicker**: 时间选择器组件
- **ZephyrDateTimePicker**: 日期时间选择器组件
- **ZephyrTimeline**: 时间线组件
- **ZephyrEventList**: 事件列表组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种日历模式
- ✅ 支持自定义样式
- ✅ 支持国际化
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/calendar/`
**示例路径**: `example/lib/components/calendar_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日