# 布局组件

ZephyrUI 布局组件提供了一套强大的布局解决方案，用于构建灵活和响应式的界面布局。

## 组件列表

- [ZephyrGrid](grid.md) - 网格布局
- [ZephyrContainer](container.md) - 容器组件
- [ZephyrAccordion](accordion.md) - 手风琴折叠面板

## 使用示例

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrGrid(
      columns: 12,
      spacing: 16,
      children: [
        ZephyrGridItem(
          span: 6,
          child: ZephyrCard(
            title: '左侧内容',
            content: Text('这是左侧的内容'),
          ),
        ),
        ZephyrGridItem(
          span: 6,
          child: ZephyrCard(
            title: '右侧内容',
            content: Text('这是右侧的内容'),
          ),
        ),
      ],
    );
  }
}
```