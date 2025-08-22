# 基础组件

ZephyrUI 基础组件提供了一套核心的 UI 组件，用于构建现代化的用户界面。

## 组件列表

- [ZephyrButton](button.md) - 多种样式按钮
- [ZephyrAvatar](avatar.md) - 头像组件
- [ZephyrBadge](badge.md) - 徽章和状态指示器
- [ZephyrCard](card.md) - 卡片组件
- [ZephyrChip](chip.md) - 标签选择器
- [ZephyrIcon](icon.md) - 图标组件
- [ZephyrText](text.md) - 文本组件
- [ZephyrDivider](divider.md) - 分割线组件

## 使用示例

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class BasicComponentsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZephyrButton.primary(
          text: '主要按钮',
          onPressed: () {},
        ),
        ZephyrCard(
          title: '卡片标题',
          subtitle: '卡片副标题',
          content: Text('卡片内容'),
        ),
      ],
    );
  }
}
```