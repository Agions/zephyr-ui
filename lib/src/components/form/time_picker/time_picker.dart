/// ZephyrUI 时间选择器组件
///
/// 提供时间选择功能，支持多种显示模式和自定义主题。
library time_picker;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 时间选择器模式
enum ZephyrTimePickerMode {
  /// 24小时制
  hour24,
  
  /// 12小时制
  hour12,
}

/// 时间选择器组件
///
/// 一个功能丰富的时间选择器组件，支持多种模式。
///
/// 示例用法:
/// ```dart
/// ZephyrTimePicker(
///   initialTime: TimeOfDay.now(),
///   mode: ZephyrTimePickerMode.hour24,
///   onTimeSelected: (time) => print(time),
/// )
/// ```
class ZephyrTimePicker extends StatefulWidget {
  /// 创建时间选择器组件
  const ZephyrTimePicker({
    super.key,
    this.initialTime,
    this.mode = ZephyrTimePickerMode.hour24,
    this.onTimeSelected,
    this.title = '选择时间',
    this.confirmText = '确定',
    this.cancelText = '取消',
    this.theme,
    this.showSeconds = false,
    this.minuteInterval = 1,
    this.secondInterval = 1,
  });

  /// 初始时间
  final TimeOfDay? initialTime;

  /// 时间模式
  final ZephyrTimePickerMode mode;

  /// 时间选择回调
  final Function(TimeOfDay)? onTimeSelected;

  /// 标题文本
  final String title;

  /// 确认按钮文本
  final String confirmText;

  /// 取消按钮文本
  final String cancelText;

  /// 主题
  final ZephyrTimePickerTheme? theme;

  /// 是否显示秒
  final bool showSeconds;

  /// 分钟间隔
  final int minuteInterval;

  /// 秒间隔
  final int secondInterval;

  @override
  State<ZephyrTimePicker> createState() => _ZephyrTimePickerState();
}

class _ZephyrTimePickerState extends State<ZephyrTimePicker> {
  late TimeOfDay _selectedTime;
  late int _selectedHour;
  late int _selectedMinute;
  late int _selectedSecond;
  late ZephyrTimePickerTheme _theme;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime ?? TimeOfDay.now();
    _selectedHour = _selectedTime.hour;
    _selectedMinute = _selectedTime.minute;
    _selectedSecond = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = widget.theme ?? ZephyrTimePickerTheme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        _buildTimePicker(),
        _buildFooter(),
      ],
    );
  }

  /// 构建头部
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: _theme.headerBackgroundColor,
      ),
      child: Text(
        widget.title,
        style: _theme.headerTextStyle,
      ),
    );
  }

  /// 构建时间选择器
  Widget _buildTimePicker() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNumberPicker(
                value: _selectedHour,
                min: 0,
                max: widget.mode == ZephyrTimePickerMode.hour24 ? 23 : 11,
                onChanged: (value) {
                  setState(() {
                    _selectedHour = value;
                    _updateSelectedTime();
                  });
                },
                label: '时',
              ),
              Text(':', style: _theme.timeSeparatorStyle),
              _buildNumberPicker(
                value: _selectedMinute,
                min: 0,
                max: 59,
                interval: widget.minuteInterval,
                onChanged: (value) {
                  setState(() {
                    _selectedMinute = value;
                    _updateSelectedTime();
                  });
                },
                label: '分',
              ),
              if (widget.showSeconds) ...[
                Text(':', style: _theme.timeSeparatorStyle),
                _buildNumberPicker(
                  value: _selectedSecond,
                  min: 0,
                  max: 59,
                  interval: widget.secondInterval,
                  onChanged: (value) {
                    setState(() {
                      _selectedSecond = value;
                      _updateSelectedTime();
                    });
                  },
                  label: '秒',
                ),
              ],
              if (widget.mode == ZephyrTimePickerMode.hour12) ...[
                const SizedBox(width: 16),
                _buildPeriodSelector(),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// 构建数字选择器
  Widget _buildNumberPicker({
    required int value,
    required int min,
    required int max,
    required Function(int) onChanged,
    required String label,
    int interval = 1,
  }) {
    return Column(
      children: [
        Text(label, style: _theme.labelStyle),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _theme.borderColor),
            borderRadius: _theme.borderRadius,
          ),
          child: Column(
            children: [
              // 增加按钮
              InkWell(
                onTap: value < max 
                    ? () => onChanged(value + interval)
                    : null,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Container(
                  width: 60,
                  height: 40,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: value < max ? _theme.iconColor : _theme.disabledIconColor,
                  ),
                ),
              ),
              
              // 当前值
              Container(
                width: 60,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    top: const BorderSide(color: _theme.borderColor),
                    bottom: const BorderSide(color: _theme.borderColor),
                  ),
                ),
                child: Text(
                  value.toString().padLeft(2, '0'),
                  style: _theme.timeNumberStyle,
                ),
              ),
              
              // 减少按钮
              InkWell(
                onTap: value > min 
                    ? () => onChanged(value - interval)
                    : null,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Container(
                  width: 60,
                  height: 40,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: value > min ? _theme.iconColor : _theme.disabledIconColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建时间段选择器
  Widget _buildPeriodSelector() {
    final isPM = _selectedHour >= 12;
    
    return Column(
      children: [
        const SizedBox(height: 32),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _theme.borderColor),
            borderRadius: _theme.borderRadius,
          ),
          child: Column(
            children: [
              // AM
              InkWell(
                onTap: () {
                  if (isPM) {
                    setState(() {
                      _selectedHour = _selectedHour - 12;
                      _updateSelectedTime();
                    });
                  }
                },
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Container(
                  width: 60,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: !isPM ? _theme.selectedPeriodColor : null,
                    border: Border(
                      bottom: const BorderSide(color: _theme.borderColor),
                    ),
                  ),
                  child: Text(
                    'AM',
                    style: !isPM ? _theme.selectedPeriodStyle : _theme.periodStyle,
                  ),
                ),
              ),
              
              // PM
              InkWell(
                onTap: () {
                  if (!isPM) {
                    setState(() {
                      _selectedHour = _selectedHour + 12;
                      _updateSelectedTime();
                    });
                  }
                },
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Container(
                  width: 60,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isPM ? _theme.selectedPeriodColor : null,
                  ),
                  child: Text(
                    'PM',
                    style: isPM ? _theme.selectedPeriodStyle : _theme.periodStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建底部操作区域
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              widget.cancelText,
              style: _theme.buttonTextStyle,
            ),
          ),
          const SizedBox(width: 16),
          TextButton(
            onPressed: () {
              widget.onTimeSelected?.call(_selectedTime);
              Navigator.of(context).pop();
            },
            child: Text(
              widget.confirmText,
              style: _theme.buttonTextStyle.copyWith(
                color: _theme.confirmButtonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 更新选中时间
  void _updateSelectedTime() {
    setState(() {
      _selectedTime = TimeOfDay(
        hour: widget.mode == ZephyrTimePickerMode.hour12 && _selectedHour > 12
            ? _selectedHour - 12
            : _selectedHour,
        minute: _selectedMinute,
      );
    });
  }
}

/// 显示时间选择器对话框
Future<TimeOfDay?> showZephyrTimePicker({
  required BuildContext context,
  TimeOfDay? initialTime,
  ZephyrTimePickerMode mode = ZephyrTimePickerMode.hour24,
  String title = '选择时间',
  String confirmText = '确定',
  String cancelText = '取消',
  ZephyrTimePickerTheme? theme,
  bool showSeconds = false,
  int minuteInterval = 1,
  int secondInterval = 1,
}) async {
  final TimeOfDay? result = await showDialog<TimeOfDay>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 400.0,
            maxHeight: 500.0,
          ),
          child: ZephyrTimePicker(
            initialTime: initialTime,
            mode: mode,
            title: title,
            confirmText: confirmText,
            cancelText: cancelText,
            theme: theme,
            showSeconds: showSeconds,
            minuteInterval: minuteInterval,
            secondInterval: secondInterval,
            onTimeSelected: (time) {
              Navigator.of(context).pop(time);
            },
          ),
        ),
      );
    },
  );

  return result;
}