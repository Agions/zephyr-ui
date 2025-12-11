---
title: Carousel 轮播图
description: VelocityUI Carousel 组件，用于轮播展示一组图片或内容
---

# Carousel 轮播图

用于轮播展示一组图片或内容。

## 基本用法

```dart
VelocityCarousel(
  items: [
    Image.network('...'),
    Image.network('...'),
    Image.network('...'),
  ],
)
```

## 自定义高度

```dart
VelocityCarousel(
  height: 150,
  items: [/*...*/],
)
```

## 自动播放配置

```dart
VelocityCarousel(
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 5), // 5秒切换一次
  items: [/*...*/],
)
```

## 隐藏指示器

```dart
VelocityCarousel(
  showIndicator: false,
  items: [/*...*/],
)
```

## API

### VelocityCarousel

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| items | ZephyrList<Widget> | - | 轮播项列表 (必填) |
| height | double | 200 | 高度 |
| autoPlay | bool | true | 是否自动播放 |
| autoPlayInterval | Duration | 3s | 自动播放间隔 |
| showIndicator | bool | true | 是否显示指示器 |
| onPageChanged | ValueChanged<int>? | - | 页面切换回调 |
| style | VelocityCarouselStyle? | - | 自定义样式 |
