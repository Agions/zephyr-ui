# 数据展示组件

ZephyrUI 数据展示组件提供了一套丰富的数据展示解决方案，用于展示各种类型的数据和信息。

## 组件列表

- [ZephyrTable](table.md) - 数据表格
- [ZephyrList](list.md) - 列表组件
- [ZephyrCalendar](calendar.md) - 日历组件
- [ZephyrStatistic](statistic.md) - 统计数据展示
- [ZephyrTimeline](timeline.md) - 时间线
- [ZephyrCardGrid](card_grid.md) - 卡片网格
- [ZephyrDataGrid](data_grid.md) - 数据网格
- [ZephyrProgressIndicators](progress_indicators.md) - 进度指示器
- [ZephyrStatusIndicators](status_indicators.md) - 状态指示器
- [ZephyrAvatarGroups](avatar_groups.md) - 头像组
- [ZephyrBadgeDisplays](badge_displays.md) - 徽章展示
- [ZephyrTagClouds](tag_clouds.md) - 标签云

## 使用示例

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class DataDisplayDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZephyrTable(
          columns: ['姓名', '年龄', '邮箱'],
          rows: [
            ['张三', '25', 'zhangsan@example.com'],
            ['李四', '30', 'lisi@example.com'],
          ],
        ),
        ZephyrStatistic(
          title: '总用户数',
          value: '1,234',
          icon: Icons.people,
        ),
      ],
    );
  }
}
```