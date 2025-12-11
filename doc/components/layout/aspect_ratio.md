---
title: AspectRatio 宽高比
description: VelocityUI AspectRatio 组件，控制组件宽高比
---

# AspectRatio 宽高比

控制组件的宽高比例，提供常用预设。

## 基本用法

```dart
VelocityAspectRatio(
  aspectRatio: 16 / 9,
  child: Image.network(...),
)
```

## 常用预设

```dart
// 16:9 视频
VelocityAspectRatio.video(child: ...)

// 4:3 照片
VelocityAspectRatio.photo(child: ...)

// 1:1 正方形
VelocityAspectRatio.square(child: ...)

// 3:4 竖版照片
VelocityAspectRatio.portrait(child: ...)
```

## API

### VelocityAspectRatio

| 构造函数 | 比例 | 说明 |
|----------|------|------|
| VelocityAspectRatio | 自定义 | 默认构造 |
| VelocityAspectRatio.video | 16/9 | 视频常用 |
| VelocityAspectRatio.photo | 4/3 | 照片常用 |
| VelocityAspectRatio.square | 1/1 | 正方形 |
| VelocityAspectRatio.portrait | 3/4 | 竖屏照片 |
