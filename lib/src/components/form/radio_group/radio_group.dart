import 'package:flutter/material.dart';
import 'radio_group_theme.dart';

/// 单选按钮组数据项
class ZephyrRadioItem<T> {
  /// 选项值
  final T value;

  /// 选项显示文本
  final String label;

  /// 是否禁用此选项
  final bool disabled;

  /// 创建单选按钮项
  const ZephyrRadioItem({
    required this.value,
    required this.label,
    this.disabled = false,
  });
}

/// 单选按钮组布局方向
enum ZephyrRadioDirection {
  /// 垂直布局
  vertical,

  /// 水平布局
  horizontal,
}

/// 单选按钮组组件
///
/// 允许用户从多个选项中选择一个选项
class ZephyrRadioGroup<T> extends StatefulWidget {
  /// 单选按钮组选项列表
  final List<ZephyrRadioItem<T>> items;

  /// 当前选中的值
  final T? value;

  /// 布局方向
  final ZephyrRadioDirection direction;

  /// 是否禁用整个单选按钮组
  final bool disabled;

  /// 选择变更时的回调函数
  final ValueChanged<T>? onChanged;

  /// 自定义主题
  final ZephyrRadioGroupTheme? theme;

  /// 创建单选按钮组
  const ZephyrRadioGroup({
    super.key,
    required this.items,
    required this.value,
    this.direction = ZephyrRadioDirection.vertical,
    this.disabled = false,
    this.onChanged,
    this.theme,
  });

  @override
  State<ZephyrRadioGroup<T>> createState() => _ZephyrRadioGroupState<T>();
}

class _ZephyrRadioGroupState<T> extends State<ZephyrRadioGroup<T>> {
  late T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(ZephyrRadioGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
  }

  void _handleValueChange(T value) {
    setState(() {
      _value = value;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrRadioGroupTheme.of(context);

    final radioItems = widget.items.map((item) {
      return _ZephyrRadio<T>(
        value: item.value,
        groupValue: _value,
        label: item.label,
        disabled: widget.disabled || item.disabled,
        onChanged: widget.disabled ? null : _handleValueChange,
        theme: theme,
      );
    }).toList();

    return widget.direction == ZephyrRadioDirection.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: radioItems,
          )
        : Wrap(
            spacing: 16.0,
            runSpacing: 8.0,
            children: radioItems,
          );
  }
}

class _ZephyrRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final bool disabled;
  final ValueChanged<T>? onChanged;
  final ZephyrRadioGroupTheme theme;

  const _ZephyrRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.disabled,
    required this.onChanged,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: disabled ? null : () => onChanged?.call(value),
        borderRadius: theme.borderRadius,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: disabled
                      ? theme.disabledBorderColor
                      : isSelected
                          ? theme.activeColor
                          : theme.borderColor,
                  width: theme.borderWidth,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: disabled
                              ? theme.disabledBorderColor
                              : theme.activeColor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: disabled ? theme.disabledTextStyle : theme.textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
