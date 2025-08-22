# ZephyrBadgeDisplays

徽章展示组件，用于显示状态徽章和标签。

## 基本用法

```dart
ZephyrBadgeDisplays(
  badges: [
    ZephyrBadge(
      text: '新功能',
      type: ZephyrBadgeType.success,
    ),
    ZephyrBadge(
      text: '热门',
      type: ZephyrBadgeType.warning,
    ),
    ZephyrBadge(
      text: '限时',
      type: ZephyrBadgeType.error,
    ),
  ],
  direction: Axis.horizontal,
  spacing: 8.0,
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| badges | List<ZephyrBadge> | required | 徽章列表 |
| direction | Axis | horizontal | 排列方向 |
| spacing | double | 8.0 | 徽章间距 |
| wrap | bool | true | 是否换行 |
| alignment | WrapAlignment | start | 对齐方式 |