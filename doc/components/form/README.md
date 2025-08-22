# 表单组件

ZephyrUI 表单组件提供了一套完整的表单解决方案，包括输入验证、布局和提交处理。

## 组件列表

- [ZephyrInput](input.md) - 文本输入框，支持验证
- [ZephyrSelect](select.md) - 下拉选择器
- [ZephyrDatePicker](date_picker.md) - 日期选择器
- [ZephyrCheckbox](checkbox.md) - 复选框
- [ZephyrRadio](radio.md) - 单选按钮
- [ZephyrSwitch](switch.md) - 开关切换
- [ZephyrSlider](slider.md) - 滑块组件
- [ZephyrRating](rating.md) - 评分组件
- [ZephyrTimePicker](time_picker.md) - 时间选择器
- [ZephyrTextArea](text_area.md) - 多行文本输入
- [ZephyrFormBuilder](form_builder.md) - 表单构建器

## 使用示例

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class FormDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrFormBuilder(
      fields: [
        ZephyrInputField(
          label: '用户名',
          placeholder: '请输入用户名',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '请输入用户名';
            }
            return null;
          },
        ),
        ZephyrSelectField(
          label: '选择选项',
          options: ['选项1', '选项2', '选项3'],
        ),
      ],
      onSubmit: (values) {
        print('表单提交: $values');
      },
    );
  }
}
```