# ZephyrAvatarGroups

头像组组件，用于显示多个用户的头像集合。

## 基本用法

```dart
ZephyrAvatarGroups(
  avatars: [
    ZephyrAvatar(
      imageUrl: 'https://example.com/avatar1.jpg',
      name: '张三',
    ),
    ZephyrAvatar(
      imageUrl: 'https://example.com/avatar2.jpg',
      name: '李四',
    ),
    ZephyrAvatar(
      imageUrl: 'https://example.com/avatar3.jpg',
      name: '王五',
    ),
  ],
  maxVisible: 3,
  size: ZephyrAvatarSize.medium,
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| avatars | List<ZephyrAvatar> | required | 头像列表 |
| maxVisible | int | 3 | 最大可见数量 |
| size | ZephyrAvatarSize | medium | 头像大小 |
| spacing | double | 8.0 | 头像间距 |
| showCount | bool | true | 是否显示计数 |
| countStyle | TextStyle? | null | 计数文本样式 |