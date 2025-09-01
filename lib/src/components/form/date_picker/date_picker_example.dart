import 'package:flutter/material.dart';
import 'date_picker.dart';
import 'date_picker_theme.dart';

/// 日期选择器组件的使用示例
class ZephyrDatePickerExample extends StatefulWidget {
  /// 创建示例
  const ZephyrDatePickerExample({Key? key}) : super(key: key);

  @override
  State<ZephyrDatePickerExample> createState() =>
      _ZephyrDatePickerExampleState();
}

class _ZephyrDatePickerExampleState extends State<ZephyrDatePickerExample> {
  DateTime? _selectedDate;
  DateTimeRange? _selectedDateRange;
  final DateTime _firstDate = DateTime(DateTime.now().year - 1, 1, 1);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1, 12, 31);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '日期选择器示例',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // 标准日期选择器
          const Text('标准日期选择器'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _showDatePicker,
            child: const Text('选择日期'),
          ),
          if (_selectedDate != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('已选择: ${_formatDate(_selectedDate!)}'),
            ),
          const SizedBox(height: 24),

          // 日期范围选择器
          const Text('日期范围选择器'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _showDateRangePicker,
            child: const Text('选择日期范围'),
          ),
          if (_selectedDateRange != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '已选择: ${_formatDate(_selectedDateRange!.start)} 至 ${_formatDate(_selectedDateRange!.end)}',
              ),
            ),
          const SizedBox(height: 24),

          // 自定义主题日期选择器
          const Text('自定义主题日期选择器'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _showCustomDatePicker,
            child: const Text('自定义主题'),
          ),
          const SizedBox(height: 24),

          // 内联日期选择器
          const Text('内联日期选择器'),
          const SizedBox(height: 8),
          SizedBox(
            height: 350,
            child: ZephyrDatePicker(
              firstDate: _firstDate,
              lastDate: _lastDate,
              initialDate: DateTime.now(),
              mode: ZephyrDatePickerMode.single,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
              showResetButton: false,
            ),
          ),
        ],
      ),
    );
  }

  // 显示标准日期选择器
  Future<void> _showDatePicker() async {
    final date = await showZephyrDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  // 显示日期范围选择器
  Future<void> _showDateRangePicker() async {
    final dateRange = await showZephyrDateRangePicker(
      context: context,
      initialStartDate: _selectedDateRange?.start,
      initialEndDate: _selectedDateRange?.end,
      firstDate: _firstDate,
      lastDate: _lastDate,
    );

    if (dateRange != null) {
      setState(() {
        _selectedDateRange = dateRange;
      });
    }
  }

  // 显示自定义主题日期选择器
  Future<void> _showCustomDatePicker() async {
    final customTheme = ZephyrDatePickerTheme(
      primaryColor: Colors.purple,
      selectedDateBackgroundColor: Colors.purple,
      selectedDateTextColor: Colors.white,
      currentDateBackgroundColor: Colors.purple.withValues(alpha: 0.1),
      currentDateTextColor: Colors.purple,
      dateTextColor: Colors.black87,
      disabledDateTextColor: Colors.black38,
      weekendDateTextColor: Colors.pink.shade300,
      rangeDateBackgroundColor: Colors.purple.withValues(alpha: 0.2),
      headerBackgroundColor: Colors.purple.shade50,
      headerTextColor: Colors.black87,
      headerYearStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),
      headerMonthStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      weekdayStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.purple,
      ),
      dateStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      selectedDateStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      buttonTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.purple,
      ),
      disabledButtonTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      dateCellBorderRadius: 8.0,
    );

    final date = await showZephyrDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
      theme: customTheme,
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  // 格式化日期
  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }
}
