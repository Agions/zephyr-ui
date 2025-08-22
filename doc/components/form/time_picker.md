# ZephyrTimePicker 时间选择器组件

时间选择器是一个功能强大的时间选择控件，支持多种选择模式和自定义样式。提供了直观的时间选择体验，包括时间选择、时间范围选择等功能。

## 🎯 组件概述

### 特性
- **多种选择模式**: 支持时间、时间范围选择模式
- **灵活显示**: 支持弹窗、内联、底部面板等多种显示方式
- **时间限制**: 支持最小时间、最大时间、禁用时间等限制
- **自定义样式**: 支持自定义颜色、字体、布局等样式
- **国际化**: 支持多语言和本地化格式
- **主题适配**: 完整的主题系统支持

### 适用场景
- 预约时间
- 会议时间
- 提醒时间
- 营业时间
- 上下班时间
- 活动时间

## 🚀 基础用法

### 基本时间选择器

```dart
ZephyrTimePicker(
  selectedTime: _selectedTime,
  onTimeSelected: (time) => setState(() => _selectedTime = time),
)
```

### 带标签的时间选择器

```dart
ZephyrTimePicker(
  label: '上班时间',
  selectedTime: _workStartTime,
  onTimeSelected: (time) => setState(() => _workStartTime = time),
)
```

### 时间范围选择器

```dart
ZephyrTimePicker(
  label: '营业时间',
  mode: ZephyrTimePickerMode.range,
  selectedRange: _businessHours,
  onRangeSelected: (range) => setState(() => _businessHours = range),
)
```

### 带时间限制的选择器

```dart
ZephyrTimePicker(
  label: '预约时间',
  selectedTime: _appointmentTime,
  firstTime: TimeOfDay(hour: 9, minute: 0),
  lastTime: TimeOfDay(hour: 18, minute: 0),
  selectableTimePredicate: (time) {
    // 禁用午休时间
    return !(time.hour >= 12 && time.hour < 14);
  },
  onTimeSelected: (time) => setState(() => _appointmentTime = time),
)
```

## 🎨 样式定制

### 显示模式

```dart
Column(
  children: [
    ZephyrTimePicker(
      label: '弹窗模式',
      selectedTime: _time1,
      displayMode: ZephyrTimePickerDisplayMode.dialog,
      onTimeSelected: (time) => setState(() => _time1 = time),
    ),
    SizedBox(height: 16),
    ZephyrTimePicker(
      label: '底部面板',
      selectedTime: _time2,
      displayMode: ZephyrTimePickerDisplayMode.bottomSheet,
      onTimeSelected: (time) => setState(() => _time2 = time),
    ),
    SizedBox(height: 16),
    ZephyrTimePicker(
      label: '内联模式',
      selectedTime: _time3,
      displayMode: ZephyrTimePickerDisplayMode.inline,
      onTimeSelected: (time) => setState(() => _time3 = time),
    ),
  ],
)
```

### 时间格式

```dart
Column(
  children: [
    ZephyrTimePicker(
      label: '24小时制',
      selectedTime: _time1,
      hourFormat: HourFormat.H24,
      onTimeSelected: (time) => setState(() => _time1 = time),
    ),
    SizedBox(height: 16),
    ZephyrTimePicker(
      label: '12小时制',
      selectedTime: _time2,
      hourFormat: HourFormat.H12,
      onTimeSelected: (time) => setState(() => _time2 = time),
    ),
  ],
)
```

### 自定义样式

```dart
ZephyrTimePicker(
  label: '自定义样式',
  selectedTime: _customTime,
  headerStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  dialTextStyle: TextStyle(
    fontSize: 16,
    color: Colors.black,
  ),
  selectedDialTextStyle: TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  selectedDialColor: Colors.blue,
  backgroundColor: Colors.grey[100],
  onTimeSelected: (time) => setState(() => _customTime = time),
)
```

## 🔧 高级用法

### 会议时间选择器

```dart
class MeetingTimePicker extends StatefulWidget {
  final ValueChanged<TimeOfDay> onTimeSelected;

  const MeetingTimePicker({
    Key? key,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  _MeetingTimePickerState createState() => _MeetingTimePickerState();
}

class _MeetingTimePickerState extends State<MeetingTimePicker> {
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择会议时间',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        // 日期选择
        ZephyrDatePicker(
          selectedDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 30)),
          onDateSelected: (date) => setState(() => _selectedDate = date),
        ),
        SizedBox(height: 16),
        // 时间选择
        ZephyrTimePicker(
          selectedTime: _selectedTime,
          firstTime: TimeOfDay(hour: 9, minute: 0),
          lastTime: TimeOfDay(hour: 18, minute: 0),
          selectableTimePredicate: (time) {
            // 禁用周末
            if (_selectedDate != null) {
              final weekday = _selectedDate!.weekday;
              if (weekday == DateTime.saturday || weekday == DateTime.sunday) {
                return false;
              }
            }
            // 禁用午休时间
            return !(time.hour >= 12 && time.hour < 14);
          },
          onTimeSelected: (time) {
            setState(() {
              _selectedTime = time;
            });
            widget.onTimeSelected(time);
          },
        ),
        if (_selectedDate != null && _selectedTime != null)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              '会议时间：${DateFormat('yyyy-MM-dd').format(_selectedDate!)} '
              '${_selectedTime!.format(context)}',
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
}
```

### 营业时间设置器

```dart
class BusinessHoursPicker extends StatefulWidget {
  final ValueChanged<TimeRange> onHoursChanged;

  const BusinessHoursPicker({
    Key? key,
    required this.onHoursChanged,
  }) : super(key: key);

  @override
  _BusinessHoursPickerState createState() => _BusinessHoursPickerState();
}

class _BusinessHoursPickerState extends State<BusinessHoursPicker> {
  TimeRange? _businessHours;
  List<DaySchedule> _weekSchedule = [];

  @override
  void initState() {
    super.initState();
    _initializeWeekSchedule();
  }

  void _initializeWeekSchedule() {
    final days = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    _weekSchedule = days.map((day) => DaySchedule(
      day: day,
      isOpen: true,
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 18, minute: 0),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '营业时间设置',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        // 统一营业时间
        ZephyrTimePicker(
          label: '统一营业时间',
          mode: ZephyrTimePickerMode.range,
          selectedRange: _businessHours,
          onRangeSelected: (range) {
            setState(() {
              _businessHours = range;
              _updateAllSchedules(range);
            });
            widget.onHoursChanged(range);
          },
        ),
        SizedBox(height: 24),
        Text(
          '每日营业时间',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),
        ..._weekSchedule.map((schedule) {
          return Card(
            margin: EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      schedule.day,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  ZephyrSwitch(
                    value: schedule.isOpen,
                    onChanged: (value) {
                      setState(() {
                        schedule.isOpen = value;
                      });
                    },
                  ),
                  SizedBox(width: 12),
                  if (schedule.isOpen)
                    Expanded(
                      child: ZephyrTimePicker(
                        mode: ZephyrTimePickerMode.range,
                        selectedRange: TimeRange(
                          start: schedule.startTime,
                          end: schedule.endTime,
                        ),
                        displayMode: ZephyrTimePickerDisplayMode.inline,
                        onRangeSelected: (range) {
                          setState(() {
                            schedule.startTime = range.start;
                            schedule.endTime = range.end;
                          });
                        },
                      ),
                    )
                  else
                    Text(
                      '休息日',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  void _updateAllSchedules(TimeRange range) {
    for (final schedule in _weekSchedule) {
      if (schedule.isOpen) {
        schedule.startTime = range.start;
        schedule.endTime = range.end;
      }
    }
  }
}

class DaySchedule {
  final String day;
  bool isOpen;
  TimeOfDay startTime;
  TimeOfDay endTime;

  DaySchedule({
    required this.day,
    required this.isOpen,
    required this.startTime,
    required this.endTime,
  });
}

class TimeRange {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeRange({
    required this.start,
    required this.end,
  });
}
```

### 提醒时间选择器

```dart
class ReminderTimePicker extends StatefulWidget {
  final ValueChanged<Duration> onReminderChanged;

  const ReminderTimePicker({
    Key? key,
    required this.onReminderChanged,
  }) : super(key: key);

  @override
  _ReminderTimePickerState createState() => _ReminderTimePickerState();
}

class _ReminderTimePickerState extends State<ReminderTimePicker> {
  Duration? _selectedDuration;
  ZephyrTimePreset? _selectedPreset;

  final List<ZephyrTimePreset> _presets = [
    ZephyrTimePreset(
      label: '5分钟前',
      duration: Duration(minutes: 5),
    ),
    ZephyrTimePreset(
      label: '15分钟前',
      duration: Duration(minutes: 15),
    ),
    ZephyrTimePreset(
      label: '30分钟前',
      duration: Duration(minutes: 30),
    ),
    ZephyrTimePreset(
      label: '1小时前',
      duration: Duration(hours: 1),
    ),
    ZephyrTimePreset(
      label: '2小时前',
      duration: Duration(hours: 2),
    ),
    ZephyrTimePreset(
      label: '1天前',
      duration: Duration(days: 1),
    ),
    ZephyrTimePreset(
      label: '自定义',
      duration: Duration(minutes: 30),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '提醒时间',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _presets.map((preset) {
            final isSelected = _selectedPreset?.label == preset.label;
            return InputChip(
              label: Text(preset.label),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedPreset = preset;
                    _selectedDuration = preset.duration;
                  } else {
                    _selectedPreset = null;
                    _selectedDuration = null;
                  }
                });
                widget.onReminderChanged(_selectedDuration);
              },
            );
          }).toList(),
        ),
        if (_selectedPreset?.label == '自定义') ...[
          SizedBox(height: 16),
          _buildCustomTimePicker(),
        ],
        if (_selectedDuration != null)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              '将在活动开始前 ${_formatDuration(_selectedDuration!)} 提醒您',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCustomTimePicker() {
    return Row(
      children: [
        Expanded(
          child: ZephyrTimePicker(
            selectedTime: TimeOfDay(
              hour: _selectedDuration!.inHours,
              minute: _selectedDuration!.inMinutes % 60,
            ),
            hourFormat: HourFormat.H24,
            onTimeSelected: (time) {
              setState(() {
                _selectedDuration = Duration(
                  hours: time.hour,
                  minutes: time.minute,
                );
              });
              widget.onReminderChanged(_selectedDuration!);
            },
          ),
        ),
        SizedBox(width: 16),
        Text(
          '前',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}天';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}小时';
    } else {
      return '${duration.inMinutes}分钟';
    }
  }
}

class ZephyrTimePreset {
  final String label;
  final Duration duration;

  const ZephyrTimePreset({
    required this.label,
    required this.duration,
  });
}
```

### 快速时间选择器

```dart
class QuickTimePicker extends StatelessWidget {
  final String label;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeSelected;
  final List<QuickTimeOption> quickOptions;

  const QuickTimePicker({
    Key? key,
    required this.label,
    this.initialTime,
    required this.onTimeSelected,
    this.quickOptions = const [
      QuickTimeOption(label: '现在', time: null),
      QuickTimeOption(label: '9:00', time: TimeOfDay(hour: 9, minute: 0)),
      QuickTimeOption(label: '12:00', time: TimeOfDay(hour: 12, minute: 0)),
      QuickTimeOption(label: '15:00', time: TimeOfDay(hour: 15, minute: 0)),
      QuickTimeOption(label: '18:00', time: TimeOfDay(hour: 18, minute: 0)),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: quickOptions.map((option) {
            return ElevatedButton(
              onPressed: () {
                final time = option.time ?? TimeOfDay.now();
                onTimeSelected(time);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                foregroundColor: Colors.black,
              ),
              child: Text(option.label),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        ZephyrTimePicker(
          selectedTime: initialTime ?? TimeOfDay.now(),
          onTimeSelected: onTimeSelected,
        ),
      ],
    );
  }
}

class QuickTimeOption {
  final String label;
  final TimeOfDay? time;

  const QuickTimeOption({
    required this.label,
    required this.time,
  });
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrTimePicker()

```dart
const ZephyrTimePicker({
  Key? key,
  String? label,
  ZephyrTimePickerMode mode = ZephyrTimePickerMode.single,
  TimeOfDay? selectedTime,
  TimeRange? selectedRange,
  TimeOfDay? firstTime,
  TimeOfDay? lastTime,
  TimeOfDay? currentTime,
  ZephyrTimePickerDisplayMode displayMode = ZephyrTimePickerDisplayMode.dialog,
  HourFormat hourFormat = HourFormat.H24,
  bool Function(TimeOfDay)? selectableTimePredicate,
  void Function(TimeOfDay)? onTimeSelected,
  void Function(TimeRange)? onRangeSelected,
  void Function()? onCancel,
  String? confirmText,
  String? cancelText,
  String? helpText,
  TextStyle? headerStyle,
  TextStyle? dialTextStyle,
  TextStyle? selectedDialTextStyle,
  TextStyle? helperTextStyle,
  Color? selectedDialColor,
  Color? backgroundColor,
  Color? unselectedDialColor,
  Widget Function(BuildContext context, int hour, int minute)? timeBuilder,
  String? semanticLabel,
})
```

**参数说明：**
- `label`: 选择器标签
- `mode`: 选择模式（单时间、范围）
- `selectedTime`: 选中的时间
- `selectedRange`: 选中的时间范围
- `firstTime`: 可选择的最小时间
- `lastTime`: 可选择的最大时间
- `currentTime`: 当前时间
- `displayMode`: 显示模式（弹窗、底部面板、内联）
- `hourFormat`: 小时格式
- `selectableTimePredicate`: 时间选择条件
- `onTimeSelected`: 时间选择回调
- `onRangeSelected`: 范围选择回调
- `onCancel`: 取消回调
- `confirmText`: 确认按钮文本
- `cancelText`: 取消按钮文本
- `helpText`: 帮助文本
- `headerStyle`: 标题样式
- `dialTextStyle`: 表盘文本样式
- `selectedDialTextStyle`: 选中表盘文本样式
- `helperTextStyle`: 帮助文本样式
- `selectedDialColor`: 选中表盘颜色
- `backgroundColor`: 背景颜色
- `unselectedDialColor`: 未选中表盘颜色
- `timeBuilder`: 自定义时间构建器
- `semanticLabel`: 语义标签

### 枚举类型

#### ZephyrTimePickerMode

```dart
enum ZephyrTimePickerMode {
  single,  // 单时间选择
  range,   // 时间范围选择
}
```

#### ZephyrTimePickerDisplayMode

```dart
enum ZephyrTimePickerDisplayMode {
  dialog,      // 弹窗模式
  bottomSheet, // 底部面板模式
  inline,      // 内联模式
}
```

#### HourFormat

```dart
enum HourFormat {
  H12,  // 12小时制
  H24,  // 24小时制
}
```

### TimeRange

```dart
class TimeRange {
  final TimeOfDay start;
  final TimeOfDay end;

  const TimeRange({
    required this.start,
    required this.end,
  });
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrTimePickerTheme(
        backgroundColor: Colors.white,
        selectedDialColor: Colors.blue,
        unselectedDialColor: Colors.grey[300],
        backgroundColor: Colors.grey[50],
        headerStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        dialTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        selectedDialTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        helperTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `backgroundColor`: 背景颜色
- `selectedDialColor`: 选中表盘颜色
- `unselectedDialColor`: 未选中表盘颜色
- `backgroundColor`: 表盘背景颜色
- `headerStyle`: 标题样式
- `dialTextStyle`: 表盘文本样式
- `selectedDialTextStyle`: 选中表盘文本样式
- `helperTextStyle`: 帮助文本样式

## 🏆 最佳实践

### 1. 合理的时间范围

```dart
// ✅ 好的做法：根据业务场景设置合适的时间范围
ZephyrTimePicker(
  selectedTime: _workStartTime,
  firstTime: TimeOfDay(hour: 8, minute: 0),
  lastTime: TimeOfDay(hour: 22, minute: 0),
  onTimeSelected: (time) => setState(() => _workStartTime = time),
)

ZephyrTimePicker(
  selectedTime: _appointmentTime,
  firstTime: TimeOfDay(hour: 9, minute: 0),
  lastTime: TimeOfDay(hour: 18, minute: 0),
  onTimeSelected: (time) => setState(() => _appointmentTime = time),
)

// ❌ 避免的做法：时间范围不合理
ZephyrTimePicker(
  selectedTime: _appointmentTime,
  firstTime: TimeOfDay(hour: 0, minute: 0),  // 允许选择凌晨时间
  lastTime: TimeOfDay(hour: 23, minute: 59),
  onTimeSelected: (time) => setState(() => _appointmentTime = time),
)
```

### 2. 时间限制

```dart
// ✅ 好的做法：禁用不合适的时间
ZephyrTimePicker(
  selectedTime: _deliveryTime,
  firstTime: TimeOfDay(hour: 10, minute: 0),
  lastTime: TimeOfDay(hour: 20, minute: 0),
  selectableTimePredicate: (time) {
    // 禁用午休时间
    return !(time.hour >= 12 && time.hour < 14);
  },
  onTimeSelected: (time) => setState(() => _deliveryTime = time),
)

// ✅ 好的做法：禁用非工作日时间
ZephyrTimePicker(
  selectedTime: _meetingTime,
  selectableTimePredicate: (time) {
    // 只允许工作时间的整点或半点
    return time.minute == 0 || time.minute == 30;
  },
  onTimeSelected: (time) => setState(() => _meetingTime = time),
)
```

### 3. 用户体验优化

```dart
// ✅ 好的做法：提供快速选择选项
QuickTimePicker(
  label: '预约时间',
  onTimeSelected: (time) => setState(() => _appointmentTime = time),
)

// ✅ 好的做法：提供预设选项
ZephyrTimePicker(
  selectedTime: _reminderTime,
  presets: [
    ZephyrTimePreset(
      label: '15分钟前',
      time: TimeOfDay.now().subtract(Duration(minutes: 15)),
    ),
    ZephyrTimePreset(
      label: '30分钟前',
      time: TimeOfDay.now().subtract(Duration(minutes: 30)),
    ),
  ],
  onTimeSelected: (time) => setState(() => _reminderTime = time),
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrTimePicker(
  label: '上班时间',
  semanticLabel: '上班时间选择器',
  selectedTime: _workStartTime,
  onTimeSelected: (time) => setState(() => _workStartTime = time),
)

// ✅ 好的做法：提供键盘导航支持
Focus(
  child: ZephyrTimePicker(
    selectedTime: _selectedTime,
    onTimeSelected: (time) => setState(() => _selectedTime = time),
  ),
)
```

### 5. 性能优化

```dart
// ✅ 好的做法：使用const构造函数
const timeRange = TimeRange(
  start: TimeOfDay(hour: 9, minute: 0),
  end: TimeOfDay(hour: 18, minute: 0),
);

ZephyrTimePicker(
  selectedRange: timeRange,
  mode: ZephyrTimePickerMode.range,
  onRangeSelected: (range) => setState(() => _timeRange = range),
)

// ✅ 好的做法：避免不必要的重建
const timePickerTheme = ZephyrTimePickerTheme(
  selectedDialColor: Colors.blue,
  unselectedDialColor: Colors.grey[300],
);

ZephyrTimePicker(
  selectedTime: _selectedTime,
  theme: timePickerTheme,
  onTimeSelected: (time) => setState(() => _selectedTime = time),
)
```

## 🔄 相关组件

- **ZephyrDatePicker**: 日期选择器
- **ZephyrDateTimePicker**: 日期时间选择器
- **ZephyrInputField**: 时间输入框
- **ZephyrFormBuilder**: 表单构建器

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持单时间和范围选择
- ✅ 多种显示模式
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/form/time_picker/`
**示例路径**: `example/lib/components/time_picker_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日