# Display Components Demo

本示例展示了 ZephyrUI 展示组件的使用方法。

## 组件列表

### 1. Empty 空状态组件
- `ZephyrEmpty` - 基础空状态组件
- `ZephyrEmptySimple` - 简单空状态组件
- `ZephyrEmptyImage` - 带图片的空状态组件

### 2. Result 结果组件
- `ZephyrResult` - 基础结果组件
- `ZephyrResultCard` - 卡片式结果组件
- `ZephyrResultPage` - 页面级结果组件

### 3. Skeleton 骨架屏组件
- `ZephyrSkeleton` - 基础骨架屏组件
- `ZephyrSkeletonText` - 文本骨架屏组件
- `ZephyrSkeletonAvatar` - 头像骨架屏组件
- `ZephyrSkeletonCard` - 卡片骨架屏组件
- `ZephyrSkeletonList` - 列表骨架屏组件

### 4. Description 描述列表组件
- `ZephyrDescription` - 表格式描述列表
- `ZephyrDescriptionList` - 列表式描述列表

### 5. Tooltip 工具提示组件
- `ZephyrTooltip` - 基础工具提示组件
- `ZephyrRichTooltip` - 富文本工具提示组件
- `ZephyrTooltipGroup` - 工具提示组

### 6. Popover 气泡卡片组件
- `ZephyrPopover` - 基础气泡卡片组件
- `ZephyrPopoverContent` - 气泡卡片内容组件
- `ZephyrPopoverCard` - 卡片式气泡组件
- `ZephyrPopoverList` - 列表式气泡组件

## 使用方法

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

// 空状态组件
ZephyrEmpty(
  title: '暂无数据',
  description: '当前没有可显示的数据',
)

// 结果组件
ZephyrResult(
  status: ZephyrResultStatus.success,
  title: '操作成功',
  description: '您的操作已成功完成',
)

// 骨架屏组件
ZephyrSkeletonText(
  lines: 3,
)

// 描述列表组件
ZephyrDescriptionList(
  items: [
    ZephyrDescriptionItem(
      label: '用户名',
      children: [Text('张三')],
    ),
  ],
)

// 工具提示组件
ZephyrTooltip(
  message: '这是一个提示',
  child: Icon(Icons.info),
)

// 气泡卡片组件
ZephyrPopoverCard(
  child: Text('卡片内容'),
)
```

## 主题配置

所有组件都支持自定义主题，可以通过 `theme` 参数传入自定义主题：

```dart
ZephyrEmpty(
  theme: ZephyrEmptyTheme(
    titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    descriptionStyle: TextStyle(fontSize: 14),
  ),
  title: '自定义主题',
  description: '这是自定义主题的空状态',
)
```