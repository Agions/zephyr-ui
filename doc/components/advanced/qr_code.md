# ZephyrQRCode

二维码生成组件，支持文本、URL等多种数据类型。

## 基本用法

```dart
ZephyrQRCode(
  data: 'https://example.com',
  size: 200,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| data | String | required | 二维码数据 |
| size | double | 200 | 二维码尺寸 |
| backgroundColor | Color | Colors.white | 背景颜色 |
| foregroundColor | Color | Colors.black | 前景颜色 |
| errorCorrectionLevel | ZephyrQRErrorCorrectionLevel | medium | 错误纠正级别 |
| padding | double | 10 | 内边距 |
| embeddedImage | ImageProvider? | null | 嵌入的图片 |
| onGenerated | Function(Uint8List)? | null | 生成完成回调 |