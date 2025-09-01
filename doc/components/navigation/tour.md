# ZephyrTour

引导游览组件，用于新功能介绍和用户引导。

## 基本用法

```dart
ZephyrTour(
  steps: [
    TourStep(
      target: GlobalKey(),
      title: '欢迎使用',
      description: '这是一个新功能介绍',
      position: TourPosition.bottom,
    ),
    TourStep(
      target: GlobalKey(),
      title: '第二步',
      description: '这是第二个介绍步骤',
      position: TourPosition.right,
    ),
  ],
  onComplete: () {
    print('引导完成');
  },
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| steps | List<TourStep> | required | 引导步骤列表 |
| onComplete | Function() | required | 完成回调 |
| onSkip | Function()? | null | 跳过回调 |
| autoStart | bool | true | 是否自动开始 |
| showSkip | bool | true | 是否显示跳过按钮 |
| showProgress | bool | true | 是否显示进度 |
| overlayColor | Color | Colors.black54 | 遮罩颜色 |
| radius | double | 8.0 | 目标区域圆角 |