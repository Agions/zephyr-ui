# ZephyrPDFViewer

PDF查看器组件，支持PDF文件的查看和交互。

## 基本用法

```dart
ZephyrPDFViewer(
  path: 'path/to/document.pdf',
  onPageChanged: (page) {
    print('当前页面: $page');
  },
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| path | String | required | PDF文件路径 |
| initialPage | int | 1 | 初始页面 |
| onPageChanged | Function(int)? | null | 页面变化回调 |
| enableZoom | bool | true | 是否支持缩放 |
| enableSwipe | bool | true | 是否支持滑动 |
| showPageIndicator | bool | true | 是否显示页面指示器 |
| backgroundColor | Color? | null | 背景颜色 |