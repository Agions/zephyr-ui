# ZephyrDatePicker 日期选择器组件

日期选择器是一个功能强大的日期选择控件，支持多种选择模式和自定义样式。提供了直观的日期选择体验，包括单日选择、范围选择、月份选择等功能。

## 🎯 组件概述

### 特性
- **多种选择模式**: 支持单日、范围、月份选择模式
- **灵活显示**: 支持弹窗、内联、底部面板等多种显示方式
- **日期限制**: 支持最小日期、最大日期、禁用日期等限制
- **自定义样式**: 支持自定义颜色、字体、布局等样式
- **国际化**: 支持多语言和本地化格式
- **主题适配**: 完整的主题系统支持

### 适用场景
- 生日选择
- 预约日期
- 出行日期
- 截止日期
- 日期范围筛选
- 报表日期选择

## 🚀 基础用法

### 基本日期选择器

```dart
ZephyrDatePicker(
  selectedDate: _selectedDate,
  onDateSelected: (date) => setState(() => _selectedDate = date),
)
```

### 带标签的日期选择器

```dart
ZephyrDatePicker(
  label: '出生日期',
  selectedDate: _birthDate,
  onDateSelected: (date) => setState(() => _birthDate = date),
)
```

### 日期范围选择器

```dart
ZephyrDatePicker(
  label: '出行日期',
  mode: ZephyrDatePickerMode.range,
  selectedRange: _dateRange,
  onRangeSelected: (range) => setState(() => _dateRange = range),
)
```

### 带日期限制的选择器

```dart
ZephyrDatePicker(
  label: '预约日期',
  selectedDate: _appointmentDate,
  firstDate: DateTime.now(),
  lastDate: DateTime.now().add(Duration(days: 30)),
  selectableDayPredicate: (date) {
    // 禁用周末
    return date.weekday != DateTime.saturday && date.weekday != DateTime.sunday;
  },
  onDateSelected: (date) => setState(() => _appointmentDate = date),
)
```

## 🎨 样式定制

### 显示模式

```dart
Column(
  children: [
    ZephyrDatePicker(
      label: '弹窗模式',
      selectedDate: _date1,
      displayMode: ZephyrDatePickerDisplayMode.dialog,
      onDateSelected: (date) => setState(() => _date1 = date),
    ),
    SizedBox(height: 16),
    ZephyrDatePicker(
      label: '底部面板',
      selectedDate: _date2,
      displayMode: ZephyrDatePickerDisplayMode.bottomSheet,
      onDateSelected: (date) => setState(() => _date2 = date),
    ),
    SizedBox(height: 16),
    ZephyrDatePicker(
      label: '内联模式',
      selectedDate: _date3,
      displayMode: ZephyrDatePickerDisplayMode.inline,
      onDateSelected: (date) => setState(() => _date3 = date),
    ),
  ],
)
```

### 自定义样式

```dart
ZephyrDatePicker(
  label: '自定义样式',
  selectedDate: _customDate,
  headerStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  weekdayStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.grey[600],
  ),
  dayStyle: TextStyle(
    fontSize: 16,
    color: Colors.black,
  ),
  selectedDayStyle: TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  selectedDayColor: Colors.blue,
  todayColor: Colors.green,
  disabledDayColor: Colors.grey[300],
  onDateSelected: (date) => setState(() => _customDate = date),
)
```

## 🔧 高级用法

### 酒店预订日期选择器

```dart
class HotelBookingDatePicker extends StatefulWidget {
  @override
  _HotelBookingDatePickerState createState() => _HotelBookingDatePickerState();
}

class _HotelBookingDatePickerState extends State<HotelBookingDatePicker> {
  DateTimeRange? _dateRange;
  int _guests = 1;
  int _rooms = 1;

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '选择日期',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ZephyrDatePicker(
              mode: ZephyrDatePickerMode.range,
              selectedRange: _dateRange,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
              selectableDayPredicate: (date) {
                // 禁用过去的日期
                return !date.isBefore(DateTime.now());
              },
              onRangeSelected: (range) {
                setState(() {
                  _dateRange = range;
                });
              },
            ),
            if (_dateRange != null)
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  '入住: ${DateFormat('yyyy-MM-dd').format(_dateRange!.start)}\n'
                  '退房: ${DateFormat('yyyy-MM-dd').format(_dateRange!.end)}\n'
                  '共 ${_dateRange!.duration.inDays} 晚',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
```

### 报表日期选择器

```dart
class ReportDatePicker extends StatefulWidget {
  final ValueChanged<DateTimeRange?> onDateRangeChanged;

  const ReportDatePicker({
    Key? key,
    required this.onDateRangeChanged,
  }) : super(key: key);

  @override
  _ReportDatePickerState createState() => _ReportDatePickerState();
}

class _ReportDatePickerState extends State<ReportDatePicker> {
  DateTimeRange? _selectedRange;
  ZephyrDateRangePreset? _selectedPreset;

  final List<ZephyrDateRangePreset> _presets = [
    ZephyrDateRangePreset(
      label: '今天',
      range: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      ),
    ),
    ZephyrDateRangePreset(
      label: '本周',
      range: DateTimeRange(
        start: DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
        end: DateTime.now(),
      ),
    ),
    ZephyrDateRangePreset(
      label: '本月',
      range: DateTimeRange(
        start: DateTime(DateTime.now().year, DateTime.now().month, 1),
        end: DateTime.now(),
      ),
    ),
    ZephyrDateRangePreset(
      label: '上月',
      range: DateTimeRange(
        start: DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
        end: DateTime(DateTime.now().year, DateTime.now().month, 0),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '快速选择',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _presets.map((preset) {
            final isSelected = _selectedPreset?.label == preset.label;
            return InputChip(
              label: Text(preset.label),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedPreset = preset;
                    _selectedRange = preset.range;
                  } else {
                    _selectedPreset = null;
                  }
                });
                widget.onDateRangeChanged(_selectedRange);
              },
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Text(
          '自定义日期',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        ZephyrDatePicker(
          mode: ZephyrDatePickerMode.range,
          selectedRange: _selectedRange,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now(),
          onRangeSelected: (range) {
            setState(() {
              _selectedRange = range;
              _selectedPreset = null;
            });
            widget.onDateRangeChanged(range);
          },
        ),
      ],
    );
  }
}
```

### 生日选择器

```dart
class BirthdayDatePicker extends StatefulWidget {
  final ValueChanged<DateTime?> onBirthdayChanged;

  const BirthdayDatePicker({
    Key? key,
    required this.onBirthdayChanged,
  }) : super(key: key);

  @override
  _BirthdayDatePickerState createState() => _BirthdayDatePickerState();
}

class _BirthdayDatePickerState extends State<BirthdayDatePicker> {
  DateTime? _selectedDate;
  int _selectedYear = 1990;
  int _selectedMonth = 1;
  int _selectedDay = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择生日',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        // 年份选择
        Row(
          children: [
            Text('年份: '),
            SizedBox(width: 8),
            DropdownButton<int>(
              value: _selectedYear,
              items: List.generate(100, (index) => 2024 - index)
                  .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text('$year年'),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedYear = value!;
                  _updateSelectedDate();
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        // 月份和日期选择
        ZephyrDatePicker(
          mode: ZephyrDatePickerMode.single,
          selectedDate: _selectedDate,
          firstDate: DateTime(_selectedYear, 1, 1),
          lastDate: DateTime(_selectedYear, 12, 31),
          initialCalendarMode: ZephyrDatePickerMode.month,
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date;
              _selectedMonth = date.month;
              _selectedDay = date.day;
            });
            widget.onBirthdayChanged(date);
          },
        ),
        if (_selectedDate != null)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              '您的生日: ${DateFormat('yyyy年MM月dd日').format(_selectedDate!)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  void _updateSelectedDate() {
    try {
      final newDate = DateTime(_selectedYear, _selectedMonth, _selectedDay);
      setState(() {
        _selectedDate = newDate;
      });
      widget.onBirthdayChanged(newDate);
    } catch (e) {
      // 处理无效日期
      setState(() {
        _selectedDate = null;
      });
      widget.onBirthdayChanged(null);
    }
  }
}
```

### 自定义日历单元格

```dart
class CustomCalendarDatePicker extends StatefulWidget {
  @override
  _CustomCalendarDatePickerState createState() => _CustomCalendarDatePickerState();
}

class _CustomCalendarDatePickerState extends State<CustomCalendarDatePicker> {
  DateTime? _selectedDate;
  final List<DateTime> _eventDates = [
    DateTime.now().add(Duration(days: 1)),
    DateTime.now().add(Duration(days: 5)),
    DateTime.now().add(Duration(days: 10)),
  ];

  @override
  Widget build(BuildContext context) {
    return ZephyrDatePicker(
      selectedDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      dayBuilder: (context, date, isSelected, isDisabled, isToday) {
        final hasEvent = _eventDates.any((eventDate) => 
          eventDate.year == date.year && 
          eventDate.month == date.month && 
          eventDate.day == date.day
        );

        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue
                : isToday
                    ? Colors.green[100]
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : isDisabled
                            ? Colors.grey[400]
                            : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (hasEvent)
                Positioned(
                  bottom: 2,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      onDateSelected: (date) => setState(() => _selectedDate = date),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrDatePicker()

```dart
const ZephyrDatePicker({
  Key? key,
  String? label,
  ZephyrDatePickerMode mode = ZephyrDatePickerMode.single,
  DateTime? selectedDate,
  DateTimeRange? selectedRange,
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? currentDate,
  ZephyrDatePickerDisplayMode displayMode = ZephyrDatePickerDisplayMode.dialog,
  ZephyrDatePickerInitialMode initialCalendarMode = ZephyrDatePickerInitialMode.day,
  bool Function(DateTime)? selectableDayPredicate,
  void Function(DateTime)? onDateSelected,
  void Function(DateTimeRange)? onRangeSelected,
  void Function()? onCancel,
  String? confirmText,
  String? cancelText,
  String? helpText,
  TextStyle? headerStyle,
  TextStyle? weekdayStyle,
  TextStyle? dayStyle,
  TextStyle? selectedDayStyle,
  TextStyle? disabledDayStyle,
  TextStyle? todayStyle,
  Color? selectedDayColor,
  Color? todayColor,
  Color? disabledDayColor,
  Color? rangeHighlightColor,
  Widget Function(BuildContext context, DateTime date, bool isSelected, bool isDisabled, bool isToday)? dayBuilder,
  String? semanticLabel,
})
```

**参数说明：**
- `label`: 选择器标签
- `mode`: 选择模式（单日、范围）
- `selectedDate`: 选中的日期
- `selectedRange`: 选中的日期范围
- `firstDate`: 可选择的最小日期
- `lastDate`: 可选择的最大日期
- `currentDate`: 当前日期
- `displayMode`: 显示模式（弹窗、底部面板、内联）
- `initialCalendarMode`: 初始日历模式
- `selectableDayPredicate`: 日期选择条件
- `onDateSelected`: 日期选择回调
- `onRangeSelected`: 范围选择回调
- `onCancel`: 取消回调
- `confirmText`: 确认按钮文本
- `cancelText`: 取消按钮文本
- `helpText`: 帮助文本
- `headerStyle`: 标题样式
- `weekdayStyle`: 星期样式
- `dayStyle`: 日期样式
- `selectedDayStyle`: 选中日期样式
- `disabledDayStyle`: 禁用日期样式
- `todayStyle`: 今日样式
- `selectedDayColor`: 选中日期颜色
- `todayColor`: 今日颜色
- `disabledDayColor`: 禁用日期颜色
- `rangeHighlightColor`: 范围高亮颜色
- `dayBuilder`: 自定义日期构建器
- `semanticLabel`: 语义标签

### 枚举类型

#### ZephyrDatePickerMode

```dart
enum ZephyrDatePickerMode {
  single,  // 单日选择
  range,   // 范围选择
}
```

#### ZephyrDatePickerDisplayMode

```dart
enum ZephyrDatePickerDisplayMode {
  dialog,      // 弹窗模式
  bottomSheet, // 底部面板模式
  inline,      // 内联模式
}
```

#### ZephyrDatePickerInitialMode

```dart
enum ZephyrDatePickerInitialMode {
  day,    // 日视图
  month,  // 月视图
  year,   // 年视图
}
```

### ZephyrDateRangePreset

```dart
class ZephyrDateRangePreset {
  final String label;
  final DateTimeRange range;

  const ZephyrDateRangePreset({
    required this.label,
    required this.range,
  });
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrDatePickerTheme(
        backgroundColor: Colors.white,
        selectedDayColor: Colors.blue,
        todayColor: Colors.green,
        disabledDayColor: Colors.grey[300],
        rangeHighlightColor: Colors.blue.withOpacity(0.2),
        headerStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        weekdayStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
        dayStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        selectedDayStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        disabledDayStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey[400],
        ),
        todayStyle: TextStyle(
          fontSize: 16,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `backgroundColor`: 背景颜色
- `selectedDayColor`: 选中日期颜色
- `todayColor`: 今日颜色
- `disabledDayColor`: 禁用日期颜色
- `rangeHighlightColor`: 范围高亮颜色
- `headerStyle`: 标题样式
- `weekdayStyle`: 星期样式
- `dayStyle`: 日期样式
- `selectedDayStyle`: 选中日期样式
- `disabledDayStyle`: 禁用日期样式
- `todayStyle`: 今日样式

## 🏆 最佳实践

### 1. 合理的日期范围

```dart
// ✅ 好的做法：根据业务场景设置合适的日期范围
ZephyrDatePicker(
  selectedDate: _birthDate,
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
  onDateSelected: (date) => setState(() => _birthDate = date),
)

ZephyrDatePicker(
  selectedDate: _appointmentDate,
  firstDate: DateTime.now(),
  lastDate: DateTime.now().add(Duration(days: 30)),
  onDateSelected: (date) => setState(() => _appointmentDate = date),
)

// ❌ 避免的做法：日期范围不合理
ZephyrDatePicker(
  selectedDate: _appointmentDate,
  firstDate: DateTime.now().subtract(Duration(days: 365)),  // 允许选择过去的预约日期
  lastDate: DateTime.now().add(Duration(days: 365)),
  onDateSelected: (date) => setState(() => _appointmentDate = date),
)
```

### 2. 日期限制

```dart
// ✅ 好的做法：禁用不合适的日期
ZephyrDatePicker(
  selectedDate: _deliveryDate,
  firstDate: DateTime.now().add(Duration(days: 1)),
  lastDate: DateTime.now().add(Duration(days: 30)),
  selectableDayPredicate: (date) {
    // 禁用周末
    return date.weekday != DateTime.saturday && date.weekday != DateTime.sunday;
  },
  onDateSelected: (date) => setState(() => _deliveryDate = date),
)

// ✅ 好的做法：禁用节假日
ZephyrDatePicker(
  selectedDate: _holidayDate,
  firstDate: DateTime.now(),
  lastDate: DateTime.now().add(Duration(days: 90)),
  selectableDayPredicate: (date) {
    final holidays = [
      DateTime(2024, 1, 1),  // 元旦
      DateTime(2024, 2, 10), // 春节
      // 更多节假日...
    ];
    return !holidays.any((holiday) => 
      holiday.year == date.year && 
      holiday.month == date.month && 
      holiday.day == date.day
    );
  },
  onDateSelected: (date) => setState(() => _holidayDate = date),
)
```

### 3. 用户体验优化

```dart
// ✅ 好的做法：提供预设选项
ZephyrDatePicker(
  mode: ZephyrDatePickerMode.range,
  selectedRange: _dateRange,
  presets: [
    ZephyrDateRangePreset(
      label: '本周',
      range: DateTimeRange(
        start: DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
        end: DateTime.now(),
      ),
    ),
    ZephyrDateRangePreset(
      label: '本月',
      range: DateTimeRange(
        start: DateTime(DateTime.now().year, DateTime.now().month, 1),
        end: DateTime.now(),
      ),
    ),
  ],
  onRangeSelected: (range) => setState(() => _dateRange = range),
)

// ✅ 好的做法：提供清晰的视觉反馈
ZephyrDatePicker(
  selectedDate: _selectedDate,
  dayBuilder: (context, date, isSelected, isDisabled, isToday) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  },
  onDateSelected: (date) => setState(() => _selectedDate = date),
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrDatePicker(
  label: '出生日期',
  semanticLabel: '出生日期选择器',
  selectedDate: _birthDate,
  onDateSelected: (date) => setState(() => _birthDate = date),
)

// ✅ 好的做法：提供键盘导航支持
Focus(
  child: ZephyrDatePicker(
    selectedDate: _selectedDate,
    onDateSelected: (date) => setState(() => _selectedDate = date),
  ),
)
```

## 🔄 相关组件

- **ZephyrTimePicker**: 时间选择器
- **ZephyrDateTimePicker**: 日期时间选择器
- **ZephyrInputField**: 日期输入框
- **ZephyrFormBuilder**: 表单构建器

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持单日和范围选择
- ✅ 多种显示模式
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/form/date_picker/`
**示例路径**: `example/lib/components/date_picker_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月19日