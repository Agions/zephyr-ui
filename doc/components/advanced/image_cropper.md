# ZephyrImageCropper

图片裁剪组件，支持自由裁剪和固定比例裁剪。

## 基本用法

```dart
ZephyrImageCropper(
  image: File('path/to/image.jpg'),
  onCropped: (croppedImage) {
    print('裁剪后的图片: $croppedImage');
  },
  aspectRatio: 16 / 9,
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| image | File | required | 原始图片文件 |
| onCropped | Function(File) | required | 裁剪完成回调 |
| aspectRatio | double? | null | 裁剪比例 |
| cropStyle | ZephyrCropStyle | square | 裁剪样式 |
| maxWidth | double? | null | 最大宽度 |
| maxHeight | double? | null | 最大高度 |
| quality | int | 90 | 输出质量 |